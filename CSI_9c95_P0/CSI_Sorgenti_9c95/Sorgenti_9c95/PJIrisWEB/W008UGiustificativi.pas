unit W008UGiustificativi;

interface

uses
  A000USessione, A000UInterfaccia, A000UCostanti, B021UUtils,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  A004UGiustifAssPresMW, R012UWebAnagrafico, RegistrazioneLog,
  A000UMessaggi, W000UMessaggi, R600, W010UCalcoloCompetenzeFM,
  SysUtils, Classes, Graphics, Controls, IWApplication,
  IWTemplateProcessorHTML, IWCompLabel, IWControl,
  IWHTMLControls, IWCompListbox, IWCompEdit, IWCompButton, Oracle, OracleData,
  IWCompCheckbox, IWDBGrids, Variants,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, Forms,
  IWVCLBaseContainer, IWContainer,
  IWVCLComponent, DatiBloccati, StrUtils,
  RpCon, RpConDS, RpSystem, RpDefine, RpRave, RVCsStd, RVData,
  RvDirectDataView, RpRender, RpRenderPDF, RVClass, RVProj, DBClient,
  DB, Math, meIWImageFile,
  IWCompGrids, IWCompExtCtrls, meIWLabel, meIWLink, meIWDBGrid, meIWGrid,
  meIWRadioGroup, meIWCheckBox, meIWComboBox, meIWEdit, meIWButton,
  IWCompJQueryWidget, WA004URecapitoVisFiscaliFM;

type
  TW008FGiustificativi = class(TR012FWebAnagrafico)
    btnVisualizza: TmeIWButton;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    cmbCausale: TmeIWComboBox;
    btnInserisci: TmeIWButton;
    btnCancella: TmeIWButton;
    chkFiltro: TmeIWCheckBox;
    rgpTipoGiust: TmeIWRadioGroup;
    edtDaOre: TmeIWEdit;
    btnVisualizzaRiepilogo: TmeIWButton;
    grdRiepilogo: TmeIWGrid;
    lblCausale: TmeIWLabel;
    grdAnomalie: TmeIWGrid;
    lblFamiliari: TmeIWLabel;
    cmbFamiliari: TmeIWComboBox;
    lblCausali: TmeIWLabel;
    edtAOre: TmeIWEdit;
    edtRiepAl: TmeIWEdit;
    lblRiepAl: TmeIWLabel;
    grdGiustificativi: TmeIWDBGrid;
    rgpCausali: TmeIWRadioGroup;
    chkStampaRicevuta: TmeIWCheckBox;
    cdsAutorizzazione: TClientDataSet;
    cdsAutorizzazionePROGRESSIVO: TIntegerField;
    cdsAutorizzazioneNOMINATIVO: TStringField;
    cdsAutorizzazioneMATRICOLA: TStringField;
    cdsAutorizzazioneSESSO: TStringField;
    cdsAutorizzazioneCAUSALE: TStringField;
    cdsAutorizzazioneD_CAUSALE: TStringField;
    cdsAutorizzazioneTIPOGIUST: TStringField;
    cdsAutorizzazioneDAL: TDateField;
    cdsAutorizzazioneAL: TDateField;
    cdsAutorizzazioneNUMEROORE: TStringField;
    cdsAutorizzazioneAORE: TStringField;
    cdsAutorizzazioneRESPONSABILE: TStringField;
    cdsAutorizzazioneD_RESPONSABILE: TStringField;
    cdsAutorizzazioneC_OGGETTO: TStringField;
    cdsAutorizzazioneC_PERIODO_AUT: TStringField;
    cdsAutorizzazioneC_PERIODO_RICH: TStringField;
    cdsAutorizzazioneC_TESTO_RICH: TStringField;
    cdsAutorizzazioneC_TESTO_AUT: TStringField;
    btnNascondiRiepilogo: TmeIWButton;
    edtNote: TmeIWEdit;
    lblNote: TmeIWLabel;
    btnStampaRicevuta: TmeIWButton;
    cdsAutorizzazioneDAL_MG: TStringField;
    cdsAutorizzazioneDAL_NOTE: TStringField;
    cdsAutorizzazioneAL_MG: TStringField;
    cdsAutorizzazioneAL_NOTE: TStringField;
    cdsAutorizzazioneGG_INTERE: TStringField;
    cdsAutorizzazioneC_DATA: TStringField;
    cdsAutorizzazioneC_FIRMA: TStringField;
    btnRecapitoAlternativo: TmeIWButton;
    chkAutorizzazioneCompleta: TmeIWCheckBox;
    rgpTipoMG: TmeIWRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure grdGiustificativiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnCancellaClick(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnVisualizzaRiepilogoClick(Sender: TObject);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure rgpCausaliClick(Sender: TObject);
    procedure chkFiltroClick(Sender: TObject);
    procedure StampaRicevuta;
    procedure IWAppFormRender(Sender: TObject);
    procedure btnNascondiRiepilogoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkStampaRicevutaClick(Sender: TObject);
    procedure btnStampaRicevutaClick(Sender: TObject);
    procedure btnRecapitoAlternativoClick(Sender: TObject);
    procedure chkAutorizzazioneCompletaAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    A004MW: TA004FGiustifAssPresMW;
    Dal,Al:TDateTime;
    TG:String;
    VisualizzaNote:Boolean;
    PrintRicevuta: Boolean;
    //rave report
    rvSystem:TRVSystem;
    rvDWDettaglio:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connDettaglio:TRVDataSetConnection;
    ScalaStampa:Real;
    W010CalcoloCompetenzeFM:TW010FCalcoloCompetenzeFM;
    WA004RecapitoFM:TWA004FRecapitoVisFiscaliFM;
    ListaFamiliari: TStringList; // BARI_POLICLINICO - chiamata 81479
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CallBackNameCausaleChange: String;
    GestioneTipoMezzaGiornata: Boolean;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    procedure GetCausaliDisponibili;
    procedure GetFamiliari;
    procedure imgDettaglioClick(Sender: TObject);
    procedure CalcoloPeriodiAssenza;
    procedure ElaboraInsCan(Sender: TObject);
    procedure ControllaRecapitoAlternativo;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    procedure OnCausaleChange(EventParams: TStringList);
    procedure OnTipoGiustChange(EventParams: TStringList);
    procedure AbilitaTipoMG(const PCausale: String; const PMezzaGiornata: Boolean);
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure ImpostaJQuery;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
const
  PAR_CODCAUS_CALLBACK   = 'codcausale';
  PAR_MG_CALLBACK        = 'mg';
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

implementation

uses W001UIrisWebDtM, IWGlobal, SyncObjs;

{$R *.DFM}

function TW008FGiustificativi.InizializzaAccesso:Boolean;
var x:Integer;
begin
  Result:=True;
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  edtDaData.Text:=DateToStr(Dal);
  edtAData.Text:=DateToStr(Al);
  if ParametriForm.Causale <> '' then
  begin
    x:=R180IndexOf(cmbCausale.Items,ParametriForm.Causale,5);
    if x >= 0 then
      cmbCausale.ItemIndex:=x
    else
    begin
      rgpCausali.ItemIndex:=1;
      rgpCausaliClick(rgpCausali);
      x:=R180IndexOf(cmbCausale.Items,ParametriForm.Causale,5);
      if x >= 0 then
        cmbCausale.ItemIndex:=x
      else
      begin
        rgpCausali.ItemIndex:=0;
        rgpCausaliClick(rgpCausali);
      end;
    end;
  end;
  if cmbCausale.Items.Count = 0 then
  begin
    rgpCausali.ItemIndex:=IfThen(rgpCausali.ItemIndex = 0,1,0);
    rgpCausaliClick(rgpCausali);
  end;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  ImpostaJQuery;
  btnNascondiRiepilogoAsyncClick(nil,nil);
  if ParametriForm.Chiamante = 'W005' then
    btnVisualizzaClick(nil);
end;

procedure TW008FGiustificativi.IWAppFormCreate(Sender: TObject);
var
  Q: TOracleQuery;
begin
  inherited;
  Dal:=Parametri.DataLavoro;
  Al:=Parametri.DataLavoro;
  lblCausale.Caption:='';
  edtRiepAl.Text:=DateToStr(Parametri.DataLavoro);
  grdAnomalie.Visible:=False;
  chkAutorizzazioneCompleta.Visible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];

  // creazione middleware A004 per gestione giustificativi
  A004MW:=TA004FGiustifAssPresMW.Create(Self);
  A004MW.Chiamante:='W008';
  A004MW.GestioneSingolaDM:=True;
  A004MW.SelAnagrafe:=selAnagrafeW;
  grdGiustificativi.DataSource:=A004MW.dsrVisualizza;

  // BARI_POLICLINICO - chiamata 81479.ini
  ListaFamiliari:=TStringList.Create;
  // BARI_POLICLINICO - chiamata 81479.fine

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // registra funzione di callback
  CallBackNameCausaleChange:=UpperCase(Self.Name) + '.OnCausaleChange';
  GGetWebApplicationThreadVar.RegisterCallBack(CallBackNameCausaleChange,OnCausaleChange);
  GGetWebApplicationThreadVar.RegisterCallBack('W008_OnTipoGiustChange',OnTipoGiustChange);
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  // impostazioni datamodule condiviso
  WR000DM.selT265.Open;
  WR000DM.selT275.Open;
  WR000DM.selT265.Filtered:=True;
  WR000DM.selT275.Filtered:=True;
  rgpCausaliClick(nil);

  btnInserisci.Visible:=not SolaLettura;
  btnCancella.Visible:=not SolaLettura;
  chkStampaRicevuta.Visible:=not SolaLettura;
  btnStampaRicevuta.Visible:=not SolaLettura;
  btnRecapitoAlternativo.Visible:=not SolaLettura;

  with WR000DM do
  begin
    selT040.Tag:=selT040.Tag + 1;
    selT265.Tag:=selT265.Tag + 1;
    selT275.Tag:=selT275.Tag + 1;
    selSG101.Tag:=selSG101.Tag + 1;
    selSG101Causali.Tag:=selSG101Causali.Tag + 1;
  end;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  // visualizzazione e posizionamento del radiogroup tipo mezza giornata
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.ReadBuffer:=2;
    Q.SQL.Add('select sum(nvl(CSI_MAX_MGMAT,0) + nvl(CSI_MAX_MGPOM,0)) MAX_MG_TOT ');
    Q.SQL.Add('from   T265_CAUASSENZE ');
    Q.Execute;
    GestioneTipoMezzaGiornata:=Q.FieldAsInteger(0) > 0;
  finally
    FreeAndNil(Q);
  end;
  rgpTipoMG.Visible:=GestioneTipoMezzaGiornata;
  A004MW.Q040B.FieldByName('D_CSI_TIPO_MG').Visible:=GestioneTipoMezzaGiornata;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

  Log('Traccia','Create completato');
