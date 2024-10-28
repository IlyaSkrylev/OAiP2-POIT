Program Project2;

// Determining the type of console program.
{$APPTYPE CONSOLE}

// Setting the name of the module.
Uses
  System.SysUtils;

{
 Function determines the serial number of the line.
}
// N - the serial number of the line.
Function NumberString(Var N: integer): String;
Begin
  Case N of
    1..9: Result := '   ' + IntToStr(N);
    10..99: Result := '  ' + IntToStr(N);
    100..999: Result := ' ' + IntToStr(N);
    1000..9999: Result := IntToStr(N);
  End;
End;

{
 Procedure is to enumerate over all the lines of a file.
}
// OldF, NewF - files from disk.
Procedure EnterNumString(Var OldF, NewF: TextFile);
Var
  N: Integer;
  S: String;
  // N - the serial number of the line;
  // S - string of file.
Begin
  Reset(OldF);
  Rewrite(NewF);
  N := 1;

  // Loop until end file is reached.
  While not Eof(OldF) do
  begin
    Readln(OldF, S);
    Write(NewF,NumberString(N), ' ');
    Writeln(NewF,S);
    Inc(N);
  end;
  CloseFile(NewF);
  CloseFile(OldF);
End;

Var
  F1, F2: TextFile;
  // F1, F2 - start and end files.

begin
  // Associate the variable with the
  // location of the file on the disk.
  AssignFile(F1, 'G:\Работы\2 семестр\ОАиП\Лаб №10\F1.txt');
  AssignFile(F2, 'G:\Работы\2 семестр\ОАиП\Лаб №10\F2.txt');
  EnterNumString(F1, F2);
end.
