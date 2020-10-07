unit A058UPianifTurniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData,
  C180FunzioniGenerali, R500Lin, Rp502Pro, R600, (*Midaslib,*) Crtl,
  DBClient, Variants, DatiBloccati, Math, QueryStorico, StrUtils,
  Generics.Collections, A000UMessaggi;

type
  TPianificazione = record
    xDatasetPianif:TOracleDataSet;
    xDatasetGiust:TOracleDataSet;
    xQueryPianif:TOracleQuery;
    xQueryGiust:TOracleQuery;
    sFlagAgg:string;
  end;

  TMaxMin = record
    Min, Max:Integer;
  end;

  TTotOpe = record
    Totale:Integer;
    Operatore,Min,Max:String;
  end;

  TArrTotOpe = array of TTotOpe;

  TTurni = record
    Turno1:integer;
    Rp502Turno1:integer;
    TotOpe1:TArrTotOpe;
    Turno2:integer;
    Rp502Turno2:integer;
    TotOpe2:TArrTotOpe;
    Turno3:integer;
    Rp502Turno3:integer;
    TotOpe3:TArrTotOpe;
    Turno4:integer;
    Rp502Turno4:integer;
    TotOpe4:TArrTotOpe;
    TotOraLiquid:Integer;
  end;

  T080PCKTURNO = class
  private
    AbilitaCopia:boolean;
    pckT080COPIATURNO:TOracleQuery;
    pckT080GETDATOGENERICO:TOracleQuery;
    procedure IniPckT080COPIATURNO;
    procedure InipckT080GETDATOGENERICO;
  public
    constructor create;
    destructor destroy; override;
    procedure SetVariabiliCopiaTurnazione(ProgOrig, ProgDest:integer; DataInizio, DataFine:TDateTime);
    function SeEsisteDatoT620(Progr:integer;DataInizio:TDateTime):integer;
    function CopiaTurnazione(EseguiCommit:Boolean = True):string;

    procedure CalcolaDatiADATA(Progr:integer; DataDest:TDateTime);
    function GetPartenza:integer;
  end;

  TGiorno = class
  private
    sT1,sT2,sOra,sAss1,sAss2,sT1EU,sT2EU:string;
    function getT1:string;
    procedure setT1(val:string);
    function getT2:string;
    procedure setT2(val:string);
    function getAss1:string;
    procedure setAss1(val:string);
    function getAss2:string;
    procedure setAss2(val:string);
    function getOra:string;
    procedure setOra(val:string);
    function getT1EU:string;
    procedure setT1EU(val:string);
    function getT2EU:string;
    procedure setT2EU(val:string);
  public
    SiglaT1,SiglaT2,NumTurno1,NumTurno2,
    ValorGior,
    AssOre,
    VAss,
    Flag,        //Flag:O = Da pianificazione; M = Pianific.esistente; CS = Cambio Squadra; NT = No pianificazione
    Squadra,DSquadra,Oper,
    VerTurni,VerRiposi,
    TurnRep,OraInizioRep,OraFineRep:String; //Turno reperibilità()
    Ass1Modif,Ass2Modif,Modificato:Boolean;
    Debito,Assegnato,NTimbTurno{Timbrature che non escludono il turno}:Integer;
    Data:TDate;
    property T1:string read getT1 write setT1;
    property T2:string read getT2 write setT2;
    property Ass1:string read getAss1 write setAss1;
    property Ass2:string read getAss2 write setAss2;
    property Ora:string read getOra write setOra;
    property T1EU:string read getT1EU write setT1EU;
    property T2EU:string read getT2EU write setT2EU;
  end;

  TDipendente = class
  public
    Prog,Badge,TurnoPartenza,
    Debito,Assegnato,RiposiPrec,FestiviLavMesePrec,FestiviLavAnnoPrec,CompRip,
    ConstMesRip,ConstElabPeriodo,ConstInd1,ConstInd2,ConstInd3,ConstInd4:Integer;
    Cognome,Nome,TipoOpe,CausRip,Matricola:String;
    TotaleTurniMese:TTurni;
    Giorni,GiorniOld:TList<TGiorno>;
  end;

  TA058FPianifTurniDtM1 = class(TDataModule)
    Q011: TOracleDataSet;
    Q012: TOracleDataSet;
    Q020: TOracleDataSet;
    Q020Turni: TOracleDataSet;
    Q040: TOracleDataSet;
    Q080: TOracleDataSet;
    Q221: TOracleDataSet;
    Q265: TOracleDataSet;
    Q265B: TOracleDataSet;
    Q430: TOracleDataSet;
    Q080Gest: TOracleDataSet;
    Q040Gest: TOracleDataSet;
    Q081Gest: TOracleDataSet;
    Q041Gest: TOracleDataSet;
    Q601: TOracleDataSet;
    Q611: TOracleDataSet;
    Q620: TOracleDataSet;
    Q630: TOracleDataSet;
    Q641: TOracleDataSet;
    CancAllT080: TOracleQuery;
    CancT080: TOracleQuery;
    CancT081: TOracleQuery;
    CancT040: TOracleQuery;
    CancT041: TOracleQuery;
    T058Stampa: TClientDataSet;
    QT021: TOracleDataSet;
    Q600: TOracleDataSet;
    D600: TDataSource;
    GetCalend: TOracleQuery;
    Q600B: TOracleDataSet;
    SelQ040: TOracleDataSet;
    Q021: TOracleDataSet;
    D021: TDataSource;
    Q021CODICE: TStringField;
    Q021NUMTURNO: TIntegerField;
    Q021SIGLATURNI: TStringField;
    Q021ENTRATA: TStringField;
    Q021USCITA: TStringField;
    Q021numfascia: TStringField;
    selRiposi: TOracleDataSet;
    selFestLav: TOracleDataSet;
    selQ601: TOracleDataSet;
    dSelQ601: TDataSource;
    selQ601CODICE: TStringField;
    sel2T600: TOracleDataSet;
    sel2T601: TOracleDataSet;
    SelT010: TOracleDataSet;
    selT021: TOracleDataSet;
    selOperatori: TOracleDataSet;
    selQ601MIN1: TIntegerField;
    selQ601MAX1: TIntegerField;
    selQ601MIN2: TIntegerField;
    selQ601MAX2: TIntegerField;
    selQ601MIN3: TIntegerField;
    selQ601MAX3: TIntegerField;
    V430Colonne: TOracleDataSet;
    SovrascriviT041: TOracleQuery;
    InserisciT041: TOracleQuery;
    selT620: TOracleDataSet;
    UpdT040: TOracleQuery;
    selT040: TOracleDataSet;
    selT530: TOracleDataSet;
    selT011: TOracleDataSet;
    selT380: TOracleDataSet;
    T600GetSquadra: TOracleDataSet;
    selDistOperatori: TOracleDataSet;
    selT082: TOracleDataSet;
    dtsT082: TDataSource;
    AusT058: TClientDataSet;
    dtsAusT058: TDataSource;
    selT100: TOracleDataSet;
    selV430: TOracleDataSet;
    procedure A058FPianifTurniDtM1Create(Sender: TObject);
    procedure A058FPianifTurniDtM1Destroy(Sender: TObject);
    procedure SelAnagrafeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    TurnazioneOld:String;
    R600DtM:TR600DtM1;
    function GetTipoGiorno(Data:TDateTime; Prog:LongInt; Calendario:String; DomNonLav:Boolean = False):String;
    function ControlloSuccTurn(ProgDip:Integer;DataIn:TDateTime;TurnoOggi:String):Boolean;
    function GetT1(Risp,CodOrario,NumTurno:String;DataIn:TDate = 0):String;
    function TestAssenza(Ass,Turno:String):Boolean;
    procedure AddTurnoOperatore(InDip:TDipendente;InArrOperatori:TArrTotOpe;AddUnita:boolean = True);
    procedure EliminaDipendente(P:Integer);
    procedure CreaGiorno(Data:TDateTime; Posizione:LongInt);
    procedure CreaDipendente(Prog,Badge:LongInt;Matricola,Cognome,Nome:String);
    procedure SviluppoTurnazione(Turnazione:String; Lista:TStringList);
    procedure SviluppoCicli(Lista,Turno1,Turno2,Orario,Causale:TStringList);
    procedure GetTurnazione(var Posizione:LongInt);
    procedure PianificaGiorno(NDip,G:LongInt; BloccoT040,BloccoT080:Boolean; xArrayPianif:TPianificazione);
    procedure PianificaOrario(NDip,G:LongInt; Ora,T1,T2,T1EU,T2EU,ValorGior:String;xArrayPianif:TPianificazione);
    procedure PianificaAssenza(NDip,G:LongInt; A1,A2:String; xArrayPianif:TPianificazione);
  public
    { Public declarations }
    PckTurno:T080PCKTURNO;
    TurnazSucc,OldInizio,OldFine,DataInizio,DataFine:TDateTime;
    ListaCicli,Turno1,Turno2,Orario,Causale:TStringList;
    SalvaSQLOriginale:String;

    ElaborazioneInterrotta,AnomaliePianif,NuovaPianif,
    AssenzeOperative,ConteggiaDebito,GeneraIniCorr:Boolean;

    R502ProDtM:TR502ProDtM1;
    Vista:TList<TDipendente>;  //TDipendente(Vista[i]).Prog/Badge/Nome/Giorni
                               //TGiorno(TDipendente(Vista[i]).Prog.Giorni[j]).T1/T2/Ora/Ass1/Ass2
    xValoreOrigine:TGiorno;
    aTotaleTurni: array of TTurni;
    QSSquadra:TQueryStorico;
    OffsetVista, TipoPianif, LungCella:Integer;
    SelAnagrafeA058:TOracleDataSet;
    selDatiBloccatiA058:TDatiBloccati;
    sNumTurno1, sNumTurno2, sT1EU, sT2EU, sAss1, sAss2: string;
    function ModificaData(InDate:TDateTime;AA,MM,GG:Word):TDateTime;
    function GetPartenza(Prog:LongInt; var Posizione:LongInt):Boolean;
    function AssenzaGG(Dip,GG:Integer):Boolean;
    function ConsideraGiorno(IndDip,IndGG:Integer;Data:TDateTime = 0):Boolean;
    function GetTipoOpe(Prog:integer):string;
    function NumRighe(S:String):Integer;
    function GetTipoGiornoServizio(D:TDateTime):String;
    function GetOrarioStorico(Data:TDateTime; Prog:LongInt):String;
    function GetListaSquadra:String;
    function GetLimitiMAX_MIN(inData:TDateTime;inTurno:integer):TMaxMin;
    procedure RefreshReperibilità;
    procedure OpenSelV430(OutDato:String);
    procedure OpenSelT100(Prog:Integer;DaData,AData:TDateTime);
    procedure GetAssegnazioneTurnazione(Progressivo:Integer;Data:TDate);
    procedure ForzaOrdC700;
    function OrdinamentoStampa:string;
    procedure AggiornaContatoriTurni(nRiga:integer;nColonna:integer;DopoElabTurni:Boolean = False);
    procedure LeggiPianificazione(Prog:LongInt;DataIniElab,DataFinElab:TDateTime; CreaPianif:Boolean = True);
    procedure PianificaDipendente(Prog:LongInt);
    procedure PulisciVista;
    procedure AggiornaTotaleTurni(i:integer);
    procedure DebitoDipendente(i,Dal,Al:Integer);
    procedure TotaleTurniInd(IDVista, IDGiorno:Integer);
    procedure GetDatiTurno(var Giorno:TGiorno);
    procedure RefreshAssenze(DataDa,DataA:TDateTime);
    procedure VerificaPianificazione(DataElabDa,DataElabA:TDateTime;SoloLOG:String);
    procedure GetPianificazione(Data:TDateTime; Prog,Posizione:LongInt; var T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,AssOre:String; var Ass1Modif,Ass2Modif:boolean);
    procedure ConteggiGiornalieri(Data:TDateTime; IDip,IGiorno:Integer);
    procedure CreaTabStampaAss;
    procedure CaricaTabStampaAss;
    procedure RefreshQ021(D:TDateTime);
    procedure EseguiPianificazione(NDip:LongInt);
    procedure RendiOperativa(NDip:LongInt);
    procedure CancellaPianificazione(Prog:LongInt);
    procedure CalcolaRiposiFestivi;
  end;

{$IFNDEF IRISWEB}
var
  A058FPianifTurniDtM1: TA058FPianifTurniDtM1;
{$ENDIF}

implementation

{$IFNDEF IRISWEB}
uses A058UPianifTurni, A058UGrigliaPianif, SelAnagrafe;
{$ENDIF}

{$R *.DFM}

{begin TGiorno}
function TGiorno.getT1;
begin
  Result:=sT1;
end;

procedure TGiorno.setT1(val:string);
begin
  if sT1.Trim <> Val.Trim then
    Modificato:=True;
  sT1:=Val;
end;

function TGiorno.getT2:string;
begin
  Result:=sT2;
end;

procedure TGiorno.setT2(val:string);
begin
  if sT2.Trim <> Val.Trim then
    Modificato:=True;
  sT2:=Val;
end;

function TGiorno.getAss1;
begin
  Result:=sAss1;
end;

procedure TGiorno.setAss1(val:string);
begin
  if sAss1.Trim <> val.Trim then
    Modificato:=True;
  sAss1:=Val;
end;

function TGiorno.getAss2:string;
begin
  Result:=sAss2;
end;

procedure TGiorno.setAss2(val:string);
begin
  if sAss2.Trim <> Val.Trim then
    Modificato:=True;
  sAss2:=Val;
end;

function TGiorno.getOra:string;
begin
  Result:=sOra;
end;

procedure TGiorno.setOra(val:string);
begin
  if sOra.Trim <> Val.Trim then
    Modificato:=True;
  sOra:=Val;
end;

function TGiorno.getT1EU:string;
begin
  Result:=sT1EU;
end;

procedure TGiorno.setT1EU(val:string);
begin
  if sT1EU.Trim <> val.Trim then
    Modificato:=True;
  sT1EU:=val;
end;

function TGiorno.getT2EU:string;
begin
  Result:=sT2EU;
end;

procedure TGiorno.setT2EU(val:string);
begin
  if sT2EU.Trim <> val.Trim then
    Modificato:=True;
  sT2EU:=val;
end;
{end TGiorno}

{Start T080PCKTURNO}

constructor T080PCKTURNO.create;
begin
  pckT080COPIATURNO:=TOracleQuery.Create(nil);
  pckT080COPIATURNO.Session:=SessioneOracle;
  pckT080GETDATOGENERICO:=TOracleQuery.Create(nil);
  pckT080GETDATOGENERICO.Session:=SessioneOracle;
  IniPckT080COPIATURNO;
  InipckT080GETDATOGENERICO;
  AbilitaCopia:=False;
end;

destructor T080PCKTURNO.destroy;
begin
  FreeAndNil(pckT080COPIATURNO);
  FreeAndNil(pckT080GETDATOGENERICO);
end;

procedure T080PCKTURNO.IniPckT080COPIATURNO;
begin
  pckT080COPIATURNO.SQL.Clear;
  pckT080COPIATURNO.SQL.Add('begin');
  pckT080COPIATURNO.SQL.Add(':RESULT:=t080pck_turno.copiaturno(:PROGORIG,:PROGDEST,:DATAINIZIO,:DATAFINE);');
  pckT080COPIATURNO.SQL.Add('end;');
  pckT080COPIATURNO.DeleteVariables;
  pckT080COPIATURNO.DeclareVariable('PROGORIG',otInteger);
  pckT080COPIATURNO.DeclareVariable('PROGDEST',otInteger);
  pckT080COPIATURNO.DeclareVariable('DATAINIZIO',otDate);
  pckT080COPIATURNO.DeclareVariable('DATAFINE',otDate);
  pckT080COPIATURNO.DeclareVariable('RESULT',otString);
  if DebugHook <> 0 then
    pckT080COPIATURNO.Debug:=True;
end;

