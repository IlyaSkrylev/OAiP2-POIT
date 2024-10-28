Program Matrix;
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
  TMatrix = Array[1..3,1..3] of integer;

// Displaying matrices on the screen.
{
 Given the matrix Concl. The procedure displays the values ​​of the elements of the given matrix.
}
Procedure OutPut(Var Concl: TMatrix);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: Integer;
Begin
  For I := 1 to 3 do
  begin
    For J := 1 to 3 do
      write(Concl[I,J]: 5);
    writeln;
  end;
  writeln;
End;

// Finding the product of matrices.
{
 Given matrices A, B. The procedure finds the matrix Result by multiplying the matrices A and B.
}
Procedure ProizvMatrix(Var A, B, Result: TMatrix);

// I, J, K - auxiliary variables for the iteration loop;
// Sum - finds the elements of matrix Result.
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

      Result[I,J] := Sum;
    end;
  end;
  Output(Result);
End;

// Finding the sum of matrices.
{
 Matrices A, B are given. The procedure finds the matrix Result by summing the elements of the matrix A and B.
}
Procedure SumMatrix(Var A, B, Result: TMatrix; Flag: Boolean);

// I, J - auxiliary variables for the iteration loop.
Var
  G:integer;
  I,j:integer;
  K: integer absolute g;
  Mat:TMatrix absolute result;
Begin
  if Flag then
    G := -1
  else
    K := 1;
  For I := 1 to 3 do
    For J := 1 to 3 do
      Mat[I,J] := A[I,J] + k*B[I,J];
  Output(Result);
End;

// Finding the product of the matrix A and the number N.
{
 Given a matrix A and a number N. The procedure finds the matrix Result by multiplying each element of the matrix A by the number N.
}
Procedure NumberProizv(Const N: integer;
                       Var A: TMatrix;
                       Var Result);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: Integer;
Begin
  For I := 1 to 3 do
    For J := 1 to 3 do
      TMatrix(Result)[I,J] := A[I,J]*N;
  OutPut(TMatrix(Result));
End;

// Assign certain data types to variables.
Var
  Matrix1, Matrix2, Matrix3, Matrix4, C: TMatrix;
  MatrixA: TMatrix = ((1,4,2),(2,1,-2),(0,1,-1));
  MatrixB: TMatrix = ((4,6,-2),(4,10,1),(2,4,-5));
  {
   Matrix1, Matrix2, Matrix3, Matrix4, C - auxiliary matrices;
   MatrixA, MatrixB - input matrices.
  }

Begin

  // Derivation of input matrices.
  Writeln('MatrixA = ');
  OutPut(MatrixA);
  Writeln('MatrixB = ');
  OutPut(MatrixB);

  // Finding an expression A^2
  writeln('A^2 = ');
  ProizvMatrix(MatrixA, MatrixA, Matrix1);

  // Finding an expression A^2+B.
  writeln('A^2+B =');
  SumMatrix(Matrix1, MatrixB, Matrix2, False);

  // Finding an expression (A^2+B)*B.
  writeln('(A^2+B)*B =');
  ProizvMatrix(Matrix2, MatrixB, Matrix3);

  // Finding an expression 2*A.
  writeln('2*A =');
  NumberProizv(2, MatrixA, Matrix4);

  // Finding the final expression.
  writeln('2*A-(A^2+B)*B =');
  SumMatrix(Matrix4, Matrix3, C, True);
  readln;
End.
