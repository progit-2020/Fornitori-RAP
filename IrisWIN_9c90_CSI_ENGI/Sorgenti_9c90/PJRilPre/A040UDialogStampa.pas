unit A040UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin , C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, QueryStorico, C001StampaLib, Oracle,
  A003UDataLavoroBis, Variants, Mask, checklst, C013UCheckList, ExtCtrls,
  StrUtils, Printers, QRPrntr, ComCtrls, C004UParamForm, Math;

type
  TA040FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    grpDettaglioTabellone: TGroupBox;
    FontDialog1: TFontDialog;
    rgpDatiAssenza: TRadioGroup;
    edtSiglaAssenza: TEdit;
    grpDatiPianif: TGroupBox;
    chkCodice: TCheckBox;
    chkOrario: TCheckBox;
    chkDatoLibero: TCheckBox;
    pnlTop: TPanel;
    rgpTipoStampa: TRadioGroup;
    grpPeriodo: TGroupBox;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    edtDataDa: TMaskEdit;
    btnDataDa: TBitBtn;
    edtDataA: TMaskEdit;
    btnDataA: TBitBtn;
    pnlRaggruppamento: TPanel;
    Label3: TLabel;
    DBLookUpCampo: TDBLookupComboBox;
    chkSaltoPagina: TCheckBox;
    pnlOpzioniTabellone: TPanel;
    chkIncludiNonPianif: TCheckBox;
    chkLegenda: TCheckBox;
    pnlCampoDettaglio: TPanel;
    Label4: TLabel;
    DBLookupDett: TDBLookupComboBox;
    pnlBottom: TPanel;
    btnPrinterSetUp: TBitBtn;
    btnAnteprima: TBitBtn;
    btnStampa: TBitBtn;
    btnClose: TBitBtn;
    btnFont: TBitBtn;
    pnlSceltaTurni: TPanel;
    edtTurni: TEdit;
    btnScegliTurni: TButton;
    Label2: TLabel;
    edtTitolo: TEdit;
    ProgressBar: TProgressBar;
    rgpSelTurni: TRadioGroup;
    Label1: TLabel;
    chkTotali: TCheckBox;
    procedure DBLookUpCampoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPrinterSetUpClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnScegliTurniClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure rgpDatiAssenzaClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLookUpCampoClick(Sender: TObject);
    procedure rgpSelTurniClick(Sender: TObject);
    procedure edtDataADblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    CampoGruppo,NomeLogicoCampoGruppo,TabellaCampoGruppo: String;
    DataDa, DataA: TDateTime;
    procedure GetCodiciTurnoUtilizzati;
    procedure GeneraQueryMese;
    procedure GeneraQueryMista;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function Controlli: Boolean;
  public
    DataSt: TDateTime;
  end;

var
  A040FDialogStampa: TA040FDialogStampa;

const
  NumLet = '0123456789ABCDEFGHILMNOPQRSTUVZ';
  MAX_CODICI = 4;

implementation

uses A040UPianifRep,A040UPianifRepDtM1,A040UStampa,A002UInterfacciaSt,
     A040UPianifRepDtM2,A040UStampa2, C700USelezioneAnagrafe;

{$R *.DFM}

procedure TA040FDialogStampa.FormShow(Sender: TObject);
begin
  // periodo stampa
  DataDa:=R180InizioMese(DataSt);
  DataA:=R180FineMese(DataSt);
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataDa);
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataA);
  // dato libero pianif.
  chkDatoLibero.Visible:=Parametri.CampiRiferimento.C3_DatoPianificabile <> '';
  chkDatoLibero.Caption:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile) + ' pianificato';
  // salvataggio parametri
  CreaC004(SessioneOracle,'A040_1',Parametri.ProgOper);
  GetParametriFunzione;
  // campo di raggruppamento
  CampoGruppo:='';
  NomeLogicoCampoGruppo:='';
  TabellaCampoGruppo:='';
  // impostazioni per la selezione del font
  FontDialog1.Font:=A040FStampa2.QRep.Font;
