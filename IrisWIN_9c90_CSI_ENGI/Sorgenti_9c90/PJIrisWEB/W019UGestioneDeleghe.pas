unit W019UGestioneDeleghe;

interface

uses
  R010UPAGINAWEB, A000UMessaggi, W000UMessaggi, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UCostanti,
  IWApplication, IWAppForm, SysUtils, Classes, Controls, Math,  Variants, Forms,
  DB, Oracle, StrUtils,
  IWBaseHTMLControl, IWCompListbox, IWCompEdit, IWCompButton,
  IWControl, DBClient, medpIWDBGrid, meIWEdit, meIWLabel, meIWButton,
  meIWImageFile, meIWGrid,meIWComboBox, IWCompGrids, IWCompExtCtrls,
  IWDBGrids, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWHTMLControls, meIWLink, OracleData, Generics.Collections;

type
  TUtente = record
    NomeProfilo: String;
    InizioValidita: TDateTime;
    FineValidita: TDateTime;
    Permessi: String;
    FiltroFunzioni: String;
    FiltroAnagrafe: String;
    FiltroDizionario: String;
    IterAutorizzativi: String;
  end;

  TUtenteDaDelegare = record
    NomeUtente: String;
    Cognome: String;
    Nome:String;
  end;

  TDeleghe = record
    RowID: String;
    Utente: String;
    Cognome: String;
    Nome: String;
    Profilo: String;
    Permessi: String;
    FiltroFunzioni: String;
    FiltroAnagrafe: String;
    FiltroDizionario: String;
    Dal: TDateTime;
    Al: TDateTime;
  end;

  TVarPers = record
    Nome: String;
    Tipo: Integer;
    Valore: Variant;
    constructor Create(PNome: String; PTipo: Integer; PValore: Variant); overload;
  end;

  TW019FGestioneDeleghe = class(TR010FPaginaWeb)
    grdDeleghe: TmedpIWDBGrid;
    cdsI061: TClientDataSet;
    dsrI061: TDataSource;
    lblCognomeCerca: TmeIWLabel;
    edtCognomeCerca: TmeIWEdit;
    lblMatricolaCerca: TmeIWLabel;
    edtMatricolaCerca: TmeIWEdit;
    edtUserCerca: TmeIWEdit;
    lblUserCerca: TmeIWLabel;
    btnFiltra: TmeIWButton;
    edtProfiloAttuale: TmeIWEdit;
    lblProfiloAttuale: TmeIWLabel;
    lblInfoDelegati: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnFiltraClick(Sender: TObject);
    procedure grdDelegheRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdDelegheAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure edtCognomeCercaSubmit(Sender: TObject);
  private
    ElencoComboUtenti:array of TUtenteDaDelegare;
    DataDal,DataAl:TDateTime;
    Operatore: TUtente;
    Operazione,UtenteDelegato, ProfiloAssegnato: String;
    FiltroDaEseguire: Boolean;
    StileCella1, StileCella2: String;
    lstVarPers: Generics.Collections.TList<TVarPers>;
    procedure FiltraComboUtenti;
    procedure GetDeleghe;
    function  ControlliInserimentoOK(cmbUtente:TmeIWComboBox; edtProfilo,edtDal,edtAl:TmeIWEdit): Boolean;
    function  ControlliModificaOK(edtDal,edtAl:TmeIWEdit): Boolean;
    procedure imgCancellaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    function  ModificaDati(FN:String):Boolean;
    procedure InserisciDelega;
    procedure CaricaComboUtenteInserimento(IndexColumn:Integer);
    procedure ConfermaSI;
    procedure DBGridColumnClick(ASender:TObject; const AValue:string);
    procedure TrasformaComponenti(FN:String;DaTestoAControlli: Boolean);
    procedure AbilitaFiltro(Abilita:Boolean);
    function  ComponiProfilo: String;
    procedure PopolaProfiliProposti;
    procedure imgAggiornaProfiloAsyncClick(Sender: TObject;EventParams: TStringList);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

procedure TW019FGestioneDeleghe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  medpModale:=True;

  // proposta periodo
  DataDal:=Parametri.DataLavoro;
  DataAl:=DataDal;

  // estrae i permessi dell'utente in collegamento in base all'attuale profilo
  with WR000DM.selI061PermessiUtente do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',Parametri.Operatore);
    // EMPOLI_ASL11 - chiamata 76680.ini
    SetVariable('PROFILO',Parametri.ProfiloWEB);
    // EMPOLI_ASL11 - chiamata 76680.fine
    Open;
    // EMPOLI_ASL11 - chiamata 76680.ini
    // non considerava il periodo di validità
    // se esistono più profili per l'utente, estrae le informazioni di quello attuale
    {
    if Parametri.ProfiloWEB <> '' then
      SearchRecord('NOME_PROFILO',Parametri.ProfiloWEB,[srFromBeginning]);
    }
    if RecordCount > 0 then
    begin
      // salva i dati del profilo nel periodo attuale di validita
      Operatore.NomeProfilo:=FieldByName('NOME_PROFILO').AsString;
      Operatore.InizioValidita:=FieldByName('INIZIO_VALIDITA').AsDateTime;
      Operatore.FineValidita:=FieldByName('FINE_VALIDITA').AsDateTime;
      Operatore.Permessi:=FieldByName('PERMESSI').AsString;
      Operatore.FiltroFunzioni:=FieldByName('FILTRO_FUNZIONI').AsString;
      Operatore.FiltroAnagrafe:=FieldByName('FILTRO_ANAGRAFE').AsString;
      Operatore.FiltroDizionario:=FieldByName('FILTRO_DIZIONARIO').AsString;
      Operatore.IterAutorizzativi:=FieldByName('ITER_AUTORIZZATIVI').AsString;
    end;
    Close;
    // EMPOLI_ASL11 - chiamata 76680.fine

    // visualizza i dati dell'attuale profilo
    edtProfiloAttuale.Text:=Operatore.NomeProfilo;
    edtProfiloAttuale.Hint:=Format('<html>' + A000TraduzioneStringhe(A000MSG_W019_FMT_PROFILO_VALIDO_DALAL),[DateToStr(Operatore.InizioValidita),DateToStr(Operatore.FineValidita)]);
  end;

  AbilitaFiltro(False);

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdDeleghe.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdDeleghe.medpDataSet:=WR000DM.selI061DelegheUtente;
  grdDeleghe.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_W019_MSG_NO_DELEGA);

  // popola la griglia delle deleghe
  GetDeleghe;

  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.ini
  // prepara la lista di variabili
  lstVarPers:=TList<TVarPers>.Create;
  lstVarPers.Add(TVarPers.Create('PROGRESSIVO',otInteger,Parametri.ProgressivoOper));
  lstVarPers.Add(TVarPers.Create('MATRICOLA',otString,Parametri.MatricolaOper));
  lstVarPers.Add(TVarPers.Create('NOME_UTENTE',otString,Parametri.Username));

  // indica che esiste un filtro personalizzato per gli utenti da delegare
  lblInfoDelegati.Caption:=IfThen(Parametri.CampiRiferimento.C90_FiltroDeleghe = '','','Importante: l''elenco degli utenti da delegare è filtrato in base a criteri personalizzati.');
  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.fine

  FiltroDaEseguire:=True;
