unit A013USviluppoIndiv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, Mask, QueryStorico,A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, Variants;

type
  TA013FSviluppoIndiv = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Calendario: TStringGrid;
    GroupBox1: TGroupBox;
    SLavora: TShape;
    Label1: TLabel;
    SDomenica: TShape;
    Label2: TLabel;
    SNonLavora: TShape;
    Label3: TLabel;
    SFesta: TShape;
    Label4: TLabel;
    DataCor: TMaskEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CalendarioDrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure SLavoraMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CalendarioSelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure DataCorKeyPress(Sender: TObject; var Key: Char);
    procedure CalendarioDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CalendarioDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Anni:array [1..120] of word;
    Mesi:array [1..120] of word;
    QSCalendario:TQueryStorico;
    procedure EvidenziaDomenica(Rect:TRect);
    procedure ColoraCella(Rect:TRect;Color:TColor);
    procedure ModificaCella(Sender:TObject; Col,Row:LongInt);
  public
    { Public declarations }
    NumMesi:Integer;
    Anno,Mese:Word;
    DaData,AData:TDateTime;
    CodCalendario:string;
  end;

var
  A013FSviluppoIndiv: TA013FSviluppoIndiv;

implementation

uses A013UCalendIndiv, A013UCalendIndivDtM1;

{$R *.DFM}

procedure TA013FSviluppoIndiv.FormCreate(Sender: TObject);
begin
  Calendario.ColWidths[0]:=80;
  Calendario.Width:=Calendario.ColWidths[0]+Calendario.ColWidths[1]*34;
  QSCalendario:=TQueryStorico.Create(nil);
end;

procedure TA013FSviluppoIndiv.FormActivate(Sender: TObject);
var i,m,a:integer;
begin
  QSCalendario.Session:=SessioneOracle;
  QSCalendario.GetDatiStorici('T430CALENDARIO',C700Progressivo,DaData,AData);
  a:=anno;
  m:=mese;
  if NumMesi > High(Mesi) then
  begin
    NumMesi:=High(Mesi);
    Calendario.RowCount:=NumMesi + 1;
  end;
  for i:=1 to NumMesi do
    begin
    Mesi[i]:=m;
    Anni[i]:=a;
    m:=m+1;
    if m > 12 then
      begin
      m:=1;
      a:=a+1;
      end;
   end;
end;

procedure TA013FSviluppoIndiv.ColoraCella(Rect:TRect;Color:TColor);
{Colora la metà specificata della cella col colore specificato}
begin
  with Calendario.Canvas do
    begin
    Brush.Color:=Color;
    FillRect(Rect);
    end;
end;

