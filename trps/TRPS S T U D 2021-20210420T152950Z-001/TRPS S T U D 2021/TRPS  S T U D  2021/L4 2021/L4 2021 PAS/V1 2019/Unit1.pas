unit Unit1;
interface
Type pt=^rec;
     rec=record
             n:real;
           ptr:pt;
         end;
Procedure OutSp(fs:pointer);
implementation
  //����� ������
Procedure OutSp(fs:pointer);
var s:pt;
begin
  s:=fs; { ������������� �� ������ ������ }
     while s<>nil do
         begin
         writeln(s^.n:10:0);
           s:=s^.ptr;
         end;
end;

end.

