unit A104UStampaMissioni;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Dialogs,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, Math,
  A000UCostanti, A000USessione,A000UInterfaccia, Variants, C180FunzioniGenerali, QRExport,
  QRWebFilt, QRPDFFilt;

type
  TA104FStampaMissioni = class(TQuickRep)
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLblAzienda: TQRLabel;
    QRLblTitolo: TQRLabel;
    QRLblCompetenza: TQRLabel;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRDBText14: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel15: TQRLabel;
    QRDBText17: TQRDBText;
    QRLabel18: TQRLabel;
    QRDBText20: TQRDBText;
    QRLabel19: TQRLabel;
    QRDBText21: TQRDBText;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape17: TQRShape;
    QRSubDetail1: TQRSubDetail;
    QRSubDetail2: TQRSubDetail;
    QRDBText5: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRBand1: TQRBand;
    QRLabel23: TQRLabel;
    QRLblTotale: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape4: TQRShape;
    QRShape12: TQRShape;
    QRShape14: TQRShape;
    QRDBText24: TQRDBText;
    QRBand2: TQRBand;
    QRShape21: TQRShape;
    QRLabel24: TQRLabel;
    QRLblTotaleGenerale: TQRLabel;
    QRDBText25: TQRDBText;
    GroupFooterBand1: TQRBand;
    GroupHeaderBand1: TQRBand;
    QRLabel8: TQRLabel;
    GroupHeaderBand2: TQRBand;
    QRLabel21: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel20: TQRLabel;
    QRDBText22: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel22: TQRLabel;
    QRDBText23: TQRDBText;
    QRLblTotaleRimborsi: TQRLabel;
    QRShape2: TQRShape;
    GroupFooterBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText26: TQRDBText;
    QRLblTotaleIndennitaKm: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape13: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    ChildBand5: TQRChildBand;
    QrLblDescImportoTrasfertaSupHHGG: TQRLabel;
    QrLblDescImportoTrasfertaSupHHGGDesc: TQRLabel;
    QRDBText3: TQRDBText;
    QrLblImportoTrasfertaSupHHGG: TQRLabel;
    QrLblDescImportoTrasfertaSupGG: TQRLabel;
    QrLblDescImportoTrasfertaSupGGDesc: TQRLabel;
    QRDBText2: TQRDBText;
    QrLblImportoTrasfertaSupGG: TQRLabel;
    QrLblDescImportoTrasfertaSupHH: TQRLabel;
    QrLblDescImportoTrasfertaSupHHDesc: TQRLabel;
    QRDBText1: TQRDBText;
    QrLblImportoTrasfertaSupHH: TQRLabel;
    QRLblIndennitaDiTrasferta: TQRLabel;
    QRLblIndennitaDiTrasfertaDesc: TQRLabel;
    QRDBText4: TQRDBText;
    QrLblImportoTrasfertaIntera: TQRLabel;
    QRShape3: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QrLblDettaglioKm: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText27: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText28: TQRDBText;
    ChildBand6: TQRChildBand;
    ChildBand7: TQRChildBand;
    QRLabel4: TQRLabel;
    QrDbNoteRimborsi: TQRDBText;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRLblImportoRimborso: TQRLabel;
    QRLabel16: TQRLabel;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel5: TQRLabel;
    PROTOCOLLO: TQRDBText;
    StatoMiss: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    ChildBand8: TQRChildBand;
    QRShape42: TQRShape;
    QrLblDipendenteb: TQRLabel;
    procedure QrLblDescImportoTrasfertaSupHHPrint(sender: TObject;
      var Value: string);
    procedure QRLblIndennitaDiTrasfertaPrint(sender: TObject;
      var Value: string);
    procedure QRDBText21Print(sender: TObject; var Value: string);
    procedure QRDBText20Print(sender: TObject; var Value: string);
    procedure QRDBText17Print(sender: TObject; var Value: string);
    procedure QRDBText16Print(sender: TObject; var Value: string);
    procedure QRDBText15Print(sender: TObject; var Value: string);
    procedure QRLblTitoloPrint(sender: TObject; var Value: string);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupFooterBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupHeaderBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure GroupHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand7BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand8BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    nPv_TotaleGeneraleMissioniDip, nPv_TotaleMissione, nPv_TotaleRimborsi, nPv_TotaleIndennitaKm:Currency;//Real;
    function TipoTariff:String;
  public
    bPv_SaltoPagina:Boolean;
    procedure CreaReport;
    constructor Create(AOwner: TComponent); override;
  end;

