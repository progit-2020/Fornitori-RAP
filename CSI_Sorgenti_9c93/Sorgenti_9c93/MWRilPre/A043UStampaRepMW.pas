unit A043UStampaRepMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, Math, DBClient, ComCtrls, StrUtils,
  USelI010, R005UDataModuleMW, Rp502Pro, QueryStorico, DatiBloccati,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali;

type
  TRiepilogo = record
    VP_Turno:String;
    VP_Ore:String;
    VP_Maggiorate:String;
    VP_NonMaggiorate:String;
    VP_GettRep:String;
    VP_Turni_oltremax:String;
    UnitaTurno:Integer;
    TotGettRep:Integer;
    TotOltreMax:Integer;
    TotDiff:Integer;
    TotDurata:Integer;
    TotOreLavorate:Integer;
    TotOreNormali:Integer;
    TotOreMagg:Integer;
    TotOreNonMagg:Integer;
    TurniInteri:Integer;
    TurniInOre:Integer;
    ResiduoPrec:Integer;
  end;

  TTimbCompresenza = record
    E,U:Integer;
  end;

  TA043FStampaRepMW = class(TR005FDataModuleMW)
    QContratti: TOracleDataSet;
    QContrattiCODICE: TStringField;
    QContrattiDESCRIZIONE: TStringField;
    QContrattiREPERIBILITA: TStringField;
    QCausaliPResenza: TOracleDataSet;
    QCausaliPResenzaCODICE: TStringField;
    QCausaliPResenzaDETREPERIB: TStringField;
    QSostitutivo: TOracleDataSet;
    Q380Sost: TOracleDataSet;
    Q350RegReperib: TOracleDataSet;
    Q350RegReperibCODICE: TStringField;
    Q350RegReperibDESCRIZIONE: TStringField;
    Q350RegReperibTIPOORE: TStringField;
    Q350RegReperibORENORMALI: TDateTimeField;
    Q350RegReperibORAINIZIO: TDateTimeField;
    Q350RegReperibORAFINE: TDateTimeField;
    Q350RegReperibORENONCAUS: TStringField;
    Q350RegReperibTOLLERANZA: TFloatField;
    Q350RegReperibTIPOTURNO: TStringField;
    Q350RegReperibRAGGRUPPAMENTO: TStringField;
    Q350RegReperibORECOMPRESENZA: TDateTimeField;
    Q350RegReperibVP_TURNO: TStringField;
    Q350RegReperibVP_ORE: TStringField;
    Q350RegReperibVP_MAGGIORATE: TStringField;
    Q350RegReperibVP_NONMAGGIORATE: TStringField;
    Q350RegReperibVP_GETTONE_CHIAMATA: TStringField;
    Q350RegReperibVP_TURNI_OLTREMAX: TStringField;
    Q350RegReperibTURNO_INTERO: TStringField;
    Q350RegReperibDETRAZ_MENSA: TStringField;
    Q350RegReperibORE_MIN_INDENNITA: TStringField;
    Q350RegReperibPIANIF_MAX_MESE: TIntegerField;
    Q350RegReperibPIANIF_MAX_MESE_TURNI_INTERI: TStringField;
    Q380Pianif: TOracleDataSet;
    D010: TDataSource;
    QCausaliAssenza: TOracleDataSet;
    QCausaliAssenzaCODICE: TStringField;
    QCausaliAssenzaDETREPERIB: TStringField;
    QCausaliAssenzaDETREPERIB_TOTALE: TStringField;
    QMesePrecedente: TOracleDataSet;
    QDelete: TOracleQuery;
    QInsert: TOracleQuery;
    Q110: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q380PianifFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    arrTimbCompresenza: array of TTimbCompresenza;
    arrTimbConteggiate: array of TTimbCompresenza;
    R502ProDtM1:TR502ProDtM1;
    GiaScaricato,bRiepilogoBloccato:Boolean;
    TotMeseTurniPianif: Integer;
    TotMeseTurniInteri: Real;
    TotMeseTurniPianifInteri: Integer;
    function LeggiTipoContratto(Progr:Integer; DataCorr:TDateTime; Contratto:String):String;
    function LeggiParametriCausalePresenza(Causale:String):Boolean;
    function GetCompresenza(Data:TDateTime; OraI,OraF:String):Integer;
    function GetValoreCampoRaggruppamento(ProgCorr:Integer;DataCorr:TDateTime;Campo:String):String;
    function GestisciTurnoSostitutivo(Prog:Integer;Data:TDateTime;Campo,ValoreCampo:String):Boolean;
    function SenzaTurno(Prog:LongInt; Data:TDateTime; OraI,OraF:String; TurniUguali:Boolean = False):Boolean;
    function ElaboraConteggiSostitutivi:Integer;
    function GetRiepilogo(DS:TDataSet):Integer;
    function LeggiDurataTurno(Data:TDateTime; Codice:String):Integer;
    function LeggiTipoTurno(Codice:String):String;
    function LeggiOreNonCaus(CodiceTurno:String):Boolean;
    function LeggiRaggruppamento(Codice:String):String;
    function TurnoMezzanotte(Codice:String):Boolean;
    function ElaboraConteggi(OreNonCaus:Boolean; Inizio,Fine,DetrazMensa:String):Integer;
    function LeggiParametriCausaleAssenza(Causale:String):Boolean;
    procedure LeggiParametriMaggiorazione(CodTurno:String;var Tipo,OreNormali:Integer);
    procedure InserisciDipendente(Prog:Integer;Data:TDateTime;Turno,DTurno,Contratto,Anomalia:String;DurataTurno,OreLavorate,InGettRep:Integer;CalcolaIndennita:Boolean = True);
    procedure ChiusuraRiepilogo(Progressivo:Integer);
    procedure SalvataggioDatiTurni(Prog:Integer);
    procedure LeggiTurni(Data:TDateTime;var T1,T2,T3,Tipo1,Tipo2,Tipo3,Ragg1,Ragg2,Ragg3:String; var Durata1,Durata2,Durata3:Integer);
    procedure ConteggiDalleAlle(Prog:LongInt; Data:TDateTime; Turno,Tipo,Ragg:String; Durata:Integer; var Riduz, OutGettRep:Integer);
  public
    selI010:TselI010;
    DataFiltro:TDateTime;
    Riepilogo:array of TRiepilogo;
    NessunaAnomalia,SalvaDatiTurni:Boolean;
    lstAnomalie:TStringList;
    A043ProgressBar:TProgressBar;
    A043chkCumula, A043chkSpezzoniMese, A043chkIgnoraAnomalie:Boolean;
    A043DataI, A043DataF:TDateTime;
    A043CampoRagg:String;
    selDatiBloccati:TDatiBloccati;
    DocumentoPDF,CodForm,TipoModulo:String; //CS=ClientServer, COM=COMServer
    procedure CalcolaParametriTurno(Data:TDateTime; Turno:String; var DataIni,DataFin,OraIni,OraFin,DetrazMensa:String; var Tolleranza,OreCompresenza:Integer);
    procedure CreaTabellaStampa;
    procedure CalcolaRiepiloghi;
    procedure CumuloGiornaliero;
    procedure AzzeraContatori;
    procedure ElaboraReperib;
    procedure CumulaMesePrecedente(Prog:LongInt);
  end;

implementation

{$R *.dfm}

procedure TA043FStampaRepMW.DataModuleCreate(Sender: TObject);
{Preparo le query Mensili}
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  CreaTabellaStampa;
  QContratti.Open;
  Q350RegReperib.Open;

  QCausaliPresenza.Open;
  QCausaliAssenza.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
  Q110.Open;
  lstAnomalie:=TStringList.Create;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  TipoModulo:='CS';
end;

procedure TA043FStampaRepMW.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(R502ProDtM1);
  FreeAndNil(selI010);
  FreeAndNil(lstAnomalie);
  FreeAndNil(selDatiBloccati);
end;

procedure TA043FStampaRepMW.Q380PianifFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=DataSet.FieldByName('DATA').AsDateTime = DataFiltro;
end;

