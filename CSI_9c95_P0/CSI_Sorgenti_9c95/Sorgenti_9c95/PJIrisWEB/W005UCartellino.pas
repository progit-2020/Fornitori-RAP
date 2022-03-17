unit W005UCartellino;

interface

uses
  SysUtils, StrUtils, Classes, Graphics, Controls, IWApplication,
  R012UWEBANAGRAFICO, R500Lin, IWTemplateProcessorHTML, IWCompLabel,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  IWCompButton, OracleData, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  IWCompCheckbox, Rp502Pro, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  R010UPAGINAWEB, IWVCLComponent, DatiBloccati,
  WC001ULegendaCalendarioFM, A023UAllTimbMW, meIWGrid,
  meIWEdit, Oracle, C190FunzioniGeneraliWeb, W005UCartellinoDtm, meIWLabel,
  IWCompGrids, meIWLink, meIWCheckBox, meIWComboBox, meIWButton, A023UTimbratureMW, WA023UValidaAssenzeFM,
  IW.Browser.InternetExplorer, A000UMessaggi, W000UMessaggi, IWCompExtCtrls, meIWImageFile;

const
  COL_F = 1;
  COL_G = 1;

type
  TTimbrature = record
    Ora:Integer;
    Verso:String;
    Causale:String;
    Ril:String;
    Flag:String;
    IdRichiesta:Integer;// commessa MAN/02 - SVILUPPO 92
    RowId:String;
  end;

  TGiustificativi = record
    Causale:String;
    Descrizione:String;
    Tipo:String;
    TipoMG:String;
    Dalle:Integer;
    Alle:Integer;
    RowId:String;
    Richiesta:Boolean;
    Validata:String;//S:Assenza Validata, N:Assenza da Validare,  :Assenza senza bisogno di validazione
    Note:String;
  end;

  TCartellino = record
    Data:TDateTime;
    Lavorativo:Boolean;
    Festivo:Boolean;
    Domenica:Boolean;
    Timbrature:array of TTimbrature;
    Giustificativi:array of TGiustificativi;
  end;

  TW005FCartellino = class(TR012FWebAnagrafico)
    btnEsegui: TmeIWButton;
    lblPeriodoDal: TmeIWLabel;
    edtDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtAl: TmeIWEdit;
    lblCausPresDisponibili: TmeIWLabel;
    cmbCausPresDisponibili: TmeIWComboBox;
    btnApplica: TmeIWButton;
    chkConteggi: TmeIWCheckBox;
    lblCausAssDisponibili: TmeIWLabel;
    cmbCausAssDisponibili: TmeIWComboBox;
    lblPeriodo: TmeIWLabel;
    lnkLegendaColoriGiorni: TmeIWLink;
    lblLegende: TmeIWLabel;
    grdCartellino: TmeIWGrid;
    lblCartellinoCaption: TmeIWLabel;
    btnValidaAssenze: TmeIWButton;
    imgPrecedente: TmeIWImageFile;
    imgSuccessivo: TmeIWImageFile;
    grdRiepilogoSaldi: TmeIWGrid;
    lblRiepilogoSaldiCaption: TmeIWLabel;
    lblUscitaNominaleGGCorr: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdCartellinoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure chkConteggiClick(Sender: TObject);
    procedure NuovaTimbraturaSubmit(Sender: TObject);
    procedure btnApplicaClick(Sender: TObject);
    procedure grdCartellinoCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure btnValidaAssenzeClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgPrecedenteClick(Sender: TObject);
    procedure grdRiepilogoSaldiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    ColF,ColNuovaTimb:Integer;
    Dal,Al:TDateTime;
    Cartellino:array of TCartellino;
    R502ProDtM1:TR502ProDtM1;
    lstAnomalie:TStringList;
    AbilGiustif,AbilPianif,AbilSegnalazioneTimb,OldResponsabile: Boolean;
    IWC:TIWCustomControl;
    W005Dtm: TW005FCartellinoDtm;
    A023FAllTimbW005:TA023FAllTimbMW;
    A023MW: TA023FTimbratureMW;
    WA023FValidaAssenzeFM: TWA023FValidaAssenzeFM;
    function ElaboraTimbratura(T,Oper:String; Giorno,Timb:Integer; Data:TDateTime):String;
    procedure GetCausaliDisponibili;
    procedure VisualizzaCartellino;
    procedure WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    function  GetInfoFunzione: String; override;
  public
    bDettaglioGG: Boolean;
    procedure InizializzaDaMainMenu;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W008UGiustificativi,
     W010URichiestaAssenze,
     W018URichiestaTimbrature,
     W023UPianifOrari;

{$R *.DFM}

