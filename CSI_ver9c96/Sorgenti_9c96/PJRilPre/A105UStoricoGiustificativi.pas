unit A105UStoricoGiustificativi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, Grids, DBGrids, ExtCtrls, DB, ComCtrls,
  checklst, Menus, Oracle, Mask, Variants, QueryStorico, RegistrazioneLog,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, A105UStoricoGiustificativiMW, C001StampaLib,
  C004UParamForm, C005UDatiAnagrafici, C013UCheckList, SelAnagrafe, StrUtils,
  C180FunzioniGenerali, C700USelezioneAnagrafe;

type
  TA105FStoricoGiustificativi = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    pmnCausali: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    pgcMain: TPageControl;
    tshStampa: TTabSheet;
    tshAllinea: TTabSheet;
    ProgressBar: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    pnlCausali: TPanel;
    pnlCausaliRichieste: TPanel;
    Label1: TLabel;
    clbCausali: TCheckListBox;
    Label3: TLabel;
    lblDaData: TLabel;
    sbtDaData: TSpeedButton;
    lblAData: TLabel;
    sbtAData: TSpeedButton;
    lblStatoElab: TLabel;
    dcmbCampo: TDBLookupComboBox;
    chkTotaliIndividuali: TCheckBox;
    chkTotaliRaggr: TCheckBox;
    chkTotaliGenerali: TCheckBox;
    chkSaltoPaginaIndividuale: TCheckBox;
    chkSaltoPaginaRaggr: TCheckBox;
    chkDettaglioGiornaliero: TCheckBox;
    chkDatiIndividuali: TCheckBox;
    chkDettaglioPeriodico: TCheckBox;
    chkAssenzeInserite: TCheckBox;
    chkAssenzeCancellate: TCheckBox;
    edtDaData: TMaskEdit;
    edtAData: TMaskEdit;
    chkRecordFisici: TCheckBox;
    sbtStatoElab: TButton;
    lblDataRegistrazione: TLabel;
    sbtDataRegistrazione: TSpeedButton;
    chkRegistrazioneInserimenti: TCheckBox;
    chkRegistrazioneCancellazioni: TCheckBox;
    chkEliminazioneAssenze: TCheckBox;
    edtDataRegistrazione: TMaskEdit;
    gpbDefinizionePeriodo: TGroupBox;
    lblPeriodoDal: TLabel;
    sbtPeriodoDal: TSpeedButton;
    lblPeriodoAl: TLabel;
    sbtPeriodoAl: TSpeedButton;
    edtPeriodoDal: TMaskEdit;
    edtPeriodoAl: TMaskEdit;
    chkDefinizioneDataRegistrazione: TCheckBox;
    chkImpostaAssElab: TCheckBox;
    pnlBottoni: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnStampa: TBitBtn;
    pnlFunzioni: TPanel;
    btnEsegui: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure sbtDaDataClick(Sender: TObject);
    procedure sbtADataClick(Sender: TObject);
    procedure dcmbCampoExit(Sender: TObject);
    procedure dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtStatoElabClick(Sender: TObject);
    procedure chkDettaglioGiornalieroClick(Sender: TObject);
    procedure chkDettaglioPeriodicoClick(Sender: TObject);
    procedure chkDatiIndividualiClick(Sender: TObject);
    procedure sbtPeriodoDalClick(Sender: TObject);
    procedure sbtPeriodoAlClick(Sender: TObject);
    procedure chkDefinizioneDataRegistrazioneClick(Sender: TObject);
    procedure sbtDataRegistrazioneClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
  Private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function GetCausali:String;
    procedure ScorriQueryAnagrafica;
  public
    { Public declarations }
    A105MW: TA105FStoricoGiustificativiMW;
  end;

var
  A105FStoricoGiustificativi: TA105FStoricoGiustificativi;

procedure OpenA105StoricoGiustificativi(Prog:LongInt);

implementation

uses A105UStampa;

{$R *.DFM}