// Leggo il contratto per sapere le ore di reperibilit�
function TA043FStampaRepMW.LeggiTipoContratto(Progr:Integer; DataCorr:TDateTime; Contratto:String):String;
begin
  Result:='';
  if QContratti.Locate('Codice',Contratto,[loCaseInsensitive]) then
    Result:=QContratti.FieldByName('Reperibilita').AsString;
end;

// Indica se devo togliere le ore causalizzate dal turno di reperibilit�
function TA043FStampaRepMW.LeggiParametriCausalePresenza(Causale:String):Boolean;
begin
  Result:=False;
  if QCausaliPresenza.Locate('Codice',Causale,[loCaseInsensitive]) then
    Result:=QCausaliPresenza.FieldByName('DetReperib').AsString <> 'N';
end;

function TA043FStampaRepMW.GetCompresenza(Data:TDateTime; OraI,OraF:String):Integer;
{Restituisce i minuti di compresenza di altri dipendenti appartenenti
 alla stessa squadra dell'interessato}
var i,j,AppProg:Integer;
    NomeSost,OraDa,OraA:String;
begin
  SetLength(arrTimbCompresenza,0);
  OraDa:=Copy(OraI,1,2) + Copy(OraI,4,2);
  OraA:=Copy(OraF,1,2) + Copy(OraF,4,2);
  with QSostitutivo do
    while not Eof do
    begin
      if SenzaTurno(FieldByName('Progressivo').AsInteger,Data,OraI,OraF,True) then
      begin
        AppProg:=FieldByName('Progressivo').AsInteger;
        NomeSost:=FieldByName('Cognome').AsString;
        if OraI >= OraF then
        begin
          R502ProDtM1.f03_com:='DALLE*' + OraDa + 'ALLE*' + OraA + '+';
          R502ProDtM1.Conteggi('Cartolina',AppProg,Data);
        end
        else
        begin
          R502ProDtM1.f03_com:='DALLE*' + OraDa + '*ALLE*' + OraA;
          R502ProDtM1.Conteggi('Cartolina',AppProg,Data);
        end;
        R502ProDtM1.f03_com:='';
        if R502ProDtM1.Blocca = 0 then
        begin
          //Result:=Result + ElaboraConteggiSostitutivi;
          j:=High(arrTimbCompresenza);
          SetLength(arrTimbCompresenza,Length(arrTimbCompresenza) + R502ProDtM1.n_timbrcon);
          for i:=1 to R502ProDtM1.n_timbrcon do
          begin
            inc(j);
            if (R502ProDtM1.ttimbraturecon[i].ggsucc) and (R502ProDtM1.ttimbraturecon[i].tminutic_u <= 1440) then
            begin
              arrTimbCompresenza[j].E:=R502ProDtM1.ttimbraturecon[i].tminutic_e + 1440;
              arrTimbCompresenza[j].U:=R502ProDtM1.ttimbraturecon[i].tminutic_u + 1440;
            end
            else
            begin
              arrTimbCompresenza[j].E:=R502ProDtM1.ttimbraturecon[i].tminutic_e;
              arrTimbCompresenza[j].U:=R502ProDtM1.ttimbraturecon[i].tminutic_u;
            end;
          end;
        end;
      end;
      Next;
    end;
  Result:=ElaboraConteggiSostitutivi;
end;

// Calcolo il valore del campo di raggruppamento.
function TA043FStampaRepMW.GetValoreCampoRaggruppamento(ProgCorr:Integer;DataCorr:TDateTime;Campo:String):String;
begin
  Result:='';
  QSostitutivo.Close;
  QSostitutivo.Sql.Clear;
  QSostitutivo.DeleteVariables;
  QSostitutivo.Sql.Add(Format('SELECT %s FROM T430_STORICO WHERE PROGRESSIVO = %d',[Campo,ProgCorr]));
  QSostitutivo.Sql.Add(Format('AND ''%s'' BETWEEN DATADECORRENZA AND DATAFINE',[FormatDateTime('dd/mm/yyyy',DataCorr),FormatDateTime('dd/mm/yyyy',DataCorr)]));
  try
    QSostitutivo.Open;
    if QSostitutivo.RecordCount > 0 then
      Result:=QSostitutivo.FieldByName(Campo).AsString;
  except
  end;
end;

function TA043FStampaRepMW.GestisciTurnoSostitutivo(Prog:Integer;Data:TDateTime;Campo,ValoreCampo:String):Boolean;
{Richiamo i dipendenti con la squadra specificata nella Query QSostitutivo}
begin
  Result:=False;
  QSostitutivo.Close;
  QSostitutivo.DeleteVariables;
  QSostitutivo.Sql.Clear;
  //QSostitutivo.Sql.Text:=QVistaOracle;
  QSostitutivo.Sql.Add('SELECT T030.PROGRESSIVO, T030.COGNOME, T430.' + Campo + ' FROM T030_ANAGRAFICO T030, T430_STORICO T430');
  QSostitutivo.Sql.Add('WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND :DATALAVORO BETWEEN DATADECORRENZA AND DATAFINE');
  QSostitutivo.Sql.Add('AND T030.PROGRESSIVO <> :PROGRESSIVO AND T430.' + Campo + ' = :VALORECAMPO');
  QSostitutivo.Sql.Add('ORDER BY T030.COGNOME');
  QSostitutivo.DeclareVariable('DataLavoro',otDate);
  QSostitutivo.DeclareVariable('Progressivo',otInteger);
  QSostitutivo.DeclareVariable('ValoreCampo',otString);
  QSostitutivo.SetVariable('DataLavoro',Data);
  QSostitutivo.SetVariable('Progressivo',Prog);
  QSostitutivo.SetVariable('ValoreCampo',ValoreCampo);
  try
    QSostitutivo.Open;
    Result:=QSostitutivo.RecordCount > 0;
  except
  end;
end;

function TA043FStampaRepMW.SenzaTurno(Prog:LongInt; Data:TDateTime; OraI,OraF:String; TurniUguali:Boolean = False):Boolean;
{Restituisce TRUE se il dipendente non � pianificato in reperibilit� per il periodo richiesto:
 in questo caso si devono eseguire i conteggi DALLE ... ALLE ...}
var DI,DF,HI,HF,DetrazMensa:String;
    Toll,OreComp:Integer;
begin
  Result:=False;
  with Q380Sost do
    begin
    Close;
    Setvariable('Progressivo',Prog);
    Setvariable('Data',Data);
    Open;
    if RecordCount > 0 then
      begin
      //Confronto Turno1
      if Trim(FieldByName('Turno1').AsString) <> '' then
        begin
        CalcolaParametriTurno(Data,FieldByName('Turno1').AsString,DI,DF,HI,HF,DetrazMensa,Toll,OreComp);
        if (not TurniUguali) and (HI = OraI) and (HF = OraF) then
          exit;
        end;
      //Confronto Turno2
      if Trim(FieldByName('Turno2').AsString) <> '' then
        begin
        CalcolaParametriTurno(Data,FieldByName('Turno2').AsString,DI,DF,HI,HF,DetrazMensa,Toll,OreComp);
        if (not TurniUguali) and (HI = OraI) and (HF = OraF) then
          exit;
        end;
      //Confronto Turno3
      if Trim(FieldByName('Turno3').AsString) <> '' then
        begin
        CalcolaParametriTurno(Data,FieldByName('Turno3').AsString,DI,DF,HI,HF,DetrazMensa,Toll,OreComp);
        if (not TurniUguali) and (HI = OraI) and (HF = OraF) then
          exit;
        end;
      end;
    Result:=True;
    end;
end;

function TA043FStampaRepMW.ElaboraConteggiSostitutivi:Integer;
{Calcolo le ore lavorate in compresenza per il turno sostitutivo}
var i,j,k,intervallo:Integer;
begin
  Result:=0;
  for i:=High(arrTimbCompresenza) downto 1 do
    for j:=0 to i - 1 do
    begin
      if (arrTimbCompresenza[i].E <= arrTimbCompresenza[j].U) and (arrTimbCompresenza[i].U >= arrTimbCompresenza[j].E) then
      begin
        arrTimbCompresenza[j].E:=min(arrTimbCompresenza[i].E,arrTimbCompresenza[j].E);
        arrTimbCompresenza[j].U:=max(arrTimbCompresenza[i].U,arrTimbCompresenza[j].U);
        for k:=i + 1 to High(arrTimbCompresenza) do
          arrTimbCompresenza[k - 1]:=arrTimbCompresenza[k];
        SetLength(arrTimbCompresenza,Length(arrTimbCompresenza) - 1);
        Break;
      end;
    end;
  //Conteggio i minuti di compresenza oltre a quelli gi� riconosciuti per il dipendente pianificato in arrTimbConteggiate
  for i:=0 to High(arrTimbCompresenza) do
  begin
    intervallo:=0;
    //Per ogni minuto dell'intervallo di compresenza verifico che non sia gi� contato in arrTimbConteggiate
    for j:=arrTimbCompresenza[i].E to arrTimbCompresenza[i].U do
    begin
      inc(intervallo);
      for k:=0 to High(arrTimbConteggiate) do
        if R180Between(j,arrTimbConteggiate[k].E,arrTimbConteggiate[k].U) then
        begin
          dec(intervallo);
          Break;
        end;
    end;
    //aggiungo i minuti di compresenza, correggendo il caso per cui
    //--> 12.00 - 12.00 = 0 (e non 1 minuto!)
    //--> 12.30 - 12.00 = 30 (e non 31 minuti!)
    inc(Result,min(intervallo,max(0,arrTimbCompresenza[i].U - arrTimbCompresenza[i].E)));
  end;
end;

// Procedura che calcola in base al turno e alla data corrente l'inizio e la
// fine effetivi del turno.
procedure TA043FStampaRepMW.CalcolaParametriTurno(Data:TDateTime; Turno:String; var DataIni,DataFin,OraIni,OraFin,DetrazMensa:String; var Tolleranza,OreCompresenza:Integer);
var AppIni,AppFin:TDateTime;
begin
  if Q350RegReperib.Locate('Codice',Turno,[]) then
  begin
    DetrazMensa:=Q350RegReperib.FieldByName('DETRAZ_MENSA').AsString;
    if Q350RegReperib.FieldByName('Tolleranza').IsNull then
      Tolleranza:=0
    else
      Tolleranza:=Q350RegReperib.FieldByName('Tolleranza').AsInteger;
    OreCompresenza:=R180OreMinuti(Q350RegReperib.FieldByName('OreCompresenza').AsDateTime);
    AppIni:=Q350RegReperib.FieldByName('OraInizio').Value;
    AppFin:=Q350RegReperib.FieldByName('OraFine').Value;
    if AppIni < AppFin then // turno che ricopre un giorno solo.
    begin
      DataIni:=FormatDateTime('dd/mm/yyyy',Data);
      DataFin:=FormatDateTime('dd/mm/yyyy',Data);
      OraIni:=FormatDateTime('hh:mm',AppIni);
      OraFin:=FormatDateTime('hh:mm',AppFin);
    end
    else
    begin               // turno che ricopre due giorni.
      DataIni:=FormatDateTime('dd/mm/yyyy',Data);
      Data:=Data + 1;
      DataFin:=FormatDateTime('dd/mm/yyyy',Data);
      OraIni:=FormatDateTime('hh:mm',AppIni);
      OraFin:=FormatDateTime('hh:mm',AppFin);
    end;
  end;
end;

function TA043FStampaRepMW.LeggiDurataTurno(Data:TDateTime; Codice:String):Integer;
var Ini,Fin:Integer;
begin
  Result:=0;
  if Q350RegReperib.Locate('Codice',Codice,[loCaseInsensitive]) then
  begin
    Ini:=R180OreMinuti(Q350RegReperib.FieldByName('OraInizio').AsDateTime);
    Fin:=R180OreMinuti(Q350RegReperib.FieldByName('OraFine').AsDateTime);
    if Fin <= Ini then
    begin
      Result:=Fin + 1440 - Ini;
      (*
      if Q110.Locate('Data',Data,[]) then
        if Ini <= R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) then
          Result:=Result + R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) - R180OreMinutiExt(Q110.FieldByName('OraNuova').AsString);
      if Q110.Locate('Data',Data + 1,[]) then
        if Fin >= R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) then
          Result:=Result + R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) - R180OreMinutiExt(Q110.FieldByName('OraNuova').AsString);
      *)
    end
    else
    begin
      Result:=Fin - Ini;
      (*
      if Q110.Locate('Data',Data,[]) then
        if (Ini <= R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString)) and
           (Fin >= R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString)) then
          Result:=Result + R180OreMinutiExt(Q110.FieldByName('OraVecchia').AsString) - R180OreMinutiExt(Q110.FieldByName('OraNuova').AsString);
      *)
    end;
  end;
