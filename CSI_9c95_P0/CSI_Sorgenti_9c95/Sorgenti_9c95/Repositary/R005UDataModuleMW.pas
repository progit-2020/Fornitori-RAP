unit R005UDataModuleMW;

interface

uses
  SysUtils, Classes, DB, Oracle, OracleData,
  A000UInterfaccia;

type
  // tipi proc. generiche
  TprocString = procedure(S: String) of object;
  TprocInteger = procedure(i: Integer) of object;
  TprocNone = procedure of object;
  TprocObject = procedure(Sender: TObject) of object;
  // tipi proc. per eventi dataset
  TAfterOpen = procedure(DataSet: TDataSet) of object;
  TAfterPost = procedure(DataSet: TDataSet) of object;
  TAfterRefresh = procedure(DataSet: TDataSet) of object;
  TAfterScroll = procedure(DataSet: TDataSet) of object;
  TBeforeDelete = procedure(DataSet: TDataSet) of object;
  TBeforeEdit = procedure(DataSet: TDataSet) of object;
  TBeforeInsert = procedure(DataSet: TDataSet) of object;
  TBeforePost = procedure(DataSet: TDataSet) of object;
  TOnCalcFields = procedure(DataSet: TDataSet) of object;
  TOnFilterRecord = procedure(DataSet: TDataSet; var Accept: Boolean) of object;
  TOnPostError = procedure(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction) of object;

  TmedpFieldHelper = class helper for TField
  public
    function medpOldValue: Variant;
  end;

  TR005FDataModuleMW = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    NomeOwner:String;
    function ProgressivoC700:Integer;
  public
    SelAnagrafe: TOracleDataSet;
    ScriviStatusBar:TprocString;
    ResettaProgressBar:TprocNone;
    IncrementaProgressBar:TprocNone;
    MaxProgressBar:TprocInteger;
    // codice form per registrazione log e altre attività
    CodForm: string;
  end;

implementation

{$R *.dfm}

{ TmedpFieldHelper }
function TmedpFieldHelper.medpOldValue: Variant;
begin
  Result:=Self.OldValue;
  if Self.DataSet.State = dsInsert then
    raise Exception.Create('medpOldValue non accessibile!' + #13#10 + 'Notificare al servizio di assistenza del software.');
end;

procedure TR005FDataModuleMW.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  inherited;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      // dataset: assegna sessione oracle
      if (Components[i] as TOracleDataSet).Session = nil then
        (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end
    else if Components[i] is TOracleQuery then
    begin
      // oracle query
      // assegna sessione oracle
      if (Components[i] as TOracleQuery).Session = nil then
        (Components[i] as TOracleQuery).Session:=SessioneOracle;
    end
    else if Components[i] is TOracleScript then
    begin
      // oracle script
      // assegna sessione oracle
      if (Components[i] as TOracleScript).Session = nil then
        (Components[i] as TOracleScript).Session:=SessioneOracle;
    end;
  end;
  NomeOwner:='';
  if Owner <> nil then
    NomeOwner:=Copy(Owner.Name,1,{$IFNDEF WEBPJ}4{$ELSE}5{$ENDIF});
  //Se Owner valorizzato ma con nome nullo, utilizzo il nome di sè stesso (in IrisCloud è W + nome)
  //es. A112 che deve creare A12MW con owner = SessioneIrisWIN per utilizzo in R110
  if NomeOwner = '' then
    NomeOwner:={$IFDEF WEBPJ}'W' + {$ENDIF}Copy(Self.Name,1,4);
 except
 end;
end;

function TR005FDataModuleMW.ProgressivoC700: Integer;
// estrae il progressivo corrente di SelAnagrafe
begin
  if (SelAnagrafe <> nil) and (SelAnagrafe.Active) then
    Result:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
  else
    Result:=0;
end;

end.
