unit W018URichiestaTimbrature;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  A023UTimbratureMW, A023UAllTimbMW, R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  W018URiepilogoEccedenzeFM, W005UCartellinoFM, W018URichiestaTimbratureDM,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWApplication, IWAppForm, SysUtils, Classes, Graphics, Controls, Math, StrUtils,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  OracleData, IWCompCheckbox, DatiBloccati, IWDBGrids, Variants,
  IWVCLBaseControl, meIWCheckBox, Forms, IWVCLBaseContainer, IWContainer,
  meIWGrid, DB, IWCompMemo, Oracle, ActnList, meIWMemo, DBClient,
  meTIWAdvRadioGroup, medpIWDBGrid, medpIWMessageDlg, meIWImageFile, meIWButton,
  meIWEdit, meIWLabel, meIWComboBox, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWCompButton, Menus, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, IWBaseControl, IWBaseHTMLControl;

type
  TMotivazioni = record
    Codice: String;
    Descrizione: String;
  end;

  TCausali = record
    Codice: String;
    Descrizione: String;
    Text: String;
  end;

  TRecordRichiesta = record
    Data: TDateTime;
    Ora: String;
    Verso: String;
    Causale: String;
    Operazione: String;
    DataRichiesta: TDateTime;
    Motivazione: String;
    Rilevatore: String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
    Operazione:String;
  end;

  TW018FRichiestaTimbrature = class(TR013FIterBase)
    dsrT105: TDataSource;
    cdsT105: TClientDataSet;
    grdTimbrature: TmedpIWDBGrid;
    dsrT100: TDataSource;
    cdsT100: TClientDataSet;
    btnVisualizza: TmeIWButton;
    edtDataFiltro: TmeIWEdit;
    lblDataFiltro: TmeIWLabel;
    btnRiepilogoOre: TmeIWButton;
    btnImporta: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnRiepilogoOreClick(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTimbratureAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtDataFiltroSubmit(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure grdTimbratureRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    Data: TDateTime;
    ArrMotivazioni: array of TMotivazioni;
    MotivazioneDefault: Integer;
    ArrCausali: array of TCausali;
    ArrRilevatori: array of TCausali;
    AbilIns,AbilCanc: Boolean;
    Autorizza: TAutorizza;
    Richiesta: TRecordRichiesta;
    StileCella1,StileCella2: String;
    MemoText:String;
    W018DM: TW018FRichiestaTimbratureDM;
    W018FRiepilogoOreFM: TW018FRiepilogoEccedenzeFM;
    W005FCartellinoFM: TW005FCartellinoFM;
    AutorizzazioniDaConfermare: Boolean;
    // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
    A023MW: TA023FTimbratureMW;
    // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine
    procedure grdRichiesteColumnClick(ASender: TObject; const AValue: string);
    procedure grdTimbratureColumnClick(ASender: TObject; const AValue: string);
    procedure AutorizzazioneOK;
    function  ArrIndexFromCodice(const Tipo: String; const Codice: String): Integer;
    function  _ArrCausaliGetIndex(const Codice: String; p,r:Integer): Integer;
    function  _ArrMotivazioniGetIndex(const Codice: String; p,r:Integer): Integer;
    function  _ArrRilevatoriGetIndex(const Codice: String; p,r:Integer): Integer;
    procedure GetDatiTabellari;
    procedure imgModificaCausClick(Sender: TObject);
    procedure imgAnnullaCausClick(Sender: TObject);
    procedure imgConfermaCausClick(Sender: TObject);
    procedure imgCancellaRichiestaClick(Sender: TObject);
    procedure TrasformaCompCausale(const FN:String);
    procedure GetCausaliPresenza(Items:TStringList);
    procedure GetModificaTimbrature;
    procedure AllineaTimbrature;
    procedure imgCancellaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgDettaglioGGClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String; DaTestoAControlli:Boolean);
    function  ModificheRiga(FN:String): Boolean;
    function  ControlliOK(FN:String): Boolean;
    procedure actInsTimbraturaOK;
    procedure actVarTimbraturaOK;
    procedure actCanTimbraturaOK;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure SetAutorizzazione(Sender: TObject);
    procedure W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    function DecodificaFunzioneRilevatore(const PFunzione: String): String;
  protected
    procedure RefreshPage; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.DFM}

function TW018FRichiestaTimbrature.InizializzaAccesso:Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=True;
  Data:=ParametriForm.Al;
  GetDipendentiDisponibili(Data);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;

    // reimposta i filtri per questo iter su C018
    // in caso di acquisizione automatica assenze su IrisWin modifica i filtri
    if Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S' then
    begin
      // richieste da autorizzare considerano anche quelle autorizzate ma non ancora elaborate
      C018.FiltroRichiesta[trDaAutorizzare]:=Format('(%s) or (T_ITER.ELABORATO = ''N'')',[C018.FiltroRichiesta[trDaAutorizzare]]);
      // richieste autorizzate / negate considerano solo quelle già elaborate
      C018.FiltroRichiesta[trAutorizzate]:=Format('(%s) and (T_ITER.ELABORATO <> ''N'')',[C018.FiltroRichiesta[trAutorizzate]]);
      C018.FiltroRichiesta[trNegate]:=Format('(%s) and (T_ITER.ELABORATO <> ''N'')',[C018.FiltroRichiesta[trNegate]]);
    end;
  end
  else
  begin
    // se data filtro è specificata -> funzione chiamata dal cartellino
    if ParametriForm.DataFiltro = 0 then
      ParametriForm.DataFiltro:=Date - 1;
    edtDataFiltro.Text:=DateToStr(ParametriForm.DataFiltro);
  end;

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W018AutorizzaTutto;
  end;

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.IWAppFormCreate(Sender: TObject);
const
  FUNZIONE = 'IWAppFormCreate';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Tag:=IfThen(WR000DM.Responsabile,419,418);
  inherited;
  W018DM:=TW018FRichiestaTimbratureDM.Create(Self);
  Iter:=ITER_TIMBR;

  W018DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W018DM.selT105,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W018DM.selT105,tiRichiesta);

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W018P1','W018P0');
  Data:=Parametri.DataLavoro;
  WR000DM.selT275.Filtered:=True; //Filtro Dizionario
  WR000DM.selT275.Open;
  WR000DM.selT275.Tag:=WR000DM.selT275.Tag + 1;
  // legge i dati tabellari in array di supporto
  GetDatiTabellari;
  edtDataFiltro.Text:=DateToStr(Date - 1);
  // abilitazioni elementi
  AbilIns:=(not SolaLettura) and
           (not WR000DM.Responsabile) and
           (Parametri.InserisciTimbrature = 'S');
  AbilCanc:=(not SolaLettura) and
            ((Parametri.CancellaTimbrature = 'S') or (Parametri.T100_CancTimbOrig = 'S'));

  // timbrature da modificare: solo per il dipendente
  btnVisualizza.Visible:=not WR000DM.Responsabile;
  edtDataFiltro.Visible:=not WR000DM.Responsabile;
  lblDataFiltro.Visible:=not WR000DM.Responsabile;

  // tabella delle timbrature
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdTimbrature.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdTimbrature.medpDataSet:=W018DM.selT100ModifTimb;
  grdTimbrature.medpTestoNoRecord:='Nessuna timbratura';

  // tabella delle richieste
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W018DM.selT105;
  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
  // datamodule per acquisizione timbrature web
  AutorizzazioniDaConfermare:=False;
  if Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S' then
  begin
    A023MW:=TA023FTimbratureMW.Create(Self);
  end;
  // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.RefreshPage;
const
  FUNZIONE = 'RefreshPage';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  WR000DM.Responsabile:=Tag = 419;
  if not AutorizzazioniDaConfermare then
    VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.IWAppFormRender(Sender: TObject);
