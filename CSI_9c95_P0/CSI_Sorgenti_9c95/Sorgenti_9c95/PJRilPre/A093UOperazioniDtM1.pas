unit A093UOperazioniDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000UCostanti, A000USessione,A000UInterfaccia,   OracleData, Oracle,
  RegistrazioneLog, C700USelezioneAnagrafe, Variants,
  L021call;

type
  TA093FOperazioniDtM1 = class(TDataModule)
    Q000_Tabelle: TOracleDataSet;
    Q000_TabelleTABELLA: TStringField;
    Q000: TOracleDataSet;
    Q000_Operatori: TOracleDataSet;
    Q000_OperatoriOPERATORE: TStringField;
    D000: TDataSource;
    Q001: TOracleDataSet;
    D001: TDataSource;
    Q001COLONNA: TStringField;
    Q001VALORE_OLD: TStringField;
    Q001VALORE_NEW: TStringField;
    selCols: TOracleDataSet;
    delI000: TOracleQuery;
    procedure A093FOperazioniDtM1Create(Sender: TObject);
    procedure A093FOperazioniDtM1Destroy(Sender: TObject);
    procedure Q000FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Q000AfterScroll(DataSet: TDataSet);
    procedure Q000AfterOpen(DataSet: TDataSet);
    procedure Q000CalcFields(DataSet: TDataSet);
    procedure QAnagraAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
end;

var
  A093FOperazioniDtM1: TA093FOperazioniDtM1;

implementation

uses A093UOperazioni;

{$R *.DFM}

procedure TA093FOperazioniDtM1.A093FOperazioniDtM1Create(Sender: TObject);
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
  Q000_Operatori.Open;
  Q000_Tabelle.Open;
  Q000.Open;
  selCols.Open;
  while not selCols.Eof do
    begin
    A093FOperazioni.cmbColonna.Items.Add(selCols.FieldByName('COLONNA').AsString);
    selCols.Next;
    end;
  selCols.Close;
end;

procedure TA093FOperazioniDtM1.A093FOperazioniDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA093FOperazioniDtM1.Q000FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=False;
  if StrToIntDef(Q000.FieldByName('Valore_Old').AsString,0) > 0 then
    if C700SelAnagrafe.SearchRecord('Progressivo',Q000.FieldByName('Valore_Old').AsInteger,[srFromBeginning]) then
      Accept:=True;
  if not Accept then
    if StrToIntDef(Q000.FieldByName('Valore_New').AsString,0) > 0 then
      if C700SelAnagrafe.SearchRecord('Progressivo',Q000.FieldByName('Valore_New').AsInteger,[srFromBeginning]) then
        Accept:=True
end;

procedure TA093FOperazioniDtM1.Q000AfterScroll(DataSet: TDataSet);
begin
  with Q001 do
  begin
    Close;
    SetVariable('ID',Q000.FieldByName('ID').AsInteger);
    Open;
  end;
end;

procedure TA093FOperazioniDtM1.Q000AfterOpen(DataSet: TDataSet);
begin
  Q000.FieldByName('ID').DisplayWidth:=8;
  Q000.FieldByName('OPERATORE').DisplayWidth:=15;
  Q000.FieldByName('OPERATORE').DisplayLabel:='Operatore';
  Q000.FieldByName('TABELLA').DisplayWidth:=15;
  Q000.FieldByName('TABELLA').DisplayLabel:='Tabella';
  Q000.FieldByName('OPERAZIONE').DisplayWidth:=3;
  Q000.FieldByName('OPERAZIONE').DisplayLabel:='Op.';
  Q000.FieldByName('DATA').DisplayWidth:=12;
  Q000.FieldByName('DATA').DisplayLabel:='Data';
  TDateTimeField(Q000.FieldByName('DATA')).DisplayFormat:='dd/mm/yyyy hhhh.nn';
  try
    Q000.FieldByName('ID_1').Visible:=False;
    Q000.FieldByName('COLONNA').DisplayWidth:=15;
    Q000.FieldByName('COLONNA').DisplayLabel:='Colonna';
    Q000.FieldByName('VALORE_OLD').DisplayWidth:=10;
    Q000.FieldByName('VALORE_OLD').DisplayLabel:='Valore_Old';
    Q000.FieldByName('VALORE_NEW').DisplayWidth:=10;
    Q000.FieldByName('VALORE_NEW').DisplayLabel:='Valore_New';
  except
  end;
end;

procedure TA093FOperazioniDtM1.Q000CalcFields(DataSet: TDataSet);
var i:Integer;
begin
  for i:=1 to High(FunzioniDisponibili) do
    //Caratto: 11/04/2013. Unificazione L021. Considero le maschere win e web (FunzioniDisponibili.S ,FunzioniDisponibili.SW)
    if L021VerificaMaschera(Q000.FieldByName('Maschera').AsString,i) and L021VerificaApplicazione(Parametri.Applicazione,i) then
    begin
      Q000.FieldByName('Funzione').AsString:=FunzioniDisponibili[i].G + ':' + FunzioniDisponibili[i].N;
      Break;
    end;
end;

procedure TA093FOperazioniDtM1.QAnagraAfterScroll(DataSet: TDataSet);
begin
  Q000.Close;
  Q001.Close;
  Q000.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('Progressivo').AsInteger);
  Q000.Open;
end;

end.