end;

procedure TW008FGiustificativi.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW008FGiustificativi.IWAppFormRender(Sender: TObject);
var
  Caus: String;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  JsCode: String;
  LFattoreCorrezioneLeft: Integer;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
begin
  inherited;

  // abilitazioni tipo fruizione
  if (not MsgBox.IsActive) then
  begin
    Caus:=Trim(Copy(cmbCausale.Text,1,5));
    if Caus <> '' then
      AddToInitProc('CausaleCambiata("' + Caus + '");');
  end;

  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
  if GestioneTipoMezzaGiornata then
  begin
    LFattoreCorrezioneLeft:=-7;
    JsCode:=Format('var p = $("#%s"); '#13#10 +
                   'var offset = p.offset(); '#13#10 +
                   '$("#%s").offset({ left: offset.left + %d}); ',
                   [rgpTipoGiust.HTMLName + '_INPUT_2',rgpTipoMG.HTMLName,LFattoreCorrezioneLeft]);
    AddToInitProc(JsCode);
  end;
  // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
end;

procedure TW008FGiustificativi.GetCausaliDisponibili;
{ Popola la combo delle causali disponibili (assenza oppure presenza)
  Inoltre prepara un array associativo in javascript per abilitare / disabilitare
  i radiobutton di scelta del tipo di fruizione (giornata, mezza gg., num. ore, da ore - a ore)

  Per le causali di ASSENZA l'array è così impostato
    arrCausFruiz["CAUSALE_1"] = bbbb;
    arrCausFruiz["CAUSALE_2"] = bbbb;
    arrCausFruiz["CAUSALE_3"] = bbbb;
    ...

    bbbb è una stringa di 4 cifre binarie che indicano il tipo di fruizione
         abilitato (0 = disabilitato, 1 = abilitato).

    pos. 1: fruizione a giornata
    pos. 2: fruizione a mezza giornata
    pos. 3: fruizione a num. ore
    pos. 4: fruizione di tipo da ore - a ore

  Per le causali di PRESENZA l'array è simile, ma la stringa è di 2 sole cifre binarie
    arrCausFruiz["CAUSALE_1"] = bb;
    arrCausFruiz["CAUSALE_2"] = bb;
    ..

    pos. 1: fruizione a num. ore
    pos. 2: fruizione di tipo da ore - a ore

  Viene inoltre predisposto un array associativo per le causali di assenza
  arrCausFam["CAUSALE_1"] = b

  b è una stringa di una cifra: 0 = no gestione familiari, 1 = gestione familiari
}
var
  Q: TOracleDataSet;
  Codice,JsCodeFruiz,FruizG,FruizMG,FruizN,FruizD,JsCodeFam,Fam,JsCodeVisFisc,VisFisc: String;
