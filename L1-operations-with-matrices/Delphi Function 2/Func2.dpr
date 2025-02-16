Program Func2;
{
 The program displays the result of the calculation using two matrices with initial data, according to the formula (2*A - (A^2 + B)*B).
}

// Determining the type of console program.
{$APPTYPE CONSOLE}

// Setting the name of the module.
uses
  System.SysUtils;

// Adding types for subroutines.
Type
  TMatrix = Array[1..3,1..3] of Integer;

// Displaying matrices on the screen.
{
 Given the matrix Concl. The procedure displays the values ??of the elements of the given matrix.
}
Procedure OutPut(Const Enter: TMatrix);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: integer;
Begin
  For I := 1 to 3 do
  begin
    For J := 1 to 3 do
      write(Enter[I,J]: 5);
    writeln;
  end;
  writeln;
End;

// Finding the product of matrices.
{
 Given matrices A, B. The function finds it's value by multiplying the matrices A and B.
}
Function ProizvMatrix(Const A, B: TMatrix; Flag: boolean): TMatrix;

// I, J, K - auxiliary variables for the iteration loop;
// Sum - fins the elements of matrix Result.
Var
  I, J, K: integer;
  Sum: Integer;
Begin
  If Flag then
    writeln('(A^2+B)*B =')
  else
    writeln('A^2 =');
  For I := 1 to 3 do
  begin
    For J := 1 to 3 do
    begin
      Sum := 0;
      For K := 1 to 3 do
        Sum := Sum + A[I,K]*B[K,J];

      ProizvMatrix[I,J] := Sum;
    end;
  end;
  Output(Result);
End;

// Finding the sum of matrices.
{
 Matrices A, B are given. The function finds it's value by summing the elements of the matrix A and B.
}
Function SumMatrix(Const A, B: TMatrix; Flag: boolean): TMatrix;

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: integer;
Begin

  For I := 1 to 3 do
  begin
    For J := 1 to 3 do
      If Flag then
        SumMatrix[I,J] := A[I,J] - B[I,J]
      else
        SumMatrix[I,J] := A[I,J] + B[I,J];
  end;
  If not Flag then
  begin
    writeln('A^2+B = ');
    Output(Result);
  end
  else
    writeln('2*A-(A^2+B)*B =');
End;

// Finding the product of the matrix A and the number N.
{
 Given a matrix A and a number N. The function finds it's value by multiplying each element of the matrix A by the number N.
}
Function NumberProizv(Const N: integer;
                      Const A: TMatrix): TMatrix;

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: integer;
Begin
  writeln('2*A');
  For I := 1 to 3 do
    For J := 1 to 3 do
      NumberProizv[I,J] := A[I,J]*N;
  OutPut(Result);
End;

Var
  MatrixA, MatrixB: TMatrix;
  I, J: integer;
  Flag: boolean;

Begin
  // Entering matrix A and B.
  Repeat
    Try
      writeln('������� �������� ������� �: ');
      for I := 1 to 3 do
      begin
        for J := 1 to 3 do
        begin
          write('������� [', I, ',', J, '] �������: ');
          readln(MatrixA[I,J]);
        end;
      end;

      writeln('������� �������� ������� B: ');
      for I := 1 to 3 do
      begin
        for J := 1 to 3 do
        begin
          write('������� [', I, ',', J, '] �������: ');
          readln(MatrixB[I,J]);
        end;
      end;
    Except
      Writeln('�� ����� ������������ ������!');
      writeln('�������� ������� ����� ���� ������������ ������ ����� ������!');
    End;
  Until Flag;

  // Derivation of the final matrix.
  OutPut(SumMatrix(NumberProizv(2, MatrixA), ProizvMatrix(SumMatrix(ProizvMatrix(MatrixA, MatrixA, False), MatrixB, False), MatrixB, True), True));
  readln;
End.
