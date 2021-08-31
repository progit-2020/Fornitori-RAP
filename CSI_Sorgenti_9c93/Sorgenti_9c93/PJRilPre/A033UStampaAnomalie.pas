unit A033UStampaAnomalie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, C001StampaLib, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, R500Lin, C180FunzioniGenerali, DBCtrls,
  C004UParamForm, Menus, SelAnagrafe, C005UDatiAnagrafici, QueryStorico, Variants,
  A000UMessaggi;

type
  TA033FStampaAnomalie = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlPrincipale: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    EDaData: TMaskEdit;
    EAData: TMaskEdit;
    btnStampa: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CBTimbrat1: TCheckBox;
    CBCausali1: TCheckBox;
    CBTimbrat2: TCheckBox;
    CBCausali2: TCheckBox;
    CBTimbrat3: TCheckBox;
    CBCausali3: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CkBAggiornaT101: TCheckBox;
    DBLookupCampo: TDBLookupComboBox;
    CheckBox4: TCheckBox;
    chkAutoGiustificazione: TCheckBox;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnAnteprima: TBitBtn;
    btnAggiornamento: TBitBtn;
    procedure DBLookupCampoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure CBTimbrat1Click(Sender: TObject);
    procedure CBTimbrat2Click(Sender: TObject);
    procedure CBTimbrat3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EDaDataExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure CkBAggiornaT101Click(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaAnomalie;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function AnomalieSelezionate:Integer;
    procedure ScorriAnagrafe;
    function VerificaAnomaliaSelezionata(Livello: Integer; idx: Integer):Boolean;
  public
    { Public declarations }
    AbilCont:Boolean;
    CampoRagg,NomeCampo:String;
  end;

var
  A033FStampaAnomalie: TA033FStampaAnomalie;

procedure OpenA033StampaAnomalie(Prog:LongInt; Da,A:TDateTime);

implementation

uses A033UStampaAnomalieQR, A033UStampaAnomalieDtM1, A033UElenco;

{$R *.DFM}

procedure OpenA033StampaAnomalie(Prog:LongInt; Da,A:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA033StampaAnomalie') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A033FStampaAnomalie:=TA033FStampaAnomalie.Create(nil);
  with A033FStampaAnomalie do
    try
      C700Progressivo:=Prog;
      if Da <> 0 then EDaData.Text:=FormatDateTime('dd/mm/yyyy',Da);
      if A <> 0 then EAData.Text:=FormatDateTime('dd/mm/yyyy',A);
      A033FStampaAnomalieDtM1:=TA033FStampaAnomalieDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A033FStampaAnomalieDtM1.Free;
      Free;
    end;
end;

procedure TA033FStampaAnomalie.FormCreate(Sender: TObject);
begin
  AbilCont:=False;
  A033FStampaAnomalieQR:=TA033FStampaAnomalieQR.Create(nil);
  A033FElenco:=TA033FElenco.Create(nil);
  EDaData.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  EAData.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  CaricaAnomalie;
end;

procedure TA033FStampaAnomalie.CaricaAnomalie;
{Carico le anomalie nelle CheckListBox}
var i:Integer;
begin
  for i:=1 to High(tdescanom1) do
    begin
    A033FElenco.Anomalie1.Items.Add(Format('[1_%s] %s', [IntToStr(tdescanom1[i].N), tdescanom1[i].D]));
    //A033FElenco.Anomalie1.Items.Add(tdescanom1[i].D);
    A033FElenco.Anomalie1.Checked[i - 1]:=True;
    end;
  for i:=1 to High(tdescanom2) do
    begin
    A033FElenco.Anomalie2.Items.Add(Format('[2_%s] %s', [IntToStr(tdescanom2[i].N), tdescanom2[i].D]));
    //A033FElenco.Anomalie2.Items.Add(tdescanom2[i].D);
    A033FElenco.Anomalie2.Checked[i - 1]:=True;
    end;
  for i:=1 to High(tdescanom3) do
    begin
    A033FElenco.Anomalie3.Items.Add(Format('[3_%s] %s', [IntToStr(tdescanom3[i].N), tdescanom3[i].D]));
    //A033FElenco.Anomalie3.Items.Add(tdescanom3[i].D);
    A033FElenco.Anomalie3.Checked[i - 1]:=True;
    end;
end;

procedure TA033FStampaAnomalie.BitBtn2Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A033FStampaAnomalieQR.QRep);
end;

procedure TA033FStampaAnomalie.CBTimbrat1Click(Sender: TObject);
begin
  if not CBTimbrat1.Checked then
    CBCausali1.Checked:=False;
  CBCausali1.Enabled:=CBTimbrat1.Checked;
end;

procedure TA033FStampaAnomalie.CBTimbrat2Click(Sender: TObject);
begin
  if not CBTimbrat2.Checked then
    CBCausali2.Checked:=False;
  CBCausali2.Enabled:=CBTimbrat2.Checked;
end;

procedure TA033FStampaAnomalie.CBTimbrat3Click(Sender: TObject);
begin
  if not CBTimbrat3.Checked then
    CBCausali3.Checked:=False;
  CBCausali3.Enabled:=CBTimbrat3.Checked;
end;

procedure TA033FStampaAnomalie.CkBAggiornaT101Click(Sender: TObject);
begin
  btnAggiornamento.Enabled:=CkBAggiornaT101.Checked;
end;

procedure TA033FStampaAnomalie.btnStampaClick(Sender: TObject);
{Lancio il processo di stampa}
var S:String;
begin
  with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
  begin
    if AnomalieSelezionate = 0 then
      raise Exception.Create(A000MSG_A033_ERR_NO_ANOM_SEL);
    DataInizio:=StrToDate(EDaData.Text);
    DataFine:=StrToDate(EAData.Text);
    if DataInizio > DataFine then
      raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
    CreazioneTabellaStampa;
    if DBLookUpCampo.KeyValue <> Null then
    begin
      CampoRagg:=DBLookUpCampo.KeyValue;
      NomeCampo:=DBLookUpCampo.Text;
      S:=C700SelAnagrafe.SQL.Text;
      if R180InserisciColonna(S,AliasTabella(DBLookUpCampo.KeyValue)+'.'+DBLookUpCampo.KeyValue) then
      begin
        C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.SQL.Text:=S;
      end;
    end
    else
    begin
      CampoRagg:='';
      NomeCampo:='';
    end;
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    frmSelAnagrafe.NumRecords;
    CancellaAnomalie;
  end;
  with A033FStampaAnomalieQR do
  begin
    qrgRaggruppamento.Enabled:=CampoRagg <> '';
    if CampoRagg <> '' then
      begin
      qrgRaggruppamento.ForceNewPage:=CheckBox4.Checked;
      LRaggInt.Caption:=NomeCampo;
      LRagg.Caption:=NomeCampo;
      end;
    S:='';
    if CheckBox1.Checked then S:=S + ',1°';
    if CheckBox2.Checked then S:=S + ',2°';
    if CheckBox3.Checked then S:=S + ',3°';
    QRLabel1.Caption:='ELENCO ANOMALIE DI ' + Copy(S,2,Length(S)) + ' LIVELLO';
    C700SelAnagrafe.First;
    QRLabel2.Caption:=Format('dal %s al %s',[EDaData.Text,EAData.Text]);
  end;

  with A033FStampaAnomalieDtM1.A033FStampaAnomalieMW do
  begin
    CreaR502Dtm;
    PeriodoConteggi;
    AggiornaT101:=CkBAggiornaT101.Checked;
    AnomalieLivello1:=CheckBox1.Checked;
    AnomalieLivello2:=CheckBox2.Checked;
    AnomalieLivello3:=CheckBox3.Checked;
    TimbratureLivello1:=CBTimbrat1.Checked;
    TimbratureLivello2:=CBTimbrat2.Checked;
    TimbratureLivello3:=CBTimbrat3.Checked;
    CausaliLivello1:=CBCausali1.Checked;
    CausaliLivello2:=CBCausali2.Checked;
    CausaliLivello3:=CBCausali3.Checked;
    CampoRaggruppamento:=CampoRagg;
    A033VerificaAnomaliaSelezionata:=VerificaAnomaliaSelezionata;
    //Massimo 23/07/2013 modificato richiamo a creaSelAnagrafe, l'abbinamento è già fatto lì
    //SelAnagrafe:=C700SelAnagrafe;
  end;

  ScorriAnagrafe;
  A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.TStampa.First;
  A033FStampaAnomalieQR.sIntRagg:=A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.TStampa.FieldByName('Raggruppamento').AsString;
  A033FStampaAnomalieQR.iIntDip:=A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.TStampa.FieldByName('Progressivo').AsInteger;
  A033FStampaAnomalieQR.bIntRagg:=True;
  A033FStampaAnomalieQR.bIntDip:=True;
  if Sender = btnAnteprima then
    A033FStampaAnomalieQR.QRep.Preview
  else if Sender = btnStampa then
    A033FStampaAnomalieQR.QRep.Print;
  A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.DistruggiR502Dtm;
  AbilCont:=False;
  A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.TStampa.Close;
end;

function TA033FStampaAnomalie.AnomalieSelezionate:Integer;
var i:Integer;
begin
  Result:=0;
  if CheckBox1.Checked then
    for i:=0 to A033FElenco.Anomalie1.Items.Count - 1 do
      if A033FElenco.Anomalie1.Checked[i] then
        inc(Result);
  if CheckBox2.Checked then
    for i:=0 to A033FElenco.Anomalie2.Items.Count - 1 do
      if A033FElenco.Anomalie2.Checked[i] then
        inc(Result);
  if CheckBox3.Checked then
    for i:=0 to A033FElenco.Anomalie3.Items.Count - 1 do
      if A033FElenco.Anomalie3.Checked[i] then
        inc(Result);
end;

procedure TA033FStampaAnomalie.Button1Click(Sender: TObject);
begin
  with A033FElenco do
    begin
    Anomalie1.Visible:=Sender = Button1;
    Anomalie2.Visible:=Sender = Button2;
    Anomalie3.Visible:=Sender = Button3;
    if Sender = Button1 then
      Caption:='Anomalie di 1° livello'
    else
      if Sender = Button2 then
        Caption:='Anomalie di 2° livello'
      else
        Caption:='Anomalie di 3° livello';
    ShowModal;
    end;
end;

procedure TA033FStampaAnomalie.FormDestroy(Sender: TObject);
begin
  A033FElenco.Release;
  A033FStampaAnomalieQR.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA033FStampaAnomalie.EDaDataExit(Sender: TObject);
var D:TDateTime;
    A,M,G:Word;
begin
  try
    D:=StrToDate(EDaData.Text);
    DecodeDate(D,A,M,G);
    try
      if D > StrToDate(EAData.Text) then
        EAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    except
      EAData.Text:=FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,R180GiorniMese(D)));
    end;
  except
  end;
