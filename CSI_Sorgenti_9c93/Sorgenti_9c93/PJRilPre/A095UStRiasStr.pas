unit A095UStRiasStr;

interface

uses
  //OracleMonitor,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin ,C001StampaLib, C180FunzioniGenerali,
  A000UCostanti, A000USessione,A000UInterfaccia,Grids, DBGrids, ExtCtrls,DB,ComCtrls,
  C004UParamForm, C700USelezioneAnagrafe, QueryStorico,
  R450, checklst, RegistrazioneLog, A029UBudgetDtM1, A029ULiquidazione,
  SelAnagrafe, Menus, C005UDatiAnagrafici, Variants,
  Oracle, OracleData, A083UMsgElaborazioni, A000UMessaggi;

type
  TA095FStRiasStr = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    SEAnno: TSpinEdit;
    SEMese: TSpinEdit;
    CheckBox1: TCheckBox;
    BtnPreView: TBitBtn;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    chkLiquidazione: TCheckBox;
    BitBtn1: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Intestazione: TCheckListBox;
    Dettaglio: TCheckListBox;
    rgpDisponibilita: TRadioGroup;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    btnAnnullaLiq: TBitBtn;
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkLiquidazioneClick(Sender: TObject);
    procedure IntestazioneMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IntestazioneMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnAnnullaLiqClick(Sender: TObject);
  private
    ItemCB:Integer;
    FormWidth:Integer;
    procedure ScorriQueryAnagrafica;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    Gruppo1 : String;
    CampoRagg : String;
    SolaLettura : Boolean;
  end;

var
  A095FStRiasStr: TA095FStRiasStr;

procedure OpenA095StRiasStr(Prog:LongInt);

implementation

uses A095UStampa, A095UStRiasStrDtM1;

{$R *.DFM}

procedure OpenA095StRiasStr(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA095StRiasStr') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A095FStRiasStr:=TA095FStRiasStr.Create(nil);
  A095FStRiasStr.SolaLettura:=SolaLettura;
  with A095FStRiasStr do
    try
      C700Progressivo:=Prog;
      A095FStRiasStrDtM1:=TA095FStRiasStrDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A095FStRiasStrDtM1.Free;
      Free;
    end;
end;

procedure TA095FStRiasStr.FormCreate(Sender: TObject);
begin
  A095FStampa:=TA095FStampa.Create(nil);
  SolaLettura:=False;
  ItemCB:=-1;
  FormWidth:=Width;
  Constraints.MinWidth:=Width;
  Constraints.MaxWidth:=Width;
  btnAnomalie.Enabled:=False;
end;

procedure TA095FStRiasStr.FormShow(Sender: TObject);
var i: Integer;
begin
  CreaC004(SessioneOracle,'A095',Parametri.ProgOper);
  with A095FStRiasStrDtM1.A095FStRiasStrMW do
  begin
    for i:=0 to LstCampiIntestazioneAnagrafe.Count - 1 do
      Intestazione.Items.Add(LstCampiIntestazioneAnagrafe[i]);
    for i:=0 to LstCampiDettaglioAnagrafe.Count - 1 do
      Dettaglio.Items.Add(LstCampiDettaglioAnagrafe[i]);
  end;
  A095FStampa.SettaDataset;

  GetParametriFunzione;
  SEAnno.Value:=StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro));
  SEMese.Value:=StrToInt(FormatDateTime('mm',Parametri.DataLavoro));
  chkLiquidazione.Enabled:=not SolaLettura;
  BitBtn1.Enabled:=chkLiquidazione.Checked;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A095FStRiasStrDtM1.A095FStRiasStrMW,SessioneOracle,StatusBar,0,False);
end;

procedure TA095FStRiasStr.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A095FStampa);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA095FStRiasStr.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A095FStampa.RepR);
end;


procedure TA095FStRiasStr.ScorriQueryAnagrafica;
begin
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  //Massimo: abbinamento già fatto nel CreaSelAnagrafe
  //A095FStRiasStrDtM1.A095FStRiasStrMW.SelAnagrafe:=C700SelAnagrafe;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
      begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      A095FStRiasStrDtM1.A095FStRiasStrMW.ElaboraDipendente(SEAnno.Value, SEMese.Value, rgpDisponibilita.ItemIndex, chkLiquidazione.checked);
      C700SelAnagrafe.Next;
      end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TA095FStRiasStr.BtnStampaClick(Sender: TObject);
var Data:TDateTime;
    i, L:Integer;
    LstIntestazione,
    LstDettaglio: TStringList;
    S: String;
