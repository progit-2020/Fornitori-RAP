unit A029USchedaRiepilDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, C180FunzioniGenerali, R450, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  QueryStorico, RegistrazioneLog, OracleData, Oracle,
  A003UDataLavoroBis, Variants,  Math, StrUtils,
  A029USchedaRiepilMW,A029ULiquidazione,A029UBudgetDtM1, A000UMessaggi;

type
  TA029FSchedaRiepilDtM1 = class(TDataModule)
    Q070: TOracleDataSet;
    Q070PROGRESSIVO: TFloatField;
    Q070DATA: TDateTimeField;
    Q070DEBITOORARIO: TStringField;
    Q070DEBITOPO: TStringField;
    Q070TIPOPO: TStringField;
    Q070FESTIVINTERA: TFloatField;
    Q070FESTIVRIDOTTA: TFloatField;
    Q070INDTURNONUM: TFloatField;
    Q070INDTURNOORE: TStringField;
    Q070CAUSALE1MINASS: TStringField;
    Q070CAUSALE2MINASS: TStringField;
    Q070OREECCEDCOMP: TStringField;
    Q070TURNI1: TFloatField;
    Q070TURNI2: TFloatField;
    Q070TURNI3: TFloatField;
    Q070TURNI4: TFloatField;
    Q070GGPRESENZA: TFloatField;
    Q070GGVUOTI: TFloatField;
    Q070OREVARIAZECC: TStringField;
    Q070OREASSENZE: TStringField;
    Q070D_Causale1: TStringField;
    Q070D_Causale2: TStringField;
    Q070RECANNOCORR: TStringField;
    Q070RECANNOPREC: TStringField;
    Q070SCOSTNEG: TStringField;
    Q070RIPCOM: TStringField;
    Q070ABBRIPCOM: TStringField;
    Q070ADDEBITOPAGHE: TStringField;
    SumReperibilita: TOracleDataSet;
    Q070RECLIQCORR: TStringField;
    Q070RECLIQPREC: TStringField;
    Q070ORECOMP_LIQUIDATE: TStringField;
    Q070LIQ_FUORI_BUDGET: TFloatField;
    Q070ORECOMP_RECUPERATE: TStringField;
    Q070OREECCEDCOMPOLTRESOGLIA: TStringField;
    Q070ORE_INAIL: TStringField;
    Q070FESTIVINTERA_VAR: TFloatField;
    Q070FESTIVRIDOTTA_VAR: TFloatField;
    Q070INDTURNOORE_VAR: TStringField;
    Q070INDTURNONUM_VAR: TIntegerField;
    Q070RIPOSI_NONFRUITI: TIntegerField;
    Q070RIPOSINONFRUITIORE: TStringField;
    Q070BANCAORE_LIQ_VAR: TStringField;
    procedure A029FSchedaRiepilDtM1Create(Sender: TObject);
    procedure A029FSchedaRiepilDtM1Destroy(Sender: TObject);
    procedure Q070NewRecord(DataSet: TDataSet);
    procedure BDEQ070UpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure Q070AfterInsert(DataSet: TDataSet);
    procedure Q070AfterCancel(DataSet: TDataSet);
    procedure Q070AfterPost(DataSet: TDataSet);
    procedure Q070BeforeDelete(DataSet: TDataSet);
    procedure Q070AfterEdit(DataSet: TDataSet);
    procedure BDEQ072UpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure BDEQ074UpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure BDEQ070CAUSALE1MINASSValidate(Sender: TField);
    procedure Q070BeforeInsert(DataSet: TDataSet);
    procedure Q070AfterScroll(DataSet: TDataSet);
    procedure Q070BeforePost(DataSet: TDataSet);
    procedure Q070AfterDelete(DataSet: TDataSet);
    procedure Q070BeforeScroll(DataSet: TDataSet);
    procedure Q070ORECOMP_LIQUIDATEValidate(Sender: TField);
    procedure Q070ORECOMP_RECUPERATEValidate(Sender: TField);
    procedure BDEQ070DEBITOORARIOValidate(Sender: TField);
  private
    PutLiquidatoFuoriBudget,AbortPost: Boolean;
    OreLiq,MaxLiquidato: Integer;
    MsgAbort: String;
    procedure ImpostaStraordinarioEsterno(SE: Integer);
    procedure VisualizzaDatiCalcolati(totali: TTotali);
    procedure AggiornaDettaglioCausalePresenza;
    procedure selT074LiqBeforePost(DataSet: TDataSet);
    procedure selT073CompBeforePost(DataSet: TDataSet);
    procedure CaricaPickListVociPaghe;
    procedure ImpostaContrattoEPartTime(ContrPartTime: TContrattoPartTime;
      EsisteContratto: Boolean);
    procedure CaricaComboCausaliPresenza;
  public
    A029FSchedaRiepilMW: TA029FSchedaRiepilMW;
  end;