end;

procedure TW019FGestioneDeleghe.RefreshPage;
begin
  GetDeleghe;
end;

procedure TW019FGestioneDeleghe.PopolaProfiliProposti;
var
  NomiProfili,Comp,Code,Prof,ProfDefault: String;
  c: Integer;
begin
  // profilo di default proposto
  if Parametri.CampiRiferimento.C90_NomeProfiloDelega <> '' then
  begin
    ProfDefault:=C190EscapeJS(ComponiProfilo);
    NomiProfili:='''' + ProfDefault  + ''','
  end
  else
  begin
    ProfDefault:='';
    NomiProfili:='';
  end;

  with WR000DM.selI061NomiProfili do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    Open;
    while not Eof do
    begin
      Prof:=C190EscapeJS(FieldByName('NOME_PROFILO').AsString);
      if Prof <> ProfDefault then
        NomiProfili:=NomiProfili + '''' + Prof + ''',';
      Next;
    end;
  end;

  // prepara autocomplete
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  if NomiProfili <> '' then
  begin
    c:=grdDeleghe.medpIndexColonna('NOME_PROFILO');
    Comp:=(grdDeleghe.medpCompCella(0,c,1)).HTMLName;
    Code:='var elementi = [' + Copy(NomiProfili,1,Length(NomiProfili) - 1) + ']; ' + CRLF +
          '$("#' + Comp +'").autocomplete({ ' + CRLF +
          '  source: elementi ' + CRLF +
          '}); ';
    Code:='try { ' +
          Code +
          '} ' +
          'catch(e) { ' +
          '  try { console.log("jqAutocomplete: " + e.message); } catch(err) {} ' +
          '}';
    jQAutocomplete.OnReady.Add(Code);
  end;
end;

function TW019FGestioneDeleghe.ControlliInserimentoOK(cmbUtente:TmeIWComboBox; edtProfilo,edtDal,edtAl:TmeIWEdit): Boolean;
// Controlli per la validazione dell'inserimento
var
  OldDataDal, OldDataAl: TDateTime;
  DataAttuale: TDateTime;
  Msg: String;