var
  A104FStampaMissioni: TA104FStampaMissioni;

implementation

uses A104UStampaMissioniDtm1, A104UDialogStampa;

{$R *.DFM}

constructor TA104FStampaMissioni.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA104FStampaMissioni.CreaReport;
begin
  A104FStampaMissioniDtM1.TabellaStampa.IndexDefs.Clear;
  A104FStampaMissioniDtM1.TabellaStampa.IndexDefs.Add('Indice','mesescarico;contatore',[ixPrimary]);
  A104FStampaMissioniDtM1.TabellaStampa.IndexName:='Indice';
  QRGroup1.ForceNewPage:=bPv_SaltoPagina;
  if (Trim(A104FDialogStampa.DocumentoPDF) <> '') and (Trim(A104FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A104FDialogStampa.TipoModulo) = 'COM')then
  begin
    A104FStampaMissioni.ShowProgress:=False;
    A104FStampaMissioni.ExportToFilter(TQRPDFDocumentFilter.Create(A104FDialogStampa.DocumentoPDF));
  end
  else
    A104FStampaMissioni.Preview;
end;

procedure TA104FStampaMissioni.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLblAzienda.Caption:=Parametri.RagioneSociale;
  QRLblCompetenza.Caption:='Mese/Anno scarico: ' + FormatDateTime('mm/yyyy', A104FStampaMissioniDtM1.TabellaStampa.fieldbyname('MESESCARICO').AsDateTime);
end;

procedure TA104FStampaMissioni.QRGroup2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  (* Spostato sul BeforePost
  with A104FStampaMissioniDtM1 do
  begin
    SelM052.Close;
    SelM052.SetVariable('PROGRESSIVO',TabellaStampa.fieldbyname('PROGRESSIVO').AsInteger);
    SelM052.SetVariable('MESESCARICO',TabellaStampa.fieldbyname('MESESCARICO').asDateTime);
    SelM052.SetVariable('MESECOMPETENZA',TabellaStampa.fieldbyname('MESECOMPETENZA').asDateTime);
    SelM052.SetVariable('DATADA',TabellaStampa.fieldbyname('DATADA').asDateTime);
    SelM052.SetVariable('ORADA', TabellaStampa.fieldbyname('ORADA').asString);
    SelM052.SetVariable('DECORRENZA', TabellaStampa.fieldbyname('DATAA').AsDateTime);
    SelM052.Open;
    GroupHeaderBand2.Enabled:=SelM052.RecordCount > 0;
    QRSubDetail1.Enabled:=SelM052.RecordCount > 0;
    GroupFooterBand2.Enabled:=SelM052.RecordCount > 0;

    SelM050.Close;
    SelM050.SetVariable('PROGRESSIVO',TabellaStampa.fieldbyname('PROGRESSIVO').AsInteger);
    SelM050.SetVariable('MESESCARICO',TabellaStampa.fieldbyname('MESESCARICO').asDateTime);
    SelM050.SetVariable('MESECOMPETENZA',TabellaStampa.fieldbyname('MESECOMPETENZA').asDateTime);
    SelM050.SetVariable('DATADA',TabellaStampa.fieldbyname('DATADA').asDateTime);
    SelM050.SetVariable('ORADA', TabellaStampa.fieldbyname('ORADA').asString);
    SelM050.Open;
    GroupHeaderBand1.Enabled:=SelM050.RecordCount > 0;
    QRSubDetail2.Enabled:=SelM050.RecordCount > 0;
    ChildBand1.Enabled:=SelM050.RecordCount > 0;
    GroupFooterBand1.Enabled:=SelM050.RecordCount > 0;

    ChildBand6.Enbled:=A104FStampaMissioniDtM1.TabellaStampa.FieldByName('NOTERIMBORSI').AsString <> '';
    ChildBand7.Enbled:=A104FStampaMissioniDtM1.TabellaStampa.FieldByName('NOTERIMBORSI').AsString <> '';
  end;
  *)
end;