procedure OpenA105StoricoGiustificativi(Prog:LongInt);
{Elenco Assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA105StoricoGiustificativi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
  end;
  A105FStoricoGiustificativi:=TA105FStoricoGiustificativi.Create(nil);
  with A105FStoricoGiustificativi do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA105FStoricoGiustificativi.FormCreate(Sender: TObject);
begin
  A105MW:=TA105FStoricoGiustificativiMW.Create(Self);
end;

procedure TA105FStoricoGiustificativi.FormShow(Sender: TObject);
begin
  A105MW.CodForm:=IfThen(A105MW.TipoModulo = 'CS','A105','WA105');
  A105FStampa:=TA105FStampa.Create(nil);
  pgcMain.ActivePageIndex:=0;
  CreaC004(SessioneOracle,A105MW.CodForm,Parametri.ProgOper);
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  edtDataRegistrazione.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  dcmbCampo.ListSource:=A105MW.D010;
  clbCausali.Items.Clear;
  with A105MW.Q265 do
  begin
    First;
    while not Eof do
    begin
      clbCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A105MW,SessioneOracle,StatusBar,0,False);
  btnEsegui.Enabled:=not SolaLettura; //Lorena 28/08/2006
end;

procedure TA105FStoricoGiustificativi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA105FStoricoGiustificativi.FormDestroy(Sender: TObject);
begin
  A105FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A105MW.Free;
end;

procedure TA105FStoricoGiustificativi.GetParametriFunzione;
{Leggo i parametri della form}
var x, y, i,r:integer;
    e: boolean;
    svalore, snome, selemento:string;
begin
  chkAssenzeInserite.Checked:=C004FParamForm.GetParametro('ASSENZEINSERITE','S') = 'S';
  chkAssenzeCancellate.Checked:=C004FParamForm.GetParametro('ASSENZECANCELLATE','S') = 'S';
  chkRecordFisici.Checked:=C004FParamForm.GetParametro('RECORDFISICI','N') = 'S';
  chkTotaliIndividuali.Checked:=C004FParamForm.GetParametro('TOTINDIVIDUALI','N') = 'S';
  chkTotaliRaggr.Checked:=C004FParamForm.GetParametro('TOTGRUPPO','N') = 'S';
  chkTotaliGenerali.Checked:=C004FParamForm.GetParametro('TOTGENERALI','N') = 'S';
  chkSaltoPaginaIndividuale.Checked:=C004FParamForm.GetParametro('SALTOPAGINAIND','N') = 'S';
  chkSaltoPaginaRaggr.Checked:=C004FParamForm.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  chkDettaglioGiornaliero.Checked:=C004FParamForm.GetParametro('DETTAGLIO','N') = 'S';
  chkDettaglioPeriodico.Checked:=C004FParamForm.GetParametro('PERIODICO','N') = 'S';
  chkDatiIndividuali.Checked:=C004FParamForm.GetParametro('DATIINDIVIDUALI','N') = 'S';
  dcmbCampo.KeyValue:=C004FParamForm.GetParametro('CAMPORAGGRUPPA',dcmbCampo.Text);
  chkDefinizioneDataRegistrazione.Checked:=C004FParamForm.GetParametro('DEFDATAREGISTRAZ','N') = 'S';
  edtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
  sbtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
  chkRegistrazioneInserimenti.Checked:=C004FParamForm.GetParametro('REGISTRAINS','S') = 'S';
  chkRegistrazioneCancellazioni.Checked:=C004FParamForm.GetParametro('REGISTRACAN','S') = 'S';
  chkEliminazioneAssenze.Checked:=C004FParamForm.GetParametro('ELIMINAMOVIMENTI','N') = 'S';
  chkDettaglioGiornaliero.Enabled:=not(chkDettaglioPeriodico.Checked);
  chkDettaglioPeriodico.Enabled:=not(chkDettaglioGiornaliero.Checked);
  if dcmbCampo.Text = '' then
  begin
    dcmbCampo.KeyValue:=null;
    chkTotaliRaggr.Enabled:=False;
    chkTotaliRaggr.Checked:=False;
    chkSaltoPaginaRaggr.Enabled:=False;
    chkSaltoPaginaRaggr.Checked:=False;
  end;
  // lettura causali selezionate
  x:=0; //contatore di paramento
  snome:='LISTACAUSALI';
  repeat
  // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
    svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
    y:=0; // contatore di elementi nel parametro
    if svalore<>'' then
      begin
      repeat
      // ciclo sugli elementi nel parametro max 16 per parametro
        selemento:=Copy(svalore,(y*5)+1,5);
        if selemento<>'' then
          begin
          i:=0;
          e:=true;
          r:=clbCausali.Items.Count;
          while (i<r) and (e) do
            begin
            if Copy(clbCausali.Items[i],1,5)=selemento then
               begin
               clbCausali.Checked[i]:=true;
               e:=false;
               end
            else
               if Copy(clbCausali.Items[i],1,5)>selemento then
                  e:=false;
            inc(i);
            end;
          inc(y);
          end;
      until selemento = '';
      inc(x);
    end;
  until svalore = '';
