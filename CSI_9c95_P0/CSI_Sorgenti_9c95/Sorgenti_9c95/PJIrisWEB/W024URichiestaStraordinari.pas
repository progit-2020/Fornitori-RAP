unit W024URichiestaStraordinari;

interface

uses
  IWApplication, IWAppForm, SysUtils, Classes, Graphics,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  Controls, IWCompLabel, IWControl, IWCompListbox, IWCompEdit, meIWEdit,
  IWCompButton, OracleData, IWCompCheckbox, Variants,  IWVCLBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, DB, StrUtils, DBClient, Math, ActnList,
  IWDBGrids, medpIWDBGrid, A000UCostanti, A000USessione, A000UInterfaccia,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWComboBox,
  R450, W024URichiestaStraordinariDM, meIWGrid, meIWLabel, meIWButton,
  IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLink, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, meIWCheckBox,
  IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl, IWHTMLControls;

type
  TW024FRichiestaStraordinari = class(TR013FIterBase)
    dsrT065: TDataSource;
    cdsT065: TClientDataSet;
    grdRiepilogo: TmeIWGrid;
    lblMessaggio: TmeIWLabel;
    btnInserisci: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure CampoOreAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnInserisciClick(Sender: TObject);
  private
    Data,DataPrimaRichiesta:TDateTime;
    ColOreEcc,ColOreComp,ColOreLiq,ColCaus,ColOreCaus,RigheAutorizzabili,RigheLimiti,RigheAvvertimenti:Integer;
    MinTotAnnuoComp,MinTotAnnuoLiq,MinTotAutComp,MinTotAutLiq,MinTotInAttAutComp,MinTotInAttAutLiq,MinResiduiComp,MinResiduiLiq: Integer;
    Operazione: String;
    R450DtM1: TR450DtM1;
    StileCella1,StileCella2: String;
    ConsideraRigheValidabili,DipValidabile:Boolean;
    W024DM: TW024FRichiestaStraordinariDM;
    function AssegnaCodIterMancanti:Boolean;
    procedure actCancRichiesta(FN:String);
    procedure actModRichiesta(FN:String);
    procedure AutorizzazioneOK(RowidT065:String;Aut:Boolean);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String);
    function  ControlliOK(FN: String): Boolean;
    procedure AggiornamentoLimitiScheda(Aut:Boolean);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure imgIterClick(Sender: TObject);
    function EsisteCodIterValidabile:Boolean;
    procedure ImpostaGrigliaRiepilogo;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure W024AutorizzaTutti(Sender: TObject; var Ok: Boolean);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure OnCambiaProgressivo; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TW024FRichiestaStraordinari.InizializzaAccesso:Boolean;
begin
  Result:=True;
  Data:=ParametriForm.Al;
  GetDipendentiDisponibili(Data);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
  if WR000DM.Responsabile then
    cmbDipendentiDisponibili.ItemIndex:=0;

  // aggiorna dati
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per apertura funzione

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W024AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,427,426);
  inherited;
  W024DM:=TW024FRichiestaStraordinariDM.Create(nil);
  CampiV430:=CampiV430 + IfThen(CampiV430 <> '',',') + 'V430.T430INIZIO,V430.T430FINE';
  Iter:=ITER_STRMESE;
  W024DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W024DM.selT065,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W024DM.selT065,tiRichiesta);
  C018.Periodo.SetVuoto;
  Data:=Parametri.DataLavoro;

  btnInserisci.Confirmation:='Si vuole inserire una nuova richiesta di straordinario per il mese di ' + FormatDateTime('mm/yyyy',R180AddMesi(Date,-W024DM.C90_W024MMIndietro)) + '?';

  //Tipo richiesta straordinario
  W024DM.TipoRichStr:='1';//1=Banca ore (AOSTA_REGIONE), 2=Straordinario annuo (TORINO_REGIONE), 3=Straordinario annuo con causale (GENOVA_COMUNE)
  with W024DM.selT025 do
  begin
    Open;
    if not Eof then
      W024DM.TipoRichStr:=FieldByName('TIPO').AsString;
    Close;
  end;
  W024DM.GestioneCausale:=(W024DM.TipoRichStr = '3') and (Parametri.CampiRiferimento.C15_LimitiMensCaus = 'S');
  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,
                           IfThen(W024DM.TipoRichStr = '1',
                                  'W024P1',                 //Aut. (Banca ore)
                                  'W024P4'),                //Aut. (Str. annuo) e (Str. annuo con causale)
                           IfThen(W024DM.TipoRichStr = '1',
                                  'W024P0',                 //Rich. (Banca ore)
                                  'W024P3'));               //Rich. (Str. annuo) e (Str. annuo con causale)

  with WR000DM.selT275 do
  begin
    Open;
    Filtered:=True;
    Tag:=Tag + 1;
  end;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W024DM.selT065;

  // imposta tipo richieste (v. anche OnFormRender)
  if W024DM.TipoRichStr = '1' then
    C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp - [trNonAutorizzabili];

  W024DM.selAnagrafeW:=selAnagrafeW;
end;

procedure TW024FRichiestaStraordinari.IWAppFormRender(Sender: TObject);
var RichiestaPendente:Boolean;
    OreEccedCalc:Integer;
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  BloccaGestione:=Operazione <> '';

  btnInserisci.Visible:=(not SolaLettura) and
                        (W024DM.TipoRichStr <> '1') and
                        (not WR000DM.Responsabile) and
                        (R180Between(R180Giorno(Date),StrToIntDef(W024DM.C90_W026UtilizzoDal,1),StrToIntDef(W024DM.C90_W026UtilizzoAl,31))) and
                        (not WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),'T820'));
  if btnInserisci.Visible then
    with W024DM.selaT065 do
    begin
      Close;
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
      Open;
      RichiestaPendente:=True;
      OreEccedCalc:=0;
      if RecordCount > 0 then
      begin
        RichiestaPendente:=False;
        while not Eof do
        begin
          if FieldByName('STATO').IsNull then
          begin
            RichiestaPendente:=True;
            Break;
          end;
          Next;
        end;
        Last;
        OreEccedCalc:=R180OreMinutiExt(FieldByName('ORE_ECCED_CALC').AsString) - IfThen(FieldByName('STATO').AsString = 'S',R180OreMinutiExt(FieldByName('ORE_ECCEDENTI').AsString),0);
      end;
      btnInserisci.Visible:=(not RichiestaPendente) and (OreEccedCalc > 0);
    end;

  // autorizza / nega tutto
  if btnTuttiSi.Visible then
    btnTuttiSi.Visible:=(not (trRichiedibili in C018.TipoRichiesteSel)) and
                        (not (trNonAutorizzabili in C018.TipoRichiesteSel)) and
                        (not (trAutorizzate in C018.TipoRichiesteSel)) and
                        (not (trNegate in C018.TipoRichiesteSel)) and
                        (not (trTutte in C018.TipoRichiesteSel)) and // suppongo sia inutile
                        (RigheAutorizzabili > 1);
  btnTuttiNo.Visible:=btnTuttiSi.Visible and (W024DM.TipoRichStr <> '1');
end;

procedure TW024FRichiestaStraordinari.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW024FRichiestaStraordinari.OnCambiaProgressivo;
begin
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per cambio dipendente
  inherited;
end;

procedure TW024FRichiestaStraordinari.VisualizzaDipendenteCorrente;
var
  FiltroPeriodo,FiltroAnag,FiltroVis,FiltroVisTipo2,FiltroNonAutorizzabili,FiltroDip,sOreComp,sOreLiq,s:String;
  LivelloAutorizzazione: Integer;
  DFin:TDateTime;