begin
  Log('Traccia','GetCausaliDisponibili - inizio');
  //Elenco causali disponibii
  if rgpCausali.ItemIndex = 0 then
    Q:=WR000DM.selT265
  else
    Q:=WR000DM.selT275;
  cmbCausale.Items.Clear;

  // prepara un array associativo (in javascript) per abilitare / disabilitare
  // i radiobutton di scelta del tipo di fruizione (giornata, mezza gg.,...)
  JsCodeFruiz:=IfThen(Q.RecordCount > 0,'var arrCausFruiz = { ','');

  // prepara un array associativo (in javascript) per abilitare / disabilitare
  // la gestione dei familiari
  JsCodeFam:=IfThen((rgpCausali.ItemIndex = 0) and (Q.RecordCount > 0),'var arrCausFam = { ','');

  // prepara un array associativo (in javascript) per abilitare / disabilitare
  // la gestione delle visite fiscali
  JsCodeVisFisc:=IfThen((rgpCausali.ItemIndex = 0) and (Q.RecordCount > 0),'var arrCausVisFisc = { ','');

  Log('Traccia','GetCausaliDisponibili: popolamento - inizio');
  //Q.Close;
  Q.Open;
  Q.First;
  while not Q.Eof do
  begin
    // salva dati in variabili di appoggio
    Codice:=Q.FieldByName('CODICE').AsString;
    // imposta le tipologie di fruizione abilitate sull'array javascript di appoggio
    if rgpCausali.ItemIndex = 0 then
    begin
      // assenza: fruizione a giornata e mezza giornata significative
      FruizG:=IfThen(Q.FieldByName('UM_INSERIMENTO').AsString = 'S','1','0');
      FruizMG:=IfThen(Q.FieldByName('UM_INSERIMENTO_MG').AsString = 'S','1','0');
    end;
    FruizN:=IfThen(Q.FieldByName('UM_INSERIMENTO_H').AsString = 'S','1','0');
    FruizD:=IfThen(Q.FieldByName('UM_INSERIMENTO_D').AsString = 'S','1','0');
    // aggiunge elemento all'array javascript
    JsCodeFruiz:=JsCodeFruiz + '"' + Codice + '":"' +
            IfThen(rgpCausali.ItemIndex = 0,FruizG + FruizMG) +
            FruizN + FruizD + '", ';

    // imposta abilitazione a gestione familiari sull'array javascript di appoggio
    if rgpCausali.ItemIndex = 0 then
    begin
      Fam:=IfThen((R180CarattereDef(Q.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
                  (R180CarattereDef(Q.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D']),'1','0');
      JsCodeFam:=JsCodeFam + '"' + Codice + '":"' + Fam + '", ';
    end;

    // imposta abilitazione a gestione visite fiscali sull'array javascript di appoggio
    if rgpCausali.ItemIndex = 0 then
    begin
      VisFisc:=IfThen(Q.FieldByName('VISITA_FISCALE').AsString = 'S','1','0');
      JsCodeVisFisc:=JsCodeVisFisc + '"' + Codice + '":"' + VisFisc + '", ';
    end;

    if (not Parametri.ModuloInstallato['TORINO_CSI_PRV']) or
       ((Codice = 'STAUT') and (Parametri.ProfiloWEB = 'DIRIGENTE'))
    then
      cmbCausale.Items.Add(Format('%-5s %s',[Codice,Q.FieldByName('DESCRIZIONE').AsString]));

    Q.Next;
  end;
  cmbCausale.RequireSelection:=cmbCausale.Items.Count > 0;
  cmbCausale.ItemIndex:=0;

  Log('Traccia','GetCausaliDisponibili: popolamento - fine');

  if JsCodeFruiz = '' then
    Exit;

  // imposta il javascript da includere nel documento
  with JavaScript do
  begin
    Clear;
    Add(Copy(JsCodeFruiz,1,Length(JsCodeFruiz) - 2) + ' };');
    if JsCodeFam <> '' then
      Add(Copy(JsCodeFam,1,Length(JsCodeFam) - 2) + ' };');
    if JsCodeVisFisc <> '' then
      Add(Copy(JsCodeVisFisc,1,Length(JsCodeVisFisc) - 2) + ' };');
    Add(' ');
    Add('var NoteGiustificativi = ' + IfThen(Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S','true','false') + ';');
    Add('var GestVisFisc = "0";');
    Add('function CausaleCambiata(CodCausale) {');
    Add('  CodCausale = trim(CodCausale); ');
    Add('  if (CodCausale == "") ');
    Add('    return; ');
    Add('  try { ');
    //Add('    // 1. abilitazione gestione familiari (solo per assenze)');
    Add('    try { ');
    Add('      if (FindElem("RGPCAUSALI_INPUT_1").checked) { ');
    Add('        var lblFamiliariElem = FindElem("' + lblFamiliari.HTMLName + '"); ');
    Add('        var cmbFamiliariElem = FindElem("' + cmbFamiliari.HTMLName + '"); ');
    Add('        var GestFam = arrCausFam[CodCausale]; ');
    Add('        //alert("Familiari = " + GestFam); ');
    Add('        cmbFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('        lblFamiliariElem.style.visibility = (GestFam == "1") ? "visible" : "hidden";');
    Add('      } ');
    Add('    } ');
    Add('    catch(err) { ');
  //Add('      //alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    }');
  //Add('    // 2. abilitazione tipologie di fruizione ');
  //Add('    // inizializzazione variabili di appoggio ');
    Add('    var edtOreElem = FindElem("' + edtDaOre.HTMLName + '"); ');
    Add('    var edtAOreElem = FindElem("' + edtAOre.HTMLName + '"); ');
    Add('    var btnInserisciElem = FindElem("' + btnInserisci.HTMLName + '"); ');
    Add('    var btnCancellaElem = FindElem("' + btnCancella.HTMLName + '"); ');
    Add('    var Fruizioni = arrCausFruiz[CodCausale]; ');
    Add('    var lblNoteElem = FindElem("' + lblNote.HTMLName + '"); ');
    Add('    var edtNoteElem = FindElem("' + edtNote.HTMLName + '"); ');
    //Add('    var chkAutorizzazioneCompletaElem = FindElem("CHKAUTORIZZAZIONECOMPLETA"); ');
    Add('    var chkAutorizzazioneCompletaElem = FindElem("' + chkAutorizzazioneCompleta.HTMLName + '_CHECKBOX"); ');
  //Add('    // creazione array di puntatori agli input di tipo radiobutton');
    Add('    numElem = (FindElem("' + rgpCausali.HTMLName + '_INPUT_1").checked)? 4 : 2; ');
    Add('    var arrRbTipo = new Array(numElem); ');
    Add('    for (i = 0; i < numElem; i++) ');
    Add('      arrRbTipo[i] = FindElem("' + rgpTipoGiust.HTMLName + '_INPUT_" + (i + 1)); ');
  //Add('    // anomalia se nessun tipo fruizione è abilitato');
    Add('    if ((Fruizioni == "00") || (Fruizioni == "0000")) ');
    Add('      alert("La causale selezionata non ha nessuna tipologia di fruizione abilitata!"); ');
  //Add('    // abilitazioni dei radiobutton per il tipo fruizione ');
    Add('    var indexChecked = -1; ');
    Add('    var firstEnabled = -1; ');
    Add('    for (i = numElem - 1; i >= 0; i--) { ');
    Add('      if (Fruizioni.substr(i,1) == "0") { ');
    Add('        arrRbTipo[i].style.visibility = "hidden"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "hidden"; ');
    Add('        if (arrRbTipo[i].checked) { ');
    Add('          arrRbTipo[i].checked = false; ');
    Add('          if (i > 0) ');
    Add('            arrRbTipo[i - 1].checked = true; ');
    Add('        } ');
    Add('      } ');
    Add('      else { ');
    Add('        firstEnabled = i; ');
    Add('        arrRbTipo[i].style.visibility = "visible"; ');
    Add('        arrRbTipo[i].nextSibling.style.visibility = "visible"; ');
    Add('      } ');
    Add('      if (arrRbTipo[i].checked) ');
    Add('        indexChecked = i; ');
    Add('    } ');
    Add('    // verifica se dopo il ciclo nessun radiobutton risulta selezionato ');
    Add('    if (indexChecked == -1) { ');
    Add('      // seleziona il primo radiobutton abilitato (se presente)');
    Add('      if (firstEnabled > -1) { ');
    Add('        indexChecked = firstEnabled; ');
    Add('        arrRbTipo[indexChecked].checked = true; ');
    Add('      } ');
    Add('    } ');
    Add('    // gestione disabilitazione pulsanti (caso di nessuna fruizione possibile) ');
    Add('    if (btnInserisciElem != null) ');
    Add('      btnInserisciElem.disabled = (firstEnabled == -1); ');
    Add('    if (btnCancellaElem != null) ');
    Add('      btnCancellaElem.disabled = (firstEnabled == -1); ');
  //Add('    // abilitazioni campi da ore / a ore ');
  //Add('    //edtOreElem.disabled = (indexChecked <= ((numElem == 4)? 0 : -1)); ');
  //Add('    //edtAOreElem.disabled = (indexChecked < (numElem - 1)); ');
    Add('    edtOreElem.style.visibility = (indexChecked <= ((numElem == 4)? 0 : -1)) ? "hidden" : "visible"; ');
    Add('    edtAOreElem.style.visibility = (indexChecked < (numElem - 1)) ? "hidden" : "visible"; ');
    Add('    if (indexChecked <= ((numElem == 4)? 0 : -1)) ');
    Add('      edtOreElem.value = ""; ');
    Add('    if (indexChecked < (numElem - 1)) ');
    Add('      edtAOreElem.value = ""; ');

    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
    begin
      Add('      if (CodCausale != "STAUT")');
      Add('        {chkAutorizzazioneCompletaElem.checked = false;}');
      Add('      chkAutorizzazioneCompletaElem.style.visibility = (CodCausale == "STAUT") ? "visible" : "hidden";');
    end;

    Add('    lblNoteElem.style.visibility = (indexChecked == ((numElem == 4)? 1 : -1)) ? "visible" : "hidden"; ');
    Add('    edtNoteElem.style.visibility = lblNoteElem.style.visibility; ');
    //Add('    // 3. abilitazione gestione visite fiscali (solo per assenze)');
    Add('    try { ');
    Add('      var btnRecapitoAlternativo = FindElem("' + btnRecapitoAlternativo.HTMLName + '"); ');
    Add('      if (btnRecapitoAlternativo != null) {');
    Add('        btnRecapitoAlternativo.style.visibility = "hidden"; ');
    Add('        GestVisFisc = arrCausVisFisc[CodCausale]; ');
    Add('        //alert("Visite fiscali = " + GestVisFisc); ');
    Add('        btnRecapitoAlternativo.style.visibility = ((indexChecked == ((numElem == 4)? 0 : -1)) && (GestVisFisc == "1")) ? "visible" : "hidden"; ');
    Add('      } ');
    Add('    } ');
    Add('    catch(err) { ');
    Add('      //alert("Errore: " + err.message + "\n" + err.description); ');
    Add('    }');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    // richiama funzione delphi in async per gestione tipologia mezza giornata
    Add('    var MG = ((FindElem("RGPTIPOGIUST_INPUT_2").checked)? "S" : "N"); ');
    Add('    executeAjaxEvent("&' + PAR_CODCAUS_CALLBACK + '=" + encodeURI(CodCausale) + "&' + PAR_MG_CALLBACK + '=" + MG,null,"' + CallBackNameCausaleChange + '",false,null,false); ');
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Add('  } ');
    Add('  catch(err) { ');
    Add('    alert("Errore: " + err.message + "\n" + err.description); ');
    Add('  }');
    Add('}');
  end;
  Log('Traccia','GetCausaliDisponibili - fine');
end;

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW008FGiustificativi.AbilitaTipoMG(const PCausale: String; const PMezzaGiornata: Boolean);
var
  LAbilitaTipoMG: Boolean;
  LFruizMaxMattine, LFruizMaxPomeriggi: Integer;
  LClassName, LJsCode: String;
begin
  // abilitazione tipo mezza giornata
  LAbilitaTipoMG:=False;
  if PMezzaGiornata then
  begin
    // giustificativo di assenza a mezza giornata
    // abilita l'indicazione della tipologia di mezza giornata
    // solo se la causale prevede fruizioni mattine + pomeriggi > 0
    if PCausale <> '' then
    begin
      LFruizMaxMattine:=StrToIntDef(VarToStr(A004MW.Q265.Lookup('CODICE',PCausale,'CSI_MAX_MGMAT')),0);
      LFruizMaxPomeriggi:=StrToIntDef(VarToStr(A004MW.Q265.Lookup('CODICE',PCausale,'CSI_MAX_MGPOM')),0);
      LAbilitaTipoMG:=(LFruizMaxMattine + LFruizMaxPomeriggi) > 0;
    end;
  end;

  // imposta la classe per il componente radiogroup in modo da renderlo visibile o meno
  if GestioneTipoMezzaGiornata then
  begin
    LClassName:=IfThen(LAbilitaTipoMG,'intestazione','nascosto');
    rgpTipoMG.Css:=LClassName;
    if GGetWebApplicationThreadVar.IsCallBack then
    begin
      LJsCode:=Format('document.getElementById("%s").className = ''%s'';',[rgpTipoMG.HTMLName,LClassName]);
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJsCode);
    end;
  end;
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW008FGiustificativi.OnCausaleChange(EventParams: TStringList);
var
  LCodCaus: String;
  LMezzaGiornata: Boolean;
begin
  // codice causale selezionata
  LCodCaus:=EventParams.Values[PAR_CODCAUS_CALLBACK];
  // valuta se è selezionato il tipo "mezza giornata"
  // rgpTipoGiust.ItemIndex non è attendibile qui
  LMezzaGiornata:=EventParams.Values[PAR_MG_CALLBACK].ToUpper = 'S';

  AbilitaTipoMG(LCodCaus,LMezzaGiornata);
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
procedure TW008FGiustificativi.OnTipoGiustChange(EventParams: TStringList);
var
  LCodCaus: String;
  LMezzaGiornata: Boolean;
begin
  // codice causale selezionata
  LCodCaus:=EventParams.Values[PAR_CODCAUS_CALLBACK];
  // valuta se è selezionato il tipo "mezza giornata"
  // rgpTipoGiust.ItemIndex non è attendibile qui
  LMezzaGiornata:=EventParams.Values[PAR_MG_CALLBACK].ToUpper = 'S';

  AbilitaTipoMG(LCodCaus,LMezzaGiornata);
end;
// ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

procedure TW008FGiustificativi.btnVisualizzaClick(Sender: TObject);
var PeriodoCambiato:Boolean;
begin
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtDaData.Text)) or (Al <> StrToDate(edtAData.Text));
    Dal:=StrToDate(edtDaData.Text);
    Al:=StrToDate(edtAData.Text);
    A004MW.DataInizio:=Dal;
    A004MW.DataFine:=Al;
    if Al < Dal then
      Abort;
  except
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO),INFORMA);
    exit;
  end;
  //Inizializzazione Dipendenti disponibili
  if PeriodoCambiato then
  begin
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;
    GetDipendentiDisponibili(Al);
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW008FGiustificativi.GetFamiliari;
var
  Codice, Descrizione, FiltroCausAbil: String;
begin
  Log('Traccia','GetFamiliari - inizio');
  cmbFamiliari.ItemsHaveValues:=True;
  cmbFamiliari.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  cmbFamiliari.Items.Clear;
  // BARI_POLICLINICO - chiamata 81479.ini
  ListaFamiliari.Clear;
  // BARI_POLICLINICO - chiamata 81479.fine

  // filtra i dataset dei familiari escludendo quelli senza causali abilitate
  FiltroCausAbil:='and    CAUSALI_ABILITATE is not null';

  with WR000DM do
  begin
    R180SetVariable(selSG101,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101,'FILTRO',FiltroCausAbil);
    selSG101.Open;
    selSG101.First;
    while not selSG101.Eof do
    begin
      Codice:=IntToStr(selSG101.FieldByName('NUMORD').AsInteger);
      Descrizione:='(' + selSG101.FieldByName('GRADOPAR').AsString + ') ' +
                   FormatDateTime('dd/mm/yyyy hh.mm',selSG101.FieldByName('DATA').AsDateTime) +
                   ' ' + selSG101.FieldByName('NOME').AsString;
      cmbFamiliari.Items.Values[Descrizione]:=Codice;
      // BARI_POLICLINICO - chiamata 81479.ini
      // bugfix: data nascita familiare rif. non corretta
      ListaFamiliari.Add(selSG101.FieldByName('DATA').AsString);
      // BARI_POLICLINICO - chiamata 81479.fine

      selSG101.Next;
    end;

    // dataset familiari per abil. causali
    R180SetVariable(selSG101Causali,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selSG101Causali,'FILTRO',FiltroCausAbil);
    selSG101Causali.Open;
    selSG101Causali.First;
  end;
  lblFamiliari.Visible:=(rgpCausali.ItemIndex = 0) and (cmbFamiliari.Items.Count > 0);
  cmbFamiliari.Visible:=(rgpCausali.ItemIndex = 0) and (cmbFamiliari.Items.Count > 0);

  Log('Traccia','GetFamiliari - fine');
end;

procedure TW008FGiustificativi.VisualizzaDipendenteCorrente;
var
  Prog: Integer;
begin
  inherited;
  Log('Traccia','VisualizzaDipendenteCorrente - inizio');
  // salva parametri
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  with A004MW do
  begin
    Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

    cmbFamiliari.ItemIndex:=-1;
    Q040.SetVariable('Progressivo',Prog);
    selT046.SetVariable('Progressivo',Prog);
    selT046.SetVariable('Data1',DataInizio);
    selT046.SetVariable('Data2',DataFine);
    selConiuge.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101Causali.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101Causali.Close;
    R600DtM1.selSG101Causali.Open;
    R600DtM1.selSG101.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101.Close;
    R600DtM1.selSG101.OnFilterRecord:=selSG101FilterRecord;
    Var_Causale:=cmbCausale.Text;
    Var_DaData:=edtDaData.Text;
    R600DtM1.selSG101.Open;
    // dataset di gestione
    Q040.Close;
    Q040.Open;
    // recapito alternativo
    RecapitoAlternativo.Clear;

    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=0;
    Var_FiltroCausaleSelezionata:=chkFiltro.Checked;
    Var_Causale:=Trim(Copy(cmbCausale.Text,1,5));

    // aggiorna visualizzazione
    SettaGiustificativiVisualizzati;
  end;

  with grdGiustificativi.DataSource.DataSet do
  begin
    VisualizzaNote:=False;
    while not Eof do
    begin
      if FieldByName('Note').AsString <> '' then
      begin
        VisualizzaNote:=True;
        Break;
      end;
      Next;
    end;
    First;
  end;

  // carica array familiari
  GetFamiliari;
  cmbFamiliari.ItemIndex:=-1;

  Log('Traccia','VisualizzaDipendenteCorrente - fine');
end;

procedure TW008FGiustificativi.grdGiustificativiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NomeCampo: String;
begin
  NomeCampo:=UpperCase((grdGiustificativi.Columns.Items[AColumn] as TIWDBGridColumn).DataField);
  if (NomeCampo = 'NOTE') and (not VisualizzaNote) then
    ACell.Css:='invisibile';

  if not RenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  // a ore: gestione caso 00.00
  if (NomeCampo = 'AORE') and (ARow > 0) then
  begin
    if (A004MW.Q040.FieldByName('TIPOGIUST').AsString = 'D') and
       (R180OreMinuti(A004MW.Q040.FieldByName('AORE').AsDateTime) = 0) then
    begin
      ACell.Text:='00.00';
    end;
  end;
end;

procedure TW008FGiustificativi.chkAutorizzazioneCompletaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if chkAutorizzazioneCompleta.Checked then
  begin
    edtDaOre.Text:='13.00';
    edtAOre.Text:='23.59';
  end
  else
  begin
    edtDaOre.Text:='';
    edtAOre.Text:='';
  end;
end;

procedure TW008FGiustificativi.chkFiltroClick(Sender: TObject);
begin
  btnVisualizzaClick(btnVisualizza);
end;

procedure TW008FGiustificativi.chkStampaRicevutaClick(Sender: TObject);
begin
  btnStampaRicevuta.Enabled:=not chkStampaRicevuta.Checked;
end;

procedure TW008FGiustificativi.ElaboraInsCan(Sender: TObject);
// Controlla che ci siano tutti i dati richiesti per l'inserimento/cancellazione
  procedure GestioneGiustificativo;
  begin
    A004MW.chkNuovoPeriodo:=False; //chkNuovoPeriodo.Checked;

    // valuta tipo gestione (dipendenti / coniugi esterni)
    // gestione dipendenti
    if Sender = btnInserisci then
    begin
      // inserimento giustificativo
      A004MW.InserisciGiustif(True);
    end
    else
    begin
      // cancellazione giustificativo
      A004MW.CancellaGiustif(True);
    end;
    if not A004MW.GestioneSingolaDM then
      A004MW.DataInizio:=StrToDate(A004MW.Var_DaData); //Alberto 09/04/2009: reimposto DataInizio all'originale, in quanto può essere variata per via del parametro COPRI_GGNONLAV
  end;
begin
  // controlla selezione dipendenti
  if selAnagrafeW.RecordCount = 0 then
  begin
    //chkNuovoPeriodo.Checked:=False;
    R180MessageBox(A000TraduzioneStringhe(A000MSG_ERR_NO_DIP),ESCLAMA);
    Exit;
  end;

  PrintRicevuta:=chkStampaRicevuta.Checked;

  // imposta variabili per i controlli
  with A004MW do
  begin
    selDatiBloccati.Close;
    RegistraMsg.IniziaMessaggio(medpCodiceForm);

    Var_Gestione:=0; //rgpGestione.ItemIndex;
    Var_TipoGiust:=rgpTipoGiust.ItemIndex;
    Var_TipoGiust_Count:=rgpTipoGiust.Items.Count;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    Var_TipoMG:='';
    if GestioneTipoMezzaGiornata then
    begin
      if not rgpTipoMG.Css.Contains('nascosto') then
      begin
        case rgpTipoMG.ItemIndex of
          0: Var_TipoMG:='M';
          1: Var_TipoMG:='P';
        else
        end;
      end;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Var_DaOre:=edtDaOre.Text;
    Var_AOre:=edtAOre.Text;
    Var_DaData:=edtDaData.Text;
    Var_AData:=edtAData.Text;
    Var_NumGG:=0;
    Var_Causale:=Trim(Copy(cmbCausale.Text,1,5));
    Var_TipoCaus:=IfThen(rgpCausali.ItemIndex = 0,1,0); // assenza / presenza sono invertite rispetto a  win/cloud
    if GestioneSingolaDM then
    begin
      // BARI_POLICLINICO - chiamata 81479.ini
      // bugfix: valore della data nascita familiari non corretto
      //Var_Familiari:=StringReplace(cmbFamiliari.Text,Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll]);
      if cmbFamiliari.ItemIndex < 0 then
        Var_Familiari:=''
      else
        Var_Familiari:=ListaFamiliari[cmbFamiliari.ItemIndex];
      // BARI_POLICLINICO - chiamata 81479.fine
    end
    else
      Var_Familiari:='';
    Var_Note:=IfThen(edtNote.Enabled,edtNote.Text,'');
    Var_Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

    // PIACENZA_COMUNE - chiamata <79574>.ini
    // in iriswin il posizionamento sul record giusto di Q265 / Q275 è automatico (lookup)
    // mentre in irisweb occorre forzarlo: la procedure Controlli utilizza infatti
    // questi dataset per i controlli sulle fruizioni
    if Var_TipoCaus = 1 then
      Q265.SearchRecord('CODICE',Var_Causale,[srFromBeginning])  // 1 = assenza
    else
      Q275.SearchRecord('CODICE',Var_Causale,[srFromBeginning]); // 0 = presenza
    // PIACENZA_COMUNE - chiamata <79574>.fine

    // controlli
    try
      Controlli(True,Sender = btnInserisci);
    except
      on E: Exception do
      begin
        R180MessageBox(E.Message,ESCLAMA);
        Exit;
      end;
    end;
    edtDaOre.Text:=Var_DaOre;
    edtAOre.Text:=Var_AOre;
  end;
  // fine controlli

  with A004MW do
  begin
    // imposta variabile Giustif
    Giustif.Inserimento:=Sender = btnInserisci;
    case rgpTipoGiust.ItemIndex of
      0:Giustif.Modo:=R180CarattereDef(IfThen(rgpCausali.ItemIndex = 1,'N','I')); // invertito rispetto a win/cloud
      1:Giustif.Modo:=R180CarattereDef(IfThen(rgpCausali.ItemIndex = 1,'D','M')); // invertito rispetto a win/cloud
      2:Giustif.Modo:='N';
      3:Giustif.Modo:='D';
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    Giustif.CSITipoMG:='';
    if GestioneTipoMezzaGiornata then
    begin
      if not rgpTipoMG.Css.Contains('nascosto') then
      begin
        case rgpTipoMG.ItemIndex of
          0: Giustif.CSITipoMG:='M';
          1: Giustif.CSITipoMG:='P';
        else
        end;
      end;
    end;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Giustif.Causale:=Trim(Copy(cmbCausale.Text,1,5));
    Giustif.DaOre:=edtDaOre.Text;
    Giustif.AOre:=edtAOre.Text;

    if GestioneSingolaDM then
    begin
      GestioneGiustificativo;
    end
    else
    begin
      // al momento la gestione massiva non è contemplata
      selAnagrafeW.First;
      while not selAnagrafeW.Eof do
      begin
        // elabora dipendente
        Var_Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
        GestioneGiustificativo;

        selAnagrafeW.Next;
      end;
    end;

    // stampa ricevuta inserimento assenza
    if PrintRicevuta then
      StampaRicevuta;

    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=0;
    //Var_FiltroCausaleSelezionata:=False;
    Var_FiltroCausaleSelezionata:=chkFiltro.Checked;
    Var_Causale:=Trim(Copy(cmbCausale.Text,1,5));
    SettaGiustificativiVisualizzati;
  end;
end;

procedure TW008FGiustificativi.btnCancellaClick(Sender: TObject);
begin
  ControllaRecapitoAlternativo;
  StartThreadElaborazione(ElaboraInsCan,Sender);
end;

procedure TW008FGiustificativi.btnInserisciClick(Sender: TObject);
begin
  ControllaRecapitoAlternativo;
  StartThreadElaborazione(ElaboraInsCan,Sender);
end;

procedure TW008FGiustificativi.ControllaRecapitoAlternativo;
begin
  if not ((rgpCausali.ItemIndex = 0) and (rgpTipoGiust.ItemIndex = 0) and (VarToStr(WR000DM.selT265.Lookup('CODICE',Trim(Copy(cmbCausale.Text,1,5)),'VISITA_FISCALE')) = 'S')) then
    A004MW.RecapitoAlternativo.Clear;
end;

procedure TW008FGiustificativi.btnNascondiRiepilogoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.Visible:=False;
  grdRiepilogo.CSS:=grdRiepilogo.CSS + ' ' + 'invisibile';
  lblCausale.Caption:='';
  btnNascondiRiepilogo.Visible:=False;
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS + ' ' + 'invisibile';
end;

procedure TW008FGiustificativi.btnRecapitoAlternativoClick(Sender: TObject);
var
  T047Data:TDateTime;
begin
  if not TryStrToDate(edtDaData.Text,T047Data) then
  begin
    MsgBox.MessageBox('Indicare una data di inizio valida!',ERRORE);
    Exit;
  end;

  WA004RecapitoFM:=TWA004FRecapitoVisFiscaliFM.Create(Self);
  WA004RecapitoFM.Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  WA004RecapitoFM.DataInizio:=T047Data;
  WA004RecapitoFM.A004MW:=A004MW;
  WA004RecapitoFM.Visualizza;
end;

procedure TW008FGiustificativi.btnStampaRicevutaClick(Sender: TObject);
var FiltroCausale:Boolean;
begin
  FiltroCausale:=chkFiltro.Checked;
  chkFiltro.Checked:=True;
  btnVisualizzaClick(nil);
  PrintRicevuta:=True;
  if A004MW.Q040B.RecordCount > 0 then
    StampaRicevuta
  else
    MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W008_ERR_FMT_FRUIZ_PERIODO),[Trim(Copy(cmbCausale.Text,1,5))]),INFORMA);
  if chkFiltro.Checked <> FiltroCausale then
  begin
    chkFiltro.Checked:=FiltroCausale;
    btnVisualizzaClick(nil);
  end;