procedure TW005FCartellino.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  // salva il flag responsabile in una variabile per eventuale ripristino in chiusura
  // (se la form non viene aggiunta alla history)
  OldResponsabile:=WR000DM.Responsabile;

  W005Dtm:=TW005FCartellinoDtm.Create(nil);

  bDettaglioGG:=False;

  if WR000DM.TipoUtente <> 'Dipendente' then
    R502ProDtM1:=TR502ProDtM1.Create(Self);
  lstAnomalie:=TStringList.Create;

  // inizializzazione causali disponibili
  GetCausaliDisponibili;

  AbilGiustif:=(A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'N') or
               (A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N') or
               (WR000DM.Responsabile and (A000GetInibizioni('Funzione','OpenW010AutorizzAssenze') <> 'N'));
  AbilPianif:=A000GetInibizioni('Tag','425') <> 'N';
  AbilSegnalazioneTimb:=(A000GetInibizioni('Tag',IfThen(Parametri.InibizioneIndividuale,'418','419')) <> 'N');

  btnApplica.Visible:=(not SolaLettura);
  btnValidaAssenze.Visible:=(not SolaLettura);

  ColNuovaTimb:=-1;
  //chkConteggi.Checked:=True; // solo per debug!!!
  SelezionePeriodica:=True;

  with WR000DM do
  begin
    selT265.Tag:=selT265.Tag + 1;
    selT275.Tag:=selT275.Tag + 1;
  end;

  A023MW:=TA023FTimbratureMW.Create(Self);
end;

procedure TW005FCartellino.InizializzaDaMainMenu;
//Inizializzazioni parametri se chiamata dal menu principale
begin
  if StrToIntDef(Parametri.CampiRiferimento.C90_W005Settimane,0) > 0 then
  begin
    Dal:=Parametri.DataLavoro - (DayOfWeek(Parametri.DataLavoro - 1) - 1);
    Dal:=Dal - ((StrToIntDef(Parametri.CampiRiferimento.C90_W005Settimane,0) - 1) * 7);
    Al:=Parametri.DataLavoro + (7 - DayOfWeek(Parametri.DataLavoro - 1));
  end
  else
  begin
    Dal:=R180InizioMese(Parametri.DataLavoro);
    Al:=R180FineMese(Parametri.DataLavoro);
  end;
  SetParam('DAL',Dal);
  SetParam('AL',Al);
  SetParam('SINGOLO',False);
end;

function TW005FCartellino.InizializzaAccesso:Boolean;
var
  Trovato: Boolean;
begin
  Result:=True;
  if bDettaglioGG then
    SolaLettura:=True;

  // imposta periodo visualizzazione in base a parametro aziendale
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  edtDal.Text:=DateToStr(Dal);
  edtAl.Text:=DateToStr(Al);

  selAnagrafeW.Filter:='PROGRESSIVO = ' + IntToStr(ParametriForm.Progressivo);
  selAnagrafeW.Filtered:=ParametriForm.Singolo;
  // selezione dipendenti periodica
  // (solo se utente supervisore oppure dipendente con filtro anagrafe impostato)
  if (WR000DM.TipoUtente = 'Dipendente') and
     (Parametri.Inibizioni.Text = '') then
    GetDipendentiDisponibili(Al)
  else
    GetDipendentiDisponibili(Dal,Al);
  Trovato:=selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  // chiamata da dettaglio giornaliero
  if (bDettaglioGG) and (not Trovato) then
    raise Exception.Create('Il dipendente selezionato non è presente nel proprio filtro anagrafe.'#13#10'Impossibile visualizzare il dettaglio!');

  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(A023MW);
  // se la form non è aggiunta alla history, ripristina il flag responsabile originale
  if not medpAddToHistory then
    WR000DM.Responsabile:=OldResponsabile;
  inherited;
end;

procedure TW005FCartellino.RefreshPage;
begin
  WR000DM.selT265.Filtered:=False;
  WR000DM.selT275.Filtered:=False;
  VisualizzaDipendenteCorrente;
  if chkConteggi.Checked then
    chkConteggiClick(nil);
end;

procedure TW005FCartellino.btnEseguiClick(Sender: TObject);
var PeriodoCambiato:Boolean;
begin
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtDal.Text)) or (Al <> StrToDate(edtAl.Text));
    Dal:=StrToDate(edtDal.Text);
    Al:=StrToDate(edtAl.Text);
    if Al < Dal then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
    if Al - Dal >= 366 then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_LUNGO));
    if Dal < Parametri.WEBCartelliniDataMin then
    begin
      GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W005_ERR_FMT_STOP_DATA_ANTECEDENTE),[DateToStr(Parametri.WEBCartelliniDataMin)]));
      PeriodoCambiato:=True;
      Dal:=Parametri.WEBCartelliniDataMin;
      edtDal.Text:=DateToStr(Dal);
      if Al < Dal then
      begin
        Al:=Dal;
        edtAl.Text:=DateToStr(Al);
      end;
    end;
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;

  if PeriodoCambiato then
  begin
    // salva parametri form
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;

    // effettua selezione dipendenti periodica nei seguenti due casi:
    // a. utente supervisore oppure
    // b. dipendente con filtro anagrafe impostato
    if (WR000DM.TipoUtente = 'Dipendente') and
       (Trim(Parametri.Inibizioni.Text) = '') then
      GetDipendentiDisponibili(Al)
    else
      GetDipendentiDisponibili(Dal,Al);
  end;

  lstAnomalie.Clear;
  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.btnValidaAssenzeClick(Sender: TObject);
var i,j:Integer;
    StrCaus:String;
begin
  for i:=0 to High(Cartellino) do
    for j:=0 to High(Cartellino[i].Giustificativi) do
      if (Cartellino[i].Giustificativi[j].Causale <> '')
      and (Cartellino[i].Giustificativi[j].Validata = 'N')
      and (A000FiltroDizionario('CAUSALI ASSENZA',Cartellino[i].Giustificativi[j].Causale))
      and (Pos(',' + Cartellino[i].Giustificativi[j].Causale + ',',',' + StrCaus + ',') <= 0) then
        StrCaus:=StrCaus + IfThen(StrCaus <> '',',') + Cartellino[i].Giustificativi[j].Causale;
  WA023FValidaAssenzeFM:=TWA023FValidaAssenzeFM.Create(Self);
  WA023FValidaAssenzeFM.A023MW:=A023MW;
  WA023FValidaAssenzeFM.btnChiudi.OnClick:=WA023FValidaAssenzaFM_btnChiudiClick;
  WA023FValidaAssenzeFM.Visualizza(ParametriForm.Progressivo,Dal,Al,StrCaus);
end;

procedure TW005FCartellino.WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
begin
  inherited;
  if WA023FValidaAssenzeFM.ElaborazioneEseguita then
    btnEseguiClick(nil);
  WA023FValidaAssenzeFM.Free;
end;

