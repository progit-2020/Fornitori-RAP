unit A045UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants, QRExport,
  QRWebFilt, QRPDFFilt, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TA045FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBIntestazione: TQRBand;
    QRLQualifica: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel14: TQRLabel;
    QRBDettaglio: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText38: TQRDBText;
    QRDBText40: TQRDBText;
    QRDBText42: TQRDBText;
    QRDBText44: TQRDBText;
    QRDBTDescr: TQRDBText;
    QRShape13: TQRShape;
    QRShape2: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape24: TQRShape;
    QRShape26: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRLabel120: TQRLabel;
    QRShape45: TQRShape;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel35: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRLAzienda: TQRLabel;
    QRLabel37: TQRLabel;
    QRShape84: TQRShape;
    QRLabel38: TQRLabel;
    QRLabel40: TQRLabel;
    QRShape86: TQRShape;
    QRShape89: TQRShape;
    QRShape91: TQRShape;
    QRLTipiRapporto: TQRLabel;
    QRLDaAData: TQRLabel;
    QRShape93: TQRShape;
    QRShape94: TQRShape;
    LDatiAz: TQRLabel;
    QRShape15: TQRShape;
    QRShape36: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape17: TQRShape;
    QRShape35: TQRShape;
    QRShape37: TQRShape;
    QRBand2: TQRBand;
    QRShape99: TQRShape;
    QRLabel8: TQRLabel;
    QRShape100: TQRShape;
    QRShape101: TQRShape;
    QRShape102: TQRShape;
    QRShape105: TQRShape;
    QRShape107: TQRShape;
    QRShape108: TQRShape;
    QRShape109: TQRShape;
    QRShape110: TQRShape;
    TotA2: TQRLabel;
    TotA4: TQRLabel;
    TotD2: TQRLabel;
    TotD4: TQRLabel;
    TotE2: TQRLabel;
    TotE4: TQRLabel;
    QRShape113: TQRShape;
    GGGenM: TQRLabel;
    GGGenF: TQRLabel;
    QRShape114: TQRShape;
    QRShape115: TQRShape;
    QRShape116: TQRShape;
    ChildBand2: TQRChildBand;
    DipGenF: TQRLabel;
    DipGenM: TQRLabel;
    TotE3: TQRLabel;
    TotE1: TQRLabel;
    TotD3: TQRLabel;
    TotD1: TQRLabel;
    TotA3: TQRLabel;
    TotA1: TQRLabel;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape75: TQRShape;
    QRShape81: TQRShape;
    QRShape82: TQRShape;
    QRShape83: TQRShape;
    QRShape87: TQRShape;
    QRShape88: TQRShape;
    QRShape96: TQRShape;
    QRShape97: TQRShape;
    QRShape57: TQRShape;
    QRShape98: TQRShape;
    QRShape58: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel22: TQRLabel;
    QRShape64: TQRShape;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRLabel1: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel27: TQRLabel;
    QRShape1: TQRShape;
    QRShape14: TQRShape;
    QRLabel28: TQRLabel;
    QRShape22: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRLabel32: TQRLabel;
    QRShape69: TQRShape;
    QRShape70: TQRShape;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRShape74: TQRShape;
    QRLabel36: TQRLabel;
    QRShape76: TQRShape;
    QRLabel39: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRShape90: TQRShape;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRShape95: TQRShape;
    QRDBText10: TQRDBText;
    QRDBText12: TQRDBText;
    QRShape12: TQRShape;
    QRShape65: TQRShape;
    QRShape85: TQRShape;
    QRDBText18: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText28: TQRDBText;
    QRDBText26: TQRDBText;
    QRShape117: TQRShape;
    QRShape118: TQRShape;
    QRDBText34: TQRDBText;
    QRDBText36: TQRDBText;
    QRShape122: TQRShape;
    QRShape123: TQRShape;
    QRShape124: TQRShape;
    QRDBText46: TQRDBText;
    QRDBText48: TQRDBText;
    QRShape129: TQRShape;
    TotC3: TQRLabel;
    TotC1: TQRLabel;
    QRShape130: TQRShape;
    QRShape133: TQRShape;
    TotC2: TQRLabel;
    TotC4: TQRLabel;
    QRShape134: TQRShape;
    TotF2: TQRLabel;
    TotF4: TQRLabel;
    QRShape136: TQRShape;
    TotF1: TQRLabel;
    TotF3: TQRLabel;
    QRShape138: TQRShape;
    TotG2: TQRLabel;
    TotG4: TQRLabel;
    QRShape140: TQRShape;
    TotG1: TQRLabel;
    TotG3: TQRLabel;
    TotB3: TQRLabel;
    TotB1: TQRLabel;
    QRShape142: TQRShape;
    QRShape143: TQRShape;
    QRShape144: TQRShape;
    QRShape145: TQRShape;
    TotB2: TQRLabel;
    TotB4: TQRLabel;
    TotH3: TQRLabel;
    TotH1: TQRLabel;
    QRShape146: TQRShape;
    QRShape147: TQRShape;
    QRShape148: TQRShape;
    TotH2: TQRLabel;
    TotH4: TQRLabel;
    QRShape149: TQRShape;
    QRDBText49: TQRDBText;
    QRDBText50: TQRDBText;
    ChildBand1: TQRChildBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText37: TQRDBText;
    QRDBText39: TQRDBText;
    QRDBText41: TQRDBText;
    QRDBText43: TQRDBText;
    QRShape16: TQRShape;
    QRLabel5: TQRLabel;
    QRShape21: TQRShape;
    QRShape27: TQRShape;
    QRShape38: TQRShape;
    QRShape40: TQRShape;
    QRShape42: TQRShape;
    QRShape44: TQRShape;
    QRShape46: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape54: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRShape72: TQRShape;
    QRShape78: TQRShape;
    QRDBText19: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText27: TQRDBText;
    QRDBText25: TQRDBText;
    QRShape120: TQRShape;
    QRDBText33: TQRDBText;
    QRDBText35: TQRDBText;
    QRShape125: TQRShape;
    QRShape126: TQRShape;
    QRShape127: TQRShape;
    QRDBText45: TQRDBText;
    QRDBText47: TQRDBText;
    QRShape128: TQRShape;
    QRDBText51: TQRDBText;
    QRDBText52: TQRDBText;
    QRLabel3: TQRLabel;
    QRShape3: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRShape4: TQRShape;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRShape5: TQRShape;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRShape6: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape23: TQRShape;
    QRShape25: TQRShape;
    TotI2: TQRLabel;
    TotI4: TQRLabel;
    QRShape28: TQRShape;
    TotI3: TQRLabel;
    TotI1: TQRLabel;
    QRShape29: TQRShape;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreaReport;
  end;

