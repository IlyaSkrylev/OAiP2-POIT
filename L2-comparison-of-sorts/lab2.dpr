Program lab2;
{
 The program is designed to compare two sorts:
 quick sorting and sorting of simple inserts.
}

// Determining the type of console program.
{$APPTYPE CONSOLE}

// Setting the name of the module.
Uses
  System.SysUtils;

// Adding types for subroutines.
Type
  TMethod = (RandomArray, SortArray, InvertedArray);
  TArray = Array of integer;
  TInfoAboutArray = record
    Arr: TArray;
    TypeArrayWrite: String;
    TypeArray: TMethod;
    Count: Integer;
    Quick: record
      TeorQuick: real;
      ExpQuick: integer;
    end;
    InsertionSort: record
      TeorInsertion: real;
      ExpInsertion: integer;
    end;
  end;

{
 The procedure for creating an array in
 three ways: random, sorted, inverted.
}
// N - array size;
// Method - array creation method;
// Arr - the source array.
Procedure GenerateArray(Const N: integer; Const Method: TMethod; Var Arr: TArray);
Var
  I: Integer;
  // I - auxiliary variable.

Begin
  Randomize;
  SetLength(Arr, N);

  // Filling an array with elements.
  For I := 0 to N-1 do
    Case Method of

      // Creating a random array.
      RandomArray:
        Arr[I] := Random(N);

      // Creating a sorted array.
      SortArray:
        Arr[I] := I;

      // Creating an inverted array.
      InvertedArray:
        Arr[I] := N - I;

    end;
End;

{
 A procedure for exchanging two elements of an array.
}
// A - the first element of the array;
// B - the second element of the array.
Procedure Swap(Var A, B: integer);
Var
  Tmp: integer;
  // Tmp - auxiliary variable.

Begin
  Tmp := A;
  A := B;
  B := Tmp;
End;

{
 A function of the quick sort algorithm. Gets
 an array and returns the number of permuta-
 tions in it.
}
// Arr - sortable array;
// N - array length;
Function QuickSort(Arr: TArray; Const N: Integer): integer;
Var
  I, J, L, R: Integer;
  X: Integer;
  S: integer;
  Stack: array of array[1..2] of Integer;
  // I, J - auxiliary variables;
  // L, R - sorting boundaries;
  // X - the middle element of the array;
  // S - number of gaps;
  // Stack - stack with gaps.

Begin

  // Initializing variables.
  Result := 0;
  Setlength(Arr, N);
  SetLength(Stack, N);
  S := 1;
  Stack[0,1] := 0;
  Stack[0,2] := N-1;

  // Sorting an array.
  Repeat
    L := Stack[s-1,1];
    R := Stack[s-1,2];
    S := S - 1;

    // Sorting an array gap.
    Repeat
      I := L;
      J := R;
      X := Arr[(L+R) div 2];

      // Passing through the gap of the array.
      Repeat
        While Arr[I] < X do
          I := I + 1;
        While X < Arr[J] do
          J := J - 1;

        // Exchange if the condition is met.
        If I <= J then
        begin
          Inc(Result);
          Swap(Arr[I], Arr[J]);
          I := I + 1;
          J := J - 1;
        end;
      Until I > J;

      // Shift of the gap.
      If I < R then
      begin
        S := S + 1;
        Stack[S-1,1] := I;
        Stack[S-1,2] := R;
      end;

      R := J;
    Until L >= R;
  Until S = 0;
End;

{
 A function of the simple insertion algorithm.
 Gets an array and returns the number of per-
 mutations in it.
}
// Arr - sortable array;
// N - array length;
Function InsertionSort(Arr: array of Integer; const N: Integer): integer;
Var
  I, J, Tmp: Integer;
  // I, J - auxiliary variables;
  // Tmp - a variable to exchange.

Begin
  I := 1;
  Result := 0;

  // Sorting the array.
  While I <= N - 1 do
  begin

    Tmp := Arr[I];
    J := I - 1;

    // Shift of array elements.
    While (J >= 0) and (Arr[J] > Tmp) do
    begin
      Inc(Result);
      Arr[J + 1] := Arr[J];
      Dec(J);
    end;

    Arr[J + 1] := Tmp;
    Inc(I);

  end;
End;

// Assign certain data types to variables.
Var
  InfoAboutArray: TInfoAboutArray;
  I: integer;

Begin
  writeln(' ________________________________________________________________________');
  writeln('| Размерность |      Тип      |    Qutick Sort    |    Простые вставки   |');
  Writeln('|   массива   |    Массива    |___________________|______________________|');
  writeln('|             |               | Кол-во |  Кол-во  | Кол-во  |   Кол-во   |');
  writeln('|             |               | экспе- |  теоре-  | экспе-  |   теорети- |');
  writeln('|             |               | рем.   |  тич.    | рем.    |   ческое   |');
  Writeln('|_____________|_______________|________|__________|_________|____________|');

  // Output of required values.
  For I := 0 to 17 do
  begin

    // Determining the size of the array.
    Case I div 3 of
      0:
        InfoAboutArray.Count := 100;
      1:
        InfoAboutArray.Count := 250;
      2:
        InfoAboutArray.Count := 500;
      3:
        InfoAboutArray.Count := 1000;
      4:
        InfoAboutArray.Count := 2000;
      5:
        InfoAboutArray.Count := 3000;
    End;

    SetLength(InfoAboutArray.Arr, InfoAboutArray.Count);

    // Definition of the array type.
    Case I mod 3 of
      0:
      begin
        InfoAboutArray.TypeArray := RandomArray;
        InfoAboutArray.TypeArrayWrite := 'Случайный    ';
        InfoAboutArray.InsertionSort.TeorInsertion := (InfoAboutArray.Count-1) * (InfoAboutArray.Count ) / 2;
      end;
      1:
      begin
        InfoAboutArray.TypeArray := SortArray;
        InfoAboutArray.TypeArrayWrite := 'Сортированный';
        InfoAboutArray.InsertionSort.TeorInsertion := 0;
      end;
      2:
      begin
        InfoAboutArray.TypeArray := InvertedArray;
        InfoAboutArray.TypeArrayWrite := 'Перевернутый ';
        InfoAboutArray.InsertionSort.TeorInsertion := (InfoAboutArray.Count-1) * (InfoAboutArray.Count ) / 2;
      end;
    End;

    // Getting additional information about the array.
    InfoAboutArray.Quick.TeorQuick := InfoAboutArray.Count * ln(InfoAboutArray.count)/ ln(2);
    GenerateArray(InfoAboutArray.Count,InfoAboutArray.TypeArray,InfoAboutArray.Arr);
    InfoAboutArray.Quick.ExpQuick := QuickSort(InfoAboutArray.Arr, InfoAboutArray.Count);
    InfoAboutArray.InsertionSort.ExpInsertion := InsertionSort(InfoAboutArray.Arr, InfoAboutArray.Count);

    // Output of the required information.
    Writeln('|             |               |        |          |         |            |');
    writeln('|    ',InfoAboutArray.Count:4,'     | ',InfoAboutArray.TypeArrayWrite ,' |  ',InfoAboutArray.Quick.ExpQuick:4,'  | ',InfoAboutArray.Quick.TeorQuick:8:2,' | ',InfoAboutArray.InsertionSort.ExpInsertion:7,' | ',InfoAboutArray.InsertionSort.TeorInsertion:10:2,' |');
    Writeln('|_____________|_______________|________|__________|_________|____________|');
  end;

  readln;
End.
