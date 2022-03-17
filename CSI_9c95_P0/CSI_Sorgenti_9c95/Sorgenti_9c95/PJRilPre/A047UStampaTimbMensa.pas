unit A047UStampaTimbMensa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, Menus, quickrpt, Qrctrls, Variants,
  QRExport, QRWebFilt, QRPDFFilt, A047UTimbMensaMW;

type
  TA047FStampaTimbMensa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRBTotali: TQRBand;
    QRBDettaglio: TQRBand;
    QRBInt: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel5: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText6: TQRDBText;
    QRLTotPasti: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText9: TQRDBText;
    QRLTotPasti2: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText10: TQRDBText;
    QRLTotAccessi: TQRLabel;
    qlblBadge2: TQRLabel;
    qlblNome2: TQRLabel;
    qlblNome: TQRDBText;
    qlblBadge: TQRDBText;
    QRBChild: TQRChildBand;
    QRDBText4: TQRDBText;
    QRDBText8: TQRDBText;
    qbndSommario: TQRBand;
    qlblSumPasti: TQRLabel;
    qlblSumPasti2: TQRLabel;
    qlblSumAccessi: TQRLabel;
    QRLabel12: TQRLabel;
    QRGroup1: TQRGroup;
    qlblRilevatore: TQRLabel;
    qbndRilevatoreI: TQRGroup;
    qbndRilevatoreP: TQRBand;
    qlblRilevatoreTot: TQRLabel;
    qlblRilPasti: TQRLabel;
    qlblRilPasti2: TQRLabel;
    qlblRilAccessi: TQRLabel;
    ChildGiustificativi: TQRChildBand;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    qlblMatricola: TQRDBText;
    QRLGruppo: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBTotaliBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qbndRilevatoreIBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qbndRilevatorePBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qbndSommarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qbndRilevatorePAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRLGruppoPrint(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TotPasti,TotPasti2,TotAccessi,
    TotRilPasti,TotRilPasti2,TotRilAccessi,
    TotSumPasti,TotSumPasti2,TotSumAccessi:Integer;
    StampaNome:Boolean;
  public
    { Public declarations }
    DataI,DataF : TDateTime;
    procedure CreaReport(Sender:TObject);
  end;

var
  A047FStampaTimbMensa: TA047FStampaTimbMensa;

implementation
{$R *.DFM}
uses A047UTimbMensaDtM1, A047UDialogStampa;

procedure TA047FStampaTimbMensa.CreaReport(Sender:TObject);
begin

  if (Trim(A047FDialogStampa.DocumentoPDF) <> '') and (Trim(A047FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A047FDialogStampa.TipoModulo) = 'COM')then
  begin
    Repr.ShowProgress:=False;
    repR.ExportToFilter(TQRPDFDocumentFilter.Create(A047FDialogStampa.DocumentoPDF));
  end
  else
  begin
    if Sender = A047FDialogStampa.btnAnteprima then
      RepR.Preview
    else
      RepR.Print;

  end;


end;

procedure TA047FStampaTimbMensa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLTitolo.Caption:='Stampa timbrature di mensa con anomalie dal '+
                       FormatDateTime('dd mmm yyyy',DataI)+' al '+FormatDateTime('dd mmm yyyy',DataF);
  TotSumPasti:=0;
  TotSumPasti2:=0;
  TotSumAccessi:=0;
  TotRilPasti:=0;
  TotRilPasti2:=0;
  TotRilAccessi:=0;
  TotPasti:=0;
  TotPasti2:=0;
  TotAccessi:=0;
end;

procedure TA047FStampaTimbMensa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA047FStampaTimbMensa.qbndRilevatoreIBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  S:String;
  i:integer;
begin
  S:='';
  if A047FDialogStampa.chkNominativi.Checked then
    S:='Badge: ' + RepR.DataSet.FieldByName('Badge').AsString + ' ' +
       'Nominativo: ' + A047FTimbMensadTm1.TabellaStampa.FieldByName('Nome').AsString;
  if A047FDialogStampa.chkRilevatori.Checked then
    S:=S + ' Ril: ' + RepR.DataSet.FieldByName('Rilevatore').AsString + ' ' + RepR.DataSet.FieldByName('Descrizione').AsString;
  if A047FDialogStampa.chkCausale.Checked then
  begin
    if S <> '' then
      S:=S + ' - ';
    S:=S + 'Caus: ' + RepR.DataSet.FieldByName('Causale').AsString;
  end;
  qlblRilevatore.Caption:=S;
  qlblRilevatoreTot.Caption:=S;
  with A047FDialogStampa do
  begin
    QRLGruppo.Caption:='';
    for i:=Low(MyCampiRaggr) to High(MyCampiRaggr) do
    begin
      if Trim(QRLGruppo.Caption) <> '' then
        QRLGruppo.Caption:=QRLGruppo.Caption + CRLF;//', ';
      QRLGruppo.Caption:=QRLGruppo.Caption + MyCampiRaggr[i].NomeLogico + ': ' +  A047FTimbMensaDtM1.TabellaStampa.FieldByName('GRUPPO' + IntToStr(i)).AsString
    end;
  end;
end;

procedure TA047FStampaTimbMensa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotPasti:=0;
  TotPasti2:=0;
  TotAccessi:=0;
  if not A047FDialogStampa.chkNominativi.Checked then
    StampaNome:=True
  else
    StampaNome:=False;
  qlblBadge2.Caption:=RepR.DataSet.FieldByName('BADGE').AsString;
  qlblNome2.Caption:=RepR.DataSet.FieldByName('NOME').AsString;
end;

procedure TA047FStampaTimbMensa.QRBDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qlblMatricola.Enabled:=StampaNome;
  qlblBadge.Enabled:=StampaNome;
  qlblNome.Enabled:=StampaNome;
  StampaNome:=False;
  TotPasti:=TotPasti + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiCon').AsInteger;
  TotPasti2:=TotPasti2 + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiInt').AsInteger;
  TotAccessi:=TotAccessi + A047FTimbMensaDtM1.TabellaStampa.FieldByName('Accessi').AsInteger;

  TotRilPasti:=TotRilPasti + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiCon').AsInteger;
  TotRilPasti2:=TotRilPasti2 + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiInt').AsInteger;
  TotRilAccessi:=TotRilAccessi + A047FTimbMensaDtM1.TabellaStampa.FieldByName('Accessi').AsInteger;

  TotSumPasti:=TotSumPasti + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiCon').AsInteger;
  TotSumPasti2:=TotSumPasti2 + A047FTimbMensaDtM1.TabellaStampa.FieldByName('PastiInt').AsInteger;
  TotSumAccessi:=TotSumAccessi + A047FTimbMensaDtM1.TabellaStampa.FieldByName('Accessi').AsInteger;

  PrintBand:=A047FDialogStampa.chkDettaglioGiornaliero.Checked and
             A047FDialogStampa.chkDatiIndividuali.Checked;
  QRBChild.Enabled:=PrintBand and A047FDialogStampa.chkTimbraturePresenza.Checked and
                    (A047FTimbMensaDtM1.TabellaStampa.FieldByName('TimbPresenza').AsString <> '') and
                    (A047FTimbMensaDtM1.TabellaStampa.FieldByName('AnomMensa').AsString <> '');
  ChildGiustificativi.Enabled:=PrintBand and A047FDialogStampa.chkGiustificativiAssenza.Checked and
                    (A047FTimbMensaDtM1.TabellaStampa.FieldByName('Giustificativi').AsString <> '') and
                    (A047FTimbMensaDtM1.TabellaStampa.FieldByName('AnomMensa').AsString <> '');
end;

procedure TA047FStampaTimbMensa.QRBTotaliBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLTotPasti.Caption:=IntToStr(TotPasti);
  QRLTotPasti2.Caption:=IntToStr(TotPasti2);
  QRLTotAccessi.Caption:=IntToStr(TotAccessi);
end;

procedure TA047FStampaTimbMensa.qbndRilevatorePBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qlblRilPasti.Caption:=IntToStr(TotRilPasti);
  qlblRilPasti2.Caption:=IntToStr(TotRilPasti2);
  qlblRilAccessi.Caption:=IntToStr(TotRilAccessi);
end;

procedure TA047FStampaTimbMensa.qbndSommarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qlblSumPasti.Caption:=IntToStr(TotSumPasti);
  qlblSumPasti2.Caption:=IntToStr(TotSumPasti2);
  qlblSumAccessi.Caption:=IntToStr(TotSumAccessi);
end;

procedure TA047FStampaTimbMensa.qbndRilevatorePAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  TotRilPasti:=0;
  TotRilPasti2:=0;
  TotRilAccessi:=0;
end;

procedure TA047FStampaTimbMensa.QRLGruppoPrint(sender: TObject;
  var Value: String);
begin
//  if Trim(A047FDialogStampa.dbCmbCampoRaggr.Text) <> '' then
//    Value:=A047FDialogStampa.NomeCampo + ': ' + A047FTimbMensaDtM1.TabellaStampa.FieldByName('GRUPPO').AsString;  //Lorena 27/07/2005
end;

end.
