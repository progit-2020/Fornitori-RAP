unit P652UINPDAPMMRegole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  Db, OracleData, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C009UCopiaSu, Variants, C013UCheckList, System.Actions,
  A000UMessaggi;

type
  TP652FINPDAPMMRegole = class(TR004FGestStorico)
    Panel1: TPanel;
    PnlRegole: TPanel;
    Panel3: TPanel;
    lblCommento: TLabel;
    dmemCommento: TDBMemo;
    PnlFLUPER: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dchkRegolaModificabileFLUPER: TDBCheckBox;
    dchkNumericoFLUPER: TDBCheckBox;
    gpbEsportazioneFile: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dEdtTipoRecordFLUPER: TDBEdit;
    dedtSezioneFileFLUPER: TDBEdit;
    dedtFormatoFileFLUPER: TDBEdit;
    dedtNumeroFileFLUPER: TDBEdit;
    dEdtParteFLUPER: TDBEdit;
    dEdtNumeroFLUPER: TDBEdit;
    dEdtDescrizioneFLUPER: TDBEdit;
    dcmbCodArrotondamentoFLUPER: TDBLookupComboBox;
    dedtFormatoFLUPER: TDBEdit;
    drgpTipoDatoFLUPER: TDBRadioGroup;
    btnFiltroVociFLUPER: TBitBtn;
    btnRipristinaAutomaticaFLUPER: TBitBtn;
    PnlINPDAP: TPanel;
    lblParteCUD: TLabel;
    lblNumeroCUD: TLabel;
    lblDescrizione: TLabel;
    lblCodArrotondamento: TLabel;
    lblFormato: TLabel;
    dchkRegolaModificabile: TDBCheckBox;
    dchkOmettiVuoto: TDBCheckBox;
    dchkNumerico: TDBCheckBox;
    gpbDatiEsportazione: TGroupBox;
    lblTipoRecord: TLabel;
    lblSezione: TLabel;
    lblFormatoFile: TLabel;
    lblNumeroFile: TLabel;
    dedtTipoRecord: TDBEdit;
    dedtSezioneFile: TDBEdit;
    dedtFormatoFile: TDBEdit;
    dchkFormatoAnnoMese: TDBCheckBox;
    dedtNumeroFile: TDBEdit;
    dedtParteCUD: TDBEdit;
    dedtNumeroCUD: TDBEdit;
    dedtDescrizione: TDBEdit;
    dcmbCodArrotondamento: TDBLookupComboBox;
    dedtFormato: TDBEdit;
    drgpTipoDato: TDBRadioGroup;
    btnFiltroVoci: TBitBtn;
    btnRipristinaAutomatica: TBitBtn;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    dLblDescrizioneTredicesimaFLUPER: TDBText;
    dLblDescrizioneArretratiACFLUPER: TDBText;
    dLblDescrizioneArretratiAPFLUPER: TDBText;
    Label11: TLabel;
    dEdtLunghezza: TDBEdit;
    BtnCausaliFLUPER: TButton;
    Label15: TLabel;
    Label13: TLabel;
    dEdtCausaliFLUPER: TDBEdit;
    dCmbNomeDato: TDBComboBox;
    Panel2: TPanel;
    dmemRegolaCalcoloManuale: TDBMemo;
    Panel4: TPanel;
    lblRegolaCalcoloManuale: TLabel;
    dCmbNumeroTredicesimaFLUPER: TDBLookupComboBox;
    dCmbNumeroArretratiACFLUPER: TDBLookupComboBox;
    dCmbNumeroArretratiAPFLUPER: TDBLookupComboBox;
    lblNumeroTredPrec: TLabel;
    dCmbNumeroTredPrecFLUPER: TDBLookupComboBox;
    dLblDescrizioneTredPrecFLUPER: TDBText;
    lblIdCausaleF24: TLabel;
    dedtIdCausaleF24: TDBEdit;
    procedure dCmbNumeroTredicesimaFLUPERKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure btnRipristinaAutomaticaClick(Sender: TObject);
    procedure btnFiltroVociClick(Sender: TObject);
    procedure AbilitaFiltro;
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure BtnCausaliFLUPERClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sPb_NomeFlusso:string;
  end;