var
  A029FSchedaRiepilDtM1: TA029FSchedaRiepilDtM1;

implementation

uses A029USchedaRiepil;

{$R *.DFM}

procedure TA029FSchedaRiepilDtM1.A029FSchedaRiepilDtM1Create(Sender: TObject);
{allocazione delle Query}
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  //Impostazioni MW
  A029FSchedaRiepilMW:=TA029FSchedaRiepilMW.Create(Self);
  A029FSchedaRiepilMW.selT074Liq.BeforePost:=selT074LiqBeforePost;
  A029FSchedaRiepilMW.selT073Comp.BeforePost:=selT073CompBeforePost;
  A029FSchedaRiepilMW.selT070_Funzioni:=Q070;
  A029FSchedaRiepilMW.dsrT071.OnDataChange:=A029FSchedaRiepilMW.dsrT071DataChange; //usare solo su win
  A029FSchedaRiepilMW.VisualizzaDatiCalcolati:=VisualizzaDatiCalcolati;
  A029FSchedaRiepilMW.AggiornaDettaglioCausalePresenza:=AggiornaDettaglioCausalePresenza;
  A029FSchedaRiepilMW.CaricaComboCausaliPresenza:=CaricaComboCausaliPresenza;
  A029FSchedaRiepilMW.ImpostaStraordinarioEsterno:=ImpostaStraordinarioEsterno;
  A029FSchedaRiepilMW.ImpostaContrattoEPartTime:=ImpostaContrattoEPartTime;

  q070.FieldByName('D_CAUSALE1').LookupDataSet:=A029FSchedaRiepilMW.selT305;
  q070.FieldByName('D_CAUSALE2').LookupDataSet:=A029FSchedaRiepilMW.selT305;
  //Impostazione Datasource controlli del form
  with A029FSchedaRiepil do
  begin
    DBGFasce.DataSource:=A029FSchedaRiepilMW.dsrT071;
    GIndennita.DataSource:=A029FSchedaRiepilMW.dsrT071;
    DBGStraord.DataSource:=A029FSchedaRiepilMW.dsrT071;
    DBGrid3.DataSource:=A029FSchedaRiepilMW.dsrT074;
    dedtOreEsclCompMese.DataSource:=A029FSchedaRiepilMW.dsrT073Comp;
    DBEdit23.DataSource:=A029FSchedaRiepilMW.dsrT073Comp;
    grdPresLiq.DataSource:=A029FSchedaRiepilMW.dsrT074Liq;
    DBGrid4.DataSource:=A029FSchedaRiepilMW.dsrT072;
    DBGrid1.DataSource:=A029FSchedaRiepilMW.dsrT075;
    DBGrid2.DataSource:=A029FSchedaRiepilMW.dsrT076;
    dgrdDatiScheda.DataSource:=A029FSchedaRiepilMW.dsrT077;
    DBLookupComboBox1.ListSource:=A029FSchedaRiepilMW.dsrT305;
    DBLookupComboBox2.ListSource:=A029FSchedaRiepilMW.dsrT305;
  end;

  CaricaPickListVociPaghe;
  //Apertura conteggi mensili R450
  //A029FSchedaRiepil.R450Dtm1:=TR450Dtm1.Create(Self);
  //Caratto 07/05/2013. Rimozione variabili globali  A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
  A029FSchedaRiepil.DButton.DataSet:=Q070;
  A029FSchedaRiepil.SituazioneBudgetStraordinario1.Visible:=A029FSchedaRiepilMW.Budget;
