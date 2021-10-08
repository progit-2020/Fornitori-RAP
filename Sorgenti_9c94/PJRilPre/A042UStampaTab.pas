unit A042UStampaTab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, QRExport,
  QRWebFilt, QRPDFFilt;


type
  TA042FStampaTab = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLFascia: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBTGruppo: TQRDBText;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLPres: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLIntesta: TQRLabel;
    QRLIntestaG: TQRLabel;
    QRLIntestaF: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DaData,AData : TDateTime;
    DaOra,AOra : String;
    procedure CreaReport;
  end;

var
  A042FStampaTab: TA042FStampaTab;

implementation

uses A042UDialogStampa, A042UStampaPreAssDtM1, A042UStampaPreAssMW;

{$R *.DFM}

procedure TA042FStampaTab.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var datacorr,DataPas:TDateTime;
    gg,se,fe:string;
    mese,giorno,anno:integer;
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
  gg:='|';
  se:='|';
  fe:='|';
  datacorr:=DaData;
  anno:=StrToInt(FormatDateTime('yyyy',datacorr));
  DataPas:=CalcolaPasqua(Anno);
  while datacorr<=AData do
    begin
    giorno:=StrToInt(FormatDateTime('d',datacorr));
    mese:=StrToInt(FormatDateTime('m',datacorr));
    anno:=StrToInt(FormatDateTime('yyyy',datacorr));
    // controlla i giorni festivi
    if (Datacorr=DataPas) or (Datacorr=DataPas+1) then
      fe:=fe+'**|'
    else
      if Festivo(giorno,mese,anno) then
        fe:=fe+'**|'
      else
        fe:=fe+'  |';
    gg:=gg+FormatDateTime('dd',datacorr)+'|';
    se:=se+Copy(FormatDateTime('dddd',datacorr),1,2)+'|';
    datacorr:=datacorr + 1;
    end;
  QRLIntesta.Caption:=gg;
  QRLIntestaG.Caption:=Se;
  QRLIntestaF.Caption:=Fe;
end;

procedure TA042FStampaTab.CreaReport;
begin
  with A042FDialogStampa do
  begin
    if A042FStampaPreAssDtM1.A042MW.ListaIntestazione.Text <> '' then
    begin
      QRGroup1.Expression:='Gruppo';
      QRGroup1.Enabled := True;
    end
    else
      QRGroup1.Enabled:=False;
    QRGroup1.ForceNewPage:=chkSaltoPagina.Checked;
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

procedure TA042FStampaTab.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA042FStampaTab.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var datacorr:TDateTime;
    gg,str: string;
begin
  gg:='|';
  str:=RepR.DataSet.FieldByName('PRESENZE').AsString;
  datacorr:=DaData;
  while datacorr <= AData do
    begin
    if Copy(str,trunc(datacorr-DaData+1),1)='1' then
      gg:=gg+'**|'
    else
      gg:=gg+'  |';
    datacorr:=datacorr +1;
    end;
  QRLPres.Caption:=gg;
end;

end.
