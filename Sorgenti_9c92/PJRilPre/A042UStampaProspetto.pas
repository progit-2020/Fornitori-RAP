unit A042UStampaProspetto;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Dialogs,
  QRCtrls, QuickRpt, StdCtrls, ExtCtrls, Forms, A000UCostanti, A000USessione,A000UInterfaccia, Variants,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TA042FStampaProspetto = class(TQuickRep)
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLblAzienda: TQRLabel;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRLblUnitaOperativa: TQRLabel;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRLabel6: TQRLabel;
    QRShape24: TQRShape;
    QRLblEntrata: TQRLabel;
    QRShape25: TQRShape;
    QRLblUscita: TQRLabel;
    QRShape26: TQRShape;
    QRLblConsecutive: TQRLabel;
    QRShape27: TQRShape;
    QRLblLimite1: TQRLabel;
    QRShape28: TQRShape;
    QRLblLimite2: TQRLabel;
    QRShape29: TQRShape;
    QRLabel13: TQRLabel;
    QRDBText2: TQRDBText;
    QRBand1: TQRBand;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRDBNomeMedico: TQRDBText;
    QRShape19: TQRShape;
    QRDBMatricola: TQRDBText;
    QRDBOraEntrata: TQRDBText;
    QRDBOraUscita: TQRDBText;
    QRDBTotale: TQRDBText;
    QRDbLimite1: TQRDBText;
    QrDbLimite2: TQRDBText;
    QRBand3: TQRBand;
    QRBand2: TQRBand;
    QRLblGruppo: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    dData: TDateTime;
    sGruppo: string;
  public
    { Public declarations }
    bSaltoPagina: boolean;
    sDaData: string;
    sDaOra, sAOra: string;
    sOraDaLimite1, sOraALimite1, sLimite1:String;
    sOraDaLimite2, sOraALimite2, sLimite2:String;
    procedure CreaReport;
    constructor Create(AOwner: TComponent); override;
  end;

var
  A042FStampaProspetto: TA042FStampaProspetto;

implementation

uses A042UStampaPreAssDtM1, A042UDialogStampa, A042UStampaPreAssMW;

{$R *.DFM}

constructor TA042FStampaProspetto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA042FStampaProspetto.CreaReport;
begin
  if A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text <> '' then
  begin
    QRLblUnitaOperativa.Caption:='Unità Operativa:';
    QRGroup2.Expression := 'Gruppo';
  end
  else
  begin
    QRGroup2.Expression := '';
    QRLblUnitaOperativa.Caption:='';
  end;
  QRLblEntrata.Caption:='Ora entrata dalle ' + sDaOra + ' alle ' + sAOra;
  QRLblUscita.Caption:='Ora uscita dalle ' + sDaOra + ' alle ' + sAOra;
  QrLblConsecutive.Caption:='Totale ore consecutive dalle ' + sDaOra + ' alle ' + sAOra;
  QrLblLimite1.Caption:='Le ore consecutive dalle ' + sOraDaLimite1 + ' alle ' + sOraALimite1 + ' sono < ' + sLimite1;
  QrLblLimite2.Caption:='Le ore consecutive dalle ' + sOraDaLimite2 + ' alle ' + sOraALimite2 + ' sono > ' + sLimite2;
  Screen.Cursor:=crDefault;
  if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
  begin
      ShowProgress:=False;
      ExportToFilter(TQRPDFDocumentFilter.Create(A042FDialogStampa.DocumentoPDF));
  end
  else if A042FDialogStampa.Anteprima then
    A042FStampaProspetto.Preview
  else
    A042FStampaProspetto.Print;
end;


procedure TA042FStampaProspetto.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A042FStampaPreAssDtM1.A042MW.TabellaStampa.FieldByName('Progressivo').asString = '' then
    PrintBand:=False;
end;

procedure TA042FStampaProspetto.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A042FStampaPreAssDtM1 do
  begin
    if (not A042MW.TabellaStampa.Bof) and
       (A042MW.ListaIntestazione.Text <> '') and
       (bSaltoPagina = True) and
       (A042MW.TabellaStampa.FieldByName('GRUPPO').asString <> sGruppo) and
       ((A042MW.TabellaStampa.FieldByName('DATA').asDateTime = dData) and (not A042MW.TabellaStampa.Bof)) then
      A042FStampaProspetto.ForceNewPage;
    dData:=A042MW.TabellaStampa.FieldByName('DATA').asDateTime;
    sGruppo:=A042MW.TabellaStampa.FieldByName('GRUPPO').asString;
  end;
end;

procedure TA042FStampaProspetto.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLblAzienda.Caption:=Parametri.RagioneSociale;
  QRLblGruppo.Caption:='PROSPETTO DELLE ORE LAVORATE NEL GIORNO: ' + FormatDateTime('dddd dd mmmm yyyy', A042FStampaPreAssDtM1.A042MW.TabellaStampa.FieldValues['DATA']);
end;

procedure TA042FStampaProspetto.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not A042FStampaPreAssDtM1.A042MW.TabellaStampa.Bof then
      A042FStampaProspetto.ForceNewPage;
end;

procedure TA042FStampaProspetto.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  dData:=0;
  sGruppo:='';
end;

procedure TA042FStampaProspetto.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=False;
end;

procedure TA042FStampaProspetto.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=False;
end;

end.
