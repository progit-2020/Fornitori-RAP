unit S750UParProtocolloDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione, A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, USelI010, A000UMessaggi, S750UParProtocolloMW;

type
  TDati = record
    Ord:Integer;
    Tipo,Desc,Dato:String;
  end;

  TS750FParProtocolloDtM = class(TDataModule)
    D751: TDataSource;
    SG750: TOracleDataSet;
    SG750CODICE: TStringField;
    SG750DESCRIZIONE: TStringField;
    SG751: TOracleDataSet;
    SG751CODICE: TStringField;
    SG751TIPO: TStringField;
    SG750TIPOXML: TStringField;
    selTipoXML_old: TOracleDataSet;
    SG751ORDINE: TIntegerField;
    SG751DESCRIZIONE: TStringField;
    SG751DATO: TStringField;
    dTipoXML_old: TDataSource;
    SG750WS_URL: TStringField;
    insSG751_old: TOracleQuery;
    updSG751_old: TOracleQuery;
    delSG751_old: TOracleQuery;
    selTipoXML_oldCODICE: TStringField;
    selTipoXML_oldDESCRIZIONE: TStringField;
    SG750D_TIPOXML: TStringField;
    D010_old: TDataSource;
    procedure S750FParProtocolloDtMCreate(Sender: TObject);
    procedure S750FParProtocolloDtMDestroy(Sender: TObject);
    procedure SG750AfterPost(DataSet: TDataSet);
    procedure SG750AfterCancel(DataSet: TDataSet);
    procedure SG750BeforePost(DataSet: TDataSet);
    procedure SG750AfterDelete(DataSet: TDataSet);
    procedure SG750AfterScroll(DataSet: TDataSet);
    procedure SG750AfterEdit(DataSet: TDataSet);
    procedure SG750AfterInsert(DataSet: TDataSet);
    procedure SG750BeforeDelete(DataSet: TDataSet);
    procedure SG751BeforeDelete(DataSet: TDataSet);
    procedure SG751BeforeInsert(DataSet: TDataSet);
    procedure SG750CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    S750FParProtocolloMW: TS750FParProtocolloMW;
  end;

var
  S750FParProtocolloDtM: TS750FParProtocolloDtM;

implementation

uses S750UParProtocollo;

{$R *.DFM}

procedure TS750FParProtocolloDtM.S750FParProtocolloDtMCreate(Sender: TObject);
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

  //creazione del middleware
  S750FParProtocolloMW:=TS750FParProtocolloMW.Create(Self);
  S750FParProtocolloMW.SG750:=SG750;
  S750FParProtocolloMW.SG751:=SG751;
  S750FParProtocolloMW.D751:=D751;
  SG750.Open;
  S750FParProtocollo.DButton.DataSet:=SG750;
end;

procedure TS750FParProtocolloDtM.S750FParProtocolloDtMDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TS750FParProtocolloDtM.SG750AfterPost(DataSet: TDataSet);
var i:Integer;
    Trovato:Boolean;
begin
  SessioneOracle.ApplyUpdates([SG751],True);
  S750FParProtocolloMW.AfterPost;
  SG751.ReadOnly:=True;
  D751.AutoEdit:=False;
  SG750AfterScroll(SG750);
  RegistraLog.RegistraOperazione;
end;

procedure TS750FParProtocolloDtM.SG750AfterCancel(DataSet: TDataSet);
begin
  SG750.CancelUpdates;
  if SG751.CachedUpdates then
    SG751.CancelUpdates;
  SG751.ReadOnly:=True;
  D751.AutoEdit:=False;
  SG750AfterScroll(SG750);
end;

procedure TS750FParProtocolloDtM.SG750BeforePost(DataSet: TDataSet);
begin
  S750FParProtocolloMW.BeforePostNoStorico;
  if QueryPK1.EsisteChiave('SG750_PARPROTOCOLLO',SG750.RowId,SG750.State,['CODICE'],[SG750Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
  end;
end;

procedure TS750FParProtocolloDtM.SG750CalcFields(DataSet: TDataSet);
begin
  S750FParProtocolloMW.SG750CalcFields(DataSet);
end;

procedure TS750FParProtocolloDtM.SG751BeforeDelete(DataSet: TDataSet);
begin
  abort;
end;

procedure TS750FParProtocolloDtM.SG751BeforeInsert(DataSet: TDataSet);
begin
  abort;
end;

procedure TS750FParProtocolloDtM.SG750AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TS750FParProtocolloDtM.SG750AfterScroll(DataSet: TDataSet);
begin
  R180SetVariable(SG751,'Codice',SG750.FieldByName('Codice').AsString);
  SG751.Open;
  D751.AutoEdit:=False;
end;

procedure TS750FParProtocolloDtM.SG750AfterEdit(DataSet: TDataSet);
begin
  S750FParProtocolloMW.SG750AfterEdit(DataSet);
  SG751.ReadOnly:=False;
  D751.AutoEdit:=True;
  SG751.FieldByName('ORDINE').ReadOnly:=True;
  SG751.FieldByName('TIPO').ReadOnly:=True;
end;

procedure TS750FParProtocolloDtM.SG750AfterInsert(DataSet: TDataSet);
begin
  S750FParProtocolloMW.SG750AfterInsert(DataSet);
end;

procedure TS750FParProtocolloDtM.SG750BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,5),DataSet,True);
end;

end.