end;

procedure TA029FSchedaRiepilDtM1.CaricaPickListVociPaghe;
var i: Integer;
begin
  with A029FSchedaRiepil.DbGrid2 do
  begin
    for i:=0 to Columns.Count - 1 do
    begin
      if Columns[i].FieldName = 'VOCEPAGHE' then
      begin
        Columns[i].PickList.Clear;
        A029FSchedaRiepilMW.selT276.First;
        while not A029FSchedaRiepilMW.selT276.Eof do
        begin
          if Columns[i].PickList.IndexOf(A029FSchedaRiepilMW.selT276.FieldByName('VocePaghe').AsString) = -1 then
            Columns[i].PickList.Add(A029FSchedaRiepilMW.selT276.FieldByName('VOCEPAGHE').AsString);
          A029FSchedaRiepilMW.selT276.Next;
        end;
      end;
    end;
  end;
end;

procedure TA029FSchedaRiepilDtM1.VisualizzaDatiCalcolati(totali: TTotali);
var
  i:Integer;
begin
with A029FSchedaRiepil do
  begin
  if Q070.FieldByname('Data').AsDateTime <> 0 then
    LData.Caption:=FormatDateTime('mmmm yyyy',Q070.FieldByname('Data').AsDateTime)
  else
    LData.Caption:='';

    //Pagina 'Saldi'
    EDebitoCompl.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebTotMes);
    EOreLavorate.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreRes);
    EOrePresenza.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreRes - R180OreMinutiExt(Q070.FieldByName('OreAssenze').AsString));
    ESaldoMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.SalMeseAtt);
    ESaldoAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.SalAnnoAtt);
    EDebPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebPOAnno);
    EResiduoPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.debpoannores);
    EResoPOMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.debpoeff);
    EResoPOAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.DebPOAnno - A029FSchedaRiepilMW.R450DtM1.debpoannores);
    //ESaldoPOAnno.Text:=R180MinutiOre(R450DtM1.SalPOAnno);
    EMesePrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salfmprec);
    ESaldoAnnoPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salcompannoprec + A029FSchedaRiepilMW.R450DtM1.salliqannoprec);
    ESaldoAnnoCorr.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salcompannoatt + A029FSchedaRiepilMW.R450DtM1.salliqannoatt);
    EOrePerse.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OrePersePeriodiche);
    edtOreTroncate.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreTroncate);
    EOreAddebitate.Text:=Format('%s (%s)',[R180MinutiOre(R180OreMinutiExt(Q070.FieldByName('AddebitoPaghe').AsString)),R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.AddebitoPaghe)]);
    EEccResAutMen.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccResAutMen);
    edtOreEsclComp.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreEsclComp);
    edtAbbRipComMes.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.abbripcommes + A029FSchedaRiepilMW.R450DtM1.RipComLiqMes);
    edtSaldoRipCom.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.salripcom);
    edtlblLiqOreAnniPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.LiqOreAnniPrec);
    edtlblVariazioneSaldo.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.VariazioneSaldo);
    lblRipComFasce.Visible:=Trim(A029FSchedaRiepilMW.R450DtM1.CausRipComFasce) <> '';
    lblRipComFasce.Caption:='per il riepilogo/liquid. in fasce vedere caus. ' + A029FSchedaRiepilMW.R450DtM1.CausRipComFasce;
    SGFasce.Cells[2,0]:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreResOri);
    SGFasce.Cells[3,0]:=R180MinutiOre(totali.TotAss1);
    SGFasce.Cells[4,0]:=R180MinutiOre(totali.TotAss2);
    SGFasce.Cells[5,0]:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.TotOreResOri + totali.TotAss1 + totali.TotAss2);
    //Pagina 'Straordinario'
    EStrAutAnn.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccAutAnno['LIQUIDABILE']);
    //EStrAutMen.Text:=R180MinutiOre(R450DtM1.StrAutMen);
    EStrAutMen.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.StrAutMenNoCau);
    edtOreCausalizzateEsterneLiq.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.OreCausLiqSenzaLimiti);
    EEccCompAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccSoloCompAnno);
    EEccResidua.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.EccSoloCompRes);
    EEccCompMese.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.CompensabileMensileNettoRiposi);
    edtVarEccLiqAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.VarEccLiqAnno);
    edtRiposiNonFruiti.Text:=FloatToStr(A029FSchedaRiepilMW.R450DtM1.RiposiNonFruitiGG) + ' (' + R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.RiposiNonFruitiOre) + ')';
    SGStraord.Cells[2,0]:=R180MinutiOre(totali.TotStrEcc);
    SGStraord.Cells[3,0]:=R180MinutiOre(totali.TotStrMes);
    SGStraord.Cells[4,0]:=R180MinutiOre(totali.TotStrLiq);
    SGStraord.Cells[5,0]:=R180MinutiOre(totali.TotLiqNelMese);
    SGStraord.Cells[6,0]:=R180MinutiOre(totali.TotStrAut);
    SGStraord.Cells[7,0]:=R180MinutiOre(totali.TotStrAnn);
    SGStraord.Cells[8,0]:=R180MinutiOre(totali.TotStrAut - totali.TotStrAnn);
    Edit2.Text:=R180MinutiOre(totali.TotStrMes);
    //Pagina 'BancaOre'
    grdOreCompensabili.RowCount:=A029FSchedaRiepilMW.R450DtM1.NFasceMese + 1;
    if grdOreCompensabili.RowCount > 1 then
      grdOreCompensabili.FixedRows:=1;
    grdOreCompensabili.Cells[0,0]:='Fasce';
    grdOreCompensabili.Cells[1,0]:='Ore';
    for i:=1 to A029FSchedaRiepilMW.R450DtM1.NFasceMese do
    begin
      grdOreCompensabili.Cells[0,i]:=Format('%s (%d%%)',[A029FSchedaRiepilMW.R450DtM1.tFasce[i],A029FSchedaRiepilMW.R450DtM1.tMaggioraz[i]]);
      grdOreCompensabili.Cells[1,i]:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.tbancaore[i]);
    end;
    grdTotOreCompensabili.Cells[0,0]:='Totale';
    grdTotOreCompensabili.Cells[1,0]:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreMese);
    edtBancaOreCausEsc.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BOMaturataCausEsterne);
    edtBancaOreRecInterna.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreRecInternaMensile);
    edtBancaOreMaturata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreAnno);
    edtBancaOreRecuperata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreRecuperata);
    edtBancaOreLiquidata.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreLiquidata);
    edtBancaOreResidua.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResidua + A029FSchedaRiepilMW.R450DtM1.BancaOreResiduaPrec);
    edtBancaOreResiduaPrec.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResiduaPrec);
    edtBancaOreResiduaCorr.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BancaOreResidua);
    edtBancaOreCausEscAnno.Text:=R180MinutiOre(A029FSchedaRiepilMW.R450DtM1.BOMaturataCausEsterneAnno);
    A029FSchedaRiepil.actSaldiMobili.Enabled:=(A029FSchedaRiepilMW.R450DtM1.MesiSaldoPrec >= 0) and (A029FSchedaRiepilMW.R450DtM1.PeriodicitaAbbattimento = 'M');
  end;
  //Totale Stroardinario e Reperibilità da inizio anno
  (*SumReperibilita.Close;
  SumReperibilita.SetVariable('Progressivo',C700Progressivo);
  SumReperibilita.SetVariable('DaData',EncodeDate(A,1,1));
  SumReperibilita.SetVariable('AData',Q070.FieldByname('Data').AsDateTime);
  SumReperibilita.Open;*)
  with A029FSchedaRiepilMW.A029FLiquidazione do
  begin
    GetOreLiquidate(Q070.FieldByname('Progressivo').AsInteger, Q070.FieldByname('Data').AsDateTime);
    A029FSchedaRiepil.edtLiquidazioniAnnue.Text:=R180MinutiOre(LiqT070 + LiqT071Anno + LiqT074Anno + AssT071Anno);
  end;
  //A029FSchedaRiepil.StrRepLiq.Text:=R180MinutiOre(SumReperibilita.FieldByName('RepLiq').AsInteger + A029FSchedaRiepil.R450DtM1.TotLiquidNelMese);
  //SumReperibilita.Close;
  A029FSchedaRiepil.GetTotaliPresenza;
