{ ���������� ������� �� ������" ������ "}
program V14;
{$APPTYPE CONSOLE}
uses
  SysUtils;

Const nmax=100;
var n,i,j,k,kx,ky,d,g: integer;
F,Fi,Fj:boolean;
a:array [1..nmax,1..nmax] of integer;

begin
write('n = ');readln(n);
{ f - 㪠�뢠�� ��אַ� ����� ��� ����� ,
 fi,fj - 㪠�뢠�� �� ����� ���न��� ����� }

i:=1; j:=1;  F:= true; Fj:=true; Fi:=false; k:=0; d:=round(n/2);

for g:=1 to sqr(n) do  begin
a[i,j]:=random(91)+10;
{ ��������㥬, �㦭� �� ������ ������ }
  if ((i=j) and (j > d )) or ((i=j+1) and (j < d)) or (j=n-i+1 )then
  begin Fj:=not Fj; Fi:= not Fi; inc(k) end;

{ ���塞 ���� ����� �१ ����� 2 ������}
  if (not odd(k)) and (k<>0) then begin F:= not F; k:=0 end;

  if F then if Fj then inc(j) else inc(i)
   else if Fj then dec(j) else dec(i) ;

end;

 ky:=5;
  for i:=1 to n do  begin
    kx:=5;
    for j:=1 to n do write(a[i,j]:kx);
    writeln;
             end;
readln;
end.