function TA104FStampaMissioni.TipoTariff:String;
var Ret:String;
begin
  with A104FStampaMissioniDtM1 do
  begin
  LeggiParametri(TabellaStampa.FieldByName('dataa').AsDateTime,TabellaStampa.FieldByName('tiporegistrazione').AsString);
    if Not(Q010.Active) then
      Exit;
    Ret:='';
    if Q010.FieldByName('TIPO_TARIFFA').AsString = 'O' then
      Ret:='Ore'
    else
      Ret:='Giorni';
    Result:=Ret;
  end;
end;

procedure TA104FStampaMissioni.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  nPv_TotaleMissione:=0;
  nPv_TotaleRimborsi:=0;
  nPv_TotaleIndennitaKm:=0;
  with A104FStampaMissioniDtM1 do
  begin
  end;
  with A104FStampaMissioniDtM1 do
  begin
    //LeggiParametri(Selm040DATAA.AsDateTime,Selm040TIPOREGISTRAZIONE.AsString);
    LeggiParametri(TabellaStampa.fieldbyname('DATAA').AsDateTime,TabellaStampa.fieldbyname('TIPOREGISTRAZIONE').AsString);
    ChildBand2.Height:=IfThen(TabellaStampa.FieldByName('IMPORTOINDINTERA').AsFloat <> 0,ChildBand2.Tag,0);
    ChildBand3.Height:=IfThen(TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat <> 0,ChildBand3.Tag,0);
    ChildBand4.Height:=IfThen(TabellaStampa.FieldByName('IMPORTOINDRIDOTTAG').AsFloat <> 0,ChildBand4.Tag,0);
    ChildBand5.Height:=IfThen(TabellaStampa.FieldByName('IMPORTOINDRIDOTTAHG').AsFloat <> 0,ChildBand5.Tag,0);

    SelM052.Close;
    SelM052.SetVariable('PROGRESSIVO',TabellaStampa.fieldbyname('PROGRESSIVO').AsInteger);
    SelM052.SetVariable('MESESCARICO',TabellaStampa.fieldbyname('MESESCARICO').asDateTime);
    SelM052.SetVariable('MESECOMPETENZA',TabellaStampa.fieldbyname('MESECOMPETENZA').asDateTime);
    SelM052.SetVariable('DATADA',TabellaStampa.fieldbyname('DATADA').asDateTime);
    SelM052.SetVariable('ORADA', TabellaStampa.fieldbyname('ORADA').asString);
    SelM052.SetVariable('DECORRENZA', TabellaStampa.fieldbyname('DATAA').AsDateTime);
    SelM052.Open;
    GroupHeaderBand2.Height:=IfThen(SelM052.RecordCount > 0,GroupHeaderBand2.Tag,0);
    QRSubDetail1.Height:=IfThen(SelM052.RecordCount > 0,QRSubDetail1.Tag,0);
    GroupFooterBand2.Height:=IfThen(SelM052.RecordCount > 0,GroupFooterBand2.Tag,0);

    SelM050.Close;
    SelM050.SetVariable('PROGRESSIVO',TabellaStampa.fieldbyname('PROGRESSIVO').AsInteger);
    SelM050.SetVariable('MESESCARICO',TabellaStampa.fieldbyname('MESESCARICO').asDateTime);
    SelM050.SetVariable('MESECOMPETENZA',TabellaStampa.fieldbyname('MESECOMPETENZA').asDateTime);
    SelM050.SetVariable('DATADA',TabellaStampa.fieldbyname('DATADA').asDateTime);
    SelM050.SetVariable('ORADA', TabellaStampa.fieldbyname('ORADA').asString);
    SelM050.Open;
    GroupHeaderBand1.Height:=IfThen(SelM050.RecordCount > 0,GroupHeaderBand1.Tag,0);
    QRSubDetail2.Height:=IfThen(SelM050.RecordCount > 0,QRSubDetail2.Tag,0);
    ChildBand1.Height:=IfThen(SelM050.RecordCount > 0,ChildBand1.Tag,0);
    GroupFooterBand1.Height:=IfThen(SelM050.RecordCount > 0,GroupFooterBand1.Tag,0);

    ChildBand6.Height:=IfThen(TabellaStampa.FieldByName('NOTERIMBORSI').AsString <> '',ChildBand6.Tag,0);
    ChildBand7.Height:=IfThen(TabellaStampa.FieldByName('NOTERIMBORSI').AsString <> '',ChildBand7.Tag,0);
  end;
