unit Ac04UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, quickrpt, ExtCtrls, Qrctrls, Variants, QRExport, QRWebFilt, QRPDFFilt,
  A000UCostanti, A000UInterfaccia, A000USessione, C180FunzioniGenerali;

type
  TAc04FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRLEnte: TQRLabel;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    bndIntestazione: TQRGroup;
    bndTotali: TQRBand;
    bndColonne: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    dlblReportingPeriod: TQRDBText;
    dlblDescProgetto: TQRDBText;
    dlblCodProgetto: TQRDBText;
    dlblPartnerName: TQRDBText;
    dlblPartnerNumber: TQRDBText;
    dlblNominativoResp: TQRDBText;
    dlblPeriodoStampa: TQRDBText;
    dlblNominativoDip: TQRDBText;
    dlblServizio: TQRDBText;
    dlblFunzione: TQRDBText;
    qlblGiorno: TQRLabel;
    qlblTotAtt: TQRLabel;
    dlblDescProgetto2: TQRDBText;
    qlblTotGG: TQRLabel;
    qlblAssMalattie: TQRLabel;
    qlblAssFestivita: TQRLabel;
    qlblAssFerie: TQRLabel;
    qlblAssAltre: TQRLabel;
    QRShape9: TQRShape;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape10: TQRShape;
    qlblAltriProgetti: TQRLabel;
    bndDettGG: TQRSubDetail;
    dlblDescGiorno: TQRDBText;
    dlblGiorno: TQRDBText;
    dlblAtt1HH: TQRDBText;
    dlblAtt2HH: TQRDBText;
    dlblAtt3HH: TQRDBText;
    dlblAtt4HH: TQRDBText;
    dlblAtt5HH: TQRDBText;
    dlblAtt6HH: TQRDBText;
    dlblAtt7HH: TQRDBText;
    dlblAtt8HH: TQRDBText;
    dlblAtt9HH: TQRDBText;
    dlblTotAttGG: TQRDBText;
    dlblPro1HH: TQRDBText;
    dlblPro2HH: TQRDBText;
    dlblPro3HH: TQRDBText;
    dlblTotProGG: TQRDBText;
    dlblAssMalattie: TQRDBText;
    dlblAssFestivita: TQRDBText;
    dlblAssFerie: TQRDBText;
    dlblAssAltre: TQRDBText;
    dlblTotGG: TQRDBText;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape35: TQRShape;
    bndFirme: TQRChildBand;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    dlblAtt1Cod: TQRDBText;
    dlblAtt2Cod: TQRDBText;
    dlblAtt3Cod: TQRDBText;
    dlblAtt4Cod: TQRDBText;
    dlblAtt5Cod: TQRDBText;
    dlblAtt6Cod: TQRDBText;
    dlblAtt7Cod: TQRDBText;
    dlblAtt8Cod: TQRDBText;
    dlblAtt9Cod: TQRDBText;
    dlblTotAtt1: TQRDBText;
    dlblTotAtt2: TQRDBText;
    dlblTotAtt3: TQRDBText;
    dlblTotAtt4: TQRDBText;
    dlblTotAtt5: TQRDBText;
    dlblTotAtt6: TQRDBText;
    dlblTotAtt7: TQRDBText;
    dlblTotAtt8: TQRDBText;
    dlblTotAtt9: TQRDBText;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    qlblTotMM: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape19: TQRShape;
    dlblTotAttMM: TQRDBText;
    dlblPro1Cod: TQRDBText;
    dlblPro2Cod: TQRDBText;
    dlblPro3Cod: TQRDBText;
    dlblTotPro1: TQRDBText;
    dlblTotPro2: TQRDBText;
    dlblTotPro3: TQRDBText;
    dlblTotProMM: TQRDBText;
    dlblTotMM: TQRDBText;
    QRSysData1: TQRSysData;
    dlblAtt10HH: TQRDBText;
    dlblAtt10Cod: TQRDBText;
    dlblTotAtt10: TQRDBText;
    QRShape20: TQRShape;
    qlblNonRend: TQRLabel;
    dlblNonRend: TQRDBText;
    dlblTotNonRend: TQRDBText;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape8: TQRShape;
    qlblTotPro: TQRLabel;
    dlblPro4Cod: TQRDBText;
    dlblPro4HH: TQRDBText;
    dlblTotPro4: TQRDBText;
    dlblPro5HH: TQRDBText;
    dlblPro5Cod: TQRDBText;
    dlblTotPro5: TQRDBText;
    procedure dlblAtt1HHPrint(sender: TObject; var Value: string);
    procedure bndIntestazioneAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure bndDettGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure dlblGiornoPrint(sender: TObject; var Value: string);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RepRAfterPreview(Sender: TObject);
    procedure RepRAfterPrint(Sender: TObject);
  private
    { Private declarations }
    ThousandSepOri: Char;
  public
    { Public declarations }
    procedure SettaDataset;
  end;