procedure TW005FCartellino.GetCausaliDisponibili;
begin
  with WR000DM do
  begin
    // causali di presenza
    cmbCausPresDisponibili.Items.Clear;
    selT275.Close;
    selT275.Filtered:=False;
    selT275.Open;
    while not selT275.Eof do
    begin
      cmbCausPresDisponibili.Items.Add(StringReplace(Format('%-5s %s',[selT275.FieldByName('CODICE').AsString,selT275.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      selT275.Next;
    end;
    cmbCausPresDisponibili.RequireSelection:=cmbCausPresDisponibili.Items.Count > 0;

    // causali di assenza
    cmbCausAssDisponibili.Items.Clear;
    selT265.Close;
    selT265.Filtered:=False;
    selT265.Open;
    while not selT265.Eof do
    begin
      cmbCausAssDisponibili.Items.Add(StringReplace(Format('%-5s %s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      selT265.Next;
    end;
    //CloseAll;
    //R180CloseDataSetTag0(WR000DM.selT265);
  end;
  cmbCausAssDisponibili.RequireSelection:=cmbCausAssDisponibili.Items.Count > 0;
end;

procedure TW005FCartellino.VisualizzaDipendenteCorrente;
begin
  inherited;
  // salva parametri
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  with W005DtM do
  begin
    // timbrature
    selT100.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selT100.SetVariable('DAL',Dal);
    selT100.SetVariable('AL',Al);
    selT100.Close;
    selT100.Open;
    // giustificativi
    selT040.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selT040.SetVariable('DAL',Dal);
    selT040.SetVariable('AL',Al);
    selT040.Close;
    selT040.Open;
    //giustificativi non ancora elaborati
    selT050.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selT050.SetVariable('DAL',Dal);
    selT050.SetVariable('AL',Al);
    selT050.Close;
    selT050.Open;
    //calendari
    selV010.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selV010.SetVariable('DAL',Dal);
    selV010.SetVariable('AL',Al);
    selV010.Close;
    selV010.Open;
    VisualizzaCartellino;
  end;
end;

procedure TW005FCartellino.VisualizzaCartellino;
var D:TDateTime;
    i,j,c,MaxT,MaxG,NumGiust:Integer;
    Timbratura,Causale,Rilevatore,Durata,ElencoGiust:String;
    Validaz,anm:String;
    TotOreReseTotali,TotDebitoGg,TotScost,TotMinLavEsc:Integer;
  function GetAnomalieCSI:String;
  var i:Integer;
      idAnomalia:String;
  begin
    Result:='';
    //if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
      with R502ProDtM1 do
      begin
        for i:=0 to lstAnomalieGG.Count - 1 do
        begin
          (*
          if (lstAnomalieGG[i].Livello = 1) and (lstAnomalieGG[i].Num in [2]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
          else if (lstAnomalieGG[i].Livello = 2) and (lstAnomalieGG[i].Num in [22,31]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
          else if (lstAnomalieGG[i].Livello = 3) and (lstAnomalieGG[i].Num in [6,9,10]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
          *)
          idAnomalia:='A' + lstAnomalieGG[i].Livello.ToString + '_' + lstAnomalieGG[i].Num.ToString;
          if (lstAnomalieGG[i].Livello = 1) or (not A000FiltroDizionario('ANOMALIE NASCOSTE SU CARTELLINO WEB',idAnomalia)) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione;
        end;
      end;
  end;
begin
  WR000DM.selT361.Open;
  //Inizializzazione tabella in memoria
  for i:=0 to High(Cartellino) do
  begin
    SetLength(Cartellino[i].Timbrature,0);
    SetLength(Cartellino[i].Giustificativi,0);
  end;
  SetLength(Cartellino,Trunc(Al - Dal) + 1);
  with TOracleQuery.Create(Self) do
  begin
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT MAX(MAXTIMB)');
      SQL.Add('FROM(');
      SQl.Add('SELECT T100.DATA, COUNT(*) AS MAXTIMB');
      SQL.Add('FROM T100_TIMBRATURE T100');
      SQL.Add('WHERE T100.DATA BETWEEN :INDATADA AND :INDATAA');
      SQL.Add('AND T100.PROGRESSIVO = :INPROG');
      SQL.Add('GROUP BY T100.DATA)');
      DeclareVariable('INDATADA',otDate);
      DeclareVariable('INDATAA',otDate);
      DeclareVariable('INPROG',otInteger);
      SetVariable('INDATADA',Dal);
      SetVariable('INDATAA',Al);
      SetVariable('INPROG',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      Execute;
      MaxT:=FieldAsInteger(0);
    finally
      Free;
    end;
  end;

  btnValidaAssenze.Enabled:=False;
  MaxG:=0;
  //Lettura dati in memoria
  D:=Dal;
  i:=0;
  if chkConteggi.Checked then
  begin
    // uso di ResettaProg.ini
    // (non applicato per errori di access violation)
    if R502ProDtM1 = nil then
      R502ProDtM1:=TR502ProDtM1.Create(Self);
    //R502ProDtM1.ResettaProg;
    // utilizzo di ResettaProg.fine

    R502ProDtM1.ConsideraRichiesteWeb:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
    R502ProDtM1.FiltroDizionarioAnomalie:=True;
    R502ProDtM1.PeriodoConteggi(Dal,Dal - 1);
    R502ProDtM1.PeriodoConteggi(Dal,Al);

    // apertura dataset della pianif. orari
    with W005DtM.selT080 do
    begin
      Close;
      SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DataInizio',Dal);
      SetVariable('DataFine',Al);
      Open;
    end;
  end;
  while D <= Al do
  begin
    Cartellino[i].Data:=D;
    Cartellino[i].Domenica:=DayOfWeek(D) = 1;
    Cartellino[i].Lavorativo:=False;
    Cartellino[i].Festivo:=False;
    // calendario
    with W005DtM.selV010 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        Cartellino[i].Lavorativo:=FieldByName('LAVORATIVO').AsString = 'S';
        Cartellino[i].Festivo:=FieldByName('FESTIVO').AsString = 'S';
      end;
    end;
    // timbrature
    with W005DtM.selT100 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        j:=0;
        repeat
          SetLength(Cartellino[i].Timbrature,j + 1);
          Cartellino[i].Timbrature[j].RowId:=RowId;
          Cartellino[i].Timbrature[j].Ora:=R180OreMinuti(FieldByName('ORA').AsDateTime);
          Cartellino[i].Timbrature[j].Verso:=FieldByName('VERSO').AsString;
          Cartellino[i].Timbrature[j].Causale:=FieldByName('CAUSALE').AsString;
          Cartellino[i].Timbrature[j].Ril:=FieldByName('RILEVATORE').AsString;
          Cartellino[i].Timbrature[j].Flag:=FieldByName('FLAG').AsString;
          Cartellino[i].Timbrature[j].IdRichiesta:=FieldByName('ID_RICHIESTA').AsInteger; // commessa MAN/02 - SVILUPPO 92
          inc(j);
        until not SearchRecord('Data',D,[]);
      end;
    end;
    // giustificativi
    with W005DtM.selT040 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        j:=0;
        repeat
          //non viusalizzo i giustificativi se non appartenenti al filtro dizionario
          if (not A000FiltroDizionario('CAUSALI SUL CARTELLINO',FieldByName('CAUSALE').AsString)) then
            Continue;
          SetLength(Cartellino[i].Giustificativi,j + 1);
          Cartellino[i].Giustificativi[j].RowId:=RowId;
          Cartellino[i].Giustificativi[j].Causale:=FieldByName('CAUSALE').AsString;
          Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT265.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
          if Trim(Cartellino[i].Giustificativi[j].Descrizione) = '' then
            Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT275.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
          Cartellino[i].Giustificativi[j].Tipo:=FieldByName('TIPOGIUST').AsString;
          Cartellino[i].Giustificativi[j].TipoMG:=FieldByName('CSI_TIPO_MG').AsString;
          Cartellino[i].Giustificativi[j].Dalle:=R180OreMinuti(FieldByName('DAORE').AsDateTime);
          Cartellino[i].Giustificativi[j].Alle:=R180OreMinuti(FieldByName('AORE').AsDateTime);
          Cartellino[i].Giustificativi[j].Richiesta:=False;
          Cartellino[i].Giustificativi[j].Note:=FieldByName('NOTE').AsString;
          Validaz:=VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('Causale').AsString,'VALIDAZIONE'));
          if (Validaz <> '') and (Validaz <> 'N') then
            if FieldByName('SCHEDA').AsString = 'V' then
              Cartellino[i].Giustificativi[j].Validata:='S'
            else
            begin
              Cartellino[i].Giustificativi[j].Validata:='N';
              btnValidaAssenze.Enabled:=True;
            end;
          inc(j);
        until not SearchRecord('Data',D,[]);
      end;
    end;
    // giustificativi non ancora elaborati
    with W005DtM.selT050 do
    begin
      First;
      while not Eof do
      begin
        //non viusalizzo i giustificativi se non appartenenti al filtro dizionario
        if (not A000FiltroDizionario('CAUSALI SUL CARTELLINO',FieldByName('CAUSALE').AsString)) then
        begin
          Next;
          Continue;
        end;
        if (D >= FieldByName('DAL').AsDateTime) and (D <= FieldByName('AL').AsDateTime) then
        begin
          if (Parametri.CampiRiferimento.C90_W010CausPres = 'S')
          and (VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'CODICE')) = '') then
            W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC','GC')
          else
            W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC',VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'GSIGNIFIC')));
          W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('DATA',D);
          W005DtM.T010F_GGSIGNIFICATIVO.Execute;
          if (VarToStr(W005DtM.T010F_GGSIGNIFICATIVO.GetVariable('SIGNIFICATIVO')) = 'S') then
          begin
            SetLength(Cartellino[i].Giustificativi,Length(Cartellino[i].Giustificativi) + 1);
            j:=Length(Cartellino[i].Giustificativi) - 1;
            Cartellino[i].Giustificativi[j].RowId:=RowId;
            Cartellino[i].Giustificativi[j].Causale:=FieldByName('CAUSALE').AsString;
            Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT265.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
            if Trim(Cartellino[i].Giustificativi[j].Descrizione) = '' then
              Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT275.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
            Cartellino[i].Giustificativi[j].Tipo:=FieldByName('TIPOGIUST').AsString;
            Cartellino[i].Giustificativi[j].TipoMG:=FieldByName('CSI_TIPO_MG').AsString;
            Cartellino[i].Giustificativi[j].Dalle:=R180OreMinutiExt(FieldByName('NUMEROORE').AsString);
            Cartellino[i].Giustificativi[j].Alle:=R180OreMinutiExt(FieldByName('AORE').AsString);
            Cartellino[i].Giustificativi[j].Richiesta:=True;
          end;
        end;
        Next;
      end;
    end;
    if Length(Cartellino[i].Timbrature) > MaxT then
      MaxT:=Length(Cartellino[i].Timbrature);
    if Length(Cartellino[i].Giustificativi) > MaxG then
      MaxG:=Length(Cartellino[i].Giustificativi);
    D:=D + 1;
    inc(i);
  end;
  // Deallocazione controlli della griglia e pulizia dati
  for i:=0 to grdCartellino.RowCount - 1 do
    for j:=0 to grdCartellino.ColumnCount - 1 do
    begin
      if grdCartellino.Cell[i,j].Control <> nil then
      begin
        IWC:=grdCartellino.Cell[i,j].Control;
        grdCartellino.Cell[i,j].Control:=nil;
        FreeAndNil(IWC);
      end;
      grdCartellino.Cell[i,j].Css:='';
      grdCartellino.Cell[i,j].Clickable:=False;
      grdCartellino.Cell[i,j].Text:='';
    end;

  if (chkConteggi.Checked) (*and (Parametri.ModuloInstallato['TORINO_CSI_PRV'])*) then
  begin
    lstAnomalie.Add('AnomalieCSI');
  end;

  // Caricamento della griglia
  grdCartellino.RowCount:=Trunc(Al - Dal) + 2;
  ColF:=COL_F + IfThen(lstAnomalie.Count > 0,1) +
        IfThen(chkConteggi.Checked,2) +
        IfThen((not SolaLettura) and (Parametri.InserisciTimbrature = 'S'),1);
  grdCartellino.ColumnCount:=ColF + COL_G + 1;

  // caption tabella
  if (Dal = R180InizioMese(Dal)) and (Al = R180FineMese(Dal)) then
    lblCartellinoCaption.Caption:='Cartellino del mese di ' + FormatDateTime('mmmm yyyy',Dal)
  else
    lblCartellinoCaption.Caption:=Format('Cartellino dal %s al %s',[edtDal.Text,edtAl.Text]);

  // intestazione
  c:=0;
  // data
  grdCartellino.Cell[0,c].Text:='Data';
  grdCartellino.Cell[0,c].Css:='';
  inc(c);
  // anomalie
  if (lstAnomalie.Count > 0) then
  begin
    grdCartellino.Cell[0,c].Text:='Anomalie';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);
  end;
  // conteggi
  if (chkConteggi.Checked) then
  begin
    grdCartellino.Cell[0,c].Text:='Saldo gg';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);

    grdCartellino.Cell[0,c].Text:='Orario';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);
  end;
  // giustificativi
  grdCartellino.Cell[0,c].Text:='Giustificativi';
  grdCartellino.Cell[0,c].Css:='';
  inc(c);
  // cella per nuova timbratura
  if (not SolaLettura) and (Parametri.InserisciTimbrature = 'S') then
  begin
    ColNuovaTimb:=c;
    grdCartellino.Cell[0,c].Text:='Nuova';
    inc(c);
  end;
  // timbrature
  grdCartellino.Cell[0,C].Text:='Timbrature';

  // dati
  TotOreReseTotali:=0;
  TotDebitoGg:=0;
  TotScost:=0;
  TotMinLavEsc:=0;
  for i:=0 to High(Cartellino) do
  begin
    with Cartellino[i] do
    begin
      c:=0;
      // data
      with grdCartellino.Cell[i + 1,c] do
      begin
        Text:=FormatDateTime('dd/mm',Data) + Format(' (%s)',[Copy(FormatDateTime('dddd',Data),1,2)]);
        Hint:=IntToStr(Trunc(Data));
        ShowHint:=False;
        Clickable:=(ParametriForm.Chiamante <> 'W018') and  // evita loop tra form
                   (AbilSegnalazioneTimb) and
                   (Data <= Trunc(Date)) and
                   not bDettaglioGG;
        Css:='bg_trasparente';
        if Festivo and (not Lavorativo) then
          Css:='bg_aqua'
        else if Festivo then
          Css:='bg_giallo'
        else if not Lavorativo then
          Css:='bg_lime';
        Css:=Css + ' ' + IfThen(Domenica,'font_rosso','comandi');
      end;
      inc(c);

       //Richiamo conteggi e carico eventuali anomalie da visualizzare (per TORINO_CSI)
      if (chkConteggi.Checked) then
      begin
        R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);
        anm:=GetAnomalieCSI;
        if anm <> '' then
          lstAnomalie.Add(Format('%s=%s',[DateToStr(Data),anm]));
      end;

      // anomalie
      if (lstAnomalie.Count > 0) then
      begin
        with grdCartellino.Cell[i + 1,c] do
        begin
          if (lstAnomalie.IndexOfName(DateToStr(Data)) >= 0) then
          begin
            Hint:='Anomalia';
            ShowHint:=True;
            Text:=lstAnomalie.Values[DateToStr(Data)];
            Css:='segnalazione';
          end
          else
          begin
            Text:='';
            Css:='comandi';
          end;
        end;
        inc(c);
      end;

      // conteggi
      if (chkConteggi.Checked) then
      begin
        //R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);

        // daniloc. - allineamento automatico timbrature
        // in caso di errore di tipo "timbrature non in sequenza"
        if R502ProDtM1.Blocca = 2 then
        begin
          // crea oggetto per allineamento timbrature uguali
          A023FAllTimbW005:=TA023FAllTimbMW.Create(nil);
          try
            try
              // allineamento timbrature
              A023FAllTimbW005.Q100.Session:=SessioneOracle;
              A023FAllTimbW005.Q100Upd.Session:=SessioneOracle;
              A023FAllTimbW005.Allinea(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);

              // timbrature
              with W005DtM.selT100 do
              begin
                Refresh;
                if SearchRecord('Data',Data,[srFromBeginning]) then
                begin
                  j:=0;
                  repeat
                    SetLength(Cartellino[i].Timbrature,j + 1);
                    Cartellino[i].Timbrature[j].RowId:=RowId;
                    Cartellino[i].Timbrature[j].Ora:=R180OreMinuti(FieldByName('ORA').AsDateTime);
                    Cartellino[i].Timbrature[j].Verso:=FieldByName('VERSO').AsString;
                    Cartellino[i].Timbrature[j].Causale:=FieldByName('CAUSALE').AsString;
                    Cartellino[i].Timbrature[j].Ril:=FieldByName('RILEVATORE').AsString;
                    Cartellino[i].Timbrature[j].Flag:=FieldByName('FLAG').AsString;
                    inc(j);
                  until not SearchRecord('Data',Data,[]);
                end;
              end;

              R502ProDtM1.ResettaProg;
              R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);
            except
              on E:Exception do
                Log('Errore','Allineamento timbrature uguali: ' + E.ClassName + '/' + E.Message);
            end;
          finally
            try FreeAndNil(A023FAllTimbW005); except end;
          end;
        end;
        // allineamento automatico timbrature.fine

        // saldi gg
        with grdCartellino.Cell[i + 1,c] do
        begin
          Hint:='';
          ShowHint:=False;
          Css:='conteggi' + ' ' + 'align_right';
          if R502ProDtM1.Blocca = 0 then
          begin
            Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                  R180MinutiOre(R502ProDtM1.OreReseTotali) + '</span><br/>' +
                  '<span style="color: #008800; cursor: default;" title="Debito giornaliero">' +
                  R180MinutiOre(R502ProDtM1.debitogg) + '</span><br/>' +
                  '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                  R180MinutiOre(R502ProDtM1.scost) + '</span><br/>' +
                  '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                  R180MinutiOre(R502ProDtM1.minlavesc);
            TotOreReseTotali:=TotOreReseTotali + R502ProDtM1.OreReseTotali;
            TotDebitoGg:=TotDebitoGg + R502ProDtM1.debitogg;
            TotScost:=TotScost + R502ProDtM1.scost;
            TotMinLavEsc:=TotMinLavEsc + R502ProDtM1.minlavesc;
          end
          else
          begin
            // anomalia bloccante
            Text:='<span style="cursor: default;" title="Anomalia bloccante: ' + R502ProDtM1.DescAnomaliaBloccante + '">' +
                  '&nbsp;<br/>Anom.<br/>&nbsp;</span>';
            Css:=Css + ' ' + 'segnalazione';
          end;
        end;
        inc(c);

        // orario (pianificazione)
        with grdCartellino.Cell[i + 1,c] do
        begin
          Clickable:=AbilPianif and not bDettaglioGG;
          Css:='';
          Text:='';
          if R502ProDtM1.cdsT020.Active then
          begin
            Hint:=R502ProDtM1.cdsT020.FieldByName('DESCRIZIONE').AsString;
            if AbilPianif then
              Hint:=Hint + ' - Pianificazione giornaliera';

            ShowHint:=True;
          end;
          if R502ProDtM1.pianif = 'no' then
            Text:=R502ProDtM1.c_orario
          else
          begin
            with W005DtM.selT080 do
              if SearchRecord('Data',Data,[srFromBeginning]) then
              begin
                Text:=FieldByName('ORARIO').AsString;
                Css:=Css + ' ' + 'font_rosso';
              end;
          end;
        end;
        inc(c);
      end;

      // giustificativi
      NumGiust:=Min(Length(Giustificativi),10); //*** stabilire n° max di giust. da visualizzare (per ora 10)
      with grdCartellino.Cell[i + 1,c] do
      begin
        Css:='';
        Clickable:=AbilGiustif and not bDettaglioGG;
        ShowHint:=True;
        if NumGiust = 0 then
        begin
          if not bDettaglioGG then
          begin
            Text:='_____';
            Hint:=A000TraduzioneStringhe(A000MSG_W005_MSG_NUOVOGIUST);
		      end;
        end
        else
        begin
          // concatena l'elenco dei giustificativi del giorno
          Css:='bg_rosa';
          ElencoGiust:='';
          for j:=0 to NumGiust - 1 do
          begin
            Durata:=Giustificativi[j].Tipo;
            if Durata = 'M' then
            begin
              if Giustificativi[j].TipoMG <> '' then
                Durata:=IfThen(Giustificativi[j].TipoMG = 'M','matt','pom');
            end
            else if Durata = 'N' then
              Durata:=R180MinutiOre(Giustificativi[j].Dalle)
            else if Durata = 'D' then
              Durata:=R180MinutiOre(Giustificativi[j].Dalle) + '/' +
                      R180MinutiOre(Giustificativi[j].Alle);
            if not Giustificativi[j].Richiesta then
              Css:='bg_rosso';
            ElencoGiust:=ElencoGiust + '<div class="' + IfThen(Giustificativi[j].Richiesta,'bg_rosa','bg_rosso') + ' ' + IfThen(Giustificativi[j].Validata = 'N','fontAcqua',IfThen(Giustificativi[j].Richiesta,'fontBlack','fontWhite')) + '">' + Giustificativi[j].Causale + IfThen(Giustificativi[j].Note <> '','[' + Giustificativi[j].Note + ']') + '(' + Durata + ')' + '</div>';
          end;
          Hint:=Giustificativi[0].Descrizione + ' - ' + A000TraduzioneStringhe(A000MSG_W005_MSG_GIUSTIFICATIVI);
          Text:=Copy(ElencoGiust,1,Length(ElencoGiust) - 3);
        end;
      end;
      inc(c);

      // cella per nuova timbratura
      if (not SolaLettura) and (Parametri.InserisciTimbrature = 'S') then
      begin
        grdCartellino.Cell[i + 1,c].Control:=TmeIWEdit.Create(Self);
        with (grdCartellino.Cell[i + 1,c].Control as TmeIWEdit) do
        begin
          Hint:='Inserimento nuova timbratura: ' + A000MSG_W005_MSG_FORMATO_TIMB;
          FriendlyName:=IntToStr(i + 1);
          Tag:=Trunc(Data);
          Text:='';
          CSS:='inputW005';
          Editable:=True;
          DoSubmitValidation:=False;
          OnSubmit:=NuovaTimbraturaSubmit;
          RenderSize:=False;
          Font.Enabled:=False;
        end;
        inc(c);
      end;
      if High(Timbrature) >= 0 then
      begin
        grdCartellino.Cell[i + 1,c].Control:=TmeIWGrid.Create(Self);
        with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid) do
        begin
          Css:='gridComandi';
          FriendlyName:='ListaTimbrature' + IntToStr(i + 1);
          ColumnCount:=MaxT;
          RowCount:=1;
        end;
      end;
      // timbrature
      for j:=0 to High(Timbrature) do
      begin
        Rilevatore:='';
        if Timbrature[j].Ril <> '' then
          Rilevatore:='(' + Timbrature[j].Ril + ')';
        Causale:='';
        if Timbrature[j].Causale <> '' then
          Causale:='/' + Timbrature[j].Causale;
        Timbratura:=Timbrature[j].Verso +
                    {StringReplace(R180MinutiOre(Timbrature[j].Ora),'.','',[])}
                    R180MinutiOre(Timbrature[j].Ora);
        // componente edit per timbratura
        with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j] do
        begin
          Control:=TmeIWEdit.Create(Self);
          Css:='width15chrW005';
        end;
        with ((grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j].Control as TmeIWEdit) do
        begin
          FriendlyName:=IntToStr(i + 1);
          Tag:=Trunc(Data);
          Text:=Timbratura + Causale + Rilevatore;
          // NON UTILIZZARE EDITABLE (NON VISUALIZZA IL COLORE ROSSO DELLE TIMBRATURE ORIGINALI E DISABILITA L'HINT)
          //Editable:=(not SolaLettura);
          ReadOnly:=SolaLettura;
          Hint:='Timbratura di ' +
                IfThen(Timbrature[j].Verso = 'E','entrata','uscita') +
                ' alle ore ' + R180MinutiOre(Timbrature[j].Ora) +
                IfThen(Timbrature[j].Causale <> '',' con causale ' + Timbrature[j].Causale,'') +
                IfThen(Timbrature[j].Ril <> '',' sul rilevatore ' + Timbrature[j].Ril + ' ' + VarToStr(WR000DM.selT361.Lookup('CODICE',Timbrature[j].Ril,'DESCRIZIONE')),'');
          if (getBrowser is TInternetExplorer) and (GetBrowser.MajorVersion = 6) then
            Css:='inputW005IE6' + ' ' + IfThen(Timbrature[j].Verso = 'E','bg_lime','bg_aqua')
          else
            Css:='inputW005' + ' ' + IfThen(Timbrature[j].Verso = 'E','bg_lime','bg_aqua');
          if Timbrature[j].Flag = 'O' then
            Css:=Css + ' ' + 'font_rosso'; // timb. originale

          RenderSize:=False;
          Font.Enabled:=False;
        end;
      end;
      if grdCartellino.Cell[i + 1,c].Control <> nil then
      begin
        for j:=0 to MaxT - 1 do
        begin
          with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j] do
          begin
            if Control = nil then
            begin
              Css:='width15chrW005';
              Text:='&nbsp;';
            end;
          end;
        end;
      end;
      //inc(c);
    end;
  end;

  lblUscitaNominaleGGCorr.Visible:=chkConteggi.Checked and R180Between(Date,Dal,Al) and (Parametri.CampiRiferimento.C90_W005Riepilogo = 'S');
  if lblUscitaNominaleGGCorr.Visible then
  begin
    R502ProDtM1.ResettaProg;
    R502ProDtM1.IgnTimbNonInSeqForzata:=True;
    try
      R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Date);
      if (R502ProDtM1.Blocca > 0) or ((R502ProDtM1.TipoOrario = 'D') and (R502ProDtM1.PeriodoLavorativo = 'L')) then
        lblUscitaNominaleGGCorr.Visible:=False
      else
        lblUscitaNominaleGGCorr.Caption:='L''uscita odierna è prevista alle ore ' + R180MinutiOre(R502ProDtM1.UscitaTeorica);
    finally
      R502ProDtM1.IgnTimbNonInSeqForzata:=False;
    end;
  end;

  if WR000DM.TipoUtente = 'Dipendente' then
    FreeAndNil(R502ProDtM1);
  // Caricamento griglia riepilogo saldi
  grdRiepilogoSaldi.RowCount:=1;
  grdRiepilogoSaldi.ColumnCount:=2;
  grdRiepilogoSaldi.Cell[0,0].Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                                    'Ore lavorate' + '</span><br/>' +
                                    '<span style="color: #008800; cursor: default;" title="Debito orario">' +
                                    'Debito orario' + '</span><br/>' +
                                    '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                                    'Scostamento' + '</span><br/>' +
                                    '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                                    'Ore escluse dalle normali';
  grdRiepilogoSaldi.Cell[0,1].Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                                    R180MinutiOre(TotOreReseTotali) + '</span><br/>' +
                                    '<span style="color: #008800; cursor: default;" title="Debito orario">' +
                                    R180MinutiOre(TotDebitoGg) + '</span><br/>' +
                                    '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                                    R180MinutiOre(TotScost) + '</span><br/>' +
                                    '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                                    R180MinutiOre(TotMinLavEsc);
  grdRiepilogoSaldi.Visible:=chkConteggi.Checked and (Parametri.CampiRiferimento.C90_W005Riepilogo = 'S');
  lblRiepilogoSaldiCaption.Visible:=grdRiepilogoSaldi.Visible;