//  QrLblImportoTrasfertaIntera.Caption:=Format('%*.*n',[10,2, StrToFloat('0')]);
//  QrLblImportoTrasfertaSupHH.Caption:=Format('%*.*n',[10,2, StrToFloat('0')]);
//  QrLblImportoTrasfertaSupGG.Caption:=Format('%*.*n',[10,2, StrToFloat('0')]);
//  QrLblImportoTrasfertaSupHHGG.Caption:=Format('%*.*n',[10,2, StrToFloat('0')]);ù
end;

procedure TA104FStampaMissioni.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Screen.Cursor:=crDefault;
end;

procedure TA104FStampaMissioni.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  nPv_TotaleGeneraleMissioniDip:=0;
  (*
  with A104FStampaMissioniDtM1 do
    QrLblDipendente.Caption:=TabellaStampa.fieldbyname('MATRICOLA').asString + ' - ' + TabellaStampa.fieldbyname('COGNOME').asString + ' ' + TabellaStampa.fieldbyname('NOME').asString;
  *)
end;

procedure TA104FStampaMissioni.QRGroup4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=not bPv_SaltoPagina;
end;

procedure TA104FStampaMissioni.QRSubDetail2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A104FStampaMissioniDtM1.SelM050.RecordCount = 0 then
    PrintBand:=False
  else
  begin
    PrintBand:=True;
    with A104FStampaMissioniDtM1 do
    begin
      if UpperCase(SelM050FLAG_ANTICIPO.AsString) = 'N' then
      begin
        QrLblImportoRimborso.Caption:=SelM050IMPORTORIMBORSOSPESE.AsString;
//        QrLblImportoRimborso.Font.Style:=[];
        nPv_TotaleRimborsi:=nPv_TotaleRimborsi + SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
        nPv_TotaleMissione:=nPv_TotaleMissione + SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
      end
      else
      begin
        QrLblImportoRimborso.Caption:= '-' + SelM050IMPORTORIMBORSOSPESE.AsString;
//        QrLblImportoRimborso.Font.Style:=[fsBold];
        nPv_TotaleRimborsi:=nPv_TotaleRimborsi - SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
        nPv_TotaleMissione:=nPv_TotaleMissione - SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
      end;
    end;
  end;
end;

procedure TA104FStampaMissioni.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if (not SelM052.Active) or (SelM052.RecordCount = 0) then
      PrintBand:=False
    else
    begin
      PrintBand:=True;
      //Valorizzo DettaglioKm
//      QrLblDettaglioKm.Caption:='(' + SelM052.FieldByName('KMPERCORSI').AsString + 'km x ' + Trim(Format('%*.*n',[10,2, SelM052.FieldByName('IMPORTO').AsFloat])) + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      QrLblDettaglioKm.Caption:='(' + SelM052.FieldByName('KMPERCORSI').AsString + 'km x ' + SelM052.FieldByName('IMPORTO').AsString + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      nPv_TotaleIndennitaKm:=nPv_TotaleIndennitaKm + SelM052IMPORTOINDENNITA.AsFloat;
      nPv_TotaleMissione:=nPv_TotaleMissione + SelM052IMPORTOINDENNITA.AsFloat;
    end;
  end;
end;

procedure TA104FStampaMissioni.GroupFooterBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A104FStampaMissioniDtM1.SelM050.RecordCount = 0 then
    PrintBand:=False
  else
  begin
    PrintBand:=True;
    QrLblTotaleRimborsi.Caption:=Format('%*.*n',[10,2, nPv_TotaleRimborsi]);
  end;
  nPv_TotaleGeneraleMissioniDip:=nPv_TotaleGeneraleMissioniDip + nPv_TotaleMissione;
end;

procedure TA104FStampaMissioni.GroupFooterBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if (SelM052.Active = False) or (SelM052.RecordCount = 0) then
      PrintBand:=False
    else
    begin
      PrintBand:=True;
      QRLblTotaleIndennitaKm.Caption:=Format('%*.*n',[10,2, nPv_TotaleIndennitaKm]);
    end;
  end;
end;

procedure TA104FStampaMissioni.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A104FStampaMissioniDtM1.SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat = 0 then
    PrintBand:=False;
end;