end;

function TA043FStampaRepMW.LeggiRaggruppamento(Codice:String):String;
begin
  Result:='';
  if Q350RegReperib.Locate('Codice',Codice,[loCaseInsensitive]) then
    Result:=Q350RegReperib.FieldByName('Raggruppamento').AsString;
end;

function TA043FStampaRepMW.LeggiTipoTurno(Codice:String):String;
begin
  Result:='';
  if Q350RegReperib.Locate('Codice',Codice,[loCaseInsensitive]) then
    Result:=Q350RegReperib.FieldByName('TipoTurno').AsString;
end;

function TA043FStampaRepMW.LeggiOreNonCaus(CodiceTurno:String):Boolean;
{Restituisce TRUE se le ore lavorate non causalizzate diminuiscono il turno}
begin
  Result:=False;
  if Q350regReperib.Locate('Codice',CodiceTurno,[loCaseInsensitive]) then
    Result:=Q350regReperib.FieldByName('OreNonCaus').AsString = 'S';
end;

// Restituisce True se il turno passato come parametro e' a cavallo della
// mezzanotte.
function TA043FStampaRepMW.TurnoMezzanotte(Codice:String):Boolean;
var Ini,Fin:Integer;
begin
  Result:=False;
  if Q350RegReperib.Locate('Codice',Codice,[loCaseInsensitive]) then
  begin
    Ini:=R180OreMinuti(Q350RegReperib.FieldByName('OraInizio').AsDateTime);
    Fin:=R180OreMinuti(Q350RegReperib.FieldByName('OraFine').AsDateTime);
    Result:=(Ini >= Fin) and (Fin <> 0);
  end;
end;

// Indica se devo togliere le ore di assenza dal turno di reperibilit�
function TA043FStampaRepMW.LeggiParametriCausaleAssenza(Causale:String):Boolean;
begin
  Result:=False;
  if QCausaliAssenza.Locate('Codice',Causale,[loCaseInsensitive]) then
    Result:=QCausaliAssenza.FieldByName('DetReperib').AsString <> '0';
end;

function TA043FStampaRepMW.ElaboraConteggi(OreNonCaus:Boolean; Inizio,Fine,DetrazMensa:String):Integer;
{Calcolo le ore che diminuiscono il turno in base ai parametri
 sulle causali di assenza/presenza sulle regole del turno di reperibilit�}
