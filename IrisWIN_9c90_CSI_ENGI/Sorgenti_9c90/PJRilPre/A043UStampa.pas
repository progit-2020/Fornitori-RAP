unit A043UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, QueryStorico, A000UCostanti, A000USessione,A000UInterfaccia,
  RegistrazioneLog, DB, Printers, Variants, QRExport, QRWebFilt, QRPDFFilt;

type
  TA043FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup2: TQRGroup;
    QRBDettaglio: TQRBand;
    QRDBTProg: TQRDBText;
    QRBFooter: TQRBand;
    QRDBText1: TQRDBText;
    QRDBTOreLavorate: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    lblTotDurata: TQRLabel;
    lblTotOreLav: TQRLabel;
    lblTotDiff: TQRLabel;
    lblTotOreNormali: TQRLabel;
    lblTotOreMagg: TQRLabel;
    lblTotOreNonMagg: TQRLabel;
    QRLGiorno: TQRLabel;
    QRLEnte: TQRLabel;
    QRDBText2: TQRDBText;
    QRLRaggruppamento: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText8: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLIntGiorno: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    lblTurno: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText9: TQRDBText;
    lblTurniInteri: TQRLabel;
    lblTurniInOre: TQRLabel;
    lblMesePrec: TQRLabel;
    lblUnitaTurno: TQRLabel;
    lblAnomalia: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    QDBTextGettRep: TQRDBText;
    LblTotGettRep: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBOltreMax: TQRDBText;
    LblTotOltreMax: TQRLabel;
    QRLabel10: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBFooterBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRLRaggruppamentoPrint(sender: TObject; var Value: String);
  private
    { Private declarations }
    function GetGiorno(Data : TDateTime) : String;
  public
    { Public declarations }
    CampoRagg : String;
    NomeCampo : String;
    TipoStampa : Integer;
    procedure CreaReport(Preview:Boolean);
  end;

var
  A043FStampa: TA043FStampa;

implementation

uses A043UDialogStampa;

{$R *.DFM}

procedure TA043FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  with A043FDialogStampa.A043MW do
  begin
    RepR.PrinterSettings.UseStandardprinter:=TipoModulo = 'COM';
    RepR.DataSet:=TabellaStampa;
    QRDBTProg.DataSet:=TabellaStampa;
    QRDBText8.DataSet:=TabellaStampa;
    QRDBText9.DataSet:=TabellaStampa;
    QRDBText1.DataSet:=TabellaStampa;
    QRDBTOreLavorate.DataSet:=TabellaStampa;
    QRDBText3.DataSet:=TabellaStampa;
    QRDBText4.DataSet:=TabellaStampa;
    QRDBText5.DataSet:=TabellaStampa;
    QRDBText6.DataSet:=TabellaStampa;
    QRDBText2.DataSet:=TabellaStampa;
    QRDBText7.DataSet:=TabellaStampa;
    QDBTextGettRep.DataSet:=TabellaStampa;
    QRDBOltreMax.DataSet:=TabellaStampa;
  end;
end;

procedure TA043FStampa.CreaReport(Preview:Boolean);
begin
  if CampoRagg <> '' then
  begin
    QRLRaggruppamento.Caption:=NomeCampo;
    QRLRaggruppamento.Enabled:=True;
  end
  else
    QRLRaggruppamento.Enabled:=False;
  QRGroup2.ForceNewPage:=False;
  QRGroup2.Expression:='Progressivo';
  if A043FDialogStampa.chkSaltoPagina.Checked and (TipoStampa = 0) then
    QRGroup2.ForceNewPage:=True;
  RepR.Page.Orientation:=poLandScape;
  with A043FDialogStampa.A043MW do
    if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
    begin
      RepR.ShowProgress:=False;
      RepR.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else if Preview then
      RepR.Preview
    else
      RepR.Print;
end;

procedure TA043FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption:='Indennità di reperibilità - ' + IfThen(TipoStampa = 0,'Dettaglio','Riepilogo') + ' di ' + FormatDateTime('mmmm yyyy',A043FDialogStampa.DataI);
  A043FDialogStampa.A043MW.AzzeraContatori;
  if TipoStampa = 0 then
  begin
    QRLIntGiorno.Enabled:=True;
    lblTurno.Enabled:=True;
  end
  else
  begin
    QRLIntGiorno.Enabled:=False;
    lblTurno.Enabled:=False;
  end;
end;

function TA043FStampa.GetGiorno(Data : TDateTime) : String;
var A,M,G : Word;
begin
  Result:='';
  DecodeDate(Data,A,M,G);
  case DayOfWeek(Data) of
    1:Result:='do';
    2:Result:='lu';
    3:Result:='ma';
    4:Result:='me';
    5:Result:='gi';
    6:Result:='ve';
    7:Result:='sa';
  end;
  if G < 10 then
    Result:=Result + ' 0'+ inttostr(G) // concateno zero non significativo
  else
    Result:=Result + ' '+ inttostr(G);
end;

procedure TA043FStampa.QRGroup2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
{Gestione spezzoni mese precedente}
begin
  A043FDialogStampa.A043MW.AzzeraContatori;
  ChildBand1.Enabled:=True;
  if A043FDialogStampa.chkSoloAnomalie.Checked and
    (A043FDialogStampa.A043MW.lstAnomalie.IndexOf(A043FDialogStampa.A043MW.TabellaStampa.FieldByName('Progressivo').AsString) = -1) then
  begin
    PrintBand:=False;
    ChildBand1.Enabled:=False;
  end;
