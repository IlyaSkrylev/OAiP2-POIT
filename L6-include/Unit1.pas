unit Unit1;

interface
Type
  TMatrix = Array [1..3,1..3] of Integer;
  Function ProizvMatrix(Const A, B: TMatrix; Flag: boolean): TMatrix;
  Function SumMatrix(Const A, B: TMatrix; Flag: boolean): TMatrix;
  Function NumberProizv(Const N: integer;
                      Const A: TMatrix): TMatrix;
implementation


// Finding the product of matrices.
{
 Given matrices A, B. The function finds it's value by multiplying the matrices A and B.
}
Function ProizvMatrix;

// I, J, K - auxiliary variables for the iteration loop;
// Sum - fins the elements of matrix Result.
Var
  I, J, K: integer;
  Sum: Integer;
Begin
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
End;

// Finding the sum of matrices.
{
 Matrices A, B are given. The function finds it's value by summing the elements of the matrix A and B.
}
Function SumMatrix;

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
End;

// Finding the product of the matrix A and the number N.
{
 Given a matrix A and a number N. The function finds it's value by multiplying each element of the matrix A by the number N.
}
Function NumberProizv;

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: integer;
Begin
  writeln('2*A');
  For I := 1 to 3 do
    For J := 1 to 3 do
      NumberProizv[I,J] := A[I,J]*N;
End;
end.