end;

procedure TA033FStampaAnomalie.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A033',Parametri.ProgOper);
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A033FStampaAnomalieDtM1.A033FStampaAnomalieMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

procedure TA033FStampaAnomalie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;
 //------------------------------------------------------------------------------
procedure TA033FStampaAnomalie.GetParametriFunzione;
{Leggo i parametri della form}
var i:integer;
    StrAnomalie:string;
begin
  with A033FStampaAnomalie do
  begin
    CheckBox1.Checked:= C004FParamForm.GetParametro('LIVELLO1','N') = 'S';
    CheckBox2.Checked:= C004FParamForm.GetParametro('LIVELLO2','N') = 'S';
    CheckBox3.Checked:= C004FParamForm.GetParametro('LIVELLO3','N') = 'S';
    CBTimbrat1.Checked:= C004FParamForm.GetParametro('TIMBRATURE1','N') = 'S';
    CBTimbrat2.Checked:= C004FParamForm.GetParametro('TIMBRATURE2','N') = 'S';
    CBTimbrat3.Checked:= C004FParamForm.GetParametro('TIMBRATURE3','N') = 'S';
    CBCausali1.Checked:= C004FParamForm.GetParametro('CAUSALI1','N') = 'S';
    CBCausali2.Checked:= C004FParamForm.GetParametro('CAUSALI2','N') = 'S';
    CBCausali3.Checked:= C004FParamForm.GetParametro('CAUSALI3','N') = 'S';
    CheckBox4.Checked:= C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
    CKBAggiornaT101.Checked:= C004FParamForm.GetParametro('SALVAANOMALIE','N') = 'S';
    chkAutoGiustificazione.Checked:=C004FParamForm.GetParametro('AUTOGIUSTIFICAZIONE','N') = 'S';
    DbLookupCampo.KeyValue:=C004FParamForm.GetParametro('CAMPORAGGRUPPA',DbLookupCampo.Text);
    if DbLookupCampo.Text = '' then
      DbLookupCampo.KeyValue:=null;
  end;
  StrAnomalie:=C004FParamForm.GetParametro('ANOMALIE1','');
  for i:=1 to High(tdescanom1) do
    A033FElenco.Anomalie1.Checked[i-1]:=R180CarattereDef(StrAnomalie,i,'N') = 'S';

  Button2.Enabled:=True;
  Button3.Enabled:=True;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if Parametri.FiltroDizionario[i].Tabella = 'ANOMALIE DEI CONTEGGI' then
    begin
      Button2.Enabled:=False;
      Button3.Enabled:=False;
    end;
  if Button2.Enabled then
  begin
    StrAnomalie:=C004FParamForm.GetParametro('ANOMALIE2','');
    for i:=1 to High(tdescanom2) do
      A033FElenco.Anomalie2.Checked[i-1]:=R180CarattereDef(StrAnomalie,i,'N') = 'S';

    StrAnomalie:=C004FParamForm.GetParametro('ANOMALIE3','');
    for i:=1 to High(tdescanom3) do
      A033FElenco.Anomalie3.Checked[i-1]:=R180CarattereDef(StrAnomalie,i,'N') = 'S';
  end
  else
  begin
    for i:=1 to High(tdescanom2) do
      A033FElenco.Anomalie2.Checked[i-1]:=A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + intToStr(tdescanom2[i].N));

    for i:=1 to High(tdescanom3) do
      A033FElenco.Anomalie3.Checked[i-1]:=A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(tdescanom3[i].N));
  end;