end;

procedure TA043FStampa.QRBDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A043FDialogStampa.A043MW do
  begin
    QRLGiorno.Caption:=GetGiorno(TabellaStampa.FieldByName('Data').Value);
    CumuloGiornaliero;
    PrintBand:=TipoStampa = 0;
    if A043FDialogStampa.chkSoloAnomalie.Checked and (Trim(TabellaStampa.FieldByName('Anomalia').AsString) = '') then
      PrintBand:=False;
  end;
end;

procedure TA043FStampa.QRBFooterBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
begin
  if A043FDialogStampa.chkSpezzoniMese.Checked then
    A043FDialogStampa.A043MW.CumulaMesePrecedente(A043FDialogStampa.A043MW.TabellaStampa.FieldByName('Progressivo').AsInteger);
  lblMesePrec.Enabled:=A043FDialogStampa.chkSpezzoniMese.Checked;
  lblTotDurata.Caption:='';
  LblTotGettRep.Caption:='';
  lblTotDiff.Caption:='';
  lblTotOreLav.Caption:='';
  lblTotOreNormali.Caption:='';
  LblTotOltreMax.Caption:='';
  lblTotOreMagg.Caption:='Maggiorate';
  lblTotOreNonMagg.Caption:='Non maggiorate';
  lblUnitaTurno.Caption:='Ore turno';
  lblTurniInteri.Caption:='Turni';
  lblTurniInOre.Caption:='Ore residue';
  lblMesePrec.Caption:='Residuo prec.';
  lblAnomalia.Enabled:=not A043FDialogStampa.A043MW.NessunaAnomalia;
  for i:=0 to High(A043FDialogStampa.A043MW.Riepilogo) do
    with A043FDialogStampa.A043MW.Riepilogo[i] do
    begin
      lblUnitaTurno.Caption:=lblunitaTurno.Caption + #13 + R180MinutiOre(UnitaTurno);
      lblTotDurata.Caption:=lblTotDurata.Caption + #13 + R180MinutiOre(TotDurata);
      lblTotOreLav.Caption:=lblTotOreLav.Caption + #13 + R180MinutiOre(TotOreLavorate);
      lblTotDiff.Caption:=lblTotDiff.Caption + #13 + R180MinutiOre(TotDiff);
      lblTotOreNormali.Caption:=lblTotOreNormali.Caption + #13 + R180MinutiOre(TotOreNormali);
      if TurniInteri > 0 then
        lblTurniInteri.Caption:=lblTurniInteri.Caption + #13 + Format('%-7s %3s',[VP_Turno + ':',IntToStr(TurniInteri)])
      else
        lblTurniInteri.Caption:=lblTurniInteri.Caption + #13;
      if TotGettRep > 0 then
        LblTotGettRep.Caption:=LblTotGettRep.Caption + #13#10 + Format('%-7s %3s',[VP_GettRep + ':',IntToStr(TotGettRep)])
      else
        LblTotGettRep.Caption:=LblTotGettRep.Caption + #13;
      if TotOltreMax > 0 then
        LblTotOltremax.Caption:=LblTotOltremax.Caption + #13#10 + Format('%-7s %3s',[VP_Turni_oltremax + ':',IntToStr(TotOltremax)])
      else
        LblTotOltremax.Caption:=LblTotOltremax.Caption + #13;
      if TurniInOre > 0 then
        lblTurniInOre.Caption:=lblTurniInOre.Caption + #13 + Format('%-7s %6s',[VP_Ore + ':',R180MinutiOre(TurniInOre)])
      else
        lblTurniInOre.Caption:=lblTurniInOre.Caption + #13;
      if TotOreMagg > 0 then
        lblTotOreMagg.Caption:=lblTotOreMagg.Caption + #13 + Format('%-7s %6s',[VP_Maggiorate + ':',R180MinutiOre(TotOreMagg)])
      else
        lblTotOreMagg.Caption:=lblTotOreMagg.Caption + #13;
      if TotOreNonMagg > 0 then
        lblTotOreNonMagg.Caption:=lblTotOreNonMagg.Caption + #13 + Format('%-7s %6s',[VP_NonMaggiorate + ':',R180MinutiOre(TotOreNonMagg)])
      else
        lblTotOreNonMagg.Caption:=lblTotOreNonMagg.Caption + #13;
      if ResiduoPrec > 0 then
        lblMesePrec.Caption:=lblMesePrec.Caption + #13 + R180MinutiOre(ResiduoPrec)
      else
        lblMesePrec.Caption:=lblMesePrec.Caption + #13;
    end;
  QRBFooter.Frame.DrawTop:=TipoStampa = 0;
  if A043FDialogStampa.A043MW.NessunaAnomalia and A043FDialogStampa.chkSoloAnomalie.Checked then
    PrintBand:=False;
end;


procedure TA043FStampa.QRLRaggruppamentoPrint(sender: TObject; var Value: String);
begin
  Value:=NomeCampo + ': ' + A043FDialogStampa.A043MW.TabellaStampa.FieldByName('GRUPPO').AsString;
end;

end.
