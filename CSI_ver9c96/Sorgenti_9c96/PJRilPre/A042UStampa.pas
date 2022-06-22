unit A042UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, C700USelezioneAnagrafe,
  QRExport, QRWebFilt, QRPDFFilt;

type
  TA042FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBGruppo: TQRGroup;
    QRBData: TQRGroup;
    QRBand1: TQRBand;
    QRDBTGruppo: TQRDBText;
    QRLData: TQRLabel;
    QRDBTData: TQRDBText;
    QRDBTNome: TQRDBText;
    QRBIntestazione: TQRBand;
    QRDBTCognome: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLFascia: TQRLabel;
    lblTimbGiust: TQRLabel;
    QRDBTDettData: TQRDBText;
    QRLIntData: TQRLabel;
    QRBTotaliGruppo: TQRBand;
    QRDBText1: TQRDBText;
    QRLGruppoTotDip: TQRLabel;
    QRBTotali: TQRBand;
    QRLTotDip: TQRLabel;
    QRLDettaglio: TQRLabel;
    QRLIntDettaglio: TQRLabel;
    QRBTotaliData: TQRBand;
    QRLDataTotDip: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBTotaliDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBTotaliBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBGruppoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBTotaliGruppoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBDataBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TotData:Integer;
    ContaDip,ContaGruppo:array of Integer;
  public
    { Public declarations }
    DaData,AData : TDateTime;
    DaOra,AOra : String;
    procedure CreaReport;
  end;

var
  A042FStampa: TA042FStampa;

implementation

uses A042UDialogStampa, A042UStampaPreAssDtM1, A042UGrafico, A042UStampaPreAssMW;

{$R *.DFM}

procedure TA042FStampa.CreaReport;
var j,L:Integer;
    TrovatoCogn:Boolean;
begin
  SetLength(ContaDip,0);
  SetLength(ContaGruppo,0);
  with A042FDialogStampa do
  begin
    //Se cognome è fleggato come raggruppamento lo rendo invisibile nella stampa
    TrovatoCogn:=False;
    for j:=0 to chkLIntestazione.Items.Count-1 do                               
      if (chkLIntestazione.Items[j] = 'COGNOME') and (chkLIntestazione.Checked[j]) then
        TrovatoCogn:=True;
    QRDBTCognome.Enabled:=Not TrovatoCogn;
    QRDBTNome.Enabled:=Not TrovatoCogn;
    QRLabel1.Enabled:=Not TrovatoCogn;
    QRLabel2.Enabled:=Not TrovatoCogn;

    QRBGruppo.Enabled:=A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text <> '';
    if QRBGruppo.Enabled then
      QRBGruppo.Expression:='Gruppo';
    QRBData.Enabled:=chkRaggData.Checked;
    QRLIntData.Enabled:=not chkRaggData.Checked;
    QRDBTDettData.Enabled:=not chkRaggData.Checked;
    QRLIntDettaglio.Enabled:=A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Text <> '';
    if QRLIntDettaglio.Enabled then
    begin
      QRLIntDettaglio.Caption:='';
      for j:=0 to A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Count -1 do
      begin
        if Length(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_CAMPO',A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Strings[j],'NOME_LOGICO'))) > C700SelAnagrafe.FieldByName(A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Strings[j]).Size then
          L:=Length(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_CAMPO',A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Strings[j],'NOME_LOGICO')))
        else
          L:=C700SelAnagrafe.FieldByName(A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Strings[j]).Size;
        QRLIntDettaglio.Caption:=QRLIntDettaglio.Caption +
          Format('%-*s',[L+2,Copy(VarToStr(A042FStampaPreAssDtM1.A042MW.selI010.Lookup('NOME_CAMPO',A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Strings[j],'NOME_LOGICO')),1,L)]);
      end;
    end;
    QRLDettaglio.Enabled:=A042FStampaPreAssDtM1.A042MW.ListaDettaglio.Text <> '';
    if QRBData.Enabled then
    begin
      QRBData.Expression:='Data';
      QRLData.Caption:='';
      QRDBTData.DataField:='Data';
    end;
    QRBTotaliGruppo.Enabled:=chkTotaliGruppo.Checked;
    QRBTotaliData.Enabled:=chkTotaliData.Checked;
    QRBTotali.Enabled:=chkTotali.Checked;
    QRBGruppo.ForceNewPage:=chkSaltoPagina.Checked;
    QRBData.ForceNewPage:=chkSaltoPaginaData.Checked;
    Screen.Cursor:=crDefault;
    if (Trim(A042FDialogStampa.DocumentoPDF) <> '') and (Trim(A042FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A042FDialogStampa.TipoModulo) = 'COM')then
    begin
        RepR.ShowProgress:=False;
        RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A042FDialogStampa.DocumentoPDF));
    end
    else if Anteprima then
      RepR.Preview
    else
      RepR.Print;
  end;
