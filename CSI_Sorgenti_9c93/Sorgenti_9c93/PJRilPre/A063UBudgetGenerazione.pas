unit A063UBudgetGenerazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Menus,
  Buttons, DBCtrls, StdCtrls, ExtCtrls,DB,checklst, ComCtrls, OracleData, StrUtils,
  RegistrazioneLog, C001StampaLib, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A003UDataLavoroBis, A083UMsgElaborazioni, C004UParamForm, Variants, Mask, Spin, Math,
  Datasnap.DBClient, A063UBudgetGenerazioneMW;

type
  TA063FBudgetGenerazione = class(TForm)
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    clbGruppi: TCheckListBox;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    Label1: TLabel;
    sedtAnno: TSpinEdit;
    rgpOreImporti: TRadioGroup;
    lblGruppi: TLabel;
    Panel3: TPanel;
    chkAssegnaBudget: TCheckBox;
    lblAlMeseBudget: TLabel;
    chkCalcolaFruito: TCheckBox;
    chkRiportaResiduo: TCheckBox;
    chkControlloFiltriAnagrafe: TCheckBox;
    chkDuplicaGruppi: TCheckBox;
    lblDuplicaSuAnno: TLabel;
    sedtDuplicaSuAnno: TSpinEdit;
    cmbDaMeseResiduo: TComboBox;
    cmbAMeseResiduo: TComboBox;
    cmbDaMeseFruito: TComboBox;
    cmbAMeseFruito: TComboBox;
    lblDalMeseFruito: TLabel;
    lblAlMeseFruito: TLabel;
    lblDalMeseResiduo: TLabel;
    lblAlMeseResiduo: TLabel;
    cmbAMeseBudget: TComboBox;
    lblTipo: TLabel;
    dcmbTipo: TDBLookupComboBox;
    lblDescTipo: TLabel;
    lblMesiSuccResiduo: TLabel;
    dsrT275: TDataSource;
    dsrApp: TDataSource;
    cdsApp: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sedtAnnoChange(Sender: TObject);
    procedure dsrAppDataChange(Sender: TObject; Field: TField);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure chkAssegnaBudgetClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    MGen:Integer;
    A063MW: TA063FBudgetGenerazioneMW;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
    procedure RicaricaListaGruppiSel;
    procedure RicaricaClbGruppi;
    procedure CicloAssegnazioneBudgetMensile;
    procedure CicloCalcoloFruitoMensile;
    procedure CicloRiportoResiduoMensile;
    procedure CicloControlloFiltriAnagrafe;
    procedure CicloDuplicazioneGruppi;
    procedure evtRichiesta(Msg,Chiave:String);
  public
    Anno:Integer;
    procedure AbilitaComponenti;
    { Public declarations }
  end;

var
  A063FBudgetGenerazione: TA063FBudgetGenerazione;

procedure OpenA063FBudgetGenerazione(CodGruppo,Tipo:String;Decorrenza:TDateTime);

implementation

{$R *.DFM}

