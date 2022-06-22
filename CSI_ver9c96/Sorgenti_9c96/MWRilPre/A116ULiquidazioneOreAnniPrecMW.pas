unit A116ULiquidazioneOreAnniPrecMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DBClient, Oracle, DB, OracleData, Math,
  USelI010, DatiBloccati, R450,
  A000UInterfaccia, A000USessione, A029ULiquidazione, C180FunzioniGenerali;

type
  TA116FLiquidazioneOreAnniPrecMW = class(TR005FDataModuleMW)
    QCols: TOracleDataSet;
    scrT134: TOracleQuery;
    TabellaStampa: TClientDataSet;
    selT134: TOracleDataSet;
    selT430: TOracleDataSet;
    selaT134: TOracleDataSet;
    delT134: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    A029FLiquidazione: TA029FLiquidazione;
    OreDaLiquidare: Integer;
    R450DtM1:TR450DtM1;
    procedure PassaggioAnno(Progressivo:Integer);
    procedure RegistraLiquidazione(Progressivo:Integer;Liquidato,Abbattuto:String);
  public
    { Public declarations }
    DocumentoPDF,CodForm,TipoModulo:String; //CS=ClientServer, COM=COMServer
    AnnoRif:Integer;
    Data:TDateTime;
    INomeCampo:TStringList;
    INomeLogico:TStringList;
    DNomeCampo:TStringList;
    DNomeLogico:TStringList;
    selI010:TselI010;
    selDatiBloccati:TDatiBloccati;
    procedure CreaTabellaStampa;
    function CalcolaOreLiquidabili(ConsideraCessati:Boolean;var MesAnomalia:String): Boolean;
    procedure InserisciRecord(MesAnomalia:String;MaxLiq,ArrLiq:Integer;AbbattimentoOre:Boolean);
    procedure CancellaLiquidazione(Progressivo: Integer);
  end;

implementation

{$R *.dfm}

procedure TA116FLiquidazioneOreAnniPrecMW.DataModuleCreate(Sender: TObject);
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  inherited;
  A029FLiquidazione:=TA029FLiquidazione.create(nil);
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
  selDatiBloccati:=TDatiBloccati.Create(Self);
  R450DtM1:=TR450DtM1.Create(nil);
  QCols.Open;
  INomeCampo:=TStringList.Create;
  INomeLogico:=TStringList.Create;
  DNomeCampo:=TStringList.Create;
  DNomeLogico:=TStringList.Create;
  TipoModulo:='CS';
end;

procedure TA116FLiquidazioneOreAnniPrecMW.DataModuleDestroy(Sender: TObject);
begin
  INomeCampo.Free;
  INomeLogico.Free;
  DNomeCampo.Free;
  DNomeLogico.Free;
  FreeAndNil(A029FLiquidazione);
  TabellaStampa.Close;
  FreeAndNil(selI010);
  FreeAndNil(selDatiBloccati);
  R450DtM1.Free;
  inherited;
end;

procedure TA116FLiquidazioneOreAnniPrecMW.CreaTabellaStampa;
var Chiave,D_C:String;
    i,L:Integer;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Liquidabile',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Liquidato',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Abbattuto',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Anomalia',ftString,30,False);
  Chiave:='';
  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      if Chiave <> '' then
        Chiave:=Chiave + ';';
      Chiave:=Chiave + D_C;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
    Insert('D_',D_C,5);
    try
      TabellaStampa.FieldDefs.Add(D_C,ftString,40,False);
    except
    end;
  end;
  for i:=0 to DNomeCampo.Count - 1 do
  begin
    D_C:=DNomeCampo[i];
    if QCols.Locate('COLUMN_NAME',D_C,[]) then
    begin
      L:=QCols.FieldByName('DATA_LENGTH').AsInteger;
      try
        TabellaStampa.FieldDefs.Add(D_C,ftString,L,False);
      except
      end;
    end;
  end;

  if Chiave <> '' then
    Chiave:=Chiave + ';';
  Chiave:=Chiave + 'Cognome;Nome;Matricola';
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Progressivo'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('Secondario',(Chiave),[]);
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
  TabellaStampa.IndexName:='Secondario';
end;

function TA116FLiquidazioneOreAnniPrecMW.CalcolaOreLiquidabili(ConsideraCessati:Boolean;var MesAnomalia:String):Boolean;
var AnnoConte, MeseConte: Integer;
    AnnoCiclo, MeseCiclo, GiornoCiclo: Word;
    DataCiclo: TDateTime;