procedure T080PCKTURNO.InipckT080GETDATOGENERICO;
begin
  pckT080GETDATOGENERICO.SQL.Clear;
  pckT080GETDATOGENERICO.SQL.Add('begin');
  pckT080GETDATOGENERICO.SQL.Add('  :PARTENZA:='''';');
  pckT080GETDATOGENERICO.SQL.Add('  t080pck_turno.GETDATO_GENERICO(:INPROG,:INDATA);');
  pckT080GETDATOGENERICO.SQL.Add('  :PARTENZA:=t080pck_turno.GETPARTENZA;');
  pckT080GETDATOGENERICO.SQL.Add('end;');
  pckT080GETDATOGENERICO.DeleteVariables;
  pckT080GETDATOGENERICO.DeclareVariable('INPROG',otInteger);
  pckT080GETDATOGENERICO.DeclareVariable('INDATA',otDate);
  pckT080GETDATOGENERICO.DeclareVariable('PARTENZA',otInteger);
  if DebugHook <> 0 then
    pckT080GETDATOGENERICO.Debug:=True;
end;

procedure T080PCKTURNO.CalcolaDatiADATA(Progr:integer; DataDest:TDateTime);
begin
  pckT080GETDATOGENERICO.SetVariable('INPROG',Progr);
  pckT080GETDATOGENERICO.SetVariable('INDATA',DataDest);
  pckT080GETDATOGENERICO.Execute;
end;

function T080PCKTURNO.GetPartenza:integer;
begin
  Result:=pckT080GETDATOGENERICO.GetVariable('PARTENZA');
end;

function T080PCKTURNO.SeEsisteDatoT620(Progr:integer;DataInizio:TDateTime):integer;
begin
  Result:=-1;
  with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('begin');
      SQL.Add('  select count(*) into :NUM_REC');
      SQL.Add('    from T620_TURNAZIND T620');
      SQL.Add('   where T620.PROGRESSIVO = :PROGRESSIVO');
      SQL.Add('     and T620.DATA = :DATA;');
      SQL.Add('end;');
      if DebugHook <> 0 then
        Debug:=True;
      DeclareAndSet('PROGRESSIVO',otInteger,Progr);
      DeclareAndSet('DATA',otDate,DataInizio);
      DeclareVariable('NUM_REC',otInteger);
      Execute;
      Result:=GetVariable('NUM_REC');
    finally
      Free;
    end;
end;

procedure T080PCKTURNO.SetVariabiliCopiaTurnazione(ProgOrig, ProgDest:integer; DataInizio, DataFine:TDateTime);
begin
  AbilitaCopia:=True;
  if ProgOrig <= 0 then
    AbilitaCopia:=False;
  if ProgDest <= 0 then
    AbilitaCopia:=False;
  if DataInizio > DataFine then
    AbilitaCopia:=False;
  pckT080COPIATURNO.ClearVariables;
  pckT080COPIATURNO.SetVariable('PROGORIG',ProgOrig);
  pckT080COPIATURNO.SetVariable('PROGDEST',ProgDest);
  pckT080COPIATURNO.SetVariable('DATAINIZIO',DataInizio);
  pckT080COPIATURNO.SetVariable('DATAFINE',DataFine);
end;

function T080PCKTURNO.CopiaTurnazione(EseguiCommit:Boolean = True):string;
begin
  Result:='';
  if AbilitaCopia then
  begin
    try
      pckT080COPIATURNO.Execute;
      Result:=VarToStr(pckT080COPIATURNO.getVariable('RESULT'));
      if EseguiCommit then
        SessioneOracle.Commit;
    except
      on e:exception do
        Result:=e.Message;
    end;
    AbilitaCopia:=False;
  end;
end;

{End T080PCKTURNO}

procedure TA058FPianifTurniDtM1.A058FPianifTurniDtM1Create(Sender: TObject);
var
  i:Integer;
begin
  if not SessioneOracle.Connected  then
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
  //AssenzeOperative:=Parametri.CampiRiferimento.C11_PianifOrari_No_Giustif = 'OPERATIVA';
  PckTurno:=T080PCKTURNO.Create;
  ConteggiaDebito:=False;
  QSSquadra:=TQueryStorico.Create(nil);
  QSSquadra.Session:=SessioneOracle;
  Vista:=TList<TDipendente>.Create;
  xValoreOrigine:=TGiorno.Create;
  selDatiBloccatiA058:=TDatiBloccati.Create(nil);
  selT082.Open;
  selT082.Filtered:=True;
  AssenzeOperative:=selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
  Q020.Open;
  QT021.Open;
  Q265.Open;
  Q265B.Open;
  Q600.Open;
  ListaCicli:=TStringList.Create;
  Turno1:=TStringList.Create;
  Turno2:=TStringList.Create;
  Orario:=TStringList.Create;
  Causale:=TStringList.Create;
  R502ProDtM:=TR502ProDtM1.Create(nil);
end;

procedure TA058FPianifTurniDtM1.OpenSelV430(OutDato:String);
begin
  R180SetVariable(selV430,'DECORRENZAIN',DataInizio);
  R180SetVariable(selV430,'SELECT',OutDato);
  selV430.Open;
end;

procedure TA058FPianifTurniDtM1.OpenSelT100(Prog:Integer;DaData,AData:TDateTime);
begin
  R180SetVariable(selT100,'PROGRESSIVO',Prog);
  R180SetVariable(selT100,'DADATA',DaData);
  R180SetVariable(selT100,'ADATA',AData);
  selT100.Open;
end;

//Restituisce TMaxMin(Max/Min Squadra) distingue già i gg feriali da quelli festivi
function TA058FPianifTurniDtM1.GetLimitiMAX_MIN(inData:TDateTime;inTurno:Integer):TMaxMin;
begin
  Result.Min:=0;
  Result.Max:=0;
  if (Not inTurno in [1,2,3,4]) or Not Q600B.Active then
    Exit;
  if VarIsNull(GetCalend.GetVariable('D')) or (VarToDateTime(GetCalend.GetVariable('D')) <> inData) then
  begin
    GetCalend.SetVariable('PROG',Vista[0].Prog);
    GetCalend.SetVariable('D',inData);
    GetCalend.Execute;
  end;
  if (VarToStr(GetCalend.GetVariable('F')) = 'S') or (DayOfWeek(inData) = 1) then
  begin
    Result.Min:=Q600B.FieldByName('FESMIN' + IntToStr(inTurno)).asInteger;
    Result.Max:=Q600B.FieldByName('FESMAX' + IntToStr(inTurno)).asInteger;
  end
  else
  begin
    Result.Min:=Q600B.FieldByName('TOTMIN' + IntToStr(inTurno)).asInteger;
    Result.Max:=Q600B.FieldByName('TOTMAX' + IntToStr(inTurno)).asInteger;
  end;
end;

function TA058FPianifTurniDtM1.TestAssenza(Ass,Turno:String):Boolean;
begin
  //True: includo il turno dal conteggio
  Ass:=Trim(Ass);
  Result:=Ass <> '';//Posso decrementare l'assenza
  if Result and R180In(Trim(Turno),['1','2','3','4','5','6','7','8','9']) then
    with TOracleQuery.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select T265.ESCLUSIONE');
        SQL.Add('  from T265_CAUASSENZE T265');
        SQL.Add(' where T265.CODICE = :CODICE');
        DeclareVariable(':CODICE',otString);
        SetVariable(':CODICE',Ass);
        Execute;
        if (RowCount > 0) and (FieldAsString('ESCLUSIONE') = 'S') then
          Result:=False;
      finally
        Free;
      end;
end;

procedure TA058FPianifTurniDtM1.AggiornaContatoriTurni(nRiga:integer;nColonna:integer;DopoElabTurni:Boolean = False);
begin
  with Vista[nRiga].Giorni[nColonna] do
  begin
    if Modificato or DopoelabTurni then
    begin
      //******************************************************************************
      //Aggiorno i contatori riguardanti la distribuzione dei turni
      //***************************** PRIMO TURNO ************************************
      if (sNumTurno1 <> NumTurno1) or (sAss1 <> Ass1) then
      begin
        //Decremento il turno che è stato eliminato
        if (sT1EU <> 'U') and ((sNumTurno1 <> '') or (Trim(T1) = '0')) and Not TestAssenza(sAss1,sNumTurno1)  then
        begin
          if sNumTurno1 = '1' then
          begin
            dec(aTotaleTurni[nColonna].Turno1);
            dec(Vista[nRiga].TotaleTurniMese.Turno1);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe1,False);
          end
          else if sNumTurno1 = '2' then
          begin
            dec(aTotaleTurni[nColonna].Turno2);
            dec(Vista[nRiga].TotaleTurniMese.Turno2);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe2,False);
          end
          else if sNumTurno1 = '3' then
          begin
            dec(aTotaleTurni[nColonna].Turno3);
            dec(Vista[nRiga].TotaleTurniMese.Turno3);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe3,False);
          end
          else if sNumTurno1 = '4' then
          begin
            dec(aTotaleTurni[nColonna].Turno4);
            dec(Vista[nRiga].TotaleTurniMese.Turno4);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe4,False);
          end;
        end;
        //Incremento il nuovo turno che è stato inserito
        {Prima di incrementare il turno verifico che la causale attuale(se presente) sia inclusa nel calcolo del turno}
        if  (T1EU <> 'U') and (Not TestAssenza(Ass1,NumTurno1) or (TestAssenza(sAss1,sNumTurno1) and (Ass1 <> sAss1))) then
        begin
          if NumTurno1 = '1' then
          begin
            inc(aTotaleTurni[nColonna].Turno1);
            inc(Vista[nRiga].TotaleTurniMese.Turno1);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe1);
          end
          else if NumTurno1 = '2' then
          begin
            inc(aTotaleTurni[nColonna].Turno2);
            inc(Vista[nRiga].TotaleTurniMese.Turno2);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe2);
          end
          else if NumTurno1 = '3' then
          begin
            inc(aTotaleTurni[nColonna].Turno3);
            inc(Vista[nRiga].TotaleTurniMese.Turno3);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe3);
          end
          else if NumTurno1 = '4' then
          begin
            inc(aTotaleTurni[nColonna].Turno4);
            inc(Vista[nRiga].TotaleTurniMese.Turno4);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe4);
          end;
        end;
      end;

      //***************************** SECONDO TURNO ************************************
      if ((sNumTurno2 <> NumTurno2) or (sAss2 <> Ass2)) then
      begin
        //Decremento il turno che è stato eliminato
        if (sT2EU <> 'U') and ((sNumTurno2 <> '') or (Trim(T2) = '0')) and Not TestAssenza(sAss2,sNumTurno2)  then
        begin
          if sNumTurno2 = '1' then
          begin
            dec(aTotaleTurni[nColonna].Turno1);
            dec(Vista[nRiga].TotaleTurniMese.Turno1);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe1,False);
          end
          else if sNumTurno2 = '2' then
          begin
            dec(aTotaleTurni[nColonna].Turno2);
            dec(Vista[nRiga].TotaleTurniMese.Turno2);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe2,False);
          end
          else if sNumTurno2 = '3' then
          begin
            dec(aTotaleTurni[nColonna].Turno3);
            dec(Vista[nRiga].TotaleTurniMese.Turno3);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe3,False);
          end
          else if sNumTurno2 = '4' then
          begin
            dec(aTotaleTurni[nColonna].Turno4);
            dec(Vista[nRiga].TotaleTurniMese.Turno4);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe4,False);
          end;
        end;
        //Incremento il nuovo turno che è stato inserito
        if  (T2EU <> 'U') and (Not TestAssenza(Ass2,NumTurno2) or (TestAssenza(sAss2,sNumTurno2) and (Ass2 <> sAss2))) then
        begin
          if NumTurno2 = '1' then
          begin
            inc(aTotaleTurni[nColonna].Turno1);
            inc(Vista[nRiga].TotaleTurniMese.Turno1);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe1);
          end
          else if NumTurno2 = '2' then
          begin
            inc(aTotaleTurni[nColonna].Turno2);
            inc(Vista[nRiga].TotaleTurniMese.Turno2);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe2);
          end
          else if NumTurno2 = '3' then
          begin
            inc(aTotaleTurni[nColonna].Turno3);
            inc(Vista[nRiga].TotaleTurniMese.Turno3);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe3);
          end
          else if NumTurno2 = '4' then
          begin
            inc(aTotaleTurni[nColonna].Turno4);
            inc(Vista[nRiga].TotaleTurniMese.Turno4);
            AddTurnoOperatore(Vista[nRiga],aTotaleTurni[nColonna].TotOpe4);
          end;
        end;
      end;
    end;
    {$IFNDEF IRISWEB}
      if (A058FGrigliaPianif <> nil) and (A058FGrigliaPianif.GVista <> nil) then
        A058FGrigliaPianif.GVista.Refresh;
    {$ENDIF}
  end;
end;

procedure TA058FPianifTurniDtM1.PianificaAssenza(NDip,G:LongInt; A1,A2:String; xArrayPianif:TPianificazione);
{Pianifica le assenze su T040 o T041 a seconda che la pianificazione sia
 operativa o meno}
var
  Cau1,Cau2:String;
  bTrovato:boolean;
  Prog:LongInt;
  Data:TDateTime;

    procedure Inserisci(Causale:String; ProgAss:integer);
    var AssModif:Boolean;
    begin
      if not Q265.Locate('Codice',Causale,[]) then exit;
      //Se il giustificativo è stato pianificato dalla gestione assenze allora non devo inserirlo...
      //perchè altrimenti creerei un duplicato, sulla T041 del record che esiste già sulla T040 e che non
      //è modificabile...
      if ProgAss=1 then
       AssModif:=Vista[NDip].Giorni[G].Ass1Modif
      else
       AssModif:=Vista[NDip].Giorni[G].Ass2Modif;
      if AssModif then
      begin
        xArrayPianif.xDatasetGiust.Append;
        xArrayPianif.xDatasetGiust.FieldByName('Progressivo').AsInteger:=Prog;
        xArrayPianif.xDatasetGiust.FieldByName('Data').AsDateTime:=Data;
        xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString:=Causale;
        if xArrayPianif.xDatasetGiust = Q040Gest then
        begin
          xArrayPianif.xDatasetGiust.FieldByName('ProgrCausale').AsInteger:=98 + ProgAss;
          xArrayPianif.xDatasetGiust.FieldByName('TipoGiust').AsString:='I';
          xArrayPianif.xDatasetGiust.FieldByName('Scheda').AsString:='P';
        end
        else if xArrayPianif.xDatasetGiust = Q041Gest then
          xArrayPianif.xDatasetGiust.FieldByName('ProgrCausale').AsInteger:=98 + ProgAss;
        if (xArrayPianif.sFlagAgg <> '') and not AssenzeOperative then
          xArrayPianif.xDatasetGiust.FieldByName('FLAGAGG').AsString:=xArrayPianif.sFlagAgg;
        xArrayPianif.xDatasetGiust.Post;
      end;
    end;

begin
  Prog:=Vista[NDip].Prog;
  Data:=DataInizio + G - OffsetVista;
  Cau1:='';
  Cau2:='';
  if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
    bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;TipoGiust',VarArrayOf([Data,'I']),[srFromBeginning])
  else
    bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;FlagAgg',VarArrayOf([Data, xArrayPianif.sFlagAgg]),[srFromBeginning]);
  if bTrovato then
    //leggo le causali a giornate intere in Cau1 e Cau2 (Max 2)
    while not xArrayPianif.xDatasetGiust.Eof do
    begin
      if xArrayPianif.xDatasetGiust.FieldByName('Data').AsDateTime <> Data then Break;
      if (Cau1 = '') and (xArrayPianif.xDatasetGiust.FieldByName('PROGRCAUSALE').asInteger <= 99) then
        Cau1:=xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString
      else if (Cau2 = '') and (xArrayPianif.xDatasetGiust.FieldByName('PROGRCAUSALE').asInteger <> 99) then
        Cau2:=xArrayPianif.xDatasetGiust.FieldByName('Causale').AsString;
      xArrayPianif.xDatasetGiust.Next;
    end;
  {if (Not A058FPianifTurni.NuovaPianif) and
     (Not A058FPianifTurni.AssenzeOperative) then
  begin}
    if (Cau1 <> A1) then
    begin
      //Se Cau1 non è più pianificata la cancello
      if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;TipoGiust',VarArrayOf([Data,Cau1,'I']),[srFromBeginning])
      else
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;FlagAgg',VarArrayOf([Data,Cau1,xArrayPianif.sFlagAgg]),[srFromBeginning]);
      if bTrovato then
        xArrayPianif.xDatasetGiust.Delete;
    end;
    if (Cau2 <> A2) then
    begin
      //Se Cau2 non è più pianificata la cancello
      if (xArrayPianif.sFlagAgg = '') or AssenzeOperative then
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;TipoGiust',VarArrayOf([Data,Cau2,'I']),[srFromBeginning])
      else
        bTrovato:=xArrayPianif.xDatasetGiust.SearchRecord('Data;Causale;FlagAgg',VarArrayOf([Data,Cau2,xArrayPianif.sFlagAgg]),[srFromBeginning]);
      if bTrovato then
        xArrayPianif.xDatasetGiust.Delete;
    end;
  //end;
  if (A1 <> Cau1) and (A1 <> Cau2) then
    //Se A1 non esiste la inserisco
    if A1 <> '' then
      Inserisci(A1,1);
  if (A2 <> Cau1) and (A2 <> Cau2) then
    if A2 <> '' then
      Inserisci(A2,2);
end;

procedure TA058FPianifTurniDtM1.PianificaOrario(NDip,G:LongInt; Ora,T1,T2,T1EU,T2EU,ValorGior:String;xArrayPianif:TPianificazione);
{Pianifica l'orario su T080 o T081 a seconda che la pianificazione sia
 operativa o meno}
var
  Prog:integer;
  Data:TDateTime;
begin
  Prog:=Vista[NDip].Prog;
  //per il calcolo della data tolgo l'offset
  Data:=DataInizio + G - OffsetVista;
  //Se esiste una pianificazione esistente la cancello
  if xArrayPianif.xDatasetPianif.Locate('Data',Data,[]) then
    xArrayPianif.xDatasetPianif.Delete;
  if Q020.Locate('Codice',Ora,[]) then
  //Pianifico se esiste l'orario
  begin
    xArrayPianif.xDatasetPianif.Append;
    xArrayPianif.xDatasetPianif.FieldByName('Progressivo').AsInteger:=Prog;
    xArrayPianif.xDatasetPianif.FieldByName('Data').AsDateTime:=Data;
    xArrayPianif.xDatasetPianif.FieldByName('Orario').AsString:=Ora;
    xArrayPianif.xDatasetPianif.FieldByName('Turno1').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno2').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno1EU').AsString:='';
    xArrayPianif.xDatasetPianif.FieldByName('Turno2EU').AsString:='';
    if xArrayPianif.xDatasetPianif = Q080Gest then
      xArrayPianif.xDatasetPianif.FieldByName('ValorGior').AsString:=ValorGior;
    if (Q020.FieldByName('TipoOra').AsString = 'E') and (Trim(T1) <> 'M') and (Trim(T1) <> 'A') then
    //FlagAgg = 'P' viene impostato automaticamente in U080/U081
    //Pianifico i turni solo se l'orario è di tipo Turni
    begin
      xArrayPianif.xDatasetPianif.FieldByName('Turno1').AsString:=Trim(T1);
      xArrayPianif.xDatasetPianif.FieldByName('Turno2').AsString:=Trim(T2);
      xArrayPianif.xDatasetPianif.FieldByName('Turno1EU').AsString:=T1EU;
      xArrayPianif.xDatasetPianif.FieldByName('Turno2EU').AsString:=T2EU;
    end;
    if xArrayPianif.sFlagAgg <> '' then
      xArrayPianif.xDatasetPianif.FieldByName('FLAGAGG').AsString:=xArrayPianif.sFlagAgg;
    xArrayPianif.xDatasetPianif.Post;
  end;
end;

procedure TA058FPianifTurniDtM1.PianificaGiorno(NDip,G:LongInt; BloccoT040,BloccoT080:Boolean; xArrayPianif:TPianificazione);
begin
  with Vista[NDip].Giorni[G] do
  begin
    //Non pianifico le pianificazioni manuali già esistenti
    if (Flag = 'M') and (not Modificato) and (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
      Exit;
    //Pianifico l'orario
    if not BloccoT080 then
      PianificaOrario(NDip,G,Ora,T1,T2,T1EU,T2EU,ValorGior,xArrayPianif);
    //Pianifico le assenze
    if not BloccoT040 then
      PianificaAssenza(NDip,G,Ass1,Ass2,xArrayPianif);
  end;
end;

procedure TA058FPianifTurniDtM1.RendiOperativa(NDip:LongInt);
{Esegui pianificazione}
var i,n:LongInt;
    xArrayPianif:array of TPianificazione;
    BloccoT040,BloccoT080:Boolean;
    D:TDateTime;
begin
  selDatiBloccatiA058.Close;
  BloccoT040:=False;
  BloccoT080:=False;
  //Cancella la pianificazione esistente su T080,T040 o su T081,T041
  //Verifico se uno dei riepiloghi è bloccato
  D:=DataInizio;
  while D <= DataFine do
  begin
    if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T040') then
      BloccoT040:=True;
    if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T080') then
      BloccoT080:=True;
    D:=D + 1;
  end;

  if not BloccoT080 then
  begin
    CancT080.SetVariable('Progressivo',Vista[NDip].Prog);
    CancT080.SetVariable('Data1',DataInizio);
    CancT080.SetVariable('Data2',DataFine);
    CancT080.Execute;
  end;
  if not BloccoT040 then
  begin
    CancT040.SetVariable('Progressivo',Vista[NDip].Prog);
    CancT040.SetVariable('Data1',DataInizio);
    CancT040.SetVariable('Data2',DataFine);
    CancT040.Execute;
  end;
  SessioneOracle.Commit;

  //Apertura archivio pianificazioni
  SetLength(xArrayPianif,0);
  SetLength(xArrayPianif,Length(xArrayPianif)+1);
  xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q080Gest;
  xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
  xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
  for n:=0 to High(xArrayPianif) do
  begin
    xArrayPianif[n].xDatasetPianif.Close;
    xArrayPianif[n].xDatasetPianif.ClearVariables;
    xArrayPianif[n].xDatasetPianif.SetVariable('Progressivo',Vista[NDip].Prog);
    xArrayPianif[n].xDatasetPianif.SetVariable('Data1',DataInizio);
    xArrayPianif[n].xDatasetPianif.SetVariable('Data2',DataFine);
    xArrayPianif[n].xDatasetPianif.Open;
    //Aggiorno i giustificativi non pianificati
    Q040.Close;
    Q040.Open;
    //Apertura archivio giustificativi
    xArrayPianif[n].xDatasetGiust.Close;
    xArrayPianif[n].xDatasetGiust.ClearVariables;
    xArrayPianif[n].xDatasetGiust.SetVariable('Progressivo',Vista[NDip].Prog);
    xArrayPianif[n].xDatasetGiust.SetVariable('Data1',DataInizio);
    xArrayPianif[n].xDatasetGiust.SetVariable('Data2',DataFine);
    xArrayPianif[n].xDatasetGiust.Open;
    //Scorrimento dei giorni da pianificare
    for i:=0 to Vista[NDip].Giorni.Count - 1 do
      PianificaGiorno(NDip,i,BloccoT040,BloccoT080,xArrayPianif[n]);
    SessioneOracle.ApplyUpdates([xArrayPianif[n].xDatasetPianif, xArrayPianif[n].xDatasetGiust],True);
    SessioneOracle.Commit;
  end;

  //Registrazione log
  if not BloccoT040 then
  begin
    RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',Copy(Self.Name,1,4),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
    RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
    RegistraLog.RegistraOperazione;
  end;
  if not BloccoT080 then
  begin
    RegistraLog.SettaProprieta('I','T080_PIANIFORARI',Copy(Self.Name,1,4),nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
    RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA058FPianifTurniDtM1.CancellaPianificazione(Prog:LongInt);
{Cancello i dati del dipendente corrente}
var
  D:TDateTime;
  BloccoT040,BloccoT080:Boolean;
  xArrayPianif:array of TPianificazione;
  i:integer;
begin
  selDatiBloccatiA058.Close;
  BloccoT080:=False;
  BloccoT040:=False;
  SetLength(xArrayPianif,0);
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    //Verifico se uno dei riepiloghi è bloccato
    D:=DataInizio;
    while D <= DataFine do
    begin
      if selDatiBloccatiA058.DatoBloccato(Prog,R180InizioMese(D),'T040') then
        BloccoT040:=True;
      if selDatiBloccatiA058.DatoBloccato(Prog,R180InizioMese(D),'T080') then
        BloccoT080:=True;
      D:=D + 1;
    end;
    SetLength(xArrayPianif,length(xArrayPianif)+1);
    xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancAllT080;
    xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT040;
    xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
    end;
  end
  else
  begin
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      {Precedente al 10/04/2014)
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';}
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      if TipoPianif = 0 then
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='I'
      else
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
    end
    else
    begin
      SetLength(xArrayPianif,length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xQueryPianif:=CancT081;
      xArrayPianif[High(xArrayPianif)].xQueryGiust:=CancT041;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='N';
    end;
  end;

  for i:=0 to High(xArrayPianif) do
  begin
    //Pianificazione
    if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') or (not BloccoT080) then
    begin
      xArrayPianif[i].xQueryPianif.ClearVariables;
      xArrayPianif[i].xQueryPianif.SetVariable('Progressivo',Prog);
      xArrayPianif[i].xQueryPianif.SetVariable('Data1',DataInizio);
      xArrayPianif[i].xQueryPianif.SetVariable('Data2',DataFine);
      if xArrayPianif[i].sFlagAgg <> '' then
        xArrayPianif[i].xQueryPianif.SetVariable('FlagAgg',' AND FLAGAGG = ''' + xArrayPianif[i].sFlagAgg + '''');
      xArrayPianif[i].xQueryPianif.Execute;
    end;
    //Giustificativi
    if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') or (not BloccoT040) then
    begin
      xArrayPianif[i].xQueryGiust.SetVariable('Progressivo',Prog);
      xArrayPianif[i].xQueryGiust.SetVariable('Data1',DataInizio);
      xArrayPianif[i].xQueryGiust.SetVariable('Data2',DataFine);
      if xArrayPianif[i].sFlagAgg <> '' then
        xArrayPianif[i].xQueryGiust.SetVariable('FlagAgg',' AND FLAGAGG = ''' + xArrayPianif[i].sFlagAgg + '''');
      xArrayPianif[i].xQueryGiust.Execute;
    end;
    SessioneOracle.Commit;
  end;

  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    if not BloccoT040 then
    begin
      RegistraLog.SettaProprieta('C','T040_GIUSTIFICATIVI',Copy(Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
    if not BloccoT080 then
    begin
      RegistraLog.SettaProprieta('C','T080_PIANIFORARI',Copy(Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
  end;
end;

procedure TA058FPianifTurniDtM1.EseguiPianificazione(NDip:LongInt);
{Esegui pianificazione}
var i,n:LongInt;
    xArrayPianif:array of TPianificazione;
    BloccoT040,BloccoT080:Boolean;
    D:TDateTime;
begin
  selDatiBloccatiA058.Close;
  BloccoT040:=False;
  BloccoT080:=False;
  //Cancella la pianificazione esistente su T080,T040 o su T081,T041
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    //Verifico se uno dei riepiloghi è bloccato
    D:=DataInizio;
    while D <= DataFine do
    begin
      if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T040') then
        BloccoT040:=True;
      if selDatiBloccatiA058.DatoBloccato(Vista[NDip].Prog,R180InizioMese(D),'T080') then
        BloccoT080:=True;
      D:=D + 1;
    end;
  end;
  if NuovaPianif then
  begin
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      if not BloccoT080 then
      begin
        CancT080.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT080.SetVariable('Data1',DataInizio);
        CancT080.SetVariable('Data2',DataFine);
        CancT080.Execute;
      end;
      if not BloccoT040 then
      begin
        CancT040.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT040.SetVariable('Data1',DataInizio);
        CancT040.SetVariable('Data2',DataFine);
        CancT040.Execute;
      end;
      //Se è attiva la PIANIFICAZIONE PROGRESSIVA elimino anche il contenuto
      //delle tabelle T081 e T041
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        CancT081.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT081.SetVariable('Data1',DataInizio);
        CancT081.SetVariable('Data2',DataFine);
        CancT081.SetVariable('FlagAgg',' AND FLAGAGG <> ''N''');
        CancT081.Execute;
        CancT041.SetVariable('Progressivo',Vista[NDip].Prog);
        CancT041.SetVariable('Data1',DataInizio);
        CancT041.SetVariable('Data2',DataFine);
        CancT041.SetVariable('FlagAgg',' AND FLAGAGG <> ''N''');
        CancT041.Execute;
      end;
    end
    else
    begin
      CancT081.SetVariable('Progressivo',Vista[NDip].Prog);
      CancT081.SetVariable('Data1',DataInizio);
      CancT081.SetVariable('Data2',DataFine);
      if (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
        CancT081.SetVariable('FlagAgg','AND FLAGAGG = ''N''');
      CancT081.Execute;
      CancT041.SetVariable('Progressivo',Vista[NDip].Prog);
      CancT041.SetVariable('Data1',DataInizio);
      CancT041.SetVariable('Data2',DataFine);
      if (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') then
        CancT041.SetVariable('FlagAgg','AND FLAGAGG = ''N''');
      CancT041.Execute;
    end;
    SessioneOracle.Commit;
  end;
  //Apertura archivio pianificazioni
  SetLength(xArrayPianif,0);
  if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then //PIANIFICAZIONE PROGRESSIVA (SOLO OPERATIVA)
  begin
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      SetLength(xArrayPianif,Length(xArrayPianif)+1);
      xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q080Gest;
      xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
      xArrayPianif[High(xArrayPianif)].sFlagAgg:='';
    end;
    {*Pianificazione progressivo non operativa*}
    //if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') then
    begin
      if GeneraIniCorr or ((TipoPianif = 0) and (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) then
      begin
        SetLength(xArrayPianif,Length(xArrayPianif) + 1);
        xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q081Gest;
        if not AssenzeOperative then
          xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q041Gest
        else
          xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='I';
      end;
      if GeneraIniCorr or ((TipoPianif = 1) and (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) or
        (NuovaPianif and  (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N')) then
      begin
        SetLength(xArrayPianif,Length(xArrayPianif) + 1);
        xArrayPianif[High(xArrayPianif)].xDatasetPianif:=Q081Gest;
        if not AssenzeOperative then
          xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q041Gest
        else
          xArrayPianif[High(xArrayPianif)].xDatasetGiust:=Q040Gest;
        xArrayPianif[High(xArrayPianif)].sFlagAgg:='C';
      end;
    end;
    {--Bruno--10/04/2014}
  end
  else
  begin
    SetLength(xArrayPianif,1);
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      xArrayPianif[0].xDatasetPianif:=Q080Gest;
      xArrayPianif[0].xDatasetGiust:=Q040Gest;
      xArrayPianif[0].sFlagAgg:='';
    end
    else
    begin
      xArrayPianif[0].xDatasetPianif:=Q081Gest;
      xArrayPianif[0].xDatasetGiust:=Q041Gest;
      if AssenzeOperative then
        xArrayPianif[0].xDatasetGiust:=Q040Gest;
      xArrayPianif[0].sFlagAgg:='N';
    end;
  end;
  for n:=0 to High(xArrayPianif) do
  begin
    xArrayPianif[n].xDatasetPianif.Close;
    xArrayPianif[n].xDatasetPianif.ClearVariables;
    xArrayPianif[n].xDatasetPianif.SetVariable('Progressivo',Vista[NDip].Prog);
    xArrayPianif[n].xDatasetPianif.SetVariable('Data1',DataInizio);
    xArrayPianif[n].xDatasetPianif.SetVariable('Data2',DataFine);
    if xArrayPianif[n].sFlagAgg <> '' then
      xArrayPianif[n].xDatasetPianif.SetVariable('FLAGAGG','AND FLAGAGG = ''' + xArrayPianif[n].sFlagAgg + '''');
    xArrayPianif[n].xDatasetPianif.Open;
    //Aggiorno i giustificativi non pianificati
    Q040.Close;
    Q040.Open;
    //Apertura archivio giustificativi
    //LELLO
    xArrayPianif[n].xDatasetGiust.Close;
    xArrayPianif[n].xDatasetGiust.ClearVariables;
    xArrayPianif[n].xDatasetGiust.SetVariable('Progressivo',Vista[NDip].Prog);
    xArrayPianif[n].xDatasetGiust.SetVariable('Data1',DataInizio);
    xArrayPianif[n].xDatasetGiust.SetVariable('Data2',DataFine);
    if xArrayPianif[n].sFlagAgg <> '' then
      xArrayPianif[n].xDatasetPianif.SetVariable('FLAGAGG','AND FLAGAGG = ''' + xArrayPianif[n].sFlagAgg + '''');
    xArrayPianif[n].xDatasetGiust.Open;
    //Scorrimento dei giorni da pianificare
    for i:=OffsetVista to (OffsetVista + Trunc(DataFine - DataInizio)) do
      PianificaGiorno(NDip,i,BloccoT040,BloccoT080,xArrayPianif[n]);
    SessioneOracle.ApplyUpdates([xArrayPianif[n].xDatasetPianif, xArrayPianif[n].xDatasetGiust],True);
    SessioneOracle.Commit;
  end;
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  begin
    if not BloccoT040 then
    begin
      RegistraLog.SettaProprieta('I','T040_GIUSTIFICATIVI',Copy(Self.Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
    if not BloccoT080 then
    begin
      RegistraLog.SettaProprieta('I','T080_PIANIFORARI',Copy(Self.Name,1,4),nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Vista[NDip].Prog));
      RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]));
      RegistraLog.RegistraOperazione;
    end;
  end;
end;

function TA058FPianifTurniDtm1.OrdinamentoStampa:string;
var
  ListaOrdinamento:TStringList;
  i:integer;
begin
  ListaOrdinamento:=TStringList.Create;
  try
    ListaOrdinamento.CommaText:=selT082.FieldByName('ORD_STAMPA').AsString;
    Result:='';
    for i:=0 to ListaOrdinamento.Count - 1 do
    begin
      if not Result.IsEmpty and (i < ListaOrdinamento.Count) then
        Result:=Result + ';';
      if ListaOrdinamento[i] = 'N' then
        Result:=Result + 'Nome'
      else if ListaOrdinamento[i] = 'S' then
        Result:=Result + 'Operatore'
      else if ListaOrdinamento[i] = 'T' then
        Result:=Result + 'Partenza'
      else if ListaOrdinamento[i] = 'P' then
        Result:=Result + 'Turni0'
      else if ListaOrdinamento[i] = 'O' then
        Result:=Result + 'Orari0';
    end;
  finally
    FreeAndNil(ListaOrdinamento);
  end;
end;

procedure TA058FPianifTurniDtm1.ForzaOrdC700;
var
  Select, From, Where, Orderby, SQL:String;
  PosStart, PosEnd, i:Integer;
  ListaOrdinamento:TStringList;
begin
  {Scompongo query selanagrafe in Select - From - Where - OrderBy}
  PosStart:=0;
  PosEnd:=pos(' FROM'+#13#10,SelAnagrafeA058.SubstitutedSQL);
  Select:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,PosEnd);
  PosStart:=PosEnd;
  PosEnd:=pos(#13#10+'WHERE ',SelAnagrafeA058.SubstitutedSQL);
  From:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart, PosEnd - PosStart);
  PosStart:=PosEnd;
  PosEnd:=pos('ORDER BY',SelAnagrafeA058.SubstitutedSQL) - 1;
  if PosEnd > 0 then
  begin
    Where:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,PosEnd - PosStart);
    PosStart:=PosEnd;
    PosEnd:=2000;
  end
  else
    Where:=Copy(SelAnagrafeA058.SubstitutedSQL,PosStart,2000);

  {Compongo la nuova query SQL in base ai parametri su T082}
  ListaOrdinamento:=TStringList.Create;
  try
    OrderBy:='';
    ListaOrdinamento.CommaText:=selT082.FieldByName('ORD_VIS').AsString;
    for i:=0 to ListaOrdinamento.Count - 1 do
    begin
      if not OrderBy.IsEmpty and (i < ListaOrdinamento.Count) then
        OrderBy:=OrderBy + ', ';
      if ListaOrdinamento[i] = 'T' then
      begin
        //Ordinamento per turno di partenza
        From:=From + ',T620_TURNAZIND T620';
        Where:=Where + ' and T620.PROGRESSIVO = T030.PROGRESSIVO';
        Where:=Where + ' and T620.DATA = (select max(T620.DATA) from T620_TURNAZIND T620';
        Where:=Where + ' where T620.PROGRESSIVO = T030.PROGRESSIVO and';
        Where:=Where + ' T620.DATA <= to_date(''' + DateToStr(DataFine) + ''',''DD/MM/YYYY''))';
        OrderBy:=OrderBy + 'T620.PARTENZA';
      end;
      if ListaOrdinamento[i] = 'S' then
        //Ordinamento per squdra - operatore
        OrderBy:=OrderBy + 'V430.T430TIPOOPE';
      if ListaOrdinamento[i] = 'P' then
        //Ordinamento per turno
        OrderBy:=OrderBy + 'T080PCK_TURNO.GETNTURNO(T030.PROGRESSIVO,TO_DATE(''' + DateToStr(DataInizio) + ''',''DD/MM/YYYY''),''' +
                           IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','O','N') + ''')';
      if ListaOrdinamento[i] = 'N' then
        //ordinamento per cognome nome
        OrderBy:=OrderBy + 'T030.COGNOME, T030.NOME';
      if ListaOrdinamento[i] = 'O' then
        OrderBy:=OrderBy + 'T080PCK_TURNO.GETORARIO(T030.PROGRESSIVO,TO_DATE(''' + DateToStr(DataInizio) + ''',''DD/MM/YYYY''),''' +
                           IfThen(selT082.fieldByName('MODALITA_LAVORO').AsString = 'O','O','N') + ''')';
    end;
    SQL:=Select + From + Where + ' order by V430.T430SQUADRA, ' + OrderBy;
    //Prima di sostituire l'SQL lo salvo in una variabile
    SalvaSQLOriginale:=SelAnagrafeA058.SQL.Text;
    if not selT082.FieldByName('ORD_VIS').IsNull then
    begin
      SelAnagrafeA058.SQL.Clear;
      SelAnagrafeA058.SQL.Add(SQL);
    end;
  finally
    FreeAndNil(ListaOrdinamento);
  end;
end;

function TA058FPianifTurniDtm1.GetListaSquadra:String;
var Str:String;
begin
  Str:='';
  SelAnagrafeA058.First;
  while Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) do
  begin
    Str:=Str + SelAnagrafeA058.FieldByName('PROGRESSIVO').AsString;
    SelAnagrafeA058.Next;
    if Not SelAnagrafeA058.Eof and (SelAnagrafeA058.RecNo <= 1000) then
      Str:=Str + ','
  end;
  T600GetSquadra.Close;
  if Str <> '' then
  begin
    Str:='AND T430.PROGRESSIVO IN (' + Str + ')';
    T600GetSquadra.SetVariable('FILTRO',Str);
  end;
  T600GetSquadra.Open;
  Result:=T600GetSquadra.FieldByName('SQUADRA').AsString;
end;

function TA058FPianifTurniDtm1.NumRighe(S:String):Integer;
var i:Integer;
begin
  Result:=0;
  S:=Trim(S);
  if Length(S) > 0 then
    Result:=1;
  for i:=1 to Length(S) do
    if S[i] = #13 then
      inc(Result);
end;

procedure TA058FPianifTurniDtm1.RefreshReperibilità;
var
  i,j:integer;
begin
  selT380.Close;
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  for i:=0 to Vista.Count - 1 do
  begin
    R180SetVariable(selT380,'PROGRESSIVO',Vista[i].Prog);
    selT380.Open;
    for j:=0 to Vista[i].Giorni.Count - 1 do
      if (selT380.FieldByName('DATA').AsDateTime = Vista[i].Giorni[j].Data) or
         selT380.SearchRecord('DATA',Vista[i].Giorni[j].Data,[srFromCurrent]) then
      begin
        Vista[i].Giorni[j].TurnRep:=selT380.FieldByName('TURNO1').AsString;
        Vista[i].Giorni[j].OraInizioRep:=selT380.FieldByName('ORAINIZIO').AsString;
        Vista[i].Giorni[j].OraFineRep:=selT380.FieldByName('ORAFINE').AsString;
      end;
  end;
end;

procedure TA058FPianifTurniDtm1.PianificaDipendente(Prog:LongInt);
var 
  Posizione:LongInt;
  DataCorr:TDateTime;
begin
  if not GetPartenza(Prog,Posizione) then
    raise exception.Create(Format(A000MSG_A058_ERR_NO_PIANIFICAZIONE,[SelAnagrafeA058.FieldByName('Cognome').AsString +
                                                                      ' ' + SelAnagrafeA058.FieldByName('Nome').AsString]));	
  CreaDipendente(SelAnagrafeA058.FieldByName('Progressivo').AsInteger,SelAnagrafeA058.FieldByName('T430Badge').AsInteger,
                 SelAnagrafeA058.FieldByName('Matricola').AsString,SelAnagrafeA058.FieldByName('Cognome').AsString,
                 SelAnagrafeA058.FieldByName('Nome').AsString);
  selT380.Close;
  selT380.SetVariable('PROGRESSIVO',Prog);
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  selT380.Open;
  QSSquadra.GetDatiStorici('T430SQUADRA,T430D_SQUADRA,T430CALENDARIO,T430TIPOOPE,T430TGESTIONE,T430INIZIO,T430FINE',Prog,DataInizio,DataFine);
  DataCorr:=DataInizio;
  while DataCorr <= DataFine do
  begin
    //Se trovo una turnazione successiva ricalcolo lo sviluppo del ciclo e
    //la posizione di partenza
    if DataCorr >= TurnazSucc then
    begin
      GetAssegnazioneTurnazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,DataCorr);
      GetTurnazione(Posizione);
    end;
    CreaGiorno(DataCorr,Posizione);
    //Incremento posizione sui cicli e data corrente
    if Posizione > 0 then
      begin
      Posizione:=Posizione + 1;
      if Posizione >= Turno1.Count then
        Posizione:=1;
      end;
    DataCorr:=DataCorr + 1;
  end;
end;

procedure TA058FPianifTurniDtm1.EliminaDipendente(P:Integer);
{Elimina l'oggetto TDipendente e la relativa Lista TGiorni}
var i:Integer;
begin
  with Vista[P] do
    for i:=Giorni.Count - 1 downto 0 do
    begin
      Giorni[i].Free;
      Giorni.Delete(i);
      GiorniOld[i].Free;
      GiorniOld.Delete(i);
    end;
  Vista[P].Giorni.Free;
  Vista[P].GiorniOld.Free;
  Vista[P].Free;
  Vista.Delete(P);
end;

procedure TA058FPianifTurniDtm1.PulisciVista;
{Pulisce la Lista VISTA liberando la memoria allocata per ogni Elemento TDipendente}
var
  i:Integer;
begin
  OffsetVista:=0;
  if Vista <> nil then
    for i:=Vista.Count - 1 downto 0 do
      EliminaDipendente(i);
  SetLength(aTotaleTurni,0);
end;

procedure TA058FPianifTurniDtm1.AddTurnoOperatore(InDip:TDipendente;InArrOperatori:TArrTotOpe;AddUnita:boolean = True);
var j, Moltiplicatore:integer;
begin
  Moltiplicatore:=1;
  if Not AddUnita then
    Moltiplicatore:=-1;
  for j:=Low(InArrOperatori) to High(InArrOperatori) do
    if InDip.TipoOpe = '(' + InArrOperatori[j].Operatore + ')' then
      InArrOperatori[j].Totale:=InArrOperatori[j].Totale + (1 * Moltiplicatore);
end;

procedure TA058FPianifTurniDtm1.AggiornaTotaleTurni(i:integer);

  procedure IniMinMaxOperatori(var InArrOperatori:TArrTotOpe;NumTurno:integer);
  var
    MinCampo, MaxCampo:String;
    DataGG:TDateTime;
  begin
    if Not selDistOperatori.Active then
      Exit;
    selDistOperatori.First;
    while Not selDistOperatori.Eof do
    begin
      SetLength(InArrOperatori,Length(InArrOperatori) + 1);
      InArrOperatori[High(InArrOperatori)].Totale:=0;
      InArrOperatori[High(InArrOperatori)].Operatore:=selDistOperatori.FieldByName('TIPOOPE').AsString;
      if Not selOperatori.Active then
        selOperatori.Open;
      if selOperatori.SearchRecord('SQUADRA;CODICE',VarArrayOf([Q600B.GetVariable('CODSQUADRA'),
                                                                selDistOperatori.FieldByName('TIPOOPE').AsString]),
                                                                [srFromBeginning]) then
      begin
        DataGG:=DataInizio + Vista[0].Giorni.Count - 1;
        GetCalend.SetVariable('PROG',Vista[0].Prog);
        GetCalend.SetVariable('D',DataGG);
        GetCalend.Execute;
        MinCampo:='MIN' + IntToStr(NumTurno);
        MaxCampo:='MAX' + IntToStr(NumTurno);
        //Se il giorno è festivo prendo i max/min festivi
        if (VarToStr(GetCalend.GetVariable('F')) = 'S') or (DayOfWeek(DataGG) = 1) then
        begin
          //Se i max/min festivi sono nulli utilizzo quelli feriali
          MinCampo:='FES' + MinCampo;
          if selOperatori.FieldByName(MinCampo).IsNull then
            MinCampo:='MIN' + IntToStr(NumTurno);
          MaxCampo:='FES' + MaxCampo;
          if selOperatori.FieldByName(MaxCampo).IsNull then
            MaxCampo:='MAX' + IntToStr(NumTurno);
        end;
        InArrOperatori[High(InArrOperatori)].Min:=selOperatori.FieldByName(MinCampo).AsString;
        InArrOperatori[High(InArrOperatori)].Max:=selOperatori.FieldByName(MaxCampo).AsString;
      end
      else
      begin
        InArrOperatori[High(InArrOperatori)].Min:='-';
        InArrOperatori[High(InArrOperatori)].Max:='-';
      end;
      selDistOperatori.Next;
    end;
  end;

begin
  with Vista[i] do
  begin
    if (Length(aTotaleTurni) < Giorni.Count) then
    begin
      SetLength(aTotaleTurni, Giorni.Count);
      aTotaleTurni[Giorni.Count-1].Turno1:=0;
      IniMinMaxOperatori(aTotaleTurni[Giorni.Count-1].TotOpe1,1);
      aTotaleTurni[Giorni.Count-1].Turno2:=0;
      IniMinMaxOperatori(aTotaleTurni[Giorni.Count-1].TotOpe2,2);
      aTotaleTurni[Giorni.Count-1].Turno3:=0;
      IniMinMaxOperatori(aTotaleTurni[Giorni.Count-1].TotOpe3,3);
      aTotaleTurni[Giorni.Count-1].Turno4:=0;
      IniMinMaxOperatori(aTotaleTurni[Giorni.Count-1].TotOpe4,4);
    end;
    with Giorni[Giorni.Count-1] do
    begin
      //Conteggio il primo turno
      if (T1EU <> 'U') and Not TestAssenza(Ass1,NumTurno1) then
        if NumTurno1 = '1' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno1);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe1);
        end
        else if NumTurno1 = '2' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno2);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe2);
        end
        else if NumTurno1 = '3' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno3);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe3);
        end
        else if NumTurno1 = '4' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno4);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe4);
        end;
      //Conteggio il secondo turno eventualmente assegnato al dipendente nello stesso giorno
      if (T2EU <> 'U') and Not TestAssenza(Ass2,NumTurno2) then
        if NumTurno2 = '1' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno1);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe1);
        end
        else if NumTurno2 = '2' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno2);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe2);
        end
        else if NumTurno2 = '3' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno3);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe3);
        end
        else if NumTurno2 = '4' then
        begin
          inc(aTotaleTurni[Giorni.Count-1].Turno4);
          AddTurnoOperatore(Vista[i],aTotaleTurni[Giorni.Count-1].TotOpe4);
        end;
        TotaleTurniInd(i,Giorni.Count-1);
        ConteggiGiornalieri(Data,i,Giorni.Count - 1);
      end;
  end;
  //Fine aggiornamento dei totali dei turni
end;

procedure TA058FPianifTurniDtm1.TotaleTurniInd(IDVista,IDGiorno:Integer);
begin
  with Vista[IDVista].Giorni[IDGiorno] do
  begin
    //Conteggio il primo turno
    if (NumTurno1 = '1') and (T1EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno1)
    else if (NumTurno1 = '2') and (T1EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno2)
    else if (NumTurno1 = '3') and (T1EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno3)
    else if (NumTurno1 = '4') and (T1EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno4);
    //Conteggio il secondo turno eventualmente assegnato al dipendente nello stesso giorno
    if (NumTurno2 = '1') and (T2EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno1)
    else if (NumTurno2 = '2') and (T2EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno2)
    else if (NumTurno2 = '3') and (T2EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno3)
    else if (NumTurno2 = '4') and (T2EU <> 'U') and (Ass1 = '') then
      inc(Vista[IDVista].TotaleTurniMese.Turno4);
  end;
end;

procedure TA058FPianifTurniDtm1.DebitoDipendente(i,Dal,Al:Integer);
var
  j:Integer;
begin
  with Vista[i] do
  begin
    Debito:=0;
    Assegnato:=0;
    for j:=Dal to Al do
    begin
      inc(Debito,Giorni[j].Debito);
      inc(Assegnato,Giorni[j].Assegnato);
    end;
  end;
end;

procedure TA058FPianifTurniDtm1.GetDatiTurno(var Giorno:TGiorno);
var
  n:integer;
  FiltroT021:String;
begin
  with Giorno do
  begin
    SiglaT1:='';
    SiglaT2:='';
    NumTurno1:='';
    NumTurno2:='';
    FiltroT021:='(CODICE = ''' + Ora + ''')';
    FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Giorno.Data) + ' >= DECORRENZA)';
    FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(Giorno.Data) + ' <= DECORRENZA_FINE)';
    QT021.Filtered:=False;
    QT021.Filter:=FiltroT021;
    QT021.Filtered:=True;
    try
      if not R180In(T1.Trim,['','M']) then
        if T1.ToInteger > 0 then
        begin
          n:=1;
          QT021.First;
          if QT021.RecordCount >= T1.ToInteger then
          begin
            while n < T1.ToInteger do
            begin
              QT021.Next;
              inc(n);
            end;
            if Trim(QT021.FieldByName('SIGLATURNI').AsString) <> '' then
              SiglaT1:='(' + QT021.FieldByName('SIGLATURNI').AsString + ')';
            if Trim(QT021.FieldByName('NUMTURNO').AsString) <> '' then
              if (Trim(Giorno.T1EU) = '') or (Giorno.T1EU = 'E') then
                NumTurno1:=QT021.FieldByName('NUMTURNO').AsString;
            if (Trim(SiglaT1) = '') and (QT021.FieldByName('NUMTURNO').AsString <> '') then
              SiglaT1:='[' + QT021.FieldByName('NUMTURNO').AsString + ']';
          end;
        end
        else if T1.ToInteger = 0 then
          SiglaT1:='(R)';
    except
    end;
    try
      if not R180In(T2.Trim,['','M']) then
        if T2.ToInteger > 0 then
        begin
          n:=1;
          QT021.First;
          if QT021.RecordCount >= T2.ToInteger then
          begin
            while n < T2.ToInteger do
            begin
              QT021.Next;
              inc(n);
            end;
            if Trim(QT021.FieldByName('SIGLATURNI').AsString) <> '' then
              SiglaT2:='(' + QT021.FieldByName('SIGLATURNI').AsString + ')';
            if Trim(QT021.FieldByName('NUMTURNO').AsString) <> '' then
              if (Trim(Giorno.T2EU)='') or (Giorno.T2EU='E') then
                NumTurno2:=QT021.FieldByName('NUMTURNO').AsString;
            if (Trim(SiglaT2) = '') and (QT021.FieldByName('NUMTURNO').AsString <> '') then
              SiglaT2:='[' + QT021.FieldByName('NUMTURNO').AsString + ']';
          end;
        end
        else if T2.ToInteger = 0 then
          SiglaT2:='(R)';
    except
    end;
  end;
end;

function TA058FPianifTurniDtm1.GetTipoOpe(Prog:integer):string;
begin
  Q430.Close;
  Q430.SetVariable('PROGRESSIVO',Prog);
  Q430.SetVariable('DATA',DataFine);
  Q430.Open;
  if Q430.RecordCount = 0 then
    Result:=''
  else
    Result:='(' + Q430.FieldByName('TIPOOPE').asString + ')';
end;

procedure TA058FPianifTurniDtm1.CreaGiorno(Data:TDateTime; Posizione:LongInt);
{Crea un oggetto TGiorno associato al dipendente corrente}
var 
	Giorno:TGiorno;
  i:Integer;
  T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,AssOre:String;
  Ass1Modif,Ass2Modif:boolean;
  Inizio,Fine,D:TDateTime;
begin
  i:=Vista.Count - 1;
  with QSSquadra do
  begin
    if not LocDatoStorico(Data) then
      Flag:='NT'
    else
      if FieldByName('T430INIZIO').IsNull then
        Flag:='NT'
      else
      begin
        Inizio:=FieldByName('T430INIZIO').AsDateTime;
        if FieldByName('T430FINE').IsNull then
          Fine:=0
        else
          Fine:=FieldByName('T430FINE').AsDateTime;
        if Fine = 0 then Fine:=StrToDate('31/12/3999');
        if (Data >= Inizio) and (Data <= Fine) then
          GetPianificazione(Data,Vista[i].Prog,Posizione,T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,AssOre,Ass1Modif,Ass2Modif)
        else
          Flag:='NT';
      end;
    Giorno:=TGiorno.Create;
    //caricamento turno reperibilità
    //Giorno.TurnRep:=Trim(VarToStr(selT380.Lookup('DATA',Data,'TURNO1')));
    if (selT380.FieldByName('DATA').AsDateTime = Data) or selT380.SearchRecord('DATA',Data,[srFromCurrent]) then
    begin
      Giorno.TurnRep:=selT380.FieldByName('TURNO1').AsString;
      Giorno.OraInizioRep:=selT380.FieldByName('ORAINIZIO').AsString;
      Giorno.OraFineRep:=selT380.FieldByName('ORAFINE').AsString;
    end;
    Giorno.NTimbTurno:=0;
    //=====================================
    //RICERCA DELLA PIANIFICAZIONE CORRETTA
    //=====================================
    R180SetVariable(Q620,'PROGRESSIVO',Vista[i].Prog);
    Q620.Open;
    D:=Q620.FieldByName('DATA').AsDateTime;
    Q620.Last;
    while (Not Q620.Bof) and (Q620.FieldByName('DATA').AsDateTime > Data) do
      Q620.Prior;
    Giorno.VerTurni:=Q620.FieldByName('VERIFICA_TURNI').AsString;
    Giorno.VerRiposi:=Q620.FieldByName('VERIFICA_RIPOSI').AsString;
    Q620.SearchRecord('DATA',D,[srFromBeginning]);
    Giorno.Flag:=Flag;
    Giorno.Data:=Data;//Bruno 02/04/10
    Giorno.Modificato:=False;
    Giorno.T1:=Format('%2s',[T1]);
    Giorno.T2:=Format('%2s',[T2]);
    Giorno.ValorGior:=ValorGior;
    Giorno.Ora:=Ora;
    //Leggo la sigla del turno T1 e del turno T2
    GetDatiTurno(Giorno);
    Giorno.T1EU:=T1EU;
    Giorno.T2EU:=T2EU;
    Giorno.Ass1:=Ass1;
    Giorno.Ass2:=Ass2;
    Giorno.VAss:=VAss;
    Giorno.AssOre:=AssOre;
    Giorno.Ass1Modif:=Ass1Modif;
    Giorno.Ass2Modif:=Ass2Modif;
    Giorno.Squadra:=FieldByName('T430SQUADRA').AsString;
    Giorno.DSquadra:=FieldByName('T430D_SQUADRA').AsString;
    Giorno.Oper:=FieldByName('T430TIPOOPE').AsString;
    //======================================================
    //VALORIZZAZIONE VARIABILE VISTA X IL COTROLLO SUI TURNI
    //======================================================
    Vista[i].ConstMesRip:=0;
    Vista[i].ConstElabPeriodo:=4;
    Vista[i].ConstInd1:=0;
    Vista[i].ConstInd2:=0;
    Vista[i].ConstInd3:=0;
    Vista[i].ConstInd4:=0;
    if Trim(Giorno.Squadra) <> '' then
    begin
      Vista[i].CausRip:=VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'CAUS_RIPOSO'));
      Vista[i].ConstMesRip:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'MIN_FESTIVITA_MESE')),0);
      Vista[i].ConstElabPeriodo:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'PERIODO_MATUR_IND')),4);
      Vista[i].ConstInd1:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'MIN_IND1')),0);
      Vista[i].ConstInd2:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'MIN_IND2')),0);
      Vista[i].ConstInd3:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'MIN_IND3')),0);
      Vista[i].ConstInd4:=StrToIntDef(VarToStr(Q600.Lookup('CODICE',FieldByName('T430SQUADRA').AsString,'MIN_IND4')),0);
    end;
    if (Giorno.Ass1 <> '') and (Trim(Giorno.T1) = '') then
      Giorno.T1:=' A';

    //Lello 07/02/2005 inizio
    //Se è pianificato il turno ma manca l'orario lo ricerco nello storico
    if NuovaPianif and (Trim(Giorno.Ora) = '') and
       (((Trim(Giorno.T1) <> 'A') and (Trim(Giorno.T1) <> '')) or
        ((Trim(Giorno.T1) = 'A') and (selT082.FieldByName('PIANIF_GG_ASS').AsString = 'S'))) then
      Giorno.Ora:=GetOrarioStorico(Data,Vista[i].Prog);
    //Lello 07/02/2005 fine
    if NuovaPianif and (selT082.FieldByName('PIANIF_GG_ASS').AsString = 'N') and
       (Trim(Giorno.Ass1) <> '') and (not Giorno.Ass1Modif) then
    begin
      Giorno.Ora:='';
      Giorno.T1:=' A';
    end;
    if (not NuovaPianif) and (Trim(Giorno.T1) = '') then
      if Giorno.Ora <> '' then
        Giorno.T1:=' M';
    Giorno.Modificato:=False;
    Vista[i].Giorni.Add(Giorno);
    Giorno:=TGiorno.Create;
    Vista[i].GiorniOld.Add(Giorno);
    //Aggiornamento dei totali dei turni
    AggiornaTotaleTurni(i);
  end;
end;

procedure TA058FPianifTurniDtm1.GetAssegnazioneTurnazione(Progressivo:Integer;Data:TDate);
begin
  R180SetVariable(Q620,'PROGRESSIVO',Progressivo);
  Q620.Open;
  Q620.Last;
  while (Not Q620.Bof) and (Q620.FieldByName('DATA').AsDateTime > Data) do
    Q620.Prior;
end;

procedure TA058FPianifTurniDtm1.CalcolaRiposiFestivi;
var
  Dipendente:TDipendente;
begin
  for Dipendente in Vista do
  begin
    with selRiposi do
    begin
      Close;
      SetVariable('PROGRESSIVO',Dipendente.Prog);
      if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 1,1,1));
        SetVariable('DATA2',DataInizio - 1);
      end
      else
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio),1,1));
        SetVariable('DATA2',DataInizio - 1);
      end;
      Open;
      Dipendente.RiposiPrec:=FieldByName('NUM').AsInteger;
      Close;
    end;
    with selFestLav do
    begin
      //Festività lavorate da inizio anno a fine mese precedente
      Close;
      SetVariable('PROGRESSIVO',Dipendente.Prog);
      if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 1,1,1));
        SetVariable('DATA2',DataInizio - 1);
      end
      else
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio),1,1));
        SetVariable('DATA2',DataInizio - 1);
      end;
      Open;
      Dipendente.FestiviLavMesePrec:=FieldByName('NUM').AsInteger;
      Close;
      //Festività lavorate anno precedente
      SetVariable('PROGRESSIVO',Dipendente.Prog);
      if (R180Mese(DataInizio) = 1) and (R180Giorno(DataInizio) = 1) then
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 2,1,1));
        SetVariable('DATA2',EncodeDate(R180Anno(DataInizio) - 2,12,31));
      end
      else
      begin
        SetVariable('DATA1',EncodeDate(R180Anno(DataInizio) - 1,1,1));
        SetVariable('DATA2',EncodeDate(R180Anno(DataInizio) - 1,12,31));
      end;
      Open;
      Dipendente.FestiviLavAnnoPrec:=FieldByName('NUM').AsInteger;
      Close;
    end;
  end;
end;

procedure TA058FPianifTurniDtm1.CreaDipendente(Prog,Badge:LongInt;Matricola,Cognome,Nome:String);
{Crea un oggetto TDipendente associato alla lista Vista}
var
  Dipendente:TDipendente;
begin
  Dipendente:=TDipendente.Create;
  Dipendente.Prog:=Prog;
  Dipendente.Badge:=Badge;
  Dipendente.Cognome:=Cognome;
  Dipendente.Nome:=Nome;
  Dipendente.Matricola:=Matricola;
  //Leggo il profilo del dipendente
  Dipendente.TipoOpe:=GetTipoOpe(Prog);
  Dipendente.Giorni:=TList<TGiorno>.Create;
  Dipendente.GiorniOld:=TList<TGiorno>.Create;
  Dipendente.TotaleTurniMese.Turno1:=0;
  Dipendente.TotaleTurniMese.Turno2:=0;
  Dipendente.TotaleTurniMese.Turno3:=0;
  Dipendente.TotaleTurniMese.Turno4:=0;
  Dipendente.RiposiPrec:=0;
  Dipendente.FestiviLavMesePrec:=0;
  Dipendente.FestiviLavAnnoPrec:=0;
  GetAssegnazioneTurnazione(Prog,DataInizio);
  Dipendente.TurnoPartenza:=Q620.FieldByName('PARTENZA').AsInteger;

  Vista.Add(Dipendente);
end;

procedure TA058FPianifTurniDtm1.LeggiPianificazione(Prog:LongInt;DataIniElab,DataFinElab:TDateTime; CreaPianif:Boolean = True);
{Creo Vista leggendo le pianificazioni e i giustificativi già esistenti}
var DataCorr:TDateTime;
    QP,QG,T040:TOracleDataSet;
begin
    T040:=nil;
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
    begin
      QP:=Q080Gest;
      QG:=Q040Gest;
    end
    else
    begin
      QP:=Q081Gest;
      QG:=Q041Gest;
      if AssenzeOperative then
        QG:=Q040Gest
      else
        T040:=Q040Gest;
    end;
    //Lettura turni reperibilità
    selT380.Close;
    selT380.SetVariable('PROGRESSIVO',Prog);
    selT380.SetVariable('DATADA',DataInizio);
    selT380.SetVariable('DATAA',DataFine);
    selT380.Open;
    //Leggo le assenze giornaliere
    if CreaPianif then
      with QG do
      begin
        Close;
        ClearVariables;
        SetVariable('Progressivo',Prog);
        SetVariable('Data1',DataIniElab);
        SetVariable('Data2',DataFinElab);
        //Andrea
        if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and not AssenzeOperative then
        begin
          if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
          //PIANIFICAZIONE PROGRESSIVA
          begin
            if TipoPianif = 0 then //Iniziale
              SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
            else if TipoPianif = 1 then //Corrente
              SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
          end
          else
            SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
        end;
        Open;
      end;

    //Leggo le pianificazioni manuali (FlagAgg <> 'P')
    with QP do
    begin
      Close;
      ClearVariables;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataIniElab);
      SetVariable('Data2',DataFinElab);
      //Andrea
      if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
      begin
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        //PIANIFICAZIONE PROGRESSIVA
        begin
          if TipoPianif = 0 then //Iniziale
            SetVariable('FlagAgg',' AND FLAGAGG = ''I''')
          else if TipoPianif = 1 then //Corrente
            SetVariable('FlagAgg',' AND FLAGAGG = ''C''');
        end
        else
          SetVariable('FlagAgg',' AND FLAGAGG = ''N''');
      end;
      Open;
    end;

    if not CreaPianif then
      exit;
    with SelAnagrafeA058 do
      CreaDipendente(FieldByName('Progressivo').AsInteger,FieldByName('T430Badge').AsInteger,
                     FieldByName('Matricola').AsString,FieldByName('Cognome').AsString,FieldByName('Nome').AsString);
    //Leggo i giustificativi inseriti in t040 che devono essere visualizzati, ma non modificabili
    //eliminato--> //Solo se la pianificazione è diversa da INIZIALE
    //sostituito con: se la pianificazione è iniziale, leggo quello che trovo in T040 con scheda <> 'P'
    //e cioè tutte le assenze che sono state inserite dalla maschera di gestione dei giustificativi, ma NON dalla pianificazione
    if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and not AssenzeOperative then //and (RgpTipo.ItemIndex <> 0) then
    begin
      with T040 do
      begin
        Close;
        ClearVariables;
        SetVariable('Progressivo',Prog);
        SetVariable('Data1',DataIniElab);
        SetVariable('Data2',DataFinElab);
        SetVariable('SCHEDA', ' and ((SCHEDA <> ''P'') or SCHEDA is null)');
        Open;
      end;
    end;

    QSSquadra.GetDatiStorici('T430SQUADRA,T430D_SQUADRA,T430CALENDARIO,T430TIPOOPE,T430INIZIO,T430FINE',Prog,DataIniElab,DataFinElab);

    DataCorr:=DataIniElab;
    while DataCorr <= DataFinElab do
    begin
      CreaGiorno(DataCorr,0);
      //Incremento data corrente
      DataCorr:=DataCorr + 1;
    end;
end;

procedure TA058FPianifTurniDtM1.CreaTabStampaAss;
begin
  T058Stampa.Close;
  //Creo la tabella di appoggio T058Stampa
  with T058Stampa.FieldDefs do
  begin
    Clear;
    Add('Matricola',ftString,10,False);
    Add('Data',ftDate);
    Add('Cognome',ftString,25,False);
    Add('Nome',ftString,25,False);
    Add('Causale',ftString,40,False);
  end;
  T058Stampa.CreateDataSet;
  T058Stampa.LogChanges:=False;
  T058Stampa.Open;
end;

procedure TA058FPianifTurniDtM1.CaricaTabStampaAss;
begin
  selT040.Close;
  selT040.SetVariable('DATADA',DataInizio);
  selT040.SetVariable('DATAA',DataFine);
  SelAnagrafeA058.First;
  while Not SelAnagrafeA058.Eof do
  begin
    selT040.Close;
    selT040.SetVariable('PROG',SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger);
    selT040.Open;
    while Not selT040.Eof do
    begin
      T058Stampa.Append;
      if selT040.Bof then
      begin
        T058Stampa.FieldByName('MATRICOLA').AsString:=selT040.FieldByName('MATRICOLA').AsString;
        T058Stampa.FieldByName('COGNOME').AsString:=selT040.FieldByName('COGNOME').AsString;
        T058Stampa.FieldByName('NOME').AsString:=selT040.FieldByName('NOME').AsString;
      end;
      T058Stampa.FieldByName('DATA').AsDateTime:=selT040.FieldByName('DATA').AsDateTime;
      T058Stampa.FieldByName('CAUSALE').AsString:=selT040.FieldByName('CAUSALE').AsString;
      T058Stampa.Post;
      selT040.Next;
    end;
    SelAnagrafeA058.Next;
  end;
end;

procedure TA058FPianifTurniDtM1.RefreshAssenze(DataDa,DataA:TDateTime);
var i,j,h:Integer;
    S:String;
    DataScorr:TDateTime;
begin
  Q040.SetVariable('DATA1',DataDa);
  Q040.SetVariable('DATA2',DataA);
  for i:=0 to Vista.Count - 1 do
  begin
    Q040.Close;
    Q040.SetVariable('PROGRESSIVO',Vista[i].Prog);
    Q040.Open;
    DataScorr:=DataDa;
    j:=Trunc(DataScorr - DataInizio);
    {$IFNDEF IRISWEB}
    A058FGrigliaPianif.GVista.RowHeights[i + A058FGrigliaPianif.nRigheBloccate]:=A058FGrigliaPianif.GVista.DefaultRowHeight;
    {$ENDIF}
    while DataScorr <= DataA do
    begin
      Vista[i].Giorni[j].Ass1:='';
      Vista[i].Giorni[j].Ass2:='';
      Vista[i].Giorni[j].VAss:='';
      Vista[i].Giorni[j].AssOre:='';
      if Q040.Locate('DATA',DataScorr,[]) then
        while not Q040.Eof do
        begin
          //Assenze a giorni
          if Q040.FieldByName('DATA').AsDateTime <> DataScorr then
            Break;
          if Q040.FieldByName('TIPOGIUST').AsString = 'I' then
          begin
            if Vista[i].Giorni[j].Ass1 = '' then
            begin
              Vista[i].Giorni[j].Ass1:=Q040.FieldByName('CAUSALE').AsString;
              Vista[i].Giorni[j].VAss:=Q040.FieldByName('VALIDAZIONE').AsString;
            end
            else
            begin
              Vista[i].Giorni[j].Ass2:=Q040.FieldByName('CAUSALE').AsString;
              if Vista[i].Giorni[j].VAss = '' then
                Vista[i].Giorni[j].VAss:=Q040.FieldByName('VALIDAZIONE').AsString;
            end
          end
          else
          begin
            //Assenze a ore/mezze giornate
            S:=Q040.FieldByName('Causale').AsString;
            if Q040.FieldByName('TipoGiust').AsString = 'M' then
              S:=S + '(1/2)'
            else if Q040.FieldByName('TipoGiust').AsString = 'D' then
              S:=S + Format('(%s-%s)',[FormatDateTime('hh.nn',Q040.FieldByName('DAORE').AsDateTime),FormatDateTime('hh.nn',Q040.FieldByName('AORE').AsDateTime)])
            else if Q040.FieldByName('TipoGiust').AsString = 'N' then
              S:=S + Format('(%s)',[FormatDateTime('hh.nn',Q040.FieldByName('DAORE').AsDateTime)]);
            Vista[i].Giorni[j].VAss:=Q040.FieldByName('VALIDAZIONE').AsString;
            if Vista[i].Giorni[j].AssOre <> '' then
              Vista[i].Giorni[j].AssOre:=Vista[i].Giorni[j].AssOre + #13;
            Vista[i].Giorni[j].AssOre:=Vista[i].Giorni[j].AssOre + S;
            {$IFNDEF IRISWEB}
            if Vista[i].Giorni[j].AssOre <> '' then
              with A058FGrigliaPianif do
              begin
                h:=Trunc(GVista.DefaultRowHeight*((3 + NumRighe(Vista[i].Giorni[j].AssOre)) / 3));
                if h > GVista.RowHeights[i + nRigheBloccate] then
                  GVista.RowHeights[i + nRigheBloccate]:=h;
              end;
            {$ENDIF}
          end;
          Q040.Next;
        end;
      inc(j);
      DataScorr:=DataScorr + 1;
    end;
  end;
end;

procedure TA058FPianifTurniDtM1.RefreshQ021(D:TDateTime);
begin
  if Q021.GetVariable('DECORRENZA') <> D then
  begin
    Q021.SetVariable('DECORRENZA',D);
    Q021.Close;
  end;
  Q021.Open;
end;

//Alberto (Pescara)
procedure TA058FPianifTurniDtM1.ConteggiGiornalieri(Data:TDateTime; IDip,IGiorno:Integer);
var
  PNE, PNU, i:integer;
  ConteggioNorm:Boolean;
begin
  if not ConteggiaDebito then
    exit;
  ConteggioNorm:=True;
  if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and
     (Parametri.CampiRiferimento.C11_PianifOrariProg <> 'S') and
     (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') and
     AssenzeOperative then
    ConteggioNorm:=False;

  R502ProDtM.PianificazioneEsterna.Progressivo:=Vista[IDip].Prog;
  R502ProDtM.PianificazioneEsterna.Data:=Data;
  R502ProDtM.PianificazioneEsterna.l08_Orario:=Vista[IDip].Giorni[IGiorno].Ora;

  R502ProDtM.PianificazioneEsterna.l08_turno1:=StrToIntDef(Vista[IDip].Giorni[IGiorno].T1,-1);
  if R502ProDtM.PianificazioneEsterna.l08_turno1 = 0 then
    R502ProDtM.PianificazioneEsterna.l08_turno2:=0
  else
    R502ProDtM.PianificazioneEsterna.l08_turno2:=StrToIntDef(Vista[IDip].Giorni[IGiorno].T2,-1);
  {if (TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).Ass1 = '') or
     (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
    R502ProDtM.PianificazioneEsterna.l08_turno1:=StrToIntDef(TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).T1,-1)
  else
    R502ProDtM.PianificazioneEsterna.l08_turno1:=0;

  if ((R502ProDtM.PianificazioneEsterna.l08_turno1 <> 0) and
     (TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).Ass1 = '')) or
     (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
    R502ProDtM.PianificazioneEsterna.l08_turno2:=StrToIntDef(TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).T2,-1)
  else
    R502ProDtM.PianificazioneEsterna.l08_turno2:=0;}

  if (not ConteggioNorm) and (R502ProDtM.PianificazioneEsterna.l08_turno1 = 0) and
     ((Vista[IDip].Giorni[IGiorno].Ass1 <> '') or (Vista[IDip].Giorni[IGiorno].Ass2 <> '')) then
       R502ProDtM.PianificazioneEsterna.l08_turno1:=-1;

  R502ProDtM.PianificazioneEsterna.l08_turno1EU:=Vista[IDip].Giorni[IGiorno].T1EU;
  R502ProDtM.PianificazioneEsterna.l08_turno2EU:=Vista[IDip].Giorni[IGiorno].T2EU;
  R502ProDtM.Conteggi('Cartolina',Vista[IDip].Prog,Data);
  Vista[IDip].Giorni[IGiorno].Debito:=R502ProDtM.debitocl;
  Vista[IDip].Giorni[IGiorno].Assegnato:=0;
  if (((Vista[IDip].Giorni[IGiorno].Ass1 = '') and (Vista[IDip].Giorni[IGiorno].Ass2 = '')) or ConteggioNorm) and
     R502ProDtM.cdsT020.Active then
  begin
    if (R502ProDtM.PianificazioneEsterna.l08_turno1 > 0) then
    begin
      //Fraz.debito con turno notturno in E
      if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno1EU = 'E') then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            1440 - R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Fraz.debito con turno notturno in U
      else if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno1EU = 'U') then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Turno normale
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'MODELLO ORARIO') then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1])
      //Differenza fra uscita ed entrata
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
      begin
        PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1];
        PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno1];
        if PNE >= PNU then
        begin
          PNE:=1440 - PNE;
          if Vista[IDip].Giorni[IGiorno].T1EU = 'E' then
            PNU:=0;
          if Vista[IDip].Giorni[IGiorno].T1EU = 'U' then
            PNE:=0;
          inc(Vista[IDip].Giorni[IGiorno].Assegnato,PNU + PNE);
        end
        else
          inc(Vista[IDip].Giorni[IGiorno].Assegnato,PNU - PNE);
      end;
    end;
    if (R502ProDtM.PianificazioneEsterna.l08_turno2 > 0) then
    begin
      //Fraz.debito con turno notturno in E
      if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno2EU = 'E') then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            1440 - R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Fraz.debito con turno notturno in U
      else if (R502ProDtM.cdsT020.FieldByName('FrazDeb').AsString = 'S') and (R502ProDtM.PianificazioneEsterna.l08_turno2EU = 'U') then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Turno normale
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'MODELLO ORARIO')  then
        inc(Vista[IDip].Giorni[IGiorno].Assegnato,
            R502ProDtM.ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2])
      //Differenza fra uscita ed entrata
      else if (Parametri.CampiRiferimento.C11_PianifOrari_DebGG = 'PUNTI NOMINALI') then
      begin
        PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2];
        PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,R502ProDtM.PianificazioneEsterna.l08_turno2];
        if PNE >= PNU then
        begin
          PNE:=1440 - PNE;
          if Vista[IDip].Giorni[IGiorno].T2EU = 'E' then
            PNU:=0;
          if Vista[IDip].Giorni[IGiorno].T2EU = 'U' then
            PNE:=0;
          inc(Vista[IDip].Giorni[IGiorno].Assegnato,PNU + PNE);
        end
        else
          inc(Vista[IDip].Giorni[IGiorno].Assegnato,PNU - PNE);
      end;
    end
    else if (not ConteggioNorm) and (VarToStr(Q020.Lookup('CODICE',Vista[IDip].Giorni[IGiorno].Ora,'TIPOORA')) <> 'E') then
    begin
      //Conteggi da punti nominali e modello orario NON a turni
      PNE:=R502ProDtM.ValNumT021['ENTRATAMM',TF_PUNTI_NOMINALI,1];
      PNU:=R502ProDtM.ValNumT021['USCITAMM',TF_PUNTI_NOMINALI,1];
      inc(Vista[IDip].Giorni[IGiorno].Assegnato,max(0,PNU - PNE));
    end;
  end
  else if (Not ConteggioNorm) and ((Vista[IDip].Giorni[IGiorno].Ass1 <> '') or
          (Vista[IDip].Giorni[IGiorno].Ass2 <> '')) then
  begin
    //Se nel giorno è presente anche un solo giustificativo d'assenza annullo il debito.
    i:=1;
    while (i < R502ProDtM.n_riepasse) and (R502ProDtM.triepgiusasse[i].traggasse <> 'H') do
      inc(i);
    if R502ProDtM.triepgiusasse[i].traggasse <> 'H' then
      inc(Vista[IDip].Giorni[IGiorno].Assegnato,IfThen(R502ProDtM.Blocca = 0,R502ProDtM.debitogg,0));
  end;
  {Bruno(19/11/2012) - MILANO_HSACCO}
  if (Vista[IDip].Giorni[IGiorno].Assegnato = 0) and ConteggioNorm then
    if (not ((VarToStr(Q020.Lookup('CODICE',Vista[IDip].Giorni[IGiorno].Ora,'TIPOORA')) = 'E') and
       (R502ProDtM.PianificazioneEsterna.l08_turno1 = 0))) then
      inc(Vista[IDip].Giorni[IGiorno].Assegnato,IfThen(R502ProDtM.Blocca = 0,R502ProDtM.debitogg,0));
  {if (TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).Assegnato = 0) and ConteggioNorm then
    TGiorno(TDipendente(Vista[IDip]).Giorni[IGiorno]).Assegnato:=IfThen(R502ProDtM.Blocca = 0,R502ProDtM.debitogg,0);}