var
  A045FStampa: TA045FStampa;

implementation

uses A045UDialogStampa;
{$R *.DFM}

procedure TA045FStampa.CreaReport;
begin
  with A045FDialogStampa.A045MW do
  begin
    QRDBTDescr.DataField := TabellaStampa.Fields[2].FieldName;
//------- Ferie
    QRDBText1.DataField := 'NDipURagg1';
    QRDBText2.DataField := 'NGioURagg1';
    QRDBText3.DataField := 'NDipDRagg1';
    QRDBText4.DataField := 'NGioDRagg1';
//------- Malattia
    QRDBText9.DataField := 'NDipURagg2';
    QRDBText10.DataField := 'NGioURagg2';
    QRDBText11.DataField := 'NDipDRagg2';
    QRDBText12.DataField := 'NGioDRagg2';
//------- Art.42
    QRDBText5.DataField := 'NDipURagg3';
    QRDBText6.DataField := 'NGioURagg3';
    QRDBText7.DataField := 'NDipDRagg3';
    QRDBText8.DataField := 'NGioDRagg3';
//------- Legge 104
    QRDBText17.DataField := 'NDipURagg4';
    QRDBText18.DataField := 'NGioURagg4';
    QRDBText19.DataField := 'NDipDRagg4';
    QRDBText20.DataField := 'NGioDRagg4';
//------- Maternità
    QRDBText25.DataField := 'NDipURagg6';
    QRDBText26.DataField := 'NGioURagg6';
    QRDBText27.DataField := 'NDipDRagg6';
    QRDBText28.DataField := 'NGioDRagg6';