end;
//------------------------------------------------------------------------------
procedure TA033FStampaAnomalie.PutParametriFunzione;
{Scrivo i parametri della forma}
var i:integer;
    s:string;
begin
  C004FParamForm.Cancella001;
  with A033FStampaAnomalie do
    begin
    if CheckBox1.Checked then
      C004FParamForm.PutParametro('LIVELLO1','S')
    else
      C004FParamForm.PutParametro('LIVELLO1','N');
    if CheckBox2.Checked then
      C004FParamForm.PutParametro('LIVELLO2','S')
    else
      C004FParamForm.PutParametro('LIVELLO2','N');
    if CheckBox3.Checked then
      C004FParamForm.PutParametro('LIVELLO3','S')
    else
      C004FParamForm.PutParametro('LIVELLO3','N');
    if CBTimbrat1.Checked then
      C004FParamForm.PutParametro('TIMBRATURE1','S')
    else
      C004FParamForm.PutParametro('TIMBRATURE1','N');
    if CBTimbrat2.Checked then
      C004FParamForm.PutParametro('TIMBRATURE2','S')
    else
      C004FParamForm.PutParametro('TIMBRATURE2','N');
    if CBTimbrat3.Checked then
      C004FParamForm.PutParametro('TIMBRATURE3','S')
    else
      C004FParamForm.PutParametro('TIMBRATURE3','N');
    if CBCausali1.Checked then
      C004FParamForm.PutParametro('CAUSALI1','S')
    else
      C004FParamForm.PutParametro('CAUSALI1','N');
    if CBCausali2.Checked then
      C004FParamForm.PutParametro('CAUSALI2','S')
    else
      C004FParamForm.PutParametro('CAUSALI2','N');
    if CBCausali3.Checked then
      C004FParamForm.PutParametro('CAUSALI3','S')
    else
      C004FParamForm.PutParametro('CAUSALI3','N');
    if CheckBox4.Checked then
      C004FParamForm.PutParametro('SALTOPAGINA','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINA','N');
    if CKBAggiornaT101.Checked then
      C004FParamForm.PutParametro('SALVAANOMALIE','S')
    else
      C004FParamForm.PutParametro('SALVAANOMALIE','N');
    if chkAutoGiustificazione.Checked then
      C004FParamForm.PutParametro('AUTOGIUSTIFICAZIONE','S')
    else
      C004FParamForm.PutParametro('AUTOGIUSTIFICAZIONE','N');
    C004FParamForm.PutParametro('CAMPORAGGRUPPA',VarToStr(DbLookupCampo.KeyValue));
    end;
  s:='';
  for i:=1 to High(tdescanom1) do
    begin
    if A033FElenco.Anomalie1.Checked[i-1] then
       s:=s+'S'
    else
       s:=s+'N';
    end;
  C004FParamForm.PutParametro('ANOMALIE1',s);
  s:='';
  for i:=1 to High(tdescanom2) do
    begin
    if A033FElenco.Anomalie2.Checked[i-1] then
       s:=s+'S'
    else
       s:=s+'N';
    end;
  C004FParamForm.PutParametro('ANOMALIE2',s);
  s:='';
  for i:=1 to High(tdescanom3) do
    begin
    if A033FElenco.Anomalie3.Checked[i-1] then
       s:=s+'S'
    else
       s:=s+'N';
    end;
  C004FParamForm.PutParametro('ANOMALIE3',s);
  try SessioneOracle.Commit; except end;