end;

procedure TA029FSchedaRiepilDtM1.Q070NewRecord(DataSet: TDataSet);
{Dati di inizializzazione della scheda}
begin
  A029FSchedaRiepilMW.selT070NewRecord;
end;

procedure TA029FSchedaRiepilDtM1.Q070AfterInsert(DataSet: TDataSet);
{Genero le fasce per i dati divisi in fasce}
begin
  A029FSchedaRiepil.DButton.OnDataChange:=A029FSchedaRiepil.DButtonDataChange;
  if not A029FSchedaRiepilMW.selT070AfterInsert then
  begin
    R180MessageBox(A000MSG_A029_ERR_CONTR_FASCE,ESCLAMA);
    Q070.Cancel;
  end;
end;

procedure TA029FSchedaRiepilDtM1.Q070AfterEdit(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070Edit;
end;

procedure TA029FSchedaRiepilDtM1.BDEQ070CAUSALE1MINASSValidate(Sender: TField);
{Se annullo la causale di assestamento azzero le ore di assestamento}
var MinAss:TField;
begin
  if Sender.IsNull then
  begin
    if Sender = Q070Causale1MinAss then
      MinAss:=A029FSchedaRiepilMW.selT071Ore1Assest
    else
      MinAss:=A029FSchedaRiepilMW.selT071Ore2Assest;
    with A029FSchedaRiepilMW.selT071 do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        Edit;
        MinAss.AsString:=' 00.00';
        Post;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TA029FSchedaRiepilDtM1.BDEQ070UpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  UpdateAction:=uaAbort;
  ShowMessage('Impossibile eseguire le modifiche!');
end;

procedure TA029FSchedaRiepilDtM1.Q070AfterCancel(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterCancel;
  Q070AfterScroll(Q070);
end;

procedure TA029FSchedaRiepilDtM1.Q070BeforePost(DataSet: TDataSet);
var
  DialogConferma: Boolean;
  Msg: String;
  Btn:TMsgDlgButtons;
  Cambiato: Boolean;
  ImpLiq: real;
begin
  A029FSchedaRiepilMW.selT070BeforePost(True);
  AbortPost:=False;
  MsgAbort:='';
  Msg:=A029FSchedaRiepilMW.ControllaLiquidato(DialogConferma);
  if Msg <> '' then
  begin
    if DialogConferma then
      Btn:=[mbYes,mbNo]
    else
      Btn:=[mbCancel];

    AbortPost:=MessageDlg(Msg,mtConfirmation,Btn,0) <> mrYes;
  end;

  try
    PutLiquidatoFuoriBudget:=False;
    if not AbortPost then
    begin
      if A029FSchedaRiepilMW.Budget then
      begin
        A029FSchedaRiepilMW.ControllaStraordinarioLiquidato(Cambiato,OreLiq,ImpLiq,MaxLiquidato);
        // effettua i controlli sul budget solo se le ore in fasce di maggiorazione
        // sono cambiate rispetto a prima
        if Cambiato then //if Liquidato <> 0 then
        begin
          if Parametri.CampiRiferimento.C2_Facoltativo = 'N' then
          begin
            A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,Q070.FieldByName('Progressivo').AsInteger,Q070.FieldByName('Data').AsDateTime,OreLiq,ImpLiq);
          end
          else if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
          begin
            if R180MessageBox(Format(A000MSG_A029_DLG_FMT_GEST_BUDGET,[R180MinutiOre(OreLiq)]),DOMANDA) = mrYes then
              A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,Q070Progressivo.AsInteger,Q070Data.AsDateTime,OreLiq,ImpLiq)
            else
              PutLiquidatoFuoriBudget:=True;
          end;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      if (E is EAbort) then
      begin
        AbortPost:=True;
        MsgAbort:=e.Message;
      end
      else
        raise;
    end;
  end;
