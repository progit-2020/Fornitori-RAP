unit A047UTimbMensaMW;

interface

uses
  System.SysUtils, System.Classes, R500Lin, R005UDataModuleMW,Variants,
  A000UCostanti, C180FunzioniGenerali, Data.DB, R300UAccessiMensaDtM,
  OracleData, QueryStorico, A000USessione, A000UInterfaccia, A000UGestioneTimbraGiustMW, DatiBloccati,
  A000UMessaggi, USelI010, Oracle;

type
  TA047ListaRaggr = record
   NomeLogico:String;
    NomeCampo:String;
  end;

  T047ArrListaRaggr = array of TA047ListaRaggr;

  TConteggiPasti = record
    pastiInt: Integer;
    pastiCon: Integer;
  end;

  TA047FTimbMensaMW = class(TR005FDataModuleMW)
    Q012: TOracleDataSet;
    Q040: TOracleDataSet;
    Q370: TOracleDataSet;
    Q370PROGRESSIVO: TFloatField;
    Q370DATA: TDateTimeField;
    Q370ORA: TDateTimeField;
    Q370VERSO: TStringField;
    Q370FLAG: TStringField;
    Q370RILEVATORE: TStringField;
    Q370CAUSALE: TStringField;
    D370: TDataSource;
    selT375: TOracleDataSet;
    Q011: TOracleDataSet;
    D265: TDataSource;
    D305: TDataSource;
    Q265: TOracleDataSet;
    Q305: TOracleDataSet;
    Q275: TOracleDataSet;
    D275: TDataSource;
    DOrologi: TDataSource;
    QOrologi: TOracleDataSet;
    scrRipristinoOriginali: TOracleQuery;
    procedure Q370ORAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure Q370ORASetText(Sender: TField; const Text: string);
    procedure Q370AfterPost(DataSet: TDataSet);
    procedure Q370BeforeDelete(DataSet: TDataSet);
    procedure Q370BeforePost(DataSet: TDataSet);
    procedure Q370NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QOrologiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure AzzeraTabelle;
    procedure CaricaArrayAccessi;
    procedure AzzeraArrayAccessi;
  public
    A000FGestioneTimbraGiustMW: TA000FGestioneTimbraGiustMW;
    R300FAccessiMensaDtM:TR300FAccessiMensaDtM;
    MaxGiorni: Word;
    selI010:TselI010;
    QSCalendario:TQueryStorico;
    FAccessi: Array [1..31,1..MaxAccessi] of TAccessiMensa;
    FNumAccessi:Array[1..31] of Byte;
    selDatiBloccati:TDatiBloccati;
    procedure CaricaMese(Anno, Mese: Integer; bCalc: boolean);
    function DescrizioneCausale(Causale: String): String;
    procedure RicaricaArrayAccessi(Data: TDateTime);
    function ConteggiGiorno(Progressivo: Integer;Data: TDateTime): TConteggiPasti;
    function ModificaNumeroAccessi(Data: TDateTime; Progressivo: Integer; causale, PranzoCena: String; NumeroAccessi: Integer): boolean;
    function NuovoAccessoManuale(Progressivo: Integer; Data: TDateTime; AccessiMensa: TAccessiMensa): String;
    procedure EliminaTimbratureRiscaricate(Progressivo: Integer; DataInizio, DataFine: TDateTime);

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA047FTimbMensaMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  MaxGiorni:=31;
  A000FGestioneTimbraGiustMW:=TA000FGestioneTimbraGiustMW.Create(Self);
  A000FGestioneTimbraGiustMW.QGiustificativi:=Q040;
  A000FGestioneTimbraGiustMW.QTimbrature:=Q370;

  Q265.Open;
  Q275.Open;
  Q305.Open;
  QOrologi.Open;
  QSCalendario:=TQueryStorico.Create(nil);
  QSCalendario.Session:=SessioneOracle;
  R300FAccessiMensaDtM:=TR300FAccessiMensaDtM.Create(nil);
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
end;