end;

procedure TA105FStoricoGiustificativi.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  C004FParamForm.Cancella001;
  if chkAssenzeInserite.Checked then
    C004FParamForm.PutParametro('ASSENZEINSERITE','S')
  else
    C004FParamForm.PutParametro('ASSENZEINSERITE','N');
  if chkAssenzeCancellate.Checked then
    C004FParamForm.PutParametro('ASSENZECANCELLATE','S')
  else
    C004FParamForm.PutParametro('ASSENZECANCELLATE','N');
  if chkRecordFisici.Checked then
    C004FParamForm.PutParametro('RECORDFISICI','S')
  else
    C004FParamForm.PutParametro('RECORDFISICI','N');
  if chkTotaliIndividuali.Checked then
    C004FParamForm.PutParametro('TOTINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('TOTINDIVIDUALI','N');
  if chkTotaliRaggr.Checked then
    C004FParamForm.PutParametro('TOTGRUPPO','S')
  else
    C004FParamForm.PutParametro('TOTGRUPPO','N');
  if chkTotaliGenerali.Checked then
    C004FParamForm.PutParametro('TOTGENERALI','S')
  else
    C004FParamForm.PutParametro('TOTGENERALI','N');
  if chkSaltoPaginaIndividuale.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAIND','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAIND','N');
  if chkSaltoPaginaRaggr.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','N');
  if chkDettaglioGiornaliero.Checked then
    C004FParamForm.PutParametro('DETTAGLIO','S')
  else
    C004FParamForm.PutParametro('DETTAGLIO','N');
  if chkDettaglioPeriodico.Checked then
    C004FParamForm.PutParametro('PERIODICO','S')
  else
    C004FParamForm.PutParametro('PERIODICO','N');
  if chkDatiIndividuali.Checked then
    C004FParamForm.PutParametro('DATIINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('DATIINDIVIDUALI','N');
  C004FParamForm.PutParametro('CAMPORAGGRUPPA',VarToStr(dcmbCampo.KeyValue));
  if chkDefinizioneDataRegistrazione.Checked then
    C004FParamForm.PutParametro('DEFDATAREGISTRAZ','S')
  else
    C004FParamForm.PutParametro('DEFDATAREGISTRAZ','N');
  if chkRegistrazioneInserimenti.Checked then
    C004FParamForm.PutParametro('REGISTRAINS','S')
  else
    C004FParamForm.PutParametro('REGISTRAINS','N');
  if chkRegistrazioneCancellazioni.Checked then
    C004FParamForm.PutParametro('REGISTRACAN','S')
  else
    C004FParamForm.PutParametro('REGISTRACAN','N');
  if chkEliminazioneAssenze.Checked then
    C004FParamForm.PutParametro('ELIMINAMOVIMENTI','S')
  else
    C004FParamForm.PutParametro('ELIMINAMOVIMENTI','N');
  // salvo l'elenco delle causali selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTACAUSALI';
  r:=clbCausali.Items.Count;
  For i:=1 to r do
    begin
    if clbCausali.Checked[i-1] then
       begin
       svalore:=svalore+Copy(clbCausali.Items[i-1],1,5);
       inc(y);
       if y=16 then
          begin
          C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
          inc(x);
          y:=0;
          svalore:='';
          end;
       end;
    end;
  C004FParamForm.PutParametro(snome+IntToStr(x),svalore);

  try SessioneOracle.Commit; except end;
end;

procedure TA105FStoricoGiustificativi.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=StrToDate(edtAData.Text);
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA105FStoricoGiustificativi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=StrToDate(edtAData.Text);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA105FStoricoGiustificativi.sbtDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDaData.Text),'Data inizio stampa','G'));
end;

