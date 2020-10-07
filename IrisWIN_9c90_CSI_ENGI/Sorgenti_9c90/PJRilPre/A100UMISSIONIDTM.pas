unit A100UMissioniDTM;

interface

uses
  R004UGESTSTORICODTM, DB, Oracle, Classes, OracleData,
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms, Math,
  StrUtils,
  Dialogs, DBClient,
  C180FunzioniGenerali, C700USelezioneAnagrafe,
  A000UCostanti, A000USessione, A000UInterfaccia,
  A100UCheckRimborsiMW,
  A083UMsgElaborazioni, QueryStorico, RegistrazioneLog,
  A100UMissioniMW,A100UImpRimborsiIterMW, A000UMessaggi;

type
  TA100FMISSIONIDTM = class(TR004FGestStoricoDtM)
    M040: TOracleDataSet;
    M040PROGRESSIVO: TFloatField;
    M040MESESCARICO: TDateTimeField;
    M040MESECOMPETENZA: TDateTimeField;
    M040DATADA: TDateTimeField;
    M040ORADA: TStringField;
    M040PROTOCOLLO: TStringField;
    M040DATAA: TDateTimeField;
    M040ORAA: TStringField;
    M040TOTALEGG: TFloatField;
    M040DURATA: TStringField;
    M040TARIFFAINDINTERA: TFloatField;
    M040OREINDINTERA: TFloatField;
    M040IMPORTOINDINTERA: TFloatField;
    M040TARIFFAINDRIDOTTAH: TFloatField;
    M040OREINDRIDOTTAH: TFloatField;
    M040IMPORTOINDRIDOTTAH: TFloatField;
    M040TARIFFAINDRIDOTTAG: TFloatField;
    M040OREINDRIDOTTAG: TFloatField;
    M040IMPORTOINDRIDOTTAG: TFloatField;
    M040TARIFFAINDRIDOTTAHG: TFloatField;
    M040OREINDRIDOTTAHG: TFloatField;
    M040IMPORTOINDRIDOTTAHG: TFloatField;
    M040FLAG_MODIFICATO: TStringField;
    M040TotaleOreIndennita: TFloatField;
    M040TotaleImportiIndennita: TFloatField;
    M040TotaleKmIndennita: TFloatField;
    M040TotaleImportiKmIndennita: TFloatField;
    M040TotaleMissione: TFloatField;
    M040PARTENZA: TStringField;
    M040DESTINAZIONE: TStringField;
    M040NOTE_RIMBORSI: TStringField;
    M040desctipomissione: TStringField;
    M040COMMESSA: TStringField;
    D050: TDataSource;
    Q030A: TOracleDataSet;
    Q030ACOD_VALUTA: TStringField;
    Q030ADECORRENZA: TDateTimeField;
    Q030ADESCRIZIONE: TStringField;
    Q030AABBREVIAZIONE: TStringField;
    Q030ANUM_DEC_IMP_VOCE: TIntegerField;
    Q030ANUM_DEC_IMP_UNIT: TIntegerField;
    D030A: TDataSource;
    M040TIPOREGISTRAZIONE: TStringField;
    M040descpartenza: TStringField;
    M040desccommessa: TStringField;
    D021A: TDataSource;
    Q021A: TOracleDataSet;
    Q021ACODICE: TStringField;
    Q021ADESCRIZIONE: TStringField;
    Q021ADECORRENZA: TDateTimeField;
    Q021AIMPORTO: TFloatField;
    Q021ACODVOCEPAGHE: TStringField;
    Q021AARROTONDAMENTO: TStringField;
    M040CostoMissione: TFloatField;
    SelM011: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    M040STATO: TStringField;
    Sel010TipoTariffa: TOracleDataSet;
    M040COD_TARIFFA: TStringField;
    M040COD_RIDUZIONE: TStringField;
    M040desctariffa: TStringField;
    M040ID_MISSIONE: TIntegerField;
    selM150: TOracleDataSet;
    selM150TIPO_RICHIESTA: TStringField;
    selM150NOMINATIVO: TStringField;
    selM150MATRICOLA: TStringField;
    selM150PROTOCOLLO: TStringField;
    selM150FLAG_ISPETTIVA: TStringField;
    selM150DATADA: TDateTimeField;
    selM150DATAA: TDateTimeField;
    selM150ORADA: TStringField;
    selM150ORAA: TStringField;
    selM150CODICE: TStringField;
    selM150DESCRIZIONE: TStringField;
    selM150KMPERCORSI: TFloatField;
    selM150RIMBORSO: TFloatField;
    selM150COD_VALUTA: TStringField;
    selM150RIMBORSO_VARIATO: TFloatField;
    selM150NOTE: TStringField;
    selM150D_DESTINAZIONE: TStringField;
    selM150STATO: TStringField;
    selM150ID: TFloatField;
    selM150KMPERCORSI_VARIATO: TFloatField;
    selM150INDENNITA_KM: TStringField;
    M040TIPO_RICHIESTA: TStringField;
    M040D_ANNULLATA: TStringField;
    M040FLAG_DESTINAZIONE: TStringField;
    M040FLAG_ISPETTIVA: TStringField;
    selM150PARTENZA: TStringField;
    selM150RIENTRO: TStringField;
    selM150C_PERCORSO: TStringField;
    selM150COMUNE_RESIDENZA: TStringField;
    selM150CAP_RESIDENZA: TStringField;
    selM150PROGRESSIVO: TIntegerField;
    selM150C_SEDE_LAVORO: TStringField;
    selM150C_COMUNE_RES: TStringField;
    selM150ELENCO_DESTINAZIONI: TStringField;
    selM150C_COMUNE_DOM: TStringField;
    selM150COMUNE_DOMICILIO: TStringField;
    selM150CAP_DOMICILIO: TStringField;
    M040ID: TFloatField;
    M040MISSIONE_RIAPERTA: TStringField;
    procedure D050DataChange(Sender: TObject; Field: TField);
    procedure M040AfterOpen(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure M040ORADAValidate(Sender: TField);
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure M040DATAAValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure M040NewRecord(DataSet: TDataSet);
    procedure M040MESESCARICOSetText(Sender: TField; const Text: String);
    procedure M040MESESCARICOGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure M040TARIFFAINDINTERAValidate(Sender: TField);
    procedure M040TARIFFAINDRIDOTTAHValidate(Sender: TField);
    procedure M040TARIFFAINDRIDOTTAGValidate(Sender: TField);
    procedure M040TARIFFAINDRIDOTTAHGValidate(Sender: TField);
    procedure M040CalcFields(DataSet: TDataSet);
    procedure M040AfterScroll(DataSet: TDataSet);
    procedure M040DATADAValidate(Sender: TField);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure M040DATADAGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure M040MESESCARICOValidate(Sender: TField);
    procedure M040PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure M040ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure D050StateChange(Sender: TObject);
    procedure M040DATADAChange(Sender: TField);
    procedure selM150BeforeDelete(DataSet: TDataSet);
    procedure selM150BeforeInsert(DataSet: TDataSet);
    procedure selM150BeforePost(DataSet: TDataSet);
    procedure selM150AfterPost(DataSet: TDataSet);
    procedure selM150BeforeEdit(DataSet: TDataSet);
    procedure selM150KMPERCORSI_VARIATOValidate(Sender: TField);
    procedure selM150AfterScroll(DataSet: TDataSet);
    procedure selM150ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure selM150CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ImpostaCampiElaboraMissione;
  public
    A100FMissioniMW : TA100FMissioniMW;
    A100FImpRimborsiIterMW: TA100FImpRimborsiIterMW;
    A100FCheckRimbMW: TA100FCheckRimborsiMW;
    TotRimborsiPasto: Real;
    EstArrotond: Real;
    EstTipo: String;
    procedure SettaProgressivo;
    procedure MessaggioAvviso(msg: String);
    procedure MostraColonne(Mostra: Boolean);
  end;

var
  A100FMISSIONIDTM: TA100FMISSIONIDTM;

implementation

uses A100UMISSIONI, R001UGestTab;
{$R *.dfm}

procedure TA100FMISSIONIDTM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  InizializzaDataSet(M040, [evBeforePostNoStorico, evBeforeDelete,evBeforeInsert,
                    // evBeforeEdit,
                    evAfterDelete, evAfterPost]);
  A100FMissioniMW:=TA100FMissioniMW.Create(Self);

  A100FMissioniMW.MessaggioAvviso:=MessaggioAvviso;
  A100FMissioniMW.MostraColonne:=MostraColonne; //Da fare su cloud
  A100FMissioniMW.Q010Scroll:=A100FMissioni.GestioneCampi;
  A100FMissioniMW.ImpostaCampiElaboraMissione:=ImpostaCampiElaboraMissione;
  D050.DataSet:=A100FMissioniMW.Q050;
  A100FMissioniMW.SelM040_Funzioni:=M040;

  M040.FieldByName('desctipomissione').LookupDataSet:=A100FMissioniMW.QM011;
  M040.FieldByName('desccommessa').LookupDataSet:=A100FMissioniMW.QCommessa;
  M040.FieldByName('descpartenza').LookupDataSet:=A100FMissioniMW.QSede;

  A100FMissioniMW.InizializzaM066;

  with A100FMissioni do
  begin
    // Carico la combo delle località di destinazione
    A100FMissioniMW.ImpostaQSourceDestinazione;
    CmbDestinazione.Items.Clear;
    While not A100FMissioniMW.QSource.Eof do
    begin
      CmbDestinazione.Items.Add(A100FMissioniMW.QSource.FieldByName('DESTINAZIONE').AsString);
      A100FMissioniMW.QSource.Next;
    end;

    // SEDE DI RIFERIMENTO - PARTENZA
    CmbPartenza.Clear;
    if A100FMissioniMW.nLunghezzaPartenza > 0 then
    begin
      // Carico la combo delle località di partenza
      While not A100FMissioniMW.QSede.Eof do
      begin
        if A100FMissioniMW.QSede.FieldByName('DESCRIZIONE').AsString <> '' then
          CmbPartenza.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[A100FMissioniMW.QSede.FieldByName('CODICE').AsString])
                                + ' - ' + A100FMissioniMW.QSede.FieldByName('DESCRIZIONE').AsString)
        else
          CmbPartenza.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[A100FMissioniMW.QSede.FieldByName('CODICE').AsString]));
        A100FMissioniMW.QSede.Next;
      end;
    end;

    // COMMESSA
    CmbCommessa.Clear;
    if A100FMissioniMW.nLunghezzaCommessa > 0  then
    begin
      // Carico la combo delle commesse
      A100FMissioniMW.QCommessa.First;
      While not A100FMissioniMW.QCommessa.Eof do
      begin
        if A100FMissioniMW.QCommessa.FieldByName('DESCRIZIONE').AsString <> '' then
          CmbCommessa.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',
                                       [A100FMissioniMW.QCommessa.FieldByName('CODICE').AsString])
                                        + ' - ' + A100FMissioniMW.QCommessa.FieldByName('DESCRIZIONE').AsString)
        else
          CmbCommessa.Items.Add(Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',[A100FMissioniMW.QCommessa.FieldByName('CODICE').AsString]));
        A100FMissioniMW.QCommessa.Next;
      end;
    end;
  end;
  A100FImpRimborsiIterMW:=TA100FImpRimborsiIterMW.Create(Self);
  A100FImpRimborsiIterMW.selM150_Funzioni:=selM150;
  //
  A100FCheckRimbMW:=TA100FCheckRimborsiMW.Create(Self);
  A100FCheckRimbMW.selM040CheckRimb_Funzioni:=A100FCheckRimbMW.selM040CheckRimb;
end;

procedure TA100FMISSIONIDTM.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A100FMissioniMW.M040FiltroDizionario;
end;

procedure TA100FMISSIONIDTM.SettaProgressivo;
begin
  with M040 do
  begin
    Close;
    SetVariable('Progressivo', C700Progressivo);
    Open;
    Last;
  end;
end;

procedure TA100FMISSIONIDTM.M040NewRecord(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.M040NewRecord;
  with A100FMissioni do
  begin
    // Pulisco la commessa...
    CmbCommessa.Text:='';
    // Pulisco la località di Partenza...
    CmbPartenza.Text:='';
    // Pulisco la località di Destinazione...
    CmbDestinazione.Text:='';
  end;
end;

procedure TA100FMISSIONIDTM.M040MESESCARICOSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  Sender.AsDateTime:=EncodeDate(strtoint(Copy(Text, 4, 4)),strtoint(Copy(Text, 1, 2)), 1);
end;

procedure TA100FMISSIONIDTM.M040MESESCARICOGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy', Sender.AsDateTime);
end;

procedure TA100FMISSIONIDTM.M040TARIFFAINDINTERAValidate(Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040INDINTERAValidate;
end;

procedure TA100FMISSIONIDTM.M040TARIFFAINDRIDOTTAHValidate(Sender: TField);
begin
  A100FMissioniMW.M040INDRIDOTTAHValidate;
end;

procedure TA100FMISSIONIDTM.M040TARIFFAINDRIDOTTAGValidate(Sender: TField);
begin
  A100FMissioniMW.M040INDRIDOTTAGValidate;
end;

procedure TA100FMISSIONIDTM.M040TARIFFAINDRIDOTTAHGValidate(Sender: TField);
begin
  A100FMissioniMW.M040INDRIDOTTAHGValidate;
end;

procedure TA100FMISSIONIDTM.M040CalcFields(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.CalcolaTotaliIndennitaOrarie;
  A100FMissioniMW.CalcolaTotaliIndennitaKm;
end;

procedure TA100FMISSIONIDTM.M040AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.selM040AfterScroll;
  // ====================================================
  // REFRESH SULLA VISUALIZZAZIONE DEL TIPO DELLA TARIFFA
  // ====================================================

  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
  // azione di riapertura missione disponibile se si verificano queste condizioni:
  // - la missione arriva da web (ID non nullo)
  // - la missione non è già stata riaperta (ovvio)
  // - lo stato è da liquidare o liquidata
  // - par. aziendale dettaglio rimborsi = 'S' (Parametri.CampiRiferimento.C8_W032RimborsiDett)
  // - par. aziendale riapertura trasferte liquidate = 'S' (Parametri.CampiRiferimento.C8_W032RiapriMissione)
  A100FMissioni.actRiapriRichiestaMissione.Enabled:=(not M040.FieldByName('ID').IsNull) and
                                                    (M040.FieldByName('MISSIONE_RIAPERTA').AsString <> 'S') and
                                                    (R180In(M040.FieldByName('STATO').AsString,['D','L'])) and
                                                    (Parametri.CampiRiferimento.C8_W032RimborsiDett = 'S') and
                                                    (Parametri.CampiRiferimento.C8_W032RiapriMissione = 'S');
  A100FMissioni.actElencoRiaperture.Enabled:=not M040.FieldByName('ID').IsNull;
  // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
  with A100FMissioni do
  begin
    // Aggiorno la descrizione dei rimborsi - Bruno 09/06/2011
    //MemNoteRimborsi.Text:=M040NOTE_RIMBORSI.AsString;

    if frmToolbarFiglioIndKM.TFDButton <> nil then
      frmToolbarFiglioIndKM.AbilitaAzioniTF(nil);
    if frmToolbarFiglioRimb.TFDButton <> nil then
      frmToolbarFiglioRimb.AbilitaAzioniTF(nil);
    if frmToolbarFiglioDettGG.TFDButton <> nil then
      frmToolbarFiglioDettGG.AbilitaAzioniTF(nil);
    Label28.Caption:=A100FMissioniMW.CaptionTariffaOraria;
    Label29.Caption:=A100FMissioniMW.CaptionTariffaQuotaEsente;

    if A100FMissioniMW.Q010.Active then
    begin
      if A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
      begin
        lblCodiceTariffa.Enabled:=True;
        lblCodiceRiduzione.Enabled:=True;
        DCmbLookpCodTariff.Enabled:=True;
        DCmbLookUpCodRiduzione.Enabled:=True;
      end
      else
      begin
        lblCodiceTariffa.Enabled:=False;
        lblCodiceRiduzione.Enabled:=False;
        DCmbLookpCodTariff.Enabled:=False;
        DCmbLookUpCodRiduzione.Enabled:=False;
        M040.FieldByName('COD_TARIFFA').Clear;
        M040.FieldByName('COD_RIDUZIONE').Clear;
      end;
    end;

    if A100FMissioniMW.Q010TIPO_TARIFFA.AsString = 'G' then
      lblOreGiorni.Caption:='Giorni'
    else
      lblOreGiorni.Caption:='Ore in centesimi';
  end;
  A100FMissioniMW.Q010.Close;
  A100FMissioniMW.Q010.ClearVariables;
  { end; }
end;

procedure TA100FMISSIONIDTM.M040DATADAValidate(Sender: TField);
begin
  A100FMissioniMW.M040DATADAValidate;
end;

procedure TA100FMISSIONIDTM.BeforePostNoStorico(DataSet: TDataSet);
var Msg:String;
begin
  A100FMissioniMW.M040BeforePostPasso1;
  if A100FMissioniMW.TestMeseScarico and
    (R180MessageBox(A000MSG_A100_ERR_DATA_MISS_SUCC, DOMANDA) = mrNo) then
    Abort;
  Msg:=A100FMissioniMW.M040BeforePostPasso2;
  if Msg <> '' then
    if R180MessageBox(Msg, DOMANDA) <> IDYes then
      Abort;

  // Imposto nella località di partenza il contenuto della combo
  with A100FMissioni do
  begin
    if trim(A100FMissioni.CmbPartenza.Text) <> '' then
    begin
      if Copy(CmbPartenza.Text, A100FMissioniMW.nLunghezzaPartenza + 1, 3) = ' - ' then
        M040PARTENZA.AsString:=trim(Copy(CmbPartenza.Text, 1, A100FMissioniMW.nLunghezzaPartenza))
      else
        M040PARTENZA.AsString:=trim(CmbPartenza.Text);
    end
    else
      M040PARTENZA.Clear;
    if trim(A100FMissioni.CmbDestinazione.Text) <> '' then
      M040DESTINAZIONE.AsString:=trim(A100FMissioni.CmbDestinazione.Text)
    else
      M040DESTINAZIONE.Clear;
    if trim(A100FMissioni.CmbCommessa.Text) <> '' then
    begin
      if Copy(CmbCommessa.Text, A100FMissioniMW.nLunghezzaCommessa + 1, 3) = ' - ' then
        M040COMMESSA.AsString:=trim(Copy(CmbCommessa.Text, 1, A100FMissioniMW.nLunghezzaCommessa))
      else
      M040COMMESSA.AsString := trim(CmbCommessa.Text);
    end
    else
      M040COMMESSA.Clear;
  end;
  Msg:=A100FMissioniMW.AnticipiDaUnire;
  if Msg <> '' then
  begin
    if R180MessageBox(Msg, 'DOMANDA') <> mrYes then
      exit;
    msg:=A100FMissioniMW.UnisciAnticipi;
    if msg <> '' then
      R180MessageBox(msg, 'INFORMA');
  end
  else
  begin
    msg:=A100FMissioniMW.AnticipiSospesi;
    if msg <> '' then
      R180MessageBox(msg, 'ESCLAMA');
  end;

  inherited;
end;

procedure TA100FMISSIONIDTM.M040DATADAChange(Sender: TField);
begin
  inherited;
  A100FMissioniMW.selM066.Close;
  A100FMissioniMW.selM066.SetVariable('COD_TARIFF', M040.FieldByName('COD_TARIFFA').AsString);
  A100FMissioniMW.selM066.SetVariable('DATA', M040.FieldByName('DATADA').AsString);
  A100FMissioniMW.selM066.Open;
  A100FMissioniMW.selM066.Refresh;
  A100FMissioni.DCmbLookUpCodRiduzione.Repaint;
end;

procedure TA100FMISSIONIDTM.M040DATADAGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := ''
  else
    Text := FormatDateTime('dd', Sender.AsDateTime);
end;

procedure TA100FMISSIONIDTM.M040MESESCARICOValidate(Sender: TField);
begin
  A100FMissioniMW.M040MESESCARICOValidate;
end;

procedure TA100FMISSIONIDTM.M040PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  A100FMissioniMW.M040PostError(E);
  inherited;
end;

procedure TA100FMISSIONIDTM.selM150AfterPost(DataSet: TDataSet);
begin
  (*
    RegistraLog.RegistraOperazione;
    with M050P_CARICA_RIMBORSI_DAITER do
    begin
    SetVariable('ID',DataSet.FieldByName('ID').AsInteger);
    Execute;
    SessioneOracle.Commit;
    end;
    *)
end;

procedure TA100FMISSIONIDTM.selM150AfterScroll(DataSet: TDataSet);
var
  IndKm: Boolean;
begin
  IndKm:=DataSet.FieldByName('INDENNITA_KM').AsString = 'S';
  DataSet.FieldByName('RIMBORSO_VARIATO').ReadOnly:=IndKm;
  DataSet.FieldByName('KMPERCORSI_VARIATO').ReadOnly:=not IndKm;
  if not IndKm then
  begin
    DataSet.FieldByName('KMPERCORSI').Text:='';
    DataSet.FieldByName('KMPERCORSI_VARIATO').Text:='';
  end;
  A100FImpRimborsiIterMW.selM150AfterScroll;
end;

procedure TA100FMISSIONIDTM.selM150ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  A100FImpRimborsiIterMW.selM150ApplyRecord(Action,Applied);
end;

procedure TA100FMISSIONIDTM.selM150BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FMISSIONIDTM.selM150BeforeEdit(DataSet: TDataSet);
begin
  (*
  if DataSet.FieldByName('STATO').AsString = 'S' then
  raise Exception.Create('Rimborso già validato e non più modificabile. Agire direttamente sulla missione.');
  *)
end;

procedure TA100FMISSIONIDTM.selM150BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA100FMISSIONIDTM.selM150BeforePost(DataSet: TDataSet);
var Msg: String;
begin
  Msg:=A100FImpRimborsiIterMW.selM150BeforePostPasso1;
  if Msg <> '' then
  begin
    // messaggio non bloccante - daniloc. 30.05.2012
    if R180MessageBox(Msg, DOMANDA) = mrNo then
      Abort;
  end;

  Msg:=A100FImpRimborsiIterMW.selM150BeforePostPasso2;
  if Msg <> '' then
  begin
    // messaggio non bloccante - daniloc. 30.05.2012
    if R180MessageBox(Msg, DOMANDA) = mrNo then
      Abort;
  end;
end;

procedure TA100FMISSIONIDTM.selM150CalcFields(DataSet: TDataSet);
begin
  inherited;
  A100FImpRimborsiIterMW.selM150CalcFields;
end;

procedure TA100FMISSIONIDTM.selM150KMPERCORSI_VARIATOValidate(Sender: TField);
begin
  A100FImpRimborsiIterMW.KMPERCORSI_VARIATOValidate
end;

procedure TA100FMISSIONIDTM.MessaggioAvviso(msg: String);
begin
  R180MessageBox(msg, 'ERRORE');
end;

procedure TA100FMISSIONIDTM.MostraColonne(Mostra: Boolean);
begin
  with A100FMissioni do
  begin
    dgrdRimborsi.Columns[6].Visible:=Mostra;
    dgrdRimborsi.Columns[7].Visible:=Mostra;
  end;
end;

procedure TA100FMISSIONIDTM.M040ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: String);
begin
  inherited;
  A100FMissioniMW.M040Apply(Action);
end;

procedure TA100FMISSIONIDTM.AfterPost(DataSet: TDataSet);
var ApriCartellino: boolean;
  Msg , StrRowId, AzioneApp : String;
begin
  ApriCartellino:=False;
  Msg:=A100FMissioniMW.M040AfterPostPasso1;
  if Msg <> '' then
  begin
    if R180MessageBox(Msg, 'DOMANDA') = mrYes then
    begin
      ApriCartellino:=True;
      A100FMissioniMW.Cancellare:=False;
    end;
  end;

  Msg:=A100FMissioniMW.M040AfterPostPasso2;
  if Msg <> '' then
  begin
    A100FMissioniMW.Inserire:=R180MessageBox(Msg, 'DOMANDA') = mrYes;
  end;

  Msg:=A100FMissioniMW.M040AfterPostPasso3;
  if Msg <> '' then
  begin
    A100FMissioniMW.Cancellare:=R180MessageBox(Msg, 'DOMANDA') = mrYes;
  end;

  if not A100FMissioniMW.M040AfterPostPasso4  then
  begin
    ShowMessage(A000MSG_A100_MSG_ANOMALIE);
    OpenA083MsgElaborazioni(Parametri.Azienda, Parametri.Operatore,'A100', 'A');
  end;

  AzioneApp:=A100FMissioniMW.Azione;
  A100FMissioniMW.Azione:='';
  A100FMissioniMW.Causale:='';
  A100FMissioniMW.CausaleOld:='';
  try
    M040.AfterScroll:=nil;
    inherited;
    A100FMissioniMW.M040AfterPostPasso6(AzioneApp);
  finally
    M040.AfterScroll:=M040AfterScroll;
  end;
  SessioneOracle.Commit;

  // ================================================================================================
  // ESEGUO UN REFRESH DELLA M040 PER EVITARE ALCUNI COMPORTAMENTI SCORRETTI DEGLI EVENTI DEL DATASET
  // ESEGUO UNA SEARCHRECORD PER NN RIPOSIZIONARMI SUL PRIMO RECORD
  // ================================================================================================
  StrRowId:=M040.RowId;
  M040.Refresh;
  M040.SearchRecord('ROWID', StrRowId, [srFromBeginning]);
  if ApriCartellino then
    A100FMissioni.actCartellinoInterattivoExecute(nil);
end;

procedure TA100FMISSIONIDTM.M040DATAAValidate(Sender: TField);
begin
  inherited;
  A100FMissioniMW.M040DATAAValidate;
end;

procedure TA100FMISSIONIDTM.BeforeEdit(DataSet: TDataSet);
begin
  A100FMissioniMW.M040BeforeEdit;
end;

procedure TA100FMISSIONIDTM.M040ORADAValidate(Sender: TField);
begin
  A100FMissioniMW.M040ORAValidate(Sender);
end;

procedure TA100FMISSIONIDTM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.M040BeforeDelete;
end;

procedure TA100FMISSIONIDTM.M040AfterOpen(DataSet: TDataSet);
begin
  inherited;
  A100FMissioniMW.M040AfterOpen;
end;

procedure TA100FMISSIONIDTM.D050DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  // =========================================================
  // DISABILITO LE DUE COLONNE QUANDO NN C'E' IL CODICE VALUTA
  // =========================================================
  A100FMissioniMW.Q050.FieldByName('IMPRIMB_VALEST').ReadOnly:=A100FMissioniMW.Q050.FieldByName('COD_VALUTA_EST').IsNull;
end;

procedure TA100FMISSIONIDTM.D050StateChange(Sender: TObject);
begin
  inherited;
  with A100FMissioni do
    if D050.State in [dsInsert, dsEdit] then
    begin
      if Not(A100FMissioniMW.Q020.Active) then
        A100FMissioniMW.Q020.Open;
      A100FMissioniMW.Q020.First;
      while Not(A100FMissioniMW.Q020.Eof) do
      begin
        dgrdRimborsi.Columns[0].PickList.Add(A100FMissioniMW.Q020.FieldByName('CODICE').AsString);
        A100FMissioniMW.Q020.Next;
      end;
      A100FMissioniMW.Q020.First;
    end;
end;

procedure TA100FMISSIONIDTM.ImpostaCampiElaboraMissione;
var
  sDescrizione, sCodice: String;
begin
  if A100FMissioniMW.Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then // Tariffa giornaliera...
    A100FMissioni.lblOreGiorni.Caption:='Giorni'
  else
    A100FMissioni.lblOreGiorni.Caption:='Ore in centesimi';
  // Propongo, se presente, nel campo Località di Partenza la sede
  // di assunzione del dipendente
  if (trim(A100FMissioni.CmbPartenza.Text) = '') then
  begin
    A100FMissioniMW.GetSede(C700Progressivo,M040.FieldByName('DATAA').AsDateTime, M040.FieldByName('DATAA').AsDateTime,sCodice,sDescrizione);
    if sCodice <> '' then
    begin
      A100FMissioni.CmbPartenza.Text:=Format('%-' + inttostr(A100FMissioniMW.nLunghezzaPartenza) + 's',[sCodice]);
      if sDescrizione <> '' then
        A100FMissioni.CmbPartenza.Text:=A100FMissioni.CmbPartenza.Text + ' - ' + sDescrizione;
    end;
  end;

  // Propongo il dato collegato al campo COMMESSA per il dipendente...
  if (trim(A100FMissioni.CmbCommessa.Text) = '') then
  begin
    A100FMissioniMW.GetCommessa(C700Progressivo,M040.FieldByName('DATAA').AsDateTime, M040.FieldByName('DATAA').AsDateTime,sCodice,sDescrizione);
    if SCodice <> '' then
    begin
      A100FMissioni.CmbCommessa.Text:=Format('%-' + inttostr(A100FMissioniMW.nLunghezzaCommessa) + 's',[sCodice]);
      if sDescrizione <> '' then
        A100FMissioni.CmbCommessa.Text:=A100FMissioni.CmbCommessa.Text + ' - ' + sDescrizione;
    end;
  end;
end;

procedure TA100FMISSIONIDTM.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  inherited;
  FreeAndNil(A100FMissioniMW);
  FreeAndNil(A100FImpRimborsiIterMW);
  FreeAndNil(A100FCheckRimbMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
end;
end.