var OreLav,OreGiorno1,OreGiorno2,i,j:Integer;
begin
  Result:=0;
  OreLav:=0;
  SetLength(arrTimbConteggiate,R502ProDtM1.n_timbrcon);
  for i:=1 to R502ProDtM1.n_timbrcon do
  begin
    if (R502ProDtM1.ttimbraturecon[i].ggsucc) and (R502ProDtM1.ttimbraturecon[i].tminutic_u <= 1440) then
    begin
      arrTimbConteggiate[i-1].E:=R502ProDtM1.ttimbraturecon[i].tminutic_e + 1440;
      arrTimbConteggiate[i-1].U:=R502ProDtM1.ttimbraturecon[i].tminutic_u + 1440;
    end
    else
    begin
      arrTimbConteggiate[i-1].E:=R502ProDtM1.ttimbraturecon[i].tminutic_e;
      arrTimbConteggiate[i-1].U:=R502ProDtM1.ttimbraturecon[i].tminutic_u;
    end;
  end;
  if R180OreMinutiExt(Inizio) >= R180OreMinutiExt(Fine) then
  begin
    OreGiorno1:=1440 - R180OreMinutiExt(Inizio);
    OreGiorno2:=R180OreMinutiExt(Fine);
  end
  else
  begin
    OreGiorno1:=R180OreMinutiExt(Fine) - R180OreMinutiExt(Inizio);
    OreGiorno2:=0;
  end;
  //Conteggio ore lavorate = ore in fasce + ore escluse dalle normali
  for i:=1 to R502ProDtM1.n_fasce do
    inc(OreLav,R502ProDtM1.tminlav[i]);
  //Alberto 28/01/2015: Elimino le ore aggiunte per coprire automaticamente la carenza
  dec(OreLav,R502ProDtM1.CoperturaCarenza);
  inc(OreLav,R502ProDtM1.minlavesc);
  //Elimino dalle ore lavorate le ore causalizzate
  for i:=1 to R502ProDtM1.n_rieppres do
    if Trim(R502ProDtM1.triepgiuspres[i].tcauspres) <> '' then
      for j:=1 to R502ProDtM1.n_fasce do
        dec(OreLav,R502ProDtM1.triepgiuspres[i].tminpres[j]);
  //Elimino dalle ore lavorate le ore rese da assenza
  for i:=1 to R502ProDtM1.n_riepasse do
    dec(OreLav,R502ProDtM1.triepgiusasse[i].tminresasse);
  if OreNonCaus then
  begin
    //Elimino le ore non causalizzate
    Result:=OreLav;
    //Abbatto il turno di reperibilit� anche dei minuti di mensa
    if DetrazMensa = 'S' then
      inc(Result,R502ProDtM1.paumendet);
  end;
  (*
  DetReperib = '1': sempre
  DetReperib = '2': fruiz. dalle..alle + altro solo se turno diurno
  DetReperib = '3': solo fruiz. dalle..alle
  DetReperib = '4': turno diurno e entrata notturno
  DetReperib = '5': turno diurno e uscita notturno totale

  R502ProDtM1.triepgiusasse[i].ttipofruiz = 'D':
    sempre

  R502ProDtM1.triepgiusasse[i].ttipofruiz <> 'D':
    DetReperib = '1'
    DetReperib = '2': solo se OreGiorno2 = 0
  *)
  for i:=1 to R502ProDtM1.n_rieppres do
    if LeggiParametriCausalePresenza(R502ProDtM1.triepgiuspres[i].tcauspres) then
      for j:=1 to R502ProDtM1.n_fasce do
        inc(Result,R502ProDtM1.triepgiuspres[i].tminpres[j]);
  for i:=1 to R502ProDtM1.n_riepasse do
    if LeggiParametriCausaleAssenza(R502ProDtM1.triepgiusasse[i].tcausasse) then
    begin
      if R502ProDtM1.triepgiusasse[i].ttipofruiz = 'D' then
        //Fruizioni dalle..alle
        inc(Result,R502ProDtM1.triepgiusasse[i].tminresasse)
      else if QCausaliAssenza.FieldByName('DetReperib').AsString <> '3' then
      begin
        //Fruizioni diverse da dalle..alle, solo se DetReperib lo consente
        if (R502ProDtM1.triepgiusasse[i].ttipofruiz = 'I') and (QCausaliAssenza.FieldByName('DetReperib_Totale').AsString = 'S') then
        begin
          if (QCausaliAssenza.FieldByName('DetReperib').AsString = '1') or (OreGiorno2 = 0) then
          begin
            if OreGiorno2 = 0 then
              inc(Result,1440)
            else
            begin
              if R502ProDtM1.triepgiusasse[i].GiornoDopo then
                inc(Result,OreGiorno2)
              else
                inc(Result,OreGiorno1);
            end;
          end
          else if (QCausaliAssenza.FieldByName('DetReperib').AsString = '4') and (OreGiorno2 > 0) and (not R502ProDtM1.triepgiusasse[i].GiornoDopo) then
            inc(Result,OreGiorno1)
          else if (QCausaliAssenza.FieldByName('DetReperib').AsString = '5') and (OreGiorno2 > 0) and (R502ProDtM1.triepgiusasse[i].GiornoDopo) then
            inc(Result,OreGiorno1 + OreGiorno2);
        end
        else
        begin
          if (QCausaliAssenza.FieldByName('DetReperib').AsString = '1') or (OreGiorno2 = 0) then
          begin
            if R502ProDtM1.triepgiusasse[i].ttipofruiz <> 'I' then
              //Fruizioni diverse da gg.intera
              inc(Result,R502ProDtM1.triepgiusasse[i].tminresasse)
            else
            begin
              //Fruizioni a gg.intera, valuto la durata nel caso di turni a cavallo mezzanotte e considero anche le ore
              if not R502ProDtM1.triepgiusasse[i].GiornoDopo then
                inc(Result,min(OreGiorno1,IfThen(R502ProDtM1.triepgiusasse[i].tminresasse > 0,R502ProDtM1.triepgiusasse[i].tminresasse,R502ProDtM1.triepgiusasse[i].tminvalasse)))
              else
                inc(Result,min(OreGiorno2,IfThen(R502ProDtM1.triepgiusasse[i].tminresasse > 0,R502ProDtM1.triepgiusasse[i].tminresasse,R502ProDtM1.triepgiusasse[i].tminvalasse)));
            end;
          end
          else if (QCausaliAssenza.FieldByName('DetReperib').AsString = '4') and (OreGiorno2 > 0) and (not R502ProDtM1.triepgiusasse[i].GiornoDopo) then
            inc(Result,min(OreGiorno1,IfThen(R502ProDtM1.triepgiusasse[i].tminresasse > 0,R502ProDtM1.triepgiusasse[i].tminresasse,R502ProDtM1.triepgiusasse[i].tminvalasse)))
          else if (QCausaliAssenza.FieldByName('DetReperib').AsString = '5') and (OreGiorno2 > 0) and (R502ProDtM1.triepgiusasse[i].GiornoDopo) then
            inc(Result,IfThen(R502ProDtM1.triepgiusasse[i].tminresasse > 0,R502ProDtM1.triepgiusasse[i].tminresasse,R502ProDtM1.triepgiusasse[i].tminvalasse));
        end;
      end;
    end;
end;

procedure TA043FStampaRepMW.ConteggiDalleAlle(Prog:LongInt; Data:TDateTime; Turno,Tipo,Ragg:String; Durata:Integer; var Riduz, OutGettRep:Integer);
{Richiamo i conteggi nella forma
  DALLE*hhmm*ALLE*hhmm per il turno diurno, e nella forma
  DALLE*hhmmALLE*hhmm+ per il turno a cavallo di mezzanotte}
var DataInizio,DataFine,OraInizio,OraFine,OraI,OraF:String;
    ValoreRagg,DetrazMensa:String;
    Tolleranza,OreCompresenza,i,j:Integer;
    OreNonCaus:Boolean;
    BloccaOld:Word;