end;

procedure TA040FDialogStampa.FormActivate(Sender: TObject);
begin
  rgpTipoStampaClick(nil);
  OnActivate:=nil;
end;

procedure TA040FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  OnActivate:=FormActivate;
  PutParametriFunzione;
end;

procedure TA040FDialogStampa.GetParametriFunzione;
var
  CR,CD: String;
begin
  rgpTipoStampa.OnClick:=nil;
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  rgpTipoStampa.OnClick:=rgpTipoStampaClick;

  edtTitolo.Text:=C004FParamForm.GetParametro('TITOLO','');
  CR:=C004FParamForm.GetParametro('CAMPORAGGR','');
  if CR = '' then
    DBLookupCampo.KeyValue:=Null
  else
    DBLookupCampo.KeyValue:=CR;
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  rgpSelTurni.OnClick:=nil;
  rgpSelTurni.ItemIndex:=StrToInt(C004FParamForm.GetParametro('SELTURNI','0'));
  rgpSelTurni.OnClick:=rgpSelTurniClick;
  edtTurni.Text:=C004FParamForm.GetParametro('ELENCOTURNI','');
  chkCodice.Checked:=C004FParamForm.GetParametro('TURNO_CODICE','N') = 'S';
  chkOrario.Checked:=C004FParamForm.GetParametro('TURNO_ORARIO','N') = 'S';
  chkDatoLibero.Checked:=C004FParamForm.GetParametro('TURNO_DATOLIBERO','N') = 'S';
  rgpDatiAssenza.ItemIndex:=StrToInt(C004FParamForm.GetParametro('DATIASSENZA','0'));
  edtSiglaAssenza.Text:=C004FParamForm.GetParametro('SIGLAASSENZA','ASS');
  chkIncludiNonPianif.Checked:=C004FParamForm.GetParametro('INCLUDINONPIANIF','S') = 'S';
  chkLegenda.Checked:=C004FParamForm.GetParametro('LEGENDA','N') = 'S';
  chkTotali.Checked:=C004FParamForm.GetParametro('TOTALI','N') = 'S';
  CD:=C004FParamForm.GetParametro('CAMPODETT','');
  if CD = '' then
    DBLookUpDett.KeyValue:=Null
  else
    DBLookUpDett.KeyValue:=CD;
end;

procedure TA040FDialogStampa.GetCodiciTurnoUtilizzati;
// estrae l'elenco dei codici turno utilizzati nel periodo
var
  S,S2,Turno: String;
  L: TStringList;
  i,conta: Integer;
  Err: Boolean;
begin
  // COMO_HSANNA
  if (rgpTipoStampa.ItemIndex > 0) and
     (rgpSelTurni.ItemIndex = 0) then
  begin
    with A040FPianifRepDtM1 do
    begin
      // salva in una stringlist i turni già proposti per verificare che siano tutti pianificati nel mese
      L:=TStringList.Create;
      try
        L.CommaText:=edtTurni.Text;

        // estrae i turni pianificati nel mese
        C700MergeSelAnagrafe(selTurni,False);
        C700MergeSettaPeriodo(selTurni,Parametri.DataLavoro,Parametri.DataLavoro);
        selTurni.Close;
        selTurni.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
        selTurni.SetVariable('TIPOLOGIA',A040MW.CodTipologia);
        selTurni.SetVariable('DATA1',DataDa);
        selTurni.SetVariable('DATA2',DataA);
        selTurni.Open;

        // verifica che tutti i turni proposti nella casella siano pianificati nel mese
        Err:=False;
        for i:=0 to L.Count - 1 do
          if VarIsNull(selTurni.Lookup('TURNO',L[i],'TURNO')) then
            Err:=True
          else
            S:=S + L[i] + ',';
        conta:=L.Count;

        // completa l'elenco con i turni pianificati nel mese
        // se prospetto per dipendente dà segnalazione se i turni superano quelli disponibili
        //if (edtTurni.Text = '') or Err then
        begin
          S2:='';
          while not selTurni.Eof do
          begin
            Turno:=selTurni.FieldByName('TURNO').AsString;
            if L.IndexOf(Turno) < 0 then
            begin
              if (rgpTipoStampa.ItemIndex <> 2) or (conta < MAX_CODICI) then
                S:=S + Turno + ','
              else
                S2:=S2 + Turno + ', ';
              inc(conta);
            end;
            selTurni.Next;
          end;
          S:=Copy(S,1,Length(S) - 1);
          edtTurni.Text:=S;
        end;

        if S2 <> '' then
        begin
          S2:=Copy(S2,1,Length(S2) - 2);
          R180MessageBox('I turni pianificati nel mese: ' + S2 + CRLF +
                         'sono stati esclusi dalla selezione.' + CRLF +
                         'Effettuare successivamente la stampa di questi turni esclusi.' + CRLF +
                         'Nota: la stampa selezionata prevede un limite di ' + IntToStr(MAX_CODICI) + ' turni,' + CRLF +
                         'per garantire una corretta visualizzazione dei dati.',INFORMA);
        end;
      finally
        FreeAndNil(L);
      end;
    end;
  end;
