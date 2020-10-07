unit A045UStatAssenzeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Rp502Pro, Oracle, DBClient, DB, OracleData,
  A000UInterfaccia, A000UMessaggi,A000USessione, C180FunzioniGenerali, R500Lin;

type
  TA045MergeSelAnagrafe = procedure(DataSet: TOracleDataSet; RicreaVariabili: Boolean) of object;
  TA045SqlCreatoC700    = function :String of object;
  TA045MergeSettaPeriodo= procedure(DataSet: TOracleDataSet; DataDa,DataA: TDateTime) of object;
  T045Msg = procedure(Msg:String) of object;

  TRecApp = class
    Codice : String;
    Qualifica : String;
    ProgressivoQualifica: integer;
    Raggruppamento : String;
    Sesso : String;
    Progressivo : Integer;
    Minuti:integer;
    Giorni : Real;
    Data: TDateTime;
    Causale: string;
  end;

  TA045FStatAssenzeMW = class(TR005FDataModuleMW)
    DQualifica: TDataSource;
    QSceltaQualif: TOracleDataSet;
    QEstrazioneAssenze: TOracleDataSet;
    QTipiRapporto: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    SelT430: TOracleDataSet;
    SelT100: TOracleDataSet;
    SelT040: TOracleDataSet;
    SelT265: TOracleDataSet;
    delT043: TOracleQuery;
    insT043: TOracleQuery;
    selT275: TOracleDataSet;
    QEstrazionePresenze: TOracleDataSet;
    selT043: TOracleDataSet;
    selT043TotQualif: TOracleDataSet;
    selT043TotRaggr: TOracleDataSet;
    selT043Tot: TOracleDataSet;
    selT305: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TabellaStampaNewRecord(DataSet: TDataSet);
  private
    SalvaSQL:string;
  public
    RecApp : TRecApp;
    ListaDip : TList;
    R502Pro:TR502ProDtM1;
    DataInizio,DataFine:TDateTime;
    dSantoPatrono: TDateTime;
    GGLavorativiChecked,AssTutteChecked,ChkPartOrChecked : Boolean;
    sQualifiche,sTipiRapporto,Causali: String;
    evtA045MergeSelAnagrafe: TA045MergeSelAnagrafe;
    evtA045SqlCreatoC700: TA045SqlCreatoC700;
    evtA045MergeSettaPeriodo: TA045MergeSettaPeriodo;
    evtA045ShowMsg: T045Msg;
    TipoArrotondamentoQualificaItemIndex,
    ArrotondamentoQualificaItemIndex,
    ArrotondamentoTotaleItemIndex,
    TipoArrotondamentoTotaleItemIndex,
    TipoArrotondamentoAssenzaItemIndex,
    ArrotondamentoAssenzaItemIndex: Integer;
    DocumentoPDF,TipoModulo:String; //CS=ClientServer, COM=COMServer
    procedure CreaTabellaStampa;
    procedure CaricaTabellaStampa;
    procedure GeneraTabella;
    procedure SvuotaLista;
    procedure AggiungiDip;
    procedure OrdinaListaDip;
    procedure ElaboraCausaliPresenza;
    procedure CreaSQLEstrazioneAssenze(GgLavorativi: Boolean);
    function ConteggiaPatrono(Prog: Integer): Boolean;
    function CreaListaQualifiche:TStringList;
    function CreaListaTipiRapporto: TStringList;
  end;

implementation

{$R *.dfm}

procedure TA045FStatAssenzeMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  ListaDip:=TList.Create;
  R502Pro:=TR502ProDtM1.Create(nil);
  selT275.Open;
  selT305.Open;
  DataInizio:=EncodeDate(StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro))-1,1,1);
  DataFine:=EncodeDate(StrToInt(FormatDateTime('yyyy',Parametri.DataLavoro))-1,12,31);
  TipoModulo:='CS';
end;

procedure TA045FStatAssenzeMW.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  TabellaStampa.Close;
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  inherited;
  SvuotaLista;
  ListaDip.Free;
  FreeAndNil(R502Pro);
end;

procedure TA045FStatAssenzeMW.TabellaStampaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=0;
end;

procedure TA045FStatAssenzeMW.CreaSQLEstrazioneAssenze(GgLavorativi: Boolean);
begin
  R502Pro.Chiamante:='Assenze';
  R502Pro.PeriodoConteggi(DataInizio,DataFine);
  R502Pro.Q100.Open;
  with QEstrazioneAssenze.SQL do
  begin
    Clear;
    Add('SELECT T430.QUALIFICAMINIST CODQUALIF, T470.DESCRIZIONE DESCQUALIF, T430.TIPORAPPORTO, T430.ORARIO ORESETT, ');
    Add('       T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, T040.TIPOGIUST, T040.DAORE, T040.AORE, ');
    Add('       T030.SESSO, T265.RAGGRSTAT, T230F_HMASSENZA_PROPPT(T040.PROGRESSIVO,T040.DATA,T040.CAUSALE) HMASSENZA, ');
    Add('       T460.TIPO TIPO_PT, NVL(T460.PIANTA,100) PERC_PT, NVL(T012.NUMGIORNI,T011.NUMGIORNI) NUMGIORNISETT, ');
    Add('       T470.PROGRESSIVOQM PROGQUALIF, T470.DEBITOGGQM');
    Add('  FROM T470_QUALIFICAMINIST T470, T011_CALENDARI T011, T012_CALENDINDIVID T012, T040_GIUSTIFICATIVI T040, ');
    Add('       T265_CAUASSENZE T265, T030_ANAGRAFICO T030, T460_PARTTIME T460, T430_STORICO T430');
    Add(' WHERE T030.PROGRESSIVO = :PROG');
    Add('   AND T030.PROGRESSIVO = T430.PROGRESSIVO');
    Add('   AND T030.PROGRESSIVO = T040.PROGRESSIVO');
    Add('   AND T430.QUALIFICAMINIST IN (' + sQualifiche + ')');
    if sTipiRapporto <> '' then
      Add(' AND T430.TIPORAPPORTO IN (' + sTipiRapporto + ')');
    Add('   AND T470.CODICE = T430.QUALIFICAMINIST');
    Add('   AND :DATAA BETWEEN T470.DECORRENZA AND T470.DECORRENZA_FINE');
    Add('   AND T460.CODICE(+) = T430.PARTTIME');
    Add('   AND T040.DATA BETWEEN :DATADA AND :DATAA');
    Add('   AND LAST_DAY(T040.DATA) BETWEEN T430.DATADECORRENZA AND T430.DATAFINE');
    Add('   AND T265.CODICE = T040.CAUSALE');
    Add('   AND T265.RAGGRSTAT NOT IN (''Z'',''L'')');
    Add('   AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND T040.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE(''31123999'',''DDMMYYYY'')))');
    Add('   AND T011.DATA  = T040.DATA');
    Add('   AND T011.CODICE = T430.CALENDARIO');
    Add('   AND T012.PROGRESSIVO(+) = T040.PROGRESSIVO');
    Add('   AND T012.DATA(+) = T040.DATA');
    //Se si considerano solo i giorni lavorativi, escludo i giorni non lavorativi, i festivi e le domeniche
    if (GgLavorativi) then
      Add(' AND NVL(T012.FESTIVO,T011.FESTIVO) = ''N'' AND NVL(T012.LAVORATIVO,T011.LAVORATIVO) = ''S'' AND TO_CHAR(NVL(T012.DATA,T011.DATA),''d'') <> 1');
    Add('ORDER BY T040.PROGRESSIVO, T265.RAGGRSTAT, T040.DATA, T040.CAUSALE');
  end;
