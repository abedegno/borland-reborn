{$P512}
program EmsTest;

type
  Str4 = string[4];
  Str80 = string[80];

  IntPtr = ^integer;
  PageArr = array[1..$2000] of integer;
  Name8 = array[1..8] of char;
  HandleRec = record
    Handle, Pages: integer;
  end;
  PagePtr = ^PageArr;
  VecPtr = ^IntPtr;
  RegType = record
    case integer of
      0: (AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags: integer);
      1: (AL, AH, BL, BH, CL, CH, DL, DH: byte);
  end;

const
  Ext: string[3] = 'COM';
var
  Page: array[0..3] of PagePtr;
  LogPage: array[0..3] of integer;
  WinSeg: integer;
  NumPages: integer;
  FreeBefore: integer;
  Handle: integer;
  HandleMap: array[1..256] of HandleRec;
  Regs: RegType;
  I: integer;
  J: integer;
  K: integer;
  Ch: char;
  F: file of PageArr;
  NamePtr: ^Name8;

function Avail: integer;
begin
  Avail := MemAvail;
end;

function BigAvail: integer;
begin
  BigAvail := MaxAvail;
end;

function MaxBytes: real;
begin
  MaxBytes := 32.0 * (BigAvail shr 1);
end;

procedure P4;
begin
end;

function Hex(Value, Bytes: integer): Str4;
const
  Digits: array[0..15] of char = '0123456789ABCDEF';
var
  I: integer;
  S: Str4;
begin
  S[0] := Chr(Bytes + Bytes);
  for I := Bytes + Bytes downto 1 do
  begin
    S[I] := Digits[Value and $F];
    Value := Value shr 4;
  end;
  Hex := S;
end;

function Min(A, B: integer): integer;
begin
  if A < B then
    Min := A
  else
    Min := B;
end;

const
  Int67Words: array[0..1] of integer = ($19C, 0);
var
  Int67Vec: VecPtr absolute Int67Words;

function EmsCall(Func: byte; var Regs: RegType): byte;
begin
  Regs.AH := Func;
  Regs.DX := Handle;
  Intr($67, Regs);
  EmsCall := Regs.AH;
end;

function StatusOk(Status: byte): boolean;
begin
  if Status = 0 then
    StatusOk := true
  else
  begin
    StatusOk := false;
    Writeln;
    case Status of
      $80: Writeln('Non-recoverable error in expanded memory manager software.');
      $81: Writeln('Non-recoverable error in expanded memory manager hardware.');
      $82: Writeln('Recoverable error: Expanded memory manager is busy.');
      $83: Writeln('Non-recoverable error: Process ID not existing.');
      $84: Writeln('Non-recoverable error: Undefined function code.');
      $85: Writeln('Recoverable error: No process IDs currently available.');
      $86: Writeln('Non-recoverable error: SAVE/RESTORE mapping context error.');
      $87, $88: Writeln('Recoverable error: Not enough free pages for allocation request.');
      $89: Writeln('Recoverable error: Zero pages cannot be allocated.');
      $8A: Writeln('Recoverable error: Invalid logical page number.');
      $8B: Writeln('Recoverable error: Invalid physical page number.');
      $8C: Writeln('Recoverable error: Mapping register context stack full.');
      $8D: Writeln('Recoverable error: Mapping register context stack recursion.');
      $8E: Writeln('Recoverable error: Process ID not on context stack.');
      $8F: Writeln('Non-recoverable error: No explanation.');
    else
      Writeln('Undefined error code: ', Hex(Status, 1));
    end;
  end;
end;

procedure Quit;
begin
  if Handle <> -1 then
  begin
    if StatusOk(EmsCall($48, Regs)) then ;
    if StatusOk(EmsCall($45, Regs)) then ;
  end;
  Halt;
end;

procedure Fatal(Msg: Str80);
begin
  Writeln;
  Writeln('   ERROR: ', Msg, ' - Program halted.');
  Quit;
end;

procedure Report(Ok: boolean; Msg: Str80);
begin
  if Ok then
    Writeln('OK.    ')
  else
    Fatal(Msg);
end;

function IntStr(Value, Width: integer): Str80;
var
  S: Str80;
begin
  Str(Value:Width, S);
  IntStr := S;
end;

function AskContinue: boolean;
begin
  Write('Press Esc to abort or any other key to continue: ');
  Read(Kbd, Ch);
  Writeln(Chr(13), '':79);
  Writeln;
  Writeln;
  AskContinue := Ch <> #27;
end;

function FrameSeg: integer;
begin
  if StatusOk(EmsCall($41, Regs)) then
    FrameSeg := Regs.BX
  else
    Quit;
end;

function FreePageCount: integer;
begin
  if StatusOk(EmsCall($42, Regs)) then
    FreePageCount := Regs.BX
  else
    Quit;
end;

