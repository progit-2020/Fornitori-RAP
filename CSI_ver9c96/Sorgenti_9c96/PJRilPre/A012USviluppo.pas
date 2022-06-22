unit A012USviluppo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, Mask, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA012FSviluppo = class(TForm)
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
  private
    { Private declarations }
    Anni:array [1..240] of word;
    Mesi:array [1..240] of word;
    procedure EvidenziaDomenica(Rect:TRect);
    procedure ColoraCella(Rect:TRect;Color:TColor);
    procedure ModificaCella(Sender:TObject; Col,Row:LongInt);
  public
    { Public declarations }
    NumMesi:Integer;
    Anno,Mese:Word;
  end;

var
  A012FSviluppo: TA012FSviluppo;

implementation

uses A012UCalendari, A012UCalendariDtM1;

{$R *.DFM}

procedure TA012FSviluppo.ColoraCella(Rect:TRect;Color:TColor);
begin
  with Calendario.Canvas do
    begin
    Brush.Color:=Color;
    FillRect(Rect);
    end;
end;

procedure TA012FSviluppo.EvidenziaDomenica(Rect:TRect);
begin
  with Calendario.Canvas do
    begin
    Pen.Color:=clRed;
    Rectangle(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
    end;
end;

procedure TA012FSviluppo.ModificaCella(Sender:TObject; Col,Row:LongInt);
var Data:TDateTime;
    Rect:TRect;
begin
  try
    Data:=EncodeDate(Anni[Row],Mesi[Row],Col);
    except
    exit;
    end;
  with A012FCalendariDtM1 do
    begin
    if not Q011.Locate('Data',Data,[]) then exit;
    Q011.CachedUpdates:=True;
    Q011.Edit;
    if Sender = SLavora then
      Q011['Lavorativo']:='S';
    if Sender = SNonLavora then
      Q011['Lavorativo']:='N';
    if Sender = SFesta then
      if Q011['Festivo'] = 'N' then
        Q011['Festivo']:='S'
      else
        Q011['Festivo']:='N';
    Q011.Post;
    SessioneOracle.ApplyUpdates([Q011],True);
    Q011.CachedUpdates:=False;
    Q011.Close;
    Q011.Open;
    end;
  Rect:=Calendario.CellRect(Col,Row);
  CalendarioDrawCell(Calendario,Col,Row,Rect,[gdSelected..gdFocused]);

end;

procedure TA012FSviluppo.FormCreate(Sender: TObject);
begin
  Calendario.ColWidths[0]:=80;
  Calendario.Width:=Calendario.ColWidths[0]+Calendario.ColWidths[1]*34;
end;

procedure TA012FSviluppo.FormActivate(Sender: TObject);
var i,m,a:integer;
begin
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

procedure TA012FSviluppo.CalendarioDrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
var Data:TDateTime;
    RetCal:TRect;
    MeseAnno:String;
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
      Exit;
    end;
    with A012FCalendariDtM1 do
      try
      if Q011.Locate('Data',Data,[]) then
        begin
        RetCal:=Rect;
        if Q011['Festivo']='S' then
          begin
          ColoraCella(RetCal,clYellow);      {Festivo}
          RetCal.Left:=(RetCal.Left+RetCal.Right) div 2;
          end;
        if not (Q011['Lavorativo'] = 'S') then
          ColoraCella(RetCal,clLime);         {Non lavorativo}
        Calendario.Canvas.Brush.Style:=bsClear;
        if DayOfWeek(Q011['Data']) = 1 then
          EvidenziaDomenica(Rect);
        Calendario.Canvas.Font.Color:=clBlack;
        Calendario.Canvas.TextRect(Rect,Rect.Left,Rect.Top,{$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(Data)]);
        Calendario.Canvas.Font.Color:=clWhite;
        end;
      except
        //on E:EDBEngineError do ShowMessage(E.Message);
      end;
    end;
end;

procedure TA012FSviluppo.SLavoraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Col,Row:LongInt;
begin
  if not (Shift = [ssAlt,ssLeft]) then exit;
  if Sender = SDomenica then exit;
  Col:=Calendario.Selection.Left;
  Row:=Calendario.Selection.Top;
  ModificaCella(Sender,Col,Row);
end;

procedure TA012FSviluppo.CalendarioSelectCell(Sender: TObject; Col,
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

procedure TA012FSviluppo.DataCorKeyPress(Sender: TObject; var Key: Char);
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
    Repeat
      G:=G+1
    Until ((Anni[G]=A) and (Mesi[G]=M)) or (G = RowCount-1);
    end;
  Calendario.Row:=G;
end;

procedure TA012FSviluppo.CalendarioDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=not SolaLettura;
end;

procedure TA012FSviluppo.CalendarioDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var Col,Row:LongInt;
begin
  Calendario.MouseToCell(X, Y, Col, Row);
  ModificaCella(Source,Col,Row);
end;

end.
