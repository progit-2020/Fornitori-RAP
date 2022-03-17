unit A092UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, R600,
  QRExport, Variants, QRWebFilt, QRPDFFilt;

type
  TA092FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel: TQRLabel;
    QRSysData3: TQRSysData;
    QRLEnte: TQRLabel;
    QRLTitolo: TQRLabel;
    QRSysData4: TQRSysData;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    ChildBand1: TQRChildBand;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRStartPage(Sender: TCustomQuickRep);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure ChildBand2AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    CampoPrec,LastMatricola: String;
  public
    { Public declarations }
    procedure CreaReport(PreView:Boolean);
  end;

var
  A092FStampa: TA092FStampa;

implementation
uses A092UStampaStorico, A092UStampaStoricoDtM1;
{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA092FStampa.ChildBand2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  LastMatricola:=A092FStampaStoricoDtM1.TabellaStampa.FieldByName('Matricola').AsString;
end;

procedure TA092FStampa.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CampoPrec:='';
end;

procedure TA092FStampa.CreaReport(PreView:Boolean);
begin
  A092FStampaStorico.FlagStatus:=True;
  if (Trim(A092FStampaStorico.DocumentoPDF) <> '') and (Trim(A092FStampaStorico.DocumentoPDF) <> '<VUOTO>') and (Trim(A092FStampaStorico.TipoModulo) = 'COM')then
  begin
    RepR.ShowProgress:=False;
    RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A092FStampaStorico.DocumentoPDF));
  end
  else if PreView then
    RepR.Preview
  else
    RepR.Print;
  A092FStampaStorico.FlagStatus:=False;
end;

procedure TA092FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

//------------------------------------------------------------------------------
procedure TA092FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption := 'Stampa storicizzazioni dal ' + DateToStr(A092FStampaStorico.DaData) +
                       ' al '+DateToStr(A092FStampaStorico.AData);
  QrGroup1.ForceNewPage:=A092FStampaStorico.chkSaltoPagina.Checked;
  LastMatricola:='';
end;

procedure TA092FStampa.RepRStartPage(Sender: TCustomQuickRep);
begin
  ChildBand2.Enabled:=LastMatricola = A092FStampaStoricoDtM1.TabellaStampa.FieldByName('Matricola').AsString;
  ChildBand3.Enabled:=LastMatricola = A092FStampaStoricoDtM1.TabellaStampa.FieldByName('Matricola').AsString;
end;

procedure TA092FStampa.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if CampoPrec <> A092FStampaStoricoDtm1.TabellaStampa.FieldByName('Campo').AsString then
    begin
    CampoPrec:=A092FStampaStoricoDtm1.TabellaStampa.FieldByName('Campo').AsString;
    QrLabel.Caption:=CampoPrec;
    end
  else
    QrLabel.Caption:='';
end;

procedure TA092FStampa.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  LastMatricola:=A092FStampaStoricoDtM1.TabellaStampa.FieldByName('Matricola').AsString;
end;

procedure TA092FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  CampoPrec:='';
end;

end.