end;

function TA045FStatAssenzeMW.ConteggiaPatrono(Prog:Integer):Boolean;
var sCalendario:string;
    bTurnista:boolean;
    a,m,g,a1,m1,g1:word;
begin
  Result:=False;
  sCalendario:='';
  dSantoPatrono:=0;
  //LEGGERE LA DISTINCT DEI SANTI PATRONI ESISTENTI PER IL DIPENDENTE E SCEGLIERE LA DATA DEL PRIMO DI QUESTI
  //CON LA DATA DEL SANTO PATRONO LEGGERE TUTTO: QUALIFICA, TURNISTA, ECC...
  SelT430.Close;
  SelT430.SQL.Clear;
  SelT430.SQL.Add('SELECT DISTINCT T010.PATRONO');
  SelT430.SQL.Add('  FROM T010_CALENDIMPOSTAZ T010, T430_STORICO T430');
  SelT430.SQL.Add(' WHERE T010.CODICE = T430.CALENDARIO');
  SelT430.SQL.Add('   AND T430.PROGRESSIVO = :PROGRESSIVO');
  SelT430.SQL.Add('   AND T430.DATADECORRENZA <=:DATAF');
  SelT430.SQL.Add('   AND T430.DATAFINE >= :DATAI');
  SelT430.SQL.Add('   AND T430.INIZIO <= :DATAF');
  SelT430.SQL.Add('   AND NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY'')) >= :DATAI');
  SelT430.SetVariable('DataI', DataInizio);
  SelT430.SetVariable('DataF', DataFine);
  SelT430.SetVariable('Progressivo',Prog);
  SelT430.Open;
  if SelT430.RecordCount > 0 then
    dSantoPatrono:=SelT430.FieldByName('PATRONO').AsDateTime;
  if dSantoPatrono > 0 then
  begin
    DecodeDate(dSantoPatrono,a,m,g);
    DecodeDate(DataInizio,a1,m1,g1);
    dSantoPatrono:=EncodeDate(a1,m,g);
    if (dSantoPatrono >= DataInizio) and (dSantoPatrono <= DataFine) then
    begin
      //Leggo il calendario assegnato al dipendente alla data del santo patrono
      SelT430.Close;
      SelT430.SQL.Clear;
      SelT430.SQL.Add('SELECT T030.SESSO, T430.TGestione, T430.Calendario, T430.QUALIFICAMINIST CODQUALIF, T470.DESCRIZIONE DESCQUALIF, ');
      SelT430.SQL.Add('       T470.PROGRESSIVOQM PROGQUALIF, T470.DEBITOGGQM, NVL(T012.LAVORATIVO,T011.LAVORATIVO) LAVORATIVO');
      SelT430.SQL.Add('  FROM T030_ANAGRAFICO T030, T430_STORICO T430, T470_QUALIFICAMINIST T470, T011_CALENDARI T011, T012_CALENDINDIVID T012');
      SelT430.SQL.Add(' WHERE T030.PROGRESSIVO = T430.PROGRESSIVO');
      SelT430.SQL.Add('   AND LAST_DAY(:DATAI) BETWEEN T430.DATADECORRENZA AND T430.DATAFINE');
      SelT430.SQL.Add('   AND :DATAF BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))');
      SelT430.SQL.Add('   AND T430.PROGRESSIVO = :PROGRESSIVO');
      SelT430.SQL.Add('   AND T430.QUALIFICAMINIST = T470.CODICE');
      SelT430.SQL.Add('   AND :DATAF BETWEEN T470.DECORRENZA AND T470.DECORRENZA_FINE');
      SelT430.SQL.Add('   AND T011.DATA  = :DATAF');
      SelT430.SQL.Add('   AND T011.CODICE = T430.CALENDARIO');
      SelT430.SQL.Add('   AND T012.PROGRESSIVO(+) = T430.PROGRESSIVO');
      SelT430.SQL.Add('   AND T012.DATA(+) = :DATAF');
      SelT430.SQL.Add('   AND T430.QUALIFICAMINIST IN (' + sQualifiche + ')');
      if sTipiRapporto <> '' then
        SelT430.SQL.Add(' AND T430.TIPORAPPORTO IN (' + sTipiRapporto + ')');
      SelT430.SetVariable('DataI', dSantoPatrono);
      SelT430.SetVariable('DataF', dSantoPatrono);
      SelT430.SetVariable('Progressivo',Prog);
      SelT430.Open;
      if SelT430.RecordCount > 0 then  //Se il dipendente ha un record nello storico alla data del santo patrono
      begin
        bTurnista:=SelT430.FieldByName('TGestione').AsString='1';
        if ((selT430.FieldByName('Lavorativo').AsString = 'S') and (not bTurnista)) or //Giorno lavorativo e dipendente non turnista
            (bTurnista) then  //oppure dipendente turnista...
        begin
          //Controllo se ci sono timbrature nel giorno
          SelT100.Close;
          SelT100.SetVariable('PROGRESSIVO',Prog);
          SelT100.SetVariable('DATA', dSantoPatrono);
          SelT100.Open;
          if SelT100.FieldByName('CONTATIMBRATURE').AsInteger = 0 then
            Result:=True;  //Se non ci sono timbrature CONTEGGIO il santo patrono xchè sono stato a casa
          //Se conteggio il Santo patrono perchè sono a casa, verifico ancora che non ci siano
          //giustificativi già conteggiati e pianificati in tale giornata
          if Result then
          begin
            //Controllo se ci sono giustificativi nel giorno...
            SelT040.Close;
            SelT040.SetVariable('PROGRESSIVO',Prog);
            SelT040.SetVariable('DATA', dSantoPatrono);
            SelT040.Open;
            while not SelT040.Eof do
            begin
              //Se individuo un giustificativo con RaggrStat <> Z (Nessun raggruppamento)
              //NON CONTO IL SANTO PATRONO xchè ho già contato l'altro giustificativo
              SelT265.SetVariable('CODICE',SelT040.FieldByName('CAUSALE').AsString);
              SelT265.Open;
              if SelT265.FieldByName('RAGGRSTAT').AsString <> 'Z' then
              begin
                Result:=False;
                break;
              end;
              SelT265.Close;
              SelT040.Next;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TA045FStatAssenzeMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Codice',ftString,20,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,150,False);
  TabellaStampa.FieldDefs.Add('NDipURagg1',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg1',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg1',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg1',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg2',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg2',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg2',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg2',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg3',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg3',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg3',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg3',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg4',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg4',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg4',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg4',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg6',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg6',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg6',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg6',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg8',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg8',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg8',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg8',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg10',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg10',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg10',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg10',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg11',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg11',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg11',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg11',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipURagg12',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioURagg12',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NDipDRagg12',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('NGioDRagg12',ftFloat	,0,False);
  TabellaStampa.FieldDefs.Add('NTotGioU',ftString,10,False);
  TabellaStampa.FieldDefs.Add('NTotGioD',ftString,10,False);
  TabellaStampa.FieldDefs.Add('NTotDipU',ftInteger	,0,False);
  TabellaStampa.FieldDefs.Add('NTotDipD',ftInteger	,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Progressivo;Codice'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA045FStatAssenzeMW.CaricaTabellaStampa;
var Filtro,OldNome,OldCodice,NomeGiorni,NomeDip,sDep:String;
    nArrotondamento:real;
begin
  selT043.Close;
  evtA045MergeSelAnagrafe(selT043,False);
  if selT043.VariableIndex('C700DataDal') >= 0 then
    selT043.SetVariable('C700DataDal',DataInizio);
  selT043.SetVariable('DATAI',DataInizio);
  selT043.SetVariable('DataLavoro',DataFine);
  Filtro:=' AND T430.QUALIFICAMINIST IN (' + sQualifiche + ')';
  if sTipiRapporto <> '' then
    Filtro:=Filtro + ' AND T430.TIPORAPPORTO IN (' + sTipiRapporto + ')';
  selT043.SetVariable('FILTRO',Filtro);
  selT043.Open;
  selT043TotQualif.Close;
  evtA045MergeSelAnagrafe(selT043TotQualif,False);
  if selT043TotQualif.VariableIndex('C700DataDal') >= 0 then
    selT043TotQualif.SetVariable('C700DataDal',DataInizio);
  selT043TotQualif.SetVariable('DATAI',DataInizio);
  selT043TotQualif.SetVariable('DataLavoro',DataFine);
  selT043TotQualif.SetVariable('FILTRO',Filtro);
  selT043TotQualif.Open;
  selT043TotRaggr.Close;
  evtA045MergeSelAnagrafe(selT043TotRaggr,False);
  if selT043TotRaggr.VariableIndex('C700DataDal') >= 0 then
    selT043TotRaggr.SetVariable('C700DataDal',DataInizio);
  selT043TotRaggr.SetVariable('DATAI',DataInizio);
  selT043TotRaggr.SetVariable('DataLavoro',DataFine);
  selT043TotRaggr.SetVariable('FILTRO',Filtro);
  selT043TotRaggr.Open;
  selT043Tot.Close;
  evtA045MergeSelAnagrafe(selT043Tot,False);
  if selT043Tot.VariableIndex('C700DataDal') >= 0 then
    selT043Tot.SetVariable('C700DataDal',DataInizio);
  selT043Tot.SetVariable('DATAI',DataInizio);
  selT043Tot.SetVariable('DataLavoro',DataFine);
  selT043Tot.SetVariable('FILTRO',Filtro);
  selT043Tot.Open;
  case TipoArrotondamentoQualificaItemIndex of
    0:sDep:='E';
    1:sDep:='D';
    2:sDep:='P';
  end;
  nArrotondamento:=-1;
  case ArrotondamentoQualificaItemIndex of
    0: nArrotondamento:=-1;//non applico nessun arrotondamento, tengo il dato così com'è.
    1: nArrotondamento:=1;
    2: nArrotondamento:=0.5;
  end;
  selT043.First;
  OldNome:='';
  OldCodice:='';
  while not selT043.Eof do begin
    if TabellaStampa.Locate('CODICE',selT043.FieldByName('Codice').AsString,[]) then
      TabellaStampa.Edit
    else
    begin
      TabellaStampa.Append;
      TabellaStampa.FieldByName('Progressivo').AsInteger:=selT043.FieldByName('ProgressivoQM').AsInteger;
      TabellaStampa.FieldByName('Codice').AsString:=selT043.FieldByName('Codice').AsString;
      TabellaStampa.FieldByName('Descrizione').AsString:=
        Format('%-85s',[Copy(selT043.FieldByName('Descrizione').AsString,1,85)]) + ' - ' + selT043.FieldByName('Codice').AsString;
      TabellaStampa.FieldByName('NDipURagg1').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg1').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg1').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg1').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg2').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg2').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg2').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg2').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg3').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg3').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg3').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg3').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg4').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg4').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg4').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg4').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg6').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg6').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg6').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg6').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg8').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg8').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg8').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg8').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg10').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg10').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg10').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg10').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg11').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg11').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg11').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg11').AsFloat:=0;
      TabellaStampa.FieldByName('NDipURagg12').AsInteger:=0;
      TabellaStampa.FieldByName('NGioURagg12').AsFloat:=0;
      TabellaStampa.FieldByName('NDipDRagg12').AsInteger:=0;
      TabellaStampa.FieldByName('NGioDRagg12').AsFloat:=0;
      TabellaStampa.FieldByName('NTotGioU').AsString:='0';
      TabellaStampa.FieldByName('NTotGioD').AsString:='0';
      TabellaStampa.FieldByName('NTotDipU').AsInteger:=0;
      TabellaStampa.FieldByName('NTotDipD').AsInteger:=0;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'A' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg1';
        NomeDip:='NDipURagg1';
      end
      else
      begin
        NomeGiorni:='NGioDRagg1';
        NomeDip:='NDipDRagg1';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'C' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg2';
        NomeDip:='NDipURagg2';
      end
      else
      begin
        NomeGiorni:='NGioDRagg2';
        NomeDip:='NDipDRagg2';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'I' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg3';
        NomeDip:='NDipURagg3';
      end
      else
      begin
        NomeGiorni:='NGioDRagg3';
        NomeDip:='NDipDRagg3';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'F' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg4';
        NomeDip:='NDipURagg4';
      end
      else
      begin
        NomeGiorni:='NGioDRagg4';
        NomeDip:='NDipDRagg4';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'G' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg6';
        NomeDip:='NDipURagg6';
      end
      else
      begin
        NomeGiorni:='NGioDRagg6';
        NomeDip:='NDipDRagg6';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'B' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg8';
        NomeDip:='NDipURagg8';
      end
      else
      begin
        NomeGiorni:='NGioDRagg8';
        NomeDip:='NDipDRagg8';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'D' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg10';
        NomeDip:='NDipURagg10';
      end
      else
      begin
        NomeGiorni:='NGioDRagg10';
        NomeDip:='NDipDRagg10';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'E' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg11';
        NomeDip:='NDipURagg11';
      end
      else
      begin
        NomeGiorni:='NGioDRagg11';
        NomeDip:='NDipDRagg11';
      end;
    end;
    if selT043.FieldByName('COD_CODICIACCORPAMENTOASS').AsString = 'H' then
    begin
      if selT043.FieldByName('SESSO').AsString = 'M' then
      begin
        NomeGiorni:='NGioURagg12';
        NomeDip:='NDipURagg12';
      end
      else
      begin
        NomeGiorni:='NGioDRagg12';
        NomeDip:='NDipDRagg12';
      end;
    end;
    if (OldNome <> NomeGiorni) or (OldCodice <> selT043.FieldByName('Codice').AsString) then
    begin
      TabellaStampa.FieldByName(NomeDip).AsInteger:=selT043.FieldByName('NDip').AsInteger;
      if nArrotondamento > 0 then
        TabellaStampa.FieldByName(NomeGiorni).AsString:=Format('%-.2f',[C180FunzioniGenerali.R180Arrotonda(selT043.FieldByName('NGiorni').AsFloat,nArrotondamento,sDep)])
      else
        TabellaStampa.FieldByName(NomeGiorni).AsString:=Format('%-.2f',[selT043.FieldByName('NGiorni').AsFloat]);
    end
    else
    begin
      TabellaStampa.FieldByName(NomeDip).AsInteger:=TabellaStampa.FieldByName(NomeDip).AsInteger + selT043.FieldByName('NDip').AsInteger;
      if nArrotondamento > 0 then
        TabellaStampa.FieldByName(NomeGiorni).AsString:=Format('%-.2f',[TabellaStampa.FieldByName(NomeGiorni).AsFloat +
                                                        C180FunzioniGenerali.R180Arrotonda(selT043.FieldByName('NGiorni').AsFloat,nArrotondamento,sDep)])
      else
        TabellaStampa.FieldByName(NomeGiorni).AsString:=Format('%-.2f',[TabellaStampa.FieldByName(NomeGiorni).AsFloat + selT043.FieldByName('NGiorni').AsFloat]);
    end;
    TabellaStampa.Post;
    OldNome:=NomeGiorni;
    OldCodice:=selT043.FieldByName('Codice').AsString;
    selT043.Next;
  end;
  selT043TotQualif.First;
  while not selT043TotQualif.Eof do
  begin
    if TabellaStampa.Locate('Codice',selT043TotQualif.FieldByName('Codice').AsString,[]) then
    begin
      TabellaStampa.Edit;
      if selT043TotQualif.FieldByName('SESSO').AsString = 'M' then
      begin
        TabellaStampa.FieldByName('NTotDipU').AsInteger:=selT043TotQualif.FieldByName('NDip').AsInteger;
        TabellaStampa.FieldByName('NTotGioU').AsString:=FloatToStr(TabellaStampa.FieldByName('NGioURagg1').AsFloat + TabellaStampa.FieldByName('NGioURagg2').AsFloat +
          TabellaStampa.FieldByName('NGioURagg3').AsFloat + TabellaStampa.FieldByName('NGioURagg4').AsFloat +
          TabellaStampa.FieldByName('NGioURagg6').AsFloat + TabellaStampa.FieldByName('NGioURagg8').AsFloat +
          TabellaStampa.FieldByName('NGioURagg10').AsFloat + TabellaStampa.FieldByName('NGioURagg11').AsFloat +
          TabellaStampa.FieldByName('NGioURagg12').AsFloat);
        TabellaStampa.FieldByName('NTotGioU').AsString:=Format('%-.2f',[TabellaStampa.FieldByName('NTotGioU').AsFloat]);
      end
      else
      begin
        TabellaStampa.FieldByName('NTotDipD').AsInteger:=selT043TotQualif.FieldByName('NDip').AsInteger;
        TabellaStampa.FieldByName('NTotGioD').AsString:=FloatToStr(TabellaStampa.FieldByName('NGioDRagg1').AsFloat + TabellaStampa.FieldByName('NGioDRagg2').AsFloat +
          TabellaStampa.FieldByName('NGioDRagg3').AsFloat + TabellaStampa.FieldByName('NGioDRagg4').AsFloat +
          TabellaStampa.FieldByName('NGioDRagg6').AsFloat + TabellaStampa.FieldByName('NGioDRagg8').AsFloat +
          TabellaStampa.FieldByName('NGioDRagg10').AsFloat + TabellaStampa.FieldByName('NGioDRagg11').AsFloat +
          TabellaStampa.FieldByName('NGioDRagg12').AsFloat);
        TabellaStampa.FieldByName('NTotGioD').AsString:=Format('%-.2f',[TabellaStampa.FieldByName('NTotGioD').AsFloat]);
      end;
      TabellaStampa.Post;
    end;
    selT043TotQualif.Next;
  end;