begin
  btnAnomalie.Enabled:=False;
  A095FStRiasStrDtM1.A095FStRiasStrMW.selDatiBloccati.Close;
  RegistraMsg.IniziaMessaggio('A095');
  Data:=R180FineMese(EncodeDate(SEAnno.Value,SEMese.Value,1));

  LstIntestazione:=TStringList.Create;
  LstDettaglio:=TStringList.Create;
  try
    for i:=0 to Intestazione.Items.Count - 1 do
      if Intestazione.Checked[i] then
        LstIntestazione.Add(Intestazione.Items[i]);

    for i:=0 to Dettaglio.Items.Count - 1 do
      if Dettaglio.Checked[i] then
        LstDettaglio.Add(Dettaglio.Items[i]);

    S:=A095FStRiasStrDtM1.A095FStRiasStrMW.SettaCampiSelAnagrafe(C700SelAnagrafe.SQL.Text,SEAnno.Value, LstIntestazione, LstDettaglio);
    if S <> '' then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  finally
    FreeAndNil(LstIntestazione);
    FreeAndNil(LstDettaglio);
  end;
  with C700SelAnagrafe do
  begin
    if GetVariable('DataLavoro') <> Data then
    begin
      Close;
      SetVariable('DataLavoro',Data);
    end;
    Open;
    frmSelAnagrafe.NumRecords;
  end;
  A095FStRiasStrDtM1.A095FStRiasStrMW.CreaTabellaStampa;
  A095FStRiasStrDtM1.A095FStRiasStrMW.SettaVariabiliDataset(SEAnno.Value, SEMese.Value);
  ScorriQueryAnagrafica;

  A095FStRiasStrDtM1.A095FStRiasStrMW.PreparaAggiornaFruitoBudget(Data);
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);

  //Non è richiesta la stampa
  if Sender = BitBtn1 then
  begin
    if btnAnomalie.Enabled then
    begin
      if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox('Elaborazione terminata',INFORMA);
  end
  else
  begin
    A095FStampa.QRGroup1.Expression:='';
    A095FStampa.QRGroup1.Enabled:=False;
    with A095FStRiasStrDtM1.A095FStRiasStrMW do
      for i:=0 to INomeCampo.Count - 1 do
      begin
        if A095FStampa.QRGroup1.Expression <> '' then
          A095FStampa.QRGroup1.Expression:=A095FStampa.QRGroup1.Expression + '+';
        A095FStampa.QRGroup1.Expression:=A095FStampa.QRGroup1.Expression + INomeCampo[i];
        A095FStampa.QRGroup1.Enabled:=True;
      end;
    A095FStampa.QRFoot1.Enabled:=(CheckBox2.Checked) and (A095FStampa.QRGroup1.Enabled);

    // abilita gli eventuali totali generali
    A095FStampa.QRBand2.Enabled:=CheckBox3.Checked;
    // abilita il salto pagina
    A095FStampa.QRGroup1.ForceNewPage:=CheckBox1.Checked;
    //Definizione della label di intestazione NomiDettaglio
    A095FStampa.NomiDettaglio.Caption:='';
    with A095FStRiasStrDtM1.A095FStRiasStrMW do
      for i:=0 to DNomeCampo.Count - 1 do
      begin
        if i > 0 then
          A095FStampa.NomiDettaglio.Caption:=A095FStampa.NomiDettaglio.Caption + ' ';
        if Length(DNomeLogico[i]) > C700SelAnagrafe.FieldByName(DNomeCampo[i]).Size then
          L:=Length(DNomeLogico[i])
        else
          L:=C700SelAnagrafe.FieldByName(DNomeCampo[i]).Size;
        S:=Format('%-*s',[L,DNomeLogico[i]]);
        S:=Copy(S,1,L);
        A095FStampa.NomiDettaglio.Caption:=A095FStampa.NomiDettaglio.Caption + S;
      end;
    // crea la stampa
    A095FStampa.CreaReport(Sender=BtnPreView);
    A095FStRiasStrDtM1.A095FStRiasStrMW.TabellaStampa.Close;
  end;
end;

procedure TA095FStRiasStr.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A095','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A095FStRiasStrDtM1.A095FStRiasStrMW);
end;

procedure TA095FStRiasStr.GetParametriFunzione;
{Leggo i parametri della form}
var i,P:Integer;
    L:TStringList;
    S,S1:String;