begin
  Result:=False;
  DataAttuale:=Date;

  // utente delegato
  if cmbUtente.Items.Count = 0 then
  begin
    if FiltroDaEseguire then
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_RICHIESTA_FILTRO),[btnFiltra.Caption])
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_LISTA_USR_VUOTA),[btnFiltra.Caption]);
    GGetWebApplicationThreadVar.ShowMessage(Msg);
    ActiveControl:=edtCognomeCerca;
    Exit;
  end;

  if (cmbUtente.ItemIndex < 0) or
     (cmbUtente.Text = '') then
  begin
    Msg:=A000TraduzioneStringhe(A000MSG_W019_MSG_SELEZIONARE_USR_DELEGA);
    GGetWebApplicationThreadVar.ShowMessage(Msg);
    ActiveControl:=cmbUtente;
    Exit;
  end;
  UtenteDelegato:=cmbUtente.Items.ValueFromIndex[cmbUtente.ItemIndex];

  // profilo rinominato
  if Trim(edtProfilo.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W019_MSG_PROFILO_DA_ASSEGNARE));
    ActiveControl:=edtProfilo;
    Exit;
  end;
  ProfiloAssegnato:=Trim(edtProfilo.Text);

  // cerca il profilo (che potrebbe essere stato digitato a mano)
  if WR000DM.selI061NomiProfili.SearchRecord('NOME_PROFILO',ProfiloAssegnato,[srIgnoreCase, srFromBeginning]) then
  begin
    edtProfilo.Text:=WR000DM.selI061NomiProfili.FieldByName('NOME_PROFILO').AsString;
    ProfiloAssegnato:=edtProfilo.Text;
  end;

  // verifica se il profilo appartiene originariamente all'operatore delegato
  // non considera il periodo di validità ma è voluto così
  with WR000DM.selI061ProfiloAssegnato do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',UtenteDelegato);
    SetVariable('PROFILO',ProfiloAssegnato);
    Open;
    if RecordCount > 0 then
    begin
      // errore: il profilo è già assegnato "nativamente" all'operatore
      GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_PROFILO_ASSEGNATO),[UtenteDelegato]));
      ActiveControl:=edtProfilo;
      Exit;
    end;
    Close;
  end;

  // inizio periodo
  if not TryStrToDate(edtDal.Text,DataDal) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO));
    ActiveControl:=edtDal;
    Exit;
  end;

  // fine periodo
  if not TryStrToDate(edtAl.Text,DataAl) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO));
    ActiveControl:=edtAl;
    Exit;
  end;

  // validità periodo: consecutività delle date
  if DataDal > DataAl then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
    ActiveControl:=edtAl;
    Exit;
  end;

  // validità periodo: il periodo non deve essere passato
  if DataDal < DataAttuale then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_DELEGA));
    ActiveControl:=edtDal;
    Exit;
  end;

  // validità periodo: il periodo delegato non deve essere esterno al proprio periodo di validità attuale
  if (DataDal < Operatore.InizioValidita) or (DataAl > Operatore.FineValidita) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_VALIDITA_PROFILO),[DateToStr(Operatore.InizioValidita),DateToStr(Operatore.FineValidita)]));
    ActiveControl:=edtProfilo;
    Exit;
  end;

  // verifica se esiste già una delega dello stesso profilo in un periodo intersecante
  with WR000DM.selI061DelegheEsistenti do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',UtenteDelegato);
    SetVariable('PROFILO',ProfiloAssegnato);
    SetVariable('DATA_DAL',DataDal);
    SetVariable('DATA_AL',DataAl);
    Open;
    if RecordCount = 1 then
    begin
      // il profilo è già stato delegato all'utente in uno (e uno solo) periodo intersecante
      OldDataDal:=FieldByName('INIZIO_VALIDITA').AsDateTime;
      OldDataAl:=FieldByName('FINE_VALIDITA').AsDateTime;

      Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_PROFILO_GIA_DELEGATO),[UtenteDelegato,DateToStr(OldDataDal),DateToStr(OldDataAl)]);

      // verifica modifiche al periodo
      if (DataDal = OldDataDal) and (DataAl = OldDataAl) then
      begin
          // stesso periodo: errore!
          GGetWebApplicationThreadVar.ShowMessage(Msg + '!');
          ActiveControl:=edtProfilo;
          Exit;
      end
      else if DataDal = OldDataDal then
      begin
        // data inizio uguale: chiede conferma
        Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_DELEGA_SOVRASCITTA),
                   [IfThen(DataAl > OldDataAl,A000TraduzioneStringhe(A000MSG_W019_MSG_POSTICIPATO),A000TraduzioneStringhe(A000MSG_W019_MSG_ANTICIPATO)),
                   DateToStr(DataAl)]);
        Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
        Exit;
      end
      else if DataAl = OldDataAl then
      begin
        // data fine uguale:
        // blocca se si sta posticipando una delega attualmente in corso di validità
        // altrimenti chiede conferma
        if (DataAttuale >= OldDataDal) and
           (DataAttuale < DataDal) then
        begin
          Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_NO_POSTICIPARE),[DateToStr(DataDal)]);
          GGetWebApplicationThreadVar.ShowMessage(Msg);
        end
        else
        begin
          Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_SOVRASCRIVI_DELEGA),
                     [IfThen(DataDal > OldDataDal,A000TraduzioneStringhe(A000MSG_W019_MSG_POSTICIPATO),A000TraduzioneStringhe(A000MSG_W019_MSG_ANTICIPATO)),DateToStr(DataDal)]);
          Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
        end;
        Exit;
      end
      else
      begin
        // periodo interno / esterno
        // blocca se si sta posticipando una delega attualmente in corso di validità
        if (DataAttuale >= OldDataDal) and
           (DataAttuale < DataDal) then
        begin
          Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_NO_POSTICIPARE),[DateToStr(DataDal)]);
          MsgBox.MessageBox(Msg,INFORMA);
        end
        else
        begin
          Msg:=Msg + A000TraduzioneStringhe(A000MSG_W019_MSG_SOVRASCRIVI_DELEGA2);
          Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
        end;
        Exit;
      end;
    end
    else if RecordCount > 1 then
    begin
      // il periodo interseca più deleghe dello stesso profilo: nessuna azione possibile
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_DELEGATO_N_VOLTE),[UtenteDelegato,IntToStr(RecordCount),DateToStr(DataDal),DateToStr(DataAl)]);
      MsgBox.MessageBox(Msg,INFORMA);
      ActiveControl:=edtDal;
      Exit;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TW019FGestioneDeleghe.ControlliModificaOK(edtDal,edtAl:TmeIWEdit): Boolean;
var
  OldDataDal, OldDataAl: TDateTime;
  DataAttuale: TDateTime;
  Msg: String;
