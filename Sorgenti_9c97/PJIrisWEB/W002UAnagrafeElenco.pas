unit W002UAnagrafeElenco;

interface

uses
  Db, SysUtils, Graphics, Oracle, IWApplication,
  IWDBGrids, IWTemplateProcessorHTML, IWHTMLControls, IWForm,
  IWAppForm, IWCompLabel, IWCompEdit, IWCompButton, IWControl,
  Classes, Controls, Variants, OracleData,
  IWBaseControl, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseHTMLControl,
  ActnList, Forms, IWVCLBaseContainer, IWContainer,
  IWVCLComponent, StrUtils, Math, IWCompCheckbox, meIWCheckBox, meIWButton,
  meIWEdit, meIWLabel, meIWImageFile, meIWDBGrid, medpIWMessageDlg,
  IWCompGrids, IWCompExtCtrls, meIWLink, Menus,
  A000UCostanti, A000UMessaggi, W000UMEssaggi,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  W003UAnomalie, W003UAnomalieDM, R010UPAGINAWEB, meIWGrid;

type
  TW002FAnagrafeElenco = class(TR010FPaginaWeb)
    chkDipendentiCessati: TmeIWCheckBox;
    lblDataLavoro: TmeIWLabel;
    edtDataLavoro: TmeIWEdit;
    btnApplicaData: TmeIWButton;
    lblNomeRicerca: TmeIWLabel;
    edtNomeRicerca: TmeIWEdit;
    btnSalvaRicerca: TmeIWButton;
    btnCancellaRicerca: TmeIWButton;
    lblNumRecord: TmeIWLabel;
    imgPrimo: TmeIWImageFile;
    imgPrec: TmeIWImageFile;
    imgSucc: TmeIWImageFile;
    imgUltimo: TmeIWImageFile;
    grdAnagrafe: TmeIWDBGrid;
    lblContaRecord: TmeIWLabel;
    lblAnagrafeCaption: TmeIWLabel;
    pmnTabella: TPopupMenu;
    mnuEsportaCsv: TMenuItem;
    lnkNotifica: TmeIWLink;
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdAnagrafeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnSalvaRicercaClick(Sender: TObject);
    procedure grdAnagrafeColumnsMatricolaClick(ASender: TObject;
      const AValue: String);
    procedure imgPaginaPrimaClick(Sender: TObject);
    procedure imgPaginaPrecClick(Sender: TObject);
    procedure imgPaginaSuccClick(Sender: TObject);
    procedure imgPaginaUltimaClick(Sender: TObject);
    procedure btnCancellaRicercaClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnApplicaDataClick(Sender: TObject);
    procedure chkDipendentiCessatiClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWTemplateProcessorHTML1UnknownTag(const AName: string; var VValue: string);
    procedure mnuEsportaCsvClick(Sender: TObject);
    procedure lnkNotificaClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    NumRec,NumPagine:Integer;
    JsDipendenteSingolo: String;
    MsgW003:String;
    W003DM: TW003FAnomalieDM;
    procedure VerificaMsgDaLeggere;
    {
    procedure selT282CountThreadExecuted(Sender: TOracleQuery);
    procedure selT282CountThreadError(Sender: TOracleQuery; ErrorCode: Integer;
      const ErrorMessage: string);
    }
    procedure UpdateVistaPersonale;
    procedure AggiornaContatore;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    procedure ApriW035MsgDaLeggere;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
    // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
    procedure VerificaRichiesteScioperoPendenti;
    procedure ApriW037Notifica;
    // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine
    procedure VerificaAnomalieCartellino;
    procedure ApriW003AnomalieCartellino;
    procedure FreeW003DM;
  protected
    procedure RefreshPage; override;
    function  GetInfoFunzione: String; override;
  public
    RefreshCompleto,
    DipendenteSingolo: Boolean;
  end;

implementation

uses A000UInterfaccia, A000USessione,
     W001UIrisWebDtM, W035UMessaggistica, W037URichiestaScioperi;

{$R *.dfm}