var
  P652FINPDAPMMRegole: TP652FINPDAPMMRegole;

procedure OpenP652FINPDAPMMRegole(sNomeFlusso:string);

implementation

uses P652UINPDAPMMRegoleDtM;

{$R *.DFM}

procedure OpenP652FINPDAPMMRegole(sNomeFlusso:string);
var
  sInibizioni:string;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if sNomeFlusso = FLUSSO_INPDAP then
    sInibizioni:='OpenP652FINPDAPMMRegole'
  else if sNomeFlusso = FLUSSO_FLUPER then
    sInibizioni:='OpenP652FFLUPERRegole'
  else if sNomeFlusso = FLUSSO_CREDITI then
    sInibizioni:='OpenP652FFlussoCreditiRegole'
  else
    sInibizioni:='';
  case A000GetInibizioni('Funzione',sInibizioni) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP652FINPDAPMMRegole, P652FINPDAPMMRegole);
  P652FINPDAPMMRegole.sPb_NomeFlusso:=sNomeFlusso;
  Application.CreateForm(TP652FINPDAPMMRegoleDtM, P652FINPDAPMMRegoleDtM);
  try
    P652FINPDAPMMRegole.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P652FINPDAPMMRegole.Free;
    P652FINPDAPMMRegoleDtM.Free;
  end;
end;

procedure TP652FINPDAPMMRegole.FormCreate(Sender: TObject);
begin
  inherited;
  A000SettaVariabiliAmbiente;
  P652FINPDAPMMRegole.sPb_NomeFlusso:=IfThen(P652FINPDAPMMRegole.sPb_NomeFlusso = '',FLUSSO_FLUPER,P652FINPDAPMMRegole.sPb_NomeFlusso); //RIGA PER TEST
end;

procedure TP652FINPDAPMMRegole.FormActivate(Sender: TObject);
var
  MyPanel:Tpanel;
begin
  actCopiaSu.Visible:=False;