procedure TA105FStoricoGiustificativi.sbtADataClick(Sender: TObject);
begin
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtAData.Text),'Data fine stampa','G'));
end;

procedure TA105FStoricoGiustificativi.dcmbCampoExit(Sender: TObject);
begin
  if dcmbCampo.Text = '' then
  begin
    dcmbCampo.KeyValue:=null;
    chkTotaliRaggr.Enabled:=False;
    chkTotaliRaggr.Checked:=False;
    chkSaltoPaginaRaggr.Enabled:=False;
    chkSaltoPaginaRaggr.Checked:=False;
  end
  else
  begin
    chkTotaliRaggr.Enabled:=True;
    chkSaltoPaginaRaggr.Enabled:=True;
  end;
end;

procedure TA105FStoricoGiustificativi.dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA105FStoricoGiustificativi.sbtStatoElabClick(Sender: TObject);
var j: integer;
begin
  try
    C013FCheckList:=TC013FCheckList.Create(nil);
    C013FCheckList.clbListaDati.Items.Assign(A105MW.ListaDati);
    C013FCheckList.Caption:=Self.Caption;
    for j:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
      if Pos(Trim(Copy(C013FCheckList.clbListaDati.Items[j],1,1)),A105MW.StatoPaghe) > 0 then
        C013FCheckList.clbListaDati.Checked[j]:=True;
    if C013FCheckList.ShowModal = mrOK then
      A105MW.StatoPaghe:='' + StringReplace(R180GetCheckList(1,C013FCheckList.clbListaDati),',',''',''',[rfReplaceAll]) + '';
  finally
    C013FCheckList.Free;
  end;
end;

procedure TA105FStoricoGiustificativi.chkDettaglioGiornalieroClick(Sender: TObject);
begin
  if chkDettaglioGiornaliero.Checked then
  begin
    chkDettaglioPeriodico.Checked:=false;
    chkDettaglioPeriodico.Enabled:=false;
  end
  else
    chkDettaglioPeriodico.Enabled:=True;
end;

procedure TA105FStoricoGiustificativi.chkDettaglioPeriodicoClick(Sender: TObject);
begin
  if chkDettaglioPeriodico.Checked then
  begin
    chkDettaglioGiornaliero.Checked:=False;
    chkDettaglioGiornaliero.Enabled:=false;
  end
  else
    chkDettaglioGiornaliero.Enabled:=True;
end;

procedure TA105FStoricoGiustificativi.chkDatiIndividualiClick(Sender: TObject);
begin
  chkTotaliIndividuali.Enabled:=chkDatiIndividuali.Checked;
  chkSaltoPaginaIndividuale.Enabled:=chkDatiIndividuali.Checked;
  chkDettaglioGiornaliero.Enabled:=chkDatiIndividuali.Checked;
  chkDettaglioPeriodico.Enabled:=chkDatiIndividuali.Checked;
  if not chkDatiIndividuali.Checked then
  begin
    chkTotaliIndividuali.Checked:=False;
    chkSaltoPaginaIndividuale.Checked:=False;
    chkDettaglioGiornaliero.Checked:=false;
    chkDettaglioPeriodico.Checked:=false;
  end;
