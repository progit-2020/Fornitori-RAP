unit S715UStampaValutazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, A000UCostanti, Data.DB,
  OracleData,Variants, A000UInterfaccia, C180FunzioniGenerali;

type
  TS715FStampaValutazioniMW = class(TR005FDataModuleMW)
    selSG746: TOracleDataSet;
    selSG750: TOracleDataSet;
    selSG751: TOracleDataSet;
    selT765: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  public
    function ListSG746 : TElencoValoriChecklist;
    function ListTipologieQuote: TElencoValoriChecklist;
    function CanAssegnaValutatore: Boolean;
    function CanProtocolla: Boolean;
    function CampiAggiuntiviC700(C700CampiBase: String): String;
    function GetDatoAnagraficoProtocollo(Tipo, Dato: String): string;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TS715FStampaValutazioniMW }

procedure TS715FStampaValutazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT765.Open;
  selSG746.Open;
  selSG750.Open;
  selSG751.Open;
end;

function TS715FStampaValutazioniMW.ListSG746: TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selSG746 do
  begin
    Close;
    SetVariable('DATARIF',Null);
    SetVariable('CAMPI_AGG',Null);
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('CODREGOLA').AsString + '.' + IntToStr(FieldByName('CODICE').AsInteger);
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-7s %s',[codice,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

function TS715FStampaValutazioniMW.ListTipologieQuote: TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;
  with selT765 do
  begin
    First;
    while not Eof do
    begin
      codice:=FieldByName('CODICE').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-5s %-65s',[Codice,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

function TS715FStampaValutazioniMW.CanAssegnaValutatore: Boolean;
begin
  Result:=((Parametri.Operatore = 'MONDOEDP') or (Parametri.Operatore = 'SYSMAN')) and (Parametri.S710_SupervisoreValut = 'S')
end;

function TS715FStampaValutazioniMW.CanProtocolla: Boolean;
begin
  Result:=VarToStr(selSG750.Lookup('TIPOXML','A','CODICE')) <> '';
end;

function TS715FStampaValutazioniMW.GetDatoAnagraficoProtocollo(Tipo,Dato:String): string;
begin
  Result:='';
  if (Pos('<#>',Dato) > 0)
  and (   (UpperCase(Tipo) = 'SENDERLIST[0].CODE')
       or (UpperCase(Tipo) = 'SENDERLIST[1].CODE')) then
  begin
    Result:=Dato;
    Result:=Copy(Result,Pos('<#>',Result) + 3);
    if Pos('<#>',Result) > 0 then
      Result:=Trim(Copy(Result,1,Pos('<#>',Result) - 1))
    else
      Result:='';
  end;
end;

function TS715FStampaValutazioniMW.CampiAggiuntiviC700(C700CampiBase: String): String;
var Dato:String;
begin
  Result:='';
  with selSG751 do
  begin
    Close;
    ClearVariables;
    Open;
    while not Eof do
    begin
      Dato:=GetDatoAnagraficoProtocollo(FieldByName('TIPO').AsString,FieldByName('DATO').AsString);
      if (Dato <> '')
      and not R180In(Copy(Dato,1,4),['T430','P430'])//Non di T430_Storico o P430_Anagrafico
      and (Pos(',' + 'T030.' + Dato + ',',',' + C700CampiBase + Result + ',') = 0) then
        Result:=Result + ',' + Dato;
      Next;
    end;
  end;
end;

end.