procedure OpenA063FBudgetGenerazione(CodGruppo,Tipo:String;Decorrenza:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA063FBudgetGenerazione') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A063FBudgetGenerazione:=TA063FBudgetGenerazione.Create(nil);
  with A063FBudgetGenerazione do
    try
      wCodGruppo:=CodGruppo;
      wTipo:=Tipo;
      wDecorrenza:=Decorrenza;
      Anno:=R180Anno(Decorrenza);
      MGen:=R180Mese(Decorrenza);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA063FBudgetGenerazione.FormCreate(Sender: TObject);
begin
  A063MW:=TA063FBudgetGenerazioneMW.Create(nil);
  A063MW.evtRichiesta:=evtRichiesta;
  cdsApp.CreateDataSet;
  dsrT275.DataSet:=A063MW.selT275;
end;

procedure TA063FBudgetGenerazione.FormShow(Sender: TObject);
var i:Integer;
begin
  CreaC004(SessioneOracle,'A063',Parametri.ProgOper);
  if Anno = 0 then
    Anno:=R180Anno(Parametri.DataLavoro);
  if MGen = 0 then
    MGen:=R180Mese(Parametri.DataLavoro);
  sedtAnno.Value:=Anno;
  sedtDuplicaSuAnno.Value:=Anno + 1;
  cmbAMeseBudget.ItemIndex:=MGen - 1;
  cmbDaMeseFruito.ItemIndex:=MGen - 1;
  cmbAMeseFruito.ItemIndex:=MGen - 1;
  cmbDaMeseResiduo.ItemIndex:=MGen - 1;
  cmbAMeseResiduo.ItemIndex:=MGen - 1;
  dcmbTipo.KeyValue:=A063MW.selT275.FieldByName('CODICE').AsString;
  lblDescTipo.Caption:=A063MW.selT275.FieldByName('DESCRIZIONE').AsString;
  btnAnomalie.Enabled:=False;
  GetParametriFunzione;
  if wTipo <> '' then
    dcmbTipo.KeyValue:=wTipo;
  //Recupero i gruppi abilitati all'utente corrente
  Screen.Cursor:=crHourGlass;
  A063MW.EseguiFiltroAnagrafeUtente(Anno,1,12);
  A063MW.StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.KeyValue));
  Screen.Cursor:=crDefault;
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato, eventualmente selezionandoli
  RicaricaClbGruppi;
  //Seleziono i gruppi di clbGruppi in base al salvataggio precedente
  GetParametriFunzione2;
  //Allineo la lista dei gruppi selezionati in base al clbGruppi
  RicaricaListaGruppiSel;
  //Se sono richiamato dall'esterno...
  if wCodGruppo <> '' then
  begin
    //Cancello la lista dei gruppi selezionati
    for i:=0 to clbGruppi.Items.Count - 1 do
      clbGruppi.Checked[i]:=False;
    //Seleziono il gruppo richiamato
    if A063MW.selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([wCodGruppo,wTipo,wDecorrenza]),[srFromBeginning]) then
      clbGruppi.Checked[A063MW.selT713.RecNo - 1]:=True;
    //Allineo la lista dei gruppi selezionati in base al clbGruppi
    RicaricaListaGruppiSel;
  end;
  AbilitaComponenti;
end;

procedure TA063FBudgetGenerazione.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA063FBudgetGenerazione.FormDestroy(Sender: TObject);
begin
  A063MW.Free;
end;

procedure TA063FBudgetGenerazione.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpOreImporti.ItemIndex:=StrToInt(C004FParamForm.GetParametro('rgpOreImporti','2'));
  dcmbTipo.KeyValue:=C004FParamForm.GetParametro('dcmbTipo','#LIQ#');
  chkAssegnaBudget.Checked:=C004FParamForm.GetParametro('chkAssegnaBudget','N') = 'S';
  chkCalcolaFruito.Checked:=C004FParamForm.GetParametro('chkCalcolaFruito','N') = 'S';
  chkRiportaResiduo.Checked:=C004FParamForm.GetParametro('chkRiportaResiduo','N') = 'S';
  chkControlloFiltriAnagrafe.Checked:=C004FParamForm.GetParametro('chkControlloFiltri','N') = 'S';
  chkDuplicaGruppi.Checked:=C004FParamForm.GetParametro('chkDuplicaGruppi','N') = 'S';
end;

procedure TA063FBudgetGenerazione.GetParametriFunzione2;
{Leggo i parametri della form}
var x,y,i:integer;
    e: boolean;
    sValore,sNome,sElemento:string;
begin
  //lettura gruppi-tipi-mesi selezionati
  x:=0; //contatore di paramento
  sNome:='clbGruppi';
  repeat
    //ciclo sui parametri clbGruppi0,clbGruppi1,ecc.
    sValore:=C004FParamForm.GetParametro(sNome + IntToStr(x),'');
    y:=0; //contatore di elementi nel parametro
    if sValore <> '' then
    begin
      repeat
        //ciclo sugli elementi nel parametro
        sElemento:=Copy(sValore,(y * 22) + 1,22);
        if sElemento <> '' then
        begin
          i:=0;
          e:=true;
          while (i < clbGruppi.Items.Count) and (e) do
          begin
            if Copy(clbGruppi.Items[i],1,22) = sElemento then
            begin
              clbGruppi.Checked[i]:=true;
              e:=false;
            end
            else if Copy(clbGruppi.Items[i],1,22) > sElemento then
              e:=false;
            inc(i);
          end;
          inc(y);
        end;
      until sElemento = '';
      inc(x);
    end;
  until sValore = '';
end;