end;

procedure TW008FGiustificativi.imgDettaglioClick(Sender: TObject);
var idx: Integer;
begin
  idx:=StrToInt((Sender as TmeIWImageFile).FriendlyName);
  W010CalcoloCompetenzeFM:=TW010FCalcoloCompetenzeFM.Create(Self);
  with W010CalcoloCompetenzeFM do
  begin
    TipoCumulo:=A004MW.R600DtM1.TipoCumulo; // AOSTA_REGIONE - commessa 2012/152
    lblProfiloAssenzeVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].ProfiloAssenze;
    lblPeriodoCumuloVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].PeriodoCumulo;
    lblCompLordeACVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].CompLordeAC;
    lblVarPeriodiRapportoVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarPeriodiRapporto;
    lblAbbattiAssCessVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].AbbattiAssCess;
    lblDecurtazNonMaturaVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].DecurtazNonMatura;
    lblVarPartTimeVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarPartTime;
    lblVarAbilitazioneAnagraficaVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarAbilitazioneAnagrafica;
    // AOSTA_REGIONE - commessa 2012/152.ini
    lblVarFruizMMInteriVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarFruizMMInteri;
    lblVarMaxIndividualeVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarMaxIndividuale;
    lblVarFruizMMContinuativiVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarFruizMMContinuativi;
    // AOSTA_REGIONE - commessa 2012/152.fine
    lblVarCompManualeVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].VarCompManuale;
    lblCompNetteACVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].CompNetteAC;
    memPartTimeVal.Lines.Text:=A004MW.R600DtM1.RiepilogoAssenze[idx].PartTime;
    lblFruizMinimaAC.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].TitoloFruizMinimaAC;
    lblFruizMinimaACVal.Caption:=A004MW.R600DtM1.RiepilogoAssenze[idx].FruizMinimaAC;
    Visualizza;
  end;
