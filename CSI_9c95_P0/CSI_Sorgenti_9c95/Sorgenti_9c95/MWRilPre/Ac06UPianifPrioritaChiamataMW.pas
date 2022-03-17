unit Ac06UPianifPrioritaChiamataMW;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Data.DB, OracleData, Oracle,
  R005UDataModuleMW, A000UInterfaccia, A000UMessaggi;

type
  TAc06FPianifPrioritaChiamataMW = class(TR005FDataModuleMW)
  private
  public
    selT381: TOracleDataSet;
    Data: TDateTime;
    Progressivo,Priorita:Integer;
    procedure Controlli;
    procedure RecuperaPriorita;
    procedure InserisciPriorita;
    procedure CancellaPriorita;
  end;

implementation

{$R *.dfm}

procedure TAc06FPianifPrioritaChiamataMW.Controlli;
begin
  if SelAnagrafe.RecordCount = 0 then
    raise Exception.create(A000MSG_ERR_NO_DIP);
  if Data = 0 then
    raise Exception.create(A000MSG_ERR_DATA_ERRATA);
  if not Priorita in [1,2,3] then
    raise Exception.create(A000MSG_Ac06_ERR_PRIORITA);
end;

procedure TAc06FPianifPrioritaChiamataMW.RecuperaPriorita;
begin
  selT381.Close;
  selT381.SetVariable('Progressivo',Progressivo);
  selT381.Open;
end;

procedure TAc06FPianifPrioritaChiamataMW.InserisciPriorita;
{Inserimento della priorità: cancello eventualmente quella già esistente}
begin
  if selT381.SearchRecord('DATA',Data,[srFromBeginning]) then
  begin
    RegistraLog.SettaProprieta('C','T381_PIANIF_PRIORITACHIAMATA',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',selT381.FieldByName('Progressivo').AsString);
    RegistraLog.InserisciDato('DATA','',selT381.FieldByName('Data').AsString);
    RegistraLog.InserisciDato('PRIORITA','',selT381.FieldByName('Priorita').AsString);
    RegistraLog.RegistraOperazione;
    selT381.Delete;
  end;
  selT381.Insert;
  selT381.FieldByName('Progressivo').AsInteger:=Progressivo;
  selT381.FieldByName('Data').AsDateTime:=Data;
  selT381.FieldByName('Priorita').AsInteger:=Priorita;
  selT381.Post;
  RegistraLog.SettaProprieta('I','T381_PIANIF_PRIORITACHIAMATA',NomeOwner,nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',selT381.FieldByName('Progressivo').AsString,'');
  RegistraLog.InserisciDato('DATA',selT381.FieldByName('Data').AsString,'');
  RegistraLog.InserisciDato('PRIORITA',selT381.FieldByName('Priorita').AsString,'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TAc06FPianifPrioritaChiamataMW.CancellaPriorita;
{Cancellazione della priorità: chiave = Progressivo + Data + Priorità}
begin
  if selT381.SearchRecord('DATA',Data,[srFromBeginning]) then
    if selT381.FieldByName('Priorita').AsInteger = Priorita then
    begin
      RegistraLog.SettaProprieta('C','T381_PIANIF_PRIORITACHIAMATA',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',selT381.FieldByName('Progressivo').AsString);
      RegistraLog.InserisciDato('DATA','',selT381.FieldByName('Data').AsString);
      RegistraLog.InserisciDato('PRIORITA','',selT381.FieldByName('Priorita').AsString);
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
      selT381.Delete;
    end;
end;

end.
