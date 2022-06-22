unit W014UPianifCorsi;

interface

uses
  W014URiepilogoProfiliFM,
  SysUtils, Variants, Classes, Graphics, Controls, IWApplication,
  R012UWebAnagrafico,IWTemplateProcessorHTML,IWCompLabel,IWCompCheckbox,
  IWVCLBaseControl,IWBaseControl,IWControl,RegistrazioneLog,
  Oracle, OracleData, A000USessione, WC012UVisualizzaFileFM,
  A000UCostanti, A000UInterfaccia, IWCompEdit, IWCompButton,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  R100UCreditiFormativiDtM,DB,R010UPAGINAWEB,
  IWVCLComponent,Windows,
  StrUtils,Math,IWCompListbox,IWBaseHTMLControl,IWHTMLControls,
  IWBaseLayoutComponent,IWBaseContainerLayout,IWContainerLayout,ActnList,
  IWDBGrids,medpIWDBGrid,DBClient,
  meIWComboBox, IWCompGrids, IWCompExtCtrls, meIWCheckBox,
  meIWImageFile, meIWLabel, meIWLink, meIWEdit, meIWRadioGroup, meIWButton;

type
  TW014FPianifCorsi = class(TR012FWebAnagrafico)
    lblCorso: TmeIWLabel;
    cmbCorso: TmeIWComboBox;
    btnConferma: TmeIWButton;
    btnRiepilogo: TmeIWButton;
    rgpTipoIscrizioni: TmeIWRadioGroup;
    lblEdizione: TmeIWLabel;
    cmbEdizione: TmeIWComboBox;
    lblGiornata: TmeIWLabel;
    cmbGiornata: TmeIWComboBox;
    lblNumCrediti: TmeIWLabel;
    lblTipo: TmeIWLabel;
    lblModo: TmeIWLabel;
    lblLuogo: TmeIWLabel;
    lblMetodo: TmeIWLabel;
    lblMaxIscr: TmeIWLabel;
    lblMaxPartec: TmeIWLabel;
    lblNote: TmeIWLabel;
    lnkLink: TmeIWLink;
    lblDurata: TmeIWLabel;
    lblIscritti: TmeIWLabel;
    rgpTipoRichieste: TmeIWRadioGroup;
    lblTipoDesc: TmeIWLabel;
    lblModoDesc: TmeIWLabel;
    lblLuogoDesc: TmeIWLabel;
    lblMetodoDesc: TmeIWLabel;
    lblMaxIscrDesc: TmeIWLabel;
    lblMaxPartecDesc: TmeIWLabel;
    lblIscrittiDesc: TmeIWLabel;
    lblDurataDesc: TmeIWLabel;
    lblNoteDesc: TmeIWLabel;
    lblNumCreditiDesc: TmeIWLabel;
    btnVisCorsi: TmeIWButton;
    lblRiepAl: TmeIWLabel;
    edtRiepAl: TmeIWEdit;
    btnVisualizza: TmeIWButton;
    edtDtInizio: TmeIWEdit;
    edtDtFine: TmeIWEdit;
    lblCorsiDal: TmeIWLabel;
    lblCorsiAl: TmeIWLabel;
    rgpTipoDettaglio: TmeIWRadioGroup;
    grdCorsi: TmedpIWDBGrid;
    dsrSG651: TDataSource;
    cdsSG651: TClientDataSet;
    cdsSG651Copy: TClientDataSet;
    procedure btnVisCorsiClick(Sender: TObject);
    procedure rgpTipoRichiesteClick(Sender: TObject);
    procedure cmbGiornataChange(Sender: TObject);
    procedure lnkLinkClick(Sender: TObject);
    procedure rgpTipoIscrizioniClick(Sender: TObject);
    procedure cmbEdizioneChange(Sender: TObject);
    procedure cmbCorsoChange(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure btnRiepilogoClick(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure rgpTipoDettaglioClick(Sender: TObject);
    procedure grdCorsiRenderCell(ACell: TIWGridCell;const ARow,AColumn: Integer);
    procedure grdCorsiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    ListaCorsi,ListaEdizioni,ListaGiornate,ListaDipendenti: TStringList;
    TuttiDipendenti,Primo: Boolean;
    SalvaItem,ColCorso: Integer;
    R100: TR100FCreditiFormativiDtM;
    W014FRiepilogoProfiliFM: TW014FRiepilogoProfiliFM;
    function Controlli: Boolean;
    procedure GetCorsi;
    procedure GetEdizioni;
    procedure GetGiornate;
    procedure GetPianifCorsi;
    procedure PulisciLabelDatiCorso;
    procedure CaricaLabelDatiCorso;
    function Iscritti: Integer;
    procedure DBGridColumnClick(ASender: TObject;const AValue: string);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure OnCambiaProgressivo; override;
    procedure GetDipendentiDisponibili(Data: TDateTime); override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM;
{$R *.dfm}

function TW014FPianifCorsi.InizializzaAccesso:Boolean;
begin
  Result:=False;
  if Trim(Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Dato CREDITI FORMATIVI non specificato in Aziende/Gestione moduli!');
    Exit;
  end;

  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  if WR000DM.Responsabile then
    WR000DM.DataSetCorsi:=WR000DM.selSG650c
  else
    WR000DM.DataSetCorsi:=WR000DM.selSG650;
  if WR000DM.Responsabile then
    rgpTipoRichiesteClick(rgpTipoRichieste)
  else
    VisualizzaDipendenteCorrente;
end;

procedure TW014FPianifCorsi.IWAppFormCreate(Sender: TObject);
var
  dd,mm,yy: Word;
begin
  if WR000DM.Responsabile then
    Tag:=413
  else
    Tag:=411;
  inherited;
  if WR000DM.Responsabile then
    Self.HelpKeyWord:='W014P1'
  else
    Self.HelpKeyWord:='W014P0';
  btnConferma.Visible:=not SolaLettura;
  rgpTipoIscrizioni.ItemIndex:=0;
  ListaCorsi:=TStringList.Create;
  ListaEdizioni:=TStringList.Create;
  ListaGiornate:=TStringList.Create;
  ListaDipendenti:=TStringList.Create;
  R100:=TR100FCreditiFormativiDtM.Create(Self);
  PulisciLabelDatiCorso;
  Primo:=True;
  // GetCorsi;
  cmbCorso.ItemIndex:=-1;
  cmbEdizione.ItemIndex:=-1;
  cmbGiornata.ItemIndex:=-1;
  edtRiepAl.Text:=FormatDateTime('yyyy',Now);
  DecodeDate(Parametri.DataLavoro,yy,mm,dd);
  edtDtInizio.Text:=DateToStr(EncodeDate(yy,1,1));
  edtDtFine.Text:=DateToStr(EncodeDate(yy,12,31));
  WR000DM.selSG651.Filtered:=False;

  ColCorso:=0;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdCorsi.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdCorsi.medpDataSet:=cdsSG651Copy;
  grdCorsi.medpRowIDField:='RI';
end;

procedure TW014FPianifCorsi.PulisciLabelDatiCorso;
begin
  lblIscritti.Caption:='';
  lblDurata.Caption:='';
  lblNumCrediti.Caption:='';
  lblTipo.Caption:='';
  lblLuogo.Caption:='';
  lblModo.Caption:='';
  lblMetodo.Caption:='';
  lblMaxIscr.Caption:='';
  lblMaxPartec.Caption:='';
  lblNote.Caption:='';
  lnkLink.Caption:='';
  lblIscrittiDesc.Caption:='';
  lblDurataDesc.Caption:='';
  lblNumCreditiDesc.Caption:='';
  lblTipoDesc.Caption:='';
  lblLuogoDesc.Caption:='';
  lblModoDesc.Caption:='';
  lblMetodoDesc.Caption:='';
  lblMaxIscrDesc.Caption:='';
  lblMaxPartecDesc.Caption:='';
  lblNoteDesc.Caption:='';
end;

procedure TW014FPianifCorsi.VisualizzaDipendenteCorrente;
var
  i: Integer;
begin
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  GetCorsi;
  if WR000DM.Responsabile and TuttiDipendenti then // Tutti i dipendenti
  begin
    lnkDipendente.Caption:='';
    with WR000DM.selSG651 do
    begin
      Close;
      SetVariable('FILTRO',WR000DM.FiltroRicerca);
      SetVariable('FILTRODOCENTI',WR000DM.FiltroRicerca);
      SetVariable('DATAINIZIO',StrToDate(edtDtInizio.Text));
      SetVariable('DATAFINE',StrToDate(edtDtFine.Text));
      SetVariable('DATALAVORO',Parametri.DataLavoro);
      Open;
    end;
  end
  else
  begin
    // Dipendente corrente
    inherited;
    with WR000DM.selSG651 do
    begin
      Close;
      SetVariable('FILTRO',' AND SG651.PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger));
      SetVariable('FILTRODOCENTI',' AND SG664.PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger));
      SetVariable('DATAINIZIO',StrToDate(edtDtInizio.Text));
      SetVariable('DATAFINE',StrToDate(edtDtFine.Text));
      SetVariable('DATALAVORO',Parametri.DataLavoro);
      Open;
      if not WR000DM.Responsabile then
      begin
        if rgpTipoIscrizioni.ItemIndex = 0 then
        begin
          Filter:='';
          Filtered:=False;
        end
        else if rgpTipoIscrizioni.ItemIndex = 1 then
        begin
          Filter:='(STATO <> ''I'')';
          Filtered:=True;
        end
        else if rgpTipoIscrizioni.ItemIndex = 2 then
        begin
          Filter:='(STATO = ''I'')';
          Filtered:=True;
        end;
      end;
    end;
  end;
  btnConferma.Visible:=not SolaLettura;

  // Creazione cdsSG651Copy uguale a selSG651
  cdsSG651Copy.Close;
  cdsSG651Copy.FieldDefs.Clear;
  with WR000DM.selSG651 do
  begin
    // Per creare il FieldDefs leggo i Fields per considerare anche campi calcolati e di lookup
    for i:=0 to FieldCount - 1 do
    begin
      if Fields[i].DataType = ftString then
        cdsSG651Copy.FieldDefs.Add(Fields[i].FieldName,Fields[i].DataType,Fields[i].Size)
      else
        cdsSG651Copy.FieldDefs.Add(Fields[i].FieldName,Fields[i].DataType);
    end;
  end;
  cdsSG651Copy.FieldDefs.Add('CDS_NUMCREDITI',ftFloat);
  cdsSG651Copy.FieldDefs.Add('CDS_GIORNATA',ftString,50);
  cdsSG651Copy.CreateDataSet;
  cdsSG651Copy.LogChanges:=False;
  // estrae l'elenco dei corsi pianificati e li copia su cdsSG651Copy
  GetPianifCorsi;
end;

procedure TW014FPianifCorsi.GetCorsi;
var
  valore,filtro: String;
begin
  // Elenco corsi
  ListaCorsi.Clear;
  cmbCorso.Items.Clear;
  if not WR000DM.Responsabile then
  begin
    cmbCorso.NoSelectionText:='Selezionare un corso';
    with WR000DM.selSG650 do
    begin
      R180SetVariable(WR000DM.selSG650,'DATAINIZIO',StrToDate(edtDtInizio.Text));
      R180SetVariable(WR000DM.selSG650,'DATAFINE',StrToDate(edtDtFine.Text));
      Open;
      First;
      if (Trim(Parametri.CampiRiferimento.C10_FormazioneProfiloCorso) <> '') then
      begin
        // Ricerco nello storico il valore del campo C10_FormazioneProfiloCorso alla data lavoro
        R180SetVariable(WR000DM.selT430,'progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        R180SetVariable(WR000DM.selT430,'datalavoro',Parametri.DataLavoro);
        R180SetVariable(WR000DM.selT430,'field',Parametri.CampiRiferimento.C10_FormazioneProfiloCorso);
        WR000DM.selT430.Open;
        WR000DM.selT430.First;
        valore:='''' + WR000DM.selT430.FieldByName('campo').AsString + '''';
        filtro:='''' + StringReplace(FieldByName('profilo_corso').AsString,',',''',''',[rfReplaceAll]) + '''';
        while not Eof do
        begin
          if (pos(valore,filtro) <> 0) or (FieldByName('PROFILO_CORSO').AsString = '') then
          begin
            cmbCorso.Items.Add(StringReplace(Format('%-15s %s',[FieldByName('CODICE').AsString,FieldByName('TITOLO_CORSO').AsString]),' ',SPAZIO,[rfReplaceAll]));
            ListaCorsi.Add(FieldByName('CODICE').AsString);
          end;
          Next;
        end;
      end
      else
      begin
        while not Eof do
        begin
          cmbCorso.Items.Add(StringReplace(Format('%-15s %s',[FieldByName('CODICE').AsString,FieldByName('TITOLO_CORSO').AsString]),' ',SPAZIO,[rfReplaceAll]));
          ListaCorsi.Add(FieldByName('CODICE').AsString);
          Next;
        end;
      end;
    end;
  end
  else if WR000DM.Responsabile then
  begin
    cmbCorso.NoSelectionText:='Tutti i corsi';
    with WR000DM.selSG650c do
    begin
      R180SetVariable(WR000DM.selSG650c,'DATAINIZIO',StrToDate(edtDtInizio.Text));
      R180SetVariable(WR000DM.selSG650c,'DATAFINE',StrToDate(edtDtFine.Text));
      Open;
      First;
      while not Eof do
      begin
        cmbCorso.Items.Add(StringReplace(Format('%-15s %s',[FieldByName('CODICE').AsString,FieldByName('TITOLO_CORSO').AsString]),' ',SPAZIO,[rfReplaceAll]));
        ListaCorsi.Add(FieldByName('CODICE').AsString);
        Next;
      end;
    end;
  end;
end;

procedure TW014FPianifCorsi.GetEdizioni;
begin
  // Elenco edizioni
  ListaEdizioni.Clear;
  cmbEdizione.Items.Clear;
  if cmbCorso.ItemIndex >= 0 then
    with WR000DM.selSG650Ediz do
    begin
      Close;
      SetVariable('CODICEIN',copy(cmbCorso.Text,1,pos(SPAZIO,cmbCorso.Text) - 1));
      SetVariable('DATAINIZIO',StrToDate(edtDtInizio.Text));
      SetVariable('DATAFINE',StrToDate(edtDtFine.Text));
      Open;
      while not Eof do
      begin
        cmbEdizione.Items.Add(StringReplace(Format('%s %s',[FieldByName('EDIZIONE').AsString,'(' + DateToStr(FieldByName('DECORRENZA').AsDateTime) + ')']),' ',SPAZIO,[rfReplaceAll]));
        ListaEdizioni.Add(FieldByName('EDIZIONE').AsString);
        Next;
      end;
    end
    else
      cmbEdizione.Items.Clear;
end;

procedure TW014FPianifCorsi.GetGiornate;
begin
  // Elenco giornate
  ListaGiornate.Clear;
  cmbGiornata.Items.Clear;
  if (cmbEdizione.ItemIndex >= 0) and (cmbCorso.ItemIndex >= 0) then
    with WR000DM.selSG650Giorn do
    begin
      Close;
      SetVariable('CODICEIN',copy(cmbCorso.Text,1,pos(SPAZIO,cmbCorso.Text) - 1));
      SetVariable('EDIZIONE',Trim(copy(cmbEdizione.Text,1,pos('(',cmbEdizione.Text) - 1)));
      SetVariable('DECORRENZA',StrToDate(copy(cmbEdizione.Text,pos('(',cmbEdizione.Text) + 1,10)));
      SetVariable('DATAINIZIO',StrToDate(edtDtInizio.Text));
      SetVariable('DATAFINE',StrToDate(edtDtFine.Text));
      Open;
      cmbGiornata.Items.Add('Tutte le giornate');
      ListaGiornate.Add('0');
      while not Eof do
      begin
        cmbGiornata.Items.Add(StringReplace(Format('%d %s %s',[FieldByName('NUMERO_GIORNO').AsInteger,FieldByName('DESCRIZIONE').AsString,'(' + DateToStr(FieldByName('DATA_GIORNO').AsDateTime) + ')']),' ',SPAZIO,[rfReplaceAll]));
        ListaGiornate.Add(IntToStr(FieldByName('NUMERO_GIORNO').AsInteger));
        Next;
      end;
      cmbGiornata.ItemIndex:=0;
    end
    else
      cmbGiornata.Items.Clear;
end;

function TW014FPianifCorsi.Controlli: Boolean;
begin
  Result:=False;
  if cmbCorso.ItemIndex < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare il corso da pianificare!');
    ActiveControl:=cmbCorso;
    exit;
  end;
  if cmbEdizione.ItemIndex < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Specificare l''edizione!');
    ActiveControl:=cmbEdizione;
    exit;
  end;
  Result:=True;
end;

procedure TW014FPianifCorsi.btnConfermaClick(Sender: TObject);
var
  DataGiorno: TDateTime;
  Ediz,C: String;
  NumGiorno,Giornata,Fine: Integer;
begin
  inherited;
  if not Controlli then
    exit;

  if cmbGiornata.ItemIndex = 0 then
  begin
    Giornata:=1;
    Fine:=(cmbGiornata.Items.Count - 1);
  end
  else
  begin
    Giornata:=cmbGiornata.ItemIndex;
    Fine:=cmbGiornata.ItemIndex;
  end;
  C:=Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15));
  Ediz:=Trim(Copy(cmbEdizione.Text,1,pos('(',cmbEdizione.Text) - 1));
  //Dec:=StrToDate(Copy(cmbEdizione.Text,pos('(',cmbEdizione.Text) + 1,10));

  with WR000DM.selSG651 do
  begin
    while Giornata <= Fine do
    begin
      cmbGiornata.ItemIndex:=Giornata;
      if WR000DM.selSG650Ediz.Locate('CODICE;EDIZIONE',VarArrayOf([C,Ediz]),[]) then
      begin
        // Se l'iscrizione del partecipante non rientra nelle Max iscrizioni, non si inserisce
        if not WR000DM.selSG650Ediz.FieldByName('MAX_ISCRITTI').IsNull then
        begin
          if Iscritti >= WR000DM.selSG650Ediz.FieldByName('MAX_ISCRITTI').AsInteger then
          begin
            if cmbGiornata.ItemIndex = 0 then
            begin
              GGetWebApplicationThreadVar.ShowMessage('È già stato raggiunto il limite massimo di iscrizioni per il giorno ' + copy(cmbGiornata.Text,(Length(cmbGiornata.Text) - 10),
                  10) + '. ' + CRLF + 'Non è quindi possibile iscriversi al corso. ' + CRLF + 'E'' possibile che in altre giornate vi siano posti liberi.');
              // Cancello le giornate inserite in precedenza ed esco
              Giornata:=0;
              Fine:=cmbGiornata.ItemIndex;
              while Giornata <= Fine do
              begin
                cmbGiornata.ItemIndex:=Giornata;
                WR000DM.delSG651.SetVariable('COD_CORSO',C);
                WR000DM.delSG651.SetVariable('EDIZIONE',Ediz);
                WR000DM.delSG651.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
                WR000DM.delSG651.SetVariable('DATA',StrToDate(copy(cmbGiornata.Text,Length(cmbGiornata.Text) - 10,10)));
                WR000DM.delSG651.Execute;
                SessioneOracle.Commit;
                Giornata:=Giornata + 1;
              end;
              exit;
            end
            else
            begin
              GGetWebApplicationThreadVar.ShowMessage('È già stato raggiunto il limite massimo di iscrizioni ' + CRLF + 'Non è più possibile iscriversi al corso selezionato.');
              exit;
            end;
          end;
        end;
        // Se l'iscrizione del partecipante non rientra nei Max partecipanti, si dà avviso di riserva ma si inserisce
        if not WR000DM.selSG650Ediz.FieldByName('MAX_PARTECIPANTI').IsNull then
        begin
          if Iscritti >= WR000DM.selSG650Ediz.FieldByName('MAX_PARTECIPANTI').AsInteger then
            GGetWebApplicationThreadVar.ShowMessage('È già stato raggiunto il limite massimo di partecipazioni. ' + CRLF + 'La sua iscrizione in data ' + copy(cmbGiornata.Text,(Length(cmbGiornata.Text) - 10),
                10) + ' verrà comunque considerata come eventuale riserva.');
        end;
      end;

      Append;
      FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

      // COD_CORSO
      FieldByName('COD_CORSO').AsString:=C;

      // EDIZIONE
      FieldByName('EDIZIONE').AsString:=Ediz;

      // NUMERO_GIORNO
      NumGiorno:=StrToInt(copy(cmbGiornata.Text,1,pos(SPAZIO,cmbGiornata.Text) - 1));
      FieldByName('NUMERO_GIORNO').AsInteger:=NumGiorno;

      // DATA_GIORNO
      DataGiorno:=StrToDate(copy(cmbGiornata.Text,Length(cmbGiornata.Text) - 10,10));
      FieldByName('DATA_CORSO').AsDateTime:=DataGiorno;

      // DURATA_CORSO
      FieldByName('DURATA_CORSO').AsString:='00.00';

      // TIPO_RECORD
      FieldByName('TIPO_RECORD').AsString:='M';

      // ORIGINE
      FieldByName('ORIGINE').AsString:='W';

      // STATO
      FieldByName('STATO').AsString:='R';

      // DATA ISCRIZIONE
      FieldByName('DATA_ISCRIZIONE').AsDateTime:=Now;

      // OPERATORE ISCRIZIONE
      FieldByName('OPERATORE_ISCRIZIONE').AsString:=Parametri.Operatore;

      try
        Post;
        SessioneOracle.Commit;
        lblIscrittiDesc.Caption:='Numero di iscritti:';
        lblIscritti.Caption:=IntToStr(Iscritti);
      except
        on e: Exception do
        begin
          If pos('ORA-00001',e.Message) > 0 then
            GGetWebApplicationThreadVar.ShowMessage('Partecipazione già esistente per il corso e per la giornata selezionata.')
          else
            Cancel;
        end;
      end;
      Giornata:=Giornata + 1;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW014FPianifCorsi.IWAppFormRender(Sender: TObject);
begin
  inherited;
  if WR000DM.Responsabile then
    Title:='(W014) Autorizzazione partecipazioni'
  else
    Title:='(W014) Gestione richieste partecipazioni';

  lblEdizione.Visible:=(not WR000DM.Responsabile);
  lblGiornata.Visible:=(not WR000DM.Responsabile);
  cmbEdizione.Visible:=(not WR000DM.Responsabile);
  cmbGiornata.Visible:=(not WR000DM.Responsabile);
  btnConferma.Visible:=(not SolaLettura) and (not WR000DM.Responsabile) and ((rgpTipoIscrizioni.ItemIndex = 0) or (rgpTipoIscrizioni.ItemIndex = 1));
  rgpTipoIscrizioni.Visible:=not WR000DM.Responsabile;
  rgpTipoRichieste.Visible:=WR000DM.Responsabile;

  GetCorsi;

  if WR000DM.Responsabile then
    rgpTipoRichiesteClick(nil);
end;

procedure TW014FPianifCorsi.GetPianifCorsi;
// Copia delle pianificazioni da selSG651 a cdsSG651Copy. Quindi popolamento di cdsSG651 e dbgrid
var
  i: Integer;
begin
  cdsSG651Copy.EmptyDataSet;
  cdsSG651Copy.Open;
  with WR000DM.selSG651 do
  begin
    First;
    while not Eof do
    begin
      if (RecNo = 1) or (rgpTipoDettaglio.ItemIndex <> 0) or (cdsSG651Copy.FieldByName('Cod_Corso').AsString <> FieldByName('Cod_Corso').AsString) or (cdsSG651Copy.FieldByName('Edizione').AsString <> FieldByName('Edizione').AsString) then
      begin
        // Caso in cui si visualizzano tutte le giornate o cod_corso-decorrenza è diverso
        // dal precedente (sono su un altro corso) quindi devo inserire la riga in tabella
        cdsSG651Copy.Append;
        // Copio l'intero record
        for i:=0 to FieldCount - 1 do
          cdsSG651Copy.Fields[i].Value:=Fields[i].Value;
        if rgpTipoDettaglio.ItemIndex = 0 then
        begin
          // Controllo se ci sono giornate dello stesso corso di quella in linea ma in stato diverso, che sono state escluse da selSG651 con un eventuale filter
          WR000DM.SelSG651StatoGiornate.Close;
          WR000DM.SelSG651StatoGiornate.SetVariable('COD_CORSO',FieldByName('Cod_Corso').AsString);
          WR000DM.SelSG651StatoGiornate.SetVariable('EDIZIONE',FieldByName('EDIZIONE').AsString);
          WR000DM.SelSG651StatoGiornate.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
          WR000DM.SelSG651StatoGiornate.Open;
          if WR000DM.SelSG651StatoGiornate.RecordCount > 1 then
            cdsSG651Copy.FieldByName('DESC_STATO').AsString:='Non definito';
        end;
        if FieldByName('Tipo_Partecipazione').AsString = 'PARTECIPANTE' then
        begin
          cdsSG651Copy.FieldByName('CREDITI').AsFloat:=R100.ConteggioCreditiCorso(FieldByName('PROGRESSIVO').AsInteger,FieldByName('Cod_Corso').AsString);
          if rgpTipoDettaglio.ItemIndex <> 0 then
            cdsSG651Copy.FieldByName('TIPO_PARTECIPAZIONE').AsString:='(' + FieldByName('Numero_Giorno').AsString + ') ' + FieldByName('descgiorno').AsString;
        end;
        cdsSG651Copy.Post;
      end;
      Next;
    end;
  end;

  grdCorsi.medpCreaCDS;
  grdCorsi.medpEliminaColonne;
  grdCorsi.medpAggiungiColonna('DBG_COMANDI',IfThen(WR000DM.Responsabile,'Autorizzazione',''),'',nil);
  if WR000DM.Responsabile and TuttiDipendenti then
  begin
    grdCorsi.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdCorsi.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  end;
  grdCorsi.medpAggiungiColonna('DESC_STATO','Stato','',nil);
  if rgpTipoDettaglio.ItemIndex = 0 then
  begin
    grdCorsi.medpAggiungiColonna('DECORRENZA','Dal','',nil);
    grdCorsi.medpAggiungiColonna('DATA_FINE','Al','',nil);
  end
  else
  begin
    grdCorsi.medpAggiungiColonna('DATA_CORSO','Data','',nil);
    grdCorsi.medpAggiungiColonna('DURATA_CORSO','Durata','',nil);
  end;
  if not WR000DM.Responsabile and ((rgpTipoIscrizioni.ItemIndex = 0) or (rgpTipoIscrizioni.ItemIndex = 2)) then
    grdCorsi.medpAggiungiColonna('CREDITI','Crediti','',nil);
  grdCorsi.medpAggiungiColonna('DESC_CORSO','Corso','',nil);
  grdCorsi.medpAggiungiColonna('EDIZIONE','Edizione','',nil);
  grdCorsi.medpAggiungiColonna('TIPO_PARTECIPAZIONE',IfThen(rgpTipoDettaglio.ItemIndex = 0,'Tipo partecipazione','Giornata'),'',nil);
  grdCorsi.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);

  grdCorsi.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    if WR000DM.Responsabile then
    begin
      grdCorsi.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdCorsi.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
    end
    else
      grdCorsi.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null');
  end;
  grdCorsi.medpCaricaCDS;
end;

procedure TW014FPianifCorsi.btnCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  with WR000DM.selSG651 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      DBGridColumnClick(Sender,FN);

      if rgpTipoDettaglio.ItemIndex = 0 then
      begin
        // Cancello tutte le giornate
        RegistraLog.SettaProprieta('C','SG651_PIANIFICAZIONECORSI',medpCodiceForm,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsString,'');
        RegistraLog.InserisciDato('COD_CORSO',FieldByName('Cod_Corso').AsString,'');
        RegistraLog.InserisciDato('DAL - AL',FieldByName('Decorrenza').AsString + ' - ' + FieldByName('Data_fine').AsString,'');
        RegistraLog.RegistraOperazione;
        WR000DM.delSG651b.SetVariable('COD_CORSO',FieldByName('Cod_Corso').AsString);
        WR000DM.delSG651b.SetVariable('EDIZIONE',FieldByName('EDIZIONE').AsString);
        WR000DM.delSG651b.SetVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
        WR000DM.delSG651b.Execute;
      end
      else
      begin
        // Cancello la giornata interessata
        RegistraLog.SettaProprieta('C','SG651_PIANIFICAZIONECORSI',medpCodiceForm,WR000DM.selSG651,True);
        Delete;
        RegistraLog.RegistraOperazione;
      end;
      SessioneOracle.Commit;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW014FPianifCorsi.btnRiepilogoClick(Sender: TObject);
var
  nAnnoRiepilogo: Integer;
begin
  inherited;
  nAnnoRiepilogo:=0;
  try
    nAnnoRiepilogo:=StrToInt(edtRiepAl.Text);
  except
  end;
  if nAnnoRiepilogo = 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Indicare l''anno di cui si desidera conoscere il riepilogo');
    ActiveControl:=edtRiepAl;
    exit;
  end;

  W014FRiepilogoProfiliFM:=TW014FRiepilogoProfiliFM.Create(Self);
  W014FRiepilogoProfiliFM.R100:=R100;
  W014FRiepilogoProfiliFM.CaricaRiepilogo(nAnnoRiepilogo);
end;

procedure TW014FPianifCorsi.grdCorsiAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
begin
  if not SolaLettura then
  begin
    for i:=0 to High(grdCorsi.medpCompGriglia) do
    begin
      if WR000DM.Responsabile then
      begin
        if grdCorsi.medpValoreColonna(i,'DESC_STATO') = 'Non definito' then
        begin
          // Componenti da eliminare
          FreeAndNil(grdCorsi.medpCompGriglia[i].CompColonne[0]);
        end
        else
        begin
          // Associo l'evento OnClick ai CheckBox
          (grdCorsi.medpCompCella(i,0,0) as TmeIWCheckBox).OnClick:=chkAutorizzazioneClick;
          (grdCorsi.medpCompCella(i,0,1) as TmeIWCheckBox).OnClick:=chkAutorizzazioneClick;
          (grdCorsi.medpCompCella(i,0,0) as TmeIWCheckBox).Checked:=grdCorsi.medpValoreColonna(i,'DESC_STATO') = 'Autorizzata';
          (grdCorsi.medpCompCella(i,0,1) as TmeIWCheckBox).Checked:=grdCorsi.medpValoreColonna(i,'DESC_STATO') = 'Non autorizzata';
        end;
      end
      else if grdCorsi.medpValoreColonna(i,'DESC_STATO') <> 'Richiesta' then
      begin
        // Componenti da eliminare
        FreeAndNil(grdCorsi.medpCompGriglia[i].CompColonne[0]);
      end
      else
      begin
        // Associo l'evento OnClick
        (grdCorsi.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=btnCancellaClick;
      end;
    end;
  end;
end;

procedure TW014FPianifCorsi.grdCorsiRenderCell(ACell: TIWGridCell;const ARow,AColumn: Integer);
begin
  inherited;

  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // assegnazione stili
  if (ARow > 0) and (grdCorsi.medpColonna(AColumn).DataField = 'DESC_STATO') and (ACell.Text <> '') then
    ACell.Css:=ACell.Css + ' align_center segnalazione';

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdCorsi.medpCompGriglia) + 1) and (grdCorsi.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdCorsi.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TW014FPianifCorsi.DBGridColumnClick(ASender: TObject;const AValue: string);
var
  C: String;
  i: Integer;
begin
  if WR000DM.selSG651.State in [dsEdit,dsInsert] then
    WR000DM.selSG651.Cancel;
  cdsSG651.Locate('DBG_ROWID',AValue,[]);
  btnConferma.Confirmation:='Inserire la richiesta di partecipazione per il corso specificato?';
  btnConferma.Visible:=(not WR000DM.Responsabile) and (not SolaLettura) and (cdsSG651.FieldByName('DESC_STATO').AsString <> 'Valida');
  if cdsSG651.RecordCount = 0 then
    exit;
  // Corso
  C:=Trim(copy(cdsSG651.FieldByName('DESC_CORSO').AsString,1,pos(' - ',cdsSG651.FieldByName('DESC_CORSO').AsString)));
  i:=ListaCorsi.IndexOf(C);
  cmbCorso.ItemIndex:=i;
  PulisciLabelDatiCorso;
  GetEdizioni;
  // Edizione
  C:=cdsSG651.FieldByName('EDIZIONE').AsString;
  i:=ListaEdizioni.IndexOf(C);
  cmbEdizione.ItemIndex:=i;
  if (cmbEdizione.ItemIndex < 0) then
    PulisciLabelDatiCorso
  else
    CaricaLabelDatiCorso;
  GetGiornate;
  // Giornata
  if (rgpTipoDettaglio.ItemIndex = 0) or (cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString = 'DOCENTE') or (cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString = 'RESPONSABILE SCIENTIFICO') or
    (cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString = 'TUTOR') or (cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString = 'ALTRO') then
    C:='0'
  else
    C:=Trim(copy(cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString,pos('(',cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString) + 1,pos(')',cdsSG651.FieldByName('TIPO_PARTECIPAZIONE').AsString) - 2));
  i:=ListaGiornate.IndexOf(C);
  cmbGiornata.ItemIndex:=i;
  cmbGiornataChange(nil);
  // Dipendente
  if (WR000DM.Responsabile) and TuttiDipendenti then
  begin
    i:=ListaDipendenti.IndexOf(cdsSG651.FieldByName('MATRICOLA').AsString);
    cmbDipendentiDisponibili.ItemIndex:=i;
    selAnagrafeW.SearchRecord('MATRICOLA',cdsSG651.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
  GetCorsi;
end;

procedure TW014FPianifCorsi.cmbCorsoChange(Sender: TObject);
begin
  inherited;
  Primo:=True;
  if (rgpTipoIscrizioni.ItemIndex = 0) or (rgpTipoIscrizioni.ItemIndex = 1) then
  begin
    PulisciLabelDatiCorso;
    GetEdizioni;
    cmbEdizione.ItemIndex:=-1;
    cmbGiornata.Clear;
  end;
end;

procedure TW014FPianifCorsi.CaricaLabelDatiCorso;
var
  C,Ediz: String;
begin
  C:=Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15));
  Ediz:=Trim(Copy(cmbEdizione.Text,1,pos('(',cmbEdizione.Text) - 1));
  with WR000DM.selSG650Ediz do
  begin
    if Locate('CODICE;EDIZIONE',VarArrayOf([C,Ediz]),[]) then
    begin
      // Descrizioni
      lblNumCreditiDesc.Caption:='Numero crediti:';
      lblTipoDesc.Caption:='Tipologia:';
      lblLuogoDesc.Caption:='Luogo:';
      lblModoDesc.Caption:='Modalità:';
      lblMetodoDesc.Caption:='Metodo:';
      lblMaxIscrDesc.Caption:='Numero massimo di iscrizioni:';
      lblMaxPartecDesc.Caption:='Numero massimo di partecipanti:';
      lblNoteDesc.Caption:='Note:';
      // Valori
      lblNumCrediti.Caption:=IntToStr(FieldByName('NUMERO_CREDITI').AsInteger);
      lblTipo.Caption:=FieldByName('FLAG_INTERNO').AsString;
      lblLuogo.Caption:=FieldByName('LUOGO_CORSO').AsString;
      lblModo.Caption:=FieldByName('EVENTO_PROGETTO').AsString;
      lblMetodo.Caption:=FieldByName('METODO_CORSO').AsString;
      If FieldByName('MAX_ISCRITTI').AsString = '' then
        lblMaxIscr.Caption:='n.d.'
      else
        lblMaxIscr.Caption:=FieldByName('MAX_ISCRITTI').AsString;
      if FieldByName('MAX_PARTECIPANTI').AsString = '' then
        lblMaxPartec.Caption:='n.d.'
      else
        lblMaxPartec.Caption:=FieldByName('MAX_PARTECIPANTI').AsString;
      lblNote.Caption:=FieldByName('NOTE').AsString;
      If FieldByName('LINK_PROGRAMMA_CORSO').AsString <> '' then
        lnkLink.Caption:='Clicca qui per visualizzare il programma del corso'
      else
        lnkLink.Caption:='';
    end;
  end;
end;

procedure TW014FPianifCorsi.cmbEdizioneChange(Sender: TObject);
begin
  inherited;
  lblIscritti.Caption:='';
  lblIscrittiDesc.Caption:='';

  if (cmbEdizione.ItemIndex < 0) then
    PulisciLabelDatiCorso
  else
    CaricaLabelDatiCorso;

  GetGiornate;
end;

function TW014FPianifCorsi.Iscritti: Integer;
var
  C: String;
begin
  // Ricavo il numero di partecipanti già iscritti al corso ed all'edizione selezionati
  C:=Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15));
  with WR000DM do
  begin
    selSG651Iscritti.Close;
    selSG651Iscritti.SetVariable('CODICEIN',C);
    selSG651Iscritti.SetVariable('EDIZIONE',Trim(Copy(cmbEdizione.Text,1,pos('(',cmbEdizione.Text) - 1)));
    if rgpTipoDettaglio.ItemIndex = 0 then
      selSG651Iscritti.SetVariable('GIORNO','')
    else
      selSG651Iscritti.SetVariable('GIORNO',' AND NUMERO_GIORNO = ''' + copy(cmbGiornata.Text,1,pos(SPAZIO,cmbGiornata.Text) - 1) + '''');
    selSG651Iscritti.Open;
    Result:=selSG651Iscritti.FieldByName('ISCRITTI').AsInteger;
  end;
end;

procedure TW014FPianifCorsi.rgpTipoDettaglioClick(Sender: TObject);
begin
  inherited;
  VisualizzaDipendenteCorrente;
end;

procedure TW014FPianifCorsi.rgpTipoIscrizioniClick(Sender: TObject);
begin
  inherited;
  VisualizzaDipendenteCorrente;
  if Sender <> nil then
  begin
    cmbCorso.ItemIndex := -1;
    ListaEdizioni.Clear;
    cmbEdizione.Items.Clear;
    ListaGiornate.Clear;
    cmbGiornata.Items.Clear;
    PulisciLabelDatiCorso;
  end;
end;

procedure TW014FPianifCorsi.lnkLinkClick(Sender: TObject);
var
  NomeFile:String;
begin
  NomeFile:=ExtractFileName(WR000DM.selSG650Ediz.FieldByName('LINK_PROGRAMMA_CORSO').AsString);
  VisualizzaFile(NomeFile,'Programma del corso',nil,nil,fdGlobal);
end;

procedure TW014FPianifCorsi.cmbGiornataChange(Sender: TObject);
var
  C: String;
  NumGiorno: Integer;
begin
  inherited;
  if cmbGiornata.ItemIndex >= 0 then
  begin
    lblIscrittiDesc.Caption:='Numero di iscritti:';
    lblIscritti.Caption:=IntToStr(Iscritti);
  end
  else
  begin
    lblIscritti.Caption:='';
    lblIscrittiDesc.Caption:='';
  end;
  // Ricavare la Durata corso
  if (cmbGiornata.ItemIndex > 0) and (rgpTipoDettaglio.ItemIndex <> 0) then
  begin
    C:=Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15));
    NumGiorno:=StrToInt(copy(cmbGiornata.Text,1,pos(SPAZIO,cmbGiornata.Text) - 1));
    with WR000DM.selSG659 do
    begin
      Close;
      SetVariable('codicein',C);
      SetVariable('NumGG',NumGiorno);
      Open;
    end;
    lblDurataDesc.Caption:='Durata:';
    lblDurata.Caption:=WR000DM.selSG659.FieldByName('ORE_GIORNO').AsString + ' h';
  end
  else
  begin
    lblDurata.Caption:='';
    lblDurataDesc.Caption:='';
  end;
end;

procedure TW014FPianifCorsi.OnCambiaProgressivo;
var
  M: String;
begin
  TuttiDipendenti:=cmbDipendentiDisponibili.ItemIndex = 0;
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) or TuttiDipendenti then
    VisualizzaDipendenteCorrente;
end;

procedure TW014FPianifCorsi.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
  ListaDipendenti.Clear;
  with selAnagrafeW do
  begin
    First;
    while not Eof do
    begin
      ListaDipendenti.Add(FieldByName('MATRICOLA').AsString);
      Next;
    end;
  end;
end;

procedure TW014FPianifCorsi.chkAutorizzazioneClick(Sender: TObject);
var
  FN:String;
begin
  FN:=(Sender as TmeIWCheckBox).FriendlyName;

  // Aggiorno Autorizzazione e Responsabile
  if not WR000DM.selSG651.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('Errore durante l''autorizzazione:' + CRLF + 'la richiesta non è più disponibile!');
    exit;
  end;

  if ((Sender as TmeIWCheckBox).Checked) and
     ((Sender as TmeIWCheckBox).Caption = 'Si') then
  begin
    if rgpTipoDettaglio.ItemIndex = 0 then
    begin
      // Aggiorno tutte le giornate
      WR000DM.upSG651.SetVariable('STATO','A');
      WR000DM.upSG651.SetVariable('COD_CORSO',WR000DM.selSG651.FieldByName('Cod_Corso').AsString);
      WR000DM.upSG651.SetVariable('EDIZIONE',WR000DM.selSG651.FieldByName('EDIZIONE').AsString);
      WR000DM.upSG651.SetVariable('PROGRESSIVO',WR000DM.selSG651.FieldByName('PROGRESSIVO').AsInteger);
      WR000DM.upSG651.Execute;
    end
    else
    begin
      // Aggiorno la giornata interessata
      WR000DM.selSG651.RefreshRecord;
      WR000DM.selSG651.Edit;
      WR000DM.selSG651.FieldByName('STATO').AsString:='A';
      WR000DM.selSG651.FieldByName('OPERATORE_AUTORIZZAZIONE').AsString:=Parametri.Operatore;
      WR000DM.selSG651.FieldByName('DATA_AUTORIZZAZIONE').AsDateTime:=Now;
      WR000DM.selSG651.Post;
    end;
  end
  else if ((Sender as TmeIWCheckBox).Checked) and
          ((Sender as TmeIWCheckBox).Caption = 'No') then
  begin
    if rgpTipoDettaglio.ItemIndex = 0 then
    begin
      // Aggiorno tutte le giornate
      WR000DM.upSG651.SetVariable('STATO','N');
      WR000DM.upSG651.SetVariable('COD_CORSO',WR000DM.selSG651.FieldByName('Cod_Corso').AsString);
      WR000DM.upSG651.SetVariable('EDIZIONE',WR000DM.selSG651.FieldByName('EDIZIONE').AsString);
      WR000DM.upSG651.SetVariable('PROGRESSIVO',WR000DM.selSG651.FieldByName('Progressivo').AsInteger);
      WR000DM.upSG651.Execute;
    end
    else
    begin
      // Aggiorno la giornata interessata
      WR000DM.selSG651.RefreshRecord;
      WR000DM.selSG651.Edit;
      WR000DM.selSG651.FieldByName('STATO').AsString:='N';
      WR000DM.selSG651.FieldByName('OPERATORE_AUTORIZZAZIONE').AsString:=Parametri.Operatore;
      WR000DM.selSG651.FieldByName('DATA_AUTORIZZAZIONE').AsDateTime:=Now;
      WR000DM.selSG651.Post;
    end;
  end
  else if not (Sender as TmeIWCheckBox).Checked then
  begin
    if rgpTipoDettaglio.ItemIndex = 0 then
    begin
      // Aggiorno tutte le giornate
      WR000DM.upSG651.SetVariable('STATO','R');
      WR000DM.upSG651.SetVariable('COD_CORSO',WR000DM.selSG651.FieldByName('Cod_Corso').AsString);
      WR000DM.upSG651.SetVariable('EDIZIONE',WR000DM.selSG651.FieldByName('EDIZIONE').AsString);
      WR000DM.upSG651.SetVariable('PROGRESSIVO',WR000DM.selSG651.FieldByName('Progressivo').AsInteger);
      WR000DM.upSG651.Execute;
    end
    else
    begin
      // Aggiorno la giornata interessata
      WR000DM.selSG651.RefreshRecord;
      WR000DM.selSG651.Edit;
      WR000DM.selSG651.FieldByName('STATO').AsString:='R';
      WR000DM.selSG651.FieldByName('OPERATORE_AUTORIZZAZIONE').AsString:='';
      WR000DM.selSG651.FieldByName('DATA_AUTORIZZAZIONE').AsString:='';
      WR000DM.selSG651.Post;
    end;
  end;
  SessioneOracle.Commit;
  //WR000DM.selSG651.RefreshOptions:=[roAllFields];//Serve per aggiornare i campi in join con la T050
  //WR000DM.selSG651.RefreshRecord;
  //WR000DM.selSG651.RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
  WR000DM.selSG651.Refresh;
  GetPianifCorsi;
  cdsSG651.Locate('DBG_ROWID',FN,[]);
end;

procedure TW014FPianifCorsi.rgpTipoRichiesteClick(Sender: TObject);
begin
  inherited;
  with WR000DM do
    if Responsabile then
    begin
      if rgpTipoRichieste.ItemIndex = 0 then
      begin
        if cmbCorso.ItemIndex >= 0 then
          selSG651.Filter:='(STATO = ''R'') AND (COD_CORSO = ''' + Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15)) + ''')'
        else
          selSG651.Filter:='(STATO = ''R'')';
        selSG651.Filtered:=True;
      end
      else if rgpTipoRichieste.ItemIndex = 1 then
      begin
        if cmbCorso.ItemIndex >= 0 then
          selSG651.Filter:='((STATO = ''R'') OR (STATO = ''A'') OR (STATO = ''N'')) AND (COD_CORSO = ''' + Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15)) + ''')'
        else
          selSG651.Filter:='((STATO = ''R'') OR (STATO = ''A'') OR (STATO = ''N''))';
        selSG651.Filtered:=True;
      end;
    end
    else
    begin
      if (rgpTipoIscrizioni.ItemIndex = 0) or (rgpTipoIscrizioni.ItemIndex = 1) then
      begin
        selSG651.Filter:='';
        selSG651.Filtered:=True;
      end
      else
      begin
        if cmbCorso.ItemIndex >= 0 then
          selSG651.Filter:='(COD_CORSO = ''' + Trim(copy(StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]),1,15)) + ''')'
        else
          selSG651.Filter:='';
        selSG651.Filtered:=True;
      end;
    end;
  if SalvaItem <> rgpTipoRichieste.ItemIndex then
  begin
    SalvaItem:=rgpTipoRichieste.ItemIndex;
    Primo:=True;
  end;
  if Sender <> nil then //Se chiamato dal Render non faccio il refresh
    rgpTipoIscrizioniClick(btnVisualizza);
end;

procedure TW014FPianifCorsi.btnVisCorsiClick(Sender: TObject);
var
  sDep: string;
begin
  if cmbCorso.Text <> '' then
  begin
    sDep:=StringReplace(cmbCorso.Text,SPAZIO,' ',[rfReplaceAll]);
    sDep:=Trim(copy(sDep,16,Length(sDep)));
    sDep:=AggiungiApice(sDep);
    //GGetWebApplicationThreadVar.ShowMessage(sDep);
    MsgBox.MessageBox(sDep,INFORMA,'Descrizione estesa del corso');
  end
  else
    //GGetWebApplicationThreadVar.ShowMessage('Nessun corso selezionato.');
    MsgBox.MessageBox('Nessun corso selezionato.',INFORMA);
end;

procedure TW014FPianifCorsi.btnVisualizzaClick(Sender: TObject);
begin
  inherited;
  // Rimando a rgpTipoIscrizioniClick anche se sono entrato come responsabile: verrà gestito lì dentro
  rgpTipoIscrizioniClick(btnVisualizza);
end;

procedure TW014FPianifCorsi.DistruggiOggetti;
begin
  if ListaCorsi <> nil then
    FreeAndNil(ListaCorsi);
  if ListaEdizioni <> nil then
    FreeAndNil(ListaEdizioni);
  if ListaGiornate <> nil then
    FreeAndNil(ListaGiornate);
  if ListaDipendenti <> nil then
    FreeAndNil(ListaDipendenti);
  if R100 <> nil then
    FreeAndNil(R100);
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selSG651.CloseAll; except end;
    try WR000DM.selSG650.CloseAll; except end;
    try WR000DM.selSG650c.CloseAll; except end;
    try WR000DM.selSG650Giorn.CloseAll; except end;
    try WR000DM.selSG650Ediz.CloseAll; except end;
    try WR000DM.selSG654.CloseAll; except end;
  end;
end;

end.