end;

procedure TA033FStampaAnomalie.ScorriAnagrafe;
begin
  Screen.Cursor:=crHourGlass;
  with C700SelAnagrafe do
  begin
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=RecordCount;
    First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Enabled:=False;  //disabilita la form
    try
      while not Eof do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar1.StepBy(1);
        if chkAutoGiustificazione.Checked then
          A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.Autogiustificazione;
        A033FStampaAnomalieDtM1.A033FStampaAnomalieMW.ElaboraDipendente;
        Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Enabled:=True; //riabilita la form
      frmSelAnagrafe.VisualizzaDipendente; //Rivisualizza il dipendente
      ProgressBar1.Position:=0;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

function TA033FStampaAnomalie.VerificaAnomaliaSelezionata(Livello,
  idx: Integer): Boolean;
begin
  Result:=False;
  if Livello = 1 then
    Result:=A033FElenco.Anomalie1.Checked[idx - 1]
  else if Livello = 2 then
    Result:=A033FElenco.Anomalie2.Checked[idx - 1]
  else if Livello = 3 then
    Result:=A033FElenco.Anomalie3.Checked[idx - 1];
end;

procedure TA033FStampaAnomalie.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=StrToDate(EAData.Text);
  except
    try
      C005DataVisualizzazione:=StrToDate(EDaData.Text);
    except
      C005DataVisualizzazione:=Parametri.DataLavoro;
    end;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA033FStampaAnomalie.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  try
    C700DataDal:=StrToDate(EDaData.Text);
    C700Datalavoro:=StrToDate(EAData.Text);
  except
    try
      C700Datalavoro:=StrToDate(EDaData.Text);
    except
      C700DataDal:=Parametri.DataLavoro;
      C700Datalavoro:=Parametri.DataLavoro;
    end;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA033FStampaAnomalie.DBLookupCampoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