begin
  rgpDisponibilita.ItemIndex:=StrToInt(C004FParamForm.GetParametro('DISPONIBILITA','0'));
  CheckBox1.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  CheckBox2.Checked:=C004FParamForm.GetParametro('TOTALIPARZIALI','N') = 'S';
  CheckBox3.Checked:=C004FParamForm.GetParametro('TOTALIGENERALI','N') = 'S';
  L:=TStringList.Create;
  S1:='';
  S:=C004FParamForm.GetParametro('INTESTAZIONE','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Intestazione.Items.IndexOf(L[i]);
    if P >= 0 then
      Intestazione.Items.Delete(P);
    Intestazione.Items.Insert(0,L[i]);
    Intestazione.Checked[0]:=True;
  end;
  L.Clear;
  S1:='';
  S:=C004FParamForm.GetParametro('DETTAGLIO','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Dettaglio.Items.IndexOf(L[i]);
    if P >= 0 then
      Dettaglio.Items.Delete(P);
    Dettaglio.Items.Insert(0,L[i]);
    Dettaglio.Checked[0]:=True;
  end;
  FreeAndNil(L);
end;

procedure TA095FStRiasStr.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DISPONIBILITA',IntToStr(rgpDisponibilita.ItemIndex));
  if CheckBox1.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if CheckBox2.Checked then
    C004FParamForm.PutParametro('TOTALIPARZIALI','S')
  else
    C004FParamForm.PutParametro('TOTALIPARZIALI','N');
  if CheckBox3.Checked then
    C004FParamForm.PutParametro('TOTALIGENERALI','S')
  else
    C004FParamForm.PutParametro('TOTALIGENERALI','N');
  C004FParamForm.PutParametro('INTESTAZIONE',R180GetCheckList(99,Intestazione));
  C004FParamForm.PutParametro('DETTAGLIO',R180GetCheckList(99,Dettaglio));
  try SessioneOracle.Commit; except end;
end;

procedure TA095FStRiasStr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA095FStRiasStr.chkLiquidazioneClick(Sender: TObject);
begin
  BitBtn1.Enabled:=chkLiquidazione.Checked;
end;

procedure TA095FStRiasStr.IntestazioneMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=Intestazione.ItemIndex;
end;

procedure TA095FStRiasStr.IntestazioneMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> Intestazione.ItemIndex) then
  begin
    C1:=Intestazione.Checked[ItemCB];
    C2:=Intestazione.Checked[Intestazione.ItemIndex];
    Intestazione.Items.Exchange(ItemCB,Intestazione.ItemIndex);
    Intestazione.Checked[ItemCB]:=C2;
    Intestazione.Checked[Intestazione.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA095FStRiasStr.DettaglioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=Dettaglio.ItemIndex;
end;

procedure TA095FStRiasStr.DettaglioMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemCB <> -1) and (ItemCB <> Dettaglio.ItemIndex) then
  begin
    C1:=Dettaglio.Checked[ItemCB];
    C2:=Dettaglio.Checked[Dettaglio.ItemIndex];
    Dettaglio.Items.Exchange(ItemCB,Dettaglio.ItemIndex);
    Dettaglio.Checked[ItemCB]:=C2;
    Dettaglio.Checked[Dettaglio.ItemIndex]:=C1;
  end;
  ItemCB:= - 1;
end;

procedure TA095FStRiasStr.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=R180FineMese(EncodeDate(SEAnno.Value,SEMese.Value,1));
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA095FStRiasStr.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=R180FineMese(EncodeDate(SEAnno.Value,SEMese.Value,1));
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA095FStRiasStr.btnAnnullaLiqClick(Sender: TObject);
var
  DataLiq,DataTmp: TDateTime;
begin
  //Caratto 11/07/2013  - deve valutare i dipendenti nel periodo indicato
  DataTmp:=EncodeDate(SEAnno.Value,SEMese.Value,1);

  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(DataTmp),R180FineMese(DataTmp)) then
  begin
    C700SelAnagrafe.Close;
  end;
  C700SelAnagrafe.Open;
  ////Caratto 11/07/2013 - fine
  DataLiq:=A095FStRiasStrDtM1.A095FStRiasStrMW.ControlloLiquid(C700SelAnagrafe, SEAnno.Value,SEMese.Value);

  if R180MessageBox(Format(A000MSG_A095_DLG_FMT_ANNULLA_LIQ,[UpperCase(FormatDateTime('mmmm yyyy',DataLiq))]),'DOMANDA') <> mrYes then
    Exit;

  A095FStRiasStrDtM1.A095FStRiasStrMW.ApriSelT071(DataLiq,SEAnno.Value,SEMese.Value, C700SelAnagrafe.VariableIndex('C700DATADAL') >= 0);

  with A095FStRiasStrDtM1.A095FStRiasStrMW do
  begin
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    while not selT071.Eof do
    begin
      ProgressBar.StepBy(1);
      ElaboraAnnullaLiquidazione(DataLiq);
      selT071.Next;
    end;
  end;
  //Calcolo il fruito e aggiorno il budget straordinario
  if Parametri.CampiRiferimento.C2_Facoltativo <> '' then
  begin
    A095FStRiasStrDtM1.A095FStRiasStrMW.A029FLiquidazione.A029FBudgetDtM1.PreparaAggiornaFruitoBudget(DataLiq,'#LIQ#');
    SessioneOracle.Commit;
  end;
  ProgressBar.Position:=0;
  R180MessageBox('Elaborazione terminata!','INFORMA');
end;

end.