procedure TA063FBudgetGenerazione.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('rgpOreImporti',IntToStr(rgpOreImporti.ItemIndex));
  C004FParamForm.PutParametro('dcmbTipo',VarToStr(dcmbTipo.KeyValue));
  C004FParamForm.PutParametro('chkAssegnaBudget',IfThen(chkAssegnaBudget.Checked,'S','N'));
  C004FParamForm.PutParametro('chkCalcolaFruito',IfThen(chkCalcolaFruito.Checked,'S','N'));
  C004FParamForm.PutParametro('chkRiportaResiduo',IfThen(chkRiportaResiduo.Checked,'S','N'));
  C004FParamForm.PutParametro('chkControlloFiltri',IfThen(chkControlloFiltriAnagrafe.Checked,'S','N'));
  C004FParamForm.PutParametro('chkDuplicaGruppi',IfThen(chkDuplicaGruppi.Checked,'S','N'));
  //salvo l'elenco dei gruppi-tipi-mesi selezionati
  x:=0; //contatore parametri gruppi-tipi-decorrenze
  y:=0; //contatore elementi per parametro
  sValore:='';
  sNome:='clbGruppi';
  for i:=1 to clbGruppi.Items.Count do
    if clbGruppi.Checked[i-1] then
    begin
       sValore:=sValore + Copy(clbGruppi.Items[i-1],1,22);
       inc(y);
       if y = 90 then
       begin
          C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
          inc(x);
          y:=0;
          sValore:='';
       end;
    end;
  C004FParamForm.PutParametro(sNome + IntToStr(x),sValore);
  try SessioneOracle.Commit; except end;
end;

procedure TA063FBudgetGenerazione.RicaricaListaGruppiSel;
var i:Integer;
begin
  A063MW.ListaGruppiSel.Clear;
  for i:=0 to clbGruppi.Items.Count - 1 do
    if clbGruppi.Checked[i] then
      A063MW.ListaGruppiSel.Add(clbGruppi.Items[i]);
end;

procedure TA063FBudgetGenerazione.RicaricaClbGruppi;
var i:Integer;
begin
  //Carico in clbGruppi l'elenco dei gruppi appena recuperato
  clbGruppi.Items.Clear;
  for i:=0 to A063MW.ListaGruppi.Count - 1 do
    clbGruppi.Items.Add(A063MW.ListaGruppi[i]);
  //Seleziono i gruppi in clbGruppi
  for i:=0 to clbGruppi.Items.Count - 1 do
    clbGruppi.Checked[i]:=A063MW.ListaGruppiSel.IndexOf(clbGruppi.Items[i]) >= 0;
end;

procedure TA063FBudgetGenerazione.AbilitaComponenti;
var RiportaResiduoAbilitato:Boolean;
begin
  lblAlMeseBudget.Visible:=chkAssegnaBudget.Checked;
  cmbAMeseBudget.Visible:=chkAssegnaBudget.Checked;
  chkCalcolaFruito.Enabled:=not (chkAssegnaBudget.Checked or (chkRiportaResiduo.Checked and chkRiportaResiduo.Enabled) or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);
  lblDalMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbDaMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbDaMeseFruito.Enabled:=VarToStr(dcmbTipo.KeyValue) <> '#ECC#';
  if cmbDaMeseFruito.Visible and not cmbDaMeseFruito.Enabled then
    cmbDaMeseFruito.ItemIndex:=0;
  lblAlMeseFruito.Visible:=chkCalcolaFruito.Checked;
  cmbAMeseFruito.Visible:=chkCalcolaFruito.Checked;
  RiportaResiduoAbilitato:=chkRiportaResiduo.Enabled;
  chkRiportaResiduo.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);
  if chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.KeyValue) = '#ECC#') then
    chkRiportaResiduo.Checked:=True
  else if not RiportaResiduoAbilitato then
    chkRiportaResiduo.Checked:=False;
  chkAssegnaBudget.Enabled:=not (chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked);//Da tenere dopo la forzatura del chkRiportaResiduo.Checked
  lblDalMeseResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.KeyValue) = '#ECC#'));
  lblDalMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbDaMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbDaMeseResiduo.Enabled:=VarToStr(dcmbTipo.KeyValue) <> '#ECC#';
  if cmbDaMeseResiduo.Visible and not cmbDaMeseResiduo.Enabled then
    cmbDaMeseResiduo.ItemIndex:=0;
  lblAlMeseResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.KeyValue) = '#ECC#'));
  lblAlMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbAMeseResiduo.Visible:=chkRiportaResiduo.Checked;
  cmbAMeseResiduo.Enabled:=VarToStr(dcmbTipo.KeyValue) <> '#ECC#';
  if cmbAMeseResiduo.Visible and not cmbAMeseResiduo.Enabled then
    cmbAMeseResiduo.ItemIndex:=11;
  lblMesiSuccResiduo.Caption:=IfThen(VarToStr(dcmbTipo.KeyValue) <> '#ECC#','sul mese successivo','sui mesi successivi');
  lblMesiSuccResiduo.Visible:=chkRiportaResiduo.Checked;
  lblMesiSuccResiduo.Enabled:=not (chkCalcolaFruito.Checked and (VarToStr(dcmbTipo.KeyValue) = '#ECC#'));
  chkControlloFiltriAnagrafe.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkDuplicaGruppi.Checked);
  chkDuplicaGruppi.Enabled:=not (chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked);
  lblDuplicaSuAnno.Visible:=chkDuplicaGruppi.Checked;
  sedtDuplicaSuAnno.Visible:=chkDuplicaGruppi.Checked;
  rgpOreImporti.Enabled:=not chkControlloFiltriAnagrafe.Checked and not chkDuplicaGruppi.Checked;
  clbGruppi.Enabled:=not chkControlloFiltriAnagrafe.Checked;
  btnEsegui.Enabled:=chkAssegnaBudget.Checked or chkCalcolaFruito.Checked or chkRiportaResiduo.Checked or chkControlloFiltriAnagrafe.Checked or chkDuplicaGruppi.Checked;
