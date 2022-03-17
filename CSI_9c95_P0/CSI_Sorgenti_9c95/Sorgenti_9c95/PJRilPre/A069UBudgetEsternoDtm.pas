unit A069UBudgetEsternoDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData, A000UInterfaccia,
  C180FunzioniGenerali, Oracle, SelAnagrafe, C700USelezioneAnagrafe,
  A069UCSIBilancioWs, OracleMonitor;

type
  TA069FBudgetEsternoDtm = class(TR004FGestStoricoDtM)
    selT710: TOracleDataSet;
    selT710ANNO: TIntegerField;
    selT710CAPITOLO: TStringField;
    selT710ARTICOLO: TStringField;
    selT710COEL: TStringField;
    selT710STANZIAMENTO: TFloatField;
    selT710DISPONIBILITA: TFloatField;
    selT710VARIAZIONE: TFloatField;
    selT710DECORRENZA_VARIAZIONE: TDateTimeField;
    selT710SCADENZA_VARIAZIONE: TDateTimeField;
    insT710: TOracleQuery;
    selLiquidazioni: TOracleDataSet;
    selT710C_UTILIZZO: TFloatField;
    selT430: TOracleDataSet;
    updT710: TOracleQuery;
    selT710UTILIZZO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT710NewRecord(DataSet: TDataSet);
    procedure selT710BeforeInsert(DataSet: TDataSet);
    procedure selT710BeforeDelete(DataSet: TDataSet);
    procedure selT710CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    DataRiferimento:TDateTime;
    procedure OpenselT710;
    procedure OpenSelLiquidazioni;
    procedure AcquisizioneBudget(Anno:Integer);
    function  RegistraLiquidazioni:String;
  end;

var
  A069FBudgetEsternoDtm: TA069FBudgetEsternoDtm;

implementation

uses A069UBudgetEsterno;

{$R *.dfm}

procedure TA069FBudgetEsternoDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT710,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  //OpenselT710;
  A069FBudgetEsterno.DButton.DataSet:=selT710;
end;

procedure TA069FBudgetEsternoDtm.OpenSelLiquidazioni;
begin
  selLiquidazioni.Close;
  C700MergeSelAnagrafe(selLiquidazioni,False);
  C700DataDal:=EncodeDate(R180Anno(DataRiferimento),1,1);
  C700DataLavoro:=R180FineMese(DataRiferimento);
  C700MergeSettaPeriodo(selLiquidazioni,C700DataDal,C700DataLavoro);
  R180SetVariable(selLiquidazioni,'CAMPORAGRR1',Parametri.CampiRiferimento.C2_Capitolo);
  R180SetVariable(selLiquidazioni,'CAMPORAGRR2',Parametri.CampiRiferimento.C2_Articolo);
  R180SetVariable(selLiquidazioni,'COSTO_ORARIO',Parametri.CampiRiferimento.C2_Costo_Orario);
  R180SetVariable(selLiquidazioni,'DATACORR',DataRiferimento);
  selLiquidazioni.Open;
end;

procedure TA069FBudgetEsternoDtm.OpenselT710;
begin
  selLiquidazioni.Close;
  selT710.Close;
  C700MergeSelAnagrafe(selT710,False);
  C700DataDal:=EncodeDate(R180Anno(DataRiferimento),1,1);
  C700DataLavoro:=R180FineMese(DataRiferimento);
  C700MergeSettaPeriodo(selT710,C700DataDal,C700DataLavoro);
  R180SetVariable(selT710,'CAMPORAGRR1',Parametri.CampiRiferimento.C2_Capitolo);
  R180SetVariable(selT710,'CAMPORAGRR2',Parametri.CampiRiferimento.C2_Articolo);
  R180SetVariable(selT710,'ANNO',R180Anno(DataRiferimento));
  selT710.Open;
end;

procedure TA069FBudgetEsternoDtm.AcquisizioneBudget(Anno:Integer);
const
  CodiceAzienda = 1;
  Coel = '1003';
var
  lstCapitoloUscita: Array_Of_capitoloUscita;
  DettaglioCapitoloArticolo:importiUEBSpesa;
  i,j:integer;
  CampiBudget:String;
  strAnno,strCapitolo,strArticolo:String;
  Stanziamento,Impegnato:Currency;
  oJSB: BilancioInterface;