procedure TA047FTimbMensaMW.EliminaTimbratureRiscaricate(Progressivo:Integer; DataInizio,DataFine:TDateTime);
begin
  scrRipristinoOriginali.SetVariable('PROGRESSIVO',Progressivo);
  scrRipristinoOriginali.SetVariable('DAL',DataInizio);
  scrRipristinoOriginali.SetVariable('AL',DataFine);
  scrRipristinoOriginali.Execute;
  SessioneOracle.Commit;
  RegistraLog.SettaProprieta('M','T370_TIMBMENSA',nomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
  RegistraLog.InserisciDato('RIPRISTINO DAL - AL',Format('%s - %s',[DateToStr(DataInizio),DateToStr(DataFine)]),'');
  RegistraLog.RegistraOperazione;
end;

function TA047FTimbMensaMW.ConteggiGiorno(Progressivo:Integer; Data:TDateTime): TConteggiPasti;
begin
  R300FAccessiMensaDtM.selT375.Close;  //Alberto 09/04/2014: chiudo per fare refresh dei dati
  R300FAccessiMensaDtM.ConteggiaPasti(Progressivo,Data);
  Result.pastiCon:=R300FAccessiMensaDtM.PastiCon;
  Result.pastiInt:=R300FAccessiMensaDtM.PastiInt;
end;

procedure TA047FTimbMensaMW.AzzeraTabelle;
{Azzero i vettori e abblenco i grid}
begin
  AzzeraArrayAccessi;
  A000FGestioneTimbraGiustMW.AzzeraTabelle;
end;

procedure TA047FTimbMensaMW.AzzeraArrayAccessi;
var i,j:Byte;
    xx:Integer;
begin
  for xx:=Low(FNumAccessi) to High(FNumAccessi) do FNumAccessi[xx]:=0;
  for i:=1 to 31 do
    for j:=1 to MaxAccessi do
    begin
       FAccessi[i,j].PranzoCena:='';
       FAccessi[i,j].Accessi:=0;
       FAccessi[i,j].Causale:='';
       FAccessi[i,j].Rilevatore:='';
    end;
end;

{Cambio i parametri alle query e carico i vettori Timbrature e Giustificativi
con i dati del mese}
procedure TA047FTimbMensaMW.CaricaMese(Anno,Mese:Integer;bCalc: boolean);
var  Inizio,Fine:TDateTime;
begin
  AzzeraTabelle;
  MaxGiorni:=R180GiorniMese(EncodeDate(Anno,Mese,1));
  Inizio:=EncodeDate(Anno,Mese,1);
  Fine:=EncodeDate(Anno,Mese,MaxGiorni);
  //Se i conteggi sono aperti imposto il periodo richiesto
  if bCalc then
    R300FAccessiMensaDtM.SettaPeriodo(Inizio,Fine);

  {Limito la vista dei giustificativi (Query) e timbrature (Query+Tabella)}
  Q012.Close;
  Q040.Close;
  Q370.Close;
  selT375.Close;
  Q012.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q012.SetVariable('DataInizio',Inizio);
  Q012.SetVariable('DataFine',Fine);
  Q040.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q040.SetVariable('DataInizio',Inizio);
  Q040.SetVariable('DataFine',Fine);
  Q370.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q370.SetVariable('DataInizio',Inizio);
  Q370.SetVariable('DataFine',Fine);
  selT375.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT375.SetVariable('DataInizio',Inizio);
  selT375.SetVariable('DataFine',Fine);
  Q012.Open;
  Q040.Open;
  Q370.Open;
  selT375.Open;
  A000FGestioneTimbraGiustMW.CaricaArrayGiustificativi(nil,nil);
  A000FGestioneTimbraGiustMW.CaricaArrayTimbrature;
  //Accessi
  CaricaArrayAccessi;

  QSCalendario.GetDatiStorici('T430CALENDARIO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Inizio,Fine);
end;

procedure TA047FTimbMensaMW.RicaricaArrayAccessi(Data: TDateTime);
var
  day,j: Integer;
begin
  //ricarica array per il solo giorno indicato
  selT375.Filtered:=True;
  selT375.Filter:='Data = ' + FloatToStr(Data);
  day:=R180Giorno(Data);
  FNumAccessi[day]:=0;
  for j:=1 to MaxAccessi do
  begin
    FAccessi[day,j].PranzoCena:='';
    FAccessi[day,j].Accessi:=0;
    FAccessi[day,j].Causale:='';
    FAccessi[day,j].Rilevatore:='';
  end;

  CaricaArrayAccessi;
  selT375.Filtered:=False;
end;

procedure TA047FTimbMensaMW.CaricaArrayAccessi;
var
  i,j:Integer;
begin
  i:=0;
  j:=0;
  selT375.First;
  while not selT375.Eof do
  begin
    if StrToInt(FormatDateTime('dd',selT375.FieldByName('Data').AsDateTime)) <> i then
    begin
      i:=StrToInt(FormatDateTime('dd',selT375.FieldByName('Data').AsDateTime));
      j:=0;
    end;
    if j < MaxAccessi then
    begin
      j:=j+1;
      FNumAccessi[i]:=j;
      FAccessi[i,j].PranzoCena:=selT375.FieldByName('PranzoCena').AsString;
      FAccessi[i,j].Accessi:=selT375.FieldByName('Accessi').AsInteger;
      FAccessi[i,j].Causale:=selT375.FieldByName('Causale').AsString;
      FAccessi[i,j].Rilevatore:=selT375.FieldByName('Rilevatore').AsString;
    end;
    selT375.Next;
  end;
end;

procedure TA047FTimbMensaMW.Q370AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA047FTimbMensaMW.Q370BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),nomeOwner,DataSet,True);
end;

