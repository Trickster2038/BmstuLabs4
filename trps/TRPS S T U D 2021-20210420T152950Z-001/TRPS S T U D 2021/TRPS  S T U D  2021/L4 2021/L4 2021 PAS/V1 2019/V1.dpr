program V1;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Unit1 in 'Unit1.pas';

Const N=10;
Var s,p,d:pt;
    f:pointer;
    fl:boolean; {������� ����,��� ������ ��� ���������}
    k:longint;
    x:real;
    Bw:pt;

  {���������� ���������������� ������}
begin
      randomize;
      new(s);  { ������� 1-� ������� ������ }
      s^.n:=random(1000);  s^.ptr:=nil;
      new(p);  { ������� 2-� ������� ������ }
      p^.n:=random(1000); p^.ptr:=nil;
      if p^.n>=s^.n then
      begin  p^.ptr:=s; f:=p;  end
      else  begin s^.ptr:=p; f:=s;  end;
      new(d); {��� �������� ��������� ������}
k:=2;
while k<N  do
        begin
           inc(k);
           new(p); x:=random(1000);
           p^.n:=x; p^.ptr:=nil;
           fl:=false;
 s:=f;  { s ������������� �� ������ ������ }
 d:=s^.ptr;
 repeat
      { ������� � ������ ������ }
 if (p^.n>=s^.n) and (s=f) then
      begin  p^.ptr:=s; f:=p; fl:=true; end;

       { ������� � �������� }
  if (p^.n>=d^.n) and (p^.n<s^.n) and not fl then
  begin s^.ptr:=p; p^.ptr:=d; d:=p; fl:=true  end;

       { ������� � ����� ������ }
  if (p^.n<d^.n) and not fl and (d^.ptr=nil) then
   begin   d^.ptr:=p; d:=p;  end;
  s:=s^.ptr; d:=d^.ptr;
until d=nil;

end;
OutSp(f);

 readln;
end.