begin
  CalcolaParametriTurno(Data,Turno,DataInizio,DataFine,OraInizio,OraFine,DetrazMensa,Tolleranza,OreCompresenza);
  OraI:=Copy(OraInizio,1,2) + Copy(OraInizio,4,2);
  OraF:=Copy(OraFine,1,2) + Copy(OraFine,4,2);

  OreNonCaus:=LeggiOreNonCaus(Turno);
  Riduz:=0;
  if TurnoMezzanotte(Turno) then
    R502ProDtM1.f03_com:='DALLE*' + OraI + 'ALLE*' + OraF + '+'
  else
    R502ProDtM1.f03_com:='DALLE*' + OraI + '*ALLE*' + OraF;
  R502ProDtM1.Conteggi('Cartolina',Prog,Data);
  R502ProDtM1.f03_com:='';

  OutGettRep:=0;
  if R502ProDtM1.dipinser = 'no' then exit;
  if R502ProDtM1.Blocca <> 0 then exit;
  if R502ProDtM1.ChiamataReperibilita(Data,R180OreMinutiExt(OraInizio),R180OreMinutiExt(OraFine)) then
    OutGettRep:=1;
  (*
  for i:=1 to R502ProDtM1.n_rieppres do
    if (R502ProDtM1.ValStrT275[R502ProDtM1.triepgiuspres[i].tcauspres,'CODINTERNO'] = 'C') then
      for j:=0 to High(R502ProDtM1.triepgiuspres[i].CoppiaEU) do
      begin
        if (R502ProDtM1.triepgiuspres[i].CoppiaEU[j].Tag <> 'TG=D') and
           (R180OreMinutiExt(OraFine) > R180OreMinutiExt(OraInizio)) and
           (R180OreMinutiExt(OraInizio) < R502ProDtM1.triepgiuspres[i].CoppiaEU[j].u) and
           (R180OreMinutiExt(OraFine) > R502ProDtM1.triepgiuspres[i].CoppiaEU[j].e) then
          OutGettRep:=1
        else if (R502ProDtM1.triepgiuspres[i].CoppiaEU[j].Tag <> 'TG=D') and
                (R180OreMinutiExt(OraFine) <= R180OreMinutiExt(OraInizio)) and
                (R180OreMinutiExt(OraInizio) < R502ProDtM1.triepgiuspres[i].CoppiaEU[j].u) and
                (R180OreMinutiExt(OraFine) + 1440 > R502ProDtM1.triepgiuspres[i].CoppiaEU[j].e) then
          OutGettRep:=1;
        if OutGettRep = 1 then
          Break;
      end;
  *)
  Riduz:=Riduz + ElaboraConteggi(OreNonCaus,OraInizio,OraFine,DetrazMensa);
  (*Gestione compresenza per turni sostitutivi*)
  BloccaOld:=R502ProDtM1.Blocca;
  if Tipo = 'S' then
  begin
    ValoreRagg:=GetValoreCampoRaggruppamento(Prog,Data,Ragg);
    if (ValoreRagg <> '') and (GestisciTurnoSostitutivo(Prog,Data,Ragg,ValoreRagg)) then
      Riduz:=Riduz + GetCompresenza(Data,OraInizio,OraFine);
  end
  else
    Riduz:=Max(Riduz,OreCompresenza);
  R502ProDtM1.Blocca:=BloccaOld;
  if Riduz > Durata then
    Riduz:=Durata;
  //Applico la tolleranza sulla riduzione
  if Riduz <= Tolleranza then
    Riduz:=0;
end;

procedure TA043FStampaRepMW.LeggiTurni(Data:TDateTime;var T1,T2,T3,Tipo1,Tipo2,Tipo3,Ragg1,Ragg2,Ragg3:String; var Durata1,Durata2,Durata3:Integer);
  procedure Swap(var x,y:String);
  var t:String;
  begin
    t:=y;
    y:=x;
    x:=t;
  end;
begin
  T1:='';
  T2:='';
  T3:='';
  T1:=Q380Pianif.FieldByName('Turno1').AsString;
  T2:=Q380Pianif.FieldByName('Turno2').AsString;
  T3:=Q380Pianif.FieldByName('Turno3').AsString;
  //Ordino i codici
  if T1 > T2 then
    Swap(T1,T2);
  if T2 > T3 then
    Swap(T2,T3);
  if T1 > T2 then
    Swap(T1,T2);
  if T1 <> '' then
    begin
    Durata1:=LeggiDurataTurno(Data,T1);
    Tipo1:=LeggiTipoTurno(T1);
    Ragg1:=LeggiRaggruppamento(T1);
    end
  else
    begin
    Durata1:=0;
    Tipo1:='';
    Ragg1:='';
    end;
  if T2 <> '' then
    begin
    Durata2:=LeggiDurataTurno(Data,T2);
    Tipo2:=LeggiTipoTurno(T2);
    Ragg2:=LeggiRaggruppamento(T2);
    end
  else
    begin
    Durata2:=0;
    Tipo2:='';
    Ragg2:='';
    end;
  if T3 <> '' then
    begin
    Durata3:=LeggiDurataTurno(Data,T3);
    Tipo3:=LeggiTipoTurno(T3);
    Ragg3:=LeggiRaggruppamento(T3);
    end
  else
    begin
    Durata3:=0;
    Tipo3:='';
    Ragg3:='';
    end;
end;

procedure TA043FStampaRepMW.LeggiParametriMaggiorazione(CodTurno:String;var Tipo,OreNormali:Integer);
begin
  if Q350RegReperib.Locate('Codice',CodTurno,[loCaseInsensitive]) then
  begin
    Tipo:=Q350RegReperib.FieldbyName('TipoOre').AsInteger;
    if not(Q350RegReperib.FieldbyName('OreNormali').IsNull) then
      OreNormali:=R180OreMinutiExt(FormatDateTime('hh:mm',Q350RegReperib.FieldbyName('OreNormali').Value))
    else
      OreNormali:=0;
  end;
end;

procedure TA043FStampaRepMW.InserisciDipendente(Prog:Integer;Data:TDateTime;Turno,DTurno,Contratto,Anomalia:String;DurataTurno,OreLavorate,InGettRep:Integer;CalcolaIndennita:Boolean = True);
var
  MinutiTurno,App,App2,Tipo,T350OreNormali,OreNormali:Integer;
