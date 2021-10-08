unit A065UStampaBudget;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, Menus, DBCtrls, StdCtrls, Spin, ExtCtrls, Buttons, CheckLst, StrUtils,
  Oracle, OracleData, R450,
  A000UCostanti, A000USessione, A000UInterfaccia, C001StampaLib, C004UParamForm, C180FunzioniGenerali,
  Mask, ComCtrls;

type
  TA065FStampaBudget = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel1: TPanel;
    lblAnno: TLabel;
    lblDaMese: TLabel;
    lblAMese: TLabel;
    lblTipo: TLabel;
    lblDescTipo: TLabel;
    cmbDaMese: TComboBox;
    cmbAMese: TComboBox;
    sedtAnno: TSpinEdit;
    dcmbTipo: TDBLookupComboBox;
    Panel2: TPanel;
    chkDettaglioDipendenti: TCheckBox;
    chkSaltoPagina: TCheckBox;
    chkTotMese: TCheckBox;
    chkTotGruppo: TCheckBox;
    chkCostoInMoneta: TCheckBox;
    rgpTipoBudget: TRadioGroup;
    lblGruppi: TLabel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    clbGruppi: TCheckListBox;
    chkTotGenerale: TCheckBox;
    chkAggiornaFruito: TCheckBox;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    BitBtn1: TBitBtn;
    btnAnteprima: TBitBtn;
    BStampa: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure sedtAnnoChange(Sender: TObject);
    procedure cmbAMeseChange(Sender: TObject);
    procedure cmbDaMeseExit(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure chkDettaglioDipendentiClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BStampaClick(Sender: TObject);
  private
    { Private declarations }
    wCodGruppo,wTipo:String;
    wDecorrenza:TDateTime;
    procedure GetParametriFunzione;
    procedure GetParametriFunzione2;
    procedure PutParametriFunzione;
  public
    { Public declarations }
    Anno, DaMese, AMese: Integer;
    procedure AbilitaComponenti;
  end;

var
  A065FStampaBudget: TA065FStampaBudget;

procedure OpenA065StampaBudget(CodGruppo,Tipo:String;Decorrenza:TDateTime);

implementation

{$R *.dfm}

uses A065UStampa, A065UStampaBudgetDtM;

procedure OpenA065StampaBudget(CodGruppo,Tipo:String;Decorrenza:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA065StampaBudget') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A065FStampaBudget:=TA065FStampaBudget.Create(nil);
  with A065FStampaBudget do
    try
      wCodGruppo:=CodGruppo;
      wTipo:=Tipo;
      wDecorrenza:=Decorrenza;
      Anno:=R180Anno(Decorrenza);
      A065FStampaBudgetDtM:=TA065FStampaBudgetDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A065FStampaBudgetDtM.Free;
      Free;
    end;
end;

procedure TA065FStampaBudget.FormCreate(Sender: TObject);
begin
  A065FStampa:=TA065FStampa.Create(nil);
end;

procedure TA065FStampaBudget.FormShow(Sender: TObject);
var
  D,M,Y:Word;
  i:Integer;
begin
  CreaC004(SessioneOracle,'A065',Parametri.ProgOper);
  DecodeDate(Parametri.DataLavoro,Y,M,D);
  sedtAnno.Value:=IfThen(Anno = 0,StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro)),Anno);
  cmbDaMese.ItemIndex:=0;
  DaMese:=1;
  cmbAMese.ItemIndex:=M - 1;
  AMese:=M;
  chkCostoInMoneta.Visible:=Parametri.CampiRiferimento.C2_Livello <> '';
  if not chkCostoInMoneta.Visible then
    chkCostoInMoneta.Checked:=False;
  dcmbTipo.KeyValue:=A065FStampaBudgetDtM.selT275.FieldByName('CODICE').AsString;
  lblDescTipo.Caption:=A065FStampaBudgetDtM.selT275.FieldByName('DESCRIZIONE').AsString;
  GetParametriFunzione;
  if wTipo <> '' then
    dcmbTipo.KeyValue:=wTipo;
  A065FStampaBudgetDtM.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065FStampaBudgetDtM.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue),clbGruppi);
  GetParametriFunzione2;
  if wCodGruppo <> '' then
  begin
    for i:=0 to clbGruppi.Items.Count - 1 do
      clbGruppi.Checked[i]:=False;
    if A065FStampaBudgetDtM.selT713.SearchRecord('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([wCodGruppo,wTipo,wDecorrenza]),[srFromBeginning]) then
      clbGruppi.Checked[A065FStampaBudgetDtM.selT713.RecNo - 1]:=True;
  end;
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA065FStampaBudget.FormDestroy(Sender: TObject);
begin
  A065FStampa.Free;
end;

procedure TA065FStampaBudget.GetParametriFunzione;
{Leggo i parametri della form}
begin
  dcmbTipo.KeyValue:=C004FParamForm.GetParametro('dcmbTipo','#LIQ#');
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkDettaglioDipendenti.Checked:=C004FParamForm.GetParametro('DIPENDENTI','N') = 'S';
  chkTotMese.Checked:=C004FParamForm.GetParametro('TOTMESE','N') = 'S';
  chkCostoInMoneta.Checked:=C004FParamForm.GetParametro('COSTO','N') = 'S';
  chkTotGruppo.Checked:=C004FParamForm.GetParametro('TOTREPARTO','N') = 'S';
  chkTotGenerale.Checked:=C004FParamForm.GetParametro('TOTGENERALE','N') = 'S';
  rgpTipoBudget.ItemIndex:=StrToInt(C004FParamForm.GetParametro('rgpTipoBudget','0'));
end;

procedure TA065FStampaBudget.GetParametriFunzione2;
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

procedure TA065FStampaBudget.PutParametriFunzione;
{Scrivo i parametri della form}
var i,x,y:integer;
    sValore,sNome:string;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('dcmbTipo',VarToStr(dcmbTipo.KeyValue));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('DIPENDENTI',IfThen(chkDettaglioDipendenti.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTMESE',IfThen(chkTotMese.Checked,'S','N'));
  C004FParamForm.PutParametro('COSTO',IfThen(chkCostoInMoneta.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTREPARTO',IfThen(chkTotGruppo.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTGENERALE',IfThen(chkTotGenerale.Checked,'S','N'));
  C004FParamForm.PutParametro('rgpTipoBudget',IntToStr(rgpTipoBudget.ItemIndex));
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

procedure TA065FStampaBudget.AbilitaComponenti;
begin
  cmbDaMese.Enabled:=(dcmbTipo.KeyValue <> '#ECC#');
  chkAggiornaFruito.Enabled:=not SolaLettura;
  chkAggiornaFruito.Caption:='Aggiornamento del fruito' + IfThen(dcmbTipo.KeyValue = '#ECC#',' e riporto del residuo');
  if not chkDettaglioDipendenti.Enabled then
    chkDettaglioDipendenti.Checked:=False;
  chkTotMese.Enabled:=(cmbDaMese.ItemIndex <> cmbAMese.ItemIndex) and chkDettaglioDipendenti.Checked;
  if not chkTotMese.Enabled then
    chkTotMese.Checked:=False;
  chkCostoInMoneta.Enabled:=((dcmbTipo.KeyValue = '#LIQ#') or (dcmbTipo.KeyValue = '#B.O#')) and chkDettaglioDipendenti.Checked;
  if not chkCostoInMoneta.Enabled then
    chkCostoInMoneta.Checked:=False;
end;

procedure TA065FStampaBudget.sedtAnnoChange(Sender: TObject);
var
  Data:TDateTime;
begin
  if Length(sedtAnno.Text) = 4 then
    try
      Data:=StrToDate('01/01/' + sedtAnno.Text);
      Anno:=sedtAnno.Value;
      A065FStampaBudgetDtM.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
      A065FStampaBudgetDtM.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue),clbGruppi);
    except
      sedtAnno.SetFocus;
    end
  else
    sedtAnno.SetFocus;
end;

procedure TA065FStampaBudget.cmbAMeseChange(Sender: TObject);
begin
  DaMese:=cmbDaMese.ItemIndex + 1;
  AMese:=cmbAMese.ItemIndex + 1;
  if cmbDaMese.ItemIndex > cmbAMese.ItemIndex then
  begin
    ShowMessage('Impostare correttamente il periodo!');
    (Sender as TComboBox).SetFocus;
    exit;
  end;
  A065FStampaBudgetDtM.EseguiFiltroAnagrafeUtente(Anno,DaMese,AMese);
  A065FStampaBudgetDtM.StruttureDisponibili(Anno,DaMese,AMese,VarToStr(dcmbTipo.KeyValue),clbGruppi);
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.cmbDaMeseExit(Sender: TObject);
begin
  if cmbDaMese.ItemIndex > cmbAMese.ItemIndex then
  begin
    ShowMessage('Impostare correttamente il periodo!');
    (Sender as TComboBox).SetFocus;
  end;
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=True;
end;

procedure TA065FStampaBudget.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=False;
end;

procedure TA065FStampaBudget.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with TCheckListBox(PopupMenu1.PopupComponent) do
    for i:=0 to Items.Count - 1 do
       Checked[i]:=not Checked[i];
end;

procedure TA065FStampaBudget.chkDettaglioDipendentiClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA065FStampaBudget.BitBtn1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A065FStampa.QRep);
end;

procedure TA065FStampaBudget.BStampaClick(Sender: TObject);
begin
  ProgressBar1.Position:=0;
  Screen.Cursor:=crHourGlass;
  A065FStampaBudgetDtM.cdsStampa.EmptyDataSet;
  A065FStampaBudgetDtM.CreaQueryStampa;
  Screen.Cursor:=crDefault;
  with A065FStampa do
  begin
    Anno:=A065FStampaBudget.Anno;
    DaMese:=A065FStampaBudget.DaMese;
    AMese:=A065FStampaBudget.AMese;
    LEnte.Caption:=Parametri.DAzienda;
    LTitolo.Caption:='Budget straordinario mensile dell''anno ' + sedtAnno.Text;
    bndTestGruppi.ForceNewPage:=chkSaltoPagina.Checked;
    lblTitoloMonetizzazione.Enabled:=chkCostoInMoneta.Checked;
    bndTestDipendenti.Enabled:=chkDettaglioDipendenti.Checked;
    lblTitoloFascia15Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloFascia30Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloFascia50Dip.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTitoloMonetizzazioneDip.Enabled:=chkCostoInMoneta.Checked;
    bndDettDipendenti.Enabled:=chkDettaglioDipendenti.Checked;
    lblF15.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblF30.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblF50.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblSoldi.Enabled:=chkCostoInMoneta.Checked;
    bndTotMesi.Enabled:=chkTotMese.Checked;
    lblTotF15.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotF30.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotF50.Enabled:=not (dcmbTipo.KeyValue = '#ECC#');
    lblTotSoldiMese.Enabled:=chkCostoInMoneta.Checked;
    bndTotGruppi.Enabled:=chkTotGruppo.Checked;
    bndTotGruppi.Frame.DrawTop:=chkTotGruppo.Checked;
    lblTotSoldiGruppo.Enabled:=chkCostoInMoneta.Checked;
    bndTotGenerale.ForceNewPage:=chkSaltoPagina.Checked;
    bndTotGenerale.Enabled:=chkTotGenerale.Checked;
    lblTitoloMonetizzazioneGenerale.Enabled:=chkCostoInMoneta.Checked;
    lblTotSoldiGenerale.Enabled:=chkCostoInMoneta.Checked;
    if dcmbTipo.KeyValue = '#ECC#' then
      R450DtM:=TR450DtM1.Create(nil);
    QRep.DataSet.First;
    if Sender = btnAnteprima then
      QRep.Preview
    else
      QRep.Print;
    if dcmbTipo.KeyValue = '#ECC#' then
      FreeAndNil(R450DtM);
  end;
  ProgressBar1.Position:=0;
end;

end.