end;

procedure TA063FBudgetGenerazione.sedtAnnoChange(Sender: TObject);
var Data:TDateTime;
begin
  if Length(sedtAnno.Text) = 4 then
  begin
    try
      Data:=StrToDate('01/01/' + sedtAnno.Text);
      if Anno <> sedtAnno.Value then
      begin
        Anno:=sedtAnno.Value;
        RicaricaListaGruppiSel;
        Screen.Cursor:=crHourGlass;
        A063MW.EseguiFiltroAnagrafeUtente(Anno,1,12);
        A063MW.StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.KeyValue));
        Screen.Cursor:=crDefault;
        RicaricaClbGruppi;
      end;
    except
      sedtAnno.SetFocus;
    end;
  end
  else
  begin
    sedtAnno.SetFocus;
  end;
end;

procedure TA063FBudgetGenerazione.dsrAppDataChange(Sender: TObject; Field: TField);
begin
  with A063MW do
  begin
    if selT275.Active then
      lblDescTipo.Caption:=selT275.FieldByName('DESCRIZIONE').AsString;
    RicaricaListaGruppiSel;
    Screen.Cursor:=crHourGlass;
    StruttureDisponibili(Anno,1,12,VarToStr(dcmbTipo.KeyValue));
    Screen.Cursor:=crDefault;
    RicaricaClbGruppi;
    AbilitaComponenti;
  end;
end;

procedure TA063FBudgetGenerazione.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
end;

procedure TA063FBudgetGenerazione.chkAssegnaBudgetClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA063FBudgetGenerazione.btnEseguiClick(Sender: TObject);
var n:Integer;
begin
  with A063MW do
  begin
    RicaricaListaGruppiSel;
    nAnno:=sedtAnno.Value;
    xOreImporti:=rgpOreImporti.ItemIndex;
    bAssegnaBudget:=chkAssegnaBudget.Checked;
    bCalcolaFruito:=chkCalcolaFruito.Checked;
    bRiportaResiduo:=chkRiportaResiduo.Checked;
    bControlloFiltriAnagrafe:=chkControlloFiltriAnagrafe.Checked;
    bDuplicaGruppi:=chkDuplicaGruppi.Checked;
    AMeseBudget:=cmbAMeseBudget.ItemIndex + 1;
    DaMeseFruito:=cmbDaMeseFruito.ItemIndex + 1;
    AMeseFruito:=cmbAMeseFruito.ItemIndex + 1;
    DaMeseResiduo:=cmbDaMeseResiduo.ItemIndex + 1;
    AMeseResiduo:=cmbAMeseResiduo.ItemIndex + 1;
    nAnnoDup:=sedtDuplicaSuAnno.Value;
    Controlli;
    Domande;
  end;
  btnAnomalie.Enabled:=False;
  n:=A063MW.ListaGruppiSel.Count;
  ProgressBar1.Max:=n;
  try
    Screen.Cursor:=crHourGlass;
    ProgressBar1.Position:=0;
    RegistraMsg.IniziaMessaggio('A063');
    if chkAssegnaBudget.Checked then
      CicloAssegnazioneBudgetMensile
    else if chkCalcolaFruito.Checked then
    begin
      CicloCalcoloFruitoMensile;
      if chkRiportaResiduo.Checked then
      begin
        //Tipo #ECC#
        ProgressBar1.Max:=n;
        ProgressBar1.Position:=0;
        CicloRiportoResiduoMensile;
      end;
    end
    else if chkRiportaResiduo.Checked then
      CicloRiportoResiduoMensile
    else if chkControlloFiltriAnagrafe.Checked then
      CicloControlloFiltriAnagrafe
    else if chkDuplicaGruppi.Checked then
      CicloDuplicazioneGruppi;
    SessioneOracle.Commit;
  finally
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA') ;
end;