end;

procedure TA105FStoricoGiustificativi.sbtPeriodoDalClick(Sender: TObject);
begin
  edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtPeriodoDal.Text),'Data inizio periodo','G'));
end;

procedure TA105FStoricoGiustificativi.sbtPeriodoAlClick(Sender: TObject);
begin
  edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtPeriodoAl.Text),'Data fine periodo','G'));
end;

procedure TA105FStoricoGiustificativi.chkDefinizioneDataRegistrazioneClick(Sender: TObject);
begin
  edtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
  sbtDataRegistrazione.Enabled:=not(chkDefinizioneDataRegistrazione.Checked);
end;

procedure TA105FStoricoGiustificativi.sbtDataRegistrazioneClick(Sender: TObject);
begin
  edtDataRegistrazione.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataRegistrazione.Text),'Data registrazione','G'));
end;

procedure TA105FStoricoGiustificativi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbCausali.Items.Count - 1 do
    clbCausali.Checked[i]:=True;
end;

procedure TA105FStoricoGiustificativi.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbCausali.Items.Count - 1 do
    clbCausali.Checked[i]:=False;
end;

procedure TA105FStoricoGiustificativi.BtnPreViewClick(Sender: TObject);
var App,S:String;
begin
  A105MW.ElencoCausali:=GetCausali;
  if A105MW.ElencoCausali = '' then
    raise Exception.Create(A000MSG_A105_ERR_NO_CAUSALE);
  A105MW.CreaTabellaStampa;
  if (dcmbCampo.KeyValue <> Null) then
    App:=dcmbCampo.KeyValue
  else
    App:='';
  if App <> '' then
  begin
    A105MW.NomeCampo:=dcmbCampo.Text;
    A105MW.CampoRagg:=App;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,App) then
    begin
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  with C700SelAnagrafe do
    if GetVariable('DataLavoro') <> StrToDate(edtAData.Text) then
    begin
      Close;
      SetVariable('DataLavoro',StrToDate(edtAData.Text));
    end;
  C700SelAnagrafe.Open;
  frmSelAnagrafe.Numrecords;
  Screen.Cursor:=crHourGlass;
  ScorriQueryAnagrafica;
  Screen.Cursor:=crDefault;
  A105FStampa.DaData:=StrToDate(edtDaData.Text);
  A105FStampa.AData:=StrToDate(edtAData.Text);
  A105FStampa.CreaReport(Sender = BtnPreView);
  A105MW.TabellaStampa.Close;
end;

function TA105FStoricoGiustificativi.GetCausali:String;
var i,xx:Integer;
  {Implementeazione Quick Sort per ordinamento timbrature}
  procedure QuickSort(iLo, iHi: Integer);
  var Lo, Hi: Integer;
      Mid:String;
      T:TTotale;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=TotInd[(Lo + Hi) div 2].Causale;
    repeat
      while TotInd[Lo].Causale < Mid do Inc(Lo);
      while TotInd[Hi].Causale > Mid do Dec(Hi);
      if Lo <= Hi then
        begin
        T:=TotInd[Lo];
        TotInd[Lo]:=TotInd[Hi];
        TotInd[Hi]:=T;
        Inc(Lo);
        Dec(Hi);
        end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(iLo, Hi);
    if Lo < iHi then QuickSort(Lo, iHi);
  end;