begin
  if (Anomalia = '') and (GiaScaricato) then
    Anomalia:='Gi� scaricato';
  if (Anomalia = '') and (bRiepilogoBloccato) then
    Anomalia:='Riep.bloccato';
  if Anomalia <> '' then
  begin
    RegistraMsg.InserisciMessaggio(IfThen(bRiepilogoBloccato,'B','A'),DateToStr(Data) + ' : ' + Anomalia,'',Prog);
  end;
  Q350RegReperib.SearchRecord('Codice',Turno,[srFromBeginning]);
  MinutiTurno:=R180OreMinutiExt(Contratto);
  if R180OreMinutiExt(Q350RegReperib.FieldByName('Turno_Intero').AsString) > 0 then
    MinutiTurno:=R180OreMinutiExt(Q350RegReperib.FieldByName('Turno_Intero').AsString);
  TabellaStampa.Insert;
  if A043CampoRagg <> '' then
    TabellaStampa.FieldByName('Gruppo').AsString:=SelAnagrafe.FieldByName(A043CampoRagg).AsString;
  TabellaStampa.FieldByName('Progressivo').AsInteger:=Prog;
  TabellaStampa.FieldByName('Matricola').Asstring:=SelAnagrafe.FieldByName('Matricola').AsString;
  TabellaStampa.FieldByName('Nome').AsString:=SelAnagrafe.FieldByName('Cognome').AsString + ' ' + SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Badge').AsInteger:=SelAnagrafe.FieldByName('T430Badge').AsInteger;
  TabellaStampa.FieldByName('Data').Value:=Data;
  TabellaStampa.FieldByName('CodTurno').Value:=Format('%-5s %s',[Turno,DTurno]);
  TabellaStampa.FieldByName('DurataTurno').Value:=R180MinutiOre(DurataTurno);
  TabellaStampa.FieldByName('Anomalia').Value:=Anomalia;
  TabellaStampa.FieldByName('UnitaTurno').Value:=MinutiTurno;
  TabellaStampa.FieldByName('VP_Turno').Value:=Q350RegReperib.FieldByName('VP_Turno').AsString;
  TabellaStampa.FieldByName('VP_Ore').Value:=Q350RegReperib.FieldByName('VP_Ore').AsString;
  TabellaStampa.FieldByName('VP_Maggiorate').Value:=Q350RegReperib.FieldByName('VP_Maggiorate').AsString;
  TabellaStampa.FieldByName('VP_NonMaggiorate').Value:=Q350RegReperib.FieldByName('VP_NonMaggiorate').AsString;
  TabellaStampa.FieldByName('OreLavorate').AsString:=R180MinutiOre(OreLavorate);
  TabellaStampa.FieldByName('Diff').AsString:=R180MinutiOre(DurataTurno - OreLavorate);
  TabellaStampa.FieldByName('VP_Turni_oltremax').Value:=Q350RegReperib.FieldByName('VP_Turni_oltremax').AsString;
  TabellaStampa.FieldByName('VP_Gettone_Chiamata').Value:=Q350RegReperib.FieldByName('VP_Gettone_Chiamata').AsString;
  if InGettRep > 0 then
    TabellaStampa.FieldByName('Gettone_Chiamata').AsInteger:=InGettRep;
  //Se ho riscontrato anomalia bloccante registro i dati ed esco subito
  //if Anomalia = 'Anomalia' then
  //if (Copy(Anomalia,1,8) = 'Anomalia') then
  if not CalcolaIndennita then
  begin
    TabellaStampa.Post;
    exit;
  end;
  LeggiParametriMaggiorazione(Turno,Tipo,T350OreNormali);
  //Distinzione Ore normali/maggiorate/non maggaiorate
  case Tipo of
     0:begin
         TabellaStampa.FieldByName('OreNormali').Value:=R180MinutiOre(DurataTurno-OreLavorate);
         TabellaStampa.FieldByName('OreMagg').Value:=R180MinutiOre(0);
         TabellaStampa.FieldByName('OreNonMagg').Value:=R180MinutiOre(0);
       end;
     1:begin
         TabellaStampa.FieldByName('OreNormali').Value:=R180MinutiOre(0);
         TabellaStampa.FieldByName('OreMagg').Value:=R180MinutiOre(DurataTurno-OreLavorate);
         TabellaStampa.FieldByName('OrenonMagg').Value:=R180MinutiOre(0);
       end;
     2:begin
         if T350OreNormali > (DurataTurno-OreLavorate) then
           begin
             TabellaStampa.FieldByName('OreNormali').Value:=R180MinutiOre(0);
             TabellaStampa.FieldByName('OreNonMagg').Value:=R180MinutiOre(DurataTurno-OreLavorate);
             TabellaStampa.FieldByName('OreMagg').Value:=R180MinutiOre(0);
           end
         else
           begin
             TabellaStampa.FieldByName('OreNonMagg').Value:=R180MinutiOre(0);
             TabellaStampa.FieldByName('OreNormali').Value:=R180MinutiOre(T350OreNormali);
             TabellaStampa.FieldByName('OreMagg').Value:=R180MinutiOre((DurataTurno-OreLavorate)-T350OreNormali);
           end;
       end;
  end;
  OreNormali:=R180OreMinutiExt(TabellaStampa.FieldByName('OreNormali').AsString);
  TabellaStampa.FieldByName('TurniInteri').Value:=OreNormali div MinutiTurno;
  TabellaStampa.FieldByName('TurniInOre').AsString:=R180MinutiOre(OreNormali mod MinutiTurno);
  //Riconoscimento del supero turno
  TotMeseTurniInteri:=TotMeseTurniInteri + (DurataTurno / MinutiTurno);
  inc(TotMeseTurniPianif);
  if (Q350RegReperib.FieldByName('VP_Turni_oltremax').AsString <> '<NO>') then
    inc(TotMeseTurniPianifInteri,DurataTurno div MinutiTurno);  //Se turno da 24h incremento di 2
  //totalizzare TotMeseTurniInteri e TotMesePianif per ogni dipendente
  // verifica i limiti per i turni
  Q350RegReperib.SearchRecord('CODICE',Turno,[srFromBeginning]);
  // se non � specificato un limite passa al prossimo turno
  if (not Q350RegReperib.FieldByName('PIANIF_MAX_MESE').IsNull) and
     (Q350RegReperib.FieldByName('VP_Turni_oltremax').AsString <> '<NO>') then
    if Q350RegReperib.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').AsString = 'S' then
    begin
      if (TotMeseTurniPianifInteri > Q350RegReperib.FieldByName('PIANIF_MAX_MESE').AsFloat) and
         (DurataTurno >= MinutiTurno) then
        //TabellaStampa.FieldByName('Turni_oltremax').AsInteger:=1;
        TabellaStampa.FieldByName('Turni_oltremax').AsInteger:=Min(DurataTurno div MinutiTurno,
                                                                   TotMeseTurniPianifInteri - Q350RegReperib.FieldByName('PIANIF_MAX_MESE').AsInteger);
    end
    else
    begin
      if TotMeseTurniPianif > Q350RegReperib.FieldByName('PIANIF_MAX_MESE').AsFloat then
        TabellaStampa.FieldByName('Turni_oltremax').AsInteger:=1;
    end;
  try
    TabellaStampa.Post;
  except
    TabellaStampa.Cancel;
    exit;
  end;
  if A043chkCumula then
    begin
      TabellaStampa.Filtered:=False;
      TabellaStampa.Filter:='Progressivo = ' + '''' + IntToStr(Prog) + '''';
      TabellaStampa.Filter:=Format('Progressivo = %d AND VP_Turno = ''%s'' AND VP_Ore = ''%s'' AND  VP_Maggiorate = ''%s'' AND VP_NonMaggiorate = ''%s'' AND VP_Gettone_Chiamata = ''%s'' AND VP_Turni_oltremax = ''%s''',
                                    [Prog,
                                     Q350RegReperib.FieldByName('VP_Turno').AsString,
                                     Q350RegReperib.FieldByName('VP_Ore').AsString,
                                     Q350RegReperib.FieldByName('VP_Maggiorate').AsString,
                                     Q350RegReperib.FieldByName('VP_NonMaggiorate').AsString,
                                     Q350RegReperib.FieldByName('VP_Gettone_Chiamata').AsString,
                                     Q350RegReperib.FieldByName('VP_Turni_oltremax').AsString]);
      TabellaStampa.Filtered:=True;
      TabellaStampa.Last;
      if (TabellaStampa.RecordCount >= 2) then
        begin
          TabellaStampa.Prior;
          App:=R180OreMinutiExt(TabellaStampa.FieldByName('TurniInOre').AsString);
          App2:=TabellaStampa.FieldByName('TurniInteri').AsInteger;
          TabellaStampa.Next;
          App:=App + R180OreMinutiExt(TabellaStampa.FieldByName('TurniInOre').AsString);
          TabellaStampa.Edit;
          TabellaStampa.FieldByName('TurniInteri').Value:=TabellaStampa.FieldByName('TurniInteri').AsInteger + (App div MinutiTurno) + App2;
          TabellaStampa.FieldByName('TurniInOre').Value:=R180MinutiOre((App mod MinutiTurno));
          TabellaStampa.Post;
        end;
      TabellaStampa.Filtered:=False;
    end;
end;

procedure TA043FStampaRepMW.ElaboraReperib;
var QSContratto:TQueryStorico;
    DataCorr:TDateTime;
    Durata1, Durata2, Durata3, GettRep, OreMinIndennita1, OreMinIndennita2, OreMinIndennita3,
    OreLavorate:Integer;
    Reperib, T1, T2, T3, TipoTurno1, TipoTurno2, TipoTurno3,
    Ragg1, Ragg2, Ragg3, D1, D2, D3:String;
    v: Variant;
