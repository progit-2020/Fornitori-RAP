unit A024ULimitiIndDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData, C180FunzioniGenerali, A000UInterfaccia,
  Oracle;

type
  TA024FLimitiIndDtm = class(TR004FGestStoricoDtM)
    selT165: TOracleDataSet;
    selT166: TOracleDataSet;
    selT165CODICE: TStringField;
    selT165ID: TFloatField;
    selT165DECORRENZA: TDateTimeField;
    selT165DECORRENZA_FINE: TDateTimeField;
    selT166TURNI: TIntegerField;
    selT166GGLAV: TIntegerField;
    selT166TIPO_PT: TStringField;
    selT166PERC_PT: TFloatField;
    selT166ORE_MAX: TStringField;
    selT166ID: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT166NewRecord(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT165AfterCancel(DataSet: TDataSet);
    procedure selT165AfterScroll(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
    FLimitiInd:String;
    procedure OpenSelT166;
    procedure PutLimitiInd(Valore:String);
  public
    { Public declarations }
    property LimitiInd:String read FLimitiInd write PutLimitiInd;
  end;

var
  A024FLimitiIndDtm: TA024FLimitiIndDtm;

implementation

{$R *.dfm}

uses A024ULimitiInd;

procedure TA024FLimitiIndDtm.PutLimitiInd(Valore:String);
begin
  FLimitiInd:=Valore;
  R180SetVariable(selT165,'CODICE',Valore);
  selT165.Open;
  OpenSelT166;
end;

procedure TA024FLimitiIndDtm.OpenSelT166;
begin
  R180SetVariable(selT166,'ID',selT165.FieldByName('ID').AsInteger);
  selT166.Open;
end;

procedure TA024FLimitiIndDtm.AfterPost(DataSet: TDataSet);
begin
  if selT166.Active and selT166.UpdatesPending then
  begin
    SessioneOracle.ApplyUpdates([selT166], False);
    selT166.Refresh;
  end;
  inherited;
end;

procedure TA024FLimitiIndDtm.selT165AfterCancel(DataSet: TDataSet);
begin
  inherited;
  if selT166.UpdatesPending then
    selT166.CancelUpdates;
end;

procedure TA024FLimitiIndDtm.selT165AfterScroll(DataSet: TDataSet);
begin
  inherited;
  OpenSelT166;
  selT166.ReadOnly:=True;
end;

procedure TA024FLimitiIndDtm.BeforePost(DataSet: TDataSet);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso then
  begin
    with TOracleQuery.Create(Self) do
      try
        Session:=SessioneOracle;
        SQL.Add('select T165_ID.nextval as ID from dual');
        Execute;
        selT165.FieldByName('ID').AsInteger:=FieldAsInteger('ID');
      finally
        Free;
      end;
  end;
  if selT166.State in [dsInsert,dsEdit] then
    selT166.Post;
end;

procedure TA024FLimitiIndDtm.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selT165.FieldByName('CODICE').AsString:=FLimitiInd;
end;

procedure TA024FLimitiIndDtm.selT166NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT166.FieldByName('ID').AsFloat:=selT165.FieldByName('ID').AsFloat;
end;

procedure TA024FLimitiIndDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //Inizializzazione campo sequence(ID) su tabella T165
  with selT165.SequenceField do
  begin
    Field:='ID';
    Sequence:='T165_ID';
    ApplyMoment:=amOnNewRecord;
  end;
  InterfacciaR004:=TA024FLimitiInd(Owner).InterfacciaR004;
  InizializzaDataSet(selT165,[evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
end;

end.