procedure MapPage(Physical, Logical: integer);
begin
  Regs.AL := Physical;
  Regs.BX := Logical;
  if not StatusOk(EmsCall($44, Regs)) then
    Quit;
end;

procedure FillPage(Physical, Logical: integer);
var
  I: integer;
begin
  MapPage(Physical, Logical);
  for I := 1 to $2000 do
    Page[Physical]^[I] := I + Logical;
end;

function CheckPage(Physical, Logical: integer): boolean;
var
  I: integer;
  P: ^integer;
  PW: array[0..1] of integer absolute P;
begin
  CheckPage := true;
  P := Ptr(Seg(Page[Physical]^), Ofs(Page[Physical]^));
  for I := 1 to $2000 do
  begin
    if P^ <> I + Logical then
    begin
      CheckPage := false;
      Writeln;
      Writeln('Logical Page #', Logical:4, ' corrupted, offset ', Hex(I, 2),
        '. Value found/expected: ', Hex(Page[Physical]^[I], 2), '/', Hex(I + Logical, 2));
      Exit;
    end;
    PW[0] := Succ(Succ(PW[0]));
  end;
end;

function MapAndCheck(Physical, Logical: integer): boolean;
var
  I: integer;
begin
  MapPage(Physical, Logical);
  MapAndCheck := CheckPage(Physical, Logical);
end;

procedure MapWindow;
var
  Logical: integer;
  Physical: byte;
begin
  Logical := Pred(NumPages);
  for Physical := 3 downto 0 do
  begin
    MapPage(Physical, Logical);
    Logical := Pred(Logical);
  end;
end;

function Allocate(Pages: integer): integer;
begin
  Regs.BX := Pages;
  if StatusOk(EmsCall($43, Regs)) then
    Allocate := Pages
  else
    Quit;
  Handle := Regs.DX;
end;

procedure Deallocate;
begin
  if not StatusOk(EmsCall($45, Regs)) then
    Quit;
  Handle := -1;
end;

procedure SaveMap;
begin
  if not StatusOk(EmsCall($47, Regs)) then
    Quit;
  MapWindow;
end;

procedure RestoreMap;
begin
  if not StatusOk(EmsCall($48, Regs)) then
    Quit;
end;

procedure PartOne;

  function Version: byte;
  begin
    if StatusOk(EmsCall($46, Regs)) then
      Version := Regs.AL
    else
      Quit;
  end;

  function TotalPages: integer;
  begin
    if StatusOk(EmsCall($42, Regs)) then
      TotalPages := Regs.DX
    else
      Quit;
  end;

  function EmsInstalled: boolean;
  begin
    EmsInstalled := true;
    if Seg(Int67Vec^^) = 0 then
    begin
      EmsInstalled := false;
      Writeln('Expanded Memory Manager Interrupt (INT 67H) not installed.');
    end
    else if EmsCall($40, Regs) = 0 then
    begin
      NamePtr := Ptr(Seg(Int67Vec^^), $000A);
      if NamePtr^ <> 'EMMXXXX0' then
      begin
        EmsInstalled := false;
        Writeln('Invalid Expanded Memory Manager Device Name ("', NamePtr^, '").');
      end;
    end
    else
    begin
      EmsInstalled := false;
      if Regs.AH <> $40 then
      begin
        if StatusOk(Regs.AH) then ;
      end
      else
        Writeln('Expanded Memory Manager Software not found.');
    end;
  end;

  procedure ShowHandles;

    function HandlePages(var Map): integer;
    begin
      Regs.ES := Seg(Map);
      Regs.DI := Ofs(Map);
      Regs.BX := 0;
      if StatusOk(EmsCall($4D, Regs)) then
        HandlePages := Regs.BX
      else
        Quit;
    end;

  begin
    Writeln;
    Writeln('Process ID   Pages allocated');
    Writeln('----------------------------');
    for I := 1 to HandlePages(HandleMap) do
      Writeln(Hex(HandleMap[I].Handle, 2):7, HandleMap[I].Pages:11, ' (', 16 * HandleMap[I].Pages:4, 'k)');
    Writeln('   Free', FreePageCount:11, ' (', 16 * FreePageCount:4, 'k)');
    Writeln('----------------------------');
  end;

begin
  Writeln('  PART ONE - EMS DETECTION');
  Writeln('  ------------------------');
  Writeln;
  if EmsInstalled then
    Writeln('Expanded Memory Manager version ', Version, '.')
  else
  begin
    Writeln('Expanded Memory not found or unusable - Program halted.');
    Quit;
  end;
  Writeln;
  Writeln('INT 67 Handler Address: ', Hex(Seg(Int67Vec^^), 2), ':', Hex(Ofs(Int67Vec^^), 2));
  Writeln('Window Segment Address: ', Hex(FrameSeg, 2));
  Writeln('Total no. of Pages    : ', TotalPages:4, ' (', 16 * TotalPages:4, 'k)');
  ShowHandles;