begin
  Result:=False;
  DataAttuale:=Trunc(R180SysDate(SessioneOracle));
  UtenteDelegato:=WR000DM.selI061DelegheUtente.FieldByName('NOME_UTENTE').AsString;
  ProfiloAssegnato:=WR000DM.selI061DelegheUtente.FieldByName('NOME_PROFILO').AsString;

  // inizio periodo
  if not TryStrToDate(edtDal.Text,DataDal) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO),INFORMA);
    ActiveControl:=edtDal;
    Exit;
  end;

  // fine periodo
  if not TryStrToDate(edtAl.Text,DataAl) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO),INFORMA);
    ActiveControl:=edtAl;
    Exit;
  end;

  // validità periodo: consecutività delle date
  if DataDal > DataAl then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO),INFORMA);
    ActiveControl:=edtAl;
    Exit;
  end;

  // validità periodo: il periodo non deve essere passato
  if (DataDal <> WR000DM.selI061DelegheUtente.FieldByName('INIZIO_VALIDITA').AsDateTime) and
     (DataDal < DataAttuale) then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_DELEGA),INFORMA);
    ActiveControl:=edtDal;
    Exit;
  end;

  // validità periodo: il periodo delegato non deve essere esterno al proprio periodo di validità
  if (DataDal < Operatore.InizioValidita) or (DataAl > Operatore.FineValidita) then
  begin
    MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_VALIDITA_PROFILO),[DateToStr(Operatore.InizioValidita),DateToStr(Operatore.FineValidita)]),INFORMA);
    Exit;
  end;

  // verifica se esiste già una delega dello stesso profilo in un periodo intersecante
  with WR000DM.selI061DelegheEsistenti do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',UtenteDelegato);
    SetVariable('PROFILO',ProfiloAssegnato);
    SetVariable('DATA_DAL',DataDal);
    SetVariable('DATA_AL',DataAl);
    Open;
    if RecordCount = 1 then
    begin
      if RowId <> WR000DM.selI061DelegheUtente.RowId then
      begin
        // il profilo è già stato delegato all'utente in uno (e uno solo) periodo intersecante
        OldDataDal:=FieldByName('INIZIO_VALIDITA').AsDateTime;
        OldDataAl:=FieldByName('FINE_VALIDITA').AsDateTime;

        Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_PROFILO_GIA_DELEGATO),[UtenteDelegato,DateToStr(OldDataDal),DateToStr(OldDataAl)]);

        // verifica modifiche al periodo
        if (DataDal = OldDataDal) and (DataAl = OldDataAl) then
        begin
            // stesso periodo: errore!
            MsgBox.MessageBox(Msg + '!',INFORMA);
            Exit;
        end
        else if DataDal = OldDataDal then
        begin
          // data inizio uguale: chiede conferma
          Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_DELEGA_SOVRASCITTA),
                     [IfThen(DataAl > OldDataAl,A000TraduzioneStringhe(A000MSG_W019_MSG_POSTICIPATO),A000TraduzioneStringhe(A000MSG_W019_MSG_ANTICIPATO)),DateToStr(DataAl)]);
          Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
          Exit;
        end
        else if DataAl = OldDataAl then
        begin
          // data fine uguale:
          // blocca se si sta posticipando una delega attualmente in corso di validità
          // altrimenti chiede conferma
          if (DataAttuale >= OldDataDal) and
             (DataAttuale < DataDal) then
          begin
            Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_NO_POSTICIPARE),[DateToStr(DataDal)]);
            MsgBox.MessageBox(Msg,INFORMA);
          end
          else
          begin
            Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_SOVRASCRIVI_DELEGA),
                       [IfThen(DataDal > OldDataDal,A000TraduzioneStringhe(A000MSG_W019_MSG_POSTICIPATO),A000TraduzioneStringhe(A000MSG_W019_MSG_ANTICIPATO)),DateToStr(DataDal)]);
            Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
          end;
          Exit;
        end
        else
        begin
          // periodo interno / esterno
          // blocca se si sta posticipando una delega attualmente in corso di validità
          if (DataAttuale >= OldDataDal) and
             (DataAttuale < DataDal) then
          begin
            Msg:=Msg + Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_NO_POSTICIPARE),[DateToStr(DataDal)]);
            MsgBox.MessageBox(Msg,INFORMA);
          end
          else
          begin
            Msg:=Msg + A000TraduzioneStringhe(A000MSG_W019_MSG_SOVRASCRIVI_DELEGA2);
            Messaggio(A000TraduzioneStringhe(A000MSG_W019_MSG_PERIODO_MODIFICA),Msg,ConfermaSI,nil);
          end;
          Exit;
        end;
      end;
    end
    else if RecordCount > 1 then
    begin
      // il periodo interseca più deleghe dello stesso profilo: nessuna azione possibile
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_DELEGATO_N_VOLTE),
           [UtenteDelegato,IntToStr(RecordCount),DateToStr(DataDal),DateToStr(DataAl)]);
      MsgBox.MessageBox(Msg,INFORMA);
      ActiveControl:=edtDal;
      Exit;
    end;
  end;

  if not WR000DM.selI061DelegheUtente.FieldByName('ULTIMO_ACCESSO').IsNull then
  begin
    if DataDal <> WR000DM.selI061DelegheUtente.FieldByName('INIZIO_VALIDITA').AsDateTime then
    begin
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_ACCESSO_EFFETTUATO),[WR000DM.selI061DelegheUtente.FieldByName('ULTIMO_ACCESSO').AsString]),INFORMA);
      edtDal.Text:=WR000DM.selI061DelegheUtente.FieldByName('INIZIO_VALIDITA').AsString;
      Exit;
    end
    else if DataAl < Trunc(WR000DM.selI061DelegheUtente.FieldByName('ULTIMO_ACCESSO').AsDateTime) then
    begin
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_ACCESSO_EFFETTUATO2),[WR000DM.selI061DelegheUtente.FieldByName('ULTIMO_ACCESSO').AsString]),INFORMA);
      Exit;
    end;
  end;

  // controlli ok
  Result:=True;
end;

procedure TW019FGestioneDeleghe.InserisciDelega;
// Inserisce il record di delega del profilo
begin
  with WR000DM.selI061DelegheUtente do
  begin
    Append;
    FieldByName('AZIENDA').AsString:=Parametri.Azienda;
    FieldByName('NOME_UTENTE').AsString:=UtenteDelegato;
    FieldByName('NOME_PROFILO').AsString:=ProfiloAssegnato;
    FieldByName('PERMESSI').AsString:=Operatore.Permessi;
    FieldByName('FILTRO_FUNZIONI').AsString:=Operatore.FiltroFunzioni;
    FieldByName('FILTRO_ANAGRAFE').AsString:=Operatore.FiltroAnagrafe;
    FieldByName('FILTRO_DIZIONARIO').AsString:=Operatore.FiltroDizionario;
    FieldByName('ITER_AUTORIZZATIVI').AsString:=Operatore.IterAutorizzativi;
    FieldByName('INIZIO_VALIDITA').AsDateTime:=DataDal;
    FieldByName('FINE_VALIDITA').AsDateTime:=DataAl;
    FieldByName('DELEGATO_DA').AsString:=Parametri.Operatore;
    try
      Post;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_INS_FALLITO),[E.Message]));
        Cancel;
      end;
    end;
  end;
end;

function TW019FGestioneDeleghe.ModificaDati(FN:String):Boolean;
var
  i:Integer;