begin
  Result:=False;
  //Leggo il saldo solo compensabile della scheda di dicembre o dell'ultimo mese dell'anno
  //di riferimento.
  AnnoConte:=AnnoRif;
  MeseConte:=12;
  if ConsideraCessati then
  begin
    with selT430 do
    begin
      Close;
      SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
      SetVariable('Anno',IntToStr(AnnoRif));
      Open;
    end;
    MeseConte:=selT430.FieldByName('ULTIMO_MESE').AsInteger;
  end;
  selT134.Close;
  selT134.SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
  selT134.SetVariable('Data',Data);
  selT134.Open;
  if selT134.FieldByName('LIQSUCC').AsInteger > 0 then
  begin
    Result:=True;
    MesAnomalia:='Esiste già liquid.succ.';
  end
  else
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('Progressivo').AsInteger,Data,'T134') then
  begin
    Result:=True;
    MesAnomalia:='Riepiloghi bloccati';
  end
  else
  begin
    MesAnomalia:='';
    //Cancello eventuale liquidazione/abbattimento dello stesso mese per consentire di rielaborare
    //completamente i saldi in base alla situazione attuale
    delT134.SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    delT134.SetVariable('Anno',AnnoRif);
    delT134.SetVariable('Data',Data);
    delT134.Execute;
    SessioneOracle.Commit;
    R450DtM1.ConteggiMese('Generico',AnnoConte,MeseConte,SelAnagrafe.FieldByName('Progressivo').AsInteger);
    OreDaLiquidare:=0;
    if (R450DtM1.ttrovscheda[MeseConte] = 1) then
    begin
      Result:=True;
      OreDaLiquidare:=R450DtM1.salcompannoprec + R450DtM1.salliqannoprec + R450DtM1.salcompannoatt;
      selaT134.Close;
      selaT134.SetVariable('Progressivo',SelAnagrafe.FieldByName('Progressivo').AsInteger);
      selaT134.SetVariable('Anno',AnnoRif);
      selaT134.SetVariable('Data',Data);
      selaT134.Open;
      OreDaLiquidare:=OreDaLiquidare + selaT134.FieldByName('VARIAZIONE_SALDO').AsInteger;
      DataCiclo:=EncodeDate(AnnoConte + 1,1,1);
      while DataCiclo <= Data do
      begin
        DecodeDate(DataCiclo, AnnoCiclo, MeseCiclo, GiornoCiclo);
        R450DtM1.ConteggiMese('Generico',AnnoCiclo,MeseCiclo,SelAnagrafe.FieldByName('Progressivo').AsInteger);
        if (R450DtM1.ttrovscheda[MeseCiclo] = 1) then
        begin
          //OreDaLiquidare:=OreDaLiquidare - R450DtM1.abbannopreceff;
          //Alberto: 19/03/2005 - considero anche le variazioni fatte lungo il periodo già considerate nei saldi
          OreDaLiquidare:=OreDaLiquidare - R450DtM1.abbannopreceff - (R450DtM1.LiqOreAnniPrec - R450DtM1.VariazioneSaldo);
          //Alberto: 07/04/2005 - limito comunque le ore da liquidare al saldo dell'anno precedente
          OreDaLiquidare:=Min(Max(0,R450DtM1.salcompannoprec + R450DtM1.salliqannoprec),OreDaLiquidare);
        end;
        DataCiclo:=R180FineMese(DataCiclo) + 1;
      end;
      if OreDaLiquidare < 0 then
        OreDaLiquidare:=0;
    end;
  end;
end;

procedure TA116FLiquidazioneOreAnniPrecMW.InserisciRecord(MesAnomalia:String;MaxLiq,ArrLiq:Integer;AbbattimentoOre:Boolean);
var D_C,S:string;
    i,Liquidato,Abbattuto:Integer;