end;

procedure TA029FSchedaRiepilDtM1.Q070AfterPost(DataSet: TDataSet);
{Applico le modifiche nella cache al database}
var BancaOreLiquidata:Integer;
    CodGruppo,FiltroAnagrafe:String;
begin
  A029FSchedaRiepilMW.NDaLiquidare:=0;
  if not AbortPost then
  begin
    BancaOreLiquidata:=A029FSchedaRiepilMW.CalcolaBancaOreLiquidata;
    A029FSchedaRiepilMW.ApplicaModifiche;
  end
  else
    R180MessageBox(A000MSG_ERR_OPERAZIONE_NON_ESEGUITA + CRLF + MsgAbort,ESCLAMA);

  A029FSchedaRiepilMW.ImpostaLiquidazioneEBancaOre(BancaOreLiquidata);

  if A029FSchedaRiepilMW.Budget then
  begin
    if not AbortPost then
    begin
      //Queste operazioni vanno fatte dopo ApplicaModifiche perchè si va a modificare la selT070
      //e quindi la commit darebbe errore di dato modificato da altro utente
      if PutLiquidatoFuoriBudget then
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.PutLiquidatoFuoriBudget(Q070Progressivo.AsInteger,Q070Data.AsDateTime,OreLiq);

      // ore liquidate fuori budget
      if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.PutMaxLiquidatoFuoriBudget(Q070Progressivo.AsInteger,Q070Data.AsDateTime,MaxLiquidato);
    end;
    A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.GetRaggruppamentiBudget(Q070Progressivo.AsInteger,Q070Data.AsDateTime,CodGruppo,FiltroAnagrafe);
    A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.AggiornaFruitoBudget(Q070Data.AsDateTime,TipoLiq,CodGruppo,FiltroAnagrafe,'E');
    SessioneOracle.Commit;
  end;

  Q070.RefreshRecord;
  Q070AfterScroll(nil);