end;

procedure TW008FGiustificativi.btnVisualizzaRiepilogoClick(Sender: TObject);
var G:TGiustificativo;
    i:Integer;
    Prog:Integer;
    dDataRiep:TDateTime;
    EsisteResiduo,EsisteFamiliare:Boolean;
    LRifDataNascita: TRiferimentoDataNascita;
begin
  if not TryStrToDate(edtRiepAl.Text,dDataRiep) then
  begin
    edtRiepAl.SetFocus;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATA_RIEP),INFORMA);
    exit;
  end;
  Log('Traccia','btnRiepilogoClick - inizio');
  Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  SetLength(A004MW.R600DtM1.RiepilogoAssenze,0);
  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=Trim(Copy(cmbCausale.Text,1,5));
  if G.Causale = '' then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_CAUSALE_RIEP),INFORMA);
    exit;
  end;
  (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.AlterSessionSessioneOracle;
  lblCausale.Caption:=G.Causale + ' - ' + Trim(Copy(cmbCausale.Text,6,40));
  EsisteFamiliare:=False;

  if R180CarattereDef(VarToStr(WR000DM.selT265.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
  begin
    with A004MW.R600DtM1.selT040DataNas do
    begin
      EsisteFamiliare:=True;
      Close;
      SetVariable('Progressivo',Prog);
      SetVariable('Causale',G.Causale);
      SetVariable('Data1',EncodeDate(1900,1,1));
      SetVariable('Data2',dDataRiep);
      Open;
      while not Eof do
      begin
        // csi.ini
        //A004MW.R600DtM1.RiepilogaAssenze(Prog,dDataRiep,G,True,FieldByName('DataNas').AsDateTime);
        A004MW.R600DtM1.RiferimentoDataNascita.Data:=FieldByName('DataNas').AsDateTime;
        A004MW.R600DtM1.GetIDFamiliare(Prog);
        A004MW.R600DtM1.RiepilogaAssenze(Prog,dDataRiep,G,True,A004MW.R600DtM1.RiferimentoDataNascita);
        // csi.fine
        Next;
      end;
    end;
  end
  else
  begin
    // csi.ini
    //(*Passo 0 perchè qui non serve questo parametro*)
    //A004MW.R600DtM1.RiepilogaAssenze(Prog,dDataRiep,G,False,0);
    LRifDataNascita.Esiste:=False;
    LRifDataNascita.Data:=DATE_NULL;
    LRifDataNascita.IDFamiliare:='';
    LRifDataNascita.GradoPar:='';
    LRifDataNascita.PartFruizMaternita:='';
    A004MW.R600DtM1.RiepilogaAssenze(Prog,dDataRiep,G,False,LRifDataNascita);
    // csi.fine
  end;
  grdRiepilogo.RowCount:=0;
  grdRiepilogo.ColumnCount:=0;
  grdRiepilogo.Clear;
  grdRiepilogo.Visible:=True;
  grdRiepilogo.RowCount:=Length(A004MW.R600DtM1.RiepilogoAssenze) + 1;
  grdRiepilogo.ColumnCount:=12;
  grdRiepilogo.Cell[0,0].Text:='';
  grdRiepilogo.Cell[0,1].Text:='Familiare';
  grdRiepilogo.Cell[0,2].Text:='Misura';
  grdRiepilogo.Cell[0,3].Text:='Comp.prec';
  grdRiepilogo.Cell[0,4].Text:='Comp.corr';
  grdRiepilogo.Cell[0,5].Text:='Comp.totali';
  grdRiepilogo.Cell[0,6].Text:='Fruito prec.';
  grdRiepilogo.Cell[0,7].Text:='Fruito corr.';
  grdRiepilogo.Cell[0,8].Text:='Fruito tot.';
  grdRiepilogo.Cell[0,9].Text:='Fruito rich.';
  grdRiepilogo.Cell[0,10].Text:='Fruito aut.';
  grdRiepilogo.Cell[0,11].Text:='Residuo';
  EsisteResiduo:=False;
  for i:=0 to High(A004MW.R600DtM1.RiepilogoAssenze) do
  begin
    if A004MW.R600DtM1.RiepilogoAssenze[i].EsisteResiduo then
      EsisteResiduo:=True;
    grdRiepilogo.Cell[i + 1,0].Control:=TmeIWImageFile.Create(Self);
    with (grdRiepilogo.Cell[i + 1,0].Control as TmeIWImageFile) do
    begin
      Css:='icona';
      Hint:=A000TraduzioneStringhe(A000MSG_W008_MSG_DETT_CALCOLO_COMPETENZE);
      ImageFile.FileName:=fileImgDettaglio;
      FriendlyName:=IntToStr(i);
      OnClick:=imgDettaglioClick;
    end;
    grdRiepilogo.Cell[i + 1,0].Clickable:=True;
    with A004MW.R600DtM1.RiepilogoAssenze[i] do
    begin
      grdRiepilogo.Cell[i + 1,1].Text:=Familiare;
      grdRiepilogo.Cell[i + 1,2].Text:=IfThen(ArrotOre2Giorni,'Giorni',UM);
      grdRiepilogo.Cell[i + 1,3].Text:=IfThen(ArrotOre2Giorni,H_CP,CP);
      grdRiepilogo.Cell[i + 1,4].Text:=IfThen(ArrotOre2Giorni,H_CC,CC);
      grdRiepilogo.Cell[i + 1,5].Text:=IfThen(ArrotOre2Giorni,H_CT,CT);
      grdRiepilogo.Cell[i + 1,6].Text:=IfThen(ArrotOre2Giorni,H_FP,FP);
      grdRiepilogo.Cell[i + 1,7].Text:=IfThen(ArrotOre2Giorni,H_FC,FC);
      grdRiepilogo.Cell[i + 1,8].Text:=IfThen(ArrotOre2Giorni,H_FT,FT);
      grdRiepilogo.Cell[i + 1,9].Text:=IfThen(ArrotOre2Giorni,H_IterRich,IterRich);
      grdRiepilogo.Cell[i + 1,10].Text:=IfThen(ArrotOre2Giorni,H_IterAut,IterAut);
      grdRiepilogo.Cell[i + 1,11].Text:=IfThen(ArrotOre2Giorni,H_R,R);
    end;
  end;
  for i:=0 to grdRiepilogo.RowCount - 1 do
  begin
    if not EsisteFamiliare then
      grdRiepilogo.Cell[i,1].Css:='invisibile';
    if not EsisteResiduo then
    begin
      grdRiepilogo.Cell[i,3].Css:='invisibile';
      grdRiepilogo.Cell[i,4].Css:='invisibile';
      grdRiepilogo.Cell[i,6].Css:='invisibile';
      grdRiepilogo.Cell[i,7].Css:='invisibile';
    end;
  end;

  btnNascondiRiepilogo.Visible:=True;
  // 18/04/2019 - Bug IntraWEB 15.0.18:
  //con TemplateProcessor.RenderStyle = False, settare la proprietà Visible in Async non funziona
  //si usa il css "invisibile"
  grdRiepilogo.CSS:=grdRiepilogo.CSS.Replace(' invisibile','');
  btnNascondiRiepilogo.CSS:=btnNascondiRiepilogo.CSS.Replace(' invisibile','');

  Log('Traccia','btnRiepilogoClick - fine');
end;

procedure TW008FGiustificativi.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
  if (ARow > 0) and (AColumn in [5,8,11]) then
    ACell.Css:=IfThen (ACell.Css = 'invisibile','invisibile','riga_colorata');
end;

procedure TW008FGiustificativi.CalcoloPeriodiAssenza;
var
  Sesso,TipoGiust,Causale,CodCaus,DesCaus,
  DalAl,DalMGStr,AlMGStr,NumeroOre,AOre,NumGGStr,
  Periodo_gg, Periodo_ore, Prev_tipo, Prev_note, PeriodoAss: String;
  NumGG: Integer;
  AutDal,AutAl:TDateTime;
  EstraiPeriodi:TOracleDataSet;

  procedure ScriviPeriodo;
  begin
    dalMGStr:='';
    DalAl:='';
    // giorni di fruizione
    NumGG:=Trunc((AutAl - 1) - AutDal) + 1;
    if NumGG > 0 then
    begin
      NumGGStr:='';
      DalAl:=IfThen(NumGG > 1,
                    Format(A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_DA_A),[DateToStr(AutDal),DateToStr(AutAl - 1)]),
                    Format(A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_IN_DATA),[DateToStr(AutDal)]));
    end;
    (*
    if (EstraiPeriodi.FieldByName('TIPOGIUST').AsString = 'M') and (NumGG = 1) then
    begin
      dalMGStr:=Format(A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_MEZZAGG_INDATA),[Causale + IfThen(EstraiPeriodi.FieldByName('NOTE').AsString <> '',' [' + EstraiPeriodi.FieldByName('NOTE').AsString +  ']'),DateToStr(AutDal)]);
      AutDal:=AutDal + 1;
    end;
    *)
    // fruizione a ore
    NumeroOre:=EstraiPeriodi.FieldByName('DAORE').AsString;
    AOre:=EstraiPeriodi.FieldByName('AORE').AsString;
    TipoGiust:=EstraiPeriodi.FieldByName('TIPOGIUST').AsString;

    if DalAl <> '' then
    begin
      Periodo_gg:=IfThen(TipoGiust = 'M',' ' + A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_MEZZA_GG) + ' ' + IfThen(NumeroOre <> '','(' + NumeroOre + ' ore) '),' ');
      if EstraiPeriodi.FieldByName('TIPOGIUST').AsString = 'M' then
      begin
        Periodo_gg:=Periodo_gg + IfThen(EstraiPeriodi.FieldByName('NOTE').AsString <> '','[' + EstraiPeriodi.FieldByName('NOTE').AsString +  '] ');
        //AutDal:=AutDal + 1;
      end;
      Periodo_gg:=Periodo_gg + DalAl;
    end;
    if TipoGiust = 'N' then
      Periodo_ore:=' di ore ' + NumeroOre                    // numero ore
    else if TipoGiust = 'D' then
      Periodo_ore:=' dalle ' + NumeroOre + ' alle ' + AOre   // da ore - a ore
    else
      Periodo_ore:='';
    PeriodoAss:=PeriodoAss +
    IfThen(DalMGStr <> '',DalMGStr + IfThen(DalAl + AlMGStr <> '',CRLF)) +
    IfThen(DalAl <> '',Causale + Periodo_gg + Periodo_ore + IfThen(AlMGStr <> '',CRLF)) +
    IfThen(AlMGStr <> '',AlMGStr) + '.' + IfThen(Parametri.CampiRiferimento.C90_Lingua = 'INGLESE',' (dates inclusive)','') + #13#10;
  end;