end;

procedure TA042FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  case A042FDialogStampa.rgpTipoStampa.ItemIndex of
    0:begin
       QRLTitolo.Caption := 'Presenti dal ' + FormatDateTime('dd mmmm yyyy',DaData)+
                            ' al ' +FormatDateTime('dd mmmm yyyy',AData);
       QRLFascia.Caption := 'Dalle ore: '+DaOra + ' alle ore: ' + AOra;
      end;
    1:begin
       QRLTitolo.Caption := 'Assenti dal ' + FormatDateTime('dd mmmm yyyy',DaData)+
                            ' al ' +FormatDateTime('dd mmmm yyyy',AData);
       QRLFascia.Caption := '';
      end;
    2:begin
       QRLTitolo.Caption := 'Assenti senza giustificativi dal ' + FormatDateTime('dd mmmm yyyy',DaData)+
                            ' al ' +FormatDateTime('dd mmmm yyyy',AData);
       QRLFascia.Caption := '';
      end;
  end;
end;

procedure TA042FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA042FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var Trovato:Boolean;
  i:Integer;
begin
  lblTimbGiust.Caption:='';
  with A042FStampaPreAssDtM1.A042MW do
  begin
    if TabellaStampa.FieldByName('Timb1').AsString <> '' then
      lblTimbGiust.Caption:=TabellaStampa.FieldByName('Timb1').AsString;
    if TabellaStampa.FieldByName('Giust1').AsString <> '' then
      lblTimbGiust.Caption:=TabellaStampa.FieldByName('Giust1').AsString;
    if TabellaStampa.FieldByName('Dettaglio').AsString <> '' then
      QRLDettaglio.Caption:=TabellaStampa.FieldByName('Dettaglio').AsString
    else
      QRLDettaglio.Caption:='';
    Trovato:=False;
    for i:=0 to High(ContaDip) do
      if ContaDip[i] = TabellaStampa.FieldByName('Progressivo').AsInteger then
        Trovato:=True;
    if not Trovato then
    begin
      SetLength(ContaDip,Length(ContaDip) + 1);
      ContaDip[High(ContaDip)]:=TabellaStampa.FieldByName('Progressivo').AsInteger;
    end;
    Trovato:=False;
    for i:=0 to High(ContaGruppo) do
      if ContaGruppo[i] = TabellaStampa.FieldByName('Progressivo').AsInteger then
        Trovato:=True;
    if not Trovato then
    begin
      SetLength(ContaGruppo,Length(ContaGruppo) + 1);
      ContaGruppo[High(ContaGruppo)]:=TabellaStampa.FieldByName('Progressivo').AsInteger;
    end;
  end;
  inc(TotData);
end;

procedure TA042FStampa.QRBDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLData.Caption:=FormatDateTime('dddd',RepR.DataSet.FieldByName('DATA').AsDateTime);
  TotData:=0;
end;

procedure TA042FStampa.QRBTotaliGruppoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLGruppoTotDip.Caption:='Totale dipendenti: ' + IntToStr(Length(ContaGruppo));
end;

procedure TA042FStampa.QRBGruppoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  SetLength(ContaGruppo,0);
end;

procedure TA042FStampa.QRBTotaliBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLTotDip.Caption:='Totale generale dipendenti: ' + IntToStr(Length(ContaDip));
end;

procedure TA042FStampa.QRBTotaliDataBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLDataTotDip.Caption:='Totale dipendenti: ' + IntToStr(TotData);
end;

end.
