Program Project2;
{
 There are 10 points on the plane, which
 are set by their coordinates. You need to
 find a point on the X, the greatest
 distance to all will be minimal.
}

// Determining the type of console program.
{$APPTYPE CONSOLE}

// Setting the name of the module.
uses
  System.SysUtils;

// Description of additional types.
Type
  TPoints = Array of array[1..2] of real;

Procedure EnterNumber(Var N: integer);
Var
  IsCorrect: boolean;
begin

  // Request to enter the values of the main
  // variables and check for correctness.
  Repeat
    Try
      write('Введите количество точек: ');
      readln(N);

      While N < 1 do
      begin
        writeln('Количество точек должно быть больше 0!');
        write('Введите количество точек: ');
        readln(N);
      end;

      // Except for repetition.
      IsCorrect := True;
    Except

      Writeln('Вы ввели некорректные данные!');

      // Transition to repetition.
      IsCorrect := False;
    End;
  Until IsCorrect;
end;

{
 The procedure is designed to enter the
 accuracy of calculations and determines
 its correctness.
}
// Eps - the value of the accuracy of calculations.
Procedure EnterEps(Var Eps: Real);
Var
  TypeEnter: integer;
  Deg: real;
  IsCorrect: boolean;
  // TypeEnter - precision input selection;
  // Deg - degree 10 for accuracy;
  // IsCorrect - determines the correctness of the input.
begin

  // Request to enter the values of the main
  // variables and check for correctness.
  Repeat
    Try

      // Choosing the type of precision input.
      Repeat
        writeln('Выберите вид ввода точности (1 или 2): 0.001, 10^-1');
        readln(TypeEnter);
      Until (TypeEnter >= 1) and (TypeEnter <= 2);

      // Entering accuracy for the selected type.
      Case TypeEnter of
        1:
          Repeat
            write('Введите точность в формате 0.001: ');
            readln(Eps);
          Until (Eps > 0) and (Eps < 1);
        2:
          begin
            Repeat
              write('Введите степень десяти меньше 0: ');
              readln(Deg);
            Until Deg < 0;
            Eps := exp(Deg*ln(10));
          end;
      end;

      // Except for repetition.
      IsCorrect := True;
    Except
      Writeln('Вы ввели некорректные данные!');

      // Transition to repetition.
      IsCorrect := False;
    End;
  Until IsCorrect;

end;

{
 The procedure is intended for entering
 the coordinates of points by the user.
}
// Points - coordinates of the points.
Procedure EnterPoints(Var Points: TPoints; N: Integer);
Var
  I, J: integer;
  DiffCoords, IsCorrect: boolean;
  // I, J - variables for the for loop;
  // DiffCoords - determines the coincidence
  // of the coordinates of the points.

Begin

  // Request to enter the values of the main
  // variables and check for correctness.
  Repeat
    Try
      SetLength(Points, N);

      While N < 1 do
      begin
        writeln('Количество точек должно быть больше 0!');
        write('Введите количество точек: ');
        readln(N);
      end;
      I := 1;

      // Input of coordinates of points by the user.
      While I <= N do
      begin
        DiffCoords := True;
        writeln('Введите координаты ', I, '-й точки: ');
        write('x = ');
        readln(Points[I,1]);
        write('y = ');
        readln(Points[I,2]);

        // Checking for matching points.
        For J := 1 to I-1 do

          // If there is a match, the user is
          // prompted to enter the point again.
          If Points[I,1] = Points[J,1] then
            If Points[I,2] = Points[J,2] then
            begin
              writeln;
              writeln('Такая точка уже существует (№', J,')!');
              writeln('Координаты точек должны быть разными!');
              writeln;
              DiffCoords := False;
            end;

        // If there are no matches, then continue the cycle.
        If DiffCoords then
          I := I + 1;

        // Except for repetition.
        IsCorrect := True;
      end;
    Except
      writeln('Вы ввели некорректные данные!');

      // Transition to repetition.
      IsCorrect := False;
    End;
  Until IsCorrect;