end;

//------------- INIZIO LIQUIDAZIONE STRAORDINARIO --------------------//

procedure TA029FSchedaRiepilDtM1.ImpostaStraordinarioEsterno(SE: Integer);
begin
  A029FSchedaRiepil.Edit1.Text:=R180MinutiOre(SE);
  A029FSchedaRiepil.EStrEst.Text:=R180MinutiOre(SE);
  if R180OreMinutiExt(A029FSchedaRiepil.Edit1.Text) > R180OreMinutiExt(A029FSchedaRiepil.Edit2.Text) then
    ShowMessage(A000MSG_A029_ERR_STRAORD_EST);
end;

//------------- FINE LIQUIDAZIONE STRAORDINARIO --------------------//

procedure TA029FSchedaRiepilDtM1.Q070BeforeDelete(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070BeforeDelete;
end;

procedure TA029FSchedaRiepilDtM1.BDEQ072UpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  UpdateAction:=uaSkip;
end;

procedure TA029FSchedaRiepilDtM1.BDEQ074UpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
var UpdateAction: TUpdateAction);
begin
  UpdateAction:=uaAbort;
end;

procedure TA029FSchedaRiepilDtM1.Q070BeforeInsert(DataSet: TDataSet);
{Chiedo la data di riferimento prima di inserire un nuovo record}
begin

  A029FSchedaRiepilMW.DataInserimento:=Parametri.DataLavoro;
  A029FSchedaRiepilMW.DataInserimento:=R180InizioMese(DataOut(R180InizioMese(A029FSchedaRiepilMW.DataInserimento),'Scheda del mese','M'));

  A029FSchedaRiepilMW.selT070BeforeInsert;

  A029FSchedaRiepil.LData.Caption:=FormatDateTime('mmmm yyyy',A029FSchedaRiepilMW.DataInserimento);
  A029FSchedaRiepil.DButton.OnDataChange:=nil;
end;