begin
  Result:=False;
  i:=grdDeleghe.medpRigaDiCompGriglia(FN);

  with WR000DM.selI061DelegheUtente do
  begin
    Edit;
    FieldByName('INIZIO_VALIDITA').AsString:=(grdDeleghe.medpCompCella(i,'INIZIO_VALIDITA',0) as TmeIWEdit).Text;
    FieldByName('FINE_VALIDITA').AsString:=(grdDeleghe.medpCompCella(i,'FINE_VALIDITA',0) as TmeIWEdit).Text;

    try
      RegistraLog.SettaProprieta('M','I061_PROFILI_DIPENDENTE',medpCodiceForm,nil,True);
      Post;
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
      on E:Exception do
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_VARIAZIONE_FALLITA),[e.Message]));
    end;
  end;
end;

procedure TW019FGestioneDeleghe.AbilitaFiltro(Abilita:Boolean);
begin
  edtCognomeCerca.Enabled:=Abilita;
  edtMatricolaCerca.Enabled:=Abilita;
  edtUserCerca.Enabled:=Abilita;
  btnFiltra.Enabled:=Abilita;
end;

procedure TW019FGestioneDeleghe.ConfermaSI;
// gestione del messaggio di conferma in caso di risposta SI
begin
  // elimina il record precedente e ne reinserisce uno nuovo
  WR000DM.selI061DelegheEsistenti.Delete;
  InserisciDelega;

  GetDeleghe;
end;

procedure TW019FGestioneDeleghe.btnFiltraClick(Sender: TObject);
begin
  if // TORINO_CSI - commessa 2014/175 SVILUPPO#1.ini
     // non dà messaggio se esiste un filtro personalizzato
     (Parametri.CampiRiferimento.C90_FiltroDeleghe = '') and
     // TORINO_CSI - commessa 2014/175 SVILUPPO#1.fine
     (Trim(edtCognomeCerca.Text) = '') and
     (Trim(edtMatricolaCerca.Text) = '') and
     (Trim(edtUserCerca.Text) = '') then
  begin
    Messaggio(A000TraduzioneStringhe(A000MSG_MSG_CONFERMA),
              A000TraduzioneStringhe(A000MSG_W019_MSG_PARAM_RICERCA),FiltraComboUtenti,nil);
    Exit;
  end;
  FiltraComboUtenti;
end;

procedure TW019FGestioneDeleghe.FiltraComboUtenti;
var
  Operatore: String;
  Filtro: String;
  i:Integer;
  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.ini
  FiltroAnagrafiche, Tempo, ErrMsg: String;
  VarPers: TVarPers;
  idxVarFiltro: Integer;
  idxVarDataset: Integer;
  T1: TDateTime;
  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.fine