//------- Permessi
    QRDBText33.DataField := 'NDipURagg8';
    QRDBText34.DataField := 'NGioURagg8';
    QRDBText35.DataField := 'NDipDRagg8';
    QRDBText36.DataField := 'NGioDRagg8';
//------- Sciopero
    QRDBText37.DataField := 'NDipURagg10';
    QRDBText38.DataField := 'NGioURagg10';
    QRDBText39.DataField := 'NDipDRagg10';
    QRDBText40.DataField := 'NGioDRagg10';
//------- Altre ass. non retrib.
    QRDBText41.DataField := 'NDipURagg11';
    QRDBText42.DataField := 'NGioURagg11';
    QRDBText43.DataField := 'NDipDRagg11';
    QRDBText44.DataField := 'NGioDRagg11';
//------- Formazione
    QRDBText45.DataField := 'NDipURagg12';
    QRDBText46.DataField := 'NGioURagg12';
    QRDBText47.DataField := 'NDipDRagg12';
    QRDBText48.DataField := 'NGioDRagg12';
  end;
end;

procedure TA045FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  if A045FDialogStampa.sDescTipiRapporto <> '' then
    QRLTipiRapporto.Caption := 'Tipi Rapporto: ' + A045FDialogStampa.sDescTipiRapporto;
  QRLDaAData.Caption := 'Dal ' + FormatDateTime('dd mmmm yyyy',A045FDialogStampa.A045MW.DataInizio)+' al ' +FormatDateTime('dd mmmm yyyy',A045FDialogStampa.A045MW.DataFine);
  QRLAzienda.Caption:=Parametri.DAzienda;
  LDatiAz.Caption:='Anno:' + FormatDateTime('yyyy',A045FDialogStampa.A045MW.DataFine);
  if Trim(A045FDialogStampa.EdtCodAzienda.Text) <> '' then
    LDatiAz.Caption:='Azienda:' + Trim(A045FDialogStampa.EdtCodAzienda.Text) + '  ' + LDatiAz.Caption;
  if Trim(A045FDialogStampa.EdtCodRegione.Text) <> '' then
    LDatiAz.Caption:='Regione:' + Trim(A045FDialogStampa.EdtCodRegione.Text) + '  ' + LDatiAz.Caption;

  //Non visualizzo le label relative al numero di dipendenti
  ChildBand1.Enabled:=A045FDialogStampa.ChkContNumDip.Checked;
  ChildBand2.Enabled:=A045FDialogStampa.ChkContNumDip.Checked;
  QRShape64.Enabled:=not A045FDialogStampa.ChkContNumDip.Checked;
  QRShape65.Enabled:=not A045FDialogStampa.ChkContNumDip.Checked;
end;

procedure TA045FStampa.FormCreate(Sender: TObject);
begin
    RepR.useQR5Justification:=True;
    RepR.PrinterSettings.UseStandardprinter:=A045FDialogStampa.A045MW.TipoModulo='COM';
    //RepR.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    RepR.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBTDescr.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Ferie
    QRDBText1.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText2.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText3.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText4.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Malattia
    QRDBText9.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText10.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText11.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText12.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Art.42
    QRDBText5.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText6.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText7.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText8.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Legge 104
    QRDBText17.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText18.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText19.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText20.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Maternità
    QRDBText25.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText26.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText27.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText28.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Permessi
    QRDBText33.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText34.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText35.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText36.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Sciopero
    QRDBText37.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText38.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText39.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText40.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Altre ass. non retrib.
    QRDBText41.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText42.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText43.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText44.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
//------- Formazione
    QRDBText45.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText46.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText47.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText48.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;

    QRDBText49.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText50.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText51.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
    QRDBText52.DataSet:=A045FDialogStampa.A045MW.TabellaStampa;
end;