begin
  inherited;
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  lblMessaggio.Caption:='';

  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] and (not WR000DM.Responsabile) then
    with W024DM.updT065 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('MESE_RIFERIMENTO',R180AddMesi(R180InizioMese(Date),-1));
      Execute;
      SessioneOracle.Commit;
    end;

  W024DM.C90_W026UtilizzoDal:=Parametri.CampiRiferimento.C90_W026UtilizzoDal;
  W024DM.C90_W026UtilizzoAl:=Parametri.CampiRiferimento.C90_W026UtilizzoAl;
  if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
  begin
    if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180AddMesi(R180InizioMese(Date),-1),'T195',True) then
    begin
      W024DM.C90_W026UtilizzoDal:='0';
      W024DM.C90_W026UtilizzoAl:='0';
    end;
  end;

  // apertura dataset delle richieste straordinari
  with W024DM.selT065 do
  begin
    W024DM.CampiCalcolati:=False;//Disabilita l'estrazione dei campi calcolati finché non servono
    // filtro in base alla selezione anagrafica
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       FiltroSingoloAnagrafico
                       );
    // inizializzazione variabili
    R180SetVariable(W024DM.selT065,'DATALAVORO',Parametri.DataLavoro);
    R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',null);
    R180SetVariable(W024DM.selT065,'FILTRO_ANAG',FiltroAnag);
    FiltroNonAutorizzabili:='( T850.STATO IS NULL AND ' +
                             '(   NOT TO_NUMBER(TO_CHAR(SYSDATE,''DD'')) BETWEEN ' + IntToStr(StrToIntDef(W024DM.C90_W026UtilizzoDal,1)) + ' AND ' + IntToStr(StrToIntDef(W024DM.C90_W026UtilizzoAl,31)) + ' ' +
                              Format('OR T_ITER.DATA < ADD_MONTHS(TRUNC(SYSDATE,''MM''),%d) ',[-W024DM.C90_W024MMIndietro]) +
                              'OR EXISTS (select 1 from t180_datibloccati ' +
                                         'where riepilogo = ''T820'' ' +
                                         'and stato = ''C'' ' +
                                         'and progressivo = T_ITER.PROGRESSIVO ' +
                                         'and T_ITER.DATA between dal and al)))';
    // indico se considerare il livello della validazione
    if W024DM.TipoRichStr = '1' then
    begin
      // ricalcolo i dati annuali alla data dell'ultimo mese elaborato (Tipo=C; Mese più recente=T065.Data DESC)
      FiltroVis:='and T850.TIPO_RICHIESTA <> ''C''';
      R180SetVariable(W024DM.selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
      // apertura temporanea per estrarre il riepilogo delle ore
      Open;
      if (not TuttiDipSelezionato)
      and (SearchRecord('TIPO','C',[srFromBeginning]))  then
      begin
        R450DtM1:=TR450DtM1.Create(nil);
        R450DtM1.ConteggiMese('Generico',R180Anno(FieldByName('DATA').AsDateTime),R180Mese(FieldByName('DATA').AsDateTime),selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        lblMessaggio.Caption:='Mese: <b>' + FormatDateTime('mm/yyyy',FieldByName('DATA').AsDateTime) + '</b> &nbsp;&nbsp;&nbsp;&nbsp; Totale ore straordinario anno: <b>' + R180MinutiOre(R450DtM1.BancaOreAnno) + '</b> &nbsp;&nbsp;&nbsp;&nbsp; Residuo ore compensabili anno: <b>' + R180MinutiOre(R450DtM1.BancaOreResidua) + '</b>';
        FreeAndNil(R450DtM1);
      end;
      DataPrimaRichiesta:=0;
      if SearchRecord('TIPO_RICHIESTA;TIPO',VarArrayOf(['R','C']),[srFromBeginning]) then
        repeat
          DataPrimaRichiesta:=FieldByName('DATA').AsDateTime
        until not SearchRecord('TIPO_RICHIESTA;TIPO',VarArrayOf(['R','C']),[]);
    end
    else if W024DM.AggiornaTotali then
    begin
      //Prelevo i riepiloghi di tutti i dipendenti selezionati
      FiltroDip:=selAnagrafeW.SubstitutedSql;
      FiltroDip:=IfThen(TuttiDipSelezionato,
                        'IN (SELECT PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')',
                        '= ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
      //Prelevo il riepilogo del Totale annuo
      W024DM.RecuperaLimitiAnnuali(FiltroDip,R180Anno(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),sOreComp,sOreLiq);
      MinTotAnnuoComp:=R180OreMinutiExt(sOreComp);
      MinTotAnnuoLiq:=R180OreMinutiExt(sOreLiq);
      //Prelevo il riepilogo del Totale autorizzato
      W024DM.RecuperaLimitiMensili(FiltroDip,R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),sOreComp,sOreLiq);
      MinTotAutComp:=R180OreMinutiExt(sOreComp);
      MinTotAutLiq:=R180OreMinutiExt(sOreLiq);
      //Prelevo il riepilogo del Totale in attesa di autorizzazione + Totale autorizzato del mese in modifica
      MinTotInAttAutComp:=0;
      MinTotInAttAutLiq:=0;
      FiltroPeriodo:=Format('and T_ITER.DATA = to_date(''%s'',''dd/mm/yyyy'')',
                            [FormatDateTime('dd/mm/yyyy',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)))]);
      R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',FiltroPeriodo);
      FiltroVis:='and (T850.TIPO_RICHIESTA IN (''A'',''I'',''S'') and not ' + FiltroNonAutorizzabili + ')';
      R180SetVariable(W024DM.selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
      // apertura temporanea per estrarre il riepilogo delle ore
      Open;
      First;
      while not Eof do
      begin
        if FieldByName('TIPO_RICHIESTA').AsString = 'S' then
        begin
          MinTotAutComp:=MinTotAutComp + R180OreMinutiExt(FieldByName('CF_ORE_COMP_AUTORIZ').AsString);
          MinTotAutLiq:=MinTotAutLiq + R180OreMinutiExt(FieldByName('CF_ORE_LIQ_AUTORIZ').AsString);
          if VarToStr(WR000DM.selT275.Lookup('CODICE',FieldByName('CF_CAUSALE_AUTORIZ').AsString,'ORENORMALI')) <> 'A' then
            MinTotAutLiq:=MinTotAutLiq + R180OreMinutiExt(FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
        end
        else
        begin
          MinTotInAttAutComp:=MinTotInAttAutComp + R180OreMinutiExt(FieldByName('CF_ORE_COMP_AUTORIZ').AsString);
          MinTotInAttAutLiq:=MinTotInAttAutLiq + R180OreMinutiExt(FieldByName('CF_ORE_LIQ_AUTORIZ').AsString);
          if VarToStr(WR000DM.selT275.Lookup('CODICE',FieldByName('CF_CAUSALE_AUTORIZ').AsString,'ORENORMALI')) <> 'A' then
            MinTotInAttAutLiq:=MinTotInAttAutLiq + R180OreMinutiExt(FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
        end;
        Next;
      end;
      MinResiduiComp:=MinTotAnnuoComp - (MinTotAutComp + MinTotInAttAutComp);
      MinResiduiLiq:=MinTotAnnuoLiq - (MinTotAutLiq + MinTotInAttAutLiq);
      W024DM.AggiornaTotali:=False;//Totali aggiornati fino alla prossima modifica, autorizzazione o cambio dipendente
    end;
    if W024DM.TipoRichStr <> '1' then
    begin
      try
        DFin:=EncodeDate(R180Anno(Date),R180Mese(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31));
      except
        DFin:=R180FineMese(Date);
      end;
      lblMessaggio.Caption:='Periodo di richiesta/autorizzazione dal ' + IntToStr(StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1)) + ' al ' + FormatDateTime('dd mmmm yyyy',DFin);
      if (W024DM.C90_W026UtilizzoDal = '0') and (W024DM.C90_W026UtilizzoAl = '0') then
        lblMessaggio.Caption:=lblMessaggio.Caption + ' - Attenzione! Destinazioni non permesse perchè il mese di ' + FormatDateTime('mmmm',R180AddMesi(Date,-1)) + ' è anomalo';
    end;
    lblMessaggio.Visible:=lblMessaggio.Caption <> '';
    grdRiepilogo.Visible:=(W024DM.TipoRichStr <> '1') and WR000DM.Responsabile;
    if grdRiepilogo.Visible then
      ImpostaGrigliaRiepilogo;

    //*** inizio
    CorrezionePeriodo;
    R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',C018.Periodo.Filtro);
    //*** fine

    if W024DM.TipoRichStr = '1' then
    begin
      // apertura temporanea per sapere se il dipendente è validabile nel periodo (eventualmente variato)
      Open;
      DipValidabile:=(RecordCount > 0) and EsisteCodIterValidabile;
    end
    else
      DipValidabile:=False;

    //*** inizio
    //Se passo a un dipendente validabile da uno non validabile e il chkVisTutte è selezionato, seleziono anche il chkVisValidate
    //*** dovrebbe farlo automaticamente
    //***if DipValidabile and chkVisTutte.Checked and not chkVisValidate.Checked then
    //***  C018.TipoRichiesteSel:=C018.TipoRichiesteSel + [trValidate];
    //Se passo a un dipendente non validabile, deseleziono chkVisValidate affinché non influisca successivamente su CorrezionePeriodo
    C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp + [trValidate];
    if not DipValidabile then
    begin
      C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp - [trValidate];
      //C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [trValidate];
    end;
    CorrezionePeriodo;
    //*** fine

    //*** inizio
    S:=C018.FiltroRichieste;
    FiltroVisTipo2:='';
    if (W024DM.TipoRichStr <> '1')
    and not (trTutte in C018.TipoRichiesteSel) then
    begin
      if trNonAutorizzabili in C018.TipoRichiesteSel then
        FiltroVisTipo2:=IfThen(S <> '',' or ') + FiltroNonAutorizzabili
      else if (trRichiedibili in C018.TipoRichiesteSel) or
              (trDaAutorizzare in C018.TipoRichiesteSel) or
              (trInAutorizzazione in C018.TipoRichiesteSel) then
        FiltroVisTipo2:=IfThen(S <> '',' and ') + 'not ' + FiltroNonAutorizzabili;
    end;

    FiltroVis:=' and (T850.TIPO_RICHIESTA <> ''C'')';
    if WR000DM.Responsabile then
      FiltroVis:=FiltroVis + ' and (T850.TIPO_RICHIESTA <> ''R'')';

    if (S <> '') or (FiltroVisTipo2 <> '') then
      FiltroVis:=FiltroVis + ' and (' + Copy(S,7,Length(S) - 7) + FiltroVisTipo2 + ')';

    R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',C018.Periodo.Filtro);
    R180SetVariable(W024DM.selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
    //*** fine

    // proseguo con l'apertura ufficiale del dataset
    R013Open(W024DM.selT065); //*** //Open;
    if //(not WR000DM.Responsabile) and
       (C018.TipoRichiesteSel = [trRichiedibili]) and
       (R180Giorno(Date) <= StrToIntDef(W024DM.C90_W026UtilizzoAl,0)) and
       (W024DM.selT065.RecordCount > 0) then
    begin
      W024DM.AggiornaSaldiSchede;
    end;

    if (not WR000DM.Responsabile) and AssegnaCodIterMancanti then
      Refresh;
    ConsideraRigheValidabili:=(RecordCount > 0) and EsisteCodIterValidabile;
    RigheAutorizzabili:=0;
    RigheLimiti:=0;
    RigheAvvertimenti:=0;
    if W024DM.TipoRichStr = '1' then
    begin
      //Per non visualizzare il pulsante "Autorizza tutto" quando accedo come Validatore,
      //bisogna controllare che non ci siano righe con un livello di autorizzazione relativo alla fase 2
      if WR000DM.Responsabile then
      begin
        First;
        while not Eof do
        begin
          C018.Id:=FieldByName('ID').AsInteger;
          C018.CodIter:=FieldByName('COD_ITER').AsString;
          LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
          if (LivelloAutorizzazione > 0)  //per escludere i livelli < 0 che non possono più intervenire in quanto sono presenti autorizzazioni a livelli superiori
          and (C018.FaseLivello[LivelloAutorizzazione] = 2)
          and R180In(FieldByName('TIPO_RICHIESTA').AsString,['A','V','I']) then
            inc(RigheAutorizzabili);
          if RigheAutorizzabili > 1 then
            Break;
          Next;
        end;
      end;
      W024DM.CampiCalcolati:=True;//Riabilita l'estrazione dei campi calcolati
    end
    else
    begin
      RigheAutorizzabili:=RecordCount; //utilizzato solo quando il responsabile visualizza le righe passibili di autorizzazione
      W024DM.CampiCalcolati:=True;//Riabilita l'estrazione dei campi calcolati
      First;
      while not Eof do
      begin
        //Righe con i limiti annuali
        if not FieldByName('CF_Res_Ore_Comp_Anno').IsNull
        or not FieldByName('CF_Res_Ore_Liq_Anno').IsNull then
          inc(RigheLimiti);
        //Righe con avvertimenti
        if not FieldByName('D_Avvertimenti').IsNull then
          inc(RigheAvvertimenti);
        if (RigheLimiti > 0) and (RigheAvvertimenti > 0) then
          Break;
        Next;
      end;
    end;
    First; //W024DM.CampiCalcolati deve essere assolutamente abilitato prima di questa istruzione!
  end;

  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  grdRichieste.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('CF_DATA','Mese','',nil);
    grdRichieste.medpAggiungiColonna('DESC_TIPO','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCED_CALC','Ore maturate','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCEDENTI','Ore da autorizzare','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_VALID','Ore validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_VALID','Ore liquidabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_AUTORIZ','Ore ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_AUTORIZ','Ore liquidabili ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_CAUSALE_AUTORIZ','Causale ' + IfThen(C018.IterModificaValori,'autorizzata','richiesta'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_AUTORIZ','Ore causalizzate ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSABILI_ANNO','Limite ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSATE_ANNO','Ore compensate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_COMP_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDABILI_ANNO','Limite ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDATE_ANNO','Ore liquidate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_LIQ_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_COMP','Riepilogo ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_LIQ','Riepilogo ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DALIQUIDARE','MIN_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DACOMPENSARE','MIN_ORE_DACOMPENSARE','',nil);

    grdRichieste.medpColonna('DBG_COMANDI').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('DESC_TIPO').Visible:=W024DM.TipoRichStr = '1';
    grdRichieste.medpColonna('ORE_ECCED_CALC').Visible:=W024DM.TipoRichStr = '1';
    grdRichieste.medpColonna('ORE_ECCEDENTI').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_ECCED_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_COMP_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_LIQ_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_CAUSALE_AUTORIZ').Visible:=W024DM.GestioneCausale;
    grdRichieste.medpColonna('CF_ORE_CAUS_AUTORIZ').Visible:=W024DM.GestioneCausale;
    grdRichieste.medpColonna('CF_ORE_COMPENSABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_COMPENSATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_COMP_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_LIQ_ANNO').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DACOMPENSARE').Visible:=False;
    grdRichieste.medpColonna('CF_RIEP_ORE_COMP').Visible:=W024DM.TipoRichStr <> '1';
    grdRichieste.medpColonna('CF_RIEP_ORE_LIQ').Visible:=W024DM.TipoRichStr <> '1';
    grdRichieste.medpColonna('D_AVVERTIMENTI').Visible:=(W024DM.TipoRichStr <> '1') and (RigheAvvertimenti > 0);
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('CF_DATA','Mese','',nil);
    grdRichieste.medpAggiungiColonna('DESC_TIPO','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCED_CALC','Ore maturate','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCEDENTI','Ore da autorizzare','',nil);
    grdRichieste.medpAggiungiColonna('ORE_DACOMPENSARE','Ore da compensare','',nil);
    grdRichieste.medpAggiungiColonna('ORE_DALIQUIDARE','Ore in pagamento','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('ORE_CAUSALIZZATE','Ore causalizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_VALID','Ore validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_VALID','Ore liquidabili validate','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_AUTORIZ','Ore autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_AUTORIZ','Ore liquidabili autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_CAUSALE_AUTORIZ','Causale autorizzata','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_AUTORIZ','Ore causalizzate autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSABILI_ANNO','Limite ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSATE_ANNO','Ore compensate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_COMP_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDABILI_ANNO','Limite ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDATE_ANNO','Ore liquidate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_LIQ_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_COMP','Riepilogo ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_LIQ','Riepilogo ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('MIN_ORE_DALIQUIDARE','MIN_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DACOMPENSARE','MIN_ORE_DACOMPENSARE','',nil);

    grdRichieste.medpColonna('DESC_TIPO').Visible:=W024DM.TipoRichStr = '1';
    grdRichieste.medpColonna('ORE_ECCED_CALC').Visible:=W024DM.TipoRichStr = '1';
    grdRichieste.medpColonna('CAUSALE').Visible:=W024DM.GestioneCausale;
    grdRichieste.medpColonna('ORE_CAUSALIZZATE').Visible:=W024DM.GestioneCausale;
    grdRichieste.medpColonna('CF_ORE_ECCED_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_COMP_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_LIQ_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_ECCED_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_COMP_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_LIQ_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_CAUSALE_AUTORIZ').Visible:=W024DM.GestioneCausale and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_CAUS_AUTORIZ').Visible:=W024DM.GestioneCausale and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_COMPENSABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_COMPENSATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_COMP_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_LIQ_ANNO').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DACOMPENSARE').Visible:=False;
    grdRichieste.medpColonna('CF_RIEP_ORE_COMP').Visible:=RigheLimiti > 0;
    grdRichieste.medpColonna('CF_RIEP_ORE_LIQ').Visible:=RigheLimiti > 0;
    grdRichieste.medpColonna('D_AVVERTIMENTI').Visible:=(W024DM.TipoRichStr <> '1') and (RigheAvvertimenti > 0);
  end;

  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  if not SolaLettura then
  begin
    grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
    grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
    grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
    grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    if WR000DM.Responsabile then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'',IfThen(W024DM.TipoRichStr <> '1','Si',''),'','');
      if W024DM.TipoRichStr <> '1' then
        grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

function TW024FRichiestaStraordinari.EsisteCodIterValidabile:Boolean;
begin
  Result:=False;
  with W024DM.selT065 do
  begin
    First;
    while not Eof do
    begin
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      if C018.EsisteFase[T065FASE_VALIDAZIONE] then
      begin
        Result:=True;
        Break;
      end;
      Next;
    end;
    First;
  end;
end;

function TW024FRichiestaStraordinari.AssegnaCodIterMancanti:Boolean;
begin
  Result:=False;
  with W024DM.selT065 do
  begin
    while not Eof do
    begin
      if (FieldByName('TIPO_RICHIESTA').AsString = 'R') and (FieldByName('COD_ITER').IsNull) then
      begin
        C018.SetCodIter;
        if C018.CodIter <> '' then
        begin
          SessioneOracle.Commit;
          Result:=True;
        end;
      end;
      Next;
    end;
    First;
  end;
end;

procedure TW024FRichiestaStraordinari.grdRiepilogoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  if not grdRiepilogo.Visible then
    exit;
  ACell.Css:=ACell.Css + ' align_center';
  if AColumn > 0 then
    ACell.Css:=ACell.Css + ' elencoOre';
  if ARow = 0 then
    ACell.Css:=ACell.Css + ' riga_intestazione'
  else
    ACell.Css:=ACell.Css + ' riga_bianca';
end;

procedure TW024FRichiestaStraordinari.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,LivelloAutorizzazione: Integer;
  IWImg: TmeIWImageFile;
begin
  //Righe dati
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      //***IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      //***if C018.SetIconaAllegati(IWImg) then
      //***  IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if not SolaLettura then
    begin
      LivelloAutorizzazione:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
      //Tolgo i componenti se non ci sono le condizioni per la modifica/autorizzazione
      //Validatore
      if WR000DM.Responsabile and (C018.FaseLivello[LivelloAutorizzazione] = 1) then
      begin
        //elimino check di autorizzazione
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
        //Stato diverso da 'A' e 'V': elimino l'icona di modifica
        if not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['A','V']) then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      end;
      //Responsabile: Stato diverso da 'A', 'V' e 'I'
      if WR000DM.Responsabile and (C018.FaseLivello[LivelloAutorizzazione] = 2) and
         not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['A','V','I']) then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      //Responsabile o Validatore: verifico se posso modificare i valori
      if WR000DM.Responsabile and
         not C018.ModificaValori(LivelloAutorizzazione) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      //Dipendente:
      //  Gestione Banca ore: Stato diverso da 'R' (oppure stato 'R' ma la richiesta 'Corrente' non è la prima) e 'A'
      //  Gestione Str. ann.: Stato diverso da 'R' e 'A'
      if (not WR000DM.Responsabile) and
         (   not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['R','A'])
          or ((W024DM.TipoRichStr = '1') and
              (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R') and
              (grdRichieste.medpValoreColonna(i,'TIPO') = 'C') and
              (grdRichieste.medpValoreColonna(i,'DATA') <> DateTimeToStr(DataPrimaRichiesta))
              )) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if LivelloAutorizzazione < 0 then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      // Associo l'evento OnClick all'icona di modifica
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if StileCella1 = '' then
        begin
          with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
          begin
            StileCella1:=Cell[0,0].Css;
            StileCella2:=Cell[0,1].Css;
          end;
        end;
        (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        if (W024DM.TipoRichStr = '1')
        or WR000DM.Responsabile
        or (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R') then
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:='invisibile';
      end;
      // Associo l'evento OnClick al checkbox di autorizzazione
      if WR000DM.Responsabile and (grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil) then
        C018.SetValoriAut(grdRichieste,i,1,0,IfThen(W024DM.TipoRichStr = '1',-1,1),chkAutorizzazioneClick);
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna:Integer;
   S,TipoRichiesta:String;
begin
  inherited;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  //evidenziazione dei movimenti riferiti a liqudazioni non destinate, e destinate successivamente
  if (ARow > 0) and (W024DM.TipoRichStr = '4') then
  begin
    if W024DM.selT065.Lookup('ROWID',grdRichieste.medpValoreColonna(ARow - 1,'DBG_ROWID'),'ID_CONGUAGLIO') = -1 then
    begin //destinzione sucessiva
      ACell.Css:=StringReplace(ACell.Css,'riga_selezionata','bg_giallo_pastello',[rfReplaceAll]);
      ACell.Css:=StringReplace(ACell.Css,'riga_bianca','bg_giallo_pastello',[rfReplaceAll]);
      ACell.Css:=StringReplace(ACell.Css,'riga_colorata','bg_giallo_pastello',[rfReplaceAll]);
      TipoRichiesta:=VartoStr(W024DM.selT065.Lookup('ROWID',grdRichieste.medpValoreColonna(ARow - 1,'DBG_ROWID'),'TIPO_RICHIESTA'));
      if TipoRichiesta = 'R' then
        ACell.Hint:='Ore con maggiorazione già liquidata, in attesa di destinazione definitiva'
      else if TipoRichiesta = 'S' then
        ACell.Hint:='Ore con maggiorazione già liquidata, in attesa di liquidazione definitiva'
      else if TipoRichiesta = 'L' then
        ACell.Hint:='Ore con maggiorazione già liquidata, liquidate definitivamente';
    end
    else if VarToStr(W024DM.selT065.Lookup('ROWID',grdRichieste.medpValoreColonna(ARow - 1,'DBG_ROWID'),'COD_ITER')) = 'AUTO' then
    begin //liquidazioni non destinate
      ACell.Css:=StringReplace(ACell.Css,'riga_selezionata','bg_rosa',[rfReplaceAll]);
      ACell.Css:=StringReplace(ACell.Css,'riga_bianca','bg_rosa',[rfReplaceAll]);
      ACell.Css:=StringReplace(ACell.Css,'riga_colorata','bg_rosa',[rfReplaceAll]);
      ACell.Hint:='Movimento di liquidazione della sola maggiorazione';
    end;
  end;

  if ((W024DM.TipoRichStr = '2') and not WR000DM.Responsabile)
  and (grdRichieste.medpColonna(NumColonna).DataField = 'ORE_ECCEDENTI') then
    ACell.CSS:='invisibile'; //Se si rende invisibile la colonna fuori dal render, non si riesce ad assegnare il testo al relativo edit nell'evento async
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'D_AUTORIZZAZIONE') then
    ACell.CSS:=ACell.CSS + ' align_center font_grassetto';
  ACell.Wrap:=ARow <> 1;
  //Formatto il titolo dei riepiloghi
  if (ARow = 0) and (   (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_COMP')
                     or (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_LIQ')) then
  begin
    ACell.Css:=ACell.Css + ' align_center elencoOre';
    ACell.RawText:=True;
    ACell.Text:=ACell.Text + '<div align="center">' +
                             '<span>Limite</span>' +
                             '<span>Fruito</span>' +
                             '<span>Residuo</span>' +
                             '</div>';
  end;
  //Imposto l'hint con la descrizione del mese
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (   (grdRichieste.medpColonna(NumColonna).DataField = 'CAUSALE')
       or (grdRichieste.medpColonna(NumColonna).DataField = 'CF_CAUSALE_AUTORIZ'))
  and (ACell.Text <> '') then
    ACell.Hint:=VarToStr(WR000DM.selT275.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
  //Imposto l'hint con la descrizione della causale
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (   (grdRichieste.medpColonna(NumColonna).DataField = 'CAUSALE')
       or (grdRichieste.medpColonna(NumColonna).DataField = 'CF_CAUSALE_AUTORIZ'))
  and (ACell.Text <> '') then
    ACell.Hint:=VarToStr(WR000DM.selT275.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
  //Imposto l'hint con la descrizione della tipologia
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (grdRichieste.medpColonna(NumColonna).DataField = 'D_TIPO_RICHIESTA') then
  begin
    if ACell.Text = 'R' then
      ACell.Hint:='richiedibile'
    else if ACell.Text = 'A' then
      ACell.Hint:='da autorizzare'
    else if ACell.Text = 'X' then
      ACell.Hint:='non autorizzabile'
    else if ACell.Text = 'V' then
      ACell.Hint:='validata'
    else if ACell.Text = 'I' then
      ACell.Hint:='in autorizzazione'
    else if ACell.Text = 'S' then
      ACell.Hint:='autorizzata'
    else if ACell.Text = 'N' then
      ACell.Hint:='negata';
  end;
  //Formatto il riepilogo delle ore compensabili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_COMP') then
  begin
    S:=grdRichieste.medpValoreColonna(ARow - 1,'CF_Riep_Ore_Comp');
    if S <> '' then
    begin
      ACell.Css:=ACell.Css + ' align_center elencoOre';
      ACell.RawText:=True;
      ACell.Text:='<div align="center">';
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span' + IfThen(R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Compensate_Anno')) > R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Compensabili_Anno')),' class="riga_evidenziata"') + '>' + S + '</span>';
      ACell.Text:=ACell.Text + '</div>';
    end;
  end;
  //Formatto il riepilogo delle ore liquidabili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (grdRichieste.medpColonna(NumColonna).DataField = 'CF_RIEP_ORE_LIQ') then
  begin
    S:=grdRichieste.medpValoreColonna(ARow - 1,'CF_Riep_Ore_Liq');
    if S <> '' then
    begin
      ACell.Css:=ACell.Css + ' align_center elencoOre';
      ACell.RawText:=True;
      ACell.Text:='<div align="center">';
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span' + IfThen(R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Liquidate_Anno')) > R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Liquidabili_Anno')),' class="riga_evidenziata"') + '>' + S + '</span>';
      ACell.Text:=ACell.Text + '</div>';
    end;
  end;
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW024FRichiestaStraordinari.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  if (Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  cdsT065.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW024FRichiestaStraordinari.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W024DM.selT065 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga in meno
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
      Exit;
    end;
  end;
  //C018.VisualizzaDettagli(Sender);
  VisualizzaDettagli(Sender);
end;

procedure TW024FRichiestaStraordinari.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (Operazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;

  DBGridColumnClick(Sender,FN);

  // se record non esiste -> errore grave
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Si è verificato un errore durante la modifica della richiesta: il record non è più disponibile.');
    Exit;
  end;

  actCancRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.actCancRichiesta(FN:String);
var i:Integer;
begin
  //cancellazione riga
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
  C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
  if grdRichieste.medpValoreColonna(i,'DESC_TIPO') = 'Conguaglio' then
    C018.EliminaIter
  else
    with W024DM.selT065 do
    begin
      RefreshRecord;
      Edit;
      FieldByName('ORE_ECCEDENTI').AsString:=FieldByName('ORE_ECCED_CALC').AsString;
      FieldByName('ORE_DACOMPENSARE').AsString:='';
      FieldByName('ORE_DALIQUIDARE').AsString:='';
      FieldByName('CAUSALE').AsString:='';
      FieldByName('ORE_CAUSALIZZATE').AsString:='';
      FieldByName('DATA_RICHIESTA').AsString:='';
      Post;
      C018.SetTipoRichiesta('R');
      C018.SetDataRichiesta;
    end;
  SessioneOracle.Commit;
  VisualizzaDipendenteCorrente;

  //eventuale posizionamento su riga appena stroncata
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',FN,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW024FRichiestaStraordinari.imgModificaClick (Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // modifica
  if Operazione = 'M' then
    Exit;
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga in meno
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
    Exit;
  end;
  DBGridColumnClick(grdRichieste,FN);
  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;
  with W024DM do
  begin
    GetMinArr;
    CalcolaLimitiLiquidazioneRecupero;
  end;
  TrasformaComponenti(FN);
end;

procedure TW024FRichiestaStraordinari.imgConfermaClick (Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // applicazione modifiche
  // se record non esiste -> errore grave
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    Operazione:='';
    grdRichieste.medpBrowse:=True;
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    GGetWebApplicationThreadVar.ShowMessage('Si è verificato un errore durante la modifica della richiesta: il record non è più disponibile.');
    Exit;
  end;
  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  actModRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.imgAnnullaClick(Sender: TObject);
var i:Integer;
    FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // annullamento modifiche
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  TrasformaComponenti(FN);

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if (W024DM.TipoRichStr <> '1')
  and (not WR000DM.Responsabile)
  and (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R')
  and (grdRichieste.medpValoreColonna(i,'DESC_TIPO') = 'Conguaglio') then
    actCancRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.TrasformaComponenti(FN:String);
{ Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRichieste }
  function ApplicaArrotondamento(S:String):String;
  var min:Integer;
  begin
    Result:=S;
    min:=R180OreMinutiExt(S);
    if (W024DM.MinArr <> 1) and (min > 0) then
      Result:=R180MinutiOre(Trunc(R180Arrotonda(min,W024DM.MinArr,'E')));
  end;
var
  DaTestoAControlli: Boolean;
  i,LivelloAutorizzazione:Integer;
  S:String;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
  LivelloAutorizzazione:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);

  case C018.FaseLivello[LivelloAutorizzazione] of
    0:begin
        ColOreEcc:=grdRichieste.medpIndexColonna('ORE_ECCEDENTI');
        ColOreComp:=grdRichieste.medpIndexColonna('ORE_DACOMPENSARE');
        ColOreLiq:=grdRichieste.medpIndexColonna('ORE_DALIQUIDARE');
        ColCaus:=grdRichieste.medpIndexColonna('CAUSALE');
        ColOreCaus:=grdRichieste.medpIndexColonna('ORE_CAUSALIZZATE');
      end;
    1:begin
        ColOreEcc:=grdRichieste.medpIndexColonna('CF_ORE_ECCED_VALID');
        ColOreComp:=grdRichieste.medpIndexColonna('CF_ORE_COMP_VALID');
        ColOreLiq:=grdRichieste.medpIndexColonna('CF_ORE_LIQ_VALID');
      end;
    2:begin
        ColOreEcc:=grdRichieste.medpIndexColonna('CF_ORE_ECCED_AUTORIZ');
        ColOreComp:=grdRichieste.medpIndexColonna('CF_ORE_COMP_AUTORIZ');
        ColOreLiq:=grdRichieste.medpIndexColonna('CF_ORE_LIQ_AUTORIZ');
        ColCaus:=grdRichieste.medpIndexColonna('CF_CAUSALE_AUTORIZ');
        ColOreCaus:=grdRichieste.medpIndexColonna('CF_ORE_CAUS_AUTORIZ');
      end;
  end;

  DaTestoAControlli:=grdRichieste.medpCompGriglia[i].CompColonne[ColOreEcc] = nil;

  // Gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli or (W024DM.TipoRichStr = '1') or WR000DM.Responsabile or (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R'),'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
    Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  // flag autorizzazione
  if grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil then
  begin
    (grdRichieste.medpCompCella(i,1,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
    if grdRichieste.medpCompCella(i,1,1) <> nil then
      (grdRichieste.medpCompCella(i,1,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  end;

  if DaTestoAControlli then
  begin
    // ore da autorizzare/autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColOreEcc,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit) do
    begin
      Name:='edtOreEcc';
      case C018.FaseLivello[LivelloAutorizzazione] of
        0:Text:=grdRichieste.medpValoreColonna(i,'ORE_ECCEDENTI');
        1:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_ECCED_VALID');
        2:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_ECCED_AUTORIZ');
      end;
      if R180In(W024DM.TipoRichStr,['3','4'])
      and not WR000DM.Responsabile then
      begin
        ReadOnly:=True;
        Css:=Css + ' bg_grigio';
      end;
      OnAsyncExit:=CampoOreAsyncExit;
    end;
    // ore da compensare/da compensare autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColOreComp,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit) do
    begin
      Name:='edtOreComp';
      case C018.FaseLivello[LivelloAutorizzazione] of
        0:Text:=grdRichieste.medpValoreColonna(i,'ORE_DACOMPENSARE');
        1:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_VALID');
        2:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_AUTORIZ');
      end;
      (*//Propongo l'unica combinazione possibile
      if (Text = '')
      and (W024DM.TipoRichStr = '2')
      and (R180OreMinutiExt(TIWEdit(grdRichieste.medpCompCella(i,ColOreEcc,0)).Text) = R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Res_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno'))) then
        Text:=grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Res_Anno');*)
      OnAsyncExit:=CampoOreAsyncExit;
      if W024DM.TipoRichStr = '4' then
      begin
        //Hint:='Ore minime da compensare: ' + ApplicaArrotondamento(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DACOMPENSARE')));
        Hint:=Format('Range ore da recuperare: %s - %s',[R180MinutiOre(W024DM.MinOreDaCompensare),R180MinutiOre(W024DM.MaxOreDaCompensare)]);
        if (W024DM.selT065.Lookup('ROWID',FN,'ID_CONGUAGLIO') = -1) and (W024DM.MaxOreDaCompensare > 0) then
          Hint:=Hint + Format(' Le ore verranno considerate nel saldo Banca Ore del mese di %s',[FormatDateTime('mmmm yyyy',W024DM.selT065Limiti.FieldByName('DATA').AsDateTime)]);
      end;
    end;
    // ore in pagamento/in pagamento autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColOreLiq,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit) do
    begin
      Name:='edtOreLiq';
      case C018.FaseLivello[LivelloAutorizzazione] of
        0:Text:=grdRichieste.medpValoreColonna(i,'ORE_DALIQUIDARE');
        1:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_VALID');
        2:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_AUTORIZ');
      end;
      (*//Propongo l'unica combinazione possibile
      if (Text = '')
      and (W024DM.TipoRichStr = '2')
      and (R180OreMinutiExt(TIWEdit(grdRichieste.medpCompCella(i,ColOreEcc,0)).Text) = R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Res_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno'))) then
        Text:=grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno');*)
      OnAsyncExit:=CampoOreAsyncExit;
      if W024DM.TipoRichStr = '4' then
        //Hint:='Ore minime da liquidare: ' + ApplicaArrotondamento(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DALIQUIDARE')));
        Hint:=Format('Range ore da liquidare: %s - %s',[R180MinutiOre(W024DM.MinOreDaLiquidare),R180MinutiOre(W024DM.MaxOreDaLiquidare)]);
    end;
    if W024DM.GestioneCausale then
    begin
      // causale/causale autorizzata
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','Selezione della causale per lo straordinario','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,ColCaus,grdRichieste.Componenti);
      with (grdRichieste.medpCompCella(i,ColCaus,0) as TmeIWComboBox) do
      begin
        Name:='cmbCausale';
        ItemsHaveValues:=True;
        Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
        Items.BeginUpdate;
        Items.Add('');
        WR000DM.selT275.First;
        while not WR000DM.selT275.Eof do
        begin
          Items.Values[StringReplace(Format('%-5s %s',[WR000DM.selT275.FieldByName('CODICE').AsString,WR000DM.selT275.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll])]:=WR000DM.selT275.FieldByName('CODICE').AsString;
          WR000DM.selT275.Next;
        end;
        Items.EndUpdate;
        case C018.FaseLivello[LivelloAutorizzazione] of
          0:S:=grdRichieste.medpValoreColonna(i,'CAUSALE');
          2:S:=grdRichieste.medpValoreColonna(i,'CF_CAUSALE_AUTORIZ');
        end;
        ItemIndex:=Max(0,R180IndexOf(Items,S,5));
        OnAsyncChange:=cmbCausaleAsyncChange;
      end;
      // ore causalizzate/causalizzate autorizzate
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,ColOreCaus,grdRichieste.Componenti);
      with (grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit) do
      begin
        Name:='edtOreCaus';
        case C018.FaseLivello[LivelloAutorizzazione] of
          0:Text:=grdRichieste.medpValoreColonna(i,'ORE_CAUSALIZZATE');
          2:Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_CAUS_AUTORIZ');
        end;
        OnAsyncExit:=CampoOreAsyncExit;
      end;
    end;
  end
  else
  begin
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColOreEcc]);
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColOreComp]);
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColOreLiq]);
    if W024DM.GestioneCausale then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCaus]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColOreCaus]);
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.CampoOreAsyncExit(Sender: TObject; EventParams: TStringList);
var i,MinEcc,MinEccOri,MinComp,MinLiq,MinCaus,LiqTot,CompTot,SaldoTot:Integer;
    MinOreDaLiquidare,MinOreDaCompensare,MaxOreDaLiquidare,MaxOreDaCompensare:Integer;
begin
  inherited;
  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  if Trim((Sender as TmeIWEdit).Text) = '' then
  begin
    if W024DM.TipoRichStr = '4' then //Per TORINO_CSI, se il campo è nullo non si valorizza automaticamente l'altro
      exit
    else
      (Sender as TmeIWEdit).Text:='00.00';
  end;
  //Controllo che il valore sia stato inserito nel formato corretto
  try
    if (Length(Copy((Sender as TmeIWEdit).Text,Pos('.',(Sender as TmeIWEdit).Text) + 1)) <> 2)
    or not OreMinutiValidate((Sender as TmeIWEdit).Text) then
      (Sender as TmeIWEdit).Text:=R180MinutiOre(R180OreMinutiExt((Sender as TmeIWEdit).Text));
      //raise exception.create('Indicare il valore delle ore nel formato HH.MM');
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      (Sender as TmeIWEdit).SetFocus;
      Exit;
    end;
  end;
  if W024DM.MinArr <> 1 then
    (Sender as TmeIWEdit).Text:=R180MinutiOre(R180OreMinutiExt((Sender as TmeIWEdit).Text) - (R180OreMinutiExt((Sender as TmeIWEdit).Text) mod W024DM.MinArr));
  MinComp:=R180OreMinutiExt((grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit).Text);
  MinLiq:=R180OreMinutiExt((grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit).Text);
  if W024DM.GestioneCausale and (Trim((grdRichieste.medpCompCella(i,ColCaus,0) as TmeIWComboBox).Text) <> '') then
    MinCaus:=R180OreMinutiExt((grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit).Text)
  else
    MinCaus:=0;

  if (W024DM.TipoRichStr = '2') and not WR000DM.Responsabile then
  begin
    MinEcc:=MinComp + MinLiq;
    MinEccOri:=MinEcc;
    (grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text:=R180MinutiOre(MinEcc);
  end
  else
  begin
    MinEcc:=R180OreMinutiExt((grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text);
    MinEccOri:=MinEcc;
    //Limito l'eccedenza richiedibile al residuo annuo disponibile
    if W024DM.TipoRichStr = '3' then
    begin
      MinEcc:=min(MinEcc,R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno')));
      MinEcc:=max(0,MinEcc);
    end;
    //Se ho cambiato le ore eccedenti...
    if (Sender as TmeIWEdit).Name = 'edtOreEcc' then
    begin
      MinEcc:=IfThen(MinEcc > 0,MinEcc,0);
      //Se diminuisco le ore, tolgo prima dalle ore compensabili
      if (MinComp + MinLiq + MinCaus) > MinEcc then
      begin
        MinComp:=MinEcc - MinLiq - MinCaus;
        MinComp:=IfThen(MinComp > 0,MinComp,0);
        MinLiq:=MinEcc - MinComp - MinCaus;
        MinLiq:=IfThen(MinLiq > 0,MinLiq,0);
      end
      //Se aumento le ore, aggiungo prima sulle ore liquidabili
      else if (MinComp + MinLiq + MinCaus) < MinEcc then
      begin
        MinLiq:=MinEcc - MinComp - MinCaus;
        MinLiq:=IfThen(MinLiq > 0,MinLiq,0);
        MinComp:=MinEcc - MinLiq - MinCaus;
        MinComp:=IfThen(MinComp > 0,MinComp,0);
      end;
      MinCaus:=MinEcc - MinComp - MinLiq;
      MinCaus:=IfThen(MinCaus > 0,MinCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreComp' then
    begin
      MinComp:=IfThen(MinComp > 0,IfThen(MinComp > MinEcc,MinEcc,MinComp),0);
      MinLiq:=MinEcc - MinComp - MinCaus;
      MinLiq:=IfThen(MinLiq > 0,MinLiq,0);
      MinCaus:=MinEcc - MinComp - MinLiq;
      MinCaus:=IfThen(MinCaus > 0,MinCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreLiq' then
    begin
      MinLiq:=IfThen(MinLiq > 0,IfThen(MinLiq > MinEcc,MinEcc,MinLiq),0);
      MinComp:=MinEcc - MinLiq - MinCaus;
      MinComp:=IfThen(MinComp > 0,MinComp,0);
      MinCaus:=MinEcc - MinComp - MinLiq;
      MinCaus:=IfThen(MinCaus > 0,MinCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreCaus' then
    begin
      MinCaus:=IfThen(MinCaus > 0,IfThen(MinCaus > MinEcc,MinEcc,MinCaus),0);
      MinComp:=MinEcc - MinLiq - MinCaus;
      MinComp:=IfThen(MinComp > 0,MinComp,0);
      MinLiq:=MinEcc - MinComp - MinCaus;
      MinLiq:=IfThen(MinLiq > 0,MinLiq,0);
    end;
  end;
  if W024DM.TipoRichStr = '4' then
  begin
    //TORINO_CSI_PRV: verifico che le ore da liquidare non siano sotto il minimo previsto (arrotondato)
    (**)
    with W024DM do
    begin
      {
      LiqTot:=selT065Limiti.FieldByName('ORE_DALIQUIDARE').AsInteger + IfThen(selT065.FieldByName('ID_CONGUAGLIO').AsInteger = 0,MinLiq);
      CompTot:=selT065Limiti.FieldByName('ORE_DACOMPENSARE').AsInteger + IfThen(selT065.FieldByName('ID_CONGUAGLIO').AsInteger = -1,MinComp);
      SaldoTot:=selT065Limiti.FieldByName('SALDO_COMPLESSIVO').AsInteger;
      }
      if selT065.FieldByName('ID_CONGUAGLIO').AsInteger = 0 then
      begin
        {
        MinOreDaLiquidare:=max(0,SaldoTot + CompTot - (20*60));
        MinOreDaLiquidare:=min(MinOredaLiquidare,MinEcc);
        if (MinArr <> 1) and (MinOreDaLiquidare > 0) then
          MinOreDaLiquidare:=Trunc(R180Arrotonda(MinOreDaLiquidare,MinArr,'E'));

        MaxOreDaLiquidare:=max(0,SaldoTot + CompTot);
        MaxOreDaLiquidare:=min(MinOredaLiquidare,MinEcc);
        if (MinArr <> 1) and (MaxOreDaLiquidare > 0) then
          MaxOreDaLiquidare:=Trunc(R180Arrotonda(MaxOreDaLiquidare,MinArr,'E'));
        }
        if MinLiq < MinOreDaLiquidare then  //In questo caso MinLiq = LiqTot
          MinLiq:=MinOreDaLiquidare;
        if MinLiq > MaxOreDaLiquidare then
          MinLiq:=MaxOreDaLiquidare;//LiqTot:=min(MinEcc,SaldoTot + CompTot);
        MinComp:=MinEcc - MinLiq;
      end
      else if selT065.FieldByName('ID_CONGUAGLIO').AsInteger = -1 then
      begin
        {
        MinOreDaCompensare:=max(0,LiqTot - SaldoTot);
        if (MinArr <> 1) and (MinOreDaCompensare > 0) then
          MinOreDaCompensare:=Trunc(R180Arrotonda(MinOreDaCompensare,MinArr,'E'));
        MaxOreDaCompensare:=max(0,LiqTot - SaldoTot + (20*60));
        if (MinArr <> 1) and (MaxOreDaCompensare > 0) then
          MaxOreDaCompensare:=Trunc(R180Arrotonda(MaxOreDaCompensare,MinArr,'E'));
        if CompTot < MinOreDaCompensare then
          inc(MinComp,MinOreDaCompensare - CompTot);//CompTot:=LiqTot - SaldoTot;
        if CompTot > MaxOreDaCompensare then
          dec(MinComp,CompTot - MaxOreDaCompensare);//CompTot:=min(MinEcc,LiqTot - SaldoTot + (20*60));
        }
        if MinComp < MinOreDaCompensare then  //In questo caso MinComp = CompTot
          MinComp:=MinOreDaCompensare;
        if MinComp > MaxOreDaCompensare then
          MinComp:=MaxOreDaCompensare;
        MinComp:=max(0,MinComp);
        MinComp:=min(MinComp,MinEcc);
        MinLiq:=MinEcc - MinComp;
      end
    end;
    (*
    MinOreDaLiquidare:=R180OreMinutiExt(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DALIQUIDARE')));
    if (MinArr <> 1) and (MinOreDaLiquidare > 0) then
      MinOreDaLiquidare:=Trunc(R180Arrotonda(MinOreDaLiquidare,MinArr,'E'));
    if MinLiq < MinOreDaLiquidare then
    begin
      dec(MinComp,MinOreDaLiquidare - MinLiq);
      MinLiq:=MinOreDaLiquidare;
    end;
    //TORINO_CSI_PRV: verifico che le ore da compensare non siano sotto il minimo previsto (arrotondato)
    MinOreDaCompensare:=R180OreMinutiExt(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DACOMPENSARE')));
    if (MinArr <> 1) and (MinOreDaCompensare > 0) then
      MinOreDaCompensare:=Trunc(R180Arrotonda(MinOreDaCompensare,MinArr,'E'));
    if MinComp < MinOreDaCompensare then
    begin
      dec(MinLiq,MinOreDaCompensare - MinComp);
      MinComp:=MinOreDaCompensare;
    end;
    *)
  end;
  //GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTOREECC").value = "' + R180MinutiOre(MinEcc) + '"');
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTOREECC").value = "' + R180MinutiOre(MinEccOri) + '"');
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORECOMP").value = "' + R180MinutiOre(MinComp) + '"');
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORELIQ").value = "' + R180MinutiOre(MinLiq) + '"');
  if W024DM.GestioneCausale then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORECAUS").value = "' + R180MinutiOre(MinCaus) + '"');
  if (Sender as TmeIWEdit).Name = 'edtOreCaus' then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORECOMP").focus();');
  if (   ((W024DM.TipoRichStr = '1') and ((Sender as TmeIWEdit).Name = 'edtOreEcc'))
      or ((W024DM.TipoRichStr <> '1') and ((Sender as TmeIWEdit).Name = 'edtOreComp')))
  and (MinComp = 0)
  and (MinLiq = 0)
  and (MinCaus = 0)
  and (R180OreMinutiExt(IfThen(WR000DM.Responsabile,grdRichieste.medpValoreColonna(i,'ORE_ECCEDENTI'),grdRichieste.medpValoreColonna(i,'ORE_ECCED_CALC'))) <> 0) then
    GGetWebApplicationThreadVar.ShowMessage('Attenzione! Verranno ' + IfThen(WR000DM.Responsabile,'autorizzate','richieste e autorizzate') + ' 0 ore!');
end;

procedure TW024FRichiestaStraordinari.cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if (Sender as TmeIWComboBox).Text = '' then
  begin
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORECAUS").value = "' + R180MinutiOre(0) + '";' + CRLF +
             'FindElem("EDTORECOMP").focus();' + CRLF +
             'FindElem("EDTORELIQ").focus();'+ CRLF + //Necessario per far scattare il ricalcolo delle ore, privilegiando le liquidabili
             'FindElem("EDTORECOMP").focus();');
  end;
end;

function TW024FRichiestaStraordinari.ControlliOK(FN: String): Boolean;
var i,Diff,OreEcc:Integer;
    SEcc,SComp,SLiq,SCaus:String;
begin
  Result:=False;
  try
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    SEcc:=(grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text;
    SComp:=(grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit).Text;
    SLiq:=(grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit).Text;
    if (Length(Copy(SEcc,Pos('.',SEcc) + 1)) <> 2) or not OreMinutiValidate(SEcc) then
      raise exception.create('Indicare il valore delle ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + ' nel formato HH.MM');
    if (Length(Copy(SComp,Pos('.',SComp) + 1)) <> 2) or not OreMinutiValidate(SComp) then
      raise exception.create('Indicare il valore delle Ore da compensare nel formato HH.MM');
    if (Length(Copy(SLiq,Pos('.',SLiq) + 1)) <> 2) or not OreMinutiValidate(SLiq) then
      raise exception.create('Indicare il valore delle Ore in pagamento nel formato HH.MM');
    if W024DM.GestioneCausale then
    begin
      SCaus:=(grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit).Text;
      if (Length(Copy(SCaus,Pos('.',SCaus) + 1)) <> 2) or not OreMinutiValidate(SCaus) then
        raise exception.create('Indicare il valore delle Ore causalizzate nel formato HH.MM');
    end;
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      Exit;
    end;
  end;
  //Ore da autorizzare maggiore o uguale a 00.00
  if R180OreMinutiExt(SEcc) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + ' minore di 00.00!');
    Exit;
  end;
  //Ore da compensare maggiore o uguale a 00.00
  if R180OreMinutiExt(SComp) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da compensare minore di 00.00!');
    Exit;
  end;
  //Ore in pagamento maggiore o uguale a 00.00
  if R180OreMinutiExt(SLiq) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore in pagamento minore di 00.00!');
    Exit;
  end;
  //Ore causalizzate maggiore o uguale a 00.00
  if R180OreMinutiExt(SCaus) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore causalizzate minore di 00.00!');
    Exit;
  end;
  if W024DM.TipoRichStr <> '1' then
  begin
    //Ore da compensare maggiori del disponibile
    if (grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno') <> '')
    and (R180OreMinutiExt(SComp) > 0) then
    begin
      Diff:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,IfThen(WR000DM.Responsabile,'CF_ORE_COMP_AUTORIZ','ORE_DACOMPENSARE')));
      if R180OreMinutiExt(SComp) > Diff then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da compensare (' + SComp + ') maggiore di quelle disponibili (' + R180MinutiOre(Max(0,Diff)) + ')!');
        Exit;
      end;
    end;
    //Ore da liquidare maggiori del disponibile
    if (grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno') <> '')
    and (R180OreMinutiExt(SLiq) > 0) then
    begin
      Diff:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,IfThen(WR000DM.Responsabile,'CF_ORE_LIQ_AUTORIZ','ORE_DALIQUIDARE')));
      if R180OreMinutiExt(SLiq) > Diff then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore in pagamento (' + SLiq + ') maggiore di quelle disponibili (' + R180MinutiOre(Max(0,Diff)) + ')!');
        Exit;
      end;
    end;
  end;

  OreEcc:=R180OreMinutiExt(SEcc);
  //Limito il totale delle ore eccedenti al residuo annuo
  if W024DM.TipoRichStr = '3' then
  begin
    OreEcc:=min(OreEcc,R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno')));
    OreEcc:=max(0,OreEcc);
  end;

  //Ore da autorizzare minore o uguale a quelle richieste/calcolate
  if not WR000DM.Responsabile
  and (OreEcc > R180OreMinutiExt(W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString)) then
  begin
    if W024DM.TipoRichStr = '1' then
      GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da autorizzare (' + R180MinutiOre(OreEcc) + ') maggiore di quello calcolato (' + W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString + ')!')
    else
      GGetWebApplicationThreadVar.ShowMessage('Il numero di ore indicato non è disponibile!');
    Exit;
  end
  else if WR000DM.Responsabile
  and (OreEcc > R180OreMinutiExt(W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString)) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore autorizzate (' + R180MinutiOre(OreEcc) + ') maggiore di quello richiesto (' + W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString + ')!');
    Exit;
  end;
  //Ore da compensare + Ore in pagamento = Ore da autorizzare
  if (R180OreMinutiExt(SComp) + R180OreMinutiExt(SLiq) + R180OreMinutiExt(SCaus)) <> OreEcc then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La somma delle Ore da compensare con le Ore in pagamento' + IfThen(W024DM.GestioneCausale,' e con le Ore causalizzate') + ' deve essere uguale al numero di ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + '!');
    Exit;
  end;
  Result:=True;
end;

procedure TW024FRichiestaStraordinari.actModRichiesta(FN:String);
var i,LIv,LivelloAutorizzazione:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  with W024DM.selT065 do
  begin
    LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
    C018.Id:=FieldByName('ID').AsInteger;
    C018.CodIter:=FieldByName('COD_ITER').AsString;
    if WR000DM.Responsabile then
    begin
      C018.SetDatoAutorizzatore('ORE_ECCEDENTI',(grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text,LivelloAutorizzazione);
      C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',(grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit).Text,LivelloAutorizzazione);
      C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',(grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit).Text,LivelloAutorizzazione);
      if W024DM.GestioneCausale then
      begin
        C018.SetDatoAutorizzatore('CAUSALE',Copy((grdRichieste.medpCompCella(i,ColCaus,0) as TmeIWComboBox).Text,1,5),LivelloAutorizzazione);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit).Text,LivelloAutorizzazione);
      end;
      if C018.FaseLivello[LivelloAutorizzazione] = 1 then
      begin
        C018.SetTipoRichiesta('V');
        C018.InsAutorizzazione(LivelloAutorizzazione,C018SI,Parametri.Operatore,'','');
      end
      else
      begin
        C018.SetTipoRichiesta('I');
        C018.InsAutorizzazione(LivelloAutorizzazione,'',Parametri.Operatore,'','');
      end;
    end
    else
    begin
      RefreshRecord;
      Edit;
      FieldByName('ORE_ECCEDENTI').AsString:=(grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text;
      FieldByName('ORE_DACOMPENSARE').AsString:=(grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit).Text;
      FieldByName('ORE_DALIQUIDARE').AsString:=(grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit).Text;
      if W024DM.GestioneCausale then
      begin
        FieldByName('CAUSALE').AsString:=Copy((grdRichieste.medpCompCella(i,ColCaus,0) as TmeIWComboBox).Text,1,5);
        FieldByName('ORE_CAUSALIZZATE').AsString:=(grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit).Text;
      end;
      Post;
      C018.SetTipoRichiesta('A');
      C018.SetDataRichiesta;
      //Liv:=C018.VerificaRichiestaEsistente(FieldByName('AUTORIZZ_AUTOMATICA').AsString);
      Liv:=C018.VerificaRichiestaEsistente('');
      if Liv = C018.LivMaxObb then
      begin
        C018.SetTipoRichiesta('S');
        //Alberto 17/10/2012: in caso di autorizzazione automatica registro i dati richiesti sulla T852
        C018.SetDatoAutorizzatore('ORE_ECCEDENTI',(grdRichieste.medpCompCella(i,ColOreEcc,0) as TmeIWEdit).Text,Liv);
        C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',(grdRichieste.medpCompCella(i,ColOreComp,0) as TmeIWEdit).Text,Liv);
        C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',(grdRichieste.medpCompCella(i,ColOreLiq,0) as TmeIWEdit).Text,Liv);
        if W024DM.GestioneCausale then
        begin
          C018.SetDatoAutorizzatore('CAUSALE',Copy((grdRichieste.medpCompCella(i,ColCaus,0) as TmeIWComboBox).Text,1,5),Liv);
          C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,ColOreCaus,0) as TmeIWEdit).Text,Liv);
        end;
        AggiornamentoLimitiScheda(True);
      end;
    end;
    try
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage('Inserimento fallito: ' + E.Message);
        Cancel;
      end;
    end;
  end;
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga modificata
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',FN,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW024FRichiestaStraordinari.W024AutorizzaTutti(Sender: TObject; var Ok: Boolean); //***TW024FRichiestaStraordinari.btnTuttiSiClick(Sender: TObject);
// Effettua l'autorizzazione positiva di tutte le richieste ancora da autorizzare visibili a video.
var
  Aut,ErrModCan,RichOltreLimiti,RichAZero,RichDaValid: Boolean;
  Messaggio:String;
  LivelloAutorizzazione:Integer;
  function FormattaDatiRichiesta: String;
  begin
    with W024DM.selT065 do
    begin
      // formatta la richiesta
      Result:=Format('Richiesta effettuata da %s (%s) il %s',
                     [FieldByName('NOMINATIVO').AsString,
                      FieldByName('MATRICOLA').AsString,
                      FieldByName('DATA_RICHIESTA').AsString]) + CRLF +
              'Data: ' + FormatDateTime('mm/yyyy',FieldByName('DATA').AsDateTime) + CRLF +
              'Tipo: ' + FieldByName('Desc_Tipo').AsString;
    end;
  end;
begin
  if Operazione = 'M' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  Aut:=Sender = btnTuttiSi;
  // inizializzazione variabili
  ErrModCan:=False;
  RichOltreLimiti:=False;
  RichAZero:=False;
  RichDaValid:=False;
  // autorizzazione richieste
  with W024DM.selT065 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID').AsInteger;
        try
          if Aut and
             (W024DM.TipoRichStr <> '1') and
             (   ((R180OreMinutiExt(FieldByName('CF_ORE_COMP_AUTORIZ').AsString) > 0) and
                  (R180OreMinutiExt(FieldByName('CF_RES_ORE_COMP_ANNO').AsString) < 0))
              or ((R180OreMinutiExt(FieldByName('CF_ORE_LIQ_AUTORIZ').AsString) > 0) and
                  (R180OreMinutiExt(FieldByName('CF_RES_ORE_LIQ_ANNO').AsString) < 0))) then
            RichOltreLimiti:=True
          else if (FieldByName('D_TIPO_RICHIESTA').AsString = 'A')
          and C018.EsisteFase[T065FASE_VALIDAZIONE] then
            RichDaValid:=True
          else if (not Aut)
               or (R180OreMinutiExt(FieldByName('CF_ORE_ECCED_AUTORIZ').AsString) <> 0)
               or (R180OreMinutiExt(FieldByName('ORE_ECCEDENTI').AsString) = 0) then
          begin
            try
              C018.SetDatoAutorizzatore('ORE_ECCEDENTI',FieldByName('CF_ORE_ECCED_AUTORIZ').AsString,LivelloAutorizzazione);
              C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',FieldByName('CF_ORE_COMP_AUTORIZ').AsString,LivelloAutorizzazione);
              C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',FieldByName('CF_ORE_LIQ_AUTORIZ').AsString,LivelloAutorizzazione);
              if W024DM.GestioneCausale then
              begin
                C018.SetDatoAutorizzatore('CAUSALE',FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivelloAutorizzazione);
                C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivelloAutorizzazione);
              end;
              C018.SetTipoRichiesta(IfThen(Aut,'S','N'));
              C018.InsAutorizzazione(LivelloAutorizzazione,IfThen(Aut,C018SI,C018NO),Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);

              RefreshOptions:=[roAllFields];
              RefreshRecord;
              RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
              AggiornamentoLimitiScheda(Aut);
              SessioneOracle.Commit;
            except
              on E: Exception do
              begin
                // messaggio bloccante
                MsgBox.MessageBox('Impostazione dell''autorizzazione fallita!' + CRLF +
                                  'Motivo: ' + E.Message + CRLF + CRLF +
                                  FormattaDatiRichiesta,ESCLAMA);
                W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga in meno
                VisualizzaDipendenteCorrente;
                Exit;
              end;
            end;
          end
          else
            RichAZero:=True;
        except
          // errore probabilmente dovuto a record modificato / cancellato da altro utente
          on E:Exception do
          begin
            ErrModCan:=True;
          end;
        end;
      finally
        Next;
      end;
    end;
  end;
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per righe autorizzate
  VisualizzaDipendenteCorrente;
  if ErrModCan then
    Messaggio:='Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.';
  if RichOltreLimiti then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto è stato superato il limite annuale.';
  if RichAZero then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto sarebbero state autorizzate 0 ore. Autorizzare tali richieste singolarmente!';
  if RichDaValid then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto le ore richieste non sono state validate. Autorizzare tali richieste singolarmente!';
  if Messaggio <> '' then
    GGetWebApplicationThreadVar.ShowMessage(Messaggio);
end;

//*** inizio
{
procedure TW024FRichiestaStraordinari.btnFiltraClick(Sender: TObject);
begin
  inherited;
  if Operazione = 'M' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  if not ImpostaPeriodo then
    Abort;
  ResetOffsetGrid:=True;
  PeriodoManuale:=True;
  VisualizzaDipendenteCorrente;
  PeriodoManuale:=False;
  ResetOffsetGrid:=False;
end;
}
//*** fine

procedure TW024FRichiestaStraordinari.btnInserisciClick(Sender: TObject);
begin
  with W024DM.selaT065 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
    Open;
    Last;
  end;
  with W024DM.selT065 do
  begin
    Append;
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DATA').AsDateTime:=R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro));
    FieldByName('ID_CONGUAGLIO').AsInteger:=W024DM.selaT065.FieldByName('ID_CONGUAGLIO').AsInteger + 1;
    FieldByName('TIPO').AsString:='G';
    FieldByName('ORE_ECCED_CALC').AsString:=R180MinutiOre(R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCED_CALC').AsString) - IfThen(W024DM.selaT065.FieldByName('STATO').AsString = 'S',R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCEDENTI').AsString),0));
    FieldByName('ORE_ECCEDENTI').AsString:=FieldByName('ORE_ECCED_CALC').AsString;
  end;
  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW024FRichiestaStraordinari.ConfermaInsRichiesta;
var IdIns:String;
    i:Integer;
    Trovato:Boolean;
begin
  with W024DM.selT065 do
  begin
    try
      C018.InsRichiesta('R','','');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      IdIns:=RowId;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della richiesta fallito!' + CRLF + 'Motivo: ' + E.Message);
        Exit;
      end;
    end;
  end;

  //*** inizio
  {
  //corregge filtri visualizzazione al fine di includere la richiesta appena inserita
  chkVisRichiedibili.Checked:=True;

  if W024DM.selT065.FieldByName('DATA').AsDateTime < PeriodoDal then
  begin
    PeriodoDal:=W024DM.selT065.FieldByName('DATA').AsDateTime;
    PeriodoManuale:=True;
  end;
  if W024DM.selT065.FieldByName('DATA').AsDateTime > PeriodoAl then
  begin
    PeriodoAl:=W024DM.selT065.FieldByName('DATA').AsDateTime;
    PeriodoManuale:=True;
  end;
  }
  C018.Periodo.Estendi(W024DM.selT065.FieldByName('DATA').AsDateTime,W024DM.selT065.FieldByName('DATA').AsDateTime);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
  //***..includi richiedibili
  //*** fine

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
  //***PeriodoManuale:=False;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);

  //lancio l'evento di modifica del nuovo record
  Trovato:=False;
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[0] is TmeIWGrid then
    begin
      if (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control is TmeIWImageFile then
      begin
        if ((grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control as TmeIWImageFile).FriendlyName = IdIns then
        begin
          Trovato:=True;
          Break;
        end;
      end;
    end;
  end;
  if Trovato then
    imgModificaClick(((grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control as TmeIWImageFile));
end;

procedure TW024FRichiestaStraordinari.AnnullaInsRichiesta;
begin
  W024DM.selT065.Cancel;
  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.chkAutorizzazioneClick(Sender: TObject);
var i:Integer;
begin
  if Operazione = 'M' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWCheckBox).FriendlyName);
  if (W024DM.TipoRichStr <> '1') and
     ((Sender as TmeIWCheckBox).Caption = 'Si') and
     (   ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_COMP_ANNO')) < 0))
      or ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_LIQ_ANNO')) < 0))) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile autorizzare la richiesta perché è stato superato il limite annuale!');
    Exit;
  end;
  (Sender as TmeIWCheckBox).Checked:=True;
  AutorizzazioneOK((Sender as TmeIWCheckBox).FriendlyName,(W024DM.TipoRichStr = '1') or ((Sender as TmeIWCheckBox).Caption = 'Si'));
end;

procedure TW024FRichiestaStraordinari.AutorizzazioneOK(RowidT065:String;Aut:Boolean);
var LivelloAutorizzazione:Integer;
begin
  with W024DM.selT065 do
  begin
    // verifica presenza record
    //Refresh; //11/08/2011 Danilo: Remmato per problemi con RichiestaAZero perché lo stato cambia in actModRichiesta
    if not SearchRecord('ROWID',RowidT065,[srFromBeginning]) then
    begin
      W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga in meno
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('Attenzione! La richiesta da autorizzare non è più disponibile!');
      Exit;
    end;
    // salva i dati di autorizzazione
    try
      LivelloAutorizzazione:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.SetDatoAutorizzatore('ORE_ECCEDENTI',FieldByName('CF_ORE_ECCED_AUTORIZ').AsString,LivelloAutorizzazione);
      C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',FieldByName('CF_ORE_COMP_AUTORIZ').AsString,LivelloAutorizzazione);
      C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',FieldByName('CF_ORE_LIQ_AUTORIZ').AsString,LivelloAutorizzazione);
      if W024DM.GestioneCausale then
      begin
        C018.SetDatoAutorizzatore('CAUSALE',FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivelloAutorizzazione);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivelloAutorizzazione);
      end;
      C018.SetTipoRichiesta(IfThen(Aut,'S','N'));
      C018.InsAutorizzazione(LivelloAutorizzazione,IfThen(Aut,C018SI,C018NO),Parametri.Operatore,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);

      RefreshOptions:=[roAllFields];
      RefreshRecord;
      RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      AggiornamentoLimitiScheda(Aut);
      SessioneOracle.Commit;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
    end;
    W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> '1');//Aggiornare totali per riga autorizzata
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW024FRichiestaStraordinari.AggiornamentoLimitiScheda(Aut:Boolean);
var OreComp,OreLiq,OreEcc,OreOld:String;
begin
  { TODO : TEST IW 15 }
  with W024DM do
  begin
    if TipoRichStr = '1' then
    begin
      //Aggiorno Banca ore liquidata
      selT070.Close;
      selT070.SetVariable('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
      selT070.SetVariable('DATA',selT065.FieldByName('DATA').AsDateTime);
      selT070.Open;
      if not selT070.Eof then
      begin
        OreOld:=selT070.FieldByName('ORECOMP_LIQUIDATE').AsString;
        selT070.Edit;
        selT070.FieldByName('ORECOMP_LIQUIDATE').AsString:=R180MinutiOre(R180OreMinutiExt(selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString) + IfThen(selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(selT070.FieldByName('ORECOMP_LIQUIDATE').AsString)));
        if selT065.FieldByName('TIPO').AsString = 'C' then
          selT070.FieldByName('BANCAORE_LIQ_VAR').AsString:='00.00';
        RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',medpCodiceForm,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsString,'');
        RegistraLog.InserisciDato('DATA',selT065.FieldByName('DATA').AsString,'');
        RegistraLog.InserisciDato('ORECOMP_LIQUIDATE',OreOld,selT070.FieldByName('ORECOMP_LIQUIDATE').AsString);
        if selT065.FieldByName('TIPO').AsString = 'C' then
          RegistraLog.InserisciDato('BANCAORE_LIQ_VAR',selT070.FieldByName('BANCAORE_LIQ_VAR').medpOldValue,selT070.FieldByName('BANCAORE_LIQ_VAR').AsString);
        selT070.Post;
        RegistraLog.RegistraOperazione;
      end;
      selT070.Close;
    end;
    //Aggiorno Limiti mensili
    if WR000DM.Responsabile then
    begin
      OreComp:=selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString;
      OreLiq:=selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString;
      OreEcc:=selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString;
    end
    else //Dati inseriti in fase di richiesta, per gestire l'autorizzazione automatica con l'aggiornamento della scheda con i dati richiesti
    begin
      OreComp:=selT065.FieldByName('ORE_DACOMPENSARE').AsString;
      OreLiq:=selT065.FieldByName('ORE_DALIQUIDARE').AsString;
      OreEcc:=selT065.FieldByName('ORE_ECCEDENTI').AsString;
    end;
    //Per TORINO_CSI_PRV non si setta il limite sulla banca ore
    if TipoRichStr <> '4' then
    begin
      selT820.Close;
      selT820.SetVariable('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
      selT820.SetVariable('DATA',selT065.FieldByName('DATA').AsDateTime);
      selT820.SetVariable('CAUSALE','* B');
      selT820.Open;
      if not selT820.Eof then
      begin
        selT820.Edit;
        selT820.FieldByName('LIQUIDABILE').AsString:='N';
        selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(TipoRichStr = '1',OreEcc,IfThen(Aut,OreComp,'00.00'))) + IfThen(selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(selT820.FieldByName('ORE').AsString)));
        RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end
      else
      begin
        selT820.Insert;
        selT820.FieldByName('PROGRESSIVO').AsInteger:=selT065.FieldByName('PROGRESSIVO').AsInteger;
        selT820.FieldByName('ANNO').AsInteger:=R180Anno(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('MESE').AsInteger:=R180Mese(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('DAL').AsInteger:=1;
        selT820.FieldByName('AL').AsInteger:=31;
        selT820.FieldByName('CAUSALE').AsString:='* B';
        selT820.FieldByName('LIQUIDABILE').AsString:='N';
        selT820.FieldByName('ORE_TEORICHE').AsString:='';
        selT820.FieldByName('ORE').AsString:=IfThen(TipoRichStr = '1',OreEcc,IfThen(Aut,OreComp,'00.00'));
        RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end;
    end;
    //Per TORINO_CSI_PRV non si setta il limite sul liquidabile
    if (TipoRichStr <> '1') and (TipoRichStr <> '4') then
    begin
      selT820.Close;
      selT820.SetVariable('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
      selT820.SetVariable('DATA',selT065.FieldByName('DATA').AsDateTime);
      selT820.SetVariable('CAUSALE','* L');
      selT820.Open;
      if not selT820.Eof then
      begin
        selT820.Edit;
        selT820.FieldByName('LIQUIDABILE').AsString:='S';
        selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(Aut,OreLiq,'00.00')) + IfThen(selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(selT820.FieldByName('ORE').AsString)));
        RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end
      else
      begin
        selT820.Insert;
        selT820.FieldByName('PROGRESSIVO').AsInteger:=selT065.FieldByName('PROGRESSIVO').AsInteger;
        selT820.FieldByName('ANNO').AsInteger:=R180Anno(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('MESE').AsInteger:=R180Mese(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('DAL').AsInteger:=1;
        selT820.FieldByName('AL').AsInteger:=31;
        selT820.FieldByName('CAUSALE').AsString:='* L';
        selT820.FieldByName('LIQUIDABILE').AsString:='S';
        selT820.FieldByName('ORE_TEORICHE').AsString:='';
        selT820.FieldByName('ORE').AsString:=IfThen(Aut,OreLiq,'00.00');
        RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end;
    end;
    if (TipoRichStr = '3')
    and not selT065.FieldByName('CF_CAUSALE_AUTORIZ').IsNull then
    begin
      selT820.Close;
      selT820.SetVariable('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
      selT820.SetVariable('DATA',selT065.FieldByName('DATA').AsDateTime);
      selT820.SetVariable('CAUSALE',selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString);
      selT820.Open;
      if not selT820.Eof then
      begin
        selT820.Edit;
        selT820.FieldByName('LIQUIDABILE').AsString:='S';
        selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(Aut,selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,'00.00')) + IfThen(selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(selT820.FieldByName('ORE').AsString)));
        RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end
      else
      begin
        selT820.Insert;
        selT820.FieldByName('PROGRESSIVO').AsInteger:=selT065.FieldByName('PROGRESSIVO').AsInteger;
        selT820.FieldByName('ANNO').AsInteger:=R180Anno(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('MESE').AsInteger:=R180Mese(selT065.FieldByName('DATA').AsDateTime);
        selT820.FieldByName('DAL').AsInteger:=1;
        selT820.FieldByName('AL').AsInteger:=31;
        selT820.FieldByName('CAUSALE').AsString:=selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString;
        selT820.FieldByName('LIQUIDABILE').AsString:='S';
        selT820.FieldByName('ORE_TEORICHE').AsString:='';
        selT820.FieldByName('ORE').AsString:=IfThen(Aut,selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,'00.00');
        RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,selT820,True);
        selT820.Post;
        RegistraLog.RegistraOperazione;
      end;
    end;
    selT820.Close;
    //alla fine si esegue la procedura personalizzabile T065P_GESTIONESTRAORDINARIO
    with T065P_GESTIONESTRAORDINARIO do
    begin
      SetVariable('PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',selT065.FieldByName('DATA').AsDateTime);
      Execute;
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 427;
  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.DistruggiOggetti;
begin
  FreeAndNil(W024DM);
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT275);
  end;

  inherited;
end;

procedure TW024FRichiestaStraordinari.ImpostaGrigliaRiepilogo;
begin
  grdRiepilogo.ColumnCount:=3;
  grdRiepilogo.RowCount:=2;
  grdRiepilogo.Cell[0,0].Css:='';
  grdRiepilogo.Cell[0,0].RawText:=True;
  grdRiepilogo.Cell[0,0].Text:='Anno';
  grdRiepilogo.Cell[0,1].Css:='';
  grdRiepilogo.Cell[0,1].RawText:=True;
  grdRiepilogo.Cell[0,1].Text:='Totale ore compensabili' +
                               '<div align="center" class="width100pc">' +
                               '<span>Limite</span>' +
                               '<span>Fruito</span>' +
                               '<span>In attesa</span>' +
                               '<span>Residuo</span>' +
                               '</div>';
  grdRiepilogo.Cell[0,2].Css:='';
  grdRiepilogo.Cell[0,2].RawText:=True;
  grdRiepilogo.Cell[0,2].Text:='Totale ore liquidabili' +
                               '<div align="center" class="width100pc">' +
                               '<span>Limite</span>' +
                               '<span>Fruito</span>' +
                               '<span>In attesa</span>' +
                               '<span>Residuo</span>' +
                               '</div>';
  grdRiepilogo.Cell[1,0].Css:='';
  grdRiepilogo.Cell[1,0].RawText:=True;
  grdRiepilogo.Cell[1,0].Text:=IntToStr(R180Anno(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
  grdRiepilogo.Cell[1,1].Css:='';
  grdRiepilogo.Cell[1,1].RawText:=True;
  grdRiepilogo.Cell[1,1].Text:='<div align="center" class="width100pc">' +
                               '<span>' + R180MinutiOre(MinTotAnnuoComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotAutComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotInAttAutComp) + '</span>' +
                               '<span' + IfThen(MinResiduiComp < 0,' class="riga_evidenziata"') + '>' + R180MinutiOre(MinResiduiComp) + '</span>' +
                               '</div>';
  grdRiepilogo.Cell[1,2].Css:='';
  grdRiepilogo.Cell[1,2].RawText:=True;
  grdRiepilogo.Cell[1,2].Text:='<div align="center" class="width100pc">' +
                               '<span>' + R180MinutiOre(MinTotAnnuoLiq) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotAutLiq) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotInAttAutLiq) + '</span>' +
                               '<span' + IfThen(MinResiduiLiq < 0,' class="riga_evidenziata"') + '>' + R180MinutiOre(MinResiduiLiq) + '</span>' +
                               '</div>';
end;

end.