begin
  // prepara il filtro su cognome, matricola e username (filtri in "or")
  Filtro:='';
  if Trim(edtCognomeCerca.Text) <> '' then
  begin
    Operatore:=IfThen(Pos('%',edtCognomeCerca.Text) > 0,'LIKE','=');
    Filtro:='(COGNOME ' + Operatore + ' ''' + edtCognomeCerca.Text + ''')';
  end;
  if Trim(edtMatricolaCerca.Text) <> '' then
  begin
    Operatore:=IfThen(Pos('%',edtMatricolaCerca.Text) > 0,'LIKE','=');
    Filtro:=IfThen(Filtro <> '',Filtro + ' OR ') +
            '(I060.MATRICOLA ' + Operatore + ' ''' + edtMatricolaCerca.Text + ''')';
  end;
  if Trim(edtUserCerca.Text) <> '' then
  begin
    Operatore:=IfThen(Pos('%',edtUserCerca.Text) > 0,'LIKE','=');
    Filtro:=IfThen(Filtro <> '',Filtro + ' OR ') +
            '(NOME_UTENTE ' + Operatore + ' ''' + edtUserCerca.Text + ''')';
  end;
  Filtro:=IfThen(Filtro <> '','AND (' + Filtro + ')');

  // popolamento combo utenti
  SetLength(ElencoComboUtenti,0);
  i:=0;
  with WR000DM.selI060Utenti do
  begin
    Close;
    ClearVariables;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',Parametri.Operatore);
    SetVariable('FILTRO',Filtro);

    // TORINO_CSI - commessa 2014/175 SVILUPPO#1.ini
    // filtro anagrafiche personalizzato
    FiltroAnagrafiche:=Parametri.CampiRiferimento.C90_FiltroDeleghe;
    if FiltroAnagrafiche <> '' then
    begin
      // determina la presenza di bind variables nel filtro e le valorizza
      with FindVariables(FiltroAnagrafiche,False) do
      begin
        try
          for VarPers in lstVarPers do
          begin
            idxVarFiltro:=IndexOf(VarPers.Nome);
            idxVarDataset:=VariableIndex(VarPers.Nome);
            if idxVarFiltro >= 0 then
            begin
              // variabile presente nel filtro
              // 1. verifica se necessario dichiararla nel dataset
              if idxVarDataset < 0 then
                DeclareVariable(VarPers.Nome,VarPers.Tipo);
              // 2. imposta valore
              SetVariable(VarPers.Nome,VarPers.Valore);
            end
            else
            begin
              // variabile non presente nel filtro
              // se è dichiarata nel dataset la elimina
              if idxVarDataset >= 0 then
                DeleteVariable(VarPers.Nome);
            end;
          end;
        finally
          Free;
        end;
      end;
    end;
    FiltroAnagrafiche:=IfThen(FiltroAnagrafiche <> '','AND (' + FiltroAnagrafiche + ')');
    SetVariable('FILTRO_ANAGRAFICHE',FiltroAnagrafiche);
    try
      DebugAdd('Filtro personalizzato:');
      DebugAdd(VarToStr(GetVariable('FILTRO_ANAGRAFICHE')));
      T1:=Now;
      Open;
      Tempo:=FormatDateTime('ss.zzz',Now - T1);
      DebugAdd('----');
      DebugAdd('Tempo esecuzione query: ' + Tempo);
    except
      on E: Exception do
      begin
        ErrMsg:=Format('Si è verificato un errore nell''applicazione del filtro personalizzato'#13#10 +
                       'per gli utenti delegabili:'#13#10 +
                       '%s (%s).',[E.Message,E.ClassName]);
        try
          // tenta apertura dataset escludendo il filtro personalizzato
          // 1. elimina eventuali variabili personalizzate
          for VarPers in lstVarPers do
          begin
            if VariableIndex(VarPers.Nome) >= 0 then
              DeleteVariable(VarPers.Nome);
          end;
          // 2. annulla la variabile substitution per il filtro anagrafiche
          SetVariable('FILTRO_ANAGRAFICHE','');
          Open;
        except
          on E: Exception do
          begin
            // se fallisce anche questo tentativo segnala errore
            MsgBox.MessageBox(ErrMsg,ESCLAMA);
            Exit;
          end;
        end;
        // informa che il filtro è errato e non viene applicato
        ErrMsg:=ErrMsg + #13#10'Il filtro personalizzato non sarà pertanto applicato.'#13#10 + 'Si prega di segnalare questa anomalia.';
        MsgBox.MessageBox(Format(ErrMsg,[E.Message,E.ClassName]),INFORMA);
      end;
    end;
    // TORINO_CSI - commessa 2014/175 SVILUPPO#1.fine
    while not Eof do
    begin
      SetLength(ElencoComboUtenti,i + 1);
      // aggiunge item alla combo di scelta utente
      ElencoComboUtenti[i].NomeUtente:=FieldByName('NOME_UTENTE').AsString;
      ElencoComboUtenti[i].Cognome:=FieldByName('COGNOME').AsString;
      ElencoComboUtenti[i].Nome:=FieldByName('NOME').AsString;

      Next;
      i:=i + 1;
    end;

    if Operazione = 'I' then
    begin
      CaricaComboUtenteInserimento(grdDeleghe.medpIndexColonna('NOME_UTENTE'));
      PopolaProfiliProposti;
    end;

    if RecordCount = 0 then
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W019_MSG_NO_UTENTE_WEB));

    Close;
  end;
  FiltroDaEseguire:=False;
end;

procedure TW019FGestioneDeleghe.imgCancellaClick(Sender: TObject);
// cancella il record selezionato
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  WR000DM.selI061DelegheUtente.Refresh;

  DBGridColumnClick(Sender,FN);
  // posizionamento sul record corrispondente ed eliminazione
  with WR000DM.selI061DelegheUtente do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      // cancellazione permessa solo se non sono stati effettuati accessi con questo profilo
      if FieldByName('ULTIMO_ACCESSO').IsNull then
      begin
        Delete;
        SessioneOracle.Commit;
        // ripopola la griglia delle deleghe
        GetDeleghe;
      end
      else
        GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W019_PARAM_CANCELLARE),[FieldByName('ULTIMO_ACCESSO').AsString]));
    end;
  end;
end;

procedure TW019FGestioneDeleghe.imgInserisciClick(Sender: TObject);
// inserisci
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);
  Operazione:='I';
  AbilitaFiltro(True);
  TrasformaComponenti(FN,True);
  grdDeleghe.medpBrowse:=False;
end;

procedure TW019FGestioneDeleghe.imgModificaClick(Sender: TObject);
// modifica il record selezionato
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);
  Operazione:='M';
  TrasformaComponenti(FN, True);
  grdDeleghe.medpBrowse:=False;
end;

procedure TW019FGestioneDeleghe.imgAnnullaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);
  grdDeleghe.medpBrowse:=True;
  AbilitaFiltro(False);
  TrasformaComponenti(FN,False);
  Operazione:='';
end;

procedure TW019FGestioneDeleghe.imgConfermaClick(Sender: TObject);
var
  i:Integer;
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  WR000DM.selI061DelegheUtente.Refresh;
  DBGridColumnClick(Sender,FN);

  i:=grdDeleghe.medpRigaDiCompGriglia(FN);

  if Operazione = 'M' then
  begin
    if not ControlliModificaOK((grdDeleghe.medpCompCella(i,'INIZIO_VALIDITA',0) as TmeIWEdit),
                               (grdDeleghe.medpCompCella(i,'FINE_VALIDITA',0) as TmeIWEdit)) then
    Exit;

    ModificaDati(FN);
  end
  else
  begin
    if not ControlliInserimentoOK((grdDeleghe.medpCompCella(i,'NOME_UTENTE',0) as TmeIWComboBox),
                                  (grdDeleghe.medpCompCella(i,'NOME_PROFILO',1) as TmeIWEdit),
                                  (grdDeleghe.medpCompCella(i,'INIZIO_VALIDITA',0) as TmeIWEdit),
                                  (grdDeleghe.medpCompCella(i,'FINE_VALIDITA',0) as TmeIWEdit)) then
    Exit;
    // inserisce il nuovo record
    InserisciDelega;
    AbilitaFiltro(False);
  end;

  Operazione:='';
  GetDeleghe;
end;

function TW019FGestioneDeleghe.ComponiProfilo: String;
var
  Delegato: String;
  Comp: TmeIWComboBox;
  Comp2: TmeIWEdit;
  ODS: TOracleDataset;
begin
  // determina il profilo da proporre in fase di inserimento
  if Parametri.CampiRiferimento.C90_NomeProfiloDelega = '' then
    Result:=Parametri.ProfiloWEB
  else
  begin
    Result:=Parametri.CampiRiferimento.C90_NomeProfiloDelega;
    ODS:=TOracleDataSet.Create(nil);
    try
      try
        ODS.Session:=SessioneOracle;

        // stringa da estrarre
        ODS.DeclareVariable('S',otSubst);
        ODS.SetVariable('S',Result);

        // delegante
        if Pos(':DELEGANTE',Result) > 0 then
        begin
          ODS.DeclareVariable('DELEGANTE',otString);
          ODS.SetVariable('DELEGANTE',Parametri.Operatore);
        end;
        // delegato
        if Pos(':DELEGATO',Result) > 0 then
        begin
          ODS.DeclareVariable('DELEGATO',otString);
          Comp:=(grdDeleghe.medpCompCella(0,'NOME_UTENTE',0) as TmeIWComboBox);
          if Comp = nil then
            Delegato:=''
          else
            Delegato:=Comp.Text;
          ODS.SetVariable('DELEGATO',Delegato);
        end;
        // profilo
        if Pos(':PROFILO',Result) > 0 then
        begin
          ODS.DeclareVariable('PROFILO',otString);
          ODS.SetVariable('PROFILO',Parametri.ProfiloWEB);
        end;
        // dal
        if Pos(':DAL',Result) > 0 then
        begin
          ODS.DeclareVariable('DAL',otDate);
          Comp2:=(grdDeleghe.medpCompCella(0,'INIZIO_VALIDITA',0) as TmeIWEdit);
          if Comp2 = nil then
            ODS.SetVariable('DAL',null)
          else
            ODS.SetVariable('DAL',StrToDateTime(Comp2.Text));
        end;
        // al
        if Pos(':AL',Result) > 0 then
        begin
          ODS.DeclareVariable('AL',otDate);
          Comp2:=(grdDeleghe.medpCompCella(0,'FINE_VALIDITA',0) as TmeIWEdit);
          if Comp2 = nil then
            ODS.SetVariable('AL',null)
          else
            ODS.SetVariable('AL',StrToDateTime(Comp2.Text));
        end;
        ODS.SQL.Add('select :S from DUAL');
        ODS.Open;
        if ODS.RecordCount > 0 then
          Result:=ODS.Fields[0].AsString;
        ODS.Close;
        Result:=Copy(Result,1,30);
      except
        on E:Exception do
        begin
          Log('Errore','Errore durante valutazione parametro C90_NomeProfiloDelega;Maschera profilo = ' + Parametri.CampiRiferimento.C90_NomeProfiloDelega,E);
          Result:=Parametri.ProfiloWEB;
        end;
      end;
    finally
      FreeAndNil(ODS);
    end;
  end;
end;

procedure TW019FGestioneDeleghe.imgAggiornaProfiloAsyncClick(Sender: TObject;EventParams: TStringList);
var
  Profilo: String;
begin
  Profilo:=ComponiProfilo;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(Format('FindElem("EDTPROFILO").value = "%s"',[Profilo]));
end;

procedure TW019FGestioneDeleghe.CaricaComboUtenteInserimento(IndexColumn:Integer);
var
  i:Integer;
  Item:String;
begin
  if grdDeleghe.medpCompCella(0,IndexColumn,0) <> nil then
  begin
    with (grdDeleghe.medpCompCella(0,IndexColumn,0) as TmeIWComboBox) do
    begin
      ItemsHaveValues:=True;
      Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
      Items.BeginUpdate;
      Items.Clear;
      for i:=0 to Length(ElencoComboUtenti) - 1 do
      begin
        // aggiunge item alla combo di scelta utente
        Item:=StringReplace(R180DimLung(ElencoComboUtenti[i].NomeUtente, 10),' ',SPAZIO, [rfReplaceAll]);
        Item:=Item + ' - ' + ElencoComboUtenti[i].Cognome + ' ' + ElencoComboUtenti[i].Nome;
        Items.Values[Item]:=ElencoComboUtenti[i].NomeUtente;
      end;
      Items.EndUpdate;

      if Items.Count > 0 then
      begin
        RequireSelection:=True;
        ItemIndex:=0;
      end;
    end;
  end;
end;

procedure TW019FGestioneDeleghe.TrasformaComponenti(FN:String;DaTestoAControlli: Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdCambiOrari
var
  i:Integer;
  c:Integer;
begin
  if DaTestoAControlli then
  begin
    if Operazione = 'I' then
    begin
      with (grdDeleghe.medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:='invisibile';
        Cell[0,1].Css:=StileCella1;
        Cell[0,2].Css:=StileCella2;
      end;

      grdDeleghe.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'35','','','','S');
      c:=grdDeleghe.medpIndexColonna('NOME_UTENTE');
      grdDeleghe.medpCreaComponenteGenerico(0,c,grdDeleghe.Componenti);
      CaricaComboUtenteInserimento(c);

      grdDeleghe.medpPreparaComponenteGenerico('C',0,0,DBG_IMG,'','AGGIORNA','','','S');
      grdDeleghe.medpPreparaComponenteGenerico('C',0,1,DBG_EDT,'30','','','','S');
      c:=grdDeleghe.medpIndexColonna('NOME_PROFILO');
      grdDeleghe.medpCreaComponenteGenerico(0,c,grdDeleghe.Componenti);
      (grdDeleghe.medpCompCella(0,c,0) as TmeIWImageFile).OnAsyncClick:=imgAggiornaProfiloAsyncClick;

      grdDeleghe.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');

      c:=grdDeleghe.medpIndexColonna('INIZIO_VALIDITA');
      grdDeleghe.medpCreaComponenteGenerico(0,c,grdDeleghe.Componenti);
      (grdDeleghe.medpCompCella(0,c,0) as TmeIWEdit).Text:=DateTimeToStr(Parametri.DataLavoro);

      c:=grdDeleghe.medpIndexColonna('FINE_VALIDITA');
      grdDeleghe.medpCreaComponenteGenerico(0,c,grdDeleghe.Componenti);
      (grdDeleghe.medpCompCella(0,c,0) as TmeIWEdit).Text:=DateTimeToStr(Parametri.DataLavoro);

      // popolamento elenco profili da proporre
      PopolaProfiliProposti;
      with (grdDeleghe.medpCompCella(0,'NOME_PROFILO',1) as TmeIWEdit) do
      begin
        Name:='EDTPROFILO';
        MaxLength:=30;
        //Text:=ComponiProfilo;
        Hint:='<html>' + A000TraduzioneStringhe(A000MSG_W019_MASCHERA_PROFILO) + '<br>' + Parametri.CampiRiferimento.C90_NomeProfiloDelega;
        ShowHint:=True;
      end;
    end
    else //Modifica
    begin
      i:=grdDeleghe.medpRigaDiCompGriglia(FN);
      with (grdDeleghe.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:='invisibile';
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:=StileCella1;
        Cell[0,3].Css:=StileCella2;
      end;

      grdDeleghe.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','S');
      c:=grdDeleghe.medpIndexColonna('INIZIO_VALIDITA');
      grdDeleghe.medpCreaComponenteGenerico(i,c,grdDeleghe.Componenti);
      (grdDeleghe.medpCompCella(i,c,0) as TmeIWEdit).Text:=grdDeleghe.medpValoreColonna(i,'INIZIO_VALIDITA');

      c:=grdDeleghe.medpIndexColonna('FINE_VALIDITA');
      grdDeleghe.medpCreaComponenteGenerico(i,c,grdDeleghe.Componenti);
      (grdDeleghe.medpCompCella(i,c,0) as TmeIWEdit).Text:=grdDeleghe.medpValoreColonna(i,'FINE_VALIDITA');
    end;
  end
  else
  begin
    i:=grdDeleghe.medpRigaDiCompGriglia(FN);

    if Operazione = 'I' then
    begin
      with (grdDeleghe.medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=StileCella1;
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;

      c:=grdDeleghe.medpIndexColonna('NOME_UTENTE');
      FreeAndNil(grdDeleghe.medpCompgriglia[i].CompColonne[c]);

      c:=grdDeleghe.medpIndexColonna('NOME_PROFILO');
      FreeAndNil(grdDeleghe.medpCompgriglia[i].CompColonne[c]);
    end
    else
    begin
      with (grdDeleghe.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=StileCella1;
        Cell[0,1].Css:=StileCella2;
        Cell[0,2].Css:='invisibile';
        Cell[0,3].Css:='invisibile';
      end;
    end;

    c:=grdDeleghe.medpIndexColonna('INIZIO_VALIDITA');
    FreeAndNil(grdDeleghe.medpCompgriglia[i].CompColonne[c]);

    c:=grdDeleghe.medpIndexColonna('FINE_VALIDITA');

    FreeAndNil(grdDeleghe.medpCompgriglia[i].CompColonne[c]);
  end;
end;

procedure TW019FGestioneDeleghe.GetDeleghe;
begin
  grdDeleghe.medpBrowse:=True;
  with WR000DM.selI061DelegheUtente do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('UTENTE',Parametri.Operatore);
    SetVariable('DATA_LIMITE',Trunc(R180SysDate(SessioneOracle)));
    Open;
  end;
  grdDeleghe.medpCreaCDS;
  grdDeleghe.medpEliminaColonne;
  grdDeleghe.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdDeleghe.medpAggiungiColonna('NOME_UTENTE','Utente','',nil);
  grdDeleghe.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdDeleghe.medpAggiungiColonna('NOME_PROFILO','Profilo','',nil);
  grdDeleghe.medpAggiungiColonna('INIZIO_VALIDITA','Inizio validit&agrave;','',nil);
  grdDeleghe.medpAggiungiColonna('FINE_VALIDITA','Fine validit&agrave;','',nil);
  grdDeleghe.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdDeleghe.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    grdDeleghe.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
    grdDeleghe.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
    grdDeleghe.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');

    grdDeleghe.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina delega','Eliminare la delega selezionata?','S');
    grdDeleghe.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
    grdDeleghe.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
    grdDeleghe.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
  end;
  grdDeleghe.medpCaricaCDS;
end;

procedure TW019FGestioneDeleghe.grdDelegheAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i:Integer;
begin
  if not SolaLettura then
  begin
    (grdDeleghe.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdDeleghe.medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdDeleghe.medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
    with (grdDeleghe.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,1].Css:='invisibile';
      Cell[0,2].Css:='invisibile';
    end;
  end;

  for i:=IfThen(not SolaLettura,1,0) to High(grdDeleghe.medpCompGriglia) do
  begin
    //Associo l'evento OnClick alle icone dei comandi
    if (grdDeleghe.medpCompGriglia[i].CompColonne[0] <> nil) then
    begin
      (grdDeleghe.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
      (grdDeleghe.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
      (grdDeleghe.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (grdDeleghe.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
      with (grdDeleghe.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,2].Css:='invisibile';
        Cell[0,3].Css:='invisibile';
        StileCella1:=Cell[0,0].Css;
        StileCella2:=Cell[0,1].Css;
      end;
    end;
  end;
end;

procedure TW019FGestioneDeleghe.DBGridColumnClick(ASender:TObject; const AValue:string);
begin
  cdsI061.Locate('DBG_ROWID',AValue,[]);
  WR000DM.selI061DelegheUtente.SearchRecord('ROWID',AValue,[srFromBeginning]);
end;

procedure TW019FGestioneDeleghe.grdDelegheRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not grdDeleghe.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // date periodo: allineamento al centro
  if (AColumn = 4) or (AColumn = 5) then
    ACell.Alignment:=taCenter;

  NumColonna:=grdDeleghe.medpNumColonna(AColumn);
  if (ARow > 0) and (ARow <= High(grdDeleghe.medpCompGriglia) + 1)
  and (grdDeleghe.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDeleghe.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW019FGestioneDeleghe.DistruggiOggetti;
// deallocazione strutture di memoria e chiura dataset
begin
  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.ini
  FreeAndNil(lstVarPers);
  // TORINO_CSI - commessa 2014/175 SVILUPPO#1.fine

  // chiude i dataset
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selI060Utenti.CloseAll; except end;
    try WR000DM.selI061NomiProfili.CloseAll; except end;
    try WR000DM.selI061PermessiUtente.CloseAll; except end;
    try WR000DM.selI061DelegheUtente.CloseAll; except end;
    try WR000DM.selI061DelegheEsistenti.Close; except end;
  end;
end;

procedure TW019FGestioneDeleghe.edtCognomeCercaSubmit(Sender: TObject);
begin
  btnFiltraClick(nil);
end;

{ TVarPers }

constructor TVarPers.Create(PNome: String; PTipo: Integer; PValore: Variant);
begin
  Self.Nome:=PNome;
  Self.Tipo:=PTipo;
  Self.Valore:=PValore;
end;

end.