begin
  Result:='';
  NumCausali:=0;
  for xx:=Low(TotInd) to High(TotInd) do
  begin
    TotInd[xx].Causale:='';
    TotInd[xx].Descrizione:='';
    TotInd[xx].Giorni:=0;
    TotInd[xx].Minuti:=0;
    TotGrup[xx].Causale:='';
    TotGrup[xx].Descrizione:='';
    TotGrup[xx].Giorni:=0;
    TotGrup[xx].Minuti:=0;
    TotGen[xx].Causale:='';
    TotGen[xx].Descrizione:='';
    TotGen[xx].Giorni:=0;
    TotGen[xx].Minuti:=0;
  end;
  for i:=0 to clbCausali.Items.Count - 1 do
    if clbCausali.Checked[i] then
      begin
      inc(NumCausali);
      TotInd[NumCausali].Causale:=Trim(Copy(clbCausali.Items[i],1,5));
      TotInd[NumCausali].Descrizione:=Trim(Copy(clbCausali.Items[i],7,40));
      if Result <> '' then Result:=Result + ',';
      Result:=Result + '''' + Trim(Copy(clbCausali.Items[i],1,5)) + '''';
      end;
  //Ordinamento causali in base al codice
  if NumCausali > 0 then
    QuickSort(1,NumCausali);
  //Copio le causali sugli altri 2 vettori per totalizzazione
  for i:=1 to NumCausali do
    begin
    TotGrup[i]:=TotInd[i];
    TotGen[i]:=TotInd[i];
    end;
end;

procedure TA105FStoricoGiustificativi.ScorriQueryAnagrafica;
begin
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
  while not C700SelAnagrafe.EOF do
  begin
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.StepBy(1);
    A105MW.ElaboraDipendente(StrToDate(edtDaData.Text),
                             StrToDate(edtAData.Text),
                             IfThen(chkRecordFisici.Checked,'S','N'),
                             chkAssenzeInserite.Checked,
                             chkAssenzeCancellate.Checked,
                             chkDettaglioGiornaliero.Checked);
    C700SelAnagrafe.Next;
  end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA105FStoricoGiustificativi.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A105FStampa.RepR);
end;

procedure TA105FStoricoGiustificativi.btnEseguiClick(Sender: TObject);
var sCausaliSelezionate:String;
begin
  sCausaliSelezionate:=R180GetCheckList(5,clbCausali);
  if sCausaliSelezionate = '' then
    raise Exception.Create(A000MSG_A105_ERR_NO_CAUSALE);
  sCausaliSelezionate:='''' + StringReplace(sCausaliSelezionate,',',''',''',[rfReplaceAll]) + '''';
  // Inserisco i record mancanti in T044_STORICOGIUSTIFICATIVI
  if (chkRegistrazioneInserimenti.Checked or chkRegistrazioneCancellazioni.Checked) then
  begin
    //Elaborare solo quelli selezionati dalla C700
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
      begin
        A105MW.Registrazione(StrToDate(edtPeriodoDal.Text),
                             StrToDate(edtPeriodoAl.Text),
                             StrToDate(edtDataRegistrazione.Text),
                             IfThen(chkDefinizioneDataRegistrazione.Checked,'S','N'),
                             IfThen(chkRegistrazioneInserimenti.Checked,'S','N'),
                             IfThen(chkRegistrazioneCancellazioni.Checked,'S','N'),
                             IfThen(chkImpostaAssElab.Checked,'S','N'),
                             sCausaliSelezionate);
        ProgressBar.StepBy(1);
        C700SelAnagrafe.Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
    end;
  end;
  // Cancello i record non ancora fleggati dagli stipendi che non devono più essere registrati
  // su T044_STORICOGIUSTIFICATIVI
  if chkEliminazioneAssenze.Checked then
  begin
    //Elaborare solo quelli selezionati dalla C700
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
      begin
        A105MW.Cancellazione(StrToDate(edtPeriodoDal.Text),
                             StrToDate(edtPeriodoAl.Text));
        ProgressBar.StepBy(1);
        C700SelAnagrafe.Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
    end;
  end;
  if frmSelAnagrafe.ElaborazioneInterrotta then
  begin
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_INTERROTTA,INFORMA);
    frmSelAnagrafe.ElaborazioneInterrotta:=False;
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
end;

end.