var
  Ac04FStampa: TAc04FStampa;

implementation

uses Ac04UStampaRendiProj,Ac04UStampaRendiProjDM;
{$R *.DFM}

//------------------------------------------------------------------------------
procedure TAc04FStampa.SettaDataset;
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    //testata
    RepR.DataSet:=cdsStampaAnagrafico;
    dlblReportingPeriod.DataSet:=RepR.DataSet;
    dlblPeriodoStampa.DataSet:=RepR.DataSet;
    dlblDescProgetto.DataSet:=RepR.DataSet;
    dlblDescProgetto2.DataSet:=RepR.DataSet;
    dlblCodProgetto.DataSet:=RepR.DataSet;
    dlblPartnerName.DataSet:=RepR.DataSet;
    dlblPartnerNumber.DataSet:=RepR.DataSet;
    dlblNominativoDip.DataSet:=RepR.DataSet;
    dlblServizio.DataSet:=RepR.DataSet;
    dlblFunzione.DataSet:=RepR.DataSet;
    dlblNominativoResp.DataSet:=RepR.DataSet;
    dlblAtt1Cod.DataSet:=RepR.DataSet;
    dlblAtt2Cod.DataSet:=RepR.DataSet;
    dlblAtt3Cod.DataSet:=RepR.DataSet;
    dlblAtt4Cod.DataSet:=RepR.DataSet;
    dlblAtt5Cod.DataSet:=RepR.DataSet;
    dlblAtt6Cod.DataSet:=RepR.DataSet;
    dlblAtt7Cod.DataSet:=RepR.DataSet;
    dlblAtt8Cod.DataSet:=RepR.DataSet;
    dlblAtt9Cod.DataSet:=RepR.DataSet;
    dlblAtt10Cod.DataSet:=RepR.DataSet;
    dlblTotAtt1.DataSet:=RepR.DataSet;
    dlblTotAtt2.DataSet:=RepR.DataSet;
    dlblTotAtt3.DataSet:=RepR.DataSet;
    dlblTotAtt4.DataSet:=RepR.DataSet;
    dlblTotAtt5.DataSet:=RepR.DataSet;
    dlblTotAtt6.DataSet:=RepR.DataSet;
    dlblTotAtt7.DataSet:=RepR.DataSet;
    dlblTotAtt8.DataSet:=RepR.DataSet;
    dlblTotAtt9.DataSet:=RepR.DataSet;
    dlblTotAtt10.DataSet:=RepR.DataSet;
    dlblTotAttMM.DataSet:=RepR.DataSet;
    dlblPro1Cod.DataSet:=RepR.DataSet;
    dlblPro2Cod.DataSet:=RepR.DataSet;
    dlblPro3Cod.DataSet:=RepR.DataSet;
    dlblPro4Cod.DataSet:=RepR.DataSet;
    dlblPro5Cod.DataSet:=RepR.DataSet;
    dlblTotPro1.DataSet:=RepR.DataSet;
    dlblTotPro2.DataSet:=RepR.DataSet;
    dlblTotPro3.DataSet:=RepR.DataSet;
    dlblTotPro4.DataSet:=RepR.DataSet;
    dlblTotPro5.DataSet:=RepR.DataSet;
    dlblTotNonRend.DataSet:=RepR.DataSet;
    dlblTotProMM.DataSet:=RepR.DataSet;
    dlblTotMM.DataSet:=RepR.DataSet;
    //dettaglio
    bndDettGG.DataSet:=cdsStampaDettaglio;
    dlblDescGiorno.DataSet:=bndDettGG.DataSet;
    dlblGiorno.DataSet:=bndDettGG.DataSet;
    dlblAtt1HH.DataSet:=bndDettGG.DataSet;
    dlblAtt2HH.DataSet:=bndDettGG.DataSet;
    dlblAtt3HH.DataSet:=bndDettGG.DataSet;
    dlblAtt4HH.DataSet:=bndDettGG.DataSet;
    dlblAtt5HH.DataSet:=bndDettGG.DataSet;
    dlblAtt6HH.DataSet:=bndDettGG.DataSet;
    dlblAtt7HH.DataSet:=bndDettGG.DataSet;
    dlblAtt8HH.DataSet:=bndDettGG.DataSet;
    dlblAtt9HH.DataSet:=bndDettGG.DataSet;
    dlblAtt10HH.DataSet:=bndDettGG.DataSet;
    dlblTotAttGG.DataSet:=bndDettGG.DataSet;
    dlblPro1HH.DataSet:=bndDettGG.DataSet;
    dlblPro2HH.DataSet:=bndDettGG.DataSet;
    dlblPro3HH.DataSet:=bndDettGG.DataSet;
    dlblPro4HH.DataSet:=bndDettGG.DataSet;
    dlblPro5HH.DataSet:=bndDettGG.DataSet;
    dlblNonRend.DataSet:=bndDettGG.DataSet;
    dlblTotProGG.DataSet:=bndDettGG.DataSet;
    dlblAssMalattie.DataSet:=bndDettGG.DataSet;
    dlblAssFestivita.DataSet:=bndDettGG.DataSet;
    dlblAssFerie.DataSet:=bndDettGG.DataSet;
    dlblAssAltre.DataSet:=bndDettGG.DataSet;
    dlblTotGG.DataSet:=bndDettGG.DataSet;
  end;