procedure TA104FStampaMissioni.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrLblTotaleGenerale.Caption:=Format('%*.*n',[10,2, nPv_TotaleGeneraleMissioniDip]);
end;

procedure TA104FStampaMissioni.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrLblTotale.Caption:=Format('%*.*n',[10,2,nPv_TotaleMissione]);
end;

procedure TA104FStampaMissioni.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDINTERA').asFloat <> 0 then
    begin
      QrLblImportoTrasfertaIntera.Caption:=Format('%*.*n',[10,2, TabellaStampa.fieldbyname('IMPORTOINDINTERA').AsFloat]);
      QRLblIndennitaDiTrasfertaDesc.Caption:='(' + TabellaStampa.fieldbyname('oreindintera').AsString + TipoTariff + ' x ' + Trim(Format('%*.*n',[10,2, TabellaStampa.fieldbyname('tariffaindintera').AsFloat])) + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      //===========================================================================
      //LE REGOLE SONO STATE PRECEDENTEMENTE IMPOSTATE NELLA FUNZIONE "TIPOTARIFFA"
      //===========================================================================
      if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
          QRLblIndennitaDiTrasfertaDesc.Caption:='';
      nPv_TotaleMissione:=nPv_TotaleMissione + TabellaStampa.fieldbyname('IMPORTOINDINTERA').AsFloat;
      PrintBand:=True;
    end
    else
      PrintBand:=False;
  end;
end;

procedure TA104FStampaMissioni.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat <> 0 then
    begin
      if Q010.FieldByName('RIDUZIONE_PASTO').AsString='S' then
        QrLblDescImportoTrasfertaSupHH.Caption:='Indennità di trasferta ridotta per rimborso pasto'
      else
        QrLblDescImportoTrasfertaSupHH.Caption:='Indennità di trasferta supero ore';
      QrLblDescImportoTrasfertaSupHHDesc.Caption:='(' + TabellaStampa.fieldbyname('oreindridottah').AsString + TipoTariff + ' x ' + Trim(Format('%*.*n',[10,2, TabellaStampa.fieldbyname('tariffaindridottah').AsFloat])) + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      //===========================================================================
      //LE REGOLE SONO STATE PRECEDENTEMENTE IMPOSTATE NELLA FUNZIONE "TIPOTARIFFA"
      //===========================================================================
      if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
        QrLblDescImportoTrasfertaSupHHDesc.Caption:='';
      QrLblImportoTrasfertaSupHH.Caption:=Format('%*.*n',[10,2, TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat]);
      nPv_TotaleMissione:=nPv_TotaleMissione + TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat;
      PrintBand:=True;
    end
    else
      PrintBand:=False;
  end;
end;

procedure TA104FStampaMissioni.ChildBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsFloat <> 0 then
    begin
      QrLblDescImportoTrasfertaSupGGDesc.Caption:='(' + TabellaStampa.fieldbyname('oreindridottag').AsString + TipoTariff + ' x ' + Trim(Format('%*.*n',[10,2, TabellaStampa.fieldbyname('tariffaindridottag').AsFloat])) + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      QrLblImportoTrasfertaSupGG.Caption:=Format('%*.*n',[10,2, TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsFloat]);
      nPv_TotaleMissione:=nPv_TotaleMissione + TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsFloat;
      PrintBand:=True;
    end
    else
      PrintBand:=False;
  end;
end;

procedure TA104FStampaMissioni.ChildBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsFloat <> 0 then
    begin
      QrLblDescImportoTrasfertaSupHHGGDesc.Caption:='(' + TabellaStampa.fieldbyname('oreindridottahg').AsString + TipoTariff + ' x ' + Trim(Format('%*.*n',[10,2, TabellaStampa.fieldbyname('tariffaindridottahg').AsFloat])) + TabellaStampa.fieldbyname('abbreviazione').AsString + ')';
      //===========================================================================
      //LE REGOLE SONO STATE PRECEDENTEMENTE IMPOSTATE NELLA FUNZIONE "TIPOTARIFFA"
      //===========================================================================
      if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
        QrLblDescImportoTrasfertaSupHHGGDesc.Caption:='';
      QrLblImportoTrasfertaSupHHGG.Caption:=Format('%*.*n',[10,2, TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsFloat]);
      nPv_TotaleMissione:=nPv_TotaleMissione + TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsFloat;
      PrintBand:=True;
    end
    else
      PrintBand:=False;
  end;
