program EmsTest;

type
  Str4 = string[4];
  Str80 = string[80];

  IntPtr = ^integer;
  PageArr = array[1..$2000] of integer;
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
  Fill0: array[0..$1FF] of byte;
  Page: array[0..3] of PagePtr;
  FillA: array[0..9] of byte;
  NumPages: integer;
  FillB: array[0..1] of byte;
  Handle: integer;
  Fill1: array[0..$3FF] of byte;
  Regs: RegType;
  Fill2: array[0..5] of byte;
  Ch: char;

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

begin
end.