end;

procedure TAc04FStampa.bndDettGGBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  bndDettGG.Color:=clWhite;
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
    if (cdsStampaDettaglio.FieldByName('DESC_GIORNO').AsString = 'Sat')
    or (cdsStampaDettaglio.FieldByName('DESC_GIORNO').AsString = 'Sun')
    or (cdsStampaDettaglio.FieldByName('ASS_FESTIVITA').AsString = 'X') then
      bndDettGG.Color:=clMenu;
end;

procedure TAc04FStampa.bndIntestazioneAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    cdsStampaDettaglio.Filtered:=False;
    cdsStampaDettaglio.Filter:='(PROGRESSIVO = ' + cdsStampaAnagrafico.FieldByName('PROGRESSIVO').AsString + ') AND (ID_T750 = ' + cdsStampaAnagrafico.FieldByName('ID_T750').AsString + ')';
    cdsStampaDettaglio.Filtered:=True;
  end;
end;

procedure TAc04FStampa.dlblGiornoPrint(sender: TObject; var Value: string);
begin
  Value:=Copy(Value,1,2);
end;

procedure TAc04FStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
end;

procedure TAc04FStampa.dlblAtt1HHPrint(sender: TObject; var Value: string);
begin
  if Value <> '' then
    Value:=R180MinutiOre(StrToInt(Value));
end;

procedure TAc04FStampa.RepRAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.RepRAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TAc04FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator <> #0 then
    ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator
  else
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
  if RepR.Exporting and (RepR.ExportFilter is TQRXLSFilter) then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
  QRLEnte.Caption:=Parametri.DAzienda;
end;

end.