end;

procedure PartTwo;
begin
  Writeln('  PART TWO - BASIC EMS FUNCTIONS');
  Writeln('  ------------------------------');
  Writeln;
  if FreePageCount < 4 then
    Fatal('< 4 pages of Expanded Memory free');
  FreeBefore := FreePageCount;
  WinSeg := FrameSeg;
  Page[0] := Ptr(WinSeg, 0);
  Page[1] := Ptr(WinSeg + 1 * ($2000 div 8), 0);
  Page[2] := Ptr(WinSeg + 2 * ($2000 div 8), 0);
  Page[3] := Ptr(WinSeg + 3 * ($2000 div 8), 0);
  NumPages := Min($80, FreeBefore);
  Write('Allocating ' + IntStr(NumPages, 0) + ' pages EMS memory: ':38);
  NumPages := Allocate(NumPages);
  Report(NumPages = FreeBefore - FreePageCount, 'Memory allocation failure');
  Writeln('EMS handle (Process ID): ':38, Hex(Handle, 2));
  Write('Saving page map and map window: ':38);
  SaveMap;
  Report(true, '');
  Write('Initializing ' + IntStr(NumPages, 0) + ' pages: ':38);
  for J := 0 to Pred(NumPages) do
  begin
    Write(J:3);
    FillPage(Random(4), J);
    Write(#8#8#8);
  end;
  Writeln('OK.');
  Write('Checking ' + IntStr(NumPages, 0) + ' pages: ':38);
  for J := 0 to Pred(NumPages) do
  begin
    Write(J:3);
    if not MapAndCheck(Random(4), J) then
      Fatal('Page corrupted');
    Write(#8#8#8);
  end;
  Writeln('OK.');
  Write('Restoring page map: ':38);
  RestoreMap;
  Report(true, '');
  Write('De-allocating ' + IntStr(NumPages, 0) + ' pages EMS memory: ':38);
  Deallocate;
  Report(FreePageCount = FreeBefore, 'Memory de-allocation failure');
end;

procedure PartThree;
begin
  Writeln('  PART THREE - EMS I/O FUNCTIONS');
  Writeln('  ------------------------------');
  Writeln;
  Write('Allocating ' + IntStr(NumPages, 0) + ' pages EMS memory: ':38);
  NumPages := Allocate(NumPages);
  Report(NumPages = FreeBefore - FreePageCount, 'Memory allocation failure');
  Writeln('EMS handle (Process ID): ':38, Hex(Handle, 2));
  Write('Saving page map and map window: ':38);
  SaveMap;
  Report(true, '');
  Write('Initializing ' + IntStr(NumPages, 0) + ' pages: ':38);
  for J := 0 to Pred(NumPages) do
  begin
    Write(J:3);
    FillPage(Random(4), J);
    Write(#8#8#8);
  end;
  Writeln('OK.');
  Write('Creating temp file EMSTEST.$$$: ':38);
  Assign(F, 'EMSTEST.$$$');
  Rewrite(F);
  Report(true, '');
  Write(IntStr(250, 0) + ' random EMS I/O with disk access: ':38);
  for K := 0 to 3 do
  begin
    LogPage[K] := Random(NumPages);
    MapPage(K, LogPage[K]);
    Seek(F, K);
    Write(F, Page[K]^);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [0]');
  end;
  for I := 1 to 250 do
  begin
    Write(I:4, '/1');
    K := Random(3);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [1]');
    Write(#8'2');
    LogPage[K] := Random(NumPages);
    MapPage(K, LogPage[K]);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [2]');
    Write(#8'3');
    Seek(F, K);
    Write(F, Page[K]^);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [3]');
    Write(#8'4');
    K := Random(3);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [4]');
    Write(#8'5');
    Seek(F, K);
    Read(F, Page[K]^);
    if not CheckPage(K, LogPage[K]) then
      Fatal('Page corrupted [5]');
    Write(#8#8#8#8#8#8);
  end;
  Report(true, '');
  Write('Erasing temp file EMSTEST.$$$: ':38);
  Close(F);
  Erase(F);
  Report(true, '');
  Write('Restoring page map: ':38);
  RestoreMap;
  Report(true, '');
  Write('De-allocating ' + IntStr(NumPages, 0) + ' pages EMS memory: ':38);
  Deallocate;
  Report(FreePageCount = FreeBefore, 'Memory de-allocation failure');
end;

begin
  Writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Writeln('³ Borland C++ EMS Test Program Version 2.0      ³');
  Writeln('³ Copyright (C) 1991 Borland International Inc. ³');
  Writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  Writeln;
  Handle := -1;
  PartOne;
  if AskContinue then
  begin
    PartTwo;
    if AskContinue then
      PartThree;
  end;
end.
