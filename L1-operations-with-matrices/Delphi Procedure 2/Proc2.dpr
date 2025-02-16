﻿Program Proc2;
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
  Matr = Array of Integer;
  TMatrix = Array of Matr;

// Displaying matrices on the screen.
{
 Given the matrix Concl. The procedure displays the values ​​of the elements of the given matrix.
}
Procedure OutPut(Var Concl: TMatrix; M1: integer);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: Integer;
Begin
  SetLength(Concl, M1, M1);
  For I := 0 to M1-1 do
  begin
    For J := 0 to M1-1 do
      write(Concl[I,J]: 5);
    writeln;
  end;
  writeln;
End;

// Finding the product of matrices.
{
 Given matrices A, B. The procedure finds the matrix Result by multiplying the matrices A and B.
}
Procedure ProizvMatrix(Var A, B, Result: TMatrix; M1: integer);

// I, J, K - auxiliary variables for the iteration loop;
// Sum - finds the elements of matrix Result.
Var
  I, J, K: integer;
  Sum: Integer;
Begin
  SetLength(Result, M1, M1);
  For I := 0 to M1-1 do
  begin
    For J := 0 to M1-1 do
    begin
      Sum := 0;
      For K := 0 to M1-1 do
        Sum := Sum + A[I,K]*B[K,J];

      Result[I,J] := Sum;
    end;
  end;
  Output(Result, M1);
End;

// Finding the sum of matrices.
{
 Matrices A, B are given. The procedure finds the matrix Result by summing the elements of the matrix A and B.
}
Procedure SumMatrix(Var A, B, Result: TMatrix; Flag: Boolean; M1: integer);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: integer;
Begin
  SetLength(Result, M1, M1);
  For I := 0 to M1-1 do
  begin
    For J := 0 to M1-1 do
      If Flag then
        Result[I,J] := A[I,J] - B[I,J]
      else
        Result[I,J] := A[I,J] + B[I,J];
  end;
  Output(Result, M1);
End;

// Finding the product of the matrix A and the number N.
{
 Given a matrix A and a number N. The procedure finds the matrix Result by multiplying each element of the matrix A by the number N.
}
Procedure NumberProizv(Const N: integer;
                       Var A, Result: TMatrix; M1: integer);

// I, J - auxiliary variables for the iteration loop.
Var
  I, J: Integer;
Begin
  SetLength(Result, M1, M1);
  For I := 0 to M1-1 do
    For J := 0 to M1-1 do
      Result[I,J] := A[I,J]*N;
  OutPut(Result, M1);
End;

// Assign certain data types to variables.
Var
  Matrix1, Matrix2, Matrix3, Matrix4, C: TMatrix;
  MatrixA: TMatrix;
  MatrixB: TMatrix;
  I, M, J: integer;
  Flag: boolean;
  {
   Matrix1, Matrix2, Matrix3, Matrix4, C - auxiliary matrices;
   MatrixA, MatrixB - input matrices;
   I, J - auxiliary variables;
   M - to enter matrix.
  }

Begin

  // Entering matrix A and B.
  Repeat
    Try
      write('Введите количество строк и столбцов у матриц: ');
      readln(M);
      SetLength(MatrixA, M, M);
      SetLength(MatrixB, M, M);
      writeln('Введите элементы матрицы А: ');
      for I := 0 to M-1 do
      begin
        for J := 0 to M-1 do
        begin
          write('Введите [', I+1, ',', J+1, '] элемент: ');
          readln(MatrixA[I,J]);
        end;
      end;

      writeln('Введите элементы матрицы B: ');
      for I := 0 to M-1 do
      begin
        for J := 0 to M-1 do
        begin
          write('Введите [', I+1, ',', J+1, '] элемент: ');
          readln(MatrixB[I,J]);
        end;
      end;
    Except
      writeln('Вы ввели некорректные данные!');
      writeln('Рамерность и элементы матрицы могут быть представлены только целочисленным типом!');
    End;
  Until flag;

  // Finding an expression A^2
  writeln('A^2 = ');
  ProizvMatrix(MatrixA, MatrixA, Matrix1, M);

  // Finding an expression A^2+B.
  writeln('A^2+B =');
  SumMatrix(Matrix1, MatrixB, Matrix2, False, M);

  // Finding an expression (A^2+B)*B.
  writeln('(A^2+B)*B =');
  ProizvMatrix(Matrix2, MatrixB, Matrix3, M);

  // Finding an expression 2*A.
  writeln('2*A =');
  NumberProizv(2, MatrixA, Matrix4, M);

  // Finding the final expression.
  writeln('2*A-(A^2+B)*B =');
  SumMatrix(Matrix4, Matrix3, C, True, M);
  readln;
End.