procedure TA013FSviluppoIndiv.EvidenziaDomenica(Rect:TRect);
{Incornicia di rosso la Domenica}
begin
  with Calendario.Canvas do
    begin
    Pen.Color:=clRed;
    Rectangle(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
    end;
end;

procedure TA013FSviluppoIndiv.ModificaCella(Sender:TObject; Col,Row:LongInt);
{Cambia lo stato della cella:
 Lavorativo/Non lavorativo
 Festivo/Non festivo}
var Data:TDateTime;
    Rect:TRect;
begin
  try
    Data:=EncodeDate(Anni[Row],Mesi[Row],Col);
    except
    exit;
    end;
  with A013FCalendIndivDtM1.A013MW do
    begin
    if not Q012.Locate('Data',Data,[]) then exit;
    Q012.Edit;
    if Sender = SLavora then
      Q012['Lavorativo']:='S';
    if Sender = SNonLavora then
      Q012['Lavorativo']:='N';
    if Sender = SFesta then
      if Q012['Festivo'] = 'S' then
        Q012['Festivo']:='N'
      else
        Q012['Festivo']:='S';
    Q012.Post;
    end;
  Rect:=Calendario.CellRect(Col,Row);
  CalendarioDrawCell(Calendario,Col,Row,Rect,[gdSelected..gdFocused]);

end;

procedure TA013FSviluppoIndiv.CalendarioDrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
var Data:TDateTime;
    RetCal:TRect;
    MeseAnno:String;
{Procedure per colorare i giorni sia del calendario dipendente che di quello generale}
begin
  {Scrive i nomi dei mesi sulla colonna 0 e i numeri dei giorni sulla riga 0}
  if State = [gdFixed] then
    begin
    if (Col = 0) and (Row > 0) then
      begin
      MeseAnno:=IntToStr(Anni[Row])+' '+{$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[Mesi[Row]];
      Calendario.Canvas.TextRect(Rect,Rect.Left,Rect.Top,MeseAnno);
      end;
    if (Col > 0) and (Col < 32) then
      Calendario.Canvas.TextRect(Rect,Rect.Left,Rect.Top,IntToStr(Col));
    end;
    {Scrive i nomi dei giorni e colora le caselle a seconda del tipo giorno}
    if not (State = [gdFixed]) then
    begin
    ColoraCella(Rect,clWhite);
    try
      Data:=EncodeDate(Anni[Row],Mesi[Row],Col);
      except
      exit;
    end;
    with A013FCalendIndivDtM1.A013MW do
      if Q012.Locate('Data',Data,[]) then
        {Calendario del dipendente}
        begin
        Calendario.Canvas.Brush.Style:=bsSolid;
        RetCal:=Rect;
        if Q012['Festivo']='S' then
          begin
          ColoraCella(RetCal,clYellow);      {Festivo}
          RetCal.Left:=(RetCal.Left+RetCal.Right) div 2;
          end;
        if not(Q012['Lavorativo'] = 'S') then
          ColoraCella(RetCal,clLime);         {Non lavorativo}
        Calendario.Canvas.Brush.Style:=bsClear;
        if DayOfWeek(Q012['Data']) = 1 then    {Domenica}
          EvidenziaDomenica(Rect);
        Calendario.Canvas.Font.Color:=clBlack;
        Calendario.Canvas.TextRect(Rect,Rect.Left,Rect.Top,{$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)]);
        Calendario.Canvas.Font.Color:=clWhite;
        end
      else
        {Attingo dal calendario registrato in anagrafico}
        begin
        if not QSCalendario.LocDatoStorico(Data) then exit;
        if QSCalendario.FieldByName('T430CALENDARIO').AsString <> VarToStr(Q011.GetVariable('Codice')) then
          begin
          Q011.Close;
          Q011.SetVariable('Codice',QSCalendario.FieldByName('T430CALENDARIO').AsString);
          Q011.SetVariable('Data1',DaData);
          Q011.SetVariable('Data2',AData);
          Q011.Open;
          end;
        if Q011.Locate('Data',Data,[]) then
          begin
          Calendario.Canvas.Brush.Style:=bsSolid;
          RetCal:=Rect;
          if Q011['Festivo']='S' then
            begin
            ColoraCella(RetCal,clYellow);      {Festivo}
            RetCal.Left:=(RetCal.Left+RetCal.Right) div 2;
            end;
          if not(Q011['Lavorativo']='S') then
            ColoraCella(RetCal,clLime);         {Non lavorativo}
          Calendario.Canvas.Brush.Style:=bsClear;
          Calendario.Canvas.Font.Color:=clRed;
          if DayOfWeek(Q011['Data']) = 1 then    {Domenica}
            EvidenziaDomenica(Rect);
          Calendario.Canvas.TextRect(Rect,Rect.Left,Rect.Top,{$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)]);
          Calendario.Canvas.Font.Color:=clWhite;
          end;
        end;
    end;
end;

procedure TA013FSviluppoIndiv.SLavoraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col,Row:LongInt;
begin
  if not (Shift = [ssAlt,ssLeft]) then exit;
  if Sender = SDomenica then exit;
  Col:=Calendario.Selection.Left;
  Row:=Calendario.Selection.Top;
  ModificaCella(Sender,Col,Row);
end;

procedure TA013FSviluppoIndiv.CalendarioSelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
var Data:TDateTime;
    A,M,G:Word;
begin
  G:=Col;
  M:=Mesi[Row];
  A:=Anni[Row];
  try
    Data:=EncodeDate(A,M,G);
  except
    exit;
  end;
  DataCor.Text:=FormatDateTime('dd/mm/yyy',Data);
end;

procedure TA013FSviluppoIndiv.DataCorKeyPress(Sender: TObject; var Key: Char);
var A,M,G:Word;
begin
  if ord(Key) <> 13 then exit;
  try
    DecodeDate(StrToDate(DataCor.Text),A,M,G);
  except
    exit;
  end;
  Calendario.Col:=G;
  with Calendario do
  begin
    G:=0;
    repeat
      G:=G+1
    until ((Anni[G]=A) and (Mesi[G]=M)) or (G = RowCount-1);
  end;
  Calendario.Row:=G;
end;

procedure TA013FSviluppoIndiv.CalendarioDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=not SolaLettura;
end;

procedure TA013FSviluppoIndiv.CalendarioDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var Col,Row:LongInt;
begin
  Calendario.MouseToCell(X, Y, Col, Row);
  ModificaCella(Source,Col,Row);
end;

procedure TA013FSviluppoIndiv.FormDestroy(Sender: TObject);
begin
  QSCalendario.Free;
end;

end.