end;

procedure TA040FDialogStampa.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004FParamForm.PutParametro('TITOLO',edtTitolo.Text);
  C004FParamForm.PutParametro('CAMPORAGGR',VarToStr(DBLookupCampo.KeyValue));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('ELENCOTURNI',edtTurni.Text);
  C004FParamForm.PutParametro('SELTURNI',IntToStr(rgpSelTurni.ItemIndex));
  C004FParamForm.PutParametro('TURNO_CODICE',IfThen(chkCodice.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_ORARIO',IfThen(chkOrario.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_DATOLIBERO',IfThen(chkDatoLibero.Checked,'S','N'));
  C004FParamForm.PutParametro('DATIASSENZA',IntToStr(rgpDatiAssenza.ItemIndex));
  C004FParamForm.PutParametro('SIGLAASSENZA',edtSiglaAssenza.Text);
  C004FParamForm.PutParametro('INCLUDINONPIANIF',IfThen(chkIncludiNonPianif.Checked,'S','N'));
  C004FParamForm.PutParametro('LEGENDA',IfThen(chkLegenda.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALI',IfThen(chkTotali.Checked,'S','N'));
  C004FParamForm.PutParametro('CAMPODETT',VarToStr(DBLookUpDett.KeyValue));
  try SessioneOracle.Commit; except end;
end;

procedure TA040FDialogStampa.GeneraQueryMese;
var Alias,Tabella,SQLSelect:String;
    i:ShortInt;
    SQLJoin,JoinOra:Array[1..31] of String;
    A,M,G,NG:Word;
begin
  with A040FPianifRepDtM1 do
  begin
    Q380St.DisableControls;
    Q380St.Close;
    DecodeDate(DataSt,A,M,G);
    SQLSelect:='';
    NG:=R180GiorniMese(DataSt);
    //Leggo le fasce dai dati in fasce
    for i:=1 to NG do
    begin
      Alias:='T380' + NumLet[i];
      Tabella:='T380_PianifReperib ' + Alias;
      //SQLSelect:=SQLSelect + ',' + Alias + '.Data';
      SQLSelect:=SQLSelect + ',' + Alias + '.Turno1||decode(' + Alias + '.Priorita1,null,null,'' #''||' + Alias + '.Priorita1) Turno1';
      SQLSelect:=SQLSelect + ',' + Alias + '.Turno2||decode(' + Alias + '.Priorita2,null,null,'' #''||' + Alias + '.Priorita2) Turno2';
      SQLSelect:=SQLSelect + ',' + Alias + '.Turno3||decode(' + Alias + '.Priorita3,null,null,'' #''||' + Alias + '.Priorita3) Turno3';
      SQLSelect:=SQLSelect + ',' + Alias + '.DatoLibero';
      case DataBaseDrv of
         //Sintassi ORACLE
         dbOracle:begin
                  SQLJoin[i]:=',' + Tabella;
                  JoinOra[i]:='T380_.Progressivo = ' + Alias +
                              '.Progressivo(+) AND ' + Alias +
                              '.Data(+) = ' + '''' + FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,i)) + ''' AND ' + Alias +
                              '.Tipologia(+) = '''+A040MW.CodTipologia+''' AND';
                  end;
      end;
    end;
    with Q380St.Sql do
    begin
      Clear;
      Add('SELECT ' + Copy(SQLSelect,2,Length(SQLSelect)));
      Add('FROM T380_PianifReperib T380_');
      for i:=1 to NG do
        Add(SQLJoin[i]);
      Add('WHERE');
      //Add('WHERE T380_.TIPOLOGIA = '''+A040FPianifRep.CodTipologia+''' AND');
      if DataBaseDrv = dbOracle then
        for i:=1 to NG do
          Add(JoinOra[i]);
      Add(Format(' T380_.Data BETWEEN ''%s'' AND ''%s''',[FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,1)),FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,NG))]));
    end;
    Q380St.EnableControls;
  end;