begin
  updT710.Execute;  //Resetto colonna UTILIZZO
  strAnno:=IntToStr(Anno);
  CampiBudget:=Format('lpad(%s,10,''0'') CAPITOLO,lpad(%s,10,''0'') ARTICOLO',[Parametri.CampiRiferimento.C2_Capitolo,Parametri.CampiRiferimento.C2_Articolo]);
  R180SetVariable(selT430,'CAMPI_BUDGET',CampiBudget);
  R180SetVariable(selT430,'ANNO',strAnno);
  selT430.Open;
  //Chiamata web service per ottenere elenco Capitoli/Articoli
  oJSB:=GetBilancioInterface(False,Parametri.CampiRiferimento.C2_WebSrv_Bilancio);
  //lstCapitoloUscita:=GetBilancioInterface.getCapitoliUscita(CodiceAzienda,strAnno,strAnno);
  lstCapitoloUscita:=oJSB.getCapitoliUscita(CodiceAzienda,strAnno,strAnno);
  for i:=Low(lstCapitoloUscita) to High(lstCapitoloUscita) do
    for j:=Low(lstCapitoloUscita[i].ueb) to High(lstCapitoloUscita[i].ueb) do
    begin
      strCapitolo:=Format('%.10d',[lstCapitoloUscita[i].ueb[j].numeroCapitolo]);
      strArticolo:=Format('%.10d',[lstCapitoloUscita[i].ueb[j].numeroArticolo]);
      if (lstCapitoloUscita[i].ueb[j].coel = Coel) and
         selT430.SearchRecord('CAPITOLO;ARTICOLO',VarArrayOf([strCapitolo,strArticolo]),[srFromBeginning]) then
      begin
        //Chiamata web service per ottenere dettaglio per il singolo capitolo/articolo
        //DettaglioCapitoloArticolo:=GetBilancioInterface.getCapCdcUscitaDatiRiepilogo(
        DettaglioCapitoloArticolo:=oJSB.getCapCdcUscitaDatiRiepilogo(
          codiceAzienda,
          strAnno,
          strAnno,
          lstCapitoloUscita[i].ueb[j].numeroCapitolo,
          lstCapitoloUscita[i].ueb[j].numeroArticolo,
          lstCapitoloUscita[i].ueb[j].cdc.cdc,
          lstCapitoloUscita[i].ueb[j].coel,
          lstCapitoloUscita[i].ueb[j].tipoFin
          );
        Stanziamento:=StrToFloat(StringReplace(DettaglioCapitoloArticolo.stanziamentoAttualeDefinitivo,'.',',',[]));
        Impegnato:=StrToFloat(StringReplace(DettaglioCapitoloArticolo.importoImpegnatoDefinitivo,'.',',',[]));
        with insT710 do
        begin
          SetVariable('ANNO',Anno);
          SetVariable('CAPITOLO',lstCapitoloUscita[i].ueb[j].numeroCapitolo);
          SetVariable('ARTICOLO',lstCapitoloUscita[i].ueb[j].numeroArticolo);
          SetVariable('COEL',lstCapitoloUscita[i].ueb[j].coel);
          SetVariable('STANZIAMENTO',Stanziamento);
          SetVariable('DISPONIBILITA',Impegnato);
          Execute;
        end;
        (*
          MyImportiUEBSpesa.importoDisponibile;
          MyImportiUEBSpesa.importoEmesso;
          MyImportiUEBSpesa.importoImpegnatoDefinitivo;
          MyImportiUEBSpesa.importoImpegnatoProvvisorio;
          MyImportiUEBSpesa.importoPagato;
          MyImportiUEBSpesa.importoPreimpegnato;
          MyImportiUEBSpesa.stanziamentoAttualeDefinitivo;
          MyImportiUEBSpesa.stanziamentoInizialeResiduo;
          MyImportiUEBSpesa.variazioniBilancioDefinitive;
          MyImportiUEBSpesa.variazioniBilancioProvvisorie;
          MyImportiUEBSpesa.stanziamentoAnnoPrecedente;
        *)
      end;
    end;
  selT710.Refresh;
end;

procedure TA069FBudgetEsternoDtm.selT710CalcFields(DataSet: TDataSet);
var strCapitolo,strArticolo:String;
begin
  inherited;
  selT710.FieldByName('C_UTILIZZO').Clear;
  if selLiquidazioni.Active then
  begin
    strCapitolo:=StringReplace(Format('%10s',[selT710.FieldByName('CAPITOLO').AsString]),' ','0',[rfReplaceAll]);
    strArticolo:=StringReplace(Format('%10s',[selT710.FieldByName('ARTICOLO').AsString]),' ','0',[rfReplaceAll]);
    if selLiquidazioni.SearchRecord('CAMPORAGRR1;CAMPORAGRR2',VarArrayOf([strCapitolo,strArticolo]),[srFromBeginning]) and (selLiquidazioni.FieldByName('MONETIZZAZIONE').AsFloat > 0) then
      selT710.FieldByName('C_UTILIZZO').AsFloat:=selLiquidazioni.FieldByName('MONETIZZAZIONE').AsFloat;
  end;
end;

procedure TA069FBudgetEsternoDtm.selT710BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA069FBudgetEsternoDtm.selT710BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA069FBudgetEsternoDtm.selT710NewRecord(DataSet: TDataSet);
begin
  inherited;
  with TOracleDataSet.Create(Self) do
    try
      Session:=SessioneOracle;
      SQL.Add('select trunc(least(T710.SCADENZA_VARIAZIONE, sysdate - 1)) SCADENZA_VARIAZIONE');
      SQL.Add('  from T710_BUDGETESTERNO_ANNUO T710');
      Open;
      selT710.FieldByName('SCADENZA_VARIAZIONE').Value:=FieldByName('SCADENZA_VARIAZIONE').Value;
    finally
      Free;
    end;
end;

function TA069FBudgetEsternoDtm.RegistraLiquidazioni:String;
var
  DispVariazione:Real;
begin
  Result:='';
  updT710.Execute;
  with selT710 do
  begin
    DisableControls;
    Refresh;
    First;
    while not Eof do
    begin
      if not FieldByName('C_UTILIZZO').IsNull then
      begin
        Edit;
        FieldByName('UTILIZZO').AsFloat:=FieldByName('C_UTILIZZO').AsFloat;
        Post;
        DispVariazione:=FieldByName('DISPONIBILITA').AsFloat;
        if R180Between(DataRiferimento,FieldByName('DECORRENZA_VARIAZIONE').AsDateTime,FieldByName('SCADENZA_VARIAZIONE').AsDateTime) then
          DispVariazione:=DispVariazione + FieldByName('VARIAZIONE').AsFloat;
        if FieldByName('C_UTILIZZO').AsFloat > DispVariazione then
          Result:='Anomalie';
      end;
      Next;
    end;
    SessioneOracle.ApplyUpdates([selT710],True);
    First;
    EnableControls;
  end;
end;

end.