procedure TW002FAnagrafeElenco.IWAppFormCreate(Sender: TObject);
begin
  medpFissa:=True;
  inherited;
  edtDataLavoro.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  imgPrimo.Hint:='Prima pagina';
  imgPrec.Hint:='Pagina precedente';
  imgSucc.Hint:='Pagina successiva';
  imgUltimo.Hint:='Ultima pagina';
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  //grdAnagrafe.RowLimit:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,18);
  grdAnagrafe.RowLimit:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  //grdAnagrafe.medpFixedColumns:=4;

  DipendenteSingolo:=False;
  RefreshCompleto:=False;
  UpdateVistaPersonale;

  if A000GetInibizioni('Tag','445') <> 'N' then
    VerificaMsgDaLeggere;

  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
  if A000GetInibizioni('Tag','428') <> 'N' then
    VerificaRichiesteScioperoPendenti;
  // EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine

  //TORINO_CSI - 28/07/2016 - 2016/186 SVILUPPO#1.ini
  VerificaAnomalieCartellino;
  //TORINO_CSI - 28/07/2016 - 2016/186 SVILUPPO#1.fine

  // MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
  // verifica se il browser in uso è supportato e notifica nel caso di incompatibilità
  VerificaCompatibilitaBrowser;
  // MONDOEDP - commessa MAN/07 SVILUPPO#0.fine
end;

procedure TW002FAnagrafeElenco.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(W003DM);
  inherited;
end;

procedure TW002FAnagrafeElenco.RefreshPage;
var
  NomeCampo: String;
begin
  with WR000DM do
  begin
    if RefreshCompleto then
    begin
      selAnagrafe.Close;
      selAnagrafe.Open;

      // caption da layout anagrafico - daniloc 04.10.2010
      // operazione necessaria dopo close + open per riallineamento del displaylabel dei campi
      cdsI010.IndexName:='Visualizzazione';
      cdsI010.Filtered:=False;
      cdsI010.First;
      while not cdsI010.Eof do
      begin
        NomeCampo:=cdsI010.FieldByName('NOME_CAMPO').AsString;
        if selAnagrafe.FindField(NomeCampo) <> nil then
          selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('CAPTION_LAYOUT').AsString;
        cdsI010.Next;
      end;
      // caption da layout anagrafico.fine

      UpdateVistaPersonale;
      cdsAnagrafe.Locate('PROGRESSIVO',ParametriForm.Progressivo,[]);
      RefreshCompleto:=False;
    end
    else
    begin
      cdsAnagrafe.Locate('PROGRESSIVO',ParametriForm.Progressivo,[]);
      AggiornaContatore;
    end;
  end;
end;

procedure TW002FAnagrafeElenco.VerificaMsgDaLeggere;
// verifica se ci sono messaggi da leggere ed eventualmente visualizza una notifica
var
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  MsgDaLeggere: TNumMessaggi;
  S: String;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  NumMsg: Integer;
  NumMsgStr,Testo: String;
begin
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  //NumMsg:=WR000DM.GetNumMsgDaLeggere;
  MsgDaLeggere:=WR000DM.GetNumMsgDaLeggere;
  NumMsg:=MsgDaLeggere.Totali;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  // se ci sono messaggi da leggere li visualizza come notifica
  if NumMsg > 0 then
  begin
    NumMsgStr:=IfThen(NumMsg = 1,'1 nuovo messaggio',Format('%d nuovi messaggi',[NumMsg]));
    Testo:=Format('Hai <a href="javascript:SubmitClick(''%s'',''W035'',true);" ' +
                  '     title="Visualizza i messaggi da leggere">%s</a> da leggere',
                  [lnkNotifica.HTMLName,NumMsgStr]);
    Notifica('Nuovi messaggi',Testo,'../img/mail-icon.png',False,True);

    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    if MsgDaLeggere.LetturaObbligatoria > 0 then
    begin
      S:=Format('SubmitClick("%s","W035",true); ',[lnkNotifica.HTMLName]);
      AddToInitProc(S);
    end;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  end;
end;