end;

procedure TW005FCartellino.grdCartellinoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,False);
end;

procedure TW005FCartellino.grdRiepilogoSaldiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,False,False,False);
  if AColumn = 1 then
    ACell.Css:=ACell.Css + ' conteggi align_right';
end;

procedure TW005FCartellino.imgPrecedenteClick(Sender: TObject);
var MesiInteri:Boolean;
    GGDiff,MMDiff,Molt:Integer;
    DalNew,AlNew:TDateTime;
begin
  Molt:=IfThen(Sender = imgPrecedente,-1,1);
  if Molt = -1 then
    AlNew:=Trunc(Dal - 1)
  else
    DalNew:=Trunc(Al + 1);
  if (Dal = R180InizioMese(Dal)) and (Al = R180FineMese(Al)) then
  begin
    MMDiff:=R180Mese(Al) - R180Mese(Dal);
    if Molt = -1 then
      DalNew:=R180InizioMese(R180AddMesi(AlNew,MMDiff * Molt))
    else
      AlNew:=R180FineMese(R180AddMesi(DalNew,MMDiff * Molt));
  end
  else
  begin
    GGDiff:=Trunc(Al - Dal);
    if Molt = -1 then
      DalNew:=AlNew - GGDiff
    else
      AlNew:=DalNew + GGDiff;
  end;
  (*
  if Molt = -1 then
    DalNew:=Max(DalNew,EncodeDate(R180Anno(AlNew),1,1))
  else
    AlNew:=Min(AlNew,EncodeDate(R180Anno(DalNew),12,31));
  *)
  edtDal.Text:=DateToStr(DalNew);
  edtAl.Text:=DateToStr(AlNew);
  btnEseguiClick(nil);
