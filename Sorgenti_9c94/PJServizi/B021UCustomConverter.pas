unit B021UCustomConverter;

interface

uses
  DBXJSONReflect;

var
  ISODateTimeConverter: TStringConverter;
  ISODateTimeReverter: TStringReverter;

  DateConverter: TStringConverter;
  DateReverter: TStringReverter;

  DateTimeConverter: TStringConverter;
  DateTimeReverter: TStringReverter;

  StringListConverter: TTypeStringsConverter;
  StringListReverter: TTypeStringsReverter;

implementation

uses
  SysUtils, RTTI, DateUtils, Classes;

initialization

  // date time converter formato ISO
  ISODateTimeConverter:=function(Data: TObject; Field: string): string
  var
    ctx: TRttiContext; date : TDateTime;
  begin
    date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
    Result:=FormatDateTime('yyyy-mm-dd hh:nn:ss',date);
  end;

  ISODateTimeReverter:=procedure(Data: TObject; Field: string; Arg: string)
  var
    ctx: TRttiContext;
    datetime :
    TDateTime;
  begin
    datetime:=EncodeDateTime(StrToInt(Copy(Arg,1,4)),
                             StrToInt(Copy(Arg,6,2)),
                             StrToInt(Copy(Arg,9,2)),
                             StrToInt(Copy(Arg,12,2)),
                             StrToInt(Copy(Arg,15,2)),
                             StrToInt(Copy(Arg,18,2)),
                             0);
    ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data,datetime);
  end;

  // TDateTime -> formato data senza ora
  DateConverter:=function(Data: TObject; Field: string): string
  var
    ctx: TRttiContext; date : TDateTime;
  begin
    date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
    Result:=FormatDateTime('yyyy-mm-dd',date);
  end;

  DateReverter:=procedure(Data: TObject; Field: string; Arg: string)
  var
    ctx: TRttiContext;
    datetime :
    TDateTime;
  begin
    datetime:=EncodeDateTime(StrToInt(Copy(Arg,1,4)),
                             StrToInt(Copy(Arg,6,2)),
                             StrToInt(Copy(Arg,9,2)),
                             0,0,0,0);
    ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data,datetime);
  end;

  // TDateTime -> formato data-ora
  DateTimeConverter:=function(Data: TObject; Field: string): string
  var
    ctx: TRttiContext; date : TDateTime;
  begin
    date:=ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
    Result:=FormatDateTime('yyyy-mm-dd hhhh:nn',date);
  end;

  DateTimeReverter:=procedure(Data: TObject; Field: string; Arg: string)
  var
    ctx: TRttiContext;
    datetime :
    TDateTime;
  begin
    datetime:=EncodeDateTime(StrToInt(Copy(Arg,1,4)),
                             StrToInt(Copy(Arg,6,2)),
                             StrToInt(Copy(Arg,9,2)),
                             StrToInt(Copy(Arg,12,2)),
                             StrToInt(Copy(Arg,15,2)),
                             0,0);
    ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data,datetime);
  end;

  // TStringList
  StringListConverter:=function(Data: TObject): TListOfStrings
  var
    i, count: integer;
  begin
    count:=TStringList(Data).count;
    SetLength(Result, count);
    for i:=0 to count - 1 do
      Result[i]:=TStringList(Data)[i];
  end;

  StringListReverter:=function(Data: TListOfStrings): TObject
  var
    StrList: TStringList;
    Str: string;
  begin
    StrList:=TStringList.Create;
    for Str in Data do
      StrList.Add(Str);
    Result:=StrList;
  end;

end.


