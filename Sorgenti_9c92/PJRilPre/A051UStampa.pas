unit A051UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, QRExport,
  QRWebFilt, QRPDFFilt;

type
  TA051FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRBDettaglio: TQRBand;
    QRLRaggruppamento: TQRLabel;
    QRDBTGruppo: TQRDBText;
    QRDBTCogn: TQRDBText;
    QRDBTNome: TQRDBText;
    QRDBTBadge: TQRDBText;
    QRBIntestazione: TQRBand;
    QRLIntGiorno: TQRLabel;
    QRLGiorno: TQRLabel;
    QRLIntTimb: TQRLabel;
    QRDBText1: TQRDBText;
    ChildBand1: TQRChildBand;
    QRDBText2: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetGiorno(Data : TDateTime) : String;
  public
    { Public declarations }
    CampoRagg:String;
    NomeCampo:String;
    Titolo:String;
    DataI,DataF:TDateTime;
    procedure CreaReport;
  end;

var
  A051FStampa: TA051FStampa;

implementation
uses A051UTimbOrig, A051UTimbOrigDtM1;
{$R *.DFM}

procedure TA051FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

function TA051FStampa.GetGiorno(Data : TDateTime) : String;
begin
  Result:='';
  case DayOfWeek(Data) of
    1:Result:='Do';
    2:Result:='Lu';
    3:Result:='Ma';
    4:Result:='Me';
    5:Result:='Gi';
    6:Result:='Ve';
    7:Result:='Sa';
  end;
  Result:=Result + ' ' +FormatDateTime('dd',Data);
end;

//------------------------------------------------------------------------------
procedure TA051FStampa.CreaReport;
begin
  if CampoRagg <> '' then
  begin
    QRGroup1.Enabled:=True;
    QRGroup1.Expression:='Gruppo';
    QRLRaggruppamento.Caption:=NomeCampo;
    QRGroup1.ForceNewPage:=A051FTimbOrig.chkSaltoPagina.Checked;
    QRGroup2.ForceNewPage:=False;
  end
  else
  begin
    QRGroup1.Enabled:=False;
    QRGroup1.Expression:='';
    QRGroup1.ForceNewPage:=False;
    QRGroup2.ForceNewPage:=A051FTimbOrig.chkSaltoPagina.Checked;
  end;

  if (Trim(A051FTimbOrig.DocumentoPDF) <> '') and (Trim(A051FTimbOrig.DocumentoPDF) <> '<VUOTO>') and (Trim(A051FTimbOrig.TipoModulo) = 'COM')then
  begin
    RepR.ShowProgress:=False;
    RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A051FTimbOrig.DocumentoPDF));
  end
  else
    RepR.Preview;
end;

//------------------------------------------------------------------------------
procedure TA051FStampa.QRBDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A051FTimbOrigDtM1 do
  begin
    QRLGiorno.Caption:=GetGiorno(TabellaStampa.FieldByName('Data').Value);
    ChildBand1.Enabled:=TabellaStampa.FieldByName('Timb2').AsString <> '';
  end;
end;

procedure TA051FStampa.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLTitolo.Caption:=Titolo + ' del mese di ' + FormatDateTime('mmmm yyyy',DataI);
end;

end.