End;

{
 The procedure is designed to find the boundaries
 of the search and the middle element in the interval.
}
// XMin, XMax - define the interval;
// XMid - the middle of the gap;
// Points - coordinates of the points.
Procedure FindBorders(Var XMin,XMax,XMid: real; Points: TPoints; N: integer);
Var
  I: Integer;
  // I - variable for the for loop.

Begin
  SetLength(Points, N);
  XMax := Points[1,1];
  XMin := Points[1,1];

  // Search for the boundaries of the gap.
  For I := 2 to N do
  begin

    // Search for the lower boundary of the gap.
    If Points[I,1] < XMin then
      XMin := Points[I,1];

    // Search for the upper boundary of the gap.
    If Points[I,1] > XMax then
      XMax := Points[I,1];
  end;

  // Calculating the midpoint of the gap.
  XMid := (XMin+XMax)/2;
End;

{
 The function is designed to find the distance
 from a point on the X to the specified
 points and determines the maximum distance
 from them. Returns the maximum distance.
}
// X - the value of the point on the X;
// Points - coordinates of the points.
Function FindMaxDist(Var X: Real; Points: TPoints; N: integer): Real;
var
  I: integer;
  Dist: real;
  // Dist - distance from a point on the X to a given point;
  // I - variable for the for loop.

Begin
  SetLength(Points, N);
  Result := 0;

  // Iterating over all specified points.
  For I := 1 to N do
  begin

    // Search for the distance from points on the X-axis to a given point.
    If Points[I,1] - X <> 0 then
      Dist := sqrt(sqr(Points[I,1]-X) + Sqr(Points[I,2]))  //exp(ln((Points[I,1]-X)*(Points[I,1]-X)+(Points[I,2])*(Points[I,2]))/2)
    else
      Dist := Points[I,2];

    // Determination of the maximum distance.
    If Dist > Result then
      Result := Dist;
  end;
End;



// Присваивайте переменным определенные типы данных.
Var
  Coords: TPoints;
  Min, Mid1, Mid2, XMin: real;
  XStart, XFinish, XMiddle, XStep: real;
  NumPoints: integer;
  {
   Coords - point coordinate values;
   Min - required distance;
   Mid1, Mid2 - the middle of the considered interval;
   XMiddle - the middle of the considered interval;
   XMin - a point on the abscissa axis;
   XStart, XFinish - boundaries of the considered interval;
   XStep - accuracy of calculations.
  }

Begin
  EnterNumber(NumPoints);

  SetLength(Coords, NumPoints);

  // Entering the coordinates of the points.
  EnterPoints(Coords, NumPoints);

  // Entering the accuracy of calculations.
  EnterEps(XStep);

  // Search for the initial boundaries of the gap.
  FindBorders(XStart, XFinish, XMiddle, Coords, NumPoints);

  // Execute until the value reaches the entered precision.
  While abs(XMiddle - XFinish) > xStep do
  begin

    // Finding the midpoints of the gap.
    Mid1 := (XStart + XMiddle)/2;
    Mid2 := (XFinish + XMiddle)/2;

    // Search for the maximum element in two branches.
    // Determining which branch to go to next.
    If FindMaxDist(Mid1, Coords, NumPoints) < FindMaxDist(Mid2, Coords, NumPoints) then
    begin
      XFinish := XMiddle;
      Min := FindMaxDist(Mid1, Coords, NumPoints);
      XMiddle := Mid1;
    end
    else
    begin
      XStart := XMiddle;
      Min := FindMaxDist(Mid2, Coords, NumPoints);
      XMiddle := Mid2;
    end;
  end;

  // Determining the final value of X on the X axis.
  XMin := XMiddle;

  // The output of the results obtained.
  writeln;
  writeln('Минимальное из максимальных расстояний: ', Min:4:2);
  writeln('Точка на оси абсцисс: ', XMin:6:2);
  readln;
end.
