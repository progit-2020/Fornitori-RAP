unit A056UTurnazIndDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione,A000UInterfaccia, Db, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, A056UTurnazIndMW, A000UMessaggi;

type
  TA056FTurnazIndDtM1 = class(TDataModule)
    D620: TDataSource;
    Q620: TOracleDataSet;
    Q620PROGRESSIVO: TFloatField;
    Q620DATA: TDateTimeField;
    Q620TURNAZIONE: TStringField;
    Q620PARTENZA: TFloatField;
    Q620PIANIF_DA_CALENDARIO: TStringField;
    Q620VERIFICA_TURNI: TStringField;
    Q620VERIFICA_RIPOSI: TStringField;
    procedure A056FTurnazIndDtM1Create(Sender: TObject);
    procedure A056FTurnazIndDtM1Destroy(Sender: TObject);
    procedure Q620BeforeDelete(DataSet: TDataSet);
    procedure Q620AfterDelete(DataSet: TDataSet);
    procedure D620StateChange(Sender: TObject);
    procedure Q620AfterPost(DataSet: TDataSet);
    procedure Q620BeforeInsert(DataSet: TDataSet);
    procedure Q620PIANIF_DA_CALENDARIOValidate(Sender: TField);
  private
    procedure EvtD640DataChange;
    procedure EvtImpostaVarMW;
    procedure EvtSetPartenzaMaxValue;
    procedure EvtInitProgressBar;
    procedure EvtIncProgressBar;
    procedure EvtShowMsg(Msg: String);
  public
    A056MW: TA056FTurnazIndMW;
    procedure AssegnazioneAutomatica;
  end;

var
  A056FTurnazIndDtM1: TA056FTurnazIndDtM1;

implementation

uses A056UTurnazInd;

{$R *.DFM}

procedure TA056FTurnazIndDtM1.A056FTurnazIndDtM1Create(Sender: TObject);
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
  A056MW:=TA056FTurnazIndMW.Create(Self);
  A056MW.EvtD640DataChange:=EvtD640DataChange;
  A056MW.EvtImpostaVarMW:=EvtImpostaVarMW;
  A056MW.EvtSetPartenzaMaxValue:=EvtSetPartenzaMaxValue;
  A056MW.EvtInitProgressBar:=EvtInitProgressBar;
  A056MW.EvtIncProgressBar:=EvtIncProgressBar;
  A056MW.EvtShowMsg:=EvtShowMsg;
  A056MW.Q620:=Q620;
end;

procedure TA056FTurnazIndDtM1.Q620BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA056FTurnazIndDtM1.Q620BeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA056FTurnazIndDtM1.Q620PIANIF_DA_CALENDARIOValidate(Sender: TField);
begin
  A056MW.PianifDaCalendarioValidate;
  if Q620.FieldByName('PIANIF_DA_CALENDARIO').AsString = 'S' then
    A056FTurnazInd.ChkPianif_da_calendario.Checked:=True
  else
    A056FTurnazInd.ChkPianif_da_calendario.Checked:=False;
end;

procedure TA056FTurnazIndDtM1.Q620AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([Q620],True);
  RegistraLog.RegistraOperazione;
end;

procedure TA056FTurnazIndDtM1.Q620AfterPost(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  SessioneOracle.ApplyUpdates([Q620],True);
  RegistraLog.RegistraOperazione;
end;

procedure TA056FTurnazIndDtM1.D620StateChange(Sender: TObject);
begin
  A056FTurnazInd.frmSelAnagrafe.Enabled:=D620.State = dsBrowse;
end;

procedure TA056FTurnazIndDtM1.EvtD640DataChange;
begin
  if A056FTurnazInd.ETurnazione.KeyValue <> Null then
  begin
    A056FTurnazInd.Label6.Caption:=A056MW.Q640.FieldByName('Descrizione').AsString;
    A056MW.CalcolaSviluppo(A056MW.Q640.FieldByName('Codice').AsString);
  end;
end;

procedure TA056FTurnazIndDtM1.EvtImpostaVarMW;
begin
  with A056FTurnazInd do
  begin
    A056MW.ControlloMaxMinItemIndex:=GrpControlloMaxMin.ItemIndex;
    A056MW.ChkPregressoChecked:=chkPregresso.Checked;
    A056MW.ChkPianifDaCalendarioChecked:=ChkPianif_da_calendario.Checked;
    A056MW.ChkGGLavChecked:=chkGGLav.Checked;
    A056MW.ChkRiposiChecked:=chkRiposi.Checked;
    A056MW.Turnazione:=ETurnazione.Text;
    A056MW.PartenzaValue:=EPartenza.Value;
  end;
end;

procedure TA056FTurnazIndDtM1.EvtIncProgressBar;
begin
  with A056FTurnazInd do
    ProgressBar1.Position:=ProgressBar1.Position + 1;
end;

procedure TA056FTurnazIndDtM1.EvtInitProgressBar;
begin
  A056FTurnazInd.ProgressBar1.Position:=0;
  A056FTurnazInd.ProgressBar1.Max:=High(A056MW.VetDipendenti);
end;

procedure TA056FTurnazIndDtM1.EvtSetPartenzaMaxValue;
begin
  with A056FTurnazInd do
  begin
    EPartenza.Value:=0;
    if A056MW.Turno1.Count > 0 then
      EPartenza.MaxValue:=A056MW.Turno1.Count - 1
    else
      EPartenza.MaxValue:=0;
  end;
end;

procedure TA056FTurnazIndDtM1.EvtShowMsg(Msg: String);
begin
 R180MessageBox(Msg,'INFORMA');
end;

procedure TA056FTurnazIndDtM1.A056FTurnazIndDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA056FTurnazIndDtM1.AssegnazioneAutomatica;
begin
  A056MW.AssegnazioneAutomaticaStep1;
  if R180MessageBox(A000MSG_A056_DLG_ASSEGNAZ_AUTOMATICA,'DOMANDA') = mrNo then
    Exit;
  A056MW.AssegnazioneAutomaticaStep2;
end;

end.