end;

procedure TA040FDialogStampa.GeneraQueryMista;
var App,S:String;
    TestoQVista,TestoQuery2:String;
    P:Integer;
    procedure CambiaT380T030;
    begin
      P:=Pos('T380_.',App);
      while P > 0 do
      begin
        Delete(App,P,5);
        Insert('T030',App,P);
        P:=Pos('T380_.',App);
      end;
    end;
begin
  with A040FPianifRepDtM1 do
  begin
    TestoQVista:=C700SelAnagrafe.Sql.Text;
    TestoQuery2:=UpperCase(Q380St.Sql.Text);
    TestoQVista:=EliminaRitornoACapo(TestoQVista);
    TestoQuery2:=EliminaRitornoACapo(TestoQuery2);
    Q380St.SQL.Clear;
    Q380St.DeleteVariables;
    // Parte SELECT
    App:='SELECT ' + GetSelect(TestoQVista) +','+ GetSelect(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    Q380St.SQL.Add(App);
    // Parte FROM
    App:='FROM ' + GetFrom(TestoQVista)+','+GetFrom(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    Delete(App,Pos(',T380_PIANIFREPERIB T380_',UpperCase(App)),Length(',T380_PIANIFREPERIB T380_'));
    Q380St.SQL.Add(App);
    // Parte WHERE
    App:='WHERE ' + GetWhere(TestoQVista);
    App:=App + ' AND ' + GetWhere(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    P:=Pos('T380_.DATA BETWEEN',UpperCase(App));
    S:=Copy(App,P + 19,30);
    Delete(App,P,49);
    Insert('0 < (SELECT COUNT(*) FROM T380_PIANIFREPERIB WHERE PROGRESSIVO = T030.PROGRESSIVO AND TIPOLOGIA = '''+A040MW.CodTipologia+''' AND DATA BETWEEN ' + S + ') ',App,P);
    CambiaT380T030;
    Q380St.SQL.Add(App);
    App:=GetOrderBy(TestoQVista);
    if (CampoGruppo <> '') and (Pos(UpperCase(CampoGruppo),StringReplace(StringReplace(UpperCase(Trim(App)),'V430.','',[rfReplaceAll]),'T030.','',[rfReplaceAll])) <> 1) then
      if App <> '' then
        App:=TabellaCampoGruppo + '.' + CampoGruppo + ',' + App
      else
        App:=TabellaCampoGruppo + '.' + CampoGruppo;
    App:='ORDER BY ' + App;
    App:=TogliParametro(App,DataSt);
    if App <> 'ORDER BY ' then
      Q380St.SQL.Add(App);
    //App:=TogliParametro(App,DataSt);
    if Pos(':C700DATADAL',Q380St.SubstitutedSql) > 0 then
    begin
      Q380St.DeclareVariable('C700DATADAL',otDate);
      Q380St.SetVariable('C700DATADAL',C700DataDal);
    end;
    if Pos(':C700FILTRO',Q380St.SubstitutedSql) > 0 then
    begin
      Q380St.DeclareVariable('C700FILTRO',otSubst);
      Q380St.SetVariable('C700FILTRO',OldC700Filtro);
    end;
    Q380St.Close;
    Q380St.Open;
  end;
end;

procedure TA040FDialogStampa.rgpDatiAssenzaClick(Sender: TObject);
begin
  edtSiglaAssenza.Enabled:=(rgpDatiAssenza.ItemIndex = 2);
end;

procedure TA040FDialogStampa.rgpSelTurniClick(Sender: TObject);
begin
  edtTurni.Text:='';
end;

procedure TA040FDialogStampa.rgpTipoStampaClick(Sender: TObject);
begin
  case rgpTipoStampa.ItemIndex of
    0: begin
         // tabellone mensile
         edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(DataSt));
         edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(DataSt));
         edtTitolo.Text:='Turni di ' + A040FPianifRepDtM1.A040MW.sTipo + ' del mese di: ' + R180NomeMese(R180Mese(DataSt)) + ' ' + IntToStr(R180Anno(DataSt));
       end;
    1: begin
         // tabellone personalizzato
         rgpDatiAssenzaClick(nil);
       end;
    2: begin
         // prospetto per dipendente
         if R180NumOccorrenzeCar(edtTurni.Text,',') >= 4 then
           edtTurni.Text:='';
       end;
    3: begin
         // prospetto orizzontale
         A040FStampa2.AbilRaggr:=False;
       end;
  end;
  edtDataDa.Enabled:=(rgpTipoStampa.ItemIndex <> 0);
  btnDataDa.Enabled:=(rgpTipoStampa.ItemIndex <> 0);
  edtDataA.Enabled:=(rgpTipoStampa.ItemIndex <> 0);
  btnDataA.Enabled:=(rgpTipoStampa.ItemIndex <> 0);
  edtTitolo.Enabled:=(rgpTipoStampa.ItemIndex <> 0);
  
  // reimposta visualizzazione pannelli
  pnlRaggruppamento.Visible:=False;
  pnlOpzioniTabellone.Visible:=False;
  pnlSceltaTurni.Visible:=False;
  grpDettaglioTabellone.Visible:=False;
  pnlCampoDettaglio.Visible:=False;
  pnlRaggruppamento.Align:=alNone;
  pnlOpzioniTabellone.Align:=alNone;
  pnlSceltaTurni.Align:=alNone;
  grpDettaglioTabellone.Align:=alNone;
  pnlCampoDettaglio.Align:=alNone;
  // visualizza pannelli in base al tipo stampa
  pnlRaggruppamento.Visible:=True;
  if pnlRaggruppamento.Visible then
    pnlRaggruppamento.Align:=alTop;
  // opzioni tabellone
  pnlOpzioniTabellone.Visible:=(rgpTipoStampa.ItemIndex = 1);
  if pnlOpzioniTabellone.Visible then
    pnlOpzioniTabellone.Align:=alTop;
  // scelta turni
  pnlSceltaTurni.Visible:=(rgpTipoStampa.ItemIndex > 0);
  if pnlSceltaTurni.Visible then
    pnlSceltaTurni.Align:=alTop;
  // dettaglio cella tabellone
  grpDettaglioTabellone.Visible:=(rgpTipoStampa.ItemIndex = 1);
  if grpDettaglioTabellone.Visible then
    grpDettaglioTabellone.Align:=alTop;
  // campo di dettaglio anagrafico
  pnlCampoDettaglio.Visible:=(rgpTipoStampa.ItemIndex = 2);
  if pnlCampoDettaglio.Visible then
    pnlCampoDettaglio.Align:=alTop;

  // abilita salto pagina in base a selezione
  chkSaltoPagina.Enabled:=((rgpTipostampa.ItemIndex = 1) or (rgpTipostampa.ItemIndex = 2)) and
                          (DBLookupCampo.KeyValue <> null);
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  if rgpTipoStampa.ItemIndex > 0 then
    GetCodiciTurnoUtilizzati;
end;

procedure TA040FDialogStampa.btnDataDaClick(Sender: TObject);
begin
   if Sender = btnDataDa then
   begin
     DataDa:=DataOut(DataDa,'Data iniziale','G');
     edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataDa);
   end
   else
   begin
     DataA:=DataOut(DataA,'Data finale','G');
     edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataA);
   end;
end;

procedure TA040FDialogStampa.btnFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
    A040FStampa2.QRep.Font:=FontDialog1.Font;
end;

procedure TA040FDialogStampa.btnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
  begin
    C001SettaQuickReport(A040FStampa.RepR);
    C001SettaQuickReport(A040FStampa2.QRep);
  end;
end;

function TA040FDialogStampa.Controlli: Boolean;
begin
  Result:=False;

  // controllo sul periodo
  if not TryStrToDate(edtDataDa.Text,DataDa) then
  begin
    R180MessageBox('Indicare una data valida di inizio periodo!',INFORMA);
    edtDataDa.SetFocus;
    Exit;
  end;
  if not TryStrToDate(edtDataA.Text,DataA) then
  begin
    R180MessageBox('Indicare una data valida di fine periodo!',INFORMA);
    edtDataA.SetFocus;
    Exit;
  end;
  if DataDa > DataA then
  begin
    R180MessageBox('Il periodo indicato non è valido!',INFORMA);
    edtDataA.SetFocus;
    Exit;
  end;
  if R180Anno(DataDa) <> R180Anno(DataA) then
  begin
    R180MessageBox('Le date devono essere riferite allo stesso anno!',INFORMA);
    edtDataA.SetFocus;
    Exit;
  end;

  // controlli specifici per tipo stampa
  case rgpTipoStampa.ItemIndex of
    1: begin
         // tabellone
          if (not ((chkCodice.Checked) or (chkOrario.Checked) or (chkDatoLibero.Checked))) and
             (rgpDatiAssenza.ItemIndex = 0) then
          begin
            if R180MessageBox('Non è stato selezionato nessun dettaglio di pianificazione o assenza.' + #13#10 +
                              'Vuoi stampare comunque un prospetto vuoto?',DOMANDA) = mrNo then
              Exit;
          end;
        end;
     2: begin
          // prospetto verticale
          if edtTurni.Text = '' then
          begin
            R180MessageBox('E'' necessario indicare almeno un turno da considerare!',INFORMA);
            edtTurni.SetFocus;
            Exit;
          end;
        end;
     3: begin
          if DBLookUpCampo.KeyValue = Null then
          begin
             R180MessageBox('E'' necessario indicare il campo di raggruppamento!',INFORMA);
             DBLookUpCampo.SetFocus;
             Exit;
          end;
       end;
  end;
  Result:=True;
end;

procedure TA040FDialogStampa.btnScegliTurniClick(Sender: TObject);
var
  Elem: String;
  LenCod: Integer;
begin
  // apre dataset dei turni da visualizzare
  with A040FPianifRepDtM1 do
  begin
    selT350Cod.Close;
    selT350Cod.SQL.Clear;
    selT350Cod.SQL.Add('select CODICE, DESCRIZIONE, to_char(ORAINIZIO,''hh24.mi'') HINI, to_char(ORAFINE,''hh24.mi'') HFINE');
    selT350Cod.SQL.Add('from   T350_REGREPERIB');
    selT350Cod.SQL.Add('where  TIPOLOGIA = :TIPOLOGIA');
    if rgpSelTurni.ItemIndex = 0 then
      selT350Cod.SQL.Add('order by 1')
    else
      selT350Cod.SQL.Add('order by 3, 4, 1');
    selT350Cod.SetVariable('TIPOLOGIA',A040MW.CodTipologia);
    selT350Cod.Open;

    LenCod:=IfThen(rgpSelTurni.ItemIndex = 0,5,11);

    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      with C013FCheckList do
      begin
        if rgpTipoStampa.ItemIndex = 2 then
          MaxElem:=MAX_CODICI;
        clbListaDati.Items.BeginUpdate;
        clbListaDati.Items.Clear;
        selT350Cod.First;
        while not selT350Cod.Eof do
        begin
          if rgpSelTurni.ItemIndex = 0 then
          begin
            Elem:=Format('%-5s %s',[selT350Cod.Fields[0].AsString,selT350Cod.Fields[1].AsString]);
            clbListaDati.Items.Add(Elem);
          end
          else
          begin
            Elem:=Format('%-5s-%-5s',[selT350Cod.Fields[2].AsString,selT350Cod.Fields[3].AsString]);
            if clbListaDati.Items.IndexOf(Elem) < 0 then
              clbListaDati.Items.Add(Elem);
          end;
          selT350Cod.Next;
        end;
        clbListaDati.Items.EndUpdate;
        R180PutCheckList(edtTurni.Text,LenCod,clbListaDati);
        if ShowModal = mrOK then
          edtTurni.Text:=R180GetCheckList(LenCod,clbListaDati);
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA040FDialogStampa.btnStampaClick(Sender: TObject);
var
  DettCella: set of TDettaglioCella;
  S,CampoRaggr,CampoDett: String;
begin
  if not Controlli then
    Exit;

  if rgpTipoStampa.ItemIndex = 0 then
  begin
    // stampa originale
    Screen.Cursor:=crHourGlass;
    with A040FPianifRepDtM1 do
      if DBLookUpCampo.KeyValue <> Null then
      begin
        NomeLogicoCampoGruppo:=DBLookUpCampo.Text;
        CampoGruppo:=selI010.FieldByName('Nome_Campo').AsString;
        TabellaCampoGruppo:=AliasTabella(selI010.FieldByName('Nome_Campo').AsString);
        S:=C700SelAnagrafe.SQL.Text;
        if R180InserisciColonna(S,TabellaCampoGruppo + '.' + CampoGruppo) then
        begin
          C700SelAnagrafe.CloseAll;
          C700SelAnagrafe.SQL.Text:=S;
        end;
      end
      else
      begin
        NomeLogicoCampoGruppo:='';
        CampoGruppo:='';
        TabellaCampoGruppo:='';
      end;
    if DataSt <> C700SelAnagrafe.GetVariable('DataLavoro') then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SetVariable('DataLavoro',DataSt);
    end;
    C700SelAnagrafe.Open;
    GeneraQueryMese;
    GeneraQueryMista;
    C001SettaQuickReport(A040FStampa.RepR);
    A040FStampa.DataStampa:=DataSt;
    A040FStampa.CampoGruppo:=CampoGruppo;
    A040FStampa.NomeLogicoCampoGruppo:=NomeLogicoCampoGruppo;
    Screen.Cursor:=crDefault;
    A040FStampa.CreaReport(Sender = btnStampa);
  end
  else
  begin
    // *** nuove stampe
    // campo di raggruppamento
    if DBLookUpCampo.KeyValue <> Null then
      CampoRaggr:=A040FPianifRepDtM1.selI010.FieldByName('Nome_Campo').AsString
    else
      CampoRaggr:='';

    // campo di dettaglio anagrafico
    if DBLookUpDett.KeyValue <> Null then
      CampoDett:=A040FPianifRepDtM1.selI010B.FieldByName('Nome_Campo').AsString
    else
      CampoDett:='';

    // compone il dettaglio cella
    DettCella:=[];
    if chkCodice.Checked then
      Include(DettCella,dtCodice);
    if chkOrario.Checked then
      Include(DettCella,dtOrario);
    if chkDatoLibero.Checked then
      Include(DettCella,dtDatoLibero);
    case rgpDatiAssenza.ItemIndex of
      1: Include(DettCella,dtCausAss);
      2: Include(DettCella,dtSiglaAss);
    end;

    // predispone il dataset per la stampa
    with A040FPianifRepDtM2 do
    begin
      case rgpTipoStampa.ItemIndex of
        1: TipoStampa:=tsTabellone;
        2: TipoStampa:=tsProspettoDip;
        3: TipoStampa:=tsProspettoRaggr;
      end;
      TipologiaTurno:=A040FPianifRepDtM1.A040MW.CodTipologia;
      DataInizio:=DataDa;
      DataFine:=DataA;
      if rgpSelTurni.ItemIndex = 0 then
        ElencoTurni:=edtTurni.Text
      else
        ElencoOrari:=edtTurni.Text;  
      IncludiNonPianificati:=chkIncludiNonPianif.Checked;
      NomeCampoRaggr:=CampoRaggr;
      NomeCampoDett:=CampoDett;
      SiglaAssenza:=edtSiglaAssenza.Text;
      DettaglioCella:=DettCella;
      VisualizzaLegenda:=chkLegenda.Checked;
      PBar:=ProgressBar;

      // prepara il dataset per la stampa
      Screen.Cursor:=crHourGlass;
      try
        PreparaDati;
      except
        on E: Exception do
        begin
          Screen.Cursor:=crDefault;
          R180MessageBox('Attenzione! Si è verificato un errore durante l''elaborazione' + #13#10 +
                         'della stampa richiesta.' + #13#10 +
                         'Motivo: ' + E.Message +
                         IfThen(E.ClassName = 'Exception','',' (' + E.ClassName + ')'),INFORMA);
          Exit;
        end;
      end;
      Screen.Cursor:=crDefault;
    end;

    // imposta proprietà stampa e crea report
    C001SettaQuickReport(A040FStampa2.QRep);
    with A040FStampa2 do
    begin
      AbilRaggr:=(CampoRaggr <> '');
      VisualizzaLegenda:=A040FPianifRepDtM2.VisualizzaLegenda;
      VisualizzaTotali:=chkTotali.Checked;
      Riproporziona:='P';
      QRGroup1.ForceNewPage:=chkSaltoPagina.Checked;
      TitoloStampa:=edtTitolo.Text;
      if TitoloStampa = '' then
      begin
        case rgpTipoStampa.ItemIndex of
          1: TitoloStampa:='Piano di servizio';
          2: TitoloStampa:='Prospetto per dipendente';
          3: TitoloStampa:='Prospetto per raggruppamento';
        end;
      end;
      if rgpTipoStampa.ItemIndex = 3 then
        AbilRaggr:=False;

      CreaReport;
      if Sender = btnAnteprima then
        QRep.Preview
      else
        QRep.Print;
    end;
  end;
  ProgressBar.Position:=0;
  ProgressBar.Repaint;
  Screen.Cursor:=crDefault;
end;

procedure TA040FDialogStampa.DBLookUpCampoClick(Sender: TObject);
begin
  if ((rgpTipostampa.ItemIndex <> 1) and (rgpTipostampa.ItemIndex <> 2)) or
     (TDBLookupComboBox(Sender).KeyValue = null) then
  begin
    chkSaltoPagina.Checked:=False;
    chkSaltoPagina.Enabled:=False;
  end
  else
    chkSaltoPagina.Enabled:=True;
end;

procedure TA040FDialogStampa.DBLookUpCampoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    TDBLookupComboBox(Sender).KeyValue:=null;
    if TDBLookupComboBox(Sender).Field <> nil then
      TDBLookupComboBox(Sender).Field.Clear;

    if Sender = DBLookUpCampo then
    begin
      chkSaltoPagina.Checked:=False;
      chkSaltoPagina.Enabled:=False;
    end;
  end;
end;

procedure TA040FDialogStampa.edtDataADblClick(Sender: TObject);
var
  D: TDateTime;
begin
  if (Sender = edtDataA) then
    if (TryStrToDate(edtDataDa.Text,D)) then
      edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(D));
end;

end.