procedure TA029FSchedaRiepilDtM1.Q070AfterScroll(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterScroll;
  A029FSchedaRiepil.PageControl1Change(nil);

  A029FSchedaRiepil.lblLiquidStrBloccata.Visible:=A029FSchedaRiepilMW.LiquidBloccata;
  A029FSchedaRiepil.BitBtn1.Enabled:=(not A029FSchedaRiepilMW.LiquidBloccata) and (not A029FSchedaRiepilMW.BloccoT071S);
  A029FSchedaRiepil.lblLiquidCompBloccata.Visible:=A029FSchedaRiepilMW.LiquidCompBloccata;

  A029FSchedaRiepil.dedtBancaOreLiqVar.Visible:=A029FSchedaRiepilMW.BancaOreVariazioneLiqVisibile;
  A029FSchedaRiepil.lblBancaOreLiqVar.Visible:=A029FSchedaRiepil.dedtBancaOreLiqVar.Visible;
end;


procedure TA029FSchedaRiepilDtM1.Q070AfterDelete(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterDelete;
  RegistraLog.RegistraOperazione;
end;

procedure TA029FSchedaRiepilDtM1.Q070BeforeScroll(DataSet: TDataSet);
begin
  if R180OreMinutiExt(A029FSchedaRiepil.Edit1.Text) > R180OreMinutiExt(A029FSchedaRiepil.Edit2.Text) then
    raise Exception.Create(A000MSG_A029_ERR_STRAORD_EST);
end;

procedure TA029FSchedaRiepilDtM1.BDEQ070DEBITOORARIOValidate(Sender: TField);
{Controllo che i minuti siano minori di 60}
var Minuti,Posiz:Byte;
begin
  if Sender.IsNull then
    exit;
  if Pos(' ',Trim(Sender.AsString)) > 1 then
    raise Exception.Create('Dato non valido!');
  Posiz:=Pos('.',Sender.AsString);
  if Posiz = 0 then
    Posiz:=Pos(':',Sender.AsString);
  if Posiz = 0 then
    exit;
  Minuti:=StrToInt(Copy(Sender.AsString,Posiz + 1,2));
  if Minuti > 59 then
    raise Exception.Create('I minuti devono essere minori di 60!');
end;

procedure TA029FSchedaRiepilDtM1.Q070ORECOMP_LIQUIDATEValidate(
  Sender: TField);
var Msg: String;
begin
  if Q070ORECOMP_LIQUIDATE.IsNull and Q070BANCAORE_LIQ_VAR.IsNull then
    exit;
  OreMinutiValidate(Sender.AsString);

  Msg:=A029FSchedaRiepilMW.VerificaDispLiquidità;
  if Msg <>'' then
    raise Exception.Create(Msg);
end;

procedure TA029FSchedaRiepilDtM1.CaricaComboCausaliPresenza;
var
  S: String;
  i: Integer;
begin
  A029FSchedaRiepil.cmbCausPresenza.Items.Clear;
  for i:=0 to High(A029FSchedaRiepilMW.R450DtM1.RiepPres) do
  begin
    if A029FSchedaRiepilMW.R450DtM1.RiepPres[i].Causale = '' then
      Break;
    S:=Format('%-5s %s',[A029FSchedaRiepilMW.R450DtM1.RiepPres[i].Causale,A029FSchedaRiepilMW.selT275.Lookup('Codice',A029FSchedaRiepilMW.R450DtM1.RiepPres[i].Causale,'Descrizione')]);
    A029FSchedaRiepil.cmbCausPresenza.Items.Add(S);
  end;
end;

procedure TA029FSchedaRiepilDtM1.AggiornaDettaglioCausalePresenza;
var
  i:Integer;
begin
  A029FSchedaRiepil.lblOreEscluseIncluse.Caption:='';
  A029FSchedaRiepilMW.TipoOreCausalizzate:=tocCompensabili;
  A029FSchedaRiepilMW.selT074Liq.ReadOnly:=True;
  A029FSchedaRiepilMW.selT073Comp.ReadOnly:=True;
  A029FSchedaRiepil.btnAttivaLiquidazione.Enabled:=False;
  A029FSchedaRiepil.lblLiquidazioneBloccata.Visible:=False;
  A029FSchedaRiepil.grdPresAnnue.RowCount:=2;
  A029FSchedaRiepil.grdPresAnnue.Rows[1].Clear;
  A029FSchedaRiepil.grdPresAnnueTot.Cells[2,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[3,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[4,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[5,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[6,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[7,0]:='00.00';
  A029FSchedaRiepil.grdPresAnnueTot.Cells[8,0]:='00.00';
  A029FSchedaRiepil.grdPresLiqTot.Cells[2,0]:='00.00';
  for i:=0 to A029FSchedaRiepil.cmbCausPresenza.Items.Count - 1 do
  begin
    if Trim(Copy(A029FSchedaRiepil.cmbCausPresenza.Items[i],1,5)) =  A029FSchedaRiepilMW.selT074.FieldByName('Causale').AsString then
    begin
      A029FSchedaRiepil.cmbCausPresenza.ItemIndex:=i;
      A029FSchedaRiepil.cmbCausPresenzaChange(nil);
      Break;
    end;
  end;
  if (A029FSchedaRiepil.cmbCausPresenza.ItemIndex = -1) and (A029FSchedaRiepil.cmbCausPresenza.Items.Count > 0) then
  begin
    A029FSchedaRiepil.cmbCausPresenza.ItemIndex:=0;
    A029FSchedaRiepil.cmbCausPresenzaChange(nil);
  end;
end;

procedure TA029FSchedaRiepilDtM1.Q070ORECOMP_RECUPERATEValidate(
  Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA029FSchedaRiepilDtM1.selT074LiqBeforePost(DataSet: TDataSet);
{Controllo che il liquidato non sia maggiore della disponibilità}
var Msg: String;
  DialogConferma: Boolean;
  Btn:TMsgDlgButtons;
begin
  Msg:=A029FSchedaRiepilMW.selT074LiqBeforePost(Trim(Copy(A029FSchedaRiepil.cmbCausPresenza.Text,1,5)),DialogConferma);
  if Msg <> '' then
  begin
    if DialogConferma then
      Btn:=[mbOK,mbCancel]
    else
      Btn:=[mbCancel];
    if MessageDlg(Msg,mtWarning,Btn,0) <> mrOK then
      Abort;
  end;
end;

procedure TA029FSchedaRiepilDtM1.selT073CompBeforePost(DataSet: TDataSet);
{Controllo che il compensabile non sia maggiore della disponibilità}
begin
  try
    A029FSchedaRiepilMW.selT073CompBeforePost(Trim(Copy(A029FSchedaRiepil.cmbCausPresenza.Text,1,5)));
  except
    A029FSchedaRiepil.dedtOreEsclCompMese.SetFocus;
    raise;
  end;
end;

procedure TA029FSchedaRiepilDtM1.ImpostaContrattoEPartTime(ContrPartTime: TContrattoPartTime; EsisteContratto:Boolean);
begin
  A029FSchedaRiepil.LContratto.Caption:='';
  A029FSchedaRiepil.LPartTime.Caption:='';

  if ContrPartTime.CodContratto <> '' then
  begin
    A029FSchedaRiepil.LContratto.Caption:=Format('%s %s',[ContrPartTime.CodContratto,ContrPartTime.DescContratto]);
    A029FSchedaRiepil.LPartTime.Caption:=Format('%s %s',[ContrPartTime.CodPartTime,ContrPartTime.DescPartTime]);
  end;

  if EsisteContratto then
  begin
    with A029FSchedaRiepil do
    begin
      try
        PIndennita.Visible:=A029FSchedaRiepilMW.selT200.FieldByName('Tipo').AsString <> 'USL';
        if A029FSchedaRiepilMW.selT200.FieldByName('Tipo').AsString = 'USL' then
          LIndennita.Caption:='Indennità notturna'
        else
          LIndennita.Caption:='Indennità di turno';
      //Gestisco il caso che non sia stato aperto il contratto
      except
        PIndennita.Visible:=False;
        LIndennita.Caption:='Indennità di turno';
      end;
    end;
  end
  else
  begin
    A029FSchedaRiepil.PIndennita.Visible:=False;
    A029FSchedaRiepil.LIndennita.Caption:='Indennità di turno';
  end;
end;

procedure TA029FSchedaRiepilDtM1.A029FSchedaRiepilDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).CloseAll;
    if (Self.Components[i] is TOracleQuery) then
      (Self.Components[i] as TOracleQuery).Close;
  end;
  FreeAndNil(A029FSchedaRiepilMW);
  //caratto 07/05/2013 rimozione variabili globali. istanziato dentroA029FLiquidazione
  // A029FBudgetDtM1.Free;
  //A029FLiquidazione.Free;
end;

end.