procedure TA063FBudgetGenerazione.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A063','');
end;

procedure TA063FBudgetGenerazione.CicloAssegnazioneBudgetMensile;
var i:Integer;
begin
  with A063MW do
    for i:=0 to ListaGruppiSel.Count - 1 do
    begin
      AssegnazioneBudgetMensile(ListaGruppiSel[i]);
      ProgressBar1.StepBy(1);
    end;
end;

procedure TA063FBudgetGenerazione.CicloCalcoloFruitoMensile;
var i:Integer;
    Data,DataMin,DataMax:TDateTime;
begin
  ProgressBar1.Max:=ProgressBar1.Max * (cmbAMeseFruito.ItemIndex - cmbDaMeseFruito.ItemIndex + 1);
  DataMin:=EncodeDate(sedtAnno.Value,cmbDaMeseFruito.ItemIndex + 1,1);
  DataMax:=EncodeDate(sedtAnno.Value,cmbAMeseFruito.ItemIndex + 1,1);
  Data:=DataMin;
  //Ciclo sui mesi: necessario a questo livello per permettere l'ottimizzazione dell'AggiornaFruitoBudget
  while Data <= DataMax do
  begin
    with A063MW do
      for i:=0 to ListaGruppiSel.Count - 1 do
      begin
        CalcoloFruitoMensile(ListaGruppiSel[i],Data);
        ProgressBar1.StepBy(1);
      end;
    Data:=R180FineMese(Data) + 1;
  end;
end;

procedure TA063FBudgetGenerazione.CicloRiportoResiduoMensile;
var i:Integer;
    Data,DataMin,DataMax:TDateTime;
begin
  ProgressBar1.Max:=ProgressBar1.Max * (cmbAMeseResiduo.ItemIndex - cmbDaMeseResiduo.ItemIndex + 1);
  DataMin:=EncodeDate(sedtAnno.Value,cmbDaMeseResiduo.ItemIndex + 1,1);
  DataMax:=EncodeDate(sedtAnno.Value,cmbAMeseResiduo.ItemIndex + 1,1);
  Data:=DataMin;
  while Data <= DataMax do
  begin
    with A063MW do
      for i:=0 to ListaGruppiSel.Count - 1 do
      begin
        RiportoResiduoMensile(ListaGruppiSel[i],Data);
        ProgressBar1.StepBy(1);
      end;
    Data:=R180FineMese(Data) + 1;
  end;
end;

procedure TA063FBudgetGenerazione.CicloControlloFiltriAnagrafe;
begin
  with A063MW do
  begin
    cdsDip.EmptyDataSet;
    cdsAnom.EmptyDataSet;
    selaT713.Close;
    selaT713.SetVariable('ANNO',sedtAnno.Value);
    selaT713.Open;
    if selaT713.RecordCount < 2 then
      exit;
    ProgressBar1.Max:=selaT713.RecordCount;
    while not selaT713.Eof do
    begin
      ControlloFiltriAnagrafe_1;
      ProgressBar1.StepBy(1);
      selaT713.Next;
    end;
    ControlloFiltriAnagrafe_2;
  end;
end;

procedure TA063FBudgetGenerazione.CicloDuplicazioneGruppi;
var i:Integer;
begin
  with A063MW do
    for i:=0 to ListaGruppiSel.Count - 1 do
    begin
      DuplicazioneGruppi(ListaGruppiSel[i]);
      ProgressBar1.StepBy(1);
    end;
end;

procedure TA063FBudgetGenerazione.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort;
end;

end.
