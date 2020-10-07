unit A113UParEstrazioniStampeDTM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, RegistrazioneLog, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, (*Midaslib,*) Crtl, DBClient, Provider, C700USelezioneAnagrafe, Variants;


type
  TControlliGriglia = record
    VNumRec:Integer;
    VInizio:Integer;
    VFine:Integer;
    VLunghezza:Integer;
    VTipoRec:String;
    VTipo:String;
    VNome:String;
    VFormato:String;
    VDefault:String;
  end;
  TA113FParEstrazioniStampeDTM1 = class(TDataModule)
    Q910: TOracleDataSet;
    D910: TDataSource;
    Q930: TOracleDataSet;
    Q910CODICE: TStringField;
    Q910TITOLO: TStringField;
    Q930CODICE_STAMPA: TStringField;
    Q930TIPO_FILE: TStringField;
    Q930NOME_FILE: TStringField;
    Q930DESC_STAMPA: TStringField;
    Q911: TOracleDataSet;
    D911: TDataSource;
    Q911NOME: TStringField;
    Q911CAPTION: TStringField;
    Q931: TOracleDataSet;
    D931: TDataSource;
    Q931DATO: TStringField;
    Q931POSIZIONE: TIntegerField;
    Q931TIPO: TStringField;
    Q931VARIAZIONI_MAX: TIntegerField;
    Q930CODICE_PAR: TStringField;
    Q931CODICE_PAR: TStringField;
    Q931DATO_LOOKUP: TStringField;
    Del931: TOracleQuery;
    Q931CHIAVE: TStringField;
    SelQ930: TOracleDataSet;
    Q931VALORE_NULL: TStringField;
    Q930UTENTI_PRIVILEGI: TStringField;
    Q931FORMATO: TStringField;
    SelUser: TOracleDataSet;
    SelUserUSERNAME: TStringField;
    Q931SOMMA_RICORRENZE: TStringField;
    Q911TIPO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q930NewRecord(DataSet: TDataSet);
    procedure Q931NewRecord(DataSet: TDataSet);
    procedure Q930BeforeDelete(DataSet: TDataSet);
    procedure Q930BeforePost(DataSet: TDataSet);
    procedure Q930AfterPost(DataSet: TDataSet);
    procedure Q930AfterDelete(DataSet: TDataSet);
    procedure Q931BeforePost(DataSet: TDataSet);
    procedure Q931BeforeDelete(DataSet: TDataSet);
    procedure Q931AfterDelete(DataSet: TDataSet);
    procedure Q931AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A113FParEstrazioniStampeDTM1: TA113FParEstrazioniStampeDTM1;

implementation

uses A113UParEstrazioniStampe;

{$R *.DFM}

procedure TA113FParEstrazioniStampeDTM1.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
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
  Q910.SetVariable('APPLICAZIONE', Parametri.Applicazione);
  //Q910.SetVariable('APPLICAZIONE', 'RILPRE');
  Q910.Open;
  Q930.Open;
  try
    SelUser.Open;
  except
  end;
end;

procedure TA113FParEstrazioniStampeDTM1.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;


procedure TA113FParEstrazioniStampeDTM1.Q930NewRecord(DataSet: TDataSet);
begin
  Q930TIPO_FILE.AsString:='A';
end;

procedure TA113FParEstrazioniStampeDTM1.Q931NewRecord(DataSet: TDataSet);
begin
  Q931CODICE_PAR.AsString:=Q930CODICE_PAR.AsString;
  Q931CHIAVE.AsString:='N';
end;

procedure TA113FParEstrazioniStampeDTM1.Q930BeforeDelete(
  DataSet: TDataSet);
begin
  //Cancello anche gli eventuali record sulla tabella T931
  Del931.SetVariable('CODICEPAR', Q930CODICE_PAR.AsString);
  Del931.Execute;
  RegistraLog.SettaProprieta('C','T930_PARESTRAZIONISTAMPE',Copy(Name,1,4),Q930,True);
end;

procedure TA113FParEstrazioniStampeDTM1.Q930BeforePost(DataSet: TDataSet);
begin
  if Q930TIPO_FILE.AsString = 'O' then
  begin
    SelQ930.Close;
    SelQ930.SetVariable('TABELLA', Q930NOME_FILE.asString);
    SelQ930.Open;
    if not SelQ930.Eof then
      raise exception.Create('Impossibile assegnare alla tabella oracle il nome indicato.' + #$D#$A + 'E'' già stato assegnato tale nome nel campo ''Genera tabella sul database''.' + #$D#$A + 'Codice stampa: ' + SelQ930.FieldByName('Codice').asString + #$D#$A + 'Titolo stampa: ' + SelQ930.FieldByName('Titolo').asString);
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T930_PARESTRAZIONISTAMPE',Copy(Name,1,4),Q930,True);
    dsEdit:RegistraLog.SettaProprieta('M','T930_PARESTRAZIONISTAMPE',Copy(Name,1,4),Q930,True);
  end;
end;

procedure TA113FParEstrazioniStampeDTM1.Q930AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA113FParEstrazioniStampeDTM1.Q930AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA113FParEstrazioniStampeDTM1.Q931BeforePost(DataSet: TDataSet);
begin
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T931_TRACCIATOESTRAZIONISTAMPE',Copy(Name,1,4),Q931,True);
    dsEdit:RegistraLog.SettaProprieta('M','T931_TRACCIATOESTRAZIONISTAMPE',Copy(Name,1,4),Q931,True);
  end;
end;

procedure TA113FParEstrazioniStampeDTM1.Q931BeforeDelete(
  DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C','T931_TRACCIATOESTRAZIONISTAMPE',Copy(Name,1,4),Q931,True);
end;

procedure TA113FParEstrazioniStampeDTM1.Q931AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA113FParEstrazioniStampeDTM1.Q931AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

end.
