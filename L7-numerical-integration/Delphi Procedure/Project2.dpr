Program Project2;
{
 The program is designed to calculate integrals
 of a given function in two ways: the method of
 right rectangles and the method of trapezoids,
 and two precision: 10^-5 and 10^-6.
}

// Determining the type of console program.
{$APPTYPE CONSOLE}

// Setting the name of the module.
Uses
  System.SysUtils;

// Declaration of constant variables.
Const
  Eps1 = 1E-5;
  Eps2 = 1E-6;
  XStart1 = 0.6;
  XFinish1 = 1.4;
  XStart2 = 0.2;
  XFinish2 = 0.8;

// Description of the types used by the program.
Type
  TResult = Array[1..4,1..2] of Real;
  TIntegral = Procedure(X:Real; Var Res: Real);
  TRes = Procedure(F: TIntegral; Const Dist,Left,Right: Real; Var Res: Real);

{
 The procedure is designed to set the first
 function.
}
// X - coordinate of the point;
// Res - the value of the function.
Procedure F_1(X: Real; Var Res: Real);
Begin
  Res := Sqrt(Sqr(X) + 0.5)/(2*X + Sqrt(sqr(X) + 2.5));
End;

{
 The procedure is designed to set the first
 function.
}
// X - coordinate of the point;
// Res - the value of the function.
Procedure F_2(X: Real; Var Res: Real);
Begin
  Res := cos(sqr(x) + 1)/(2 + sin(2*X + 0.5));
End;

{
 The procedure is designed to determine
 the area of one right rectangle.
}
// F - integrated function;
// Dist - X coordinate step;
// Left, Right - rectangle borders;
// Res - the area of the rectangle.
Procedure RightRectangle(F: TIntegral; Const Dist, Left, Right: Real; Var Res: Real);
Var
  Tmp: Real;
  // Tmp - the temporary value of the function.

Begin
  F(Right, Tmp);
  Res := Tmp*Dist;
End;

{
 The procedure is designed to determine
 the area of one trapezoid.
}
// F - integrated function;
// Dist - X coordinate step;
// Left, Right - rectangle borders;
// Res - the trapezoid area.
Procedure Trapezoid(F: TIntegral; Const Dist, Left, Right: Real; Var Res: Real);
Var
  Tmp1, Tmp2: Real;
  // Tmp - the temporary value of the function.
Begin
  F(Left, Tmp1);
  F(Right, Tmp2);
  Res := ((Tmp1 + Tmp2)/2)*Dist;
End;

{
 The function is designed to calculate the
 integral.
}
// Method - numerical integration method;
// Func - integrated function;
// XStart, XFinish - limits of integration;
// I - auxiliary variable;
// Res - an array of the integral value
// and the number of partitioning sections.
Procedure FindResult(Method: TRes; Func: TIntegral; Const XStart, XFinish: Real; Const I: Byte; Var Res: TResult);
Var
  Delta, A, H, B: Real;
  Flag: Boolean;
  Tmp2, Tmp1: Real;
  N, J: Integer;
  // Delta - the difference between the
  // previous and the present value of the
  // integral;
  // A, B - shape boundaries;
  // H - the distance between the borders
  // of the shape;
  // Tmp, Tmp1, Tmp2 - previous value of the integral;
  // N - number of gaps;
  // J - auxiliary variable.

Begin

  // Initializing variables.
  Flag := True;
  N := 2;
  H := (XFinish - XStart)/N;
  Method(Func, H, XStart, XFinish, Tmp2);
  Delta := abs(Res[I,1]) - abs(Tmp2);

  // Finding an integral with two precision.
  While abs(Delta) > Eps2 do
  begin

    // Initialization of variables with N partitioning parts.
    H := (XFinish - XStart)/N;
    A := XStart;
    B := A + H;
    Res[I,1] := 0;

    // Finding the integral with N broken parts.
    For J := 1 to N do
    begin
      Method(Func, H, A, B, Tmp1);
      Res[I,1] := Res[I,1] + Tmp1;
      A := A + H;
      B := A + H;
    end;
    Delta := abs(Res[I,1]) - abs(Tmp2);

    // Finding the integral at the first precision.
    If (abs(Delta) <= Eps1) and Flag then
    begin
      Res[I-1,1] := Res[I,1];
      Res[I-1,2] := N;
      Flag := False;
    end;
    Tmp2 := Res[I,1];
    Inc(N);
  end;
  Res[I,2] := N-1;
End;

// Assign certain data types to variables.
Var
  RRec, Trap: TResult;
  I : Byte;
  // RRec - array with results when integrating right rectangles;
  // Trap - an array with the results when integrating trapezoids;
  // I - auxiliary variable.

begin

  // Finding the first integral by right rectangles with two points.
  FindResult(RightRectangle, F_1, XStart1, XFinish1, 2, RRec);

  // Finding the second integral by right rectangles with two points.
  FindResult(RightRectangle, F_2, XStart2, XFinish2, 4, RRec);

  // Finding the first integral by trapezoids with two precision.
  FindResult(Trapezoid, F_1, XStart1, XFinish1, 2, Trap);

  // Finding the second integral by trapezoids with two precision.
  FindResult(Trapezoid, F_2, XStart2, XFinish2, 4, Trap);

  // Output of calculation results in the form of a table.
  writeln('F1 = sqrt(sqr(x) + 0.5)/(2*x + sqrt(sqr(x) + 2.5))');
  writeln('F2 = cos(sqr(x) + 1)/(2 + sin(2*x + 0.5))');
  writeln(' _______________________________________________________________________________________ ');
  writeln('|               |                 F1                |                 F2                |');
  writeln('| ����� ������- |___________________________________|___________________________________|');
  writeln('| ���� �������- |   Eps1 =  |  N  |   Eps2 =  |  N  |   Eps1 =  |  N  |   Eps2 =  |  N  |');
  writeln('| �������       |', Eps1:9, ' |     |', Eps2:9, ' |     |', Eps1:9, ' |     |', Eps2:9, ' |     |');
  writeln('|_______________|___________|_____|___________|_____|___________|_____|___________|_____|');
  writeln('|               |           |     |           |     |           |     |           |     |');
  writeln('| ������ �����- |  ', RRec[1,1]:7:5,'  | ', RRec[1,2]:2:0,'  |  ', RRec[2,1]:7:6,' | ', RRec[2,2]:2:0,'  |  ', RRec[3,1]:7:5,'  | ', RRec[3,2]:3:0,' |  ', RRec[4,1]:7:6,' | ', RRec[4,2]:3:0,' | ');
  writeln('| ����������    |           |     |           |     |           |     |           |     |');
  writeln('|_______________|___________|_____|___________|_____|___________|_____|___________|_____|');
  writeln('|               |           |     |           |     |           |     |           |     |');
  writeln('| ��������      |  ', Trap[1,1]:7:5,'  | ', Trap[1,2]:2:0,'  |  ', Trap[2,1]:7:6,' | ', Trap[2,2]:3:0,' |  ', Trap[3,1]:7:5,'  | ', Trap[3,2]:3:0,' |  ', Trap[4,1]:7:6,' | ', Trap[4,2]:3:0,' | ');
  writeln('|_______________|___________|_____|___________|_____|___________|_____|___________|_____|');

  readln;
end.