end;

procedure TA045FStatAssenzeMW.GeneraTabella;
var i,j,ProgOld,NRagg:Integer;
  VettTotali: array [1..12] of Real;
  VettTotaliMin: array [1..12] of Real;
  RaggrOld,sDep:String;
  nArrotondamento:real;
begin
(*A-1: Ferie
  B-8: Permessi retribuiti
  C-2: Assenze per malattia
  D-10: Sciopero
  E-11: Altre assenze
  F-4: Legge 104/92
  G-6: Assenze per maternità
  H-12: Formazione
  I-3: Art.42
  L: Aspettative Tab. 3
  Z: Nessuno*)
  SelAnagrafe.First;
  while not SelAnagrafe.Eof do
  begin
    //pulizia tabella
    delT043.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    delT043.SetVariable('DADATA',R180InizioMese(DataFine));
    delT043.SetVariable('DATA',DataFine);
    delT043.Execute;
    SessioneOracle.Commit;
    SelAnagrafe.Next;
  end;
  if ListaDip.Count = 0 then
    Exit;
  RecApp:=ListaDip.Items[0];
  ProgOld:=RecApp.Progressivo;
  RaggrOld:=RecApp.Raggruppamento;
  case RecApp.Raggruppamento[1] of
    'A':NRagg:=1;
    'B':NRagg:=8;
    'C':NRagg:=2;
    'D':NRagg:=10;
    'E':NRagg:=11;
    'F':NRagg:=4;
    'G':NRagg:=6;
    'H':NRagg:=12;
    'I':NRagg:=3;
  else
    NRagg:=1;
  end;
  for j:=1 to 12 do
    VettTotali[j]:=0;
  for j:=1 to 12 do
    VettTotaliMin[j]:=0;
  case TipoArrotondamentoTotaleItemIndex of
    0:sDep:='E';
    1:sDep:='D';
    2:sDep:='P';
  end;
  nArrotondamento:=-1;
  for i:=0 to ListaDip.Count - 1 do
  begin
    RecApp:=ListaDip.Items[i];
    if (RecApp.Progressivo = ProgOld) and (RecApp.Raggruppamento = RaggrOld) then
    begin
      VettTotali[NRagg]:=VettTotali[NRagg] + RecApp.Giorni;
      VettTotaliMin[NRagg]:=VettTotaliMin[NRagg] + RecApp.Minuti;
    end
    else
    begin
      //considero l'arrot. al totale delle assenze per dip.
      case ArrotondamentoTotaleItemIndex of
        0: nArrotondamento:=-1;//non applico nessun arrotondamento, tengo il dato così com'è.
        1: nArrotondamento:=1;
        2: nArrotondamento:=0.5;
        3: begin
           if VettTotaliMin[NRagg] <> 0 then
             nArrotondamento:=(VettTotali[NRagg]/VettTotaliMin[NRagg]) * 60
           else
             nArrotondamento:=-1;
           end;
      end;
      if nArrotondamento > 0 then
        VettTotali[NRagg]:=C180FunzioniGenerali.R180Arrotonda(VettTotali[NRagg],nArrotondamento,sDep);
      //inserimento in tabella
      if VettTotali[NRagg] > 0 then
      begin
        insT043.SetVariable('PROGRESSIVO',ProgOld);
        insT043.SetVariable('DATA',DataFine);
        insT043.SetVariable('TIPOACCORPAMENTO','T11');
        insT043.SetVariable('CODICIACCORPAMENTO',RaggrOld);
        insT043.SetVariable('FRUITO',VettTotali[NRagg]);
        insT043.Execute;
        SessioneOracle.Commit;
      end;
      for j:=1 to 12 do
        VettTotali[j]:=0;
      for j:=1 to 12 do
        VettTotaliMin[j]:=0;
      ProgOld:=RecApp.Progressivo;
      RaggrOld:=RecApp.Raggruppamento;
      case RecApp.Raggruppamento[1] of
        'A':NRagg:=1;
        'B':NRagg:=8;
        'C':NRagg:=2;
        'D':NRagg:=10;
        'E':NRagg:=11;
        'F':NRagg:=4;
        'G':NRagg:=6;
        'H':NRagg:=12;
        'I':NRagg:=3;
      else
        NRagg:=1;
      end;
      VettTotali[NRagg]:=VettTotali[NRagg] + RecApp.Giorni;
      VettTotaliMin[NRagg]:=VettTotaliMin[NRagg] + RecApp.Minuti;
    end;
  end;
  //considero l'arrot. al totale delle assenze per dip.
  case ArrotondamentoTotaleItemIndex of
    0: nArrotondamento:=-1;//non applico nessun arrotondamento, tengo il dato così com'è.
    1: nArrotondamento:=1;
    2: nArrotondamento:=0.5;
    3: begin
         if VettTotaliMin[NRagg] <> 0 then
           nArrotondamento:=(VettTotali[NRagg]/VettTotaliMin[NRagg]) * 60
         else
           nArrotondamento:=-1;
       end;
  end;
  if nArrotondamento > 0 then
    VettTotali[NRagg]:=C180FunzioniGenerali.R180Arrotonda(VettTotali[NRagg],nArrotondamento,sDep);
  //inserimento in tabella
  if VettTotali[NRagg] > 0 then
  begin
    insT043.SetVariable('PROGRESSIVO',ProgOld);
    insT043.SetVariable('DATA',DataFine);
    insT043.SetVariable('TIPOACCORPAMENTO','T11');
    insT043.SetVariable('CODICIACCORPAMENTO',RaggrOld);
    insT043.SetVariable('FRUITO',VettTotali[NRagg]);
    insT043.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA045FStatAssenzeMW.SvuotaLista;
