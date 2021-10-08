unit A096UProfiliLibProfMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, Oracle, DB, StrUtils, R005UDataModuleMW,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA096FProfiliLibProfMW = class(TR005FDataModuleMW)
    selaT311: TOracleDataSet;
    Upd311: TOracleQuery;
    Del311: TOracleQuery;
    Q275: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selT310: TOracleDataSet;
    selT311: TOracleDataSet;
    procedure selT310AfterScroll;
    procedure selT310BeforeDelete;
    procedure selT310BeforePost;
    procedure selT311BeforePost;
    procedure selT311CalcFields;
    procedure selT311NewRecord;
    procedure selT311DALLEValidate(Sender: TField);
    procedure selT311CAUSALEValidate(Sender: TField);
  end;

implementation

{$R *.dfm}

procedure TA096FProfiliLibProfMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Q275.Open;
end;

procedure TA096FProfiliLibProfMW.selT310AfterScroll;
begin
  with selT311 do
  begin
    Close;
    SetVariable('Codice',selT310.FieldByName('Codice').AsString);
    Open;
  end;
end;

procedure TA096FProfiliLibProfMW.selT310BeforeDelete;
begin
  with Del311 do
  begin
    SetVariable('Codice',selT310.FieldByName('Codice').AsString);
    Execute;
  end;
end;

procedure TA096FProfiliLibProfMW.selT310BeforePost;
begin
  if QueryPK1.EsisteChiave('T310_DESCLIBPROF',selT310.RowId,selT310.State,['CODICE'],[selT310.FieldByName('Codice').AsString]) then
    raise Exception.Create(A000MSG_ERR_CODICE_ESISTENTE);
  if selT310.State = dsEdit then
    if selT310.FieldByName('Codice').Value <> selT310.FieldByName('Codice').medpOldValue then
      with Upd311 do
      begin
        SetVariable('Codice',selT310.FieldByName('Codice').Value);
        SetVariable('Codice_Old',selT310.FieldByName('Codice').medpOldValue);
        try
          Execute;
        except
          SessioneOracle.Rollback;
          raise;
        end;
      end;
end;

procedure TA096FProfiliLibProfMW.selT311BeforePost;
begin
  selaT311.Close;
  selaT311.SetVariable('CODICE',selT311.FieldByName('CODICE').AsString);
  if selT311.State in [dsEdit] then
    selaT311.SetVariable('COND_ROWID',' and rowid <> ''' + selT311.RowId + ''' ')
  else
    selaT311.SetVariable('COND_ROWID','');
  selaT311.SetVariable('GIORNO',selT311.FieldByName('GIORNO').AsInteger);
  selaT311.SetVariable('DALLE',selT311.FieldByName('DALLE').AsString);
  selaT311.SetVariable('ALLE',selT311.FieldByName('ALLE').AsString);
  selaT311.SetVariable('ALLE_CONTINUE',IfThen(R180OreMinutiExt(selT311.FieldByName('DALLE').AsString) > R180OreMinutiExt(selT311.FieldByName('ALLE').AsString),R180MinutiOre(R180OreMinutiExt(selT311.FieldByName('ALLE').AsString) + R180OreMinutiExt('24.00')),selT311.FieldByName('ALLE').AsString));
  selaT311.Open;
  if not selaT311.Eof then
    raise exception.Create(Format(A000MSG_A096_ERR_FMT_INTERSEZIONE,[selT311.FieldByName('GIORNO').AsString,
                                                                     selT311.FieldByName('Dalle').AsString,
                                                                     selT311.FieldByName('Alle').AsString,
                                                                     selaT311.FieldByName('GIORNO').AsString,
                                                                     selaT311.FieldByName('Dalle').AsString,
                                                                     selaT311.FieldByName('Alle').AsString]));
end;

procedure TA096FProfiliLibProfMW.selT311CalcFields;
begin
  selT311.FieldByName('D_Giorno').AsString:=R180NomeGiornoSett(selT311.FieldByName('Giorno').AsInteger);
end;

procedure TA096FProfiliLibProfMW.selT311NewRecord;
begin
  selT311.FieldByName('Codice').AsString:=selT310.FieldByName('Codice').AsString;
end;

procedure TA096FProfiliLibProfMW.selT311DALLEValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA096FProfiliLibProfMW.selT311CAUSALEValidate(Sender: TField);
begin
  if Sender.IsNull or (Sender.Text = '') then
    exit;
  if not Q275.Locate('CODICE',Sender.AsString,[]) then
    raise Exception.Create(A000MSG_A096_ERR_CAUSALE_INESISTENTE);
end;

end.