end;

procedure TA104FStampaMissioni.GroupHeaderBand2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
    if SelM052.Active then
      PrintBand:=SelM052.RecordCount > 0;
end;

procedure TA104FStampaMissioni.GroupHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=A104FStampaMissioniDtM1.SelM050.RecordCount > 0;
end;

procedure TA104FStampaMissioni.ChildBand6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=A104FStampaMissioniDtM1.TabellaStampa.FieldByName('NOTERIMBORSI').AsString <> '';
end;

procedure TA104FStampaMissioni.ChildBand7BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  nDep:integer;
begin
  if A104FStampaMissioniDtM1.TabellaStampa.FieldByName('NOTERIMBORSI').AsString = '' then
    PrintBand:=False
  else
  begin
    nDep:=Trunc(QrDbNoteRimborsi.Size.Height);
    QrShape39.Height:=nDep + 10;
    QrShape41.Height:=nDep + 10;
    PrintBand:=True;
  end;
end;

procedure TA104FStampaMissioni.ChildBand8BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
    QrLblDipendenteB.Caption:=TabellaStampa.fieldbyname('MATRICOLA').asString + ' - ' + TabellaStampa.fieldbyname('COGNOME').asString + ' ' + TabellaStampa.fieldbyname('NOME').asString;
end;

procedure TA104FStampaMissioni.QRLblTitoloPrint(sender: TObject;
  var Value: string);
begin
  Value:=A104FDialogStampa.EdtTitolo.Text;
end;

procedure TA104FStampaMissioni.QRDBText15Print(sender: TObject;
  var Value: string);
begin
  if (QRDBText15.DataSet.FieldByName('DATAA').AsString = QRDBText14.DataSet.FieldByName('DATADA').AsString)
     and (QRDBText16.DataSet.FieldByName('ORADA').AsString = QRDBText17.DataSet.FieldByName('ORAA').AsString) then
    Value:='';
end;

procedure TA104FStampaMissioni.QRDBText16Print(sender: TObject;
  var Value: string);
begin
  if (QRDBText15.DataSet.FieldByName('DATAA').AsString = QRDBText14.DataSet.FieldByName('DATADA').AsString)
     and (QRDBText16.DataSet.FieldByName('ORADA').AsString = QRDBText17.DataSet.FieldByName('ORAA').AsString) then
    Value:='';
end;

procedure TA104FStampaMissioni.QRDBText17Print(sender: TObject;
  var Value: string);
begin
  if (QRDBText15.DataSet.FieldByName('DATAA').AsString = QRDBText14.DataSet.FieldByName('DATADA').AsString)
     and (QRDBText16.DataSet.FieldByName('ORADA').AsString = QRDBText17.DataSet.FieldByName('ORAA').AsString) then
    Value:='';
end;

procedure TA104FStampaMissioni.QRDBText20Print(sender: TObject;
  var Value: string);
begin
  if (QRDBText15.DataSet.FieldByName('DATAA').AsString = QRDBText14.DataSet.FieldByName('DATADA').AsString)
     and (QRDBText16.DataSet.FieldByName('ORADA').AsString = QRDBText17.DataSet.FieldByName('ORAA').AsString) then
    Value:='';
end;

procedure TA104FStampaMissioni.QRDBText21Print(sender: TObject;
  var Value: string);
begin
  if (QRDBText15.DataSet.FieldByName('DATAA').AsString = QRDBText14.DataSet.FieldByName('DATADA').AsString)
     and (QRDBText16.DataSet.FieldByName('ORADA').AsString = QRDBText17.DataSet.FieldByName('ORAA').AsString) then
    Value:='';
end;

procedure TA104FStampaMissioni.QRLblIndennitaDiTrasfertaPrint(sender: TObject;
  var Value: string);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
      Value:='Quota esente da tassazione'
    else
      Value:='Indennità di trasferta intera';
  end;
end;

procedure TA104FStampaMissioni.QrLblDescImportoTrasfertaSupHHPrint(
  sender: TObject; var Value: string);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
      Value:='Quota soggetta a tassazione'
    else
      Value:='Indennità al supero delle ore massime/rimborso pasto';
  end;
end;

end.