begin
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Badge').Value:=SelAnagrafe.FieldByName('T430Badge').Value;
  TabellaStampa.FieldByName('Cognome').Value:=SelAnagrafe.FieldByName('Cognome').Value;
  TabellaStampa.FieldByName('Nome').Value:=SelAnagrafe.FieldByName('Nome').Value;
  TabellaStampa.FieldByName('Matricola').Value:=SelAnagrafe.FieldByName('Matricola').Value;
  TabellaStampa.FieldByName('Progressivo').Value:=SelAnagrafe.FieldByName('Progressivo').Value;
  TabellaStampa.FieldByName('Anomalia').AsString:=MesAnomalia;
  if MesAnomalia <> '' then
  begin
    TabellaStampa.FieldByName('Liquidabile').Value:='**.**';
    TabellaStampa.FieldByName('Liquidato').Value:='**.**';
    TabellaStampa.FieldByName('Abbattuto').Value:='**.**';
  end
  else
  begin
    TabellaStampa.FieldByName('Liquidabile').Value:=R180MinutiOre(OreDaLiquidare);
    Abbattuto:=0;
    if OreDaLiquidare > MaxLiq then
    begin
      Liquidato:=MaxLiq;
      if AbbattimentoOre then
        Abbattuto:=OreDaLiquidare - Liquidato;
    end
    else
      Liquidato:=OreDaLiquidare;
    if ArrLiq > 1 then
      Liquidato:=(Liquidato div ArrLiq) * ArrLiq;
    if Liquidato < 0 then
      Liquidato:=0;
    TabellaStampa.FieldByName('Liquidato').Value:=R180MinutiOre(Liquidato);
    TabellaStampa.FieldByName('Abbattuto').Value:=R180MinutiOre(Abbattuto);
    RegistraLiquidazione(SelAnagrafe.FieldByName('Progressivo').AsInteger, R180MinutiOre(Liquidato), R180MinutiOre(Abbattuto));
    RegistraLog.SettaProprieta('M','T134_ORELIQUIDATEANNIPREC',CodForm,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(SelAnagrafe.FieldByName('Progressivo').AsInteger),'');
    RegistraLog.InserisciDato('DATA',DateToStr(Data),'');
    RegistraLog.RegistraOperazione;
  end;
  for i:=0 to INomeCampo.Count - 1 do
  begin
    D_C:=INomeCampo[i];
    S:=Format('%-*s',[SelAnagrafe.FieldByName(D_C).Size,SelAnagrafe.FieldByName(D_C).AsString]);
    TabellaStampa.FieldByName(D_C).AsString:=S;
    Insert('D_',D_C,5);
    try
      TabellaStampa.FieldByName(D_C).AsString:=SelAnagrafe.FieldByName(D_C).AsString;
    except
    end;
  end;
  for i:=0 to DNomeCampo.Count - 1 do
    TabellaStampa.FieldByName(DNomeCampo[i]).AsString:=SelAnagrafe.FieldByName(DNomeCampo[i]).AsString;
  TabellaStampa.Post;
end;

procedure TA116FLiquidazioneOreAnniPrecMW.RegistraLiquidazione(Progressivo:Integer;Liquidato,Abbattuto:String);
//Liquidazione delle ore indicate e aggiornamento dei residui tramite la funzione di passaggio di anno
begin
  scrT134.SetVariable('Progressivo',Progressivo);
  scrT134.SetVariable('Anno',AnnoRif);
  scrT134.SetVariable('Data',Data);
  scrT134.SetVariable('OreLiquidate',Liquidato);
  if R180OreMinutiExt(Abbattuto) > 0 then
    scrT134.SetVariable('VariazioneOre','-' + Abbattuto)
  else
    scrT134.SetVariable('VariazioneOre',Abbattuto);
  scrT134.Execute;
  SessioneOracle.Commit;
  PassaggioAnno(Progressivo);
end;

procedure TA116FLiquidazioneOreAnniPrecMW.CancellaLiquidazione(Progressivo:Integer);
//Cancello le liquidazioni solo se non sono bloccate
begin
  if not selDatiBloccati.DatoBloccato(Progressivo,Data,'T134') then
  begin
    //Cancello eventuale liquidazione/abbattimento dello stesso anno e mese
    delT134.SetVariable('Progressivo',Progressivo);
    delT134.SetVariable('Anno',AnnoRif);
    delT134.SetVariable('Data',Data);
    delT134.Execute;
    SessioneOracle.Commit;
    PassaggioAnno(Progressivo);
  end;
end;

procedure TA116FLiquidazioneOreAnniPrecMW.PassaggioAnno(Progressivo:Integer);
//Passaggio di anno delle ore residue
begin
  A029FLiquidazione.AggiornaResiduiSuccessivi(Progressivo,R180Anno(Data));
end;

end.
