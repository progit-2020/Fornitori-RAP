unit A042UStampaEUCausalizzate;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, A000UCostanti, A000USessione,
  A000UInterfaccia, C180FunzioniGenerali, Variants, QRExport, QRWebFilt, QRPDFFilt;

type
  TChiamate = record
    Matricola:string;
    Data:TDateTime;
    OraDa: string;
    OraA: string;
  end;

type
  TA042FStampaEUCausalizzate = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRLblUnitaOperativa: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel3: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRLabel9: TQRLabel;
    QRShape19: TQRShape;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRLblAzienda: TQRLabel;
    QRLblTitolo: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLblOre: TQRLabel;
    QRShape13: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QrLblTotOre: TQRLabel;
    QRLabel8: TQRLabel;
    QRLblTotChiamate: TQRLabel;
    QRShape22: TQRShape;
    QRLabel7: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRLblData: TQRLabel;
    QRLblMatricola: TQRLabel;
    QRLblNome: TQRLabel;
    QRLblPeriodo: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText4Print(sender: TObject; var Value: String);
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
    TotaleChiamate, TotaleMinuti:integer;
    Chiamate: array of TChiamate;
    sPv_Data, sPv_Matricola: string;
  public
    { Public declarations }
    Periodo, Titolo: String;
    procedure CreaReport;
  end;

var
  A042FStampaEUCausalizzate: TA042FStampaEUCausalizzate;

implementation

uses A042UStampaPreAssDtM1, A042UDialogStampa, A042UStampaPreAssMW;

{$R *.DFM}

constructor TA042FStampaEUCausalizzate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA042FStampaEUCausalizzate.CreaReport;
begin
  if A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text <> '' then
    QRGroup1.Expression := 'Gruppo'
  else
    QRGroup1.Expression := '';
  Screen.Cursor:=CrDefault;
  if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
  begin
      ShowProgress:=False;
      ExportToFilter(TQRPDFDocumentFilter.Create(A042FDialogStampa.DocumentoPDF));
  end
  else if A042FDialogStampa.Anteprima then
    A042FStampaEUCausalizzate.Preview
  else
    A042FStampaEUCausalizzate.Print;
end;


procedure TA042FStampaEUCausalizzate.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLblAzienda.Caption:=Parametri.RagioneSociale;
  QrLblTitolo.Caption:=Titolo;
  QRLblPeriodo.Caption:=Periodo;
end;

procedure TA042FStampaEUCausalizzate.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var M:Integer;
begin
  if A042FStampaPreAssDtM1.A042MW.TabellaStampa.FieldByName('Progressivo').asString = '' then
    PrintBand:=False
  else
  begin
    with A042FStampaPreAssDtM1.A042MW do
    begin
      M:=R180OreMinutiExt(TabellaStampa.FieldByName('OraUscita').AsString);
      if (R180OreMinutiExt(TabellaStampa.FieldByName('OraEntrata').AsString) > M) or
         ((M <= 1440) and (TabellaStampa.FieldByName('Data').AsDateTime < TabellaStampa.FieldByName('DataUscita').AsDateTime)) then
        M:=M + 1440;
      QRLblOre.Caption:=R180MinutiOre(M - R180OreMinutiExt(TabellaStampa.FieldByName('OraEntrata').AsString));
      TotaleMinuti:=TotaleMinuti + M - R180OreMinutiExt(TabellaStampa.FieldByName('OraEntrata').AsString);

      SetLength(Chiamate, Length(Chiamate) + 1);
      Chiamate[Length(Chiamate) - 1].Matricola:=TabellaStampa.FieldByName('Matricola').asString;
      Chiamate[Length(Chiamate) - 1].Data:=TabellaStampa.FieldByName('Data').asDateTime;
      Chiamate[Length(Chiamate) - 1].OraDa:=TabellaStampa.FieldByName('OraEntrata').AsString;
      Chiamate[Length(Chiamate) - 1].OraA:=TabellaStampa.FieldByName('OraUscita').AsString;
      if ((TabellaStampa.FieldByName('Matricola').asString = sPv_Matricola) and
         (TabellaStampa.FieldByName('Data').asString = sPv_Data)) then
      begin
        QRLblData.Caption:='';
        QRLblMatricola.Caption:='';
        QRLblNome.Caption:='';
      end
      else
      begin
        sPv_Matricola:=TabellaStampa.FieldByName('Matricola').asString;
        sPv_Data:=TabellaStampa.FieldByName('Data').asString;
        QRLblData.Caption:=sPv_Data;
        QRLblMatricola.Caption:=sPv_Matricola;
        QRLblNome.Caption:=TabellaStampa.FieldByName('Nome').asString;
      end;
    end;
  end;
end;

procedure TA042FStampaEUCausalizzate.QRGroup1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  TotaleChiamate:=0;
  TotaleMinuti:=0;
  sPv_Data:='';
  sPv_Matricola:='';
  SetLength(Chiamate, 0);
  if A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text <> '' then
    QRLblUnitaOperativa.Caption:= A042FStampaPreAssDtM1.A042MW.TabellaStampa.fieldbyname('Gruppo').asString
  else
    QRLblUnitaOperativa.Caption:='';
end;

procedure TA042FStampaEUCausalizzate.QRBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var i:integer;
begin
  QRLblTotOre.Caption:=R180MinutiOre(TotaleMinuti);
  TotaleChiamate:=0;
  for i:=0 to length(Chiamate)-1 do
  begin
    if ((i>0) and (Chiamate[i].Matricola = Chiamate[i-1].Matricola) and (Chiamate[i].Data = Chiamate[i-1].Data + 1) and (Chiamate[i-1].OraA = '23.59') and (Chiamate[i].OraDa = '00.00')) then
      //Nulla
    else
      TotaleChiamate:=TotaleChiamate+1;
  end;
  QRLblTotChiamate.Caption:=inttostr(TotaleChiamate);
end;

procedure TA042FStampaEUCausalizzate.QRDBText4Print(sender: TObject;
  var Value: String);
begin
  if R180OreMinutiExt(Value) > 1440 then
    Value:=R180MinutiOre(R180OreMinutiExt(Value) - 1440);
end;

end.