begin
  QSContratto:=TQueryStorico.Create(nil);
  QSContratto.Session:=SessioneOracle;
  R502ProDtM1.PeriodoConteggi(A043DataI,A043DataF + 1);
  GiaScaricato:=False;
  TotMeseTurniInteri:=0;
  TotMeseTurniPianif:=0;
  TotMeseTurniPianifInteri:=0;
  QSContratto.GetDatiStorici('T430CONTRATTO',SelAnagrafe.FieldByName('Progressivo').AsInteger,A043DataI,A043DataF);
  DataCorr:=A043DataI;
  while DataCorr <= A043DataF  do
  begin
    GettRep:=0;
    A043ProgressBar.Position:=A043ProgressBar.Position + 1;
    //Leggo se sono pianificati dei turni
    DataFiltro:=DataCorr;
    Q380Pianif.Filtered:=False;
    Q380Pianif.Filtered:=True;
    Q380Pianif.First;
    if Q380Pianif.Locate('Data',DataCorr,[loCaseInsensitive]) then
    begin
      if QSContratto.LocDatoStorico(DataCorr) then
        Reperib:=LeggiTipoContratto(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,QSContratto.FieldByName('T430CONTRATTO').AsString)
      else
        Reperib:='00.00';
      if R180OreMinutiExt(Reperib) > 0 then  //Vado avanti solo se ho le ore del turno da contratto
      begin
        LeggiTurni(DataCorr,T1,T2,T3,TipoTurno1,TipoTurno2,TipoTurno3,Ragg1,Ragg2,Ragg3,Durata1,Durata2,Durata3);
        // gestione ore min. per indennita.ini
        D1:='';
        OreMinIndennita1:=0;
        v:=Q350RegReperib.Lookup('CODICE',T1,'DESCRIZIONE;ORE_MIN_INDENNITA');
        if not VarIsNull(v) then
        begin
          if not VarIsNull(v[0]) then
            D1:=String(v[0]);
          if not VarIsNull(v[1]) then
            OreMinIndennita1:=R180OreMinutiExt(String(v[1]));
        end;
        D2:='';
        OreMinIndennita2:=0;
        v:=Q350RegReperib.Lookup('CODICE',T2,'DESCRIZIONE;ORE_MIN_INDENNITA');
        if not VarIsNull(v) then
        begin
          if not VarIsNull(v[0]) then
            D2:=String(v[0]);
          if not VarIsNull(v[1]) then
            OreMinIndennita2:=R180OreMinutiExt(String(v[1]));
        end;
        D3:='';
        OreMinIndennita3:=0;
        v:=Q350RegReperib.Lookup('CODICE',T3,'DESCRIZIONE;ORE_MIN_INDENNITA');
        if not VarIsNull(v) then
        begin
          if not VarIsNull(v[0]) then
            D3:=String(v[0]);
          if not VarIsNull(v[1]) then
            OreMinIndennita3:=R180OreMinutiExt(String(v[1]));
        end;
        // gestione ore min. per indennita.fine
        //Gestione primo turno
        if T1 <> '' then
        begin
          ConteggiDalleAlle(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T1,TipoTurno1,Ragg1,Durata1,OreLavorate,GettRep);
          if R502ProDtM1.dipinser <> 'no' then
          begin
            if R502ProDtM1.Blocca <> 0 then
              InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T1,D1,Reperib,'Anomalia! ' + IfThen(A043chkIgnoraAnomalie,'Conteggi non eseguiti', 'Mese non conteggiato'),0,0,GettRep,False)
            else
            begin
              if Durata1 - OreLavorate < OreMinIndennita1 then
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T1,D1,Reperib,'Turno inferiore alle ore minime',Durata1,OreLavorate,GettRep,False)
              else
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T1,D1,Reperib,'',Durata1,OreLavorate,GettRep);
            end;
          end;
        end;
        //Gestione secondo turno
        if (T2 <> '') and (T1 <> T2) then
        begin
          ConteggiDalleAlle(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T2,TipoTurno2,Ragg2,Durata2,OreLavorate,GettRep);
          if R502ProDtM1.dipinser <> 'no' then
          begin
            if R502ProDtM1.Blocca <> 0 then
              InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T2,D2,Reperib,'Anomalia! ' + IfThen(A043chkIgnoraAnomalie,'Conteggi non eseguiti', 'Mese non conteggiato'),0,0,GettRep,False)
            else
            begin
              if Durata2 - OreLavorate < OreMinIndennita2 then
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T2,D2,Reperib,'Turno inferiore alle ore minime',Durata2,OreLavorate,GettRep,False)
              else
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T2,D2,Reperib,'',Durata2,OreLavorate,GettRep);
            end;
          end;
        end;
        //Gestione terzo turno
        if (T3 <> '') and (T1 <> T3) and (T2 <> T3) then
        begin
          ConteggiDalleAlle(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T3,TipoTurno3,Ragg3,Durata3,OreLavorate,GettRep);
          if R502ProDtM1.dipinser <> 'no' then
          begin
            if R502ProDtM1.Blocca <> 0 then
              InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T3,D3,Reperib,'Anomalia! ' + IfThen(A043chkIgnoraAnomalie,'Conteggi non eseguiti', 'Mese non conteggiato'),0,0,GettRep,False)
            else
            begin
              if Durata3 - OreLavorate < OreMinIndennita3 then
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T3,D3,Reperib,'Turno inferiore alle ore minime',Durata3,OreLavorate,GettRep,False)
              else
                InserisciDipendente(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr,T3,D3,Reperib,'',Durata3,OreLavorate,GettRep);
            end;
          end;
        end;
      end;
    end;
    DataCorr:=DataCorr + 1;
  end;
  FreeAndNil(QSContratto);
end;