begin
  inherited;
  // 1. imposta variabili di appoggio
  // sesso
  Sesso:=cdsAutorizzazione.FieldByName('SESSO').AsString;
  // causale
  CodCaus:=cdsAutorizzazione.FieldByName('CAUSALE').AsString;
  DesCaus:=cdsAutorizzazione.FieldByName('D_CAUSALE').AsString;
  Causale:=IfThen(DesCaus <> '',DesCaus,CodCaus);

  // campo: oggetto
  cdsAutorizzazione.FieldByName('C_OGGETTO').AsString:=A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_OGGETTO) + ' ' + Causale;

  // campo: testo richiesta
  cdsAutorizzazione.FieldByName('C_TESTO_RICH').AsString:=A000TraduzioneStringhe(IfThen(Sesso = 'F',A000MSG_W008_MSG_RAV_NOMIN_F,A000MSG_W008_MSG_RAV_NOMIN_M)) + ' ' +
  cdsAutorizzazione.FieldByName('NOMINATIVO').AsString + ' ('+ A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_MATRICOLA) + ' ' + cdsAutorizzazione.FieldByName('MATRICOLA').AsString + ')';

  DalAl:='';
  DalMGStr:='';
  AlMGStr:='';

  AutDal:=cdsAutorizzazione.FieldByName('DAL').AsDateTime;
  AutAl:=cdsAutorizzazione.FieldByName('AL').AsDateTime;

  EstraiPeriodi:=TOracleDataSet.Create(nil);
  try
    EstraiPeriodi.session:=SessioneOracle;
    EstraiPeriodi.SQL.Add('select T040.DATA, T040.TIPOGIUST, T040.NOTE,');
    EstraiPeriodi.SQL.Add('       to_char(T040.DAORE,''HH24.MI'') as DAORE, to_char(T040.AORE,''HH24.MI'') as AORE');
    EstraiPeriodi.SQL.Add('  from T040_GIUSTIFICATIVI T040');
    EstraiPeriodi.SQL.Add(' where T040.PROGRESSIVO = :MYPROG');
    EstraiPeriodi.SQL.Add('   and T040.DATA between :MYDATADA and :MYDATAA');
    EstraiPeriodi.SQL.Add('   and T040.CAUSALE = :MYCAUS');
    EstraiPeriodi.SQL.Add(' order by T040.DATA');
    EstraiPeriodi.DeclareVariable('MYPROG',otInteger);
    EstraiPeriodi.DeclareVariable('MYDATADA',otDate);
    EstraiPeriodi.DeclareVariable('MYDATAA',otDate);
    EstraiPeriodi.DeclareVariable('MYCAUS',otString);
    EstraiPeriodi.SetVariable('MYPROG',cdsAutorizzazione.FieldByName('PROGRESSIVO').AsInteger);
    EstraiPeriodi.SetVariable('MYDATADA',AutDal);
    EstraiPeriodi.SetVariable('MYDATAA',AutAl);
    EstraiPeriodi.SetVariable('MYCAUS',CodCaus);
    EstraiPeriodi.Open;

    AutDal:=0;
    Prev_tipo:=EstraiPeriodi.FieldByName('TIPOGIUST').AsString;
    Prev_note:=EstraiPeriodi.FieldByName('NOTE').AsString;
    PeriodoAss:='';
    while Not EstraiPeriodi.Eof do
    begin
      if AutDal = 0 then
      begin
        AutDal:=EstraiPeriodi.FieldByName('DATA').AsDateTime;
        AutAl:=AutDal;
      end;
      if (Prev_tipo <> EstraiPeriodi.FieldByName('TIPOGIUST').AsString) or
         (Prev_note <> EstraiPeriodi.FieldByName('NOTE').AsString) or
         (AutAl + 1 <> EstraiPeriodi.FieldByName('DATA').AsDateTime + 1) then
      begin
        EstraiPeriodi.Prior;
        ScriviPeriodo;
        EstraiPeriodi.Next;
        AutDal:=EstraiPeriodi.FieldByName('DATA').AsDateTime;
        AutAl:=AutDal;
      end;
      AutAl:=AutAl + 1;
      Prev_tipo:=EstraiPeriodi.FieldByName('TIPOGIUST').AsString;
      Prev_note:=EstraiPeriodi.FieldByName('NOTE').AsString;
      EstraiPeriodi.Next;
    end;
    if AutDal > 0 then
      ScriviPeriodo;
  finally
    FreeAndNil(EstraiPeriodi);
  end;
  cdsAutorizzazione.FieldByName('C_PERIODO_RICH').AsString:=PeriodoAss;

  // campo: testo autorizzazione
  if Parametri.CampiRiferimento.C90_Lingua = 'INGLESE' then
    cdsAutorizzazione.FieldByName('C_TESTO_AUT').AsString:=''
  else
    cdsAutorizzazione.FieldByName('C_TESTO_AUT').AsString:='Si autorizza ' + IfThen(Sesso = 'F','la','il') + ' dipendente ' + cdsAutorizzazione.FieldByName('NOMINATIVO').AsString + ' a usufruire di :';

  // campo: periodo autorizzato
  if Parametri.CampiRiferimento.C90_Lingua = 'INGLESE' then
    cdsAutorizzazione.FieldByName('C_PERIODO_AUT').AsString:=''
  else
    cdsAutorizzazione.FieldByName('C_PERIODO_AUT').AsString:=PeriodoAss;
                                                                                                             //data e firma
  cdsAutorizzazione.FieldByName('C_DATA').AsString:=Format(A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_DATA),[DateToStr(R180SysDate(SessioneOracle))]);
  cdsAutorizzazione.FieldByName('C_FIRMA').AsString:=cdsAutorizzazione.FieldByName('D_RESPONSABILE').AsString;
