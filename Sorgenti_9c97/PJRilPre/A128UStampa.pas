unit A128UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Printers, A000UInterfaccia, Variants,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TA128FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRBDettaglio: TQRBand;
    QRBIntestazione: TQRBand;
    ChildDettaglio: TQRChildBand;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRGroup1: TQRGroup;
    QRLRaggruppamento: TQRLabel;
    QRDBTGruppo: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRExpr1: TQRExpr;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    VettInte:array[1..31] of TQRLabel;
    VettDett:array[1..93] of TQRDBText;
    VettShape:array[1..93] of TQRShape;
    procedure DistruggiQRDBText;
    procedure DistruggiQRLabel;
    function NomeGiorno(Data :TDateTime):String;
  public
    { Public declarations }
    CampoGruppo:String;
    NomeLogicoCampoGruppo:String;
    DataStampa:TDateTime;
    procedure CreaReport;
  end;

var
  A128FStampa: TA128FStampa;

implementation
uses A128UDialogStampa, A128UPianPrestazioniAggiuntiveDtm;
{$R *.DFM}

function TA128FStampa.NomeGiorno(Data :TDateTime):String;
begin
  Result:='';
  case DayofWeek(Data) of
    1:Result:='D';
    2:Result:='L';
    3:Result:='M';
    4:Result:='M';
    5:Result:='G';
    6:Result:='V';
    7:Result:='S';
  end;
end;

procedure TA128FStampa.CreaReport;
var AA,MM,DD,NG,X,I,J:Word;
    DefWidth:Integer;
    DataApp:TDateTime;
    Suff:String;
begin
  DistruggiQRDBText;
  DistruggiQRLabel;
  RepR.Page.Orientation:=poLandScape;
  DecodeDate(DataStampa,AA,MM,DD);
  if CampoGruppo <> '' then
  begin
    QRGroup1.Expression:=CampoGruppo;
    QRLRaggruppamento.Caption:=NomeLogicoCampoGruppo;
    QRDBTGruppo.DataField:=CampoGruppo;
    QRGroup1.Enabled:=True;
  end
  else
    QRGroup1.Enabled:=False;
  NG:=R180GiorniMese(DataStampa);
  X:=20;
  DefWidth:=33; //Canvas.TextWidth('ZZZZZ');
  for I:=1 to NG do
  begin
    VettInte[I]:=TQRLabel.Create(A128FStampa);
    VettInte[I].Parent:=QRBIntestazione;
    VettInte[I].Top:=4;
    VettInte[I].Height:=8;
    VettInte[I].Width:=DefWidth;
    VettInte[I].Left:=X;
    VettInte[I].Autosize:=False;
    VettInte[I].Font.Size:=8;
    VettInte[I].AlignMent:=taCenter;
    DataApp:=EncodeDate(AA,MM,I);
    VettInte[I].Caption:=inttostr(I) +' '+NomeGiorno(DataApp);
    X:=X + DefWidth;
  end;
  X:=20;
  I:=1;
  j:=0;
  while I < (NG*3) do
  begin
    VettShape[I]:=TQRShape.Create(A128FStampa);
    VettShape[I].Parent:=ChildDettaglio;
    VettShape[I].Shape:=qrsRectangle;
    VettShape[I].Top:=2;
    VettShape[I].Height:=16;
    VettShape[I].Width:=DefWidth;
    VettShape[I].Left:=X;
    VettShape[I+1]:=TQRShape.Create(A128FStampa);
    VettShape[I+1].Parent:=ChildDettaglio;
    VettShape[I+1].Shape:=qrsRectangle;
    VettShape[I+1].Top:=18;
    VettShape[I+1].Height:=16;
    VettShape[I+1].Width:=DefWidth;
    VettShape[I+1].Left:=X;
    if j > 0 then
      Suff:='_' + IntToStr(j)
    else
      Suff:='';
    VettDett[I]:=TQRDBText.Create(A128FStampa);
    VettDett[I].Parent:=ChildDettaglio;
    VettDett[I].DataSet:=A128FPianPrestazioniAggiuntiveDtm.Q332St;
    VettDett[I].DataField:='TURNO1' + Suff;
    VettDett[I].Top:=4;
    VettDett[I].Height:=8;
    VettDett[I].Width:=DefWidth-2;
    VettDett[I].Left:=X+1;
    VettDett[I].AutoSize:=False;
    VettDett[I].Alignment:=taCenter;
    VettDett[I].Font.Size:=7;
    VettDett[I+1]:=TQRDBText.Create(A128FStampa);
    VettDett[I+1].Parent:=ChildDettaglio;
    VettDett[I+1].DataSet:=A128FPianPrestazioniAggiuntiveDtm.Q332St;
    VettDett[I+1].DataField:='TURNO2' + Suff;
    VettDett[I+1].Top:=20;
    VettDett[I+1].Height:=8;
    VettDett[I+1].Width:=DefWidth-2;
    VettDett[I+1].Left:=X+1;
    VettDett[I+1].AutoSize:=False;
    VettDett[I+1].Font.Size:=7;
    VettDett[I+1].Alignment:=taCenter;
    X:=X + DefWidth;
    inc(I,3);
    inc(J,1);
  end;
  RepR.Preview;
end;

procedure TA128FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLTitolo.Caption:='Turni prestazioni aggiuntive del mese di: '+ A128FDialogStampa.CreaDataCorrente(DataStampa);
end;

procedure TA128FStampa.DistruggiQRDBText;
var I:Integer;
begin
  for I:=(R180GiorniMese(DataStampa)*3) downto 1 do
    if VettDett[I] <> nil then
    begin
      FreeAndNil(VettDett[I]);
      FreeAndNil(VettShape[I]);
    end;
end;

procedure TA128FStampa.DistruggiQRLabel;
var I:Integer;
begin
  for I:=R180GiorniMese(DataStampa) downto 1 do
     TQRLabel(VettInte[I]).Free;
end;

procedure TA128FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA128FStampa.FormDestroy(Sender: TObject);
begin
  DistruggiQRDBText;
  DistruggiQRLabel;
end;

end.