const
  FUNZIONE = 'IWAppFormRender';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;

  // autorizza / nega tutto
  if medpAutorizzaMultiplo then
  begin
    if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W018DM.selT105.RecordCount > 0) and (Autorizza.Operazione = '');
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  // acquisizione timbrature
  // abilitata solo per le richieste da autorizzare se il corrispondente parametro aziendale è attivo
  btnImporta.Visible:=(Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
                      (WR000DM.Responsabile) and // bugfix - SGIULIANOMILANESE_COMUNE - chiamata <76351>
                      (W018DM.selT105.RecordCount > 0) and
                      (C018.TipoRichiesteSel = [trDaAutorizzare]);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna,idx:Integer;
  Campo: String;
//const
//  FUNZIONE = 'grdRichiesteRenderCell';
begin
  //Log('Traccia',FUNZIONE + ': inizio');
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  Campo:=grdRichieste.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) then
  begin
    if Campo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center';
      if grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZAZIONE') = 'N' then
        ACell.Css:=ACell.Css + ' font_rosso';
    end
    else if Campo = 'D_ELABORATO' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'ELABORATO') = 'E',' font_rosso')
    end;
  end;

  // gestione degli Hint
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (ACell.Text <> '') then
  begin
    if Campo = 'CAUSALE_UTILE' then
    begin
      idx:=ArrIndexFromCodice('C',grdRichieste.medpValoreColonna(ARow - 1,'CAUSALE_UTILE'));
      if idx >= 0 then
        ACell.Hint:=ArrCausali[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end
    else if Campo = 'CAUSALE_ORIG' then
    begin
      idx:=ArrIndexFromCodice('C',grdRichieste.medpValoreColonna(ARow - 1,'CAUSALE_ORIG'));
      if idx >= 0 then
        ACell.Hint:=ArrCausali[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end
    else if (Campo = 'RILEVATORE_RICH') or
            (Campo = 'RILEVATORE_ORIG') then // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    begin
      idx:=ArrIndexFromCodice('R',grdRichieste.medpValoreColonna(ARow - 1,Campo));
      if idx >= 0 then
        ACell.Hint:=ArrRilevatori[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end;
    // MONDOEDP - commessa: MAN/07 SVILUPPO#54.ini
    // gestione colonna descrizione motivazione in tabella
    {
    else if Campo = 'MOTIVAZIONE' then
    begin
      idx:=ArrIndexFromCodice('M',grdRichieste.medpValoreColonna(ARow - 1,'MOTIVAZIONE'));
      if idx >= 0 then
        ACell.Hint:=ArrMotivazioni[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end;
    }
    // MONDOEDP - commessa: MAN/07 SVILUPPO#54.fine
  end;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
  //Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,x,LivAut,LivCaus: Integer;
  HintDesc,Op,CausUtile: String;
  DatiModificabili:Boolean;
  IWImg: TmeIWImageFile;
const
  FUNZIONE = 'grdRichiesteAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  //Righe dati
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    with (grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      if C018.SetIconaAllegati(IWImg) then
        IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if (not SolaLettura) and (C018.TipoRichiesteSel <> [trAutorizzAuto]) then
    begin
      if WR000DM.Responsabile then
      begin
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          if (grdRichieste.medpValoreColonna(i,'ELABORATO') = 'N') and
             (grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
             (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
             (StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0) > 0) then
          begin
            // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
            if Parametri.CampiRiferimento.C90_W018AcquisizioneAuto <> 'S' then
            begin
              // v1: onclick
              C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);
              // v1.fine
            end
            else
            begin
              // v2.ini
              // versione con onasyncclick (non aggiorna la dbgrid dopo l'operazione di autorizzazione)
              C018.SetValoriAut(grdRichieste,i,0,0,1,nil);
              with (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox) do
              begin
                Name:=Format(ROW_ELEM_NAME_FMT,[CHKSI_NAME,i]);
                OnAsyncClick:=chkAutorizzazioneAsyncClick;
              end;
              if grdRichieste.medpCompCella(i,0,1) <> nil then
              begin
                with (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox) do
                begin
                  Name:=Format(ROW_ELEM_NAME_FMT,[CHKNO_NAME,i]);
                  OnAsyncClick:=chkAutorizzazioneAsyncClick;
                end;
              end;
              // v2.fine
            end;
            // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine
          end
          else
          begin
            //Elimino checkbox se autorizzazione automatica o non abilitato ad autorizzare
            FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
          end;
        end;
        //Gestione pulsante di modifica causale
        x:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        LivCaus:=StrToIntDef(grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE_LIV'),0);
        LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1);
        C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
        DatiModificabili:=C018.ModificaValori(LivAut) and (LivAut >= LivCaus);
        if grdRichieste.medpColonna('DBG_COMANDI').Visible then
        begin
          Op:=grdRichieste.medpValoreColonna(i,'OPERAZIONE');
          CausUtile:=grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE');
          if not ( DatiModificabili and
                  (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') = '') and
                  (((Op = 'I') and ((CausUtile <> '') or C018.GetDatoAutorizzatore('CAUSALE',IntToStr(LivAut)).Esiste)) or
                   ((Op = 'M') and ((CausUtile <> grdRichieste.medpValoreColonna(i,'CAUSALE_ORIG')) or C018.GetDatoAutorizzatore('CAUSALE',IntToStr(LivAut)).Esiste)))
                  ) then
          begin
            //Elimino il pulsante di modifica causale
            FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[x]);
          end
          else
          begin
            if StileCella1 = '' then
            begin
              with (grdRichieste.medpCompGriglia[i].CompColonne[x] as TmeIWGrid) do
              begin
                StileCella1:=Cell[0,0].Css;
                StileCella2:=Cell[0,2].Css;
              end;
            end;
            //Associo l'evento onclick al pulsante di modifica causale
            with (grdRichieste.medpCompCella(i,x,0) as TmeIWImageFile) do
            begin
              Hint:=IfThen(grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE') = '','Imposta causale','Modifica causale');
              OnClick:=imgModificaCausClick;
            end;
            //Associo l'evento onclick al pulsante di annullamento modifica causale
            (grdRichieste.medpCompCella(i,x,1) as TmeIWImageFile).OnClick:=imgAnnullaCausClick;
            //Associo l'evento onclick al pulsante di conferma modifica causale
            (grdRichieste.medpCompCella(i,x,2) as TmeIWImageFile).OnClick:=imgConfermaCausClick;
            with (grdRichieste.medpCompGriglia[i].CompColonne[x] as TmeIWGrid) do
            begin
              Cell[0,1].Css:='invisibile';
              Cell[0,2].Css:='invisibile';
            end;
          end;
        end;
        //Gestione pulsante di dettaglio giornaliero
        x:=grdRichieste.medpIndexColonna('DETTAGLIO_GG');
        (grdRichieste.medpCompCella(i,x,0) as TmeIWImageFile).OnClick:=imgDettaglioGGClick;
      end
      else
      begin
        // visualizza immagine per cancellazione richiesta solo se non ancora autorizzata
        if (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) and (grdRichieste.medpValoreColonna(i,'REVOCABILE') <> 'CANC') then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaRichiestaClick;
          HintDesc:=' del ' + grdRichieste.medpValoreColonna(i,'DATA_RICHIESTA') +
                    ' per l''' + IfThen(grdRichieste.medpValoreColonna(i,'VERSO')='E','entrata','uscita') +
                    ' del giorno ' + grdRichieste.medpValoreColonna(i,'DATA') +
                    ' alle ore ' + grdRichieste.medpValoreColonna(i,'ORA') +
                    ' con causale ' + grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE');
          (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).Hint:=(grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).Hint + HintDesc;
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdRichiesteColumnClick(ASender: TObject; const AValue: string);
const
  FUNZIONE = 'grdRichiesteColumnClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  cdsT105.Locate('DBG_ROWID',AValue,[]);

  // nominativo
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT105.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
  HintDesc,Flag:String;
const
  FUNZIONE = 'grdTimbratureAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  if (not SolaLettura) then
  begin
    //Riga di inserimento
    if grdTimbrature.medpRigaInserimento then
    begin
      if StileCella1 = '' then
      begin
        with (grdTimbrature.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
        begin
          StileCella1:=Cell[0,0].Css;
          StileCella2:=Cell[0,2].Css;
        end;
      end;
      HintDesc:=' per il ' + edtDataFiltro.Text;
      with (grdTimbrature.medpCompCella(0,0,0) as TmeIWImageFile) do
      begin
        OnClick:=imgInserisciClick; //Inserimento
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompCella(0,0,1) as TmeIWImageFile) do
      begin
        OnClick:=imgAnnullaClick;   //Annulla
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompCella(0,0,2) as TmeIWImageFile) do
      begin
        OnClick:=imgConfermaClick;  //Conferma
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;
    //Righe dati
    for i:=IfThen(grdTimbrature.medpRigaInserimento,1,0) to High(grdTimbrature.medpCompGriglia) do
    begin
      if grdTimbrature.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        HintDesc:=' di ' + grdTimbrature.medpValoreColonna(i,'DESC_VERSO') +
                  ' alle ' + grdTimbrature.medpValoreColonna(i,'ORA') +
                  ' del ' + edtDataFiltro.Text;

        // Associo l'evento OnClick alle Icone
        with (grdTimbrature.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          OnClick:=imgCancellaClick; //Cancella
          Hint:=Hint + HintDesc;
        end;
        with (grdTimbrature.medpCompCella(i,0,1) as TmeIWImageFile) do
        begin
          OnClick:=imgModificaClick; //Modifica
          Hint:=Hint + HintDesc;
        end;
        with (grdTimbrature.medpCompCella(i,0,2) as TmeIWImageFile) do
        begin
          OnClick:=imgAnnullaClick;  //Annulla
        end;
        with (grdTimbrature.medpCompCella(i,0,3) as TmeIWImageFile) do
        begin
          OnClick:=imgConfermaClick; //Conferma
        end;

        with (grdTimbrature.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          if not AbilCanc then
            //Non abilitato alla cancellazione
            Cell[0,0].Css:='invisibile'
          else
          begin
            Flag:=grdTimbrature.medpValoreColonna(i,'FLAG');
            if (Flag = 'I') and (Parametri.CancellaTimbrature = 'N') then
              Cell[0,0].Css:='invisibile'
            else if (Flag = 'O') and (Parametri.T100_CancTimbOrig = 'N') then
              Cell[0,0].Css:='invisibile';
          end;
          if (Parametri.T100_Ora <> 'S') and (Parametri.T100_Causale <> 'S') then
            //Non abilitato alla modifica
            Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureColumnClick(ASender: TObject; const AValue: string);
const
  FUNZIONE = 'grdTimbratureColumnClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  cdst100.Locate('DBG_ROWID',AValue,[]);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var Campo:String;
    NumColonna:Integer;
begin
  inherited;
  grdTimbrature.medpRenderCellComp(ACell,ARow,AColumn);
  NumColonna:=(ACell.Grid as TmedpIWDBGrid).medpNumColonna(AColumn);
  Campo:=grdTimbrature.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdTimbrature.medpCompGriglia) > 0) then
    if (grdTimbrature.medpValoreColonna(ARow - 1,'FLAG') = 'I') and R180In(Campo,['ORA','DESC_VERSO']) then
      ACell.Css:=ACell.Css + ' font_grassetto';
end;

procedure TW018FRichiestaTimbrature.btnVisualizzaClick(Sender: TObject);
const
  FUNZIONE = 'btnVisualizzaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // controlla la data filtro
  if Trim(edtDataFiltro.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Indicare la data per la visualizzazione delle timbrature.');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  if not TryStrToDate(edtDataFiltro.Text,ParametriForm.DataFiltro) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Indicare una data valida!');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  if ParametriForm.DataFiltro > Date then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La data non può essere successiva al giorno corrente!');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  // estrae le timbrature del giorno indicato
  GetModificaTimbrature;
  grdTimbrature.Caption:='Timbrature di ' + FormatDateTime('dddd d mmmm yyyy',ParametriForm.DataFiltro);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
const
  FUNZIONE = 'btnVisualizzaClick';
  function FormattaDatiRichiesta: String;
  var
    Operazione,OperazioneStr,Verso,Causale,
    VersoOrig,CausaleOrig,NoteRich: String;
  begin
    with W018DM.selT105 do
    begin
      Operazione:=FieldByName('OPERAZIONE').AsString;
      Verso:=FieldByName('VERSO').AsString;
      VersoOrig:=FieldByName('VERSO_ORIG').AsString;
      Causale:=FieldByName('CAUSALE_UTILE').AsString;
      CausaleOrig:=FieldByName('CAUSALE_ORIG').AsString;
      NoteRich:=FieldByName('NOTE1').AsString;
      if Operazione = 'I' then
        OperazioneStr:='inserimento'
      else if Operazione = 'M' then
        OperazioneStr:='modifica'
      else if Operazione = 'C' then
        OperazioneStr:='cancellazione';
      // formatta la richiesta
      Result:=Format('Richiesta di %s effettuata da %s (%s) il %s',
                     [OperazioneStr,
                      FieldByName('NOMINATIVO').AsString,
                      FieldByName('MATRICOLA').AsString,
                      FieldByName('DATA_RICHIESTA').AsString]) + CRLF +
              Format('Data: %s Ora: %s Verso: %s Causale: %s',
                     [FieldByName('DATA').AsString,
                      FieldByName('ORA').AsString,
                      IfThen(Operazione = 'M',VersoOrig,Verso),
                      IfThen(Operazione = 'M',CausaleOrig,Causale)]) +
              IfThen(Verso <> VersoOrig,CRLF + 'Verso modificato: ' + Verso) +
              IfThen(Causale <> CausaleOrig,CRLF + 'Causale modificata: ' + Causale) +
              IfThen(NoteRich <> '',CRLF + 'Note dipendente: ' + NoteRich);
    end;
  end;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  with W018DM.selT105 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ELABORATO').AsString = 'N') and
           (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
        begin
          try
            C018.CodIter:=FieldByName('COD_ITER').AsString;
            C018.Id:=FieldByName('ID').AsInteger;
            try
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione)
              else
                SessioneOracle.Commit;
            except
              on E: Exception do
              begin
                // messaggio bloccante
                MsgBox.MessageBox('Impostazione dell''autorizzazione fallita!' + CRLF +
                                  'Motivo: ' + E.Message + CRLF + CRLF +
                                  FormattaDatiRichiesta,ESCLAMA);
                Exit;
              end;
            end;
          except
            // errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
            begin
              ErrModCan:=True;
            end;
          end;
        end;
      finally
        Next;
      end;
    end;
  end;
  if ErrModCan then
    MsgBox.MessageBox('Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.',INFORMA);
  Ok:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.chkAutorizzazioneClick(Sender: TObject);
// autorizzazione - v1
const
  FUNZIONE = 'chkAutorizzazioneClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  SetAutorizzazione(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
procedure TW018FRichiestaTimbrature.chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
// autorizzazione - v2
var
  Nome, Indice, Target: String;
  IWC: TComponent;
const
  FUNZIONE = 'chkAutorizzazioneAsyncClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  SetAutorizzazione(Sender);

  // garantisce che solo uno dei check si/no sia impostato
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // determina il nome del checkbox da TmeIWCheckBox
    Nome:=(Sender as TmeIWCheckBox).Name;
    Indice:=RightStr(Nome,ROW_ELEM_INDEX_LENGTH);
    Nome:=Copy(Nome,1,Length(Nome) - ROW_ELEM_INDEX_LENGTH);

    Target:=IfThen(Nome = CHKSI_NAME,CHKNO_NAME,CHKSI_NAME) + Indice;
    IWC:=FindComponent(Target);
    if Assigned(IWC) then
    begin
      (IWC as TmeIWCheckBox).Checked:=False;
    end;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;
// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine

procedure TW018FRichiestaTimbrature.SetAutorizzazione(Sender: TObject);
// conferma l'autorizzazione indicata sulla richiesta
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // esegue l'autorizzazione della richiesta
  AutorizzazioneOK;

  if (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
     (GGetWebApplicationThreadVar.IsCallBack) then
  begin
    AutorizzazioniDaConfermare:=True;
  end;
end;

procedure TW018FRichiestaTimbrature.chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
var
  StrTemp: String;
const
  FUNZIONE = 'chkNoteInsAsyncClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  if (Sender as TmeIWCheckBox).Checked then
    StrTemp:='FindElem("MEMNOTEINS").className = "textarea_note inser";' + CRLF +
             'FindElem("MEMNOTEINS").focus();'
  else
    StrTemp:='FindElem("MEMNOTEINS").className = "invisibile"';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(StrTemp);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.AutorizzazioneOK;
// Importante: può essere richiamato anche da eventi async
var
  Aut,Resp: String;
const
  FUNZIONE = 'AutorizzazioneOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W018DM.selT105 do
  begin
    // verifica presenza record
    Refresh;
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      if GGetWebApplicationThreadVar.IsCallBack then
      begin
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      end
      else
      begin
        VisualizzaDipendenteCorrente;
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
      end;
      Exit;
    end;
    // imposta i dati di autorizzazione
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if Autorizza.Checked and (Autorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not Autorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione)
      else
        SessioneOracle.Commit;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
    end;
    if not GGetWebApplicationThreadVar.IsCallBack then
    begin
      Refresh;
      grdRichieste.medpCaricaCDS;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.btnRiepilogoOreClick(Sender: TObject);
var
  DataAttuale,DataSelez,DataInizio,DataFine: TDateTime;
const
  FUNZIONE = 'btnRiepilogoOreClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // stabilisce e imposta il periodo per i conteggi
  DataAttuale:=Date; //Trunc(R180SysDate(SessioneOracle));
  with W018DM.selT105 do
  begin
    if SearchRecord('ROWID',cdsT105.FieldByName('DBG_ROWID').AsString,[srFromBeginning]) then
      DataSelez:=FieldByName('DATA').AsDateTime
    else
      DataSelez:=IfThen(ParametriForm.DataFiltro = 0,DataAttuale,ParametriForm.DataFiltro);
  end;
  DataInizio:=R180InizioMese(DataSelez);
  DataFine:=R180FineMese(DataSelez);
  if DataFine > DataAttuale then
    DataFine:=DataAttuale;
  Log('Traccia',Format('Data selezionata: %s, inizio: %s, fine: %s',[DateToStr(DataSelez),DateToStr(DataInizio),DateToStr(DataFine)]));

  // crea frame per riepilogo ore
  W018FRiepilogoOreFM:=TW018FRiepilogoEccedenzeFM.Create(Self);
  Log('Traccia','Creazione frame di riepilogo ore completata');
  W018FRiepilogoOreFM.W018DM:=W018DM;
  W018FRiepilogoOreFM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W018FRiepilogoOreFM.DataSelez:=DataSelez;
  W018FRiepilogoOreFM.DataInizio:=DataInizio;
  W018FRiepilogoOreFM.DataFine:=DataFine;
  if not W018FRiepilogoOreFM.Visualizza then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format('Nessun riepilogo da visualizzare per il mese di %s %d!',
                               [R180NomeMese(R180Mese(DataInizio)),
                                R180Anno(DataInizio)]));
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
procedure TW018FRichiestaTimbrature.btnImportaClick(Sender: TObject);
var
  Errore,Msg,ErrMsg,ElencoRichieste: String;
  NumScartate,NumRichieste: Integer;
  Ok,AvvisoRiesegui: Boolean;
const
  FUNZIONE = 'AutorizzazioneOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  AutorizzazioniDaConfermare:=False;

  // determina l'elenco delle richieste attualmente presenti nel dataset
  W018DM.selT105.Refresh;
  if W018DM.selT105.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  with W018DM.selT105 do
  begin
    ElencoRichieste:='';
    AvvisoRiesegui:=RecordCount > ORACLE_MAX_IN_VALUES;
    First;
    while not Eof do
    begin
      if RecNo > ORACLE_MAX_IN_VALUES then
        Break;
      ElencoRichieste:=ElencoRichieste + FieldByName('ID').AsString + ',';
      Next;
    end;
  end;
  ElencoRichieste:=Copy(ElencoRichieste,1,Length(ElencoRichieste) - 1);

  if ElencoRichieste = '' then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  //ImportaTimbratureAutorizzate(ElencoRichieste);
  A023MW.AcquisizioneRichiesteAuto(ElencoRichieste,ErrMsg,NumScartate,NumRichieste);
  if ErrMsg <> '' then
  begin
    MsgBox.AddMessage(ErrMsg);
  end;

  (*
  // sfrutta il dataset della A023MW, impostando un C700SelAnagrafe fittizio
  // e filtrando le richieste solo per ID
  // nota: il dataset viene ora filtrato in base al proprio filtro dizionario
  //       questa modifica non dovrebbe causare effetti collaterali per cui si mantiene
  //       il filtro del dataset
  with A023MW.selT105 do
  begin
    Close;
    SetVariable('C700SELANAGRAFE','t030_anagrafico t030 where 1=1');
    SetVariable('FILTRO_RICHIESTE',Format('and t105.id in (%s)',[ElencoRichieste]));
    Open;
    if RecordCount = 0 then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W018_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
      Exit;
    end;
  end;

  // elaborazione massiva delle richieste
  Errore:='';
  NumScartate:=0;
  Ok:=True;
  try
    RegistraMsg.IniziaMessaggio(medpCodiceForm);
    A023MW.InizializzaAcquisizioneWeb(False);

    while not A023MW.selT105.Eof do
    begin
      A023MW.ImportaRichiesta;

      if A023MW.Elaborato = 'E' then
        Ok:=False;
      A023MW.selT105.Next;
    end;
    A023MW.selT105.Refresh;
  finally
    A023MW.FinalizzaAcquisizioneWeb;
  end;
  *)
  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  (*
  // messaggio di fine elaborazione
  if Ok then
  begin
    // elaborazione ok / warning
    if Errore = '' then
      Msg:=A000TraduzioneStringhe(A000MSG_MSG_ELAB_OK)
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_MSG_ELAB_WARNING),[Errore]);

    if NumScartate > 0 then
      Msg:=Msg + CRLF + A000TraduzioneStringhe(A000MSG_W018_MSG_RICH_GIA_IMPORTATE);
    MsgBox.AddMessage(Msg);
  end
  else
  begin
    // anomalie durante elaborazione
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_MSG_ELAB_ERRORE) + CRLF +
                      A000TraduzioneStringhe(A000MSG_W018_MSG_CONSULTA_NOTIFICHE_ELAB));
  end;
  *)

  // richieste > del limite della in di oracle
  if AvvisoRiesegui then
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_W018_MSG_RIESEGUI_IMPORTAZIONE));

  MsgBox.ShowMessages;