end;

procedure TW008FGiustificativi.StampaRicevuta;
var
  rvComp: TRaveComponent;
  L: TStringList;
  dconnDettaglio: TRaveDataConnection;
  ODS: TOracleDataSet;
  NomeFile, Caus, NomeCognomeResp, EnteIndirizzo: String;

  function GetFirma(Expr:String):String;
  begin
    Result:='';
    with TOracleQuery.Create(nil) do
     try
      Session:=SessioneOracle;
      SQL.Text:=Format('select %s from dual',[Expr]);
      try
        if Pos(':PROGRESSIVO',UpperCase(Expr)) > 0 then
          DeclareAndSet('PROGRESSIVO',otInteger,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);//selAnagrafeW.FieldByName('PROGRESSIVO').Value
        if Pos(':PROGR_UTENTE',UpperCase(Expr)) > 0 then
          DeclareAndSet('PROGR_UTENTE',otInteger,Parametri.ProgressivoOper);
        if Pos(':MATR_UTENTE',UpperCase(Expr)) > 0 then
          DeclareAndSet('MATR_UTENTE',otString,Parametri.MatricolaOper);
        if Pos(':UTENTE',UpperCase(Expr)) > 0 then
          DeclareAndSet('UTENTE',otString,Parametri.Operatore);
        Execute;
        Result:=FieldAsString(0);
      except
      end;
    finally
      Free;
    end;
  end;