(*
procedure TW002FAnagrafeElenco.selT282CountThreadExecuted(Sender: TOracleQuery);
// ATTENZIONE: NON E' UTILIZZATA
// query di conteggio messaggi
// viene eseguita in modalità asincrona nel formcreate
var
  NumMsg: Integer;
  NumMsgStr,Testo: String;
begin
  if not Sender.Eof then
  begin
    NumMsg:=Sender.FieldAsInteger(0);
    // se ci sono messaggi da leggere li visualizza come notifica
    if NumMsg > 0 then
    begin
      NumMsgStr:=IfThen(NumMsg = 1,'1 nuovo messaggio',Format('%d nuovi messaggi',[NumMsg]));
      Testo:=Format('Hai <a href="javascript:SubmitClick(''%s'','''',true);" ' +
                    '     title="Visualizza i messaggi da leggere">%s</a> da leggere',
                    [lnkNotifica.HTMLName,NumMsgStr]);
      Notifica('Nuovi messaggi',Testo,'../img/mail-icon.png',False,True);
    end;
  end;
end;

procedure TW002FAnagrafeElenco.selT282CountThreadError(Sender: TOracleQuery;
  ErrorCode: Integer; const ErrorMessage: string);
// ATTENZIONE: NON E' UTILIZZATA
// gestione errori query conteggio messaggi
begin
  Log(ERRORE,'Errore in fase di conteggio messaggi ricevuti: ' + ErrorMessage + ' (' + IntToStr(ErrorCode) + ')');
end;
*)

// EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
procedure TW002FAnagrafeElenco.VerificaRichiesteScioperoPendenti;
// verifica se ci sono eventi di sciopero per cui non è presente una richiesta
// oppure la richiesta non è autorizzata all'ultimo livello ed eventualmente visualizza una notifica
var
  {S,}Testo, StrVisNotificaDebug: String;
  VisNotifica: Boolean;
  DataInizioNotifica, T1: TDateTime;
begin
  // PRE: verificata abilitazione alla funzione "Notifica adesione scioperi" (lettura / scrittura)
  T1:=Now;
  VisNotifica:=False;
  with WR000DM do
  begin
    // estrae gli eventi di sciopero futuri che non hanno ancora una richiesta associata
    // autorizzata all'ultimo livello, considerando i giorni di notifica
    selNotificaEventiSciopero.Close;
    selNotificaEventiSciopero.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    selNotificaEventiSciopero.Open;

    // per ognuno degli eventi estratti valuta le selezioni anagrafiche,
    // per verificare quelle che intersecano la propria
    // nota: gli eventi sono ordinati per data decrescente, perciò sono considerati
    //       in modo prioritario quelli più recenti
    while not selNotificaEventiSciopero.Eof do
    begin
      VisNotifica:=selNotificaEventiSciopero.FieldByName('SELEZIONE_ANAGRAFICA').IsNull;
      if not VisNotifica then
      begin
        // valuta la selezione anagrafica associata all'evento per estrarre i progressivi
        // che possono partecipare allo sciopero
        with selAnagEventoSciopero do
        begin
          SetVariable('DATALAVORO',selNotificaEventiSciopero.FieldByName('DATA').AsDateTime);
          SetVariable('FILTRO','AND ' + selNotificaEventiSciopero.FieldByName('SELEZIONE_ANAGRAFICA').AsString);
          SetVariable('FILTRO_IN_SERVIZIO',FILTRO_IN_SERVIZIO);
          Open;
        end;

        // valuta se esiste almeno un dipendente in comune tra le due selezioni anagrafiche
        with cdsAnagrafe do
        begin
          First;
          while not Eof do
          begin
            if selAnagEventoSciopero.SearchRecord('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
            begin
              VisNotifica:=True;
              Break;
            end;
            Next;
          end;
          First;
        end;
      end;

      // la notifica è generica per cui al primo evento da notificare si ferma
      if VisNotifica then
      begin
        // in debug fornisce info sull'evento
        StrVisNotificaDebug:='';
        if DebugHook <> 0 then
        begin
          with selNotificaEventiSciopero do
          begin
            DataInizioNotifica:=FieldByName('DATA').AsDateTime - FieldByName('GG_NOTIFICA').AsInteger;
            StrVisNotificaDebug:=Format('<hr/>(**) Evento del %s da notificare a partire dal %s (%d giorni prima)',
                                        [FieldByName('DATA').AsString,
                                         DateToStr(DataInizioNotifica),
                                         FieldByName('GG_NOTIFICA').AsInteger]);
          end;
        end;
        Break;
      end;
      selNotificaEventiSciopero.Next;
    end;
  end;

  //
  if DebugHook <> 0 then
  begin
    StrVisNotificaDebug:=StrVisNotificaDebug + Format('<hr/>(ricerca effettuata in %s sec.)',[FormatDateTime('ss.zzz',Now - T1)]);
  end;

  // chiusura dataset di supporto
  with WR000DM do
  begin
    selNotificaEventiSciopero.CloseAll;
    selAnagEventoSciopero.CloseAll;
  end;

  // se ci sono eventi da considerare visualizza una notifica
  if VisNotifica then
  begin
    Testo:=Format('Deve ancora essere completata la ' +
                  '<a href="javascript:SubmitClick(''%s'',''W037'',true);" ' +
                  '   title="Accede alla funzione di Notifica adesione scioperi">Notifica adesione scioperi</a>%s',
                  [lnkNotifica.HTMLName,StrVisNotificaDebug]);
    Notifica('Eventi di sciopero',Testo,''{'../img/sciopero-icon.png'},True,True);

    // accesso automatico alla funzione
    {
    if ... then
    begin
      S:=Format('SubmitClick("%s","W037",true); ',[lnkNotifica.HTMLName]);
      AddToInitProc(S);
    end;
    }
  end;
end;
// EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine

//TORINO_CSI - 28/07/2016 - 2016/186 SVILUPPO#1.ini
procedure TW002FAnagrafeElenco.VerificaAnomalieCartellino;
begin
  MsgW003:='';
  if (A000GetInibizioni('Tag','402') = 'N') or (Parametri.WEBNotificaAnomalie = 'N') then
    exit;

  FreeAndNil(W003DM);
  W003DM:=TW003FAnomalieDM.Create(nil);
  W003DM.NotificaAutomaticaAnomalie;
  // accesso alla funzione messaggistica sui messaggi da leggere
  if High(W003DM.VettAnomalie) >= 0 then
  begin
    MsgW003:=Parametri.CampiRiferimento.C90_W003MsgAccesso;
    if MsgW003 = '' then
      MsgW003:='Sono presenti anomalie sui cartellini nel periodo :DAL - :AL. Visualizzare l''elenco dettagliato delle anomalie?';
    MsgW003:=StringReplace(MsgW003,'.','.' + CRLF,[rfReplaceAll]);
    MsgW003:=StringReplace(MsgW003,':DAL',DateToStr(W003DM.DataDal),[rfReplaceAll,rfIgnoreCase]);
    MsgW003:=StringReplace(MsgW003,':AL',DateToStr(W003DM.DataAl),[rfReplaceAll,rfIgnoreCase]);
    AddToInitProc(Format('SubmitClick("%s","W003",true); ',[lnkNotifica.HTMLName]));
  end;
end;

procedure TW002FAnagrafeElenco.ApriW003AnomalieCartellino;
var
  W003: TW003FAnomalie;
begin
  try
    W003:=TW003FAnomalie.Create(GGetWebApplicationThreadVar);
    W003.NotificaAutomaticaAnomalie(W003DM);
    W003.OpenPage;
  finally
    FreeAndNil(W003DM);
  end;
end;

procedure TW002FAnagrafeElenco.FreeW003DM;
begin
  FreeAndNil(W003DM);
end;
//TORINO_CSI - 28/07/2016 - 2016/186 SVILUPPO#1.ini

procedure TW002FAnagrafeElenco.IWAppFormRender(Sender: TObject);
begin
  inherited;

  if DipendenteSingolo then
    JsDipendenteSingolo:='document.getElementById("PagNavBarAnagrafe").className = "invisibile";' + CRLF +
                         'document.getElementById("W002Filtri").className = "invisibile";';
  chkDipendentiCessati.Checked:=VarToStr(WR000DM.selAnagrafe.GetVariable('FILTRO_IN_SERVIZIO')) = '';

  (*
  if MsgW003 <> '' then
  begin
    //W002.Notifica('Anomalie sul cartellino',LNotifica,''{'../img/anomalie-icon.png'},True,True);
    //GGetWebApplicationThreadVar.ShowMessage(MsgW003);
    Messaggio('W003',MsgW003,nil,nil);
  end;
  *)
end;

procedure TW002FAnagrafeElenco.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 15 }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    lblCommentoCorrente.Caption:='';
    RimuoviNotifiche;
  end;
end;

procedure TW002FAnagrafeElenco.IWTemplateProcessorHTML1UnknownTag(const AName: string; var VValue: string);
begin
  inherited;
  if UpperCase(AName) = 'DIPENDENTESINGOLO' then
    VValue:=JsDipendenteSingolo;
end;

procedure TW002FAnagrafeElenco.UpdateVistaPersonale;
// Apre il clientdataset cdsAnagrafe e ricostruisce grdAnagrafe
var
  i:Integer;
begin
  with WR000DM do
  begin
    // prepara i campi di cdsAnagrafe
    cdsAnagrafe.Close;
    cdsAnagrafe.FieldDefs.Assign(selAnagrafe.FieldDefs);
    for i:=0 to cdsAnagrafe.FieldDefs.Count - 1 do
    begin
      cdsAnagrafe.FieldDefs[i].Required:=False;
    end;
    cdsAnagrafe.CreateDataSet;
    cdsAnagrafe.LogChanges:=False;
    for i:=0 to selAnagrafe.FieldCount - 1 do
    begin
      cdsAnagrafe.FieldByName(selAnagrafe.Fields[i].FieldName).Index:=selAnagrafe.Fields[i].Index;
      cdsAnagrafe.Fields[i].Visible:=selAnagrafe.Fields[i].Visible;
      cdsAnagrafe.Fields[i].DisplayLabel:=selAnagrafe.Fields[i].DisplayLabel;
      cdsAnagrafe.Fields[i].ReadOnly:=False;
    end;

    // carica i valori di selAnagrafe su cdsAnagrafe
    selAnagrafe.First;
    while not selAnagrafe.Eof do
    begin
      cdsAnagrafe.Append;
      for i:=0 to selAnagrafe.FieldCount - 1 do
      begin
        cdsAnagrafe.Fields[i].Value:=selAnagrafe.Fields[i].Value;
      end;
      cdsAnagrafe.Post;
      selAnagrafe.Next;
    end;
    selAnagrafe.CloseAll;
  end;

  // imposta proprietà griglia
  grdAnagrafe.Columns.Clear;
  grdAnagrafe.CreateImplicitColumns;
  for i:=0 to grdAnagrafe.Columns.Count - 1 do
  begin
    if (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'MATRICOLA') or
       (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'COGNOME') or
       (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'NOME') then
    begin
      TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).OnClick:=grdAnagrafeColumnsMatricolaClick;
      TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).LinkField:='MATRICOLA';
    end;
  end;
  NumPagine:=WR000DM.cdsAnagrafe.RecordCount div grdAnagrafe.RowLimit;
  if (WR000DM.cdsAnagrafe.RecordCount mod grdAnagrafe.RowLimit) > 0 then
    inc(NumPagine);
  WR000DM.cdsAnagrafe.First;
  if WR000DM.cdsAnagrafe.RecordCount > 0 then
  begin
    ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
  end;

  NumRec:=1;
  AggiornaContatore;
end;

function TW002FAnagrafeElenco.GetInfoFunzione: String;
begin
  Result:='';
  try
    if (WR000DM <> nil) and
       (WR000DM.cdsAnagrafe <> nil) then
    begin
      if not WR000DM.cdsAnagrafe.Active then
        Result:='' // dataset non pronto
      else if WR000DM.cdsAnagrafe.RecordCount = 0 then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_NESSUN_DIP)
      else
      begin
        Result:=Format('%s: %s<br>%s: %s %s',
                       [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                        WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
                        A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                        WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
                        WR000DM.cdsAnagrafe.FieldByName('NOME').AsString]);
      end;
    end;
  except
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
procedure TW002FAnagrafeElenco.ApriW035MsgDaLeggere;
// accesso alla funzione messaggistica sui messaggi da leggere
var
  W035: TW035FMessaggistica;
begin
  W035:=TW035FMessaggistica.Create(GGetWebApplicationThreadVar);
  W035.SetParam('PROGRESSIVO',medpProgressivo);
  W035.SetParam('MODALITA','L'); // L = lettura, I = invio
  W035.OpenPage;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

// EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.ini
procedure TW002FAnagrafeElenco.ApriW037Notifica;
// accesso alla funzione di notifica adesione scioperi come richiedente
var
  W037: TW037FRichiestaScioperi;
begin
  WR000DM.Responsabile:=False;
  W037:=TW037FRichiestaScioperi.Create(GGetWebApplicationThreadVar);
  W037.SetParam('AL',Parametri.DataLavoro);
  W037.OpenPage;
end;
// EMPOLI_ASL11 - commessa 2013/040 SVILUPPO#3.fine

procedure TW002FAnagrafeElenco.lnkNotificaClick(Sender: TObject);
// gestione click su un'azione di notifica
var
  ParStr: String;
begin
  // parametro inviato via javascript
  // serve a determinare il tipo di azione da eseguire
  ParStr:=(Sender as TmeIWLink).GetSubmitParam;

  if ParStr = 'W003' then
  begin
    //Notifica presenza di anomalie e possibilità di apire in automatico la pagina dell'elenco anomalie
    Messaggio('W003',MsgW003,ApriW003AnomalieCartellino,FreeW003DM);
    MsgW003:='';
  end
  else if ParStr = 'W035' then
  begin
    // click su notifica nuovi messaggi: apre messaggi da leggere
    ApriW035MsgDaLeggere;
  end
  else if ParStr = 'W037' then
  begin
    // click su notifica richieste sciopero da completare: apre notifica adesione scioperi
    ApriW037Notifica;
  end;
end;

procedure TW002FAnagrafeElenco.btnSalvaRicercaClick(Sender: TObject);
var i:Integer;
begin
  if Trim(edtNomeRicerca.Text) = '' then  //Lorena 15/06/2006
  begin
    MsgBox.MessageBox(INFORMA,A000TraduzioneStringhe(A000MSG_W002_MSG_INSERIRE_NOME_SELEZIONE));
    exit;
  end;
  if WR000DM.lstSQL.Count = 0 then
  begin
    MsgBox.MessageBox(INFORMA,A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_NON_ATTIVA));
    Exit;
  end;
  with WR000DM do
  begin
    seldistT003.Close; //Lorena 12/06/2006
    seldistT003.Filtered:=False;
    seldistT003.Open; //Lorena 12/06/2006
    if not seldistT003.SearchRecord('NOME',edtNomeRicerca.Text,[srFromBeginning]) then
    begin
      insT003.SetVariable('NOME',edtNomeRicerca.Text);
      for i:=0 to WR000DM.lstSQL.Count - 1 do
      begin
        insT003.SetVariable('POSIZIONE',i);
        insT003.SetVariable('RIGA',WR000DM.lstSQL[i]);
        insT003.Execute;
      end;
      insT003.Session.Commit;
      RefreshT003:=True;
      MsgBox.MessageBox(INFORMA,Format(A000TraduzioneStringhe(A000MSG_W002_MSG_FMT_SELEZIONE_SALVATA),[edtNomeRicerca.Text]));
    end
    else
      MsgBox.MessageBox(INFORMA,A000TraduzioneStringhe(A000MSG_W002_ERR_SELEZIONE_GIA_ESISTENTE));
    seldistT003.Close; //Lorena 12/06/2006
    seldistT003.Filtered:=True;
  end;
end;

procedure TW002FAnagrafeElenco.grdAnagrafeColumnsMatricolaClick(ASender: TObject; const AValue: String);
begin
  WR000DM.cdsAnagrafe.Locate('MATRICOLA',AValue,[]);
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.mnuEsportaCsvClick(Sender: TObject);
begin
  InviaFile('ElencoDipendenti.xls',grdAnagrafe.ToCsv);
end;

procedure TW002FAnagrafeElenco.AggiornaContatore;
// Aggiorna visualizzazione del contatore di record / pagine
var
   recDa,recA,recTot,pagCurr,pagTot: Integer;
begin
  // calcoli per num. record
  if WR000DM.cdsAnagrafe.RecordCount = 0 then
  begin
    pagTot:=0;
    imgPrimo.Visible:=False;
    imgPrec.Visible:=False;
    lblNumRecord.Visible:=True;
    lblNumRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_PAG),[0,0]);
    lblNumRecord.Hint:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT),[0,0,0]);
    lblContaRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[0,0,0]);
    imgSucc.Visible:=False;
    imgUltimo.Visible:=False;
  end
  else
  begin
    // calcoli per num. record
    recDa:=WR000DM.cdsAnagrafe.RecNo;
    recA:=min(WR000DM.cdsAnagrafe.RecNo + grdAnagrafe.RowLimit - 1,WR000DM.cdsAnagrafe.RecordCount);
    recTot:=WR000DM.cdsAnagrafe.RecordCount;

    // contatore in formato numero pagine
    pagCurr:=NumRec div grdAnagrafe.RowLimit + 1;
    pagTot:=NumPagine;

    // imposta label in base a tipo visualizzazione
    lblNumRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_PAG),[pagCurr,pagTot]);
    lblNumRecord.Hint:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT),[recDa,recA,recTot]);
    lblContaRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[recDa,recA,recTot]);
    lblContaRecord.Css:='contatore align_right';

    // se num. pag. totale è maggiore di 1 visualizza le immagini per la navigazione
    imgPrimo.Visible:=(pagTot > 1);
    imgPrec.Visible:=(pagTot > 1);
    imgSucc.Visible:=(pagTot > 1);
    imgUltimo.Visible:=(pagTot > 1);
    if pagTot > 1 then
    begin
      imgPrimo.Enabled:=(pagCurr > 1);
      imgPrimo.ImageFile.FileName:=IfThen(imgPrimo.Enabled,filebtnPrimo,filebtnPrimoDisab);
      imgPrec.Enabled:=(recDa - grdAnagrafe.RowLimit >= 0);
      imgPrec.ImageFile.FileName:=IfThen(imgPrec.Enabled,filebtnPrec,filebtnPrecDisab);
      imgSucc.Enabled:=(recDa + grdAnagrafe.RowLimit <= recTot);
      imgSucc.ImageFile.FileName:=IfThen(imgSucc.Enabled,filebtnSucc,filebtnSuccDisab);
      imgUltimo.Enabled:=(recA < recTot);
      imgUltimo.ImageFile.FileName:=IfThen(imgUltimo.Enabled,filebtnUltimo,filebtnUltimoDisab);
    end;
  end;
  lblNumRecord.Css:='contatore' + IfThen(pagTot > 1,'_pad');
end;

procedure TW002FAnagrafeElenco.imgPaginaPrimaClick(Sender: TObject);
begin
  WR000DM.cdsAnagrafe.First;
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
  begin
    WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
    WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
  end;
  NumRec:=1;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaSuccClick(Sender: TObject);
begin
  if (NumRec + grdAnagrafe.RowLimit) <= WR000DM.cdsAnagrafe.RecordCount then
  begin
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    WR000DM.cdsAnagrafe.MoveBy(grdAnagrafe.RowLimit);
    NumRec:=WR000DM.cdsAnagrafe.RecNo;
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    begin
      WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
      WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    end;
  end;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaPrecClick(Sender: TObject);
begin
  if NumRec > 1 then
  begin
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    WR000DM.cdsAnagrafe.MoveBy(- grdAnagrafe.RowLimit);
    NumRec:=WR000DM.cdsAnagrafe.RecNo;
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    begin
      WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
      WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    end;
  end;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaUltimaClick(Sender: TObject);
begin
  WR000DM.cdsAnagrafe.Last;
  if WR000DM.cdsAnagrafe.RecNo mod grdAnagrafe.RowLimit = 0 then
    WR000DM.cdsAnagrafe.MoveBy(-(grdAnagrafe.RowLimit - 1))
  else
    WR000DM.cdsAnagrafe.MoveBy(-(WR000DM.cdsAnagrafe.RecNo mod grdAnagrafe.RowLimit) + 1);
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
  begin
    WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
  end;
  NumRec:=WR000DM.cdsAnagrafe.RecNo;
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.grdAnagrafeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  S:String;
  v: Variant;
begin
  if ARow = 0 then
  begin
    // intestazione
    v:=WR000DM.cdsI010.Lookup('NOME_CAMPO',ACell.Text,'CAPTION_LAYOUT;NOME_LOGICO');
    if (not VarIsNull(v)) then
    begin
      if not VarIsNull(v[0]) then
        S:=VarToStr(v[0])
      else
        S:=VarToStr(v[1]);
      if S <> '' then
        ACell.Text:=S;
    end
  end;
  RenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TW002FAnagrafeElenco.btnApplicaDataClick(Sender: TObject);
begin
  inherited;
  // controlli su data indicata
  if Trim(edtDataLavoro.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_INSERIRE_DATALAVORO));
    ActiveControl:=edtDataLavoro;
    Exit;
  end;
  if not TryStrToDate(edtDataLavoro.Text,Parametri.DataLavoro) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_ERR_DATALAVORO_NON_VALIDA));
    ActiveControl:=edtDataLavoro;
    Exit;
  end;

  // verifica se è necessario aggiornare la vista anagrafica
  if R180VarToDateTime(WR000DM.selAnagrafe.GetVariable('DATALAVORO')) <> Parametri.DataLavoro then
  begin
    WR000DM.selAnagrafe.SetVariable('DATALAVORO',Parametri.DataLavoro);
    WR000DM.selAnagrafe.Open;
    UpdateVistaPersonale;

    // salva data di lavoro su tabella
    if WR000DM.TipoUtente = '**Supervisore**' then
    begin
      with WR000DM.selT432 do
      try
        R180SetVariable(WR000DM.selT432,'UTENTE',Parametri.Operatore);
        Open;
        First;
        if Parametri.DataLavoro <> Date then
        begin
          Edit;
          FieldByName('UTENTE').AsString:=Parametri.Operatore;
          FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
          RegistraLog.SettaProprieta('M','T432_DATALAVORO','W002',WR000DM.selT432,True);
          RegistraLog.RegistraOperazione;
          Post;
        end
        else if not Eof then
          Delete;
        SessioneOracle.Commit;
        Close;
      except
        //on E: Exception do GGetWebApplicationThreadVar.ShowMessage(E.Message + ' (' + E.ClassName + ')');
      end;
    end;

    // distrugge tutte le form attive poiché la selezione anagrafica è cambiata
    WR000DM.History.FormReleaseAll;
  end;
end;

procedure TW002FAnagrafeElenco.chkDipendentiCessatiClick(Sender: TObject);
begin
  WR000DM.selAnagrafe.SetVariable('FILTRO_IN_SERVIZIO',IfThen(chkDipendentiCessati.Checked,'',FILTRO_IN_SERVIZIO));
  WR000DM.selAnagrafe.Open;
  UpdateVistaPersonale;

  // aggiorna variabile FiltroRicerca
  if chkDipendentiCessati.Checked then
  begin
    if Pos(FILTRO_IN_SERVIZIO,WR000DM.FiltroRicerca) > 0 then
      WR000DM.FiltroRicerca:=StringReplace(WR000DM.FiltroRicerca,FILTRO_IN_SERVIZIO,'',[rfReplaceAll,rfIgnoreCase])
  end
  else
  begin
    if Pos(FILTRO_IN_SERVIZIO,WR000DM.FiltroRicerca) = 0 then
      WR000DM.FiltroRicerca:=FILTRO_IN_SERVIZIO + WR000DM.FiltroRicerca;
  end;

  // distrugge tutte le form attive poiché la selezione anagrafica è cambiata
  WR000DM.History.FormReleaseAll;
end;

procedure TW002FAnagrafeElenco.btnCancellaRicercaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtNomeRicerca.Text) = '' then  //Lorena 15/06/2006
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_CANCELLARE));
    exit;
  end;
  with WR000DM do
  begin
    seldistT003.Close; //Lorena 12/06/2006
    seldistT003.Open; //Lorena 12/06/2006
    if seldistT003.SearchRecord('NOME',edtNomeRicerca.Text,[srFromBeginning]) then
    begin
      delT003.SetVariable('NOME',edtNomeRicerca.Text);
      delT003.Execute;
      delT003.Session.Commit;
      RefreshT003:=True;
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_CANCELLATA));
    end
    else
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_IMPOSSIB_CANC_SELEZIONE));
    seldistT003.Close; //Lorena 12/06/2006
  end;
end;

end.