end;
// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine

function TW018FRichiestaTimbrature.ArrIndexFromCodice(const Tipo: String; const Codice: String): Integer;
// Determina l'indice della causale specificata nell'array ArrCausali
const
  FUNZIONE = 'ArrIndexFromCodice';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Result:=-1;
  if Codice = '' then
    Exit;

  if Tipo = 'C' then
    Result:=_ArrCausaliGetIndex(Codice,0,High(ArrCausali))
  else if Tipo = 'R' then //Rilevatori
    Result:=_ArrRilevatoriGetIndex(Codice,0,High(ArrRilevatori))
  else
    Result:=_ArrMotivazioniGetIndex(Codice,0,High(ArrMotivazioni));

  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature._ArrCausaliGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array delle causali
var
  q, Res: Integer;
const
  FUNZIONE = '_ArrCausaliGetIndex';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrCausali[q].Codice) then
      Res:=_ArrCausaliGetIndex(Codice,p,q-1);
    if (Codice > ArrCausali[q].Codice) then
      Res:=_ArrCausaliGetIndex(Codice,q+1,r);
    if (Codice = ArrCausali[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrCausali[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature._ArrRilevatoriGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array dei rilevatori
var
  q, Res: Integer;
const
  FUNZIONE = '_ArrRilevatoriGetIndex';
begin
   Log('Traccia',FUNZIONE + ': inizio');
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrRilevatori[q].Codice) then
      Res:=_ArrRilevatoriGetIndex(Codice,p,q-1);
    if (Codice > ArrRilevatori[q].Codice) then
      Res:=_ArrRilevatoriGetIndex(Codice,q+1,r);
    if (Codice = ArrRilevatori[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrRilevatori[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature._ArrMotivazioniGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array delle motivazioni
const
  FUNZIONE = '_ArrMotivazioniGetIndex';
var
  q, Res: Integer;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrMotivazioni[q].Codice) then
      Res:=_ArrMotivazioniGetIndex(Codice,p,q-1);
    if (Codice > ArrMotivazioni[q].Codice) then
      Res:=_ArrMotivazioniGetIndex(Codice,q+1,r);
    if (Codice = ArrMotivazioni[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrMotivazioni[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
  Log('Traccia',FUNZIONE + ': fine');
end;

// MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
function TW018FRichiestaTimbrature.DecodificaFunzioneRilevatore(const PFunzione: String): String;
// decodifica la funzione del rilevatore in base al codice
begin
  if PFunzione = 'P' then
    Result:='presenza'
  else if PFunzione = 'M' then
    Result:='mensa'
  else if PFunzione = 'E' then
    Result:='presenza/mensa'
  else
    Result:=Format('[non valido: %s]',[PFunzione]);
end;
// MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

procedure TW018FRichiestaTimbrature.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
var
  i: Integer;
  CausRichWeb: Boolean;
const
  FUNZIONE = 'GetDatiTabellari';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // array per le motivazioni della richiesta
  with W018DM.selT106 do
  begin
    MotivazioneDefault:=-1;
    R180SetVariable(W018DM.selT106,'TIPO','T');
    Open;
    First;
    SetLength(ArrMotivazioni,RecordCount);
    i:=0;
    while not Eof do
    begin
      ArrMotivazioni[i].Codice:=FieldByName('CODICE').AsString;
      ArrMotivazioni[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      if FieldByName('CODICE_DEFAULT').AsString = 'S' then
        MotivazioneDefault:=i;
      Next;
      i:=i + 1;
    end;
    Close;
  end;

  // array per le causali di presenza
  with WR000DM.selT275 do
  begin
    //Close;
    Open;
    First;
    SetLength(ArrCausali,RecordCount + 1);
    i:=1;
    CausRichWeb:=False;
    while not Eof do
    begin
      ArrCausali[i].Codice:=FieldByName('CODICE').AsString;
      ArrCausali[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      ArrCausali[i].Text:=StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]);
      if FieldByName('TIPO_RICHIESTA_WEB').AsString <> 'N' then
        CausRichWeb:=True;
      Next;
      i:=i + 1;
    end;
    //Close;
  end;

  // array per i rilevatori
  with WR000DM.selT361 do
  begin
    //Close;
    Filtered:=True;//FiltroDizionario
    Open;
    First;
    SetLength(ArrRilevatori,RecordCount + 1);
    i:=1;
    while not Eof do
    begin
      ArrRilevatori[i].Codice:=FieldByName('CODICE').AsString;
      // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
      // aggiunta info tipo rilevatore
      //ArrRilevatori[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      //ArrRilevatori[i].Text:=Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]);
      ArrRilevatori[i].Descrizione:=Format('%s (%s)',[FieldByName('DESCRIZIONE').AsString,DecodificaFunzioneRilevatore(FieldByName('FUNZIONE').AsString)]);
      ArrRilevatori[i].Text:=Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]);
      // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

      Next;
      i:=i + 1;
    end;
    //Close;
    Filtered:=False;
  end;

  // il pulsante "Riepilogo ore" è visibile solo se ci sono causali
  // per cui è indicato il cumulo con le richieste web
  btnRiepilogoOre.Visible:=CausRichWeb;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.GetDipendentiDisponibili(Data:TDateTime);
const
  FUNZIONE = 'GetDipendentiDisponibili';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
  i:Integer;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  Autorizza.Operazione:='';
  grdRichieste.medpBrowse:=True;

  // apre il dataset delle richieste di timbrature
  with W018DM.selT105 do
  begin
    // determina filtri
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    R013Open(W018DM.selT105);
  end;

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('DETTAGLIO_GG','Dett. gg','',nil);
    if C018.TipoRichiesteSel <> [trDaAutorizzare] then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
    grdRichieste.medpAggiungiColonna('DESC_OPERAZIONE','Operazione','',nil);
    grdRichieste.medpAggiungiColonna('VERSO','Verso','',nil);
    grdRichieste.medpAggiungiColonna('ORA','Ora','',nil);
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','Mod.caus.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_UTILE','Causale','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    // aggiunta info rilevatore e spostata operazione dopo colonna data
    grdRichieste.medpAggiungiColonna('RILEVATORE_RICH','Rilevatore','',nil);
    //grdRichieste.medpAggiungiColonna('DESC_OPERAZIONE','Operazione','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
    grdRichieste.medpAggiungiColonna('VERSO_ORIG','Verso orig.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_ORIG','Causale orig.','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    // aggiunta colonna rilevatore orig.
    grdRichieste.medpAggiungiColonna('RILEVATORE_ORIG','Rilev. orig.','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
    if Length(ArrMotivazioni) > 0 then
    begin
      // MONDOEDP - commessa: MAN/07 SVILUPPO#54.ini
      // gestione colonna descrizione motivazione in tabella
      //grdRichieste.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
      grdRichieste.medpAggiungiColonna('D_MOTIVAZIONE','Motivazione','',nil);
      // MONDOEDP - commessa: MAN/07 SVILUPPO#54.fine
    end;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=(not SolaLettura) and
                                                     (C018.TipoRichiesteSel <> [trAutorizzAuto]) and
                                                     (Parametri.T100_Causale = 'S') and
                                                     (C018.IterModificaValori);
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
    grdRichieste.medpAggiungiColonna('DESC_OPERAZIONE','Operazione','',nil);
    grdRichieste.medpAggiungiColonna('VERSO','Verso','',nil);
    grdRichieste.medpAggiungiColonna('ORA','Ora','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_UTILE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('RILEVATORE_RICH','Rilevatore','',nil);
    grdRichieste.medpAggiungiColonna('VERSO_ORIG','Verso orig.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_ORIG','Causale orig.','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    // aggiunta colonna rilevatore orig.
    grdRichieste.medpAggiungiColonna('RILEVATORE_ORIG','Rilev. orig.','',nil);
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
    if Length(ArrMotivazioni) > 0 then
    begin
      // MONDOEDP - commessa: MAN/07 SVILUPPO#54.ini
      // gestione colonna descrizione motivazione in tabella
      //grdRichieste.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
      grdRichieste.medpAggiungiColonna('D_MOTIVAZIONE','Motivazione','',nil);
      // MONDOEDP - commessa: MAN/07 SVILUPPO#54.fine
    end;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    if C018.TipoRichiesteSel <> [trDaAutorizzare] then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  end;
  grdRichieste.medpAggiungiColonna('FLAG','','',nil);
  grdRichieste.medpColonna('FLAG').Visible:=False;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',grdRichiesteColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if (not SolaLettura) and (C018.TipoRichiesteSel <> [trAutorizzAuto]) then
  begin
    if WR000DM.Responsabile then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      if grdRichieste.medpColonna('DBG_COMANDI').Visible then
      begin
        i:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        grdRichieste.medpPreparaComponenteGenerico('R',i,0,DBG_IMG,'','MODIFICA','null','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,1,DBG_IMG,'','ANNULLA','null','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,2,DBG_IMG,'','CONFERMA','null','Confermare la modifica della causale indicata dal dipendente?','D');
      end;
    end
    else
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di modifica timbratura','Eliminare la richiesta selezionata?','',True);
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  if WR000DM.Responsabile then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('DETTAGLIO_GG'),0,DBG_IMG,'','DETTAGLIO','','','',True);
  grdRichieste.medpCaricaCDS;

  // visualizzazione timbrature del giorno per il dipendente
  if not WR000DM.Responsabile then
  begin
    btnVisualizzaClick(nil);
  end
  else
  begin
    grdTimbrature.Visible:=False;
    JavascriptBottom.Add('document.getElementById("elencoTimbrature").className = "invisibile";');
  end;

  // svuota clientdataset per i conteggi di riepilogo
  W018DM.cdsRiepOre.Close;

  AutorizzazioniDaConfermare:=False;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgModificaCausClick(Sender: TObject);
var
  FN: string;
const
  FUNZIONE = 'imgModificaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // modifica
  if Autorizza.Operazione = 'M' then
  begin
    MsgBox.MessageBox('E'' necessario completare l''operazione di variazione in corso prima di procedere!',INFORMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRichiesteColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  Autorizza.Operazione:='M';
  grdRichieste.medpBrowse:=False;
  TrasformaCompCausale(FN);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgAnnullaCausClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAnnullaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Autorizza.Operazione:='';

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRichiesteColumnClick(Sender,FN);

  grdRichieste.medpBrowse:=True;
  TrasformaCompCausale(FN);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgConfermaCausClick(Sender: TObject);
var
  FN, CausMod: String;
  i, idxCaus: Integer;
const
  FUNZIONE = 'imgConfermaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // applicazione modifiche
  if (Autorizza.Operazione = 'M') then
  begin
    // se il record non esiste -> errore
    W018DM.selT105.Refresh;
    if not W018DM.selT105.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Errore durante la modifica della causale:' + CRLF +
                        'la richiesta non è più disponibile!',INFORMA);
      Exit;
    end;

    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    idxCaus:=grdRichieste.medpIndexColonna('CAUSALE_UTILE');

    grdRichiesteColumnClick(Sender,FN);

    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    CausMod:=Copy((grdRichieste.medpCompCella(i,idxCaus,0) as TmeIWComboBox).Text,1,5);
    Autorizza.Operazione:='';
    grdRichieste.medpBrowse:=True;
    if CausMod = W018DM.selT105.FieldByName('CAUSALE_UTILE').AsString then
    begin
      TrasformaCompCausale(FN);
      Exit;
    end;

    // modifica della causale
    try
      with W018DM.selT105 do
      begin
        RefreshRecord;

        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID').AsInteger;
        if CausMod = W018DM.selT105.FieldByName('CAUSALE').AsString then
          C018.DelDatoAutorizzatore('CAUSALE',FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger)
        else
          C018.SetDatoAutorizzatore('CAUSALE',CausMod,FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);

        SessioneOracle.Commit;
        RefreshOptions:=[roAllFields];
        RefreshRecord;
        RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      end;
    except
      on E: Exception do
      begin
        VisualizzaDipendenteCorrente;
        GGetWebApplicationThreadVar.ShowMessage('Modifica della causale fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
        Exit;
      end;
    end;
    grdRichieste.medpAllineaRecordCDS;
    grdRichieste.medpCaricaCDS(FN);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgCancellaRichiestaClick(Sender: TObject);
// Cancellazione di una richiesta
const
  FUNZIONE = 'imgCancellaRichiestaClick';
var
  D,D2:TDateTime;
  FN: String;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W018DM.selT105 do
  begin
    Refresh;
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione! La richiesta da cancellare non è più disponibile!',INFORMA);
      Exit;
    end;

    grdRichiesteColumnClick(Sender,FN);

    D:=FieldByName('DATA').AsDateTime;
    try
      //elimina la richiesta
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.EliminaIter;
      SessioneOracle.Commit;
      Refresh;
    except
      on E: Exception do
        GGetWebApplicationThreadVar.ShowMessage('Cancellazione della richiesta fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
    end;
  end;
  grdRichieste.medpCaricaCDS;
  if TryStrToDate(edtDataFiltro.Text,D2) and (D = D2) then
    GetModificaTimbrature;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.TrasformaCompCausale(const FN:String);
// Trasforma la colonna "Causale" della riga indicata da text a control e viceversa
// per la grid grdRichieste
const
  FUNZIONE = 'TrasformaCompCausale';
var
  DaTestoAControlli: Boolean;
  i,x,idxCaus: Integer;
begin
  Log('Traccia',FUNZIONE + ': inizio');

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  idxCaus:=grdRichieste.medpIndexColonna('CAUSALE_UTILE');
  DaTestoAControlli:=grdRichieste.medpCompGriglia[i].CompColonne[idxCaus] = nil;
  // abilita / disabilita possibilità di autorizzare
  (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;

  // Gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[idxCaus - 1] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
    Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    // combobox delle causali
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,idxCaus,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,idxCaus,0) as TmeIWComboBox) do
    begin
      ItemsHaveValues:=True;
      Items.BeginUpdate;
      Items.Add('');
      for x:=1 to Length(ArrCausali) - 1 do
        Items.Values[ArrCausali[x].Text]:=ArrCausali[x].Codice;
      Items.EndUpdate;
      ItemIndex:=Max(0,R180IndexOf(Items,grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE'),5));
    end;
  end
  else
  begin
    // trasforma componenti in testo
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxCaus]);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.GetModificaTimbrature;
const
  FUNZIONE = 'GetModificaTimbrature';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Richiesta.Operazione:='';
  grdTimbrature.medpBrowse:=True;

  AllineaTimbrature;

  // apre dataset di supporto per timbrature
  W018DM.selT100ModifTimb.Close;
  W018DM.selT100ModifTimb.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W018DM.selT100ModifTimb.SetVariable('DATA',StrToDate(edtDataFiltro.Text));
  W018DM.selT100ModifTimb.Open;

  grdTimbrature.medpCreaCDS;
  grdTimbrature.medpEliminaColonne;
  grdTimbrature.medpAggiungiColonna('DBG_COMANDI','','DBG_ROWID',grdTimbratureColumnClick);
  grdTimbrature.medpAggiungiColonna('DESC_VERSO','Verso','',nil);
  grdTimbrature.medpAggiungiColonna('ORA','Ora','',nil);
  grdTimbrature.medpAggiungiColonna('DESC_CAUSALE','Causale','',nil);
  grdTimbrature.medpAggiungiColonna('RILEVATORE','Rilevatore','',nil);
  grdTimbrature.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
  grdTimbrature.medpAggiungiColonna('NOTE','Note','',nil);
  grdTimbrature.medpColonna('MOTIVAZIONE').Visible:=Length(ArrMotivazioni) > 0;
  grdTimbrature.medpColonna('NOTE').Visible:=False;
  grdTimbrature.medpAggiungiRowClick('DBG_ROWID',grdTimbratureColumnClick);

  grdTimbrature.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    if AbilCanc or (Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S') then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Cancella la timbratura','Confermare la richiesta di eliminazione della timbratura corrente?','S');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la timbratura','','D');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la richiesta di modifica della timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la richiesta di modifica della timbratura','Confermare la richiesta di modifica della timbratura corrente?','D');
    end;
    if AbilIns then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce la richiesta di una nuova timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla la richiesta di inserimento di una nuova timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma la richiesta di inserimento di una nuova timbratura','Confermare la richiesta di inserimento della timbratura?','D');
    end;
  end;
  grdTimbrature.medpCaricaCDS;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.AllineaTimbrature;
var A023FAllTimbW018:TA023FAllTimbMW;
    Data:TDateTime;
begin
  Data:=StrToDate(edtDataFiltro.Text);
  // crea oggetto per allineamento timbrature uguali
  A023FAllTimbW018:=TA023FAllTimbMW.Create(nil);
  try
    try
      // allineamento timbrature
      A023FAllTimbW018.Q100.Session:=SessioneOracle;
      A023FAllTimbW018.Q100Upd.Session:=SessioneOracle;
      A023FAllTimbW018.Allinea(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);
    except
      on E:Exception do
        Log('Errore','Allineamento timbrature uguali: ' + E.ClassName + '/' + E.Message);
    end;
  finally
    try FreeAndNil(A023FAllTimbW018); except end;
  end;
end;

procedure TW018FRichiestaTimbrature.imgCancellaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgCancellaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if Richiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione in corso prima di procedere!');
    Exit;
  end;

  grdTimbratureColumnClick(Sender,FN);

  // verifica blocco riepiloghi
  if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(ParametriForm.DataFiltro),'T100') then
  begin
    MsgBox.MessageBox('Inserimento richiesta annullato: blocco attivo!',INFORMA,'Riepiloghi bloccati');
    Exit;
  end;

  // se il record non esiste -> errore
  W018DM.selT100ModifTimb.Refresh;
  if not W018DM.selT100ModifTimb.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GetModificaTimbrature;
    MsgBox.MessageBox('Errore durante l''inserimento della richiesta:' + CRLF +
                      'la timbratura da cancellare non è più disponibile!',INFORMA);
    Exit;
  end;

  // eliminazione record
  actCanTimbraturaOK;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.GetCausaliPresenza(Items:TStringList);
var Codice,Descrizione:String;
begin
  R180SetVariable(W018DM.selT275Abilitate,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
  R180SetVariable(W018DM.selT275Abilitate,'DATA',StrToDate(edtDataFiltro.Text));
  with W018DM.selT275Abilitate do
  begin
    Open;
    First;
    while not Eof do
    begin
      Codice:=FieldByName('CODICE').AsString;
      Descrizione:=StringReplace(Format('%-5s %s',[Codice,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]);
      Items.Values[Descrizione]:=Codice;
      Next;
    end;
  end;
end;

procedure TW018FRichiestaTimbrature.imgInserisciClick(Sender: TObject);
// Crea i controlli per la riga di inserimento
var
  x: Integer;
  FN: string;
const
  FUNZIONE = 'imgInserisciClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if Richiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare' + CRLF +
                               'l''operazione in corso prima di procedere!');
    Exit;
  end;
  grdTimbratureColumnClick(Sender,FN);

  Richiesta.Operazione:='I';
  grdTimbrature.medpBrowse:=False;
  with (grdTimbrature.medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:='invisibile';
    Cell[0,1].Css:=StileCella1;
    Cell[0,2].Css:=StileCella2;
  end;

  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Entrata,Uscita','Verso della timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,1,grdTimbrature.Componenti);
  (grdTimbrature.medpCompCella(0,1,0) as TmeTIWAdvRadioGroup).ItemIndex:=0;

  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','Ora della timbratura in formato hh mm','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,2,grdTimbrature.Componenti);

  if Parametri.T100_Causale = 'S' then
  begin
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','Selezione della causale per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(0,3,grdTimbrature.Componenti);
    with (grdTimbrature.medpCompCella(0,3,0) as TmeIWComboBox) do
    begin
      ItemsHaveValues:=True;
      Items.BeginUpdate;
      Items.Add('');
      (*Alberto 24/11/2013: lettura delle sole causali abilitate
      for x:=1 to Length(ArrCausali) - 1 do
        Items.Values[ArrCausali[x].Text]:=ArrCausali[x].Codice;
      *)
      GetCausaliPresenza(Items);
      Items.EndUpdate;
      ItemIndex:=0;
    end;
  end;

  if Parametri.T100_Rilevatore = 'S' then
  begin
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'30','','Selezione del rilevatore per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('RILEVATORE'),grdTimbrature.Componenti);
    with (grdTimbrature.medpCompCella(0,'RILEVATORE',0) as TmeIWComboBox) do
    begin
      ItemsHaveValues:=True;
      Items.BeginUpdate;
      Items.Add('');
      for x:=1 to Length(ArrRilevatori) - 1 do
        Items.Values[ArrRilevatori[x].Text]:=ArrRilevatori[x].Codice;
      Items.EndUpdate;
      ItemIndex:=0;
    end;
  end;

  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'40','','Selezione della motivazione per la timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('MOTIVAZIONE'),grdTimbrature.Componenti);
  with (grdTimbrature.medpCompCella(0,'MOTIVAZIONE',0) as TmeIWComboBox) do
  begin
    NoSelectionText:='';
    RequireSelection:=True;
    ItemsHaveValues:=True;
    Items.BeginUpdate;
    for x:=0 to Length(ArrMotivazioni) - 1 do
      Items.Values[ArrMotivazioni[x].Descrizione]:=ArrMotivazioni[x].Codice;
    Items.EndUpdate;
    ItemIndex:=MotivazioneDefault;
  end;

  grdTimbrature.medpColonna('NOTE').Visible:=True;
  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','Inserimento delle note per la timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('NOTE'),grdTimbrature.Componenti);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgModificaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgModificaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  if Richiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare' + CRLF +
                               'l''operazione in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdTimbratureColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  Richiesta.Operazione:=IfThen(FN = '*','I','M');
  grdTimbrature.medpBrowse:=False;
  TrasformaComponenti(FN,True);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgConfermaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgConfermaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // controlli per modifica
  if (Richiesta.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    MemoText:='';
    if not ModificheRiga(FN) then
    begin
      Richiesta.Operazione:='';
      grdTimbrature.medpColonna('NOTE').Visible:=False;
      grdTimbrature.medpCaricaCDS(FN);
      grdTimbrature.medpBrowse:=True;
      MsgBox.MessageBox('I dati della timbratura non sono stati modificati: richiesta non inserita!',INFORMA);
      Exit;
    end;

    // se il record non esiste -> errore
    W018DM.selT100ModifTimb.Refresh;
    if not W018DM.selT100ModifTimb.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      Richiesta.Operazione:='';
      GetModificaTimbrature;
      MsgBox.MessageBox('Errore durante l''inserimento della richiesta:' + CRLF +
                        'la timbratura da modificare non è più disponibile!',INFORMA);
      Exit;
    end;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  // inserimento / aggiornamento
  if Richiesta.Operazione = 'I' then
    actInsTimbraturaOK
  else
    actVarTimbraturaOK;

  grdTimbrature.medpColonna('NOTE').Visible:=False;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgAnnullaClick(Sender: TObject);
const
  FUNZIONE = 'imgAnnullaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgIterClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgIterClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdTimbrature.medpStato = msBrowse then
    grdRichiesteColumnClick(Sender,FN);
  with W018DM.selT105 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW018FRichiestaTimbrature.imgAllegClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAllegClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdTimbrature.medpStato = msBrowse then
    grdRichiesteColumnClick(Sender,FN);
  with W018DM.selT105 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaAllegati(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW018FRichiestaTimbrature.imgDettaglioGGClick(Sender: TObject);
var
  i: Integer;
  FN: String;
const
  FUNZIONE = 'imgDettaglioGGClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  grdRichiesteColumnClick(Sender,FN);
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  W005FCartellinoFM:=TW005FCartellinoFM.Create(Self);
  W005FCartellinoFM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W005FCartellinoFM.Dal:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
  W005FCartellinoFM.Al:=W005FCartellinoFM.Dal;
  W005FCartellinoFM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.TrasformaComponenti(FN:String; DaTestoAControlli:Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa
// per la grid grdTimbrature
var
  i,x: Integer;
const
  FUNZIONE = 'TrasformaComponenti';
begin
  // pre: not SolaLettura
  Log('Traccia',FUNZIONE + ': inizio');
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);

  if Richiesta.Operazione = 'I' then
  begin
    with (grdTimbrature.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;
  end
  else
  begin
    with (grdTimbrature.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;
  end;

  if DaTestoAControlli then
  begin
    // verso
    if (not SolaLettura) and (Parametri.T100_Ora = 'S') then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Entrata,Uscita','Verso della timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,1,grdTimbrature.Componenti);
      (grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex:=IfThen(grdTimbrature.medpValoreColonna(i,'VERSO') = 'E',0,1);
    end;
    // causale
    if (not SolaLettura) and (Parametri.T100_Causale = 'S') then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','Selezione della causale per la timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,3,grdTimbrature.Componenti);
      with (grdTimbrature.medpCompCella(i,3,0) as TmeIWComboBox) do
      begin
        ItemsHaveValues:=True;
        Items.BeginUpdate;
        Items.Add('');
        (*Alberto 24/11/2013: lettura delle sole causali abilitate
        for x:=1 to Length(ArrCausali) - 1 do
          Items.Values[ArrCausali[x].Text]:=ArrCausali[x].Codice;
        *)
        GetCausaliPresenza(Items);
        Items.EndUpdate;
        ItemIndex:=Max(0,R180IndexOf(Items,grdTimbrature.medpValoreColonna(i,'CAUSALE'),5));
      end;
    end;
    // motivazione
    if (not SolaLettura) and
       (Length(ArrMotivazioni) > 0) and
       ((Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S')) then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'40','','Selezione della motivazione per la timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,grdTimbrature.medpIndexColonna('MOTIVAZIONE'),grdTimbrature.Componenti);
      with (grdTimbrature.medpCompCella(i,'MOTIVAZIONE',0) as TmeIWComboBox) do
      begin
        NoSelectionText:='';
        RequireSelection:=True;
        ItemsHaveValues:=True;
        Items.BeginUpdate;
        for x:=0 to Length(ArrMotivazioni) - 1 do
          Items.Values[ArrMotivazioni[x].Descrizione]:=ArrMotivazioni[x].Codice;
        Items.EndUpdate;
        ItemIndex:=MotivazioneDefault;
      end;
    end;

    grdTimbrature.medpColonna('NOTE').Visible:=True;
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','Inserimento delle note per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(i,grdTimbrature.medpIndexColonna('NOTE'),grdTimbrature.Componenti);
  end
  else
  begin
    // verso
    if (not SolaLettura) and (Parametri.T100_Ora = 'S') then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[1]);
    end;

    //ora - solo inserimento
    if Richiesta.Operazione = 'I' then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[2]);
    end;

    // causale
    if (not SolaLettura) and (Parametri.T100_Causale = 'S') then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[3]);
    end;

    //rilevatore - solo inserimento e se colonna presente
    if Richiesta.Operazione = 'I' then
      if Parametri.T100_Rilevatore = 'S' then
      begin
        FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('RILEVATORE')]);
      end;

    // motivazione
    if (not SolaLettura) and
       (Length(ArrMotivazioni) > 0) and
       ((Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S')) then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('MOTIVAZIONE')]);
    end;

    // note
    FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('NOTE')]);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature.ModificheRiga(FN:String): Boolean;
// Restituisce true se sono state effettuate modifiche alla timbratura, false altrimenti
var
  i: Integer;
  NewVerso,NewCausale: String;
const
  FUNZIONE = 'ModificheRiga';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=False;
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);

  // se verso abilitato verifica modifica
  if grdTimbrature.medpCompGriglia[i].CompColonne[1] <> nil then
  begin
    NewVerso:=IfThen((grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex = 0,'E','U');
    Result:=Result or (grdTimbrature.medpValoreColonna(i,'VERSO') <> NewVerso);
  end;

  // se causale abilitata verifica modifica
  if grdTimbrature.medpCompGriglia[i].CompColonne[3] <> nil then
  begin
    NewCausale:=Copy((grdTimbrature.medpCompCella(i,3,0) as TmeIWComboBox).Text,1,5);
    Result:=Result or (grdTimbrature.medpValoreColonna(i,'CAUSALE') <> NewCausale);
  end;
  MemoText:=(grdTimbrature.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
begin
  // conferma nel caso di autorizzazioni pendenti da confermare
  if (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
     (AutorizzazioniDaConfermare) then
  begin
    Conferma:='Attenzione!'#13#10 +
              'Sono presenti autorizzazioni da confermare.'#13#10 +
              'Le modifiche non verrano perse, ma sarà necessario confermarle la volta successiva.'#13#10 +
              'Uscire comunque?';
  end;
end;

function TW018FRichiestaTimbrature.ControlliOK(FN:String): Boolean;
// Effettua i controlli e imposta i dati per l'aggiornamento
var
  i,c: Integer;
  IWC: TmeIWComboBox;
  IWEdt: TmeIWEdit;
const
  FUNZIONE = 'ControlliOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Result:=False;
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);
  with WR000DM do
  begin
    // imposta variabili per inserimento / aggiornamento
    if Richiesta.Operazione = 'I' then
    begin
      // data timbratura
      if Trim(edtDataFiltro.Text) = '' then
      begin
        MsgBox.MessageBox('Indicare la data della timbratura!',INFORMA);
        ActiveControl:=edtDataFiltro;
        Exit;
      end;
      if not TryStrToDate(edtDataFiltro.Text,Richiesta.Data) then
      begin
        MsgBox.MessageBox('Indicare una data valida!',INFORMA);
        ActiveControl:=edtDataFiltro;
        Exit;
      end;
      if Richiesta.Data > Date then
      begin
        MsgBox.MessageBox('La data non può essere successiva al giorno corrente!',INFORMA);
        ActiveControl:=edtDataFiltro;
        Exit;
      end;
      if (Parametri.WEBIterTimbGGPrec >= 0) and ((Date - Richiesta.Data) > Parametri.WEBIterTimbGGPrec) then
      begin
        MsgBox.MessageBox(Format('La data non può essere antecedente più di %d giorni!',[Parametri.WEBIterTimbGGPrec]),INFORMA);
        ActiveControl:=edtDataFiltro;
        Exit;
      end;

      // ora timbratura
      IWEdt:=(grdTimbrature.medpCompCella(i,'ORA',0) as TmeIWEdit);
      if IWEdt.Text = '' then
      begin
        MsgBox.MessageBox('Indicare l''ora della timbratura!',INFORMA);
        ActiveControl:=IWEdt;
        Exit;
      end;
      try
        R180OraValidate(IWEdt.Text);
        Richiesta.Ora:=IWEdt.Text;
      except
        on E:Exception do
        begin
          MsgBox.MessageBox(E.Message,INFORMA);
          ActiveControl:=IWEdt;
          Exit;
        end;
      end;
    end
    else
      Richiesta.Data:=ParametriForm.DataFiltro;

    // verifica blocco dati
    if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(Richiesta.Data),'T100') then
    begin
      MsgBox.MessageBox('Inserimento richiesta annullato: blocco attivo',INFORMA,'Riepiloghi bloccati');
      Exit;
    end;

    // verso
    c:=grdTimbrature.medpIndexColonna('DESC_VERSO');
    if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
      Richiesta.Verso:=IfThen((grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex = 0,'E','U')
    else
      Richiesta.Verso:=grdTimbrature.medpValoreColonna(i,'VERSO');

    // causale
    c:=grdTimbrature.medpIndexColonna('DESC_CAUSALE');
    if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
    begin
      IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
      Richiesta.Causale:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
    end
    else
      Richiesta.Causale:=grdTimbrature.medpValoreColonna(i,'CAUSALE');

    //if Parametri.T100_Rilevatore = 'S' then
    begin
      // rilevatore
      c:=grdTimbrature.medpIndexColonna('RILEVATORE');
      if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
      begin
        IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
        Richiesta.Rilevatore:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
      end
      else
        Richiesta.Rilevatore:=grdTimbrature.medpValoreColonna(i,'RILEVATORE');
    end;

    // motivazione
    if Length(ArrMotivazioni) > 0 then
    begin
      c:=grdTimbrature.medpIndexColonna('MOTIVAZIONE');
      if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
      begin
        // verifica selezione motivazione
        IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
        if IWC.ItemIndex < 0 then
        begin
          MsgBox.MessageBox('E'' necessario selezionare una motivazione per la richiesta!',INFORMA);
          ActiveControl:=IWC;
          Exit;
        end;
        Richiesta.Motivazione:=ArrMotivazioni[IWC.ItemIndex].Codice;
      end
      else
        Richiesta.Motivazione:='';
    end;
  end;
  // controlli ok
  Result:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.actInsTimbraturaOK;
// inserimento richiesta di segnalazione timbratura
const
  FUNZIONE = 'actInsTimbraturaOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  with W018DM.selT105 do
  begin
    Append;
    FieldByName('OPERAZIONE').AsString:='I';
    FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    FieldByName('DATA').AsDateTime:=Richiesta.Data;
    FieldByName('ORA').AsString:=Richiesta.Ora;
    FieldByName('VERSO').AsString:=Richiesta.Verso;
    FieldByName('CAUSALE').AsString:=Richiesta.Causale;
    FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
    FieldByName('RILEVATORE_RICH').AsString:=Richiesta.Rilevatore;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // imposta le note per valutazione condizioni validità
  if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'I' then
    C018.Note:=Trim((grdTimbrature.medpCompCella(0,'NOTE',0) as TmeIWMemo).Text)
  else if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'M' then
    C018.Note:=MemoText
  else if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'C' then
    C018.Note:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    ConfermaInsRichiesta;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.actVarTimbraturaOK;
// inserimento richiesta di modifica timbratura
const
  FUNZIONE = 'actVarTimbraturaOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  with W018DM do
  begin
    selT105.Append;
    selT105.FieldByName('OPERAZIONE').AsString:='M';
    selT105.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    selT105.FieldByName('DATA').AsDateTime:=selT100ModifTimb.FieldByName('DATA').AsDateTime;
    selT105.FieldByName('ORA').AsString:=selT100ModifTimb.FieldByName('ORA').AsString;
    selT105.FieldByName('VERSO_ORIG').AsString:=selT100ModifTimb.FieldByName('VERSO').AsString;
    selT105.FieldByName('CAUSALE_ORIG').AsString:=selT100ModifTimb.FieldByName('CAUSALE').AsString;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    // è necessario salvare il rilevatore della timbratura originale per le successive
    // considerazioni in fase di importazione
    selT105.FieldByName('RILEVATORE_ORIG').AsString:=selT100ModifTimb.FieldByName('RILEVATORE').AsString;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
    selT105.FieldByName('VERSO').AsString:=Richiesta.Verso;
    selT105.FieldByName('CAUSALE').AsString:=Richiesta.Causale;
    selT105.FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // imposta le note per valutazione condizioni validità
  if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'I' then
    C018.Note:=Trim((grdTimbrature.medpCompCella(0,'NOTE',0) as TmeIWMemo).Text)
  else if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'M' then
    C018.Note:=MemoText
  else if W018DM.selT105.FieldByName('OPERAZIONE').AsString = 'C' then
    C018.Note:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    ConfermaInsRichiesta;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.actCanTimbraturaOK;
// controlli ok -> inserimento record di richiesta cancellazione
const
  FUNZIONE = 'actCanTimbraturaOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  with W018DM do
  begin
    selT105.Append;
    selT105.FieldByName('OPERAZIONE').AsString:='C';
    selT105.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    selT105.FieldByName('DATA').AsDateTime:=selT100ModifTimb.FieldByName('DATA').AsDateTime;
    selT105.FieldByName('ORA').AsString:=selT100ModifTimb.FieldByName('ORA').AsString;
    selT105.FieldByName('VERSO').AsString:=selT100ModifTimb.FieldByName('VERSO').AsString;
    selT105.FieldByName('CAUSALE').AsString:=selT100ModifTimb.FieldByName('CAUSALE').AsString;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    // è necessario salvare il rilevatore della timbratura originale per le successive
    // considerazioni in fase di importazione
    selT105.FieldByName('RILEVATORE_ORIG').AsString:=selT100ModifTimb.FieldByName('RILEVATORE').AsString;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#62.ini
  // pulisce le note per valutazione condizioni validità
  C018.Note:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#62.fine

  if not C018.WarningRichiesta then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + #13#10'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    ConfermaInsRichiesta;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.ConfermaInsRichiesta;
var
  Res,IdIns,NumScartate,NumRichieste: Integer;
  TmpMsgOperazione,ErrMsg: String;
const
  FUNZIONE = 'ConfermaInsRichiesta';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Res:=0;
  with W018DM.selT105 do
  begin
    try
      if FieldByName('OPERAZIONE').AsString = 'I' then
        MemoText:=Trim((grdTimbrature.medpCompCella(0,'NOTE',0) as TmeIWMemo).Text)
      else if FieldByName('OPERAZIONE').AsString = 'C' then
        MemoText:='';
      Res:=C018.InsRichiesta('D',MemoText,'');
      IdIns:=C018.Id;

      // salva messaggio operazione, che a seguito del "Cancel" viene pulito per effetto del CalcFields
      TmpMsgOperazione:=C018.MessaggioOperazione;
      if TmpMsgOperazione <> '' then
      begin
        Cancel;
        IdIns:=0;
        raise Exception.Create(TmpMsgOperazione);
      end;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        if State = dsInsert then
          Cancel;
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della richiesta fallito!'#13#10'Motivo: ' + E.Message);
      end;
    end;
  end;

  // Se è prevista l'acquisizione automatica, e la richiesta è subito autorizzata automaticamente, si procede con la sua acquisizione
  if (IdIns > 0) and
     (C018.StatoRichiesta <> '') then
  begin
    if not A023MW.AcquisizioneRichiesteAuto(C018.Id.ToString,ErrMsg,NumScartate,NumRichieste) then
    begin
      if ErrMsg <> '' then
        MsgBox.AddMessage(ErrMsg);
    end;
  end;

  // se la richiesta è stata autorizzata automaticamente include nel filtro anche le autorizzate
  if (Res > 0) and (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto <> 'S') then
    C018.IncludiTipoRichieste(trAutorizzate);

  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
  MsgBox.ShowMessages;
end;

procedure TW018FRichiestaTimbrature.AnnullaInsRichiesta;
const
  FUNZIONE = 'AnnullaInsRichiesta';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  W018DM.selT105.Cancel;
  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.DistruggiOggetti;
const
  FUNZIONE = 'DistruggiOggetti';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // dealloca componenti creati
  FreeAndNil(W018DM);
  if A023MW <> nil then
    FreeAndNil(A023MW);

  SetLength(ArrMotivazioni,0);
  SetLength(ArrCausali,0);

  // dataset
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT275);
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.edtDataFiltroSubmit(Sender: TObject);
const
  FUNZIONE = 'edtDataFiltroSubmit';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  btnVisualizzaClick(nil);

  Log('Traccia',FUNZIONE + ': fine');
end;

end.

