program probe;
var i: integer; b: boolean; c: char; s: string[80]; r: real; regs: record ax,bx,cx,dx,bp,si,di,ds,es,flags: integer; end;
begin
  b := KeyPressed;
  i := MemAvail;
  i := MaxAvail;
  i := IOresult;
  i := WhereX;
  i := WhereY;
  i := Random(10);
  b := Odd(i);
  i := Ord(c);
  c := UpCase(c);
  i := Length(s);
  i := Pos('a', s);
  s := Copy(s, 1, 2);
  Delete(s, 1, 1);
  Insert('x', s, 1);
  Str(i, s);
  Val(s, i, i);
  ClrScr; ClrEol; GotoXY(1,1);
  Intr($67, regs);
  MsDos(regs);
  Read(Kbd, c);
  Write(i); Write(i:4); Write(c); Write(s); Write(b); Writeln;
  Halt;
end.