end;

function TA058FPianifTurniDtM1.GetPartenza(Prog:LongInt; var Posizione:LongInt):Boolean;
{Leggo dalle turnazioni individuali la data che più si avvicina alla data di partenza}
var 
  DataRif:TDateTime;
  OffSet:Integer;
begin
  Result:=False;
  TurnazioneOld:='';
  GetAssegnazioneTurnazione(Prog,DataInizio);
  with Q620 do
  begin
    if RecordCount = 0 then
      exit;
    DataRif:=FieldByName('Data').AsDateTime;
    Offset:=IfThen(DataRif <= DataInizio,1,-1);
    //Mi posiziono sulla data scelta
  end;
  Result:=True;
  //Leggo tutti gli spostamenti occasionali
  with Q630 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data1',DataInizio);
    SetVariable('Data2',DataFine);
    Open;
  end;
  if (selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or AssenzeOperative then
  //Leggo giustif. e pianificazioni manuali solo se lavoro in modalità operativa
  //o se la gestione assenze è operativa
  begin
    //Leggo le assenze giornaliere
    with Q040 do
    begin
      Close;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      Open;
    end;
    //Leggo le pianificazioni manuali (FlagAgg <> 'P')
    with Q080 do
    begin
      Close;
      SetVariable('Progressivo',Prog);
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      Open;
    end;
  end;
  GetTurnazione(Posizione);
  //Se Posizione = 0: Nessun turno:non pianifico ma devo tener conto di
  //altre Turnazioni Individuali successive
  if Posizione = 0 then
    exit;
  //Ricerco il giorno di partenza effettivo spostandomi dalla data di riferimento
  //alla data di inizio pianificazione
  while DataRif <> DataInizio do
  begin
    DataRif:=DataRif + Offset;
    Posizione:=Posizione + Offset;
    if Posizione >= Turno1.Count then
      Posizione:=1;
    if Posizione <=0 then
      Posizione:=Turno1.Count - 1;
  end;
end;

procedure TA058FPianifTurniDtM1.GetTurnazione(var Posizione:LongInt);
{Sviluppa il ciclo specificato dalla turnazione individuale e la posizione di partenza}
begin
  with Q620 do
  begin
    Posizione:=FieldByName('Partenza').AsInteger;
    if Posizione > 0 then
    begin
      if TurnazioneOld <> FieldByName('Turnazione').AsString then
      begin
        //Sviluppo il ciclo nelle Liste Turno1,Turno2,Orario,Causale
        SviluppoTurnazione(FieldByName('Turnazione').AsString,ListaCicli);
        SviluppoCicli(ListaCicli,Turno1,Turno2,Orario,Causale);
        //Disallineamento tra Partenza e numero reale di Giorni di ciclicità:
        //esco senza pianificare
        TurnazioneOld:=FieldByName('Turnazione').AsString;
      end;
      if Posizione > Turno1.Count - 1 then
        Posizione:=0;
    end;
    Next;
    //Imposto data di Turnaz.Successiva
    if Eof then
      TurnazSucc:=EncodeDate(3999,12,31)
    else
      TurnazSucc:=FieldByName('Data').AsDateTime;
  end;
end;

procedure TA058FPianifTurniDtM1.SviluppoTurnazione(Turnazione:String; Lista:TStringList);
var i,j:Integer;
begin
  //Carico la sequenza dei cicli in ListaCicli
  Lista.Clear;
  with Q641 do
  begin
    Close;
    SetVariable('Turnazione',Turnazione);
    Open;
    while not Eof do
    begin
      for i:=1 to FieldByName('Multiplo').AsInteger do
        //Carico i cicli n volte quanto specificato da MULTIPLO
        for j:=0 to 4 do
          //Carico i Cicli validi
          if Trim(Fields[j].AsString) <> '' then
            Lista.Add(Fields[j].AsString);
      Next;
    end;
  end;
end;

procedure TA058FPianifTurniDtM1.SviluppoCicli(Lista,Turno1,Turno2,Orario,Causale:TStringList);
{Sviluppo i cicli ottenuti dalla turnazione}
var i:Integer;
    CicloOld:String;
begin
  CicloOld:='';
  Turno1.Clear;
  Turno2.Clear;
  Orario.Clear;
  Causale.Clear;
  Turno1.Add('NT');
  Turno2.Add('');
  Orario.Add('');
  Causale.Add('');
  for i:=0 to Lista.Count - 1 do
    //Scorro i cicli otenuti dalla turnazione
    with Q611 do
    begin
      if CicloOld <> Lista[i] then
      //Aggiorno la query dei cicli giornalieri se è cambiato il codice
      begin
        Close;
        SetVariable('Ciclo',Lista[i]);
        Open;
        CicloOld:=Lista[i];
      end;
      First;
      while not Eof do
      begin
        Turno1.Add(Format('%2s',[FieldByName('Turno1').AsString]) + FieldByName('Turno1EU').AsString);
        Turno2.Add(Format('%2s',[FieldByName('Turno2').AsString]) + FieldByName('Turno2EU').AsString);
        Orario.Add(FieldByName('Orario').AsString);
        Causale.Add(FieldByName('Causale').AsString);
        Next;
      end;
    end;
end;

procedure TA058FPianifTurniDtM1.GetPianificazione(Data:TDateTime; Prog,Posizione:LongInt; var T1,T2,T1EU,T2EU,Ora,Ass1,Ass2,ValorGior,Flag,VAss,AssOre:String; var Ass1Modif,Ass2Modif:boolean);
{Legge l'eventuale spostamento di squadra e la pianificazione del giorno}
var QP,QG,T040:TOracleDataSet;
    S:String;
begin
  Ass1:='';
  Ass2:='';
  VAss:='';
  AssOre:='';
  Ass1Modif:=True;
  Ass2Modif:=True;
  T040:=nil;
  if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
  //Leggo giustif, e pianificazioni effettivi
  begin
    if NuovaPianif then
    begin
      QP:=Q080;
      QG:=Q040;
    end
    else
    begin
      QP:=Q080Gest;
      QG:=Q040Gest;
    end;
  end
  else
  //Leggo giustif, e pianificazioni provvisori
  begin
    QP:=Q081Gest;
    QG:=Q041Gest;
    if AssenzeOperative then
      if NuovaPianif then
        QG:=Q040
      else
        QG:=Q040Gest
    else
      T040:=Q040Gest;
  end;
  if (not NuovaPianif) or (selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or AssenzeOperative then
  //Leggo Giustificativi e Causali quando:
  // - sto leggendo pianificazioni esistenti (NuovaPianif = False)
  // - sto pianificando in modalità operativa
  begin
    //T040 serve solo in modalità non operativa
    if T040 <> nil then
    begin
      if T040.Locate('Data',Data,[]) then
      //Carico i giustificativi in Ass1 e Ass2
        while not T040.Eof do
        begin
          if T040.FieldByName('Data').AsDateTime <> Data then Break;
          //In modalità non operativa considero solo giustificativi a gg.intera
          if T040.FieldByName('TIPOGIUST').AsString = 'I' then
          begin
            //if Ass1 = '' then
            if (Ass1 = '') and (T040.FieldByName('PROGRCAUSALE').AsInteger<=99) then
            begin
              //if T040.FieldByName('SCHEDA').AsString <> 'V' then
                VAss:=T040.FieldByName('VALIDAZIONE').AsString;
              Ass1:=T040.FieldByName('Causale').AsString;
              if T040.FieldByName('Scheda').AsString <> 'P' then
                Ass1Modif:=False;
            end
            //else
            else if (Ass2 = '') and (T040.FieldByName('PROGRCAUSALE').AsInteger <> 99) then
            begin
              if (VAss <> 'S') (*and (T040.FieldByName('SCHEDA').AsString <> 'V')*) then
                VAss:=T040.FieldByName('VALIDAZIONE').AsString;
              Ass2:=T040.FieldByName('Causale').AsString;
              if T040.FieldByName('Scheda').AsString <> 'P' then
                Ass2Modif:=False;
            end;
          end;
          T040.Next;
        end;
    end;

    if QG.Locate('Data',Data,[]) then
    //Carico i giustificativi in Ass1 e Ass2
      while not QG.Eof do
      begin
        if QG.FieldByName('Data').AsDateTime <> Data then Break;
        if (QG = Q041Gest) or (QG.FieldByName('TIPOGIUST').AsString = 'I') then
        begin
          //if Ass1 = '' then
          if (Ass1 = '') and (QG.FieldByName('PROGRCAUSALE').AsInteger <= 99) then
          begin
            if (QG <> Q041Gest) (*and (QG.FieldByName('SCHEDA').AsString <> 'V')*) then
              VAss:=QG.FieldByName('VALIDAZIONE').AsString;
            Ass1:=QG.FieldByName('Causale').AsString;
            if QG <> Q041Gest then
              if QG.FieldByName('Scheda').AsString <> 'P' then
                Ass1Modif:=False;
          end
          //else
          else if (Ass2 = '') and (QG.FieldByName('PROGRCAUSALE').AsInteger <> 99) then
          begin
            if (VAss <> 'S') and  (QG <> Q041Gest) (*and (QG.FieldByName('SCHEDA').AsString <> 'V')*) then
              VAss:=QG.FieldByName('VALIDAZIONE').AsString;
            Ass2:=QG.FieldByName('Causale').AsString;
            if QG <> Q041Gest then
              if QG.FieldByName('Scheda').AsString <> 'P' then
                Ass2Modif:=False;
          end;
        end
        else
        //Alberto: assenze ad ore/mezza giornata
        begin
          S:=QG.FieldByName('Causale').AsString;
          if QG.FieldByName('TipoGiust').AsString = 'M' then
            S:=S + '(1/2)'
          else if QG.FieldByName('TipoGiust').AsString = 'D' then
            S:=S + Format('(%s-%s)',[FormatDateTime('hh.nn',QG.FieldByName('DAORE').AsDateTime),FormatDateTime('hh.nn',QG.FieldByName('AORE').AsDateTime)])
          else if QG.FieldByName('TipoGiust').AsString = 'N' then
            S:=S + Format('(%s)',[FormatDateTime('hh.nn',QG.FieldByName('DAORE').AsDateTime)]);
          if (VAss <> 'S') and  (QG <> Q041Gest) then
            VAss:=QG.FieldByName('VALIDAZIONE').AsString;
          if AssOre <> '' then
            AssOre:=AssOre + #13;
          AssOre:=AssOre + S;
        end;
        QG.Next;
      end;
    if QP.Locate('Data',Data,[]) then
    //Pianificazione manuale esistente
    begin
      Ora:=QP.FieldByName('Orario').AsString;
      T1:=QP.FieldByName('Turno1').AsString;
      T2:=QP.FieldByName('Turno2').AsString;
      T1EU:=QP.FieldByName('Turno1EU').AsString;
      T2EU:=QP.FieldByName('Turno2EU').AsString;
      if (QP = Q080) or (QP = Q080Gest) then
        ValorGior:=QP.FieldByName('ValorGior').AsString;
      Flag:='M';
      exit;
    end;

  end;
  if NuovaPianif then
    //Leggo lo sviluppo della turnazione solo se sto generando una Nuova Turnazione
    begin
    if Posizione = 0 then
      //Non pianifico
    begin
      Flag:='NT';
      exit;
    end;
    if selT082.FieldByName('PIANIF_GG_FEST').AsString = 'N' then
      //Se non si pianificano i giorni festivi controllo i calendari
      if GetTipoGiorno(Data,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString) = 'FESTIVO' then
      begin
        Flag:='NT';
        exit;
      end;
    //Se si pianifica solamente con Tipo Gestione = turnista, controllo il Tipo Gestione del dipendente
    if (selT082.FieldByName('PIANIF_SOLO_TURN').AsString = 'S') and (QSSquadra.FieldByName('T430TGESTIONE').AsString = '0') then
    begin
      Flag:='NT';
      exit;
    end;
    if not VarToStr(selT620.Lookup('PROGRESSIVO',Prog,'PROGRESSIVO')).IsEmpty then
    begin
      if (GetTipoGiorno(Data,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString,True) = 'FESTIVO') or
         (GetTipoGiorno(Data,Prog,QSSquadra.FieldByName('T430CALENDARIO').AsString,True) = 'NONLAV') then
      begin
        Flag:='NT';
        Exit;
      end;
    end;

    if Q630.Locate('Data',Data,[]) then
    //Spostamento occasionale di squadra
    begin
      Ora:=Q630.FieldByName('Orario').AsString;
      T1:=Q630.FieldByName('Turno1').AsString;
      T2:=Q630.FieldByName('Turno2').AsString;
      T1EU:='';
      T2EU:='';
      Flag:='CS';
      exit;
    end;
    //Dati da sviluppo turnazione
    Flag:='O';
    T1:=Copy(Turno1[Posizione],1,2);
    T2:=Copy(Turno2[Posizione],1,2);
    T1EU:=Copy(Turno1[Posizione],3,1);
    T2EU:=Copy(Turno2[Posizione],3,1);
    Ora:=Orario[Posizione];
    ValorGior:='';
    if Ass1 = '' then
      Ass1:=Causale[Posizione]
    else if (Ass1 <> Causale[Posizione]) and (Ass2 = '') then
      Ass2:=Causale[Posizione];
    if ((Trim(T1) <> '') or (Trim(T2) <> '')) and (Trim(Ora)  = '') then
      //Sono definiti i turni ma non l'orario
    begin
      if Trim(T1) = 'A' then
        exit;
      Ora:=GetOrarioStorico(Data,Prog);
    end;
  end
  else
    //Giorno senza pianificazione
    Flag:='NT';
end;

function TA058FPianifTurniDtM1.GetOrarioStorico(Data:TDateTime; Prog:LongInt):String;
{Leggo l'orario sul profilo da anagrafico}
var G:String;
begin
 Result:='';
  with Q430 do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    Open;
    if RecordCount = 0 then
      exit;
    if Trim(FieldByName('POrario').AsString) = '' then
      exit;
  end;
  with Q221 do
  begin
    Close;
    SetVariable('Codice',Q430.FieldByName('POrario').AsString);
    SetVariable('Data',Data);
    Open;
    if RecordCount = 0 then
      exit;
    //Leggo il nome del giorno da cui prendere l'orario sul profilo (Lu..Do,NonLav,Fest
    G:=GetTipoGiorno(Data,Prog,Q430.FieldByName('CALENDARIO').AsString);
    if G <> '' then
      Result:=FieldByName(G).AsString;
  end;
end;

function TA058FPianifTurniDtM1.GetTipoGiorno(Data:TDateTime; Prog:LongInt; Calendario:String; DomNonLav:Boolean = False):String;
{Leggo il tipo giorno da calendario individuale o normale
 DomNonLav = Considera la domenica come giorno non lavorativo}
const GIORNI : array[1..9] of String =
               ('LUNEDI','MARTEDI','MERCOLEDI','GIOVEDI','VENERDI',
                'SABATO','DOMENICA','NONLAV','FESTIVO');
begin
  Result:='';
  //Leggo calendario individuale
  with Q012 do
    begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      begin
      Result:=GIORNI[DayOfWeek(Data - 1)];
      if (FieldByName('Lavorativo').AsString = 'N') and ((DayOfWeek(Data - 1) <> 7) or DomNonLav) then
        Result:=GIORNI[8];
      if FieldByName('Festivo').AsString = 'S' then
        Result:=GIORNI[9];
      exit;
      end;
    end;
  //Leggo calendario da anagrafico
  with Q011 do
    begin
    Close;
    SetVariable('Codice',Calendario);
    SetVariable('Data',Data);
    Open;
    if RecordCount > 0 then
      begin
      Result:=GIORNI[DayOfWeek(Data - 1)];
      if (FieldByName('Lavorativo').AsString = 'N') and ((DayOfWeek(Data - 1) <> 7) or DomNonLav)then
        Result:=GIORNI[8];
      if FieldByName('Festivo').AsString = 'S' then
        Result:=GIORNI[9];
      end;
    end;
end;

procedure TA058FPianifTurniDtM1.A058FPianifTurniDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(PckTurno);
  selDatiBloccatiA058.Free;
  QSSquadra.Free;
  ListaCicli.Free;
  Turno1.Free;
  Turno2.Free;
  Orario.Free;
  Causale.Free;
  xValoreOrigine.Free;
  PulisciVista;
  Vista.Free;
  FreeAndNil(R502ProDtM);
end;

procedure TA058FPianifTurniDtM1.SelAnagrafeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  try
    Accept:=(DataSet.FieldByName('T430FINE').AsDateTime >= DataInizio) or
            DataSet.FieldByName('T430FINE').IsNull or (DataSet.FieldByName('T430FINE').AsDateTime = 0);
    Accept:=Accept and (DataSet.FieldByName('T430INIZIO').AsDateTime <= DataFine);
  except
    Accept:=False;
  end;
end;

procedure TA058FPianifTurniDtM1.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  if (DataSet = Q265) or (DataSet = Q265B) then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = Q020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT082 then
    Accept:=A000FiltroDizionario('PROFILI PIANIF. TURNI',DataSet.FieldByName('CODICE').AsString);
end;

function TA058FPianifTurniDtM1.GetTipoGiornoServizio(D:TDateTime):String;
{Restituisce l'alternanza dei giorni festivi/feriali legati alla pianificazione dei Servizi (FIRENZE_COMUNE)}
var x:Byte;
    Festivo:Boolean;
    DataPrimoFestivo,DataPrimoGiornaliero:TDateTime;
begin
  Result:='';
  try
    if not selT530.Active then
      exit;
    if selT530.RecordCount = 0 then
      exit;
    DataPrimoFestivo:=selT530.FieldByName('DATA_PRIMOGGFES').AsDateTime;
    DataPrimoGiornaliero:=selT530.FieldByName('DATA_PRIMOGGLAV').AsDateTime;
    with selT011 do
    begin
      SetVariable('CODICE',selT530.FieldByName('CALENDARIO').AsString);
      SetVariable('DATA1',Min(DataPrimoFestivo,DataPrimoGiornaliero));
      if D > GetVariable('DATA2') then
      begin
        SetVariable('DATA2',D);
        Close;
      end;
      Open;
      if not SearchRecord('DATA',D,[srFromEnd]) then
        exit;
      if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(D) = 1) then
      begin
        Festivo:=True;
        if SearchRecord('DATA',DataPrimoFestivo,[srFromBeginning]) then
          Result:='F'
        else
          exit;
      end
      else
      begin
        Festivo:=False;
        if SearchRecord('DATA',DataPrimoGiornaliero,[srFromBeginning]) then
          Result:='G'
        else
          exit;
      end;
      x:=0;
      while not Eof do
      begin
        if FieldByName('DATA').AsDateTime > D then
          Break;
        if Festivo then
        begin
          if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(FieldByName('DATA').AsDateTime) = 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGFES').AsInteger then
              x:=1;
          end;
        end
        else
        begin
          if (FieldByName('FESTIVO').AsString = 'N') and (DayOfWeek(FieldByName('DATA').AsDateTime) > 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGLAV').AsInteger then
              x:=1;
          end;
        end;
        Next;
      end;
      if x > 0 then
        Result:=Result + IntToStr(x);
    end;
  except
  end;
end;

//==============================================================================
//==================PROCEDURE INERENTI ALLA VERIFICA DEI TURNI==================
//==============================================================================
function TA058FPianifTurniDtM1.ModificaData(InDate:TDateTime;AA,MM,GG:Word):TDateTime;
var A,M,G:Word;
begin
  try
    DecodeDate(InDate,A,M,G);
    if (AA > 0) then
      A:=AA;
    if MM > 0 then
      M:=MM - (12 * (MM div 13));
    if GG > 0 then
      G:=GG;
    if (MM div 13 > 0) then
      A:=A + (MM div 13);
  except
  end;
  Result:=EncodeDate(A,M,G);
end;

function TA058FPianifTurniDtM1.AssenzaGG(Dip,GG:Integer):Boolean;
//Controlla che per il progressivo e il giorno passati per parametro
//il dipendente sia in servizio
begin
  if (Vista[Dip].Giorni[GG].Ass1 = Vista[Dip].CausRip) or
     (Vista[Dip].Giorni[GG].Ass1 = '') then
    Result:=True
  else
    Result:=False;
end;

function TA058FPianifTurniDtM1.ControlloSuccTurn(ProgDip:Integer;DataIn:TDateTime;TurnoOggi:String):Boolean;
//Controllo che non si verifichino casi: 3 -> 1, 2 -> 3, 1 -> 3, 3 -> 2
var Ind:Integer;
    Ret:Boolean;
    TurnoIeri,TurnoDomani:String;
begin
  Ret:=True;
  TurnoIeri:='NULL';
  TurnoDomani:='NULL';
  Ind:=Trunc(DataIn - ModificaData(DataIn,0,1,1)) - 1;
  if Ind >= 0 then
    TurnoIeri:=Vista[ProgDip].Giorni[Ind].NumTurno1;
  if Ind + 2 <= Vista[0].Giorni.Count - 1 then
    TurnoDomani:=Vista[ProgDip].Giorni[Ind+2].NumTurno1;
  if ((TurnoOggi = '1') or (TurnoOggi = '2')) and (TurnoIeri = '3') then
    Ret:=False;
  if (TurnoOggi = '3') and ((TurnoDomani = '1') or (TurnoDomani = '2')) then
    Ret:=False;
  if (TurnoIeri = 'NULL') and (TurnoDomani = 'NULL') then
    Ret:=False;

  Result:=Ret;
end;

function TA058FPianifTurniDtM1.ConsideraGiorno(IndDip,IndGG:Integer;Data:TDateTime = 0):Boolean;
begin
  Result:=True;
  if Data > 0 then
    IndGG:=Trunc(Data - ModificaData(Data,0,1,1));
  if (Trim(Vista[IndDip].Giorni[IndGG].T1) = '0') and
     (Vista[IndDip].Giorni[IndGG].VerRiposi = 'N') then
    Result:=False
  else if (Trim(Vista[IndDip].Giorni[IndGG].T1) <> '0') and
     (Vista[IndDip].Giorni[IndGG].VerTurni = 'N') then
  Result:=False;
end;

function TA058FPianifTurniDtM1.GetT1(Risp,CodOrario,NumTurno:String;DataIn:TDate = 0):String;
var Ret,FiltroT021:String;
    Count:Integer;
begin
  Ret:='';
  Risp:=Uppercase(Risp);
  if (NumTurno <> '') and (CodOrario <> '') then
  begin
    QT021.Filtered:=False;
    FiltroT021:='(CODICE = ''' + CodOrario + ''')';
    if DataIn > 0 then
    begin
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(DataIn) + ' >= DECORRENZA)';
      FiltroT021:=FiltroT021 + ' AND (' + FloatToStr(DataIN) + ' <= DECORRENZA_FINE)';
    end;
    QT021.Filter:=FiltroT021;
    QT021.Filtered:=True;
    QT021.First;
    Count:=1;
    while Not(QT021.Eof) and (QT021.FieldByName('NUMTURNO').AsString <> Trim(NumTurno)) do
    begin
      Inc(Count);
      QT021.Next;
    end;
    if UpperCase(Risp) <> 'SIGLA' then
      Ret:=IntToStr(Count)
    else
      Ret:='(' + QT021.FieldByName('SIGLATURNI').AsString + ')';

    if QT021.Eof and (QT021.FieldByName('NUMTURNO').AsString <> NumTurno) then
      Ret:='E';
    QT021.Filtered:=False;
  end;
  if (NumTurno = '') and (CodOrario <> '') then
    if (Risp = 'T1') then
      Ret:='0'
    else if Risp = 'SIGLA' then
      Ret:='(R)';
  Result:=Ret;
end;

procedure TA058FPianifTurniDtM1.VerificaPianificazione(DataElabDa,DataElabA:TDateTime;SoloLOG:String);
type TSquadre = record
       Operatore:String;
       Squadra:String;
       VetOrdTurn:array[1..4] of Integer;
       MinFer:array[1..4] of Integer;
       MinFes:array[1..4] of Integer;
       MaxFer:array[1..4] of Integer;
       MaxFes:array[1..4] of Integer;
    end;
type TNTurni = record
      Numero:Integer;
      Deficit:String;
    end;
type TTurni = record
       NumTurni:Integer;
       Indice:Integer;
       RipMese:Integer;
       RipAnno:Integer;
       Flag:Boolean;
       NTurni:array[1..4]of TNTurni;
     end;
//==============================
//DICHIARAZIONE VARIABILI LOCALI
//==============================
var AInizio,AFine,DataCorr,
    DataDaTemp,DataATemp:TDateTime;
    ICorr,ISquadre,Mese,xx,IndOrdTurn:Integer;
    Turni:array of TTurni;
    VetSquadre:array of TSquadre;
    VarDModifica:Boolean;
    G:TGiustificativo;

//========================================
//DICHIARAZIONE SOTTO PROCEDURE E FUNZIONI
//========================================
  procedure RegAnom(Indice:Integer;DataModifica,DataA:TDateTime;Msg:String);
  var Nominativo,Data,DataFine:String;
      MaxLength,i:Integer;
  begin
    if Not((Indice >= -1) and (Indice < Vista.Count)) {and (EseguiLog)} then
      Exit;
    MaxLength:=0;
    if Indice >= 0 then
    begin
      for i:=0 to Vista.Count - 1 do
      begin
        Nominativo:=Vista[i].Cognome + ' ' + Vista[i].Nome;
        if Length(Nominativo) > MaxLength then
          MaxLength:=Length(Nominativo);
      end;
      AnomaliePianif:=True;
      Nominativo:=Vista[Indice].Cognome + ' ' + Vista[Indice].Nome + ':';
    end;
    Data:=' Data: ' + DateToStr(DataModifica);
    DataFine:=' - ' + DateToStr(DataA);
    if DataModifica = 0 then
      Data:='';
    if DataA = 0 then
      DataFine:='';
    Data:=Data + DataFine;
    {
    try
      if Not(DirectoryExists(R180EstraiPercorsoFile(PathFileAnom))) then
        CreateDir(R180EstraiPercorsoFile(PathFileAnom));
      R180AppendFile(PathFileAnom,Format('%-*.*s',[MaxLength,MaxLength,Nominativo]) + Data + ' ' + Msg);
    except
      R180MessageBox('Impossibile scrivere o creare il file:"' + PathFileAnom + '"','ERRORE');
      EseguiLog:=False;
    end;
    }
    if Indice > -1 then
      RegistraMsg.InserisciMessaggio('A',Format('%-*.*s',[MaxLength,MaxLength,Nominativo]) + Data + ' ' + Msg,'',Vista[Indice].Prog)
    else
      RegistraMsg.InserisciMessaggio('A',Format('%-*.*s',[MaxLength,MaxLength,Nominativo]) + Data + ' ' + Msg,'',0);
  end;

  function ElabPeriodo(Data:TDateTime;Periodo:Integer;DIF:String):TDateTime;
  //Calcola in output la Data di Inizio o Fine perido(in base al parametro DIF)
  //il parametro periodo controlla che il periodo sia un divisore di 12(mesi - (1 anno))
  //il parametro (periodo) viene valorizzato dalla maschera di definizione parametri
  var Ret,DataIni,DataFine,DataTemp:TDateTime;
      AA,MM,GG:Word;
      i:Integer;
  begin
    Result:=0;
    if Not(Periodo in [1,2,3,4,6,12]) then
      Exit;
    DecodeDate(Data,AA,MM,GG);
    DataTemp:=ModificaData(Data,AA,1,1);
    for i:=0 to (12 div Periodo)-1 do
    begin
      DataIni:=ModificaData(DataTemp,AA,1 + (i * Periodo) ,1);
      DataFine:=ModificaData(DataTemp,AA,1 + ((i + 1) * periodo),1)-1;
      if (Data >= DataIni) and (Data <= DataFine) then
        Break;
    end;
    if DIF = 'INIZIO' then
      Ret:=DataIni
    else
      Ret:=DataFine;
    Result:=Ret;
  end;

  function ControlloAss(Dip,Gio:Integer):Boolean;
  var Ret:Boolean;
  begin
    Ret:=False;
    if (Vista[Dip].Giorni[Gio].Ass1 <> '') or
       (Vista[Dip].Giorni[Gio].Ass2 <> '') then
       Ret:=True;
    Result:=Ret;
  end;

  procedure CreaLog(Data:TDateTime;Indice:Integer;Str:String);
  var FTxt:TextFile;
  begin
    if DirectoryExists('C:\Documents and Settings\DAVIDE\Desktop\') then
    begin
      AssignFile(FTxt,'C:\Documents and Settings\DAVIDE\Desktop\Log.Txt');
      if Not(FileExists('C:\Documents and Settings\DAVIDE\Desktop\Log.Txt')) then
        Rewrite(FTxt)
      else
        Append(FTxt);
      Writeln(FTxt,'DATA:' + DateToStr(Data) + '  DIPENDENTE:' + IntToStr(Indice) + #13#10 + '"' + Str + '"');
      CloseFile(FTxt);
    end;
  end;

  function GetNumSquadra(GG:TDateTime;Turn,Squad:String;Oper:String=''):Integer;
  //Calcola il numero dei dipendenti presenti in un turno, in una squadra e in un
  //determinato giorno(se Oper è valorizzato fa un ulteriore distinzione per operatore)
  var IndGio,i,Ret:Integer;
      TempSquad,TempTurn:String;
  //Se riconosce la presenza di più operatori all'interno della vista
  //ritorna true
  function PiuOperatori:Boolean;
  var Ind:Integer;
      Operatore:String;
  begin
    Result:=False;
    Operatore:=Vista[0].Giorni[IndGio].Oper;
    for Ind:=0 to Vista.Count - 1 do
      if Vista[Ind].Giorni[IndGio].Oper <> Operatore then
      begin
        Result:=True;
        Break;
      end;
  end;
  
  begin
    IndGio:=Trunc(GG - AInizio);
    Ret:=0;
    Oper:=Trim(Oper);

    for i:=0 to Vista.Count-1 do
    begin
      TempTurn:='NULL';
      if (Vista[i].Giorni[IndGio].T1EU <> 'U') then
        TempTurn:=Vista[i].Giorni[IndGio].NumTurno1;

      TempSquad:=Vista[i].Giorni[IndGio].Squadra;
      if (Squad = TempSquad) and (Turn = TempTurn) and
         (Vista[i].Giorni[IndGio].Flag <> 'NT') and
         Not(ControlloAss(i,IndGio)) then
        if (Oper = Vista[i].Giorni[IndGio].Oper) or Not PiuOperatori then
          Inc(Ret);
    end;
    Result:=Ret;
  end;

  function DaSquadre(Squad:String):Boolean;
  var Ret:Boolean;
  begin
    Ret:=True;
    if Not(selOperatori.Active) then
      selOperatori.Open;
    if Trim(VarToStr(selOperatori.Lookup('SQUADRA',Squad,'SQUADRA'))) <> '' then
      Ret:=False;
    Result:=Ret;
  end;

  procedure GetSquadre(GG:TDateTime;Squadra:String='';Oper:String='');
  //Prende le squadre del giorno designato con i loro relativi massimi e minimi
  //NB:Prima di richiamarla ripulire il vettore "VetSquadre" = "SetLength(VetSquadre,0)"
  var i,j,IndGio,k:Integer;
      TempSquadra,TempOper,Temp:String;
      Trovato:Boolean;
  begin
    IndGio:=Trunc(GG - AInizio);
    for i:=0 to Vista.Count-1 do
    begin
      //Ricerca di valori già esistenti
      TempSquadra:=Vista[i].Giorni[IndGio].Squadra;
      TempOper:='';
      if Not(daSquadre(TempSquadra)) then
        TempOper:=Vista[i].Giorni[IndGio].Oper;

      if (TempSquadra <> '') then
      begin
        Trovato:=False;
        for k:=Low(VetSquadre) to High(VetSquadre) do
          if (VetSquadre[k].Squadra = TempSquadra) and (VetSquadre[k].Operatore = TempOper) then
            Trovato:=True;

        if Not(Trovato) then
        begin
          j:=High(VetSquadre);
          if j <= -1 then
            SetLength(VetSquadre,1)
          else
            SetLength(VetSquadre,High(VetSquadre)+2);

          j:=High(VetSquadre);
          //Carico Squadra e Operatore
          VetSquadre[j].Squadra:=TempSquadra;
          VetSquadre[j].Operatore:=TempOper;
          sel2T600.Close;
          if Squadra <> '' then
            TempSquadra:=Squadra;
          sel2T600.SetVariable('SQUADRA',TempSquadra);
          sel2T600.Open;
          Temp:=sel2T600.FieldByName('PRIORITA_MINMAX').AsString;
          for k:=1 to 4 do
          begin
            Temp:=Trim(Temp);
            if pos(IntToStr(k),Temp) <= 0 then
              Temp:=Temp + IntToStr(k);
            if Copy(Temp,k,1) <> '' then
              VetSquadre[j].VetOrdTurn[k]:=StrToInt(Copy(Temp,k,1));
          end;

          //Caricamento dei limiti Max e Min a seconda se prendo dalle squadre
          //o dagli operatori
          if (daSquadre(TempSquadra)) or (TempOper = '') then
          begin
            for k:=1 to 4 do
            begin
              if sel2T600.FieldByName('TOTMIN' + IntToStr(k)).IsNull then
                VetSquadre[j].MinFer[k]:=0
              else
                VetSquadre[j].MinFer[k]:=sel2T600.FieldByName('TOTMIN' + IntToStr(k)).AsInteger;
              if sel2T600.FieldByName('TOTMAX' + IntToStr(k)).IsNull then
                VetSquadre[j].MaxFer[k]:=999
              else
                VetSquadre[j].MaxFer[k]:=sel2T600.FieldByName('TOTMAX' + IntToStr(k)).AsInteger;

              if sel2T600.FieldByName('FESMIN' + IntToStr(k)).IsNull then
                if sel2T600.FieldByName('TOTMIN' + IntToStr(k)).IsNull then
                  VetSquadre[j].MinFes[k]:=0
                else
                  VetSquadre[j].MinFes[k]:=sel2T600.FieldByName('TOTMIN' + IntToStr(k)).AsInteger
              else
                VetSquadre[j].MinFes[k]:=sel2T600.FieldByName('FESMIN' + IntToStr(k)).AsInteger;
              if sel2T600.FieldByName('FESMAX' + IntToStr(k)).IsNull then
                if sel2T600.FieldByName('TOTMAX' + IntToStr(k)).IsNull then
                  VetSquadre[j].MaxFes[k]:=999
                else
                  VetSquadre[j].MaxFes[k]:=sel2T600.FieldByName('TOTMAX' + IntToStr(k)).AsInteger
              else
                VetSquadre[j].MaxFes[k]:=sel2T600.FieldByName('FESMAX' + IntToStr(k)).AsInteger;
            end;
          end
          else
          begin
            if Oper <> '' then
              TempOper:=Oper;
            sel2T601.Close;
            sel2T601.SetVariable('SQUADRA',TempSquadra);
            sel2T601.SetVariable('OPERATORE',TempOper);
            sel2T601.Open;

            for k:=1 to 4 do
            begin
              if sel2T601.FieldByName('MIN' + IntToStr(k)).IsNull then
                VetSquadre[j].MaxFer[k]:=0
              else
                VetSquadre[j].MinFer[k]:=sel2T601.FieldByName('MIN' + IntToStr(k)).AsInteger;
              if sel2T601.FieldByName('MAX' + IntToStr(k)).IsNull then
                VetSquadre[j].MaxFer[k]:=999
              else
                VetSquadre[j].MaxFer[k]:=sel2T601.FieldByName('MAX' + IntToStr(k)).AsInteger;
              if sel2T601.FieldByName('FESMIN' + IntToStr(k)).IsNull then
                if sel2T601.FieldByName('MIN' + IntToStr(k)).IsNull then
                  VetSquadre[j].MinFes[k]:=0
                else
                  VetSquadre[j].MinFes[k]:=sel2T601.FieldByName('MIN' + IntToStr(k)).AsInteger
              else
                VetSquadre[j].MinFes[k]:=sel2T601.FieldByName('FESMIN' + IntToStr(k)).AsInteger;
              if sel2T601.FieldByName('FESMAX' + IntToStr(k)).IsNull then
                if sel2T601.FieldByName('MAX' + IntToStr(k)).IsNull then
                  VetSquadre[j].MaxFes[k]:=999
                else
                  VetSquadre[j].MaxFes[k]:=sel2T601.FieldByName('MAX' + IntToStr(k)).AsInteger
              else
                VetSquadre[j].MaxFes[k]:=sel2T601.FieldByName('FESMAX' + IntToStr(k)).AsInteger;
            end;
          end;
        end;
      end;
      if (Squadra <> '') or (Oper <> '') then
        Break;
    end;
    sel2T601.Close;
  end;

  function MaggTurniOrigine(TurnoOrigine,TurnoDest:Integer;DataCorr:TDateTime):Integer;
  //Restituisce l'indice vista del dipendente consiagliato per effettuare il turno
  type TTurniDip = record
       Prog:Integer;
       Turno:array[1..4]of Integer;
  end;
  var TurniDip:array of TTurniDip;
      j,i,TempTurno,ProgOld,
      Massimo,Minimo,//Usati per contaggiare i massimi e i minimi nei turni
      NDipValidi,Ret:Integer;
      DataModDa,DataModA,DataModCorr:TDateTime;
  begin
    Ret:=High(Ret);
    //Calocolo data inizio e fine bimestre
    DataModDa:=ElabPeriodo(DataCorr,Vista[0].ConstElabPeriodo,'INIZIO');
    DataModA:=ElabPeriodo(DataCorr,Vista[0].ConstElabPeriodo,'FINE');

    ProgOld:=0;
    SetLength(TurniDip,0);
    for i:=0 to Vista.Count-1 do
    begin
      //Controllo successione turni
      //se il giorno prima il turno era una notte è oggi il turno
      //è un mattino o un pomeriggio non carico il dip nel vettore
      //controllo che siano abilitate le sostituzioni sul giorno corrente (ConsideraGiorno(i,0,DataCorr))
      if ControlloSuccTurn(i,DataCorr,IntToStr(TurnoOrigine)) and ConsideraGiorno(i,0,DataCorr) then
      begin
        DataModCorr:=DataModDa;
        j:=Trunc(DataModCorr - AInizio);
        while DataModCorr <= DataModA do
        begin
          //scorro il bimestre e carico 1 vettore con i turni fatti nel bimestre dei soli turni
          //di destinazione
          if (Vista[i].Giorni[j].Flag <> 'NT') and (Vista[i].Giorni[j].NumTurno1 <> '') and
             Not(ControlloAss(i,Icorr)) and//Controlla che il dipendente non abbia un'assenza
             (Vista[i].Giorni[ICorr].NumTurno1 = IntToStr(TurnoDest)) and
             (Vista[i].Giorni[ICorr].Squadra = VetSquadre[ISquadre].Squadra) and
             ((Vista[i].Giorni[ICorr].Oper = VetSquadre[ISquadre].Operatore) or (DaSquadre(VetSquadre[ISquadre].Squadra))) then
          begin
            if ProgOld <> Vista[i].Prog then
              if High(TurniDip) < 0 then
                SetLength(TurniDip,1)
              else
                SetLength(TurniDip,High(TurniDip) + 2);

            TurniDip[High(TurniDip)].prog:=i;
            TempTurno:=StrToInt(Vista[i].Giorni[j].NumTurno1);
            inc(TurniDip[High(TurniDip)].Turno[TempTurno]);
            ProgOld:=Vista[i].Prog;
          end;
          inc(j);
          DataModCorr:=DataModCorr + 1;
        end;
      end;
    end;
    //Trovo massimo nei turni di origine
    Massimo:=0;
    for i:=low(TurniDip) to High(TurniDip) do
      if TurniDip[i].Turno[TurnoOrigine] > Massimo then
        Massimo:=TurniDip[i].Turno[TurnoOrigine];

    NDipValidi:=0;
    //Azzero i progressivi che non raggiungono il Massimo
    //e conto il numero di dipendenti validi
    for i:=low(TurniDip) to High(TurniDip) do
      if TurniDip[i].Turno[TurnoOrigine] < Massimo then
        TurniDip[i].Prog:=-1
      else
        inc(NDipValidi);

    if NDipValidi > 1 then
    begin
      //Trovo il minimo dei turni di destinazione
      Minimo:=High(Integer);
      for i:=low(TurniDip) to High(TurniDip) do
        if (TurniDip[i].Turno[TurnoDest] < Minimo) and (TurniDip[i].Prog > 0) then
          Minimo:=TurniDip[i].Turno[TurnoDest];

      //Azzero i progressivi che superano il minimo
      for i:=low(TurniDip) to High(TurniDip) do
        if (TurniDip[i].Turno[TurnoDest] > Minimo) and (NDipValidi > 1) then
        begin
          TurniDip[i].Prog:=-1;
          Dec(NDipValidi);
        end;
    end;

    if High(TurniDip) >= 0 then
    begin
      i:=low(TurniDip);
      while (i <= High(TurniDip)) and (TurniDip[i].Prog < 0) do
        inc(i);
      if (i <= High(TurniDip)) or (TurniDip[i].Prog > 0) then
        Ret:=TurniDip[i].Prog;
    end;
    Result:=Ret;
  end;

  //==================================================================
  //PROCEDURE DEDICATE ALLA GESTIONE DEL NUMERO DEI TURNI DEL BIMESTRE
  //==================================================================
  procedure CaricaNTurni(Day:TDateTime);
  var k,h,x:Integer;
      InizioB,FineB,Scorr:TDateTime;
      MinimiTurni:array[1..4]of Integer;
      Orari:String;
  begin
    //=====================================================
    //CARICO VETTORE CONTENENTE IL NUMERO DEI DIVERSI TURNI
    //EFFETTUATI NEL BIMESTRE DAL DIPENDENTE
    //=====================================================

    //Minimi dei turni nel bimestre
    MinimiTurni[1]:=Vista[0].ConstInd1;
    MinimiTurni[2]:=Vista[0].ConstInd2;
    MinimiTurni[3]:=Vista[0].ConstInd3;
    MinimiTurni[4]:=Vista[0].ConstInd4;
    for x:=1 to 4 do
      if (MinimiTurni[x] <= 0) or (MinimiTurni[x] > 400) then
        MinimiTurni[x]:=0;

    if Length(Turni) = 0 then
    begin
      if High(Turni) <> Vista.Count then
        SetLength(Turni,Vista.Count);
      for k:=0 to Vista.Count-1 do
      begin
        Turni[k].Indice:=k;
        Turni[k].NumTurni:=0;
        for h:=1 to 4 do
        begin
          Turni[k].NTurni[h].Numero:=0;
          Turni[k].NTurni[h].Deficit:='NV';
        end;
        Orari:=',';
        for x:=0 to Vista[k].Giorni.Count - 1 do
        begin
          if Pos(',' + Vista[k].Giorni[x].Ora + ',',Orari) = 0 then
          begin
            selT021.Close;
            selT021.SetVariable('CODICEORARIO',Vista[k].Giorni[x].Ora);
            selT021.Open;
            //Leggo sulla selT021 where codice = TDipendente(Vista[x]).Giorni[y]).Ora a flaggo a true i turni esistenti
            for h:=1 to 4 do
              if selT021.SearchRecord('NUMTURNO',h,[srFromBeginning]) then
                Turni[k].NTurni[h].Deficit:='';
            Orari:=Orari + Vista[k].Giorni[x].Ora + ',';
            selT021.Close;
          end;
        end;
      end;
    end;

    for k:=Low(Turni) to High(Turni) do
      for x:=1 to 4 do
        Turni[k].NTurni[x].Numero:=0;

    InizioB:=ElabPeriodo(Day,Vista[0].ConstElabPeriodo,'INIZIO');
    FineB:=ElabPeriodo(Day,Vista[0].ConstElabPeriodo,'FINE');
    //=====================================================================
    //CICLO PER IL CARICAMENTO DEL NUMERO DEI TURNI ALL'INTERNO DEL PERIODO
    //=====================================================================
    Scorr:=InizioB;
    h:=Trunc(Scorr - AInizio);
    while Scorr <= FineB do
    begin
      for k:=0 to Vista.Count-1 do
      begin
        if (Trim(Vista[k].Giorni[h].T1) <> '0') and (Trim(Vista[k].Giorni[h].NumTurno1) <> '') and
           (StrToInt(Vista[k].Giorni[h].NumTurno1) > 0) and (StrToInt(Vista[k].Giorni[h].NumTurno1) < 5) and Not(ControlloAss(k,h)) and
           (Vista[k].Giorni[h].Flag <> 'NT') then
          inc(Turni[k].NTurni[StrToInt(Vista[k].Giorni[h].NumTurno1)].Numero);
      end;
      Scorr:=Scorr + 1;
      inc(h);
    end;

    for k:=Low(Turni) to High(Turni) do
      for h:=1 to 4 do
      begin
        if Turni[k].NTurni[h].Deficit = 'NV' then
          Continue;
        if (Turni[k].NTurni[h].Numero < MinimiTurni[h]) then
          Turni[k].NTurni[h].Deficit:='<'
        else if (Turni[k].NTurni[h].Numero = MinimiTurni[h]) then
          Turni[k].NTurni[h].Deficit:='='
        else if (Turni[k].NTurni[h].Numero > MinimiTurni[h]) then
          Turni[k].NTurni[h].Deficit:='>';
        if (Turni[k].NTurni[h].Numero > MinimiTurni[h] + (MinimiTurni[h] / 100) * 100) then
          Turni[k].NTurni[h].Deficit:='>>';
      end;
  end;

  //Carica nel vettore turni il n° di riposi annuali e mensili festivi
  procedure CaricaRiposi(Day:TDateTime);
  var InizioDataElab,FineDataElab,DataScorrElab:TDateTime;//Variabili per lo scorrimento dell'anno
      InizioMese,FineMese:TDateTime;                      //Variabili per lo scorrimento del mese
      h,k:Integer;
      AA,MM,DD:Word;
      Festivo:String;
  begin
    //Carico i riposi del dipendente nell'anno
    DecodeDate(Day,AA,MM,DD);
    InizioDataElab:=ModificaData(Day,0,1,1);
    FineDataElab:=ModificaData(Day,0,12,31);
    InizioMese:=ModificaData(Day,0,0,1);
    FineMese:=ModificaData(Day,0,MM + 1,1)-1;
    for k:=low(Turni) to High(Turni) do
    begin
      Turni[k].RipAnno:=0;
      Turni[k].RipMese:=0;
    end;
    h:=0;
    DataScorrElab:=InizioDataElab;
    while DataScorrElab <= FineDataElab do
    begin
      Festivo:='N';
      Festivo:=VarToStr(SelT010.Lookup('DATA',DataScorrElab,'FESTIVO'));
      for k:=low(Turni) to High(Turni) do
      begin
        if (Trim(Vista[Turni[k].Indice].Giorni[h].T1) = '0') and
           (Vista[Turni[k].Indice].Giorni[h].Flag <> 'NT') then
          inc(Turni[k].RipAnno);
        if (DataScorrElab >= InizioMese) and (DataScorrElab <= FineMese) and (Festivo = 'S') and
           (Trim(Vista[Turni[k].Indice].Giorni[h].T1) = '0') and
           (Vista[Turni[k].Indice].Giorni[h].Flag <> 'NT') then
          inc(Turni[k].RipMese);
      end;
      Inc(h);
      DataScorrElab:=DataScorrElab + 1;
    end;
  end;

  function GetDaRiposi(DataCorr:TDateTime;OrigTurn:String):Integer;
  type TRiposiDip = record
       Prog:Integer;
       NRipFest:Integer;
       NRipFer:Integer;
  end;
  var i,j,Max,Ret:Integer;
      Fest,Temp:String;
      VetRiposi:array of TRiposiDip;
      DataModA,DataModDa,DataModCorr:TDateTime;
      AA,MM,GG:Word;
  begin
    //====================
    //J = DATA SOTTO ESAME
    //====================
    j:=Trunc(DataCorr - AInizio);
    //===============================================================
    //CARICO VETTORE CON I SOLI DIPENDENTI CON IL TURNO E/O OPERATORE
    //SOTTO ESAME NEL GIORNO SPECIFICATO
    //===============================================================
    SetLength(Turni,0);
    CaricaNTurni(DataCorr);
    CaricaRiposi(DataCorr);
    for i:=0 to Vista.Count-1 do
    begin
      if (Vista[i].Giorni[j].Squadra = VetSquadre[ISquadre].Squadra) and
         (Trim(Vista[i].Giorni[j].T1) = '0') and ControlloSuccTurn(i,DataCorr,OrigTurn) and
         ((Vista[i].Giorni[j].Oper = VetSquadre[ISquadre].Operatore) or (DaSquadre(VetSquadre[ISquadre].Squadra))) and
         (Vista[i].CompRip < Turni[i].RipAnno) and ConsideraGiorno(i,j) then
      begin
         if High(VetRiposi) < 0 then
           SetLength(VetRiposi,1)
         else
           SetLength(VetRiposi,High(VetRiposi) + 2);
         VetRiposi[High(VetRiposi)].Prog:=i;
      end;
    end;
    Fest:=VarToStr(SelT010.Lookup('DATA',DataCorr,'FESTIVO'));
    DecodeDate(DataCorr,AA,MM,GG);
    //=======================================================================
    //CARICO I NUMERO DEI RIPOSI NEI GIORNI FESTIVI NEL CASO IN CUI IL GIORNO
    //SOTTO ESAME SIA FESTIVO
    //=======================================================================
    if Fest = 'S' then
    begin
      DataModA:=ModificaData(DataCorr,0,MM+1,1) - 1;
      DataModDa:=ModificaData(DataCorr,0,0,1);
      DataModCorr:=DataModDa;
      j:=Trunc(DataModCorr - AInizio);
      while DataModCorr <= DataModA do
      begin
        Temp:=VarToStr(SelT010.Lookup('DATA',DataModCorr,'FESTIVO'));
        for i:=Low(VetRiposi) to High(VetRiposi) do
          if (Vista[VetRiposi[i].Prog].Giorni[j].Flag <> 'NT') and
             (Trim(Vista[VetRiposi[i].Prog].Giorni[j].T1) = '0') and (Temp = 'S'){ and
             (TGiorno(TDipendente(Vista[VetRiposi[i].Prog]).Giorni[j]).Squadra = VetSquadre[ISquadre].Squadra) and
             ((TGiorno(TDipendente(Vista[VetRiposi[i].Prog]).Giorni[j]).Oper = VetSquadre[ISquadre].Operatore) or (DaSquadre(VetSquadre[ISquadre].Squadra)))} then
            Inc(VetRiposi[i].NRipFest);
        DataModCorr:=DataModCorr + 1;
        inc(j);
      end;
      Max:=0;
      for i:=Low(VetRiposi) to High(VetRiposi) do
        if (VetRiposi[i].NRipFest > 1) and (VetRiposi[i].NRipFest > Max) then
          Max:=VetRiposi[i].NRipFest;
      if Max > 0 then
        for i:=Low(VetRiposi) to High(VetRiposi) do
          if VetRiposi[i].NRipFest < Max then
            VetRiposi[i].Prog:=-1;
    end;
    //=================================================
    //CARICO NEL VETTORE IL NUMERO DEI RIPOSI NELL'ANNO
    //=================================================
    DataModA:=AFine;
    DataModDa:=AInizio;
    DataModCorr:=DataModDa;
    j:=0;
    while DataModCorr <= DataModA do
    begin
      for i:=Low(VetRiposi) to High(VetRiposi) do
        if (VetRiposi[i].Prog > 0) and (Vista[VetRiposi[i].Prog].Giorni[j].Flag <> 'NT') and
           (Trim(Vista[VetRiposi[i].Prog].Giorni[j].T1) = '0') then
           Inc(VetRiposi[i].NRipFer);
      DataModCorr:=DataModCorr + 1;
      inc(j);
    end;
    Ret:=High(Ret);
    Max:=0;
    for i:=Low(VetRiposi) to High(VetRiposi) do
      if VetRiposi[i].NRipFer > Max then
        Max:=VetRiposi[i].NRipFer;
    for i:=Low(VetRiposi) to High(VetRiposi) do
      if VetRiposi[i].NRipFer < Max then
        VetRiposi[i].Prog:=-1;
    for i:=Low(VetRiposi) to High(VetRiposi) do
      if VetRiposi[i].Prog > 0 then
        Ret:=VetRiposi[i].Prog;

    Result:=Ret;
  end;

  procedure GestisciMinimi(TipoGG:String;ITurni:Integer);
  var Minimo,Massimo,NumInSqua,
      IT,//Indici usati per scorrimento Turni(IT) e Squadre(ISq)
      ITMax,MaxTemp,Temp:Integer;
      Festivo:String;
  begin
    if daSquadre(VetSquadre[ISquadre].Squadra) then
      NumInSqua:=GetNumSquadra(DataCorr,IntToStr(ITurni),VetSquadre[ISquadre].Squadra)
    else
      NumInSqua:=GetNumSquadra(DataCorr,IntToStr(ITurni),VetSquadre[ISquadre].Squadra,VetSquadre[ISquadre].Operatore);
    Festivo:=VarToStr(selT010.Lookup('DATA',DataCorr,'FESTIVO'));
    if Festivo = 'S' then
      Minimo:=VetSquadre[ISquadre].MinFes[ITurni]
    else
      Minimo:=VetSquadre[ISquadre].MinFer[ITurni];
    {scorro tutti i turni di tutte le squadre per
    vedere se ci sono degli esuberi negli altri turni}
    if NumInSqua < Minimo then
    begin
      Massimo:=0;
      ITMax:=0;
      for IT:=1 to 4 do
        if IT <> ITurni then
        begin
          if daSquadre(VetSquadre[ISquadre].Squadra) then
            MaxTemp:=GetNumSquadra(DataCorr,IntToStr(IT),VetSquadre[ISquadre].Squadra)
          else
            MaxTemp:=GetNumSquadra(DataCorr,IntToStr(IT),VetSquadre[ISquadre].Squadra,VetSquadre[ISquadre].Operatore);
          //Rivalorizzo il minimo in base al turno sotto esame
          if Festivo = 'S' then
            Minimo:=VetSquadre[ISquadre].MinFes[IT]
          else
            Minimo:=VetSquadre[ISquadre].MinFer[IT];
        //Cerco il turno con il maggior numero di turnisti in esubero
        //Massimo è attualmentre il valore + alto del DELTA trovato
        if (MaxTemp - Minimo) > Massimo then
        begin
          Massimo:=(MaxTemp - Minimo);
          //ITMax contenitore del turno con il maggior esubero
          ITMax:=IT;
        end;
      end;
      if TipoGG = 'RIP' then
        ITMax:=1;
      if ITMax > 0 then
      begin
        if UpperCase(TipoGG) = 'FER' then
                              //Origine//Destinazione
          Temp:=MaggTurniOrigine(ITurni,ITMax,DataCorr)
        else
          Temp:=GetDaRiposi(DataCorr,IntToStr(ITurni));
        if (Temp <= Vista.Count) then
        begin
          if ((Vista[Temp].Giorni[ICorr].Ass1 <> '') and (Vista[Temp].Giorni[ICorr].Ass1 = Vista[Temp].CausRip)) or
             (Vista[Temp].Giorni[ICorr].Ass1 = '') then
          begin
            VarDModifica:=True;
            //Copio i dati del turno in deficit di personale sul quello in esubero
            Vista[Temp].Giorni[ICorr].Modificato:=True;
            Vista[Temp].Giorni[ICorr].NumTurno1:=IntToStr(ITurni);
            Vista[Temp].Giorni[ICorr].T1:=' ' + GetT1('T1',Vista[Temp].Giorni[ICorr].Ora,IntToStr(ITurni),DataCorr);
            Vista[Temp].Giorni[ICorr].SiglaT1:=GetT1('SIGLA',Vista[Temp].Giorni[ICorr].Ora,IntToStr(ITurni),DataCorr);
            if GetT1('T1',Vista[Temp].Giorni[ICorr].Ora,IntToStr(ITurni),DataCorr) <> '0' then
              Vista[Temp].Giorni[ICorr].Ass1:='';
          end;
        end;
      end;
    end;
  end;

  procedure GestisciMassimi(ITurni:Integer);
  type TRiposiDip = record
       Prog:Integer;
       NRipFest:Integer;
       NRipFer:Integer;
       TurnOri:Integer;
  end;
  var NumInSqua,Massimo,i,j,
      Temp,count:Integer;
      Festivo:String;
      DataModDa,DataModA,DataModCorr:TDateTime;
      AA,MM,GG:Word;
      VetRiposi:array of TRiposiDip;
  begin
    Festivo:=VarToStrDef(SelT010.Lookup('DATA',DataCorr,'FESTIVO'),'N');
    if Festivo = 'S' then
      Massimo:=VetSquadre[ISquadre].MaxFes[ITurni]
    else
      Massimo:=VetSquadre[ISquadre].MaxFer[ITurni];
    if daSquadre(VetSquadre[ISquadre].Squadra) then
      NumInSqua:=GetNumSquadra(DataCorr,IntToStr(ITurni),VetSquadre[ISquadre].Squadra)
    else
      NumInSqua:=GetNumSquadra(DataCorr,IntToStr(ITurni),VetSquadre[ISquadre].Squadra,VetSquadre[ISquadre].Operatore);

    if NumInSqua > Massimo then
    begin
      CaricaNTurni(DataCorr);
      DecodeDate(DataCorr,AA,MM,GG);
      for i:=0 to Vista.Count - 1 do
      begin
        if (Vista[i].Giorni[ICorr].NumTurno1 = IntToStr(ITurni)) and
           Not(ControlloAss(i,ICorr)) and ConsideraGiorno(i,ICorr) and
           (Vista[i].Giorni[ICorr].Squadra = VetSquadre[ISquadre].Squadra) and
           ((Vista[i].Giorni[ICorr].Oper = VetSquadre[ISquadre].Operatore) or (daSquadre(VetSquadre[ISquadre].Squadra))) then
        begin
          if High(VetRiposi) < 0 then
            SetLength(VetRiposi,1)
          else
            SetLength(VetRiposi,High(VetRiposi) + 2);
          VetRiposi[High(VetRiposi)].Prog:=i;
        end;
      end;
      if Festivo <> 'S' then
      begin
//====================================
//CARICO IL NUMERO DI RIPOSI NELL'ANNO
//====================================
        DataModDa:=ModificaData(DataElabDa,0,1,1);
        DataModA:=ModificaData(DataElabA,0,12,31);
        j:=0;
        DataModCorr:=DataModDa;
        while DataModCorr <= DataModA do
        begin
          for i:=Low(VetRiposi) to High(VetRiposi) do
            if Trim(Vista[VetRiposi[i].Prog].Giorni[j].T1) = '0' then
              Inc(VetRiposi[i].NRipFer);
          DataModCorr:=DataModCorr + 1;
          Inc(j);
        end;
//=====================================
//CARICO IL NUMERO DEI TURNI DI ORIGINE
//=====================================
        DataModDa:=ElabPeriodo(DataCorr,Vista[0].ConstElabPeriodo,'INIZIO');
        DataModA:=ElabPeriodo(DataCorr,Vista[0].ConstElabPeriodo,'FINE');

        DataModCorr:=DataModDa;
        j:=Trunc(DataModDa - AInizio);
        while DataModCorr < DataModA do
        begin
          for i:=low(VetRiposi) to High(VetRiposi) do
            if (Vista[VetRiposi[i].Prog].Giorni[j].NumTurno1 = IntToStr(ITurni)) and
               Not(ControlloAss(VetRiposi[i].Prog,j)) and
               (Vista[VetRiposi[i].Prog].Giorni[j].Flag <> 'NT') and Not(ControlloAss(i,j)) then
              inc(VetRiposi[i].TurnOri);
          DataModCorr:=DataModCorr + 1;
          Inc(j);
        end;
      end
      else
      begin
//==============================================
//CARICO IL NUMERO DEI RIPOSI NEI GIORNI FESTIVI
//==============================================
        DataModDa:=ModificaData(DataCorr,0,0,1);
        DataModA:=ModificaData(DataCorr,0,MM+1,1)-1;
        DataModCorr:=DataModDa;
        j:=Trunc(DataModDa - AInizio);
        while DataModCorr < DataModA do
        begin
          for i:=Low(VetRiposi) to High(VetRiposi) do
            if (VarToStr(SelT010.Lookup('DATA',DataModCorr,'FESTIVO')) = 'S') and
               (Trim(Vista[VetRiposi[i].Prog].Giorni[j].T1) = '0') then
              Inc(VetRiposi[i].NRipFest);
          DataModCorr:=DataModCorr + 1;
          Inc(j);
        end;
      end;
      if Festivo <> 'S' then
      begin
        Temp:=High(Temp);
        count:=High(VetRiposi);
        for i:=low(VetRiposi) to High(VetRiposi) do
          if VetRiposi[i].NRipFer < Temp then
            Temp:=VetRiposi[i].NRipFer;
        for i:=low(VetRiposi) to High(VetRiposi) do
          if (VetRiposi[i].NRipFer > Temp) or
             (VetRiposi[i].NRipFer >= Vista[VetRiposi[i].Prog].CompRip) then
          begin
            Dec(count);
            VetRiposi[i].Prog:=-1;
          end;
        if count > 1 then
        begin
          Temp:=0;
          for i:=Low(VetRiposi) to High(VetRiposi) do
            if VetRiposi[i].TurnOri > Temp then
              Temp:=VetRiposi[i].TurnOri;
          for i:=Low(VetRiposi) to High(VetRiposi) do
            if VetRiposi[i].TurnOri < Temp then
              VetRiposi[i].Prog:=-1;
        end;
      end
      else
      begin
        Temp:=0;
        for i:=Low(VetRiposi) to High(VetRiposi) do
          if VetRiposi[i].NRipFest > Temp then
            Temp:=VetRiposi[i].NRipFest;
        for i:=low(VetRiposi) to High(VetRiposi) do
          if (VetRiposi[i].NRipFest < Temp) or
             (VetRiposi[i].NRipFest >= Vista[VetRiposi[i].Prog].ConstMesRip) then
            VetRiposi[i].Prog:=-1;
      end;
      Temp:=-1;
      if High(VetRiposi) > 0 then
      begin
        for i:=Low(VetRiposi) to High(VetRiposi) do
          if (VetRiposi[i].Prog >= 0) and (Temp < 0) and
             (Vista[VetRiposi[i].Prog].Giorni[ICorr].NumTurno1 <> '') and
             (Vista[VetRiposi[i].Prog].Giorni[ICorr].NumTurno1 >= '1') and
             (Vista[VetRiposi[i].Prog].Giorni[ICorr].NumTurno1 <= '4') and
             ((Turni[VetRiposi[i].Prog].NTurni[StrToInt(Vista[VetRiposi[i].Prog].Giorni[ICorr].NumTurno1)].Deficit = '>') or
             (Turni[VetRiposi[i].Prog].NTurni[StrToInt(Vista[VetRiposi[i].Prog].Giorni[ICorr].NumTurno1)].Deficit = '>>')) then
            Temp:=VetRiposi[i].Prog;
        if Temp < 0 then
        begin
          for i:=Low(VetRiposi) to High(VetRiposi) do
            if (VetRiposi[i].Prog >= 0) and (Temp < 0) then
              Temp:=VetRiposi[i].Prog;
        end;
      end;
      if Temp >= 0 then
      begin
        VarDModifica:=True;
        Vista[Temp].Giorni[ICorr].Modificato:=True;
        Vista[Temp].Giorni[ICorr].NumTurno1:='';
        Vista[Temp].Giorni[ICorr].T1:=' 0';
        Vista[Temp].Giorni[ICorr].SiglaT1:='(R)';
      end;
    end;
  end;

  procedure MinimoTurni;
  var i,IndScorr,DestInd,DestTurn,
      OrigInd,OrigTurn,NumInSquad,
      Max,Count:Integer;
      DataScorr:TDateTime;
      Temp,Fest:String;
  begin
    //Ripeti:=False;
    //SetLength(Turni,0);
    CaricaNTurni(DataElabDa);
    //Memorizzo il N°Turno e l'indice del dipendente in deficit
    for DestInd:=Low(Turni) to High(Turni) do
      for DestTurn:=1 to 4 do
      begin
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.LblOPerazioni.Caption:='Controllo turno ' + IntToStr(DestTurn)
        + ' per il dipendente ' + Vista[DestInd].Cognome + ' ' + Vista[DestInd].Nome;
        {$ENDIF}
        Application.ProcessMessages;
        if (Turni[DestInd].NTurni[DestTurn].Deficit = '<') then
        begin
          VarDModifica:=False;
          //Punti 1-2-3
          //****************************************************************
          //Count = Turno in eccesso del dipendnte con il deficit, se nn ha
          //turno in eccesso allora potrei saltare l'elaborazione successiva
          //****************************************************************
          count:=-1;
          for i:=1 to 4 do
            if (Turni[DestInd].NTurni[i].Deficit = '>') or (Turni[DestInd].NTurni[i].Deficit = '>>') and (count < 0) and
               (i <> DestTurn) then
              Count:=i;
          //=====================================================
          if Count > 0 then
          begin
            //Ripeti:=False;
            DataScorr:=DataElabDa;
            IndScorr:=Trunc(DataElabDa - AInizio);
            while DataScorr <= DataElabA do
            begin
              //==============================================
              //RICERCA DEL DIPENDENTE CON IL TURNO IN ECCESSO
              //==============================================
              if Vista[DestInd].Giorni[IndScorr].Flag <> 'NT' then
              begin
                OrigInd:=-1;                                                                  //qua sotto c'era DestTurn
                if (Vista[DestInd].Giorni[IndScorr].NumTurno1 = IntToStr(Count)) and
                   (Trim(Vista[DestInd].Giorni[IndScorr].T1) <> '0') and Not(ControlloAss(DestInd,IndScorr)) then
                  for i:=low(Turni) to High(Turni) do
                    if (i <> DestInd) and ControlloSuccTurn(DestInd,DataScorr,Vista[i].Giorni[IndScorr].NumTurno1) and
                       ControlloSuccTurn(i,DataScorr,Vista[DestInd].Giorni[IndScorr].NumTurno1) and
                       (Vista[i].Giorni[IndScorr].NumTurno1 = IntToStr(DestTurn)) and
                       (Vista[DestInd].Giorni[IndScorr].Squadra = Vista[i].Giorni[IndScorr].Squadra) and
                       ((Vista[DestInd].Giorni[IndScorr].Oper = Vista[i].Giorni[IndScorr].Oper)
                       or daSquadre(Vista[i].Giorni[IndScorr].Squadra)) and
                       ((Turni[i].NTurni[DestTurn].Deficit = '>') or (Turni[i].NTurni[DestTurn].Deficit = '>>')) and (Trim(Vista[DestInd].Giorni[IndScorr].T1) <> '0') and (OrigInd < 0) then
                      OrigInd:=i;

                if (OrigInd >= 0) and Not(ControlloAss(DestInd,IndScorr)) and Not(ControlloAss(OrigInd,IndScorr)) and
                   ConsideraGiorno(DestInd,IndScorr) and ConsideraGiorno(OrigInd,IndScorr) then
                begin
                  VarDModifica:=True;
                  //swap NumTurno1
                  Temp:=Vista[DestInd].Giorni[IndScorr].NumTurno1;
                  Vista[DestInd].Giorni[IndScorr].NumTurno1:=Vista[OrigInd].Giorni[IndScorr].NumTurno1;
                  Vista[OrigInd].Giorni[IndScorr].NumTurno1:=Temp;
                  //swap T1
                  Vista[DestInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[DestInd].Giorni[IndScorr].Ora,
                                                                       Vista[DestInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[OrigInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[OrigInd].Giorni[IndScorr].Ora,
                                                                       Vista[OrigInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  //Sigla T1
                  Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,
                                                                         Vista[DestInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[OrigInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[OrigInd].Giorni[IndScorr].Ora,
                                                                         Vista[OrigInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                  Vista[OrigInd].Giorni[IndScorr].Modificato:=True;
                  //Ripeti:=True;
                  CaricaNTurni(DataElabDa);
                  if (Turni[DestInd].NTurni[DestTurn].Deficit <> '<') then
                    Break;
                end;
              end;
              Application.ProcessMessages;
              DataScorr:=DataScorr + 1;
              Inc(IndScorr);
            end;
          end;
          //**********************************************************
          //Punto 4-5: vedi punto 7 con ricerca sugli altri dipendenti
          //**********************************************************
          if (Turni[DestInd].NTurni[DestTurn].Deficit = '<') then
          begin
            DataScorr:=DataElabDa;
            IndScorr:=Trunc(DataElabDa - AInizio);
            //Ripeti:=False;
            CaricaRiposi(DataScorr);
            while DataScorr <= DataElabA do
            begin
              if (Trim(Vista[Turni[DestInd].Indice].Giorni[IndScorr].T1) = '0') and
                 (Vista[DestInd].Giorni[IndScorr].Flag <> 'NT') and
                 ConsideraGiorno(DestInd,0,DataScorr) then
              begin
                for i:=low(Turni) to High(Turni) do
                  Turni[i].Flag:=False;
                Max:=0;
                Count:=0;
                //if not(il dipendente DestInd è in riposo il giorno DataScorr) allora
                //passo al giorno successivo
                //Ricerco il dipendente con il max turno in esubero
                for i:=Low(Turni) to High(Turni) do
                  if (i <> DestInd) and (Turni[i].NTurni[DestTurn].Numero > Max) and
                     ((Turni[i].NTurni[DestTurn].Deficit = '>') or (Turni[i].NTurni[DestTurn].Deficit = '>>')) and
                     Not(ControlloAss(i,IndScorr)) and ConsideraGiorno(i,IndScorr) and
                     (Vista[i].Giorni[IndScorr].NumTurno1 = IntToStr(DestTurn)) and
                     (Vista[Turni[i].Indice].Giorni[IndScorr].Squadra =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra) and
                     ((Vista[Turni[i].Indice].Giorni[IndScorr].Oper =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper) or
                     (DaSquadre(Vista[Turni[i].Indice].Giorni[IndScorr].Squadra))) then
                    Max:=Turni[i].NTurni[DestTurn].Numero;
                for i:=low(Turni) to High(Turni) do
                  if (Turni[i].NTurni[DestTurn].Numero = Max) and
                     Not(ControlloAss(i,IndScorr)) and ConsideraGiorno(i,IndScorr) and
                     ((Turni[i].NTurni[DestTurn].Deficit = '>') or (Turni[i].NTurni[DestTurn].Deficit = '>>')) and                       (DestInd <> i) and
                     (Vista[i].Giorni[IndScorr].NumTurno1 = IntToStr(DestTurn)) and
                     (Vista[Turni[i].Indice].Giorni[IndScorr].Squadra =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra) and
                     ((Vista[Turni[i].Indice].Giorni[IndScorr].Oper =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper) or
                     (DaSquadre(Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra))) then
                  begin
                    Turni[i].Flag:=True;
                    Inc(Count);
                  end;
                //Ricerca del dipendente con il minor numero di riposi
                Max:=High(Max);
                for i:=low(Turni) to High(Turni) do
                  if (Turni[i].RipAnno < Max) and (Turni[i].Flag) and (DestInd <> i) and
                     Not(ControlloAss(i,IndScorr)) and ConsideraGiorno(i,IndScorr) and
                     (Vista[i].Giorni[IndScorr].NumTurno1 = IntToStr(DestTurn)) and
                     (Vista[Turni[i].Indice].Giorni[IndScorr].Squadra =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra) and
                     ((Vista[Turni[i].Indice].Giorni[IndScorr].Oper =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper) or
                     (DaSquadre(Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra))) then
                    Max:=Turni[i].RipAnno;
                for i:=low(Turni) to High(Turni) do
                  if (Turni[i].RipAnno > Max) and (Turni[i].Flag) and (DestInd <> i) and (count > 1) and
                     Not(ControlloAss(i,IndScorr)) and ConsideraGiorno(i,IndScorr) and
                     (Vista[i].Giorni[IndScorr].NumTurno1 = IntToStr(DestTurn)) and
                     (Vista[Turni[i].Indice].Giorni[IndScorr].Squadra =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra) and
                     ((Vista[Turni[i].Indice].Giorni[IndScorr].Oper =
                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper) or
                     (DaSquadre(Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra))) then
                  begin
                    Turni[i].Flag:=False;
                    dec(Count);
                  end;
                //===============================
                //ELIMINAZIONE MATTINI DOPO NOTTI
                //===============================
                for i:=low(Turni) to High(Turni) do
                  if (Not ControlloSuccTurn(DestInd,DataScorr,Vista[i].Giorni[IndScorr].NumTurno1)) or
                     (Not ControlloSuccTurn(i,DataScorr,Vista[DestInd].Giorni[IndScorr].NumTurno1)) then
                    Turni[i].Flag:=False;
                //===============================

                OrigInd:=-1;
                for i:=low(Turni) to High(Turni) do
                  if (Turni[i].Flag) and (OrigInd < 0) then
                    OrigInd:=i;
                if OrigInd > 0 then
                begin
                  VarDModifica:=true;
                  //swap del numero turno
                  Temp:=Vista[DestInd].Giorni[IndScorr].NumTurno1;
                  Vista[DestInd].Giorni[IndScorr].NumTurno1:=Vista[OrigInd].Giorni[IndScorr].NumTurno1;
                  Vista[OrigInd].Giorni[IndScorr].NumTurno1:=Temp;
                  //swap dell'eventuale causale d'assenza
                  Temp:=Vista[DestInd].Giorni[IndScorr].Ass1;
                  Vista[DestInd].Giorni[IndScorr].Ass1:=Vista[OrigInd].Giorni[IndScorr].Ass1;
                  Vista[OrigInd].Giorni[IndScorr].Ass1:=Temp;
                  //nel caso in cui le causali siano diverse da quelle di riposo le azzero
                  if Vista[DestInd].Giorni[IndScorr].Ass1 <> Vista[DestInd].CausRip then
                    Vista[DestInd].Giorni[IndScorr].Ass1:='';
                  if Vista[OrigInd].Giorni[IndScorr].Ass1 <> Vista[OrigInd].CausRip then
                    Vista[OrigInd].Giorni[IndScorr].Ass1:='';

                  Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,
                                                                         Vista[DestInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[OrigInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[OrigInd].Giorni[IndScorr].Ora,
                                                                         Vista[OrigInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[DestInd].Giorni[IndScorr].T1:=' ' +GetT1('T1',Vista[DestInd].Giorni[IndScorr].Ora,
                                                                      Vista[DestInd].Giorni[IndScorr].NumTurno1, DataScorr);
                  Vista[OrigInd].Giorni[IndScorr].T1:=' ' +GetT1('T1',Vista[OrigInd].Giorni[IndScorr].Ora,
                                                                      Vista[OrigInd].Giorni[IndScorr].NumTurno1, DataScorr);

                  Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                  Vista[OrigInd].Giorni[IndScorr].Modificato:=True;
                  {CreaLog(DataScorr,DestInd,'Se non si riesce comunque a raggiungere il minimo provare a scambiare mettendo in gioco anche i giorni in cui il dipendente carente era in riposo V. Individuare dipendente (esubero) con maggior esubero di' +
                                            'turni origine nel bimestre e minor numero di riposi e per ogni giorno in cui viene');}
                  Fest:=VarToStr(SelT010.Lookup('DATA',DataScorr,'FESTIVO'));
                  if (Fest <> 'S') then
                  begin
                    Dec(Turni[DestInd].RipAnno);
                    Inc(Turni[OrigInd].RipAnno);
                  end
                  else if(Fest = 'S') then
                  begin
                    Dec(Turni[DestInd].RipMese);
                    Inc(Turni[OrigInd].RipMese);
                  end;
                  CaricaNTurni(DataElabDa);
                  if (Turni[DestInd].NTurni[DestTurn].Deficit <> '<') then
                    Break;
                end;
              end;
              Application.ProcessMessages;
              inc(IndScorr);
              DataScorr:=DataScorr + 1;
            end;
          end;
          //*********************************************************************************
          //Punto 6: sostituzione di un turno in esubero con il turno in deficit senza
          //considerare altri dipendente, ma controllando i max/min giornalieri della squadra
          //*********************************************************************************
          if (Turni[DestInd].NTurni[DestTurn].Deficit = '<') then
          begin
            OrigTurn:=-1;
            for i:=1 to 4 do
              if ((Turni[DestInd].NTurni[i].Deficit = '>') or (Turni[DestInd].NTurni[i].Deficit = '>>')) then
                OrigTurn:=i;
            if OrigTurn > 0 then
            begin
              DataScorr:=DataElabDa;
              IndScorr:=Trunc(DataElabDa - AInizio);
              while DataScorr <= DataElabA do
              begin
                if (Vista[DestInd].Giorni[IndScorr].NumTurno1 = IntToStr(OrigTurn)) and
                   ControlloSuccTurn(DestInd,DataScorr,IntToStr(OrigTurn)) and ConsideraGiorno(DestInd,0,DataScorr) then
                begin
                  SetLength(VetSquadre,0);
                  GetSquadre(DataScorr,
                             Vista[DestInd].Giorni[IndScorr].Squadra,
                             Vista[DestInd].Giorni[IndScorr].Oper);
                  NumInSquad:=GetNumSquadra(DataScorr,IntToStr(OrigTurn),
                                            Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra,
                                            Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper);
                  Max:=GetNumSquadra(DataScorr,IntToStr(DestTurn),
                                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra,
                                     Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper);
                  Inc(Max);
                  Fest:=VarToStr(SelT010.Lookup('DATA',DataScorr,'FESTIVO'));
                  if Fest = 'S' then
                    if (NumInSquad > VetSquadre[0].MinFes[OrigTurn]) and (Max < VetSquadre[0].MaxFes[DestTurn]) then
                    begin
                      VarDModifica:=True;
                      Vista[DestInd].Giorni[IndScorr].NumTurno1:=IntToStr(OrigTurn);
                      Vista[DestInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(OrigTurn), DataScorr);
                      Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(OrigTurn), DataScorr);
                      Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                      {CreaLog(DataScorr,DestInd,'Scambio x il dip: ' + IntToStr(DestInd) + ' il Turno ' + IntToStr(DestTurn)
                              + ' con il Turno ' + IntToStr(OrigTurn) + ' in Data: ' + DateToStr(DataScorr));}
                    end
                  else
                    if (NumInSquad > VetSquadre[0].MinFer[OrigTurn]) and (Max < VetSquadre[0].MaxFer[DestTurn])  then
                    begin
                      VarDModifica:=True;
                      Vista[DestInd].Giorni[IndScorr].NumTurno1:=IntToStr(OrigTurn);
                      Vista[DestInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[DestInd].Giorni[IndScorr].T1,IntToStr(OrigTurn), DataScorr);
                      Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(OrigTurn), DataScorr);
                      Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                      {CreaLog(DataScorr,DestInd,'Scambio x il dip: ' + IntToStr(DestInd) + ' il Turno ' + IntToStr(DestTurn)
                              + ' con il Turno ' + IntToStr(OrigTurn) + ' in Data: ' + DateToStr(DataScorr));}
                    end;
                end;
                if (Turni[DestInd].NTurni[DestTurn].Deficit <> '<') then
                  Break;
                Application.ProcessMessages;
                inc(IndScorr);
                DataScorr:=DataScorr + 1;
              end;
            end;
          end;
          //*******************
          //Questo è il punto 7
          //*******************
          if (Turni[DestInd].NTurni[DestTurn].Deficit = '<') then
          begin
            DataScorr:=DataElabDa;
            CaricaRiposi(DataScorr);
            IndScorr:=Trunc(DataElabDa - AInizio);
            //Ripeti:=False;
            while DataScorr <= DataElabA do
            begin
              if (Trim(Vista[Turni[DestInd].Indice].Giorni[IndScorr].T1) = '0') and
                 (Vista[Turni[DestInd].Indice].Giorni[IndScorr].Flag <> 'NT') and
                 ControlloSuccTurn(DestInd,DataScorr,IntToStr(DestTurn)) and ConsideraGiorno(DestInd,IndScorr) then
              begin
                SetLength(VetSquadre,0);
                GetSquadre(DataScorr, Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra,
                           Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper);
                //Cercare dipendente (stessa squadra) che ha DestTurno in esubero e metterlo a riposo
                Fest:=VarToStr(SelT010.Lookup('DATA',DataScorr,'FESTIVO'));
                NumInSquad:=GetNumSquadra(DataScorr,IntToStr(DestTurn),
                                          Vista[Turni[DestInd].Indice].Giorni[IndScorr].Squadra,
                                          Vista[Turni[DestInd].Indice].Giorni[IndScorr].Oper);
                if (Fest <> 'S') and (Turni[DestInd].RipAnno > Vista[Turni[DestInd].Indice].CompRip{104}) and
                   (NumInSquad < VetSquadre[0].MaxFer[DestInd]) and (Vista[Turni[DestInd].Indice].CompRip > 0) then
                begin
                  VarDModifica:=true;
                  Vista[DestInd].Giorni[IndScorr].NumTurno1:=IntToStr(DestTurn);
                  Vista[DestInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(DestTurn), DataScorr);
                  Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(DestTurn), DataScorr);
                  Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                  Vista[DestInd].Giorni[IndScorr].Ass1:='';
                  {CreaLog(DataScorr,DestInd,'Forzo il turno mettendo il dipendente a lavorare controllando che non superi il massimo.');}
                  Dec(Turni[DestInd].RipAnno);
                end;
                if (Fest = 'S') and (Turni[DestInd].RipMese > Vista[Turni[DestInd].Indice].ConstMesRip) and
                   (NumInSquad < VetSquadre[0].MaxFes[DestInd]) then
                begin
                  VarDModifica:=true;
                  Vista[DestInd].Giorni[IndScorr].NumTurno1:=IntToStr(DestTurn);
                  Vista[DestInd].Giorni[IndScorr].T1:=' ' + GetT1('T1',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(DestTurn), DataScorr);
                  Vista[DestInd].Giorni[IndScorr].SiglaT1:=GetT1('SIGLA',Vista[DestInd].Giorni[IndScorr].Ora,IntToStr(DestTurn), DataScorr);
                  Vista[DestInd].Giorni[IndScorr].Modificato:=True;
                  Vista[DestInd].Giorni[IndScorr].Ass1:='';
                  {CreaLog(DataScorr,DestInd,'Forzo il turno mettendo il dipendente a lavorare controllando che non superi il massimo.');}
                  Dec(Turni[DestInd].RipMese);
                end;
              end;
              if (Turni[DestInd].NTurni[DestTurn].Deficit <> '<') then
                Break;
              Application.ProcessMessages;
              inc(IndScorr);
              DataScorr:=DataScorr + 1;
            end;
          end;
        end;
        Application.ProcessMessages;
      end;

  end;

  procedure GestisciRiposi;
  var i,j,k,x,NSquad,
      DestGG,OrigGG:Integer;
      DataS:TDateTime;
      Temp:String;
  begin
    SetLength(Turni,0);
    CaricaNTurni(DataElabDa);
    CaricaRiposi(DataElabDa);

    for i:=0 to Vista.Count - 1 do
    begin
      {$IFNDEF IRISWEB}
      A058FGrigliaPianif.LblOPerazioni.Caption:='Controllo riposi per il dipendente ' + Vista[i].Cognome + ' ' + Vista[i].Nome;
      {$ENDIF}
      Application.ProcessMessages;
      CaricaNTurni(DataElabDa);
      //Punto 6.A
      for j:=1 to 4 do
      begin
        if ((Turni[i].NTurni[j].Deficit = '>') or (Turni[i].NTurni[j].Deficit = '>>')) and (Turni[i].RipMese < Vista[Turni[i].Indice].ConstMesRip) and
           (Turni[i].RipAnno < Vista[Turni[i].Indice].CompRip) then
        begin
          VarDModifica:=False;
          DataS:=DataElabDa;
          k:=Trunc(DataElabDa - AInizio);
          while DataS <= DataElabA do
          begin
            if (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) = 'S') and (Turni[i].RipMese < Vista[Turni[i].Indice].ConstMesRip) and
               (Vista[i].Giorni[k].NumTurno1 <> '') and (Trim(Vista[i].Giorni[k].T1) <> '0') and
               (StrToInt(Vista[i].Giorni[k].NumTurno1) = j) and ConsideraGiorno(i,k) then
            begin
              NSquad:=GetNumSquadra(DataS,
                                    Vista[i].Giorni[k].NumTurno1,
                                    Vista[i].Giorni[k].Squadra,
                                    Vista[i].Giorni[k].Oper);
              SetLength(VetSquadre,0);
              GetSquadre(DataS,Vista[i].Giorni[k].Squadra,
                         Vista[i].Giorni[k].Oper);
              if NSquad > VetSquadre[0].MinFes[j] then
              begin
                VarDModifica:=True;
                Vista[i].Giorni[k].NumTurno1:='0';
                Vista[i].Giorni[k].T1:=' 0';
                Vista[i].Giorni[k].SiglaT1:='(R)';
                Vista[i].Giorni[k].Modificato:=True;
                inc(Turni[i].RipMese);
                CaricaNTurni(DataElabDa);
              end;
            end;
            inc(k);
            DataS:=DataS + 1;
          end;
          //Punto 6.B
          if Turni[i].RipMese < Vista[Turni[i].Indice].ConstMesRip then
          begin
            DestGG:=-1;
            OrigGG:=-1;
            DataS:=DataElabDa;
            k:=Trunc(DataS - AInizio);
            while DataS <= DataElabA do
            begin
              if (Vista[i].Giorni[k].NumTurno1 <> '') and
                 (Vista[i].Giorni[k].NumTurno1 >= '1') and
                 (Vista[i].Giorni[k].NumTurno1 <= '4') then
              begin
                NSquad:=GetNumSquadra(DataS,Vista[i].Giorni[k].NumTurno1,
                                      Vista[i].Giorni[k].Squadra,
                                      Vista[i].Giorni[k].Oper);
                SetLength(VetSquadre,0);
                GetSquadre(DataS,Vista[i].Giorni[k].Squadra, Vista[i].Giorni[k].Oper);
                if (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) = 'S') and (ControlloSuccTurn(i,DataS,Vista[i].Giorni[k].NumTurno1)) and
                   (NSquad > VetSquadre[0].MinFes[StrToInt(Vista[i].Giorni[k].NumTurno1)]) and ConsideraGiorno(i,k) then
                  DestGG:=k;
                if (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) = 'S') and ControlloSuccTurn(i,DataS,Vista[i].Giorni[k].NumTurno1) and
                   (Trim(Vista[i].Giorni[k].T1) <> '0') and
                   (NSquad < VetSquadre[0].MaxFer[StrToInt(Vista[i].Giorni[k].NumTurno1)]) and ConsideraGiorno(i,k) then
                  OrigGG:=K;
              end;
              Inc(k);
              DataS:=DataS + 1;
            end;
            if (DestGG > 0) and (OrigGG > 0) then
            begin
              VarDModifica:=True;
              Temp:=Vista[i].Giorni[DestGG].NumTurno1;
              Vista[i].Giorni[DestGG].NumTurno1:=Vista[i].Giorni[OrigGG].NumTurno1;;
              Vista[i].Giorni[OrigGG].NumTurno1:=Temp;

              Vista[i].Giorni[DestGG].T1:=' ' + GetT1('T1',Vista[i].Giorni[DestGG].Ora,
                                                           Vista[i].Giorni[DestGG].NumTurno1,
                                                           Vista[i].Giorni[DestGG].Data);
              Vista[i].Giorni[OrigGG].T1:=' ' + GetT1('T1',Vista[i].Giorni[OrigGG].Ora,
                                                           Vista[i].Giorni[OrigGG].NumTurno1,
                                                           Vista[i].Giorni[OrigGG].Data);

              Vista[i].Giorni[DestGG].SiglaT1:=GetT1('SIGLA',Vista[i].Giorni[DestGG].Ora,
                                                             Vista[i].Giorni[DestGG].NumTurno1,
                                                             Vista[i].Giorni[DestGG].Data);
              Vista[i].Giorni[OrigGG].SiglaT1:=GetT1('SIGLA',Vista[i].Giorni[OrigGG].Ora,
                                                             Vista[i].Giorni[OrigGG].NumTurno1,
                                                             Vista[i].Giorni[OrigGG].Data);
              Vista[i].Giorni[OrigGG].Modificato:=True;
              Vista[i].Giorni[DestGG].Modificato:=True;
            end;
          end;
          //Punto 6.C
          if Turni[i].RipMese < Vista[Turni[i].Indice].ConstMesRip then
          begin
            for x:=0 to Vista.Count - 1 do
              if Turni[x].RipMese > Vista[Turni[x].Indice].ConstMesRip then
              begin
                DataS:=DataElabDa;
                k:=Trunc(DataS - AInizio);
                while (DataS <= DataElabA) do
                begin
                  if (Vista[i].Giorni[k].NumTurno1 <> '') and (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) = 'S') and
                     (Turni[x].RipMese > Vista[Turni[x].Indice].ConstMesRip) and (Trim(Vista[i].Giorni[k].T1) <> '0') and
                     (Vista[i].Giorni[k].Squadra = Vista[x].Giorni[k].Squadra) and
                     (Vista[i].Giorni[k].Oper = Vista[x].Giorni[k].Oper) and
                     ((Turni[i].NTurni[StrToInt(Trim(Vista[i].Giorni[k].NumTurno1))].Deficit = '>') or
                     (Turni[i].NTurni[StrToInt(Trim(Vista[i].Giorni[k].NumTurno1))].Deficit = '>>'))and
                     ControlloSuccTurn(i,DataS,Vista[x].Giorni[k].NumTurno1) and
                     ControlloSuccTurn(x,DataS,Vista[i].Giorni[k].NumTurno1) and
                     AssenzaGG(x,k) and AssenzaGG(i,k) and ConsideraGiorno(i,k) and ConsideraGiorno(x,k) then
                  begin
                    VarDModifica:=True;
                    Temp:=Vista[i].Giorni[k].NumTurno1;
                    Vista[i].Giorni[k].NumTurno1:=''{TGiorno(TDipendente(Vista[x]).Giorni[k]).NumTurno1};
                    Vista[x].Giorni[k].NumTurno1:=Temp;

                    Vista[x].Giorni[k].T1:=' ' + GetT1('T1',Vista[x].Giorni[k].Ora,Vista[x].Giorni[k].NumTurno1, DataS);
                    Vista[x].Giorni[k].SiglaT1:=GetT1('SIGLA',Vista[x].Giorni[k].Ora,Vista[x].Giorni[k].NumTurno1, DataS);
                    Vista[i].Giorni[k].T1:=' 0';
                    Vista[i].Giorni[k].SiglaT1:='(R)';
                    Vista[x].Giorni[k].Modificato:=True;
                    Vista[i].Giorni[k].Modificato:=True;
                    CaricaNTurni(DataElabDa);
                    if Vista[x].Giorni[k].Ass1 = Vista[x].CausRip then
                      Vista[x].Giorni[k].Ass1:='';
                    if Vista[i].Giorni[k].Ass1 = Vista[i].CausRip then
                      Vista[i].Giorni[k].Ass1:='';
                    dec(Turni[x].RipMese);
                    inc(Turni[i].RipMese);
                  end;
                  DataS:=DataS + 1;
                  inc(k);
                end;
              end;
          end;
        end;
      end;
    end;
  end;

  procedure CoperturaTurni;
  var i,j,k,NumSquadra,NMesi,RXMese,DecMese:Integer;
      DataS:TDateTime;
      Modif:Boolean;
  begin
    SetLength(Turni,0);
    CaricaNTurni(DataElabDa);
    CaricaRiposi(DataElabDa);
    NMesi:=-1;
    if (1 = R180Giorno(DataInizio)) and (R180Anno(DataInizio) = R180Anno(DataFine)) then
      NMesi:=12 - R180Mese(DataInizio) + 1;

    for i:=0 to Vista.Count - 1 do
    begin
      //Calcolo il numero di riposi da distribuire per il mese
      RXMese:=-1;
      DecMese:=-1;
      if (NMesi > 0) and (Turni[i].RipAnno > Vista[i].ConstMesRip) then
      begin
        RXMese:=Turni[i].RipAnno - Vista[i].CompRip;
        RXMese:=RXMese div NMesi;
        DecMese:=RXMese;
      end;

      for k:=1 to 4 do
      begin
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.LblOPerazioni.Caption:='Controllo turno ' + IntToStr(k)
        + ' per il dipendente ' + Vista[i].Cognome + ' ' + Vista[i].Nome;
        {$ENDIF}
        Application.ProcessMessages;
        if ((Turni[i].RipMese > Vista[Turni[i].Indice].ConstMesRip) or (Turni[i].RipAnno > Vista[Turni[i].Indice].CompRip{104})) and
           ((Turni[i].NTurni[k].Deficit <> '>>') and (Turni[i].NTurni[k].Deficit <> 'NV')) then
        begin
          DataS:=DataElabDa;
          j:=Trunc(DataS - AInizio);
          while DataS <= DataElabA do
          begin
            if (R180Giorno(DataS) = 1) then
              DecMese:=RXMese;

            Modif:=False;
            if (Trim(Vista[i].Giorni[j].T1) = '0') and
               AssenzaGG(i,j) and ((DecMese > 0) or (DecMese < 0)) and ConsideraGiorno(i,j) then
            begin
              NumSquadra:=GetNumSquadra(DataS,IntToStr(k),
                                        Vista[i].Giorni[j].Squadra,
                                        Vista[i].Giorni[j].Oper);
              SetLength(VetSquadre,0);
              GetSquadre(DataS,Vista[i].Giorni[j].Squadra,
                         Vista[i].Giorni[j].Oper);
              //Controllo GG festivi
              if (Turni[i].RipMese > Vista[Turni[i].Indice].ConstMesRip) and
                 (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) = 'S') and ControlloSuccTurn(i,DataS,IntToStr(k)) and
                 (Trim(Vista[i].Giorni[j].T1) = '0') and
                 (NumSquadra < VetSquadre[0].MaxFes[k]) and (GetT1('T1',Vista[i].Giorni[j].Ora,IntToStr(k),DataS) <> 'E') then
              begin
                Vista[i].Giorni[j].NumTurno1:=IntToStr(k);
                Vista[i].Giorni[j].T1:=' ' + GetT1('T1',Vista[i].Giorni[j].Ora,
                                                        Vista[i].Giorni[j].NumTurno1,DataS);
                Vista[i].Giorni[j].SiglaT1:=GetT1('SIGLA',Vista[i].Giorni[j].Ora,
                                                          Vista[i].Giorni[j].NumTurno1,DataS);
                //Se la causale è uguale alla causale di riposo la cencello
                if Vista[i].Giorni[j].Ass1 = Vista[i].CausRip then
                  Vista[i].Giorni[j].Ass1:='';
                if Vista[i].Giorni[j].Ass2 = Vista[i].CausRip then
                  Vista[i].Giorni[j].Ass2:='';

                Vista[i].Giorni[j].Modificato:=True;
                Dec(Turni[i].RipMese);
                Modif:=True;
              end;
              //Controllo GG feriali
              if (Turni[i].RipAnno > Vista[Turni[i].Indice].CompRip{104}) and
                 (VarToStr(SelT010.Lookup('DATA',DataS,'FESTIVO')) <> 'S') and ControlloSuccTurn(i,DataS,IntToStr(k)) and
                 (Trim(Vista[i].Giorni[j].T1) = '0') and
                 (NumSquadra < VetSquadre[0].MaxFer[k]) and (GetT1('T1',Vista[i].Giorni[j].Ora,IntToStr(k),DataS) <> 'E') then
              begin
                Vista[i].Giorni[j].NumTurno1:=IntToStr(k);
                Vista[i].Giorni[j].T1:=' ' + GetT1('T1',Vista[i].Giorni[j].Ora,
                                                        Vista[i].Giorni[j].NumTurno1,DataS);
                Vista[i].Giorni[j].SiglaT1:=GetT1('SIGLA',Vista[i].Giorni[j].Ora,
                                                          Vista[i].Giorni[j].NumTurno1,DataS);
                //Se la causale è uguale alla causale di riposo la cencello
                if Vista[i].Giorni[j].Ass1 = Vista[i].CausRip then
                  Vista[i].Giorni[j].Ass1:='';
                if Vista[i].Giorni[j].Ass2 = Vista[i].CausRip then
                  Vista[i].Giorni[j].Ass2:='';

                Vista[i].Giorni[j].Modificato:=True;
                Dec(Turni[i].RipAnno);
                Modif:=True;
              end;
              if Modif then
              begin
                CaricaNTurni(DataS);
                Dec(DecMese);
              end;
            end;
            DataS:=DataS + 1;
            inc(j);
          end;
        end;
        {=========================================}
      end;
    end;
  end;

  procedure GeneraLogAnomalie;
  var i,j,k,Numero,TempMese:Integer;
      DataScorr,DataMeseDa,DataMeseA,
      BimestreDa,BimestreA:TDateTime;
      Squadra,MemLog:String;
      DtsMsg:TClientDataSet;
  begin
    if Not SelT010.Active then
    begin
      SelT010.Close;
      SelT010.SetVariable('PROGRESSIVO',Vista[0].Prog);
      SelT010.SetVariable('DATA1',AInizio);
      SelT010.SetVariable('DATA2',AFine);
      SelT010.Open;
    end;
    AnomaliePianif:=False;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie Massimi e minimi giornalieri>>');
    DataScorr:=DataElabDa;
    SetLength(VetSquadre,0);
    GetSquadre(DataScorr);
    while DataScorr <= DataElabA do
    begin
      for i:=low(VetSquadre) to High(VetSquadre) do
      begin
        Squadra:='';
        Squadra:=VetSquadre[i].Squadra;
        if VetSquadre[i].Operatore <> '' then
          Squadra:=Squadra + '(' + VetSquadre[i].Operatore + ') ';
        for j:=1 to 4 do
        begin
          Numero:=GetNumSquadra(DataScorr,IntToStr(j),VetSquadre[i].Squadra,VetSquadre[i].Operatore);
          if VarToStr(selT010.Lookup('DATA',DataScorr,'FESTIVO')) <> 'S' then
          begin
            if Numero < VetSquadre[i].MinFer[j] then
              RegAnom(-1,0,0,Squadra + ' Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + IntTostr(j) + ' minore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(VetSquadre[i].MinFer[j])+ ')');
            if Numero > VetSquadre[i].MaxFer[j] then
              RegAnom(-1,0,0,Squadra + ' Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + IntTostr(j) + ' maggiore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(VetSquadre[i].MaxFer[j]) + ')');
          end
          else
          begin
            if Numero < VetSquadre[i].MinFes[j] then
              RegAnom(-1,0,0,Squadra + 'Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + IntTostr(j) + ' minore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(VetSquadre[i].MinFes[j]) + ')');
            if Numero > VetSquadre[i].MaxFes[j] then
              RegAnom(-1,0,0,Squadra + 'Data:' + DateToStr(DataScorr) + ' Numero dei dipendenti in squadra per il turno ' + IntTostr(j) + ' maggiore di quelli previsti.'
                                     + #13#10 + '(Assegnati:' + IntToStr(Numero) + ' - Previsti:' + IntToStr(VetSquadre[i].MaxFes[j]) + ')');
          end;
        end;
      end;
      DataScorr:=DataScorr + 1;
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie di successione nei turni>>');
    DataScorr:=DataElabDa;
    k:=Trunc(DataScorr - AInizio);
    while DataScorr <= DataElabA do
    begin
      if (k > 0) and (k < Vista.Count - 1) then
        for i:=0 to Vista.Count - 1 do
          if Not ControlloSuccTurn(i,DataScorr,Vista[i].Giorni[k].NumTurno1) then
            RegAnom(i,DataScorr,0,'Pianificato turno di mattino o pomeriggio dopo turno notturno.');
      DataScorr:=DataScorr + 1;
      inc(k);
    end;
    RegistraMsg.InserisciMessaggio('A','<<Anomalie numero turni effettuati nel quadrimestre e riposi>>');
    BimestreDa:=0;
    BimestreA:=0;
    DtsMsg:=TClientDataSet.Create(nil);
    DtsMsg.FieldDefs.Add('MESSAGGIO',ftString,100,False);
    DtsMsg.CreateDataSet;
    DtsMsg.Open;
    for TempMese:=R180Mese(DataElabDa) to R180Mese(DataElabA) do
    begin
      DataMeseda:=EncodeDate(R180Anno(DataElabDa),TempMese,R180Giorno(DataElabDa));
      DataMeseA:=R180FineMese(EncodeDate(R180Anno(DataDaTemp),TempMese,1));
      SetLength(Turni,0);
      CaricaNTurni(DataMeseDa);
      CaricaRiposi(DataMeseDa);
      for i:=0 to Vista.Count-1 do
      begin
        for j:=1 to 4 do
          if (Turni[i].NTurni[j].Deficit = '<') then
          begin
            BimestreDa:=ElabPeriodo(DataMeseDa,Vista[0].ConstElabPeriodo,'INIZIO');
            BimestreA:=ElabPeriodo(DataMeseA,Vista[0].ConstElabPeriodo,'FINE');
            MemLog:=IntToStr(i) + DateToStr(BimestreDa) + DateToStr(BimestreA) + IntToStr(j);
            MemLog:=UpperCase(MemLog);
            if VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '' then
            begin
              RegAnom(i,BimestreDa,BimestreA,'Turno numero ' + IntToStr(j) + ' non raggiunge il numero minimo contrattuale nel periodo di ' + IntToStr(Vista[0].ConstElabPeriodo) + ' mesi.('
                      + IntToStr(Turni[i].NTurni[j].Numero) + ')');
              DtsMsg.Insert;
              DtsMsg.FieldByName('MESSAGGIO').AsString:=MemLog;
              DtsMsg.Post;
            end;
          end;
        MemLog:=IntToStr(i) + DateToStr(BimestreDa) + DateToStr(BimestreA) + 'Numero festivi a riposo del mese minore di ' + IntToStr(Vista[Turni[i].Indice].ConstMesRip);
        MemLog:=UpperCase(MemLog);
        if (Turni[i].RipMese < Vista[Turni[i].Indice].ConstMesRip) and
           (VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '') then
        begin
          RegAnom(i,DataMeseA,0,'Numero festivi a riposo del mese minore di ' + IntToStr(Vista[Turni[i].Indice].ConstMesRip));
          DtsMsg.Insert;
          DtsMsg.FieldByName('MESSAGGIO').AsString:=UpperCase(MemLog);
          DtsMsg.Post;
        end;
        MemLog:=IntToStr(i) + DateToStr(AInizio) + DateToStr(AFine) + 'Numero di riposi nell''anno minori di ' + IntToStr(Vista[Turni[i].Indice].CompRip) + '(' + IntToStr(Turni[i].RipAnno) + ')';
        MemLog:=UpperCase(MemLog);
        if (Turni[i].RipAnno < Vista[Turni[i].Indice].CompRip) and
           (VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '') then
        begin
          RegAnom(i,AInizio,AFine,'Numero di riposi nell''anno minori di ' + IntToStr(Vista[Turni[i].Indice].CompRip) + '(' + IntToStr(Turni[i].RipAnno) + ')');
          DtsMsg.Insert;
          DtsMsg.FieldByName('MESSAGGIO').AsString:=UpperCase(MemLog);
          DtsMsg.Post;
        end;
        MemLog:=IntToStr(i) + DateToStr(AInizio) + DateToStr(AFine) + 'Numero di riposi nell''anno maggiore di ' + IntToStr(Vista[Turni[i].Indice].CompRip) + '(' + IntToStr(Turni[i].RipAnno) + ')';
        MemLog:=UpperCase(MemLog);
        if (Turni[i].RipAnno > Vista[Turni[i].Indice].CompRip) and
           (VarToStr(DtsMsg.Lookup('MESSAGGIO',MemLog,'MESSAGGIO')) = '') then
        begin
          RegAnom(i,AInizio,AFine,'Numero di riposi nell''anno maggiore di ' + IntToStr(Vista[Turni[i].Indice].CompRip) + '(' + IntToStr(Turni[i].RipAnno) + ')');
          DtsMsg.Insert;
          DtsMsg.FieldByName('MESSAGGIO').AsString:=UpperCase(MemLog);
          DtsMsg.Post;
        end;
      end;
    end;
    DtsMsg.Close;
    FreeAndNil(DtsMsg);
    if (TempMese mod 2) <> 0 then
      MemLog:='';
  end;

  procedure RipristinoVista;
  begin
    PulisciVista;
    SelAnagrafeA058.First;
    while Not(SelAnagrafeA058.Eof) do
    begin
      LeggiPianificazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,
                          DataElabDa,DataElabA);
      SelAnagrafeA058.Next;
      Application.ProcessMessages;
    end;
  end;
//====================================
//IMPLEMENTAZIONE PROCEDURA PRINCIPALE
//====================================
begin
  RegistraMsg.IniziaMessaggio('A058');
  AInizio:=ModificaData(DataElabDa,0,1,1);
  AFine:=ModificaData(DataElabA,0,12,31);
  {$IFNDEF IRISWEB}
  A058FGrigliaPianif.PGVista.Min:=0;
  A058FGrigliaPianif.PGVista.Max:=2 + (3 * (R180Mese(DataElabA) - R180Mese(DataElabDa))+1);
  A058FGrigliaPianif.PGVista.Position:=0;
  {$ENDIF}
  ElaborazioneInterrotta:=False;
  Screen.Cursor:=crHourGlass;
  try
    {$IFNDEF IRISWEB}
    if A058FGrigliaPianif.DatoModificato or (DataInizio <> ModificaData(DataInizio,0,1,1)) or
      (DataFine <> ModificaData(DataFine,0,12,31)) then
    begin
      PulisciVista;
      SelAnagrafeA058.First;
      while Not(SelAnagrafeA058.Eof) do
      begin
        A058FGrigliaPianif.LblOPerazioni.Caption:='Caricamento annuale vista: ' +
                                                  SelAnagrafeA058.FieldByName('COGNOME').AsString +
                                                  ' ' + SelAnagrafeA058.FieldByName('NOME').AsString;
        Application.ProcessMessages;
        LeggiPianificazione(SelAnagrafeA058.FieldByName('PROGRESSIVO').AsInteger,
                            AInizio,AFine);

        SelAnagrafeA058.Next;
        if ElaborazioneInterrotta then
          Break;
        Application.ProcessMessages;
      end;
      A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
    end;
    {$ENDIF}
    if ElaborazioneInterrotta then
    begin
      RipristinoVista;
      Exit;
    end;
    SelT010.Close;
    SelT010.SetVariable('PROGRESSIVO',Vista[0].Prog);
    SelT010.SetVariable('DATA1',AInizio);
    SelT010.SetVariable('DATA2',AFine);
    SelT010.Open;
    DataCorr:=DataElabDa;
    ICorr:=Trunc(DataElabDa - AInizio);
    OffsetVista:=ICorr;

    //===================================================
    //CARICAMENTO DELLE COMPETENZE DEI RIPOSI NEL PERIODO
    //===================================================
    R600DtM:=TR600DtM1.Create(nil);
    try
      for xx:=0 to Vista.Count - 1 do
      begin
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=Vista[xx].CausRip;
        R600DtM.GetAssenze(Vista[xx].Prog,DataElabDa,DataElabA,0,G);
        Vista[xx].CompRip:=Trunc(R600DtM.ValCompTot);
      end;
    finally
      FreeAndNil(R600DtM);
    end;

    if SoloLOG = 'N' then
    begin
      //Ciclo scorrimento dei giorni
      while DataCorr <= DataElabA do
      begin
        //Carico dati Squadre e apro il DataSet "sel2T600"
        //il quale mi servirà in seguito
        SetLength(VetSquadre,0);
        GetSquadre(DataCorr);
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.LblOPerazioni.Caption:='Controllo massimi e minimi giornalieri per le squadre';
        {$ENDIF}
        Application.ProcessMessages;

        //Ciclo scorrimento del vettore squadre
        for ISquadre:=low(VetSquadre) to High(VetSquadre) do
        begin
          IndOrdTurn:=1;
          while IndOrdTurn <= 4 do
          begin
            repeat
              VarDModifica:=False;
              GestisciMinimi('RIP',VetSquadre[ISquadre].VetOrdTurn[IndOrdTurn]);
            until Not(VarDModifica);
            inc(IndOrdTurn);
          end;
        end;

        //Ciclo scorrimento del vettore squadre
        for ISquadre:=low(VetSquadre) to High(VetSquadre) do
        begin
          IndOrdTurn:=1;
          while IndOrdTurn <= 4 do
          begin
            repeat
              VarDModifica:=False;
              GestisciMinimi('FER',VetSquadre[ISquadre].VetOrdTurn[IndOrdTurn]);
            until Not(VarDModifica);
            inc(IndOrdTurn);
          end;
        end;

        //Ciclo scorrimento del vettore squadre
        for ISquadre:=low(VetSquadre) to High(VetSquadre) do
        begin
          IndOrdTurn:=1;
          while IndOrdTurn <= 4 do
          begin
            repeat
              VarDModifica:=False;
              GestisciMassimi(VetSquadre[ISquadre].VetOrdTurn[IndOrdTurn]);
            until Not(VarDModifica);
            Inc(IndOrdTurn);
          end;
        end;

        Application.ProcessMessages;
        ICorr:=ICorr + 1;
        DataCorr:=DataCorr + 1;
      end;
      {$IFNDEF IRISWEB}
      A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
      A058FGrigliaPianif.Repaint;
      {$ENDIF}
      DataDaTemp:=DataElabDa;
      DataATemp:=DataElabA;

      for Mese:=R180Mese(DataDaTemp) to R180Mese(DataATemp) do
      begin
        DataElabDa:=EncodeDate(R180Anno(DataDaTemp),Mese,R180Giorno(DataDaTemp));
        DataElabA:=R180FineMese(EncodeDate(R180Anno(DataDaTemp),Mese,1));
        //Controllo che siano rispettati i minimi dei turni del bimestre
        MinimoTurni;
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.Repaint;
        A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
        {$ENDIF}
        //Controllo che sia effettuato almeno 1 riposo festivo nell'arco del mese
        GestisciRiposi;
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.Repaint;
        A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
        {$ENDIF}
        //Se c'è 1 eccesso di riposi, li uso x compensare i turni carenti nel bimestre
        CoperturaTurni;
        {$IFNDEF IRISWEB}
        A058FGrigliaPianif.Repaint;
        A058FGrigliaPianif.PGVista.Position:=A058FGrigliaPianif.PGVista.Position + 1;
        {$ENDIF}
      end;
      DataElabDa:=DataDaTemp;
      DataElabA:=DataATemp;
    end;
    GeneraLogAnomalie;

    SelT010.Close;
    sel2T600.Close;
    SelOperatori.Close;
  finally
    {$IFNDEF IRISWEB}
    if A058FGrigliaPianif <> nil then
      A058FGrigliaPianif.PGVista.Position:=0;
    {$ENDIF}
    Screen.Cursor:=crDefault;
  end;
end;

end.