var I : Integer;
begin
  for I:=ListaDip.Count-1 downto 0 do
  begin
    try
      TRecApp(ListaDip.Items[I]).Free;
    except
    end;
    ListaDip.Delete(I);
  end;
end;

procedure TA045FStatAssenzeMW.AggiungiDip;
begin
  RecApp:=TRecApp.Create;
  RecApp.Giorni:=1;
  RecApp.Codice:=selT430.FieldByName('CODQUALIF').AsString;
  RecApp.Qualifica:=selT430.FieldByName('DESCQUALIF').AsString;
  RecApp.ProgressivoQualifica:=selT430.FieldByName('PROGQUALIF').AsInteger;
  RecApp.Raggruppamento:='A';
  RecApp.Sesso:=selT430.FieldByName('Sesso').AsString;
  RecApp.Progressivo:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
  RecApp.Data:=dSantoPatrono;
  RecApp.Causale:='';
  RecApp.Minuti:=0;
  ListaDip.Add(RecApp);
end;

procedure TA045FStatAssenzeMW.ElaboraCausaliPresenza;
var Filtro,sDep : String;
    App,i,j,xx,G,DebitoGGQM : Integer;
    nArrotondamento,PresMinuti:real;
    tgiustific_vuoto:t_tgiustificdipmese;