procedure TA047FTimbMensaMW.Q370BeforePost(DataSet: TDataSet);
var
  Op: String;
begin
  if DataSet.State = dsEdit then
    if Q370Flag.AsString = 'C' then
      Op:='C'
    else
      Op:='M';
  if DataSet.State = dsInsert then
    if A000FGestioneTimbraGiustMW.StatoTimb = stInserimento then
      Op:='I'
    else
      Op:='M';
  RegistraLog.SettaProprieta(Op,R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA047FTimbMensaMW.Q370NewRecord(DataSet: TDataSet);
{Inizializzo nuova timbratura manuale}
var H,M,S,MS:Word;
begin
  inherited;
  Q370.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if A000FGestioneTimbraGiustMW.EU in ['E','U'] then
    //Inverto il verso rispetto alla precedente timbratura
    begin
    if A000FGestioneTimbraGiustMW.EU = 'E' then
      Q370.FieldByName('Verso').AsString:='U'
    else
      Q370.FieldByName('Verso').AsString:='E';
    end
  else
    Q370.FieldByName('Verso').AsString:='E';
  Q370.FieldByName('Flag').AsString:='I';
  DecodeTime(Time,H,M,S,MS);
  Q370.FieldByName('Ora').AsDateTime:=EncodeDate(1900,1,1) + EncodeTime(H,M,0,0);
end;

procedure TA047FTimbMensaMW.Q370ORAGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:='' else Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA047FTimbMensaMW.Q370ORASetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TA047FTimbMensaMW.QOrologiFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  //Chiamata: 83085
  Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA',QOrologi.FieldByName('CODICE').AsString);
end;

function TA047FTimbMensaMW.DescrizioneCausale(Causale:String): String;
begin
  Result:='';
  if Q265.Locate('Codice',Causale,[]) then
    Result:=Q265.FieldByName('Descrizione').AsString
  else if Q275.Locate('Codice',Causale,[]) then
    Result:=Q275.FieldByName('Descrizione').AsString
  else if Q305.Locate('Codice',Causale,[]) then
    Result:=Q305.FieldByName('Descrizione').AsString
end;

function TA047FTimbMensaMW.ModificaNumeroAccessi(Data:TDateTime; Progressivo:Integer; causale,PranzoCena:String;NumeroAccessi:Integer):boolean;
begin
  Result:=False;
  if selDatiBloccati.DatoBloccato(Progressivo,R180InizioMese(Data),'T375') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  with selT375 do
  begin
    if SearchRecord('Data;Causale;PranzoCena',VarArrayOf([Data,causale,PranzoCena]),[srFromBeginning]) then
    begin
      if NumeroAccessi > 0 then
      begin
        Edit;
        FieldByName('Accessi').AsInteger:=NumeroAccessi;
        Post;
      end
      else
      begin
        Delete
      end;
      RicaricaArrayAccessi(Data);
      Result:=True;
    end
  end;
end;

function TA047FTimbMensaMW.NuovoAccessoManuale(Progressivo:Integer; Data:TDateTime;AccessiMensa: TAccessiMensa): String;
begin
  Result:='';
  try
    selT375.Append;
    selT375.FieldByName('Progressivo').AsInteger:=Progressivo;
    selT375.FieldByName('Data').AsDateTime:= Data;
    selT375.FieldByName('Causale').AsString:=AccessiMensa.Causale;
    selT375.FieldByName('PranzoCena').AsString:=AccessiMensa.PranzoCena;
    selT375.FieldByName('Rilevatore').AsString:=AccessiMensa.Rilevatore;
    selT375.FieldByName('Accessi').AsInteger:=AccessiMensa.Accessi;
    selT375.Post;
    RicaricaArrayAccessi(Data);
  except
    Result:=A000MSG_A047_ERR_CAUSALE;
    selT375.Cancel;
  end;
end;

procedure TA047FTimbMensaMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A000FGestioneTimbraGiustMW);
  FreeAndNil(QSCalendario);
  FreeAndNil(R300FAccessiMensaDtM);
  FreeAndNil(SelDatiBloccati);
  FreeAndNil(selI010);
  inherited;
end;

end.