//  CopiaDa1.Enabled:=False;
  VisioneCorrente1Click(nil);
  actInserisci.Visible:=False;
  actCancella.Visible:=False;
  btnStoricizza.Enabled:=False;
  //MAN/08 SVILUPPO#181 Riesame del 25/02/2015. non consentire modifica decorrenza
  dedtDecorrenza.Enabled:=False;
  if sPb_NomeFlusso = FLUSSO_INPDAP then
  begin
    MyPanel:=PnlINPDAP;
    PnlRegole.Height:=180;
    P652FINPDAPMMRegole.Caption:='<P652> Regole fornitura INPDAP - DMA';
    P652FINPDAPMMRegole.HelpContext:=3652000;
  end
  else if sPb_NomeFlusso = FLUSSO_FLUPER then
  begin
    MyPanel:=PnlFLUPER;
    PnlRegole.Height:=251;
    P652FINPDAPMMRegole.Caption:='<P652> Regole fornitura FLUPER';
    P652FINPDAPMMRegole.HelpContext:=3652100;
  end
  else if sPb_NomeFlusso = FLUSSO_CREDITI then
  begin
    MyPanel:=PnlFLUPER;
    PnlRegole.Height:=251;
    P652FINPDAPMMRegole.Caption:='<P652> Regole flusso crediti';
    P652FINPDAPMMRegole.HelpContext:=3652200;
  end
  else
    raise exception.Create('Flusso ''' + sPb_NomeFlusso + ''' non riconosciuto.');
  MyPanel.Color:=clBtnFace;
  MyPanel.Align:=alClient;
  MyPanel.Visible:=True;
end;

procedure TP652FINPDAPMMRegole.Copiada1Click(Sender: TObject);
begin
  inherited;
  C009FCopiaSu:=TC009FCopiaSu.Create(nil);
  with C009FCopiaSu do
  try
    ODS:=P652FINPDAPMMRegoleDtM.P660;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TP652FINPDAPMMRegole.btnRipristinaAutomaticaClick(
  Sender: TObject);
begin
  with P652FINPDAPMMRegoleDtM do
  begin
    if (R180MessageBox(A000MSG_P652_DLG_RIPRISTINO_REGOLA ,DOMANDA) = mrYes) then
    begin
      If P660.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString = '' then
        R180MessageBox(A000MSG_P652_MSG_NO_REGOLA,INFORMA)
      else
        P660.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=P660.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
    end;
  end;
end;

procedure TP652FINPDAPMMRegole.btnFiltroVociClick(Sender: TObject);
var
  lstVoci,lstVociSelezionate: TStringList;
  sEsisteContratto: String;
  lenCodice, j,i: Integer;
begin
  try
    lstVoci:=TStringList.Create;
    sEsisteContratto:=P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.FiltroVoci(dmemRegolaCalcoloManuale.SelStart, lstVoci);
    if lstVoci.count = 0 then
      Exit;
    if sEsisteContratto = 'XX' then
      lenCodice:=17
    else
      lenCodice:=11;

    C013FCheckList:=TC013FCheckList.Create(nil);
    C013FCheckList.clbListaDati.Items.Assign(lstVoci);
    C013FCheckList.Caption:='<P602> Filtro Voci';
    for j:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
    begin
      if Pos(Trim(Copy(C013FCheckList.clbListaDati.Items[j],1,lenCodice)),P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.VociSelezionate) > 0 then
        C013FCheckList.clbListaDati.Checked[j]:=True;
    end;
    if C013FCheckList.ShowModal = mrOK then
    begin
      lstVociSelezionate:=TStringList.Create();

      for i:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
      begin
        if C013FCheckList.clbListaDati.Checked[i] then
          lstVociSelezionate.add(Copy(C013FCheckList.clbListaDati.Items[i],1,lenCodice));
      end;
      P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.ImpostaVociFiltro(lstVociSelezionate);
    end;
  finally
    if C013FCheckList <> nil then
      FreeAndNil(C013FCheckList);
    if lstVoci <> nil then
      FreeAndNil(lstVoci);
    if lstVociSelezionate <> nil then
      FreeAndNil(lstVociSelezionate);
  end;
end;

procedure TP652FINPDAPMMRegole.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  AbilitaFiltro;
  if DButton.State = dsBrowse then
  begin
    with P652FINPDAPMMRegoleDtM do
    begin
//      actModifica.Enabled:=(P660.FieldByName('REGOLA_MODIFICABILE').AsString = 'S');      Lorena 08/08/2006
//      actStoricizza.Enabled:=(P660.FieldByName('REGOLA_MODIFICABILE').AsString = 'S');
      actModifica.Enabled:=(P660.FieldByName('REGOLA_MODIFICABILE').AsString = 'S') and (not SolaLettura);
      actStoricizza.Enabled:=(P660.FieldByName('REGOLA_MODIFICABILE').AsString = 'S') and (not SolaLettura);
    end;
  end;
end;

procedure TP652FINPDAPMMRegole.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaFiltro;
  if DButton.State in [dsInsert, dsEdit] then
  begin
    BtnCausaliFLUPER.Enabled:=True;
    dEdtCausaliFLUPER.Color:=clWindow;
    dCmbNomeDato.Enabled:=True;
    dCmbNomeDato.Color:=clWindow;
    dcmbNumeroTredicesimaFLUPER.Enabled:=True;
    dCmbNumeroTredPrecFLUPER.Enabled:=True;
    dcmbNumeroArretratiACFLUPER.Enabled:=True;
    dcmbNumeroArretratiAPFLUPER.Enabled:=True;
    dcmbNumeroTredicesimaFLUPER.Color:=clWindow;
    dcmbNumeroTredPrecFLUPER.Color:=clWindow;
    dcmbNumeroArretratiACFLUPER.Color:=clWindow;
    dcmbNumeroArretratiAPFLUPER.Color:=clWindow;
    dmemRegolaCalcoloManuale.Color:=clWindow;
  end
  else
  begin
    BtnCausaliFLUPER.Enabled:=False;
    dEdtCausaliFLUPER.Color:=cl3DLight;
    dCmbNomeDato.Enabled:=False;
    dCmbNomeDato.Color:=cl3DLight;
    dCmbNumeroTredicesimaFLUPER.Enabled:=False;
    dCmbNumeroTredPrecFLUPER.Enabled:=False;
    dCmbNumeroArretratiACFLUPER.Enabled:=False;
    dCmbNumeroArretratiAPFLUPER.Enabled:=False;
    dCmbNumeroTredicesimaFLUPER.Color:=cl3DLight;
    dCmbNumeroTredPrecFLUPER.Color:=cl3DLight;
    dCmbNumeroArretratiACFLUPER.Color:=cl3DLight;
    dCmbNumeroArretratiAPFLUPER.Color:=cl3DLight;
    dmemRegolaCalcoloManuale.Color:=cl3DLight;
  end;
end;

procedure TP652FINPDAPMMRegole.AbilitaFiltro;
begin
  btnFiltroVoci.Enabled:=False;
  btnFiltroVociFLUPER.Enabled:=False;
  btnRipristinaAutomatica.Enabled:=False;
  btnRipristinaAutomaticaFLUPER.Enabled:=False;
  if (DButton.State <> dsBrowse) and
     (P652FINPDAPMMRegoleDtM.P660.FieldByName('REGOLA_MODIFICABILE').AsString = 'S') then
  begin
    with P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW do
    begin
      btnRipristinaAutomatica.Enabled:=CanRipristinaAutomatica;
      btnRipristinaAutomaticaFLUPER.Enabled:=btnRipristinaAutomatica.Enabled;

      btnFiltroVoci.Enabled:=CanFiltroVoci;
      btnFiltroVociFLUPER.Enabled:=btnFiltroVoci.Enabled;
    end;
  end;
end;

procedure TP652FINPDAPMMRegole.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  NomiCampiR001.Clear;
  if (sPb_NomeFlusso = FLUSSO_FLUPER) or (sPb_NomeFlusso = FLUSSO_CREDITI) then
  begin
    QueryStampa.Add('SELECT  T1.NOME_FLUSSO,');
    NomiCampiR001.Add('NOME_FLUSSO');
    QueryStampa.Add('        T1.DECORRENZA,');
    NomiCampiR001.Add('DECORRENZA');
    QueryStampa.Add('        T1.PARTE,');
    NomiCampiR001.Add('PARTE');
    QueryStampa.Add('        T1.NUMERO,');
    NomiCampiR001.Add('NUMERO');
    QueryStampa.Add('        T1.DESCRIZIONE,');
    NomiCampiR001.Add('DESCRIZIONE');
    QueryStampa.Add('        T1.TIPO_RECORD,');
    NomiCampiR001.Add('TIPO_RECORD');
    QueryStampa.Add('        T1.SEZIONE_FILE,');
    NomiCampiR001.Add('SEZIONE_FILE');
    QueryStampa.Add('        T1.NUMERO_FILE,');
    NomiCampiR001.Add('NUMERO_FILE');
    QueryStampa.Add('        T1.FORMATO_FILE,');
    NomiCampiR001.Add('FORMATO_FILE');
    QueryStampa.Add('        T1.LUNGHEZZA_FILE,');
    NomiCampiR001.Add('LUNGHEZZA_FILE');
    QueryStampa.Add('        T1.FORMATO_ANNOMESE,');
    NomiCampiR001.Add('FORMATO_ANNOMESE');
    QueryStampa.Add('        T1.NUMERICO,');
    NomiCampiR001.Add('NUMERICO');
    QueryStampa.Add('        T1.COD_ARROTONDAMENTO,');
    NomiCampiR001.Add('COD_ARROTONDAMENTO');
    QueryStampa.Add('        T1.FORMATO,');
    NomiCampiR001.Add('FORMATO');
    QueryStampa.Add('        T1.OMETTI_VUOTO,');
    NomiCampiR001.Add('OMETTI_VUOTO');
    QueryStampa.Add('        T1.TIPO_DATO,');
    NomiCampiR001.Add('TIPO_DATO');
    QueryStampa.Add('        T1.REGOLA_CALCOLO_AUTOMATICA,');
    NomiCampiR001.Add('REGOLA_CALCOLO_AUTOMATICA');
    QueryStampa.Add('        T1.REGOLA_CALCOLO_MANUALE,');
    NomiCampiR001.Add('REGOLA_CALCOLO_MANUALE');
    QueryStampa.Add('        T1.REGOLA_MODIFICABILE,');
    NomiCampiR001.Add('REGOLA_MODIFICABILE');
    QueryStampa.Add('        T1.COMMENTO,');
    NomiCampiR001.Add('COMMENTO');
    QueryStampa.Add('        T1.FL_NUMERO_TREDICESIMA,');
    NomiCampiR001.Add('FL_NUMERO_TREDICESIMA');
    QueryStampa.Add('        P660BA.DESCRIZIONE AS DESC_FL_NUMERO_TREDICESIMA,');
    NomiCampiR001.Add('DESC_FL_NUMERO_TREDICESIMA');
    QueryStampa.Add('        T1.FL_NUMERO_ARRCORR,');
    NomiCampiR001.Add('FL_NUMERO_ARRCORR');
    QueryStampa.Add('        P660BB.DESCRIZIONE AS DESC_FL_NUMERO_ARRCORR,');
    NomiCampiR001.Add('DESC_FL_NUMERO_ARRCORR');
    QueryStampa.Add('        T1.FL_NUMERO_ARRPREC,');
    NomiCampiR001.Add('FL_NUMERO_ARRPREC');
    QueryStampa.Add('        P660BC.DESCRIZIONE  AS DESC_FL_NUMERO_ARRPREC');
    NomiCampiR001.Add('DESC_FL_NUMERO_ARRPREC');
    QueryStampa.Add('   FROM P660_FLUSSIREGOLE T1, P660_FLUSSIREGOLE P660BA, P660_FLUSSIREGOLE P660BB, P660_FLUSSIREGOLE P660BC');
    QueryStampa.Add('  WHERE T1.FL_NUMERO_TREDICESIMA=P660BA.NUMERO(+)');
    QueryStampa.Add('    AND T1.DECORRENZA=P660BA.DECORRENZA(+)');
    QueryStampa.Add('    AND T1.PARTE=P660BA.PARTE(+)');
    QueryStampa.Add('    AND T1.FL_NUMERO_ARRCORR=P660BB.NUMERO(+)');
    QueryStampa.Add('    AND T1.DECORRENZA=P660BB.DECORRENZA(+)');
    QueryStampa.Add('    AND T1.PARTE=P660BB.PARTE(+)');
    QueryStampa.Add('    AND T1.FL_NUMERO_ARRPREC=P660BC.NUMERO(+)');
    QueryStampa.Add('    AND T1.DECORRENZA=P660BC.DECORRENZA(+)');
    QueryStampa.Add('    AND T1.PARTE=P660BC.PARTE(+)');
    QueryStampa.Add('    AND T1.NOME_FLUSSO=''' + sPb_NomeFlusso + '''');
  end
  else if sPb_NomeFlusso = FLUSSO_INPDAP then
  begin
    QueryStampa.Add('SELECT  T1.NOME_FLUSSO,');
    NomiCampiR001.Add('NOME_FLUSSO');
    QueryStampa.Add('        T1.DECORRENZA,');
    NomiCampiR001.Add('DECORRENZA');
    QueryStampa.Add('        T1.PARTE,');
    NomiCampiR001.Add('PARTE');
    QueryStampa.Add('        T1.NUMERO,');
    NomiCampiR001.Add('NUMERO');
    QueryStampa.Add('        T1.DESCRIZIONE,');
    NomiCampiR001.Add('DESCRIZIONE');
    QueryStampa.Add('        T1.TIPO_RECORD,');
    NomiCampiR001.Add('TIPO_RECORD');
    QueryStampa.Add('        T1.SEZIONE_FILE,');
    NomiCampiR001.Add('SEZIONE_FILE');
    QueryStampa.Add('        T1.NUMERO_FILE,');
    NomiCampiR001.Add('NUMERO_FILE');
    QueryStampa.Add('        T1.FORMATO_FILE,');
    NomiCampiR001.Add('FORMATO_FILE');
    QueryStampa.Add('        T1.LUNGHEZZA_FILE,');
    NomiCampiR001.Add('LUNGHEZZA_FILE');
    QueryStampa.Add('        T1.FORMATO_ANNOMESE,');
    NomiCampiR001.Add('FORMATO_ANNOMESE');
    QueryStampa.Add('        T1.NUMERICO,');
    NomiCampiR001.Add('NUMERICO');
    QueryStampa.Add('        T1.COD_ARROTONDAMENTO,');
    NomiCampiR001.Add('COD_ARROTONDAMENTO');
    QueryStampa.Add('        T1.FORMATO,');
    NomiCampiR001.Add('FORMATO');
    QueryStampa.Add('        T1.OMETTI_VUOTO,');
    NomiCampiR001.Add('OMETTI_VUOTO');
    QueryStampa.Add('        T1.TIPO_DATO,');
    NomiCampiR001.Add('TIPO_DATO');
    QueryStampa.Add('        T1.REGOLA_CALCOLO_AUTOMATICA,');
    NomiCampiR001.Add('REGOLA_CALCOLO_AUTOMATICA');
    QueryStampa.Add('        T1.REGOLA_CALCOLO_MANUALE,');
    NomiCampiR001.Add('REGOLA_CALCOLO_MANUALE');
    QueryStampa.Add('        T1.REGOLA_MODIFICABILE,');
    NomiCampiR001.Add('REGOLA_MODIFICABILE');
    QueryStampa.Add('        T1.COMMENTO');
    NomiCampiR001.Add('COMMENTO');
    QueryStampa.Add('   FROM P660_FLUSSIREGOLE T1');
    QueryStampa.Add('  WHERE T1.NOME_FLUSSO=''' + sPb_NomeFlusso + '''');
  end;
  inherited;
end;

procedure TP652FINPDAPMMRegole.TGommaClick(Sender: TObject);
begin
  if ActiveControl is TDBEdit then
    if ((ActiveControl as TDBEdit).Name = dedtDescrizione.Name)
    or ((ActiveControl as TDBEdit).Name = dEdtDescrizioneFLUPER.Name) then
      exit;
  inherited;
end;

procedure TP652FINPDAPMMRegole.actRefreshExecute(Sender: TObject);
begin
  if sPb_NomeFlusso = FLUSSO_FLUPER then
  begin
    P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.v430.Close;
    P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.v430.Open;
  end;
  inherited;
end;

procedure TP652FINPDAPMMRegole.BtnCausaliFLUPERClick(Sender: TObject);
var
  elencoValori: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    begin
      clbListaDati.Items.Clear;
      clbListaDati.Items.Add('*** Presenza');
      try
        elencoValori:=P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.getListPresenze;
        clbListaDati.Items.AddStrings(elencoValori.lstDescrizione);
      finally
        FreeAndNil(elencoValori);
      end;
      clbListaDati.Items.Add('*** Assenza');
      try
        elencoValori:=P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW.getListAssenze;
      clbListaDati.Items.AddStrings(elencoValori.lstDescrizione);
      finally
        FreeAndNil(elencoValori);
      end;
    end;
    R180PutCheckList(dEdtCausaliFLUPER.Field.AsString,5,clbListaDati);
    if ShowModal = mrOK then
      dEdtCausaliFLUPER.Field.AsString:=StringReplace(StringReplace(R180GetCheckList(5,clbListaDati),'*** A','',[]),'*** P','',[]);
  finally
    Free;
  end;
end;

procedure TP652FINPDAPMMRegole.FormShow(Sender: TObject);
begin
  inherited;
  //CARICO LA COMBO NOME_DATO
  with P652FINPDAPMMRegoleDtM.P652FINPDAPMMRegoleMW do
  begin
    dCmbNomeDato.Items.Clear;
    V430.First;
    while not V430.Eof do
    begin
      dCmbNomeDato.Items.Add(V430.FieldByName('COLUMN_NAME').AsString);
      V430.Next;
    end;
  end;
end;

procedure TP652FINPDAPMMRegole.dCmbNumeroTredicesimaFLUPERKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