begin
  //Elaborazione causali di presenza per Formazione
  if Trim(Causali) <> '' then
  begin
    Filtro:=' AND CAUSALE IN (''' + StringReplace(Causali,',',''',''',[rfReplaceAll]) + ''')';
    Filtro:=Filtro + ' AND T430.QUALIFICAMINIST IN (' + sQualifiche + ')';
    if sTipiRapporto <> '' then
      Filtro:=Filtro + ' AND T430.TIPORAPPORTO IN (' + sTipiRapporto + ')';
    if GGLavorativiChecked then
      Filtro:=Filtro + ' AND NVL(T012.FESTIVO,T011.FESTIVO) = ''N'' AND NVL(T012.LAVORATIVO,T011.LAVORATIVO) = ''S'' AND TO_CHAR(NVL(T012.DATA,T011.DATA),''d'') <> 1';
    QEstrazionePresenze.Close;
    QEstrazionePresenze.SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    QEstrazionePresenze.SetVariable('DataDa',DataInizio);
    QEstrazionePresenze.SetVariable('DataA',DataFine);
    QEstrazionePresenze.SetVariable('FILTRO',Filtro);
    QEstrazionePresenze.Open;
    QEstrazionePresenze.First;
    while not QEstrazionePresenze.Eof do
    begin
      RecApp:=nil;
      RecApp:=TRecApp.Create;
      RecApp.Codice:=QEstrazionePresenze.FieldByName('CODQUALIF').AsString;
      RecApp.Qualifica:=QEstrazionePresenze.FieldByName('DESCQUALIF').AsString;
      RecApp.ProgressivoQualifica:=QEstrazionePresenze.FieldByName('PROGQUALIF').AsInteger;
      RecApp.Raggruppamento:='H';
      RecApp.Sesso:=QEstrazionePresenze.FieldByName('Sesso').AsString;
      RecApp.Progressivo:=QEstrazionePresenze.FieldByName('Progressivo').AsInteger;
      RecApp.Causale:='';
      RecApp.Data:=QEstrazionePresenze.FieldByName('DATA').AsDateTime;
      RecApp.Giorni:=0;
      RecApp.Minuti:=0;
      //Richiamare i conteggi della giornata per avere il num. di ore di presenza
      App:=0;
      with R502Pro do
      begin
        Conteggi('Servizio',RecApp.Progressivo,RecApp.Data);
        if Blocca = 0 then
        begin
          for i:=0 to High(TimbratureDelGiorno) - 1 do
            if (TimbratureDelGiorno[i].tversotimb = 'E') and
               (Pos(',' + TimbratureDelGiorno[i].tcaustimb + ',',',' + Causali + ',') > 0) and
               (selT305.SearchRecord('CODICE',TimbratureDelGiorno[i].tcaustimb,[srFromBeginning])) and
               (TimbratureDelGiorno[i + 1].tversotimb = 'U') and
               (TimbratureDelGiorno[i + 1].tcaustimb = TimbratureDelGiorno[i].tcaustimb) then
              inc(App,TimbratureDelGiorno[i + 1].toratimb - TimbratureDelGiorno[i].toratimb);
          //Caus.presenza
          for i:=1 to n_rieppres do
            if Pos(',' + triepgiuspres[i].tcauspres + ',',',' + Causali + ',') > 0 then
              for j:=1 to n_fasce do
                inc(App,triepgiuspres[i].tminpres[j]);
        end;
      end;
      if AssTutteChecked then  //Nuovo conteggio della qualifica ministeriale (dal 2005)
      begin
        with QEstrazionePresenze do
        begin
          RecApp.Minuti:=R180OreMinutiExt(FieldByName('DEBITOGGQM').AsString);
          if (RecApp.Minuti = 0) and (FieldByName('NUMGIORNISETT').AsInteger > 0) then
            RecApp.Minuti:=Round(R180OreMinutiExt(FieldByName('ORESETT').AsString)/FieldByName('NUMGIORNISETT').AsInteger);
        end;
        if RecApp.Minuti <> 0 then
          RecApp.Giorni:=RecApp.Giorni + (App / RecApp.Minuti);
      end
      else
      begin
        //Vecchia gestione della qualifica ministeriale (fino al 2004)
          if (QEstrazionePresenze.FieldByName('ORESETT').AsString = '0') or (QEstrazionePresenze.FieldByName('NUMGIORNISETT').AsInteger = 0) then
            RecApp.Minuti:=0
          else
            RecApp.Minuti:=trunc(C180FunzioniGenerali.R180OreMinutiExt(QEstrazionePresenze.FieldByName('ORESETT').AsString)/QEstrazionePresenze.FieldByName('NUMGIORNISETT').AsInteger);
        if RecApp.Minuti <> 0 then
          RecApp.Giorni:=RecApp.Giorni + (App / RecApp.Minuti);
      end;
      if RecApp.Giorni > 1 then
        RecApp.Giorni:=1;//Questo può accadere nel caso io abbia per lo stesso giorno inserito un assenza per l'intera giornata e altre ore di assenza sulla stessa causale...
      //Rapporto l'assenza alla percentuale di part-time in organico, per il tipo part-time orizzontale
      if ((ChkPartOrChecked) and (QEstrazionePresenze.FieldByName('TIPO_PT').AsString = 'O')) then
        RecApp.Giorni:=RecApp.Giorni/100 * QEstrazionePresenze.FieldByName('PERC_PT').AsFloat;
      //Applico eventuali arrotondamenti ad ogni assenza come specificato dalle opzioni...
      case TipoArrotondamentoAssenzaItemIndex of
        0:sDep:='E';
        1:sDep:='D';
        2:sDep:='P';
      end;
      nArrotondamento:=-1;
      case ArrotondamentoAssenzaItemIndex of
        0: nArrotondamento:=-1;//non applico nessun arrotondamento, tengo il dato così com'è.
        1: nArrotondamento:=1;
        2: nArrotondamento:=0.5;
        3: begin
             if PresMinuti <> 0 then
               nArrotondamento:=(1/RecApp.Minuti) * 60 //Ottengo il valore di ogni ora rispetto alla giornata lavorativa
             else
               nArrotondamento:=-1;
           end;
      end;
      if nArrotondamento > 0 then
        RecApp.Giorni:=C180FunzioniGenerali.R180Arrotonda(RecApp.Giorni,nArrotondamento,sDep);
      if RecApp.Giorni > 0 then
        ListaDip.Add(RecApp);
      QEstrazionePresenze.Next;
    end;
  end;
  //Assenze
  QEstrazioneAssenze.Close;
  QEstrazioneAssenze.SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  QEstrazioneAssenze.SetVariable('DataDa',DataInizio);
  QEstrazioneAssenze.SetVariable('DataA',DataFine);
  QEstrazioneAssenze.Open;
  QEstrazioneAssenze.First;
  RecApp:=nil;
  while not QEstrazioneAssenze.Eof do
  begin
    //So ho già aggiunto almeno un elemento nella lista e se tale elemento si riferisce allo stesso
    //dipendente, alla stessa causale di assenza nella stessa data, LO ELIMINO DALLA LISTA...
    if (ListaDip.Count > 0) and
       (QEstrazioneAssenze.FieldByName('Progressivo').AsInteger = TRecApp(ListaDip.Items[ListaDip.Count - 1]).Progressivo) and
       (QEstrazioneAssenze.FieldByName('DATA').AsDateTime = TRecApp(ListaDip.Items[ListaDip.Count - 1]).Data) and
       (QEstrazioneAssenze.FieldByName('CAUSALE').AsString = TRecApp(ListaDip.Items[ListaDip.Count - 1]).Causale) then
      RecApp:=nil;
    //Se l'elemento elaborato in precedenza è diverso per progressivo o data o causale a quello corrente
    //allora creo un altro elememento, altrimenti non lo creo e continuo a lavorare sul precedente RecApp
    if (RecApp = nil) or
       (RecApp.progressivo <> QEstrazioneAssenze.FieldByName('PROGRESSIVO').AsInteger) or
       (RecApp.data <> QEstrazioneAssenze.FieldByName('DATA').AsDateTime) or
       (RecApp.causale <> QEstrazioneAssenze.FieldByName('CAUSALE').AsString) then
    begin
      RecApp:=TRecApp.Create;
      RecApp.Giorni:=0
    end;
    RecApp.Codice:=QEstrazioneAssenze.FieldByName('CODQUALIF').AsString;
    RecApp.Qualifica:=QEstrazioneAssenze.FieldByName('DESCQUALIF').AsString;
    RecApp.ProgressivoQualifica:=QEstrazioneAssenze.FieldByName('PROGQUALIF').AsInteger;
    RecApp.Raggruppamento:=QEstrazioneAssenze.FieldByName('RaggrStat').AsString;
    RecApp.Sesso:=QEstrazioneAssenze.FieldByName('Sesso').AsString;
    RecApp.Progressivo:=QEstrazioneAssenze.FieldByName('Progressivo').AsInteger;
    RecApp.Data:=QEstrazioneAssenze.FieldByName('DATA').AsDateTime;
    RecApp.Causale:=QEstrazioneAssenze.FieldByName('CAUSALE').AsString;
    if AssTutteChecked then
    begin
    //Alberto 4/5/2005
    //Nuovo conteggio della qualifica ministeriale (dal 2005):
    //tutte le assenze vengono conteggiate in ore
    //e trasformate in giorni secondo la valorizzazione giornaliera FISSA:
    //(debito settimanale) / (gg lavorativi della qualifica minsteriale)
      G:=R180Giorno(RecApp.Data);
      for xx:=1 to MaxGiustif do R502Pro.m_tab_giustificativi[G,xx]:=tgiustific_vuoto;
      //Carico i dati dell'assenza nella matrice per R502Pro
      R502Pro.m_tab_giustificativi[G,1].tcausgius:=RecApp.Causale;
      R502Pro.m_tab_giustificativi[G,1].tdallegius:=QEstrazioneAssenze.FieldByName('DAORE').AsDateTime;
      R502Pro.m_tab_giustificativi[G,1].ttipogius:=R180CarattereDef(QEstrazioneAssenze.FieldByName('TIPOGIUST').AsString,1,'I');
      R502Pro.m_tab_giustificativi[G,1].tallegius:=QEstrazioneAssenze.FieldByName('AORE').AsDateTime;
      R502Pro.Conteggi('Assenze',RecApp.Progressivo,RecApp.Data);
      //Se i conteggi sono bloccati e si tratta di giornate, conteggio manualmente le assenze
      if R502Pro.Blocca = 0 then
      begin
        RecApp.Minuti:=R502Pro.triepgiusasse[1].tminresasse;
        with QEstrazioneAssenze do
        begin
          DebitoGGQM:=R180OreMinutiExt(FieldByName('DEBITOGGQM').AsString);
          if (DebitoGGQM = 0) and (FieldByName('NUMGIORNISETT').AsInteger > 0) then
            DebitoGGQM:=Round(R180OreMinutiExt(FieldByName('ORESETT').AsString)/FieldByName('NUMGIORNISETT').AsInteger);
          //Lorena 04/07/2011 x dirigenti con deb.=0
          if (RecApp.Minuti = 0) and (R502Pro.debitogg = 0) and (R502Pro.gglavcal = 'si') then
          begin
            case QEstrazioneAssenze.FieldByName('TipoGiust').AsString[1] of
              'I': RecApp.Giorni:=1; // giornata intera.
              'M': RecApp.Giorni:=RecApp.Giorni + 0.5; // mezza giornata
              'D': begin
                     App:=R180OreMinuti(QEstrazioneAssenze.FieldByName('AOre').AsDateTime) - R180OreMinuti(QEstrazioneAssenze.FieldByName('DaOre').AsDateTime);
                     if DebitoGGQM <> 0 then
                       RecApp.Giorni:=RecApp.Giorni + (App / DebitoGGQM);
                   end;
              'N': begin
                     App:=R180OreMinuti(QEstrazioneAssenze.FieldByName('DaOre').AsDateTime);
                     if DebitoGGQM <> 0 then
                       RecApp.Giorni:=RecApp.Giorni + (App / DebitoGGQM);
                   end;
            end;
          end
          else
          begin
            if DebitoGGQM <> 0 then
              RecApp.Giorni:=RecApp.Minuti / DebitoGGQM
            else
              RecApp.Giorni:=0;
          end;
        end;
      end;
    end
    else
    begin
      //Vecchia gestione della qualifica ministeriale (fino al 2004)
      if not(QEstrazioneAssenze.FieldByName('HMAssenza').IsNull) and (R180OreMinuti(QEstrazioneAssenze.FieldByName('HMAssenza').Value) <> 0) then
        RecApp.Minuti:=R180OreMinuti(QEstrazioneAssenze.FieldByName('HMAssenza').Value)
      else
        if (QEstrazioneAssenze.FieldByName('ORESETT').AsString = '0') or (QEstrazioneAssenze.FieldByName('NUMGIORNISETT').AsInteger = 0) then
          RecApp.Minuti:=0
        else
          RecApp.Minuti:=trunc(C180FunzioniGenerali.R180OreMinutiExt(QEstrazioneAssenze.FieldByName('ORESETT').AsString)/QEstrazioneAssenze.FieldByName('NUMGIORNISETT').AsInteger);
      case QEstrazioneAssenze.FieldByName('TipoGiust').AsString[1] of
        'I': RecApp.Giorni:=1; // giornata intera.
        'M': RecApp.Giorni:=RecApp.Giorni + 0.5; // mezza giornata
        'D': begin
               App:=R180OreMinuti(QEstrazioneAssenze.FieldByName('AOre').AsDateTime) - R180OreMinuti(QEstrazioneAssenze.FieldByName('DaOre').AsDateTime);
               if RecApp.Minuti <> 0 then
                 RecApp.Giorni:=RecApp.Giorni + (App / RecApp.Minuti);
             end;
        'N': begin
               App:=R180OreMinuti(QEstrazioneAssenze.FieldByName('DaOre').AsDateTime);
               if RecApp.Minuti <> 0 then
                 RecApp.Giorni:=RecApp.Giorni + (App / RecApp.Minuti);
             end;
      end;
      if RecApp.Giorni > 1 then
        RecApp.Giorni:=1;//Questo può accadere nel caso io abbia per lo stesso giorno inserito un assenza per l'intera giornata e altre ore di assenza sulla stessa causale...
    end;

    //Rapporto l'assenza alla percentuale di part-time in organico, per il tipo part-time orizzontale
    if ((ChkPartOrChecked) and (QEstrazioneAssenze.FieldByName('TIPO_PT').AsString = 'O')) then
      RecApp.Giorni:=RecApp.Giorni/100 * QEstrazioneAssenze.FieldByName('PERC_PT').AsFloat;
    //Applico eventuali arrotondamenti ad ogni assenza come specificato dalle opzioni...
    case TipoArrotondamentoAssenzaItemIndex of
      0:sDep:='E';
      1:sDep:='D';
      2:sDep:='P';
    end;
    nArrotondamento:=-1;
    case ArrotondamentoAssenzaItemIndex of
      0: nArrotondamento:=-1;//non applico nessun arrotondamento, tengo il dato così com'è.
      1: nArrotondamento:=1;
      2: nArrotondamento:=0.5;
      3: begin
           if RecApp.Minuti <> 0 then
             nArrotondamento:=(1/RecApp.Minuti) * 60 //Ottengo il valore di ogni ora rispetto alla giornata lavorativa
           else
             nArrotondamento:=-1;
         end;
    end;
    if nArrotondamento > 0 then
      RecApp.Giorni:=C180FunzioniGenerali.R180Arrotonda(RecApp.Giorni,nArrotondamento,sDep);
    if RecApp.Giorni > 0 then
      ListaDip.Add(RecApp);
    QEstrazioneAssenze.Next;
  end;
end;

function TA045FStatAssenzeMW.CreaListaTipiRapporto:TStringList;
var sTipo:string;
  ListaRapporti:TStringList;
begin
  with QTipiRapporto do
  begin
    Open;
    ListaRapporti:=TStringList.Create;
    while not Eof do
    begin
      sTipo:=trim(uppercase(FieldByName('Tipo').AsString));
      if sTipo = 'R' then
        sTipo:='Ruolo'
      else if sTipo = 'S' then
        sTipo:='Supplente'
      else if sTipo = 'I' then
        sTipo:='Incaricato'
      else if sTipo = 'P' then
        sTipo:='Prova'
      else if sTipo = 'A' then
        sTipo:='Altro'
      else
        sTipo:='Non riconosciuto';
      ListaRapporti.Add(Format('%-5s - %s(%s)',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString, sTipo]));
      Next;
    end;
    Result:=ListaRapporti;
    Close;
  end;
end;

function TA045FStatAssenzeMW.CreaListaQualifiche:TStringList;
var MaxLen:Integer;
    s, SqlCreato: String;
    ListaQualifiche: TStringList;
begin
  with QSceltaQualif do
  begin
    if Trim(SalvaSQL) = '' then
      SalvaSQL:=SQL.Text;
    Close;
    SQL.Clear;
    SQL.Text:=SalvaSQL;
    evtA045MergeSelAnagrafe(QSceltaQualif,False);
    evtA045MergeSettaPeriodo(QSceltaQualif,DataInizio,DataFine);
    SQL.Text:=StringReplace(SUBSTITUTEDSQL,
      ':DATALAVORO BETWEEN V430.T430DATADECORRENZA AND V430.T430DATAFINE',
      'T430DATADECORRENZA <= :DataLAVORO AND T430DATAFINE >= :DataI',[rfReplaceAll,rfIgnoreCase]);
    SQL.Text:=StringReplace(SQL.Text,
      ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
      'NVL(P430DECORRENZA,:DATALAVORO) <= :DATALAVORO AND NVL(P430DECORRENZA_FINE,:DATALAVORO) >= :DATAI',[rfReplaceAll,rfIgnoreCase]);
    SqlCreato:=evtA045SqlCreatoC700;
    if Pos('ORDER BY',SqlCreato) > 0 then
      s:=Copy(SqlCreato,1,Pos('ORDER BY',SqlCreato)-1)
    else
      s:=SqlCreato;
    SQL.Text:=StringReplace(SQL.Text,UpperCase(s),s,[rfReplaceAll]);
    SetVariable('DATAI',DataInizio);
    SetVariable('DATALAVORO',DataFine);
    Open;
    First;
    MaxLen:=0;
    while not Eof do
    begin
      if Length(FieldByName('CODICE').AsString) > MaxLen then
        MaxLen:=Length(FieldByName('CODICE').AsString);
      Next;
    end;
    if MaxLen > 20 then
      raise exception.Create(A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP20);
    if MaxLen > 6 then
      if Assigned(evtA045ShowMsg) and (TipoModulo = 'CS') then
        evtA045ShowMsg(A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP6);
    First;
    ListaQualifiche:=TStringList.Create;
    while not Eof do
    begin
      ListaQualifiche.Add(Format('%' + IntToStr(MaxLen) + 's - %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
    Result:=ListaQualifiche;
  end;
end;

function OrdinamentoTab(p1,p2 : Pointer) : Integer;
begin
  if TRecApp(p1).Codice > TRecApp(p2).Codice then
    Result:=1
  else if TRecApp(p1).Codice < TRecApp(p2).Codice then
    Result:=-1
  else if TRecApp(p1).Raggruppamento > TRecApp(p2).Raggruppamento then
    Result:=1
  else if TRecApp(p1).Raggruppamento < TRecApp(p2).Raggruppamento then
    Result:=-1
  else if TRecApp(p1).Sesso > TRecApp(p2).Sesso then
    Result:=1
  else if TRecApp(p1).Sesso < TRecApp(p2).Sesso then
    Result:=-1
  else if TRecApp(p1).Progressivo > TRecApp(p2).Progressivo then
    Result:=1
  else if TRecApp(p1).Progressivo < TRecApp(p2).Progressivo then
    Result:=-1
  else if TRecApp(p1).Data > TRecApp(p2).Data then
    Result:=1
  else if TRecApp(p1).Data < TRecApp(p2).Data then
    Result:=-1
  else if TRecApp(p1).Causale > TRecApp(p2).Causale then
    Result:=1
  else if TRecApp(p1).Causale < TRecApp(p2).Causale then
    Result:=-1
  else if TRecApp(p1).Giorni > TRecApp(p2).Giorni then
    Result:=1
  else if TRecApp(p1).Giorni < TRecApp(p2).Giorni then
    Result:=-1
  else
    Result:=0;
end;

procedure TA045FStatAssenzeMW.OrdinaListaDip;
begin
  ListaDip.Sort(OrdinamentoTab);
end;

end.