end;

procedure TW005FCartellino.chkConteggiClick(Sender: TObject);
begin
  lstAnomalie.Clear;
  VisualizzaCartellino;
end;

function TW005FCartellino.ElaboraTimbratura(T,Oper:String; Giorno,Timb:Integer; Data:TDateTime):String;
var H,V,C,R,Messaggio:String;
    PNew,DNew,HNew,CNew,RNew,VNew,IdNew,
    POld,DOld,HOld,COld,ROld,VOld,IdOld:String;
begin
  Result:='';
  H:='';
  V:='';
  C:='';
  R:='';
  PNew:='';
  DNew:='';
  HNew:='';
  CNew:='';
  RNew:='';
  VNew:='';
  IdNew:=''; // commessa MAN/02 - SVILUPPO 92
  POld:='';
  DOld:='';
  HOld:='';
  COld:='';
  ROld:='';
  VOld:='';
  IdOld:=''; // commessa MAN/02 - SVILUPPO 92
  Messaggio:='';

  if Oper <> 'C' then
  begin
    // separa l'informazione nei suoi valori
    V:=UpperCase(Copy(T,1,1));
    H:=Copy(T,2,5);
    if Pos('/',T) > 0 then
      C:=Copy(T,Pos('/',T) + 1,Length(T));
    if Pos('(',C) > 0 then
      C:=Copy(C,1,Pos('(',C) - 1);
    if Pos('(',T) > 0 then
      R:=Copy(T,Pos('(',T) + 1,Length(T));
    if Pos(')',R) > 0 then
      R:=Copy(R,1,Pos(')',R) - 1);

    // formato timbratura (verso + ora)
    if (V = '') or (H = '') then
    begin
      Result:=A000MSG_W005_ERR_FORMATO_TIMB;
      exit;
    end;
    // verso
    if (V <> 'E') and (V <> 'U') then
    begin
      Result:=A000MSG_W005_ERR_VERSO_TIMB;
      exit;
    end;
    // ora
    if Pos('.',H) = 0 then
    begin
      Result:=A000MSG_W005_ERR_FORMATO_ORA_TIMB;
      exit;
    end;
    try
      R180OraValidate(H);
      H:=StringReplace(H,'.','',[]);
    except
      on E: Exception do
      begin
        Result:=StringReplace(E.Message,'del dato',A000TraduzioneStringhe(A000MSG_W005_ERR_DELL_ORA),[]);
        Exit;
      end;
    end;
    // causale
    if (C <> '') and (not WR000DM.selT275.SearchRecord('CODICE',C,[srFromBeginning])) then
    begin
      Result:=Format(A000MSG_W005_PARAM_CAUSALE_INESISTENTE,[C]);
      exit;
    end;
    // rilevatore
    if Length(R) > 2 then
    begin
      Result:=A000MSG_W005_ERR_COD_MAX_2_CHARATTERI;
      exit;
    end;
  end;
  if (Oper = 'M') or (Oper = 'I') then
  begin
    PNew:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    DNew:=DateToStr(Data);
    HNew:=H;
    VNew:=V;
    CNew:=C;
    RNew:=R;
    IdNew:=''; // commessa MAN/02 - SVILUPPO 92
  end;
  if (Oper = 'M') or (Oper = 'C') then
  begin
    POld:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    DOld:=DateToStr(Data);
    HOld:=StringReplace(R180MinutiOre(Cartellino[Giorno].Timbrature[Timb].Ora),'.','',[]);
    VOld:=Cartellino[Giorno].Timbrature[Timb].Verso;
    COld:=Cartellino[Giorno].Timbrature[Timb].Causale;
    ROld:=Cartellino[Giorno].Timbrature[Timb].Ril;
    // commessa MAN/02 - SVILUPPO 92.ini
    if Cartellino[Giorno].Timbrature[Timb].IdRichiesta = 0 then
      IdOld:=''
    else
      IdOld:=IntToStr(Cartellino[Giorno].Timbrature[Timb].IdRichiesta);
    // commessa MAN/02 - SVILUPPO 92.fine
    if HNew = '' then
    begin
      if (Parametri.CancellaTimbrature = 'N') and (Parametri.T100_CancTimbOrig = 'N') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMBRATURE
      else if (Parametri.CancellaTimbrature = 'N') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'I') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMB_MANUALI
      else if (Parametri.T100_CancTimbOrig = 'N') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMB_ORIGINALI;
    end;
    if (HNew <> '') and (HNew <> HOld) and (Parametri.T100_Ora = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_TIMBRATURE;
    if (HNew <> '') and (RNew <> ROld) and (Parametri.T100_Rilevatore = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_RILEVATORE;
    if (HNew <> '') and (CNew <> '') and (CNew <> COld) and (Parametri.T100_Causale = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_CAUSALE;
    WR000DM.selT275.Filtered:=True;
    if (CNew <> '') and (not WR000DM.selT275.SearchRecord('CODICE',CNew,[srFromBeginning])) and (Parametri.T100_Causale = 'S') then
      Messaggio:=A000MSG_W005_MSG_USARE_CAUS_SELEZIONATA;
    WR000DM.selT275.Filtered:=False;
  end
  // filtro dizionario su caus. pres anche per inserimento 
  else if Oper = 'I' then
  begin
    WR000DM.selT275.Filtered:=True;
    if (CNew <> '') and (not WR000DM.selT275.SearchRecord('CODICE',CNew,[srFromBeginning])) then
      Messaggio:=A000MSG_W005_MSG_USARE_CAUS_SELEZIONATA;
    WR000DM.selT275.Filtered:=False;
  end;
  if Messaggio = '' then
  begin
    // controllo dati bloccati
    if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,WR000DM.selDatiBloccati.MeseBloccoRiepiloghi(Data),'T100') then
    begin
      Result:=WR000DM.selDatiBloccati.MessaggioLog;
    end
    else
    begin
      // applica la modifica al database
      with W005DtM do
      begin
        Timbrature.SetVariable('OPER',Oper);
        if Oper <> 'I' then
          Timbrature.SetVariable('ROWID',Cartellino[Giorno].Timbrature[Timb].RowID);
        Timbrature.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        Timbrature.SetVariable('DATA',Data);
        Timbrature.SetVariable('ORA',H);
        if Oper <> 'I' then
          Timbrature.SetVariable('FLAG',Cartellino[Giorno].Timbrature[Timb].Flag);
        Timbrature.SetVariable('VERSO',V);
        Timbrature.SetVariable('CAUSALE',C);
        Timbrature.SetVariable('RILEVATORE',R);
        Timbrature.SetVariable('ORIGINALE','N');
        if (Oper = 'M') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') and (Parametri.TimbOrig_Causale = 'S') and (COld <> CNew) then
          if (HOld = HNew) and (VOld = VNew) and (ROld = RNew) then
            Timbrature.SetVariable('ORIGINALE','S');
        if (Oper = 'M') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') and (Parametri.TimbOrig_Verso = 'S') and (VOld <> VNew) then
          if (HOld = HNew) and (COld = CNew) and (ROld = RNew) then
            Timbrature.SetVariable('ORIGINALE','S');
        Timbrature.Execute;
        if VarToStr(Timbrature.GetVariable('ERRORE')) <> '' then
        begin
          if Oper = 'I' then
            Result:=A000MSG_W005_MSG_INSERIMENTO_FALLITO;
        end
        else
        begin
          RegistraLog.SettaProprieta(Oper,'T100_TIMBRATURE',medpCodiceForm,nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO',Pold,PNew);
          RegistraLog.InserisciDato('DATA',DOld,DNew);
          RegistraLog.InserisciDato('ORA',HOld,HNew);
          RegistraLog.InserisciDato('VERSO',VOld,VNew);
          RegistraLog.InserisciDato('CAUSALE',COld,CNew);
          RegistraLog.InserisciDato('RILEVATORE',ROld,RNew);
          RegistraLog.InserisciDato('ID_RICHIESTA',IdOld,IdNew); // commessa MAN/02 - SVILUPPO 92
          RegistraLog.RegistraOperazione;
        end;
      end;
    end;
    Result:=A000TraduzioneStringhe(Result);
  end
  else
    Result:=A000TraduzioneStringhe(A000MSG_W005_MSG_MANCANO_AUTORIZZAZIONI) + ' ' + A000TraduzioneStringhe(Messaggio);
end;

procedure TW005FCartellino.NuovaTimbraturaSubmit(Sender: TObject);
var S:String;
begin
  S:=ElaboraTimbratura((Sender as TmeIWEdit).Text,'I',0,0,(Sender as TmeIWEdit).Tag);
  if S <> '' then
  begin
    if S = A000TraduzioneStringhe(A000MSG_W005_MSG_INSERIMENTO_FALLITO) then
      (Sender as TmeIWEdit).Text:='';
    GGetWebApplicationThreadVar.ShowMessage(S + '!')
  end
  else
  begin
    SessioneOracle.Commit;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW005FCartellino.btnApplicaClick(Sender: TObject);
var i,j,k:Integer;
    T,Msg:String;
    Data:TDateTime;
    IWEdt: TmeIWEdit;
begin
  lstAnomalie.Clear;
  for i:=1 to grdCartellino.RowCount - 1 do
  begin
    for j:=1 to grdCartellino.ColumnCount - 1 do
    begin
      Msg:='';
      Data:=StrToInt(grdCartellino.Cell[i,0].Hint);
      //Nuova timbratura
      if j = (ColF - 1 + COL_G) then
      begin
        if (grdCartellino.Cell[i,j].Control as TmeIWEdit).Text <> '' then
          Msg:=ElaboraTimbratura((grdCartellino.Cell[i,j].Control as TmeIWEdit).Text,'I',0,0,Data);
      end;
      //Modifica/cancellazione timbratura esistente
      if j > (ColF - 1 + COL_G) then
      begin
        if grdCartellino.Cell[i,j].Control is TmeIWGrid then
        begin
          for k:=0 to (grdCartellino.Cell[i,j].Control as TmeIWGrid).ColumnCount - 1 do
          begin
            if (grdCartellino.Cell[i,j].Control as TmeIWGrid).Cell[0,k].Control <> nil then
            begin
              IWEdt:=((grdCartellino.Cell[i,j].Control as TmeIWGrid).Cell[0,k].Control as TmeIWEdit);
              {Bruno 04/10/2011
               Espressione precedente:    x:=(k + 3) - (ColF + COL_G);}
              T:=Cartellino[i - 1].Timbrature[k].Verso +
                 R180MinutiOre(Cartellino[i - 1].Timbrature[k].Ora);
              if Cartellino[i - 1].Timbrature[k].Causale <> '' then
                T:=T + '/' + Cartellino[i - 1].Timbrature[k].Causale;
              if Cartellino[i - 1].Timbrature[k].Ril <> '' then
                T:=T + '(' + Cartellino[i - 1].Timbrature[k].Ril + ')';
              if IWEdt.Text <> T then
              begin
                if Trim(IWEdt.Text) = '' then
                  Msg:=ElaboraTimbratura(IWEdt.Text,'C',i - 1,k,Data)
                else
                  Msg:=ElaboraTimbratura(IWEdt.Text,'M',i - 1,k,Data);
              end;
            end;
            if Msg <> '' then
            begin
              if lstAnomalie.IndexOfName(DateToStr(Data)) = -1 then
                lstAnomalie.Add(Format('%s=%s',[DateToStr(Data),Msg]));
            end;
          end;
        end;
      end;
    end;
  end;
  SessioneOracle.Commit;
  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.grdCartellinoCellClick(ASender: TObject; const ARow, AColumn: Integer);
var
  ColData, ColOrario, ColGiust: Integer;
  Giorno: TDateTime;
  W018: TW018FRichiestaTimbrature;
  W023: TW023FPianifOrari;
  W008: TW008FGiustificativi;
  W010: TW010FRichiestaAssenze;
  Caus: String;
begin
  // determina le colonne da considerare
  ColData:=0;
  ColOrario:=IfThen(chkConteggi.Checked,IfThen(lstAnomalie.Count > 0,1,0) +  2,-1);
  ColGiust:=IfThen(lstAnomalie.Count > 0,1,0) + IfThen(chkConteggi.Checked,2,0) + 1;

  // data della riga selezionata
  Giorno:=StrToInt(grdCartellino.Cell[ARow,0].Hint);

  if AColumn = ColData then
  begin
    // click sulla data    -> segnalazione / autorizzazione omesse timbrature
    // in assenza di informazioni imposta il flag Responsabile in base alla presenza
    // o meno di un filtro anagrafe impostato
    WR000DM.Responsabile:=not Parametri.InibizioneIndividuale;
    W018:=TW018FRichiestaTimbrature.Create(GGetWebApplicationThreadVar);
    W018.SetParam('CHIAMANTE','W005');
    W018.SetParam('PROGRESSIVO',medpProgressivo);
    W018.SetParam('AL',Parametri.DataLavoro);
    W018.SetParam('DATA_FILTRO',Giorno);
    W018.OpenPage;
  end
  else if AColumn = ColOrario then
  begin
    // click sull'orario  -> pianificazione orari
    W023:=TW023FPianifOrari.Create(GGetWebApplicationThreadVar);
    W023.SetParam('CHIAMANTE','W005');
    W023.SetParam('PROGRESSIVO',medpProgressivo);
    W023.SetParam('DAL',Giorno);
    W023.SetParam('AL',Giorno);
    W023.OpenPage;
  end
  else if AColumn = ColGiust then
  begin
    // se l'utente è abilitato alla gestione giustificativi attiva questa,
    // altrimenti verifica l'abilitazione alla richiesta assenze
    if (A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N') or
            (WR000DM.Responsabile and (A000GetInibizioni('Funzione','OpenW010AutorizzAssenze') <> 'N')) then
    begin
      // click sul giust.   -> richiesta assenze
      if A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N' then
        WR000DM.Responsabile:=False;

      W010:=TW010FRichiestaAssenze.Create(GGetWebApplicationThreadVar);
      W010.SetParam('CHIAMANTE','W005');
      W010.SetParam('PROGRESSIVO',medpProgressivo);
      W010.SetParam('DAL',Giorno);
      W010.SetParam('AL',Giorno);
      if grdCartellino.Cell[ARow,AColumn].Text = '_____' then
        Caus:=''
      else
      begin
        Caus:=grdCartellino.Cell[ARow,AColumn].Text;
        Caus:=Copy(Caus,Pos('">',Caus) + 2);
        if Pos('[',Caus) > 0 then
          Caus:=Copy(Caus,1,Pos('[',Caus) - 1)
        else if Pos('(',Caus) > 0 then
          Caus:=Copy(Caus,1,Pos('(',Caus) - 1);
      end;
      W010.SetParam('CAUSALE',Caus);
      W010.OpenPage;
    end
    else if (A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'N') and
       True//(not Parametri.ModuloInstallato['TORINO_CSI_PRV'])
    then
    begin
      // click sul giust.   -> gestione giustificativi
      W008:=TW008FGiustificativi.Create(GGetWebApplicationThreadVar);
      W008.SetParam('CHIAMANTE','W005');
      W008.SetParam('PROGRESSIVO',medpProgressivo);
      W008.SetParam('DAL',Giorno);
      W008.SetParam('AL',Giorno);
      if grdCartellino.Cell[ARow,AColumn].Text = '_____' then
        Caus:=''
      else
      begin
        Caus:=grdCartellino.Cell[ARow,AColumn].Text;
        Caus:=Copy(Caus,Pos('">',Caus) + 2);
        if Pos('[',Caus) > 0 then
          Caus:=Copy(Caus,1,Pos('[',Caus) - 1)
        else if Pos('(',Caus) > 0 then
          Caus:=Copy(Caus,1,Pos('(',Caus) - 1);
      end;
      W008.SetParam('CAUSALE',Caus);
      W008.OpenPage;
    end;
  end;
end;

procedure TW005FCartellino.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  TWC001FLegendaCalendarioFM.Create(Self);
end;

function TW005FCartellino.GetInfoFunzione: String;
begin
  Result:=inherited GetInfoFunzione;
  Result:=Result + '<br>' + C190PeriodoStr(Dal,Al);
end;

procedure TW005FCartellino.DistruggiOggetti;
var
  i:Integer;
begin
  // array di supporto
  for i:=0 to High(Cartellino) do
  begin
    SetLength(Cartellino[i].Timbrature,0);
    SetLength(Cartellino[i].Giustificativi,0);
  end;

  if R502ProDtM1 <> nil then
    FreeAndNil(R502ProDtM1);
  if lstAnomalie <> nil then
    FreeAndNil(lstAnomalie);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
  end;

  try FreeAndNil(W005Dtm); except end;
end;

end.