begin
  inherited;
  Log('Traccia','StampaRicevuta - inizio');
  CSStampa.Enter;
  rvSystem:=TRVSystem.Create(Self);
  rvProject:=TRVProject.Create(Self);
  connDettaglio:=TRVDataSetConnection.Create(Self);
  rvRenderPDF:=TRvRenderPDF.Create(Self);
  L:=TStringList.Create;
  try
    cdsAutorizzazione.Close;
    cdsAutorizzazione.CreateDataSet;
    cdsAutorizzazione.Open;
    cdsAutorizzazione.EmptyDataSet;

    rvProject.Engine:=RvSystem;
    rvRenderPDF.Active:=True;
    rvProject.ProjectFile:=gSC.ContentPath + 'report\W008Giustificativi.rav';
    connDettaglio.Name:='connDettaglio';
    connDettaglio.DataSet:=cdsAutorizzazione;
    connDettaglio.RuntimeVisibility:=RpCon.rtNone;
    with WR000DM do
    begin
      // estrae nominativo del responsabile
      selI060DatiUtente.Close;
      selI060DatiUtente.SetVariable('AZIENDA',Parametri.Azienda);
      selI060DatiUtente.SetVariable('UTENTE',Parametri.Operatore);
      selI060DatiUtente.Open;
      if (selI060DatiUtente.RecordCount > 0) then
        if A000TraduzioneStringhe('W008_RICEVUTA_FIRMA') = 'W008_RICEVUTA_FIRMA' then
          NomeCognomeResp:=selI060DatiUtente.FieldByName('NOME').AsString + ' ' + selI060DatiUtente.FieldByName('COGNOME').AsString
        else
          NomeCognomeResp:=GetFirma(A000TraduzioneStringhe('W008_RICEVUTA_FIRMA'));
      selI060DatiUtente.Close;

      case rgpTipoGiust.ItemIndex of
        0:TG:=IfThen(rgpTipoGiust.Items.Count = 4,'I','N');
        1:TG:=IfThen(rgpTipoGiust.Items.Count = 4,'M','D');
        2:TG:='N';
        3:TG:='D';
      end;
      // inserisce i dati nel client dataset
      with cdsAutorizzazione do
      begin
        Append;
        FieldByName('PROGRESSIVO').Value:=selAnagrafeW.FieldByName('PROGRESSIVO').Value;
        FieldByName('NOMINATIVO').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString +
                                            ' ' + selAnagrafeW.FieldByName('NOME').AsString;
        FieldByName('MATRICOLA').Value:=selAnagrafeW.FieldByName('MATRICOLA').Value;
        FieldByName('SESSO').Value:=selAnagrafeW.FieldByName('SESSO').Value;
        Caus:=Trim(Copy(cmbCausale.Text,1,5));
        if rgpCausali.ItemIndex = 0 then
        begin
          // assenza
          selT265.SearchRecord('CODICE',Caus,[srFromBeginning]);
          FieldByName('CAUSALE').AsString:=selT265.FieldByName('CODICE').AsString;
          FieldByName('D_CAUSALE').AsString:=selT265.FieldByName('DESCRIZIONE').AsString;
        end
        else
        begin
          // presenza
          selT275.SearchRecord('CODICE',Caus,[srFromBeginning]);
          FieldByName('CAUSALE').AsString:=selT275.FieldByName('CODICE').AsString;
          FieldByName('D_CAUSALE').AsString:=selT275.FieldByName('DESCRIZIONE').AsString;
        end;
        FieldByName('TIPOGIUST').AsString:=TG;
        FieldByName('DAL').AsDateTime:=StrToDate(edtDaData.Text);
        FieldByName('AL').AsDateTime:=StrToDate(edtAData.Text);
        FieldByName('NUMEROORE').AsString:=edtDaOre.Text;
        FieldByName('AORE').AsString:=edtAOre.Text;
        FieldByName('RESPONSABILE').AsString:=Parametri.Operatore;
        FieldByName('D_RESPONSABILE').AsString:=NomeCognomeResp;
        FieldByName('DAL_MG').AsString:='N';
        FieldByName('AL_MG').AsString:='N';
        FieldByName('GG_INTERE').AsString:='N';
        //if (edtDal.Text <> edtAl.Text) and not chkStampaRicevuta.Checked then //richiamo da btnStampaRicevuta
        //if {not }chkStampaRicevuta.Checked then //richiamo da btnStampaRicevuta
        if PrintRicevuta then
          CalcoloPeriodiAssenza;
        Post;
      end;
    end;

    // Gestione stampa
    rvProject.Open;
    rvProject.GetReportList(L,True);
    rvProject.SelectReport(L[0],True);
    rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);

    //Impostazioni dei campi di Dettaglio
    dconnDettaglio:=CreateDataCon(connDettaglio);
    rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
    rvDWDettaglio.DataCon:=dconnDettaglio;
    CreateFields(rvDWDettaglio,nil,nil,True);
    rvPage:=RVProject.ProjMan.FindRaveComponent('W008.Page',nil);

    // Impostazioni della banda bndTitolo
    // 1. Logo
    rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
    (rvComp as TRaveBitmap).Height:=0;
    (rvComp as TRaveBitmap).Width:=0;
    try
      ODS:=TOracleDataSet.Create(nil);
      try
        ODS.Session:=SessioneOracle;
        ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
        ODS.Open;
        if ODS.RecordCount = 1 then
        begin
          (rvComp as TRaveBitmap).Image.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
          (rvComp as TRaveBitmap).Height:=0.640;
          (rvComp as TRaveBitmap).Width:=1.2;
        end;
        ODS.Close;
      finally
        FreeAndNil(ODS);
      end;
    except
      on E:Exception do
        Log('Errore','StampaRicevuta;Impostazione logo;' + E.ClassName + '/' + E.Message);
    end;

    // 2. altre informazioni di testata
    // ragione sociale
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
    (rvComp as TRaveText).Text:=Parametri.RagioneSociale;
    // indirizzo
    with WR000DM.selI090 do
    begin
      Close;
      SetVariable('AZIENDA',Parametri.Azienda);
      Open;
      EnteIndirizzo:=IfThen(RecordCount = 0,'',FieldByName('INDIRIZZO').AsString);
      Close;
    end;
    rvComp:=RVProject.ProjMan.FindRaveComponent('lblIndirizzo',rvPage);
    (rvComp as TRaveText).Text:=EnteIndirizzo;

    (RVProject.ProjMan.FindRaveComponent('Text1',rvPage) as TRaveText).Text:=A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_CHIEDE) + ' ' + A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_USUFRUIRE) + ':';
    (RVProject.ProjMan.FindRaveComponent('Text4',rvPage) as TRaveText).Text:=A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_FIRMA_DIP);
    (RVProject.ProjMan.FindRaveComponent('Text8',rvPage) as TRaveText).Text:=A000TraduzioneStringhe(A000MSG_W008_MSG_RAV_FIRMA_RESP);
    if Parametri.CampiRiferimento.C90_Lingua = 'INGLESE' then
      (RVProject.ProjMan.FindRaveComponent('lbl_ITC',rvPage) as TRaveText).Text:='[ ] This form modifies or amends previous request'
    else
      (RVProject.ProjMan.FindRaveComponent('lbl_ITC',rvPage) as TRaveText).Text:='';

    ScalaStampa:=0.2 / 18;
    //Generazione del file PDF
    rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
    rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
    rvSystem.DefaultDest:=rdFile;
    rvSystem.DoNativeOutput:=False;
    rvSystem.RenderObject:=RvRenderPDF;
    if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
      rvSystem.SystemFiler.StreamMode:=smTempFile
    else
      rvSystem.SystemFiler.StreamMode:=smMemory;
    NomeFile:=GetNomeFile('pdf');
    rvSystem.OutputFileName:=NomeFile;
    ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
    rvProject.Execute;
    VisualizzaFile(NomeFile,'Anteprima stampa ricevuta',nil,nil);
  finally
    cdsAutorizzazione.Close;
    L.Free;
    rvProject.Close;
    FreeAndNil(dconnDettaglio);
    FreeAndNil(rvSystem);
    FreeAndNil(rvRenderPDF);
    FreeAndNil(rvProject);
    FreeAndNil(connDettaglio);
    CSStampa.Leave;
  end;
  Log('Traccia','StampaRicevuta - fine');
end;

procedure TW008FGiustificativi.rgpCausaliClick(Sender: TObject);
begin
  inherited;
  GetCausaliDisponibili;

  // gestione familiari disponibile solo per assenze
  lblFamiliari.Visible:=(rgpCausali.ItemIndex = 0);
  cmbFamiliari.Visible:=(rgpCausali.ItemIndex = 0);

  // imposta i tipi di fruizione in base al giustificativo (assenza / presenza)
  rgpTipoGiust.Items.BeginUpdate;
  rgpTipoGiust.Items.StrictDelimiter:=True;
  rgpTipoGiust.Items.CommaText:=IfThen(rgpCausali.ItemIndex = 0,
                                       Format('%s,%s,',[A000TraduzioneStringhe('Giorn.'),A000TraduzioneStringhe('Mezza giorn.')])) +
                                       Format('%s,%s',[A000TraduzioneStringhe('Num.ore'),A000TraduzioneStringhe('Da ore - A ore')]);
  rgpTipoGiust.Items.EndUpdate;

  btnVisualizzaRiepilogo.Visible:=(rgpCausali.ItemIndex = 0);
end;

procedure TW008FGiustificativi.DistruggiOggetti;
begin
  // BARI_POLICLINICO - chiamata 81479.ini
  if ListaFamiliari <> nil then
    FreeAndNil(ListaFamiliari);
  // BARI_POLICLINICO - chiamata 81479.fine

  // middleware giustificativi
  try FreeAndNil(A004MW); except end;

  // dataset condivisi
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
    R180CloseDataSetTag0(WR000DM.selT040);
    R180CloseDataSetTag0(WR000DM.selSG101);
    R180CloseDataSetTag0(WR000DM.selSG101Causali);
  end;
end;

procedure TW008FGiustificativi.ImpostaJQuery;
var
  s, Elementi: String;
  ODS: TOracleDataSet;
begin
  // autocomplete configurazioni stampa
  ODS:=TOracleDataSet.Create(nil);
  try
    ODS.Session:=SessioneOracle;
    ODS.SQL.Add('select distinct NOTE from T040_GIUSTIFICATIVI where DATA >= add_months(sysdate,-12) and NOTE is not null');
    ODS.Open;
    while not ODS.Eof do
    begin
      Elementi:=Elementi + '''' + C190EscapeJS(ODS.FieldByName('NOTE').AsString) + ''',';
      ODS.Next;
    end;
    ODS.Close;
  finally
    FreeAndNil(ODS);
  end;
  if Elementi <> '' then
  begin
    s:='var elementi = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' +
       '$("#' + edtNote.HTMLName + '").autocomplete({' + CRLF +
       '  source: elementi,' + CRLF +
       '  delay: 0,' + CRLF +
       '  minLength: 0' + CRLF +
       '}).focus(function(){ ' + CRLF +
       '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
       '}); ';
  end;
  jQAutoComplete.OnReady.Text:=s;
end;

end.