procedure TA045FStampa.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  TotA1.Caption:='0';
  TotA2.Caption:='0';
  TotA3.Caption:='0';
  TotA4.Caption:='0';
  TotC1.Caption:='0';
  TotC2.Caption:='0';
  TotC3.Caption:='0';
  TotC4.Caption:='0';
  TotI1.Caption:='0';
  TotI2.Caption:='0';
  TotI3.Caption:='0';
  TotI4.Caption:='0';
  TotF1.Caption:='0';
  TotF2.Caption:='0';
  TotF3.Caption:='0';
  TotF4.Caption:='0';
  TotG1.Caption:='0';
  TotG2.Caption:='0';
  TotG3.Caption:='0';
  TotG4.Caption:='0';
  TotB1.Caption:='0';
  TotB2.Caption:='0';
  TotB3.Caption:='0';
  TotB4.Caption:='0';
  TotD1.Caption:='0';
  TotD2.Caption:='0';
  TotD3.Caption:='0';
  TotD4.Caption:='0';
  TotE1.Caption:='0';
  TotE2.Caption:='0';
  TotE3.Caption:='0';
  TotE4.Caption:='0';
  TotH1.Caption:='0';
  TotH2.Caption:='0';
  TotH3.Caption:='0';
  TotH4.Caption:='0';
  GGGenM.Caption:='0';
  GGGenF.Caption:='0';
  DipGenM.Caption:='0';
  DipGenF.Caption:='0';
  with A045FDialogStampa.A045MW do
  begin
    //Totalizzo il num. giorni da codice e non tramite query per considerare i dati già arrotondati per qualif.
    TabellaStampa.First;
    while not TabellaStampa.Eof do
    begin
      TotA2.Caption:=FloatToStr(StrToFloatDef(TotA2.Caption,0) + TabellaStampa.FieldByName('NGioURagg1').AsFloat);
      TotA4.Caption:=FloatToStr(StrToFloatDef(TotA4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg1').AsFloat);
      TotC2.Caption:=FloatToStr(StrToFloatDef(TotC2.Caption,0) + TabellaStampa.FieldByName('NGioURagg2').AsFloat);
      TotC4.Caption:=FloatToStr(StrToFloatDef(TotC4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg2').AsFloat);
      TotI2.Caption:=FloatToStr(StrToFloatDef(TotI2.Caption,0) + TabellaStampa.FieldByName('NGioURagg3').AsFloat);
      TotI4.Caption:=FloatToStr(StrToFloatDef(TotI4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg3').AsFloat);
      TotF2.Caption:=FloatToStr(StrToFloatDef(TotF2.Caption,0) + TabellaStampa.FieldByName('NGioURagg4').AsFloat);
      TotF4.Caption:=FloatToStr(StrToFloatDef(TotF4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg4').AsFloat);
      TotG2.Caption:=FloatToStr(StrToFloatDef(TotG2.Caption,0) + TabellaStampa.FieldByName('NGioURagg6').AsFloat);
      TotG4.Caption:=FloatToStr(StrToFloatDef(TotG4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg6').AsFloat);
      TotB2.Caption:=FloatToStr(StrToFloatDef(TotB2.Caption,0) + TabellaStampa.FieldByName('NGioURagg8').AsFloat);
      TotB4.Caption:=FloatToStr(StrToFloatDef(TotB4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg8').AsFloat);
      TotD2.Caption:=FloatToStr(StrToFloatDef(TotD2.Caption,0) + TabellaStampa.FieldByName('NGioURagg10').AsFloat);
      TotD4.Caption:=FloatToStr(StrToFloatDef(TotD4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg10').AsFloat);
      TotE2.Caption:=FloatToStr(StrToFloatDef(TotE2.Caption,0) + TabellaStampa.FieldByName('NGioURagg11').AsFloat);
      TotE4.Caption:=FloatToStr(StrToFloatDef(TotE4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg11').AsFloat);
      TotH2.Caption:=FloatToStr(StrToFloatDef(TotH2.Caption,0) + TabellaStampa.FieldByName('NGioURagg12').AsFloat);
      TotH4.Caption:=FloatToStr(StrToFloatDef(TotH4.Caption,0) + TabellaStampa.FieldByName('NGioDRagg12').AsFloat);
      TabellaStampa.Next;
    end;
    //Totalizzo il num. dip da query per considerare (distinct progressivo)
    selT043TotRaggr.First;
    while not selT043TotRaggr.Eof do
    begin
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'A' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotA1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotA2.Caption := Format('%-.2f',[StrToFloatDef(TotA2.Caption,0)]);
        end
        else
        begin
          TotA3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotA4.Caption := Format('%-.2f',[StrToFloatDef(TotA4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'C' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotC1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotC2.Caption := Format('%-.2f',[StrToFloatDef(TotC2.Caption,0)]);
        end
        else
        begin
          TotC3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotC4.Caption := Format('%-.2f',[StrToFloatDef(TotC4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'I' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotI1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotI2.Caption := Format('%-.2f',[StrToFloatDef(TotI2.Caption,0)]);
        end
        else
        begin
          TotI3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotI4.Caption := Format('%-.2f',[StrToFloatDef(TotI4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'F' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotF1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotF2.Caption := Format('%-.2f',[StrToFloatDef(TotF2.Caption,0)]);
        end
        else
        begin
          TotF3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotF4.Caption := Format('%-.2f',[StrToFloatDef(TotF4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'G' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotG1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotG2.Caption := Format('%-.2f',[StrToFloatDef(TotG2.Caption,0)]);
        end
        else
        begin
          TotG3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotG4.Caption := Format('%-.2f',[StrToFloatDef(TotG4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'B' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotB1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotB2.Caption := Format('%-.2f',[StrToFloatDef(TotB2.Caption,0)]);
        end
        else
        begin
          TotB3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotB4.Caption := Format('%-.2f',[StrToFloatDef(TotB4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'D' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotD1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotD2.Caption := Format('%-.2f',[StrToFloatDef(TotD2.Caption,0)]);
        end
        else
        begin
          TotD3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotD4.Caption := Format('%-.2f',[StrToFloatDef(TotD4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'E' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotE1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotE2.Caption := Format('%-.2f',[StrToFloatDef(TotE2.Caption,0)]);
        end
        else
        begin
          TotE3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotE4.Caption := Format('%-.2f',[StrToFloatDef(TotE4.Caption,0)]);
        end;
      end;
      if selT043TotRaggr.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'H' then
      begin
        if selT043TotRaggr.FieldByName('SESSO').AsString = 'M' then
        begin
          TotH1.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotH2.Caption := Format('%-.2f',[StrToFloatDef(TotH2.Caption,0)]);
        end
        else
        begin
          TotH3.Caption := selT043TotRaggr.FieldByName('NDIP').AsString;
          TotH4.Caption := Format('%-.2f',[StrToFloatDef(TotH4.Caption,0)]);
        end;
      end;
      selT043TotRaggr.Next;
    end;
    selT043Tot.First;
    while not selT043Tot.Eof do
    begin
      if selT043Tot.FieldByName('SESSO').AsString = 'M' then
      begin
        DipGenM.Caption:=selT043Tot.FieldByName('NDIP').AsString;
        GGGenM.Caption:=FloatToStr(StrToFloatDef(TotA2.Caption,0) + StrToFloatDef(TotC2.Caption,0) + StrToFloatDef(TotI2.Caption,0) +
                        StrToFloatDef(TotF2.Caption,0) + StrToFloatDef(TotG2.Caption,0) +
                        StrToFloatDef(TotB2.Caption,0) + StrtoFloatDef(TotD2.Caption,0) +
                        StrToFloatDef(TotE2.Caption,0) + StrtoFloatDef(TotH2.Caption,0));
        GGGenM.Caption:=Format('%-.2f',[StrToFloatDef(GGGenM.Caption,0)]);
      end
      else
      begin
        DipGenF.Caption := selT043Tot.FieldByName('NDIP').AsString;
        GGGenF.Caption:=FloatToStr(StrToFloatDef(TotA4.Caption,0) + StrToFloatDef(TotC4.Caption,0) + StrToFloatDef(TotI4.Caption,0) +
                        StrToFloatDef(TotF4.Caption,0) + StrToFloatDef(TotG4.Caption,0) +
                        StrToFloatDef(TotB4.Caption,0) + StrtoFloatDef(TotD4.Caption,0) +
                        StrToFloatDef(TotE4.Caption,0) + StrtoFloatDef(TotH4.Caption,0));
        GGGenF.Caption:=Format('%-.2f',[StrToFloatDef(GGGenF.Caption,0)]);
      end;
      selT043Tot.Next;
    end;
  end;
end;

end.
