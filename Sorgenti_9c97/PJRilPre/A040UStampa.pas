unit A040UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Printers, A000UInterfaccia,
  Variants, QRExport, QRWebFilt, QRPDFFilt;

type
  TA040FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRBIntestazione: TQRBand;
    QRBDettaglio: TQRBand;
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
    QRLabel5: TQRLabel;
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
    VettDett:array[1..124] of TQRDBText;
    VettShape:array[1..124] of TQRShape;
    procedure DistruggiQRDBText;
    procedure DistruggiQRLabel;
  public
    { Public declarations }
    CampoGruppo:String;
    NomeLogicoCampoGruppo:String;
    DataStampa:TDateTime;
    procedure CreaReport(Stampa: Boolean);
  end;

var
  A040FStampa: TA040FStampa;

implementation

uses A040UDialogStampa, A040UPianifRep, A040UPianifRepDtM1;
{$R *.DFM}

procedure TA040FStampa.CreaReport(Stampa: Boolean);
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
  if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    ChildDettaglio.Height:=66
  else
    ChildDettaglio.Height:=56;
  NG:=R180GiorniMese(DataStampa);
  X:=20;
  DefWidth:=33; //Canvas.TextWidth('ZZZZZ');
  for I:=1 to NG do
  begin
    VettInte[I]:=TQRLabel.Create(A040FStampa);
    VettInte[I].Parent:=QRBIntestazione;
    VettInte[I].Top:=4;
    VettInte[I].Height:=8;
    VettInte[I].Width:=DefWidth;
    VettInte[I].Left:=X;
    VettInte[I].Autosize:=False;
    VettInte[I].Font.Size:=8;
    VettInte[I].AlignMent:=taCenter;
    DataApp:=EncodeDate(AA,MM,I);
    VettInte[I].Caption:=inttostr(I) + ' ' + Copy(R180NomeGiorno(DataApp),2);
    X:=X + DefWidth;
  end;
  X:=20;
  I:=1;
  j:=0;
  while I < (NG*4) do
  begin
    VettShape[I]:=TQRShape.Create(A040FStampa);
    VettShape[I].Parent:=ChildDettaglio;
    VettShape[I].Shape:=qrsRectangle;
    VettShape[I].Top:=2;
    VettShape[I].Height:=16;
    VettShape[I].Width:=DefWidth;
    VettShape[I].Left:=X;
    VettShape[I+1]:=TQRShape.Create(A040FStampa);
    VettShape[I+1].Parent:=ChildDettaglio;
    VettShape[I+1].Shape:=qrsRectangle;
    VettShape[I+1].Top:=18;
    VettShape[I+1].Height:=16;
    VettShape[I+1].Width:=DefWidth;
    VettShape[I+1].Left:=X;
    VettShape[I+2]:=TQRShape.Create(A040FStampa);
    VettShape[I+2].Parent:=ChildDettaglio;
    VettShape[I+2].Shape:=qrsRectangle;
    VettShape[I+2].Top:=34;
    VettShape[I+2].Height:=16;
    VettShape[I+2].Width:=DefWidth;
    VettShape[I+2].Left:=X;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      VettShape[I+3]:=TQRShape.Create(A040FStampa);
      VettShape[I+3].Parent:=ChildDettaglio;
      VettShape[I+3].Shape:=qrsRectangle;
      VettShape[I+3].Top:=50;
      VettShape[I+3].Height:=16;
      VettShape[I+3].Width:=DefWidth;
      VettShape[I+3].Left:=X;
    end;
    if j > 0 then
      Suff:='_' + IntToStr(j)
    else
      Suff:='';
    VettDett[I]:=TQRDBText.Create(A040FStampa);
    VettDett[I].Parent:=ChildDettaglio;
    VettDett[I].DataSet:=A040FPianifRepDtM1.Q380St;
    VettDett[I].DataField:='TURNO1' + Suff;
    VettDett[I].Top:=4;
    VettDett[I].Height:=8;
    VettDett[I].Width:=DefWidth-2;
    VettDett[I].Left:=X+1;
    VettDett[I].AutoSize:=False;
    VettDett[I].Alignment:=taCenter;
    VettDett[I].Font.Size:=5;
    VettDett[I+1]:=TQRDBText.Create(A040FStampa);
    VettDett[I+1].Parent:=ChildDettaglio;
    VettDett[I+1].DataSet:=A040FPianifRepDtM1.Q380St;
    VettDett[I+1].DataField:='TURNO2' + Suff;
    VettDett[I+1].Top:=20;
    VettDett[I+1].Height:=8;
    VettDett[I+1].Width:=DefWidth-2;
    VettDett[I+1].Left:=X+1;
    VettDett[I+1].AutoSize:=False;
    VettDett[I+1].Font.Size:=5;
    VettDett[I+1].Alignment:=taCenter;
    VettDett[I+2]:=TQRDBText.Create(A040FStampa);
    VettDett[I+2].Parent:=ChildDettaglio;
    VettDett[I+2].DataSet:=A040FPianifRepDtM1.Q380St;
    VettDett[I+2].DataField:='TURNO3' + Suff;
    VettDett[I+2].Top:=36;
    VettDett[I+2].Height:=8;
    VettDett[I+2].Width:=DefWidth-2;
    VettDett[I+2].Left:=X+1;
    VettDett[I+2].AutoSize:=False;
    VettDett[I+2].Font.Size:=5;
    VettDett[I+2].Alignment:=taCenter;
    if Parametri.CampiRiferimento.C3_DatoPianificabile <> '' then
    begin
      VettDett[I+3]:=TQRDBText.Create(A040FStampa);
      VettDett[I+3].Parent:=ChildDettaglio;
      VettDett[I+3].DataSet:=A040FPianifRepDtM1.Q380St;
      VettDett[I+3].DataField:='DATOLIBERO' + Suff;
      VettDett[I+3].Top:=52;
      VettDett[I+3].Height:=8;
      VettDett[I+3].Width:=DefWidth-2;
      VettDett[I+3].Left:=X+1;
      VettDett[I+3].AutoSize:=False;
      VettDett[I+3].Font.Size:=5;
      VettDett[I+3].Alignment:=taCenter;
    end;
    X:=X + DefWidth;
    inc(I,4);
    inc(J,1);
  end;
  if Stampa then
    RepR.Print
  else
    RepR.Preview;
end;

procedure TA040FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  MeseAnno: String;
begin
  MeseAnno:=R180NomeMese(R180Mese(DataStampa)) + ' ' + IntToStr(R180Anno(DataStampa));
  QRLTitolo.Caption:=Format('Turni di %s del mese di: %s',[A040FPianifRepDtM1.A040MW.sTipo,MeseAnno]);
end;

procedure TA040FStampa.DistruggiQRDBText;
var i:Integer;
begin
  //for I:=(R180GiorniMese(DataStampa)*3) downto 1 do
  for i:=124 downto 1 do
    if VettDett[i] <> nil then
    begin
      FreeAndNil(VettDett[i]);
      FreeAndNil(VettShape[i]);
    end;
end;

procedure TA040FStampa.DistruggiQRLabel;
var i:Integer;
begin
  //for I:=R180GiorniMese(DataStampa) downto 1 do
  for i:=31 downto 1 do
    if VettInte[i] <> nil then
    begin
     TQRLabel(VettInte[i]).Free;
     VettInte[i]:=nil;
    end;
end;

procedure TA040FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA040FStampa.FormDestroy(Sender: TObject);
begin
  DistruggiQRDBText;
  DistruggiQRLabel;
end;

end.
