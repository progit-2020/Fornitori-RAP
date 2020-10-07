unit A036UTurniRepMW;

interface

uses
  SysUtils, Variants, Classes, OracleData, DB, R005UDataModuleMW,
  DatiBloccati, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA036FTurniRepMW = class(TR005FDataModuleMW)
    selT350: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selDatiBloccati:TDatiBloccati;
  public
    selT340:TOracleDataSet;
    procedure OnCalcFields;
    procedure OnNewRecord;
    procedure BeforePost;
    procedure BeforeDelete;
    procedure AfterDelete;
    procedure selT340ValidaOre(Sender:TField);
    procedure selT340ValidaVoce(Sender: TField);
    procedure SettaProgressivo;
    procedure CaricaPickList(PL:TStrings;Tipo:String);
  end;

implementation

{$R *.dfm}

procedure TA036FTurniRepMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  selT350.Open;
end;

procedure TA036FTurniRepMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

procedure TA036FTurniRepMW.OnCalcFields;
begin
  selT340.FieldByName('CalcMese').AsString:=R180Capitalize(R180NomeMese(selT340.FieldByName('Mese').AsInteger));
end;

procedure TA036FTurniRepMW.OnNewRecord;
begin
  selT340.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TA036FTurniRepMW.BeforePost;
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT340.FieldByName('Anno').AsString),StrToInt(selT340.FieldByName('Mese').AsString),1),'T340') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
  if Trim(selT340.FieldByName('VP_TURNO').AsString) = '' then
    selT340.FieldByName('VP_TURNO').AsString:='<NO>';
  if Trim(selT340.FieldByName('VP_ORE').AsString) = '' then
    selT340.FieldByName('VP_ORE').AsString:='<NO>';
  if Trim(selT340.FieldByName('VP_MAGGIORATE').AsString) = '' then
    selT340.FieldByName('VP_MAGGIORATE').AsString:='<NO>';
  if Trim(selT340.FieldByName('VP_NONMAGGIORATE').AsString) = '' then
    selT340.FieldByName('VP_NONMAGGIORATE').AsString:='<NO>';
  if QueryPK1.EsisteChiave('T340_TURNIREPERIB',selT340.RowId,selT340.State,
    ['PROGRESSIVO','ANNO','MESE','VP_TURNO','VP_ORE','VP_MAGGIORATE','VP_NONMAGGIORATE'],
    [selT340.FieldByName('PROGRESSIVO').AsString,selT340.FieldByName('ANNO').AsString,selT340.FieldByName('MESE').AsString,
     selT340.FieldByName('VP_TURNO').AsString,selT340.FieldByName('VP_ORE').AsString,
     selT340.FieldByName('VP_MAGGIORATE').AsString,selT340.FieldByName('VP_NONMAGGIORATE').AsString]) then
    raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
end;

procedure TA036FTurniRepMW.BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Encodedate(StrToInt(selT340.FieldByName('Anno').AsString),StrToInt(selT340.FieldByName('Mese').AsString),1),'T340') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA036FTurniRepMW.AfterDelete;
var A,M:Word;
begin
  A:=selT340.FieldByName('Anno').AsInteger;
  M:=selT340.FieldByName('Mese').AsInteger;
  selT340.Refresh;
  selT340.Locate('Anno;Mese',VarArrayOf([A,M]),[]);
end;

procedure TA036FTurniRepMW.selT340ValidaOre(Sender:TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA036FTurniRepMW.selT340ValidaVoce(Sender: TField);
begin
  if (Sender.AsString = '<SI>') or (Sender.AsString = '<NO>') then
    exit;
  if not selT350.SearchRecord('TIPO;VOCEPAGHE',VarArrayOf([Sender.FieldName,Sender.AsString]),[srFromBeginning]) then
    raise Exception.Create(Format(A000MSG_ERR_FMT_NON_ESISTENTE,['Voce paghe']));
end;

procedure TA036FTurniRepMW.SettaProgressivo;
begin
  if SelAnagrafe <> nil then
  begin
    selT340.Close;
    selT340.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT340.Open;
  end;
end;

procedure TA036FTurniRepMW.CaricaPickList(PL:TStrings;Tipo:String);
begin
  PL.Clear;
  PL.Add('<SI>');
  PL.Add('<NO>');
  with selT350 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('TIPO').AsString = Tipo then
        PL.Add(FieldByName('VOCEPAGHE').AsString);
      Next;
    end;
  end;
end;

end.