procedure TA043FStampaRepMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftstring,8,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('CodTurno',ftString,50,False);
  TabellaStampa.FieldDefs.Add('UnitaTurno',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('VP_Turno',ftString,6,False);
  TabellaStampa.FieldDefs.Add('VP_Ore',ftString,6,False);
  TabellaStampa.FieldDefs.Add('VP_Maggiorate',ftString,6,False);
  TabellaStampa.FieldDefs.Add('VP_NonMaggiorate',ftString,6,False);
  TabellaStampa.FieldDefs.Add('VP_Gettone_Chiamata',ftString,6,False);
  TabellaStampa.FieldDefs.Add('VP_Turni_oltremax',ftString,6,False);
  TabellaStampa.FieldDefs.Add('DurataTurno',ftString,6,False);
  TabellaStampa.FieldDefs.Add('TurniInteri',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('TurniInOre',ftString,6,False);
  TabellaStampa.FieldDefs.Add('OreLavorate',ftString,6,False);
  TabellaStampa.FieldDefs.Add('Diff',ftString,6,False);
  TabellaStampa.FieldDefs.Add('OreNormali',ftString,6,False);
  TabellaStampa.FieldDefs.Add('OreMagg',ftString,6,False);
  TabellaStampa.FieldDefs.Add('OreNonMagg',ftString,6,False);
  TabellaStampa.FieldDefs.Add('Gettone_Chiamata',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Turni_oltremax',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Anomalia',ftString,100,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Nome;Badge;Matricola;Progressivo;Data;CodTurno'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA043FStampaRepMW.AzzeraContatori;
begin
  SetLength(Riepilogo,0);
  NessunaAnomalia:=True;
  GiaScaricato:=False;
  bRiepilogoBloccato:=False;
end;

procedure TA043FStampaRepMW.CalcolaRiepiloghi;
var Progressivo:Integer;
begin
  lstAnomalie.Clear;
  Progressivo:=-1;
  if A043ProgressBar <> nil then
  begin
    A043ProgressBar.Position:=0;
    A043ProgressBar.Max:=TabellaStampa.RecordCount;
  end;
  TabellaStampa.First;
  while not TabellaStampa.Eof do
  begin
    if A043ProgressBar <> nil then
      A043ProgressBar.StepBy(1);
    if TabellaStampa.FieldByName('PROGRESSIVO').AsInteger <> Progressivo then
    begin
      ChiusuraRiepilogo(Progressivo);
      AzzeraContatori;
      Progressivo:=TabellaStampa.FieldByName('PROGRESSIVO').AsInteger;
    end;
    CumuloGiornaliero;
    TabellaStampa.Next;
  end;
  ChiusuraRiepilogo(Progressivo);
  if A043ProgressBar <> nil then
    A043ProgressBar.Position:=0;
end;

procedure TA043FStampaRepMW.CumuloGiornaliero;
var i:Integer;
begin
  i:=GetRiepilogo(TabellaStampa);
  inc(Riepilogo[i].TotGettRep,TabellaStampa.FieldByName('Gettone_Chiamata').AsInteger);
  inc(Riepilogo[i].TotDurata,R180OreMinutiExt(TabellaStampa.FieldByName('DurataTurno').AsString));
  inc(Riepilogo[i].TotDiff,R180OreMinutiExt(TabellaStampa.FieldByName('Diff').AsString));
  inc(Riepilogo[i].TotOreLavorate,R180OreMinutiExt(TabellaStampa.FieldByName('OreLavorate').AsString));
  inc(Riepilogo[i].TotOreNormali,R180OreMinutiExt(TabellaStampa.FieldByName('OreNormali').AsString));
  inc(Riepilogo[i].TotOreMagg,R180OreMinutiExt(TabellaStampa.FieldByName('OreMagg').AsString));
  inc(Riepilogo[i].TotOreNonMagg,R180OreMinutiExt(TabellaStampa.FieldByName('OreNonMagg').AsString));
  inc(Riepilogo[i].TotOltreMax,TabellaStampa.FieldByName('Turni_oltremax').AsInteger);
  if A043chkCumula then
  begin
    Riepilogo[i].TurniInteri:=TabellaStampa.FieldByName('TurniInteri').AsInteger;
    Riepilogo[i].TurniInOre:=R180OreMinutiExt(TabellaStampa.FieldByName('TurniInOre').AsString);
  end
  else
  begin
    inc(Riepilogo[i].TurniInteri,TabellaStampa.FieldByName('TurniInteri').AsInteger);
    inc(Riepilogo[i].TurniInOre,R180OreMinutiExt(TabellaStampa.FieldByName('TurniInOre').AsString));
  end;
  //Memorizzo se c'� una anomalia per non salvare i dati su archivio in SalvataggioDatiTurni
  //if TabellaStampa.FieldByName('Anomalia').AsString = 'Anomalia' then
  if (Copy(TabellaStampa.FieldByName('Anomalia').AsString,1,8) = 'Anomalia') then
    NessunaAnomalia:=False;
  if TabellaStampa.FieldByName('Anomalia').AsString = 'Gi� scaricato' then
  begin
    NessunaAnomalia:=False;
    GiaScaricato:=True;
  end;
  if TabellaStampa.FieldByName('Anomalia').AsString = 'Riep.bloccato' then
  begin
    NessunaAnomalia:=False;
    bRiepilogoBloccato:=True;
  end;
end;

function TA043FStampaRepMW.GetRiepilogo(DS:TDataSet):Integer;
{Ricerca del turno corrente nel riepilogo}
var i:Integer;
begin
  Result:= -1;
  for i:=0 to High(Riepilogo) do
    if (DS.FieldByName('VP_Turno').AsString = Riepilogo[i].VP_Turno) and
       (DS.FieldByName('VP_Ore').AsString = Riepilogo[i].VP_Ore) and
       (DS.FieldByName('VP_Maggiorate').AsString = Riepilogo[i].VP_Maggiorate) and
       (DS.FieldByName('VP_NonMaggiorate').AsString = Riepilogo[i].VP_NonMaggiorate) and
       (DS.FieldByName('VP_Gettone_Chiamata').AsString = Riepilogo[i].VP_GettRep) and
       (DS.FieldByName('VP_Turni_oltremax').AsString = Riepilogo[i].VP_Turni_oltremax) then
    begin
      Result:=i;
      Break;
    end;
  if Result = -1 then
  begin
    SetLength(Riepilogo,Length(Riepilogo) + 1);
    Result:=High(Riepilogo);
    Riepilogo[Result].VP_Turno:=DS.FieldByName('VP_Turno').AsString;
    Riepilogo[Result].VP_GettRep:=DS.FieldByName('VP_Gettone_Chiamata').AsString;
    Riepilogo[Result].VP_Ore:=DS.FieldByName('VP_Ore').AsString;
    Riepilogo[Result].VP_Maggiorate:=DS.FieldByName('VP_Maggiorate').AsString;
    Riepilogo[Result].VP_NonMaggiorate:=DS.FieldByName('VP_NonMaggiorate').AsString;
    Riepilogo[Result].VP_Turni_oltremax:=DS.FieldByName('VP_Turni_oltremax').AsString;
    if DS = TabellaStampa then
      Riepilogo[Result].UnitaTurno:=DS.FieldByName('UnitaTurno').AsInteger
    else
      Riepilogo[Result].UnitaTurno:=0;
    Riepilogo[Result].TotGettRep:=0;
    Riepilogo[Result].TotDiff:=0;
    Riepilogo[Result].TotDurata:=0;
    Riepilogo[Result].TotOreLavorate:=0;
    Riepilogo[Result].TotOreNormali:=0;
    Riepilogo[Result].TotOreMagg:=0;
    Riepilogo[Result].TotOreNonMagg:=0;
    Riepilogo[Result].TurniInteri:=0;
    Riepilogo[Result].TurniInOre:=0;
    Riepilogo[Result].ResiduoPrec:=0;
    Riepilogo[Result].TotOltreMax:=0;
  end;
end;

procedure TA043FStampaRepMW.ChiusuraRiepilogo(Progressivo:Integer);
begin
 if Progressivo <= 0 then exit;
  if A043chkSpezzoniMese then
    CumulaMesePrecedente(Progressivo);
  if not NessunaAnomalia then
    lstAnomalie.Add(IntToStr(Progressivo));
  if (SalvaDatiTurni) and (not GiaScaricato) and (not bRiepilogoBloccato) then
    SalvataggioDatiTurni(Progressivo);
end;

procedure TA043FStampaRepMW.CumulaMesePrecedente(Prog:LongInt);
{Leggo le eventuali ore precedenti e le cumulo a seconda di quanto specificato}
var i:Integer;
begin
  QMesePrecedente.Close;
  QMesePrecedente.SetVariable('Progressivo',Prog);
  QMesePrecedente.SetVariable('Data',R180AddMesi(A043DataI,-1));
  QMesePrecedente.Open;
  while not QMesePrecedente.Eof do
  begin
    i:=GetRiepilogo(QMesePrecedente);
    inc(Riepilogo[i].TurniInOre,R180OreMinutiExt(QMesePrecedente.FieldByName('TurniOre').AsString));
    Riepilogo[i].ResiduoPrec:=R180OreMinutiExt(QMesePrecedente.FieldByName('TurniOre').AsString);
    if A043chkCumula and (Riepilogo[i].UnitaTurno > 0) then
    begin
      inc(Riepilogo[i].TurniInteri,Riepilogo[i].TurniInOre div Riepilogo[i].UnitaTurno);
      Riepilogo[i].TurniInOre:=Riepilogo[i].TurniInOre mod Riepilogo[i].UnitaTurno;
    end;
    QMesePrecedente.Next;
  end;
  QMesePrecedente.Close;
end;

procedure TA043FStampaRepMW.SalvataggioDatiTurni(Prog:Integer);
var A,M,G:Word;
    i:Integer;
begin
  DecodeDate(A043DataI,A,M,G);
  //Non salvo i dati se � stata riscontrata un'anomalia
  if not NessunaAnomalia and Not A043chkIgnoraAnomalie then
    exit;
  QInsert.SetVariable('Progressivo',Prog);
  QInsert.SetVariable('Anno',A);
  QInsert.SetVariable('Mese',M);
  for i:=0 to High(Riepilogo) do
  begin
    QInsert.SetVariable('VP_Turno',Riepilogo[i].VP_Turno);
    QInsert.SetVariable('VP_Ore',Riepilogo[i].VP_Ore);
    QInsert.SetVariable('VP_Maggiorate',Riepilogo[i].VP_Maggiorate);
    QInsert.SetVariable('VP_NonMaggiorate',Riepilogo[i].VP_NonMaggiorate);
    QInsert.SetVariable('VP_Gettone_Chiamata',Riepilogo[i].VP_GettRep);
    QInsert.SetVariable('VP_Turni_oltremax',Riepilogo[i].VP_Turni_oltremax);
    QInsert.SetVariable('Gettone_Chiamata',Riepilogo[i].TotGettRep);
    QInsert.SetVariable('TurniInteri',Riepilogo[i].TurniInteri);
    QInsert.SetVariable('TurniOre',R180MinutiOre(Riepilogo[i].TurniInOre));
    QInsert.SetVariable('OreMagg',R180MinutiOre(Riepilogo[i].TotOreMagg));
    QInsert.SetVariable('OreNonMagg',R180MinutiOre(Riepilogo[i].TotOreNonMagg));
    QInsert.SetVariable('FlagPaghe','1');
    QInsert.SetVariable('Turni_oltremax',Riepilogo[i].TotOltremax);
    try
      QInsert.Execute;
      RegistraLog.SettaProprieta('I','T340_TURNIREPERIB',CodForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('DATA','',DateToStr(EncodeDate(A,M,1)));
      RegistraLog.InserisciDato('CODICI','',Riepilogo[i].VP_Turno + Riepilogo[i].VP_Ore + Riepilogo[i].VP_Maggiorate + Riepilogo[i].VP_NonMaggiorate + Riepilogo[i].VP_GettRep + Riepilogo[i].VP_Turni_oltremax);
      RegistraLog.RegistraOperazione;
    except
    end;
  end;
  SessioneOracle.Commit;
end;

end.
