unit A094USkLimitiStrDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, C180FunzioniGenerali,
  RegistrazioneLog, OracleData, Oracle, Variants, DatiBloccati, A094USkLimitiStraordMW;

type
  TA094FSkLimitiStrDtM1 = class(TDataModule)
    T800: TOracleDataSet;
    T800TIPOLIMITE: TStringField;
    T800DATADECORR: TDateTimeField;
    T800NOMECAMPO1: TStringField;
    T800NOMECAMPO2: TStringField;
    QAnno_810: TOracleDataSet;
    QAnno_810CAMPO1: TStringField;
    QAnno_810CAMPO2: TStringField;
    QAnno_811: TOracleDataSet;
    QAnno_811CAMPO1: TStringField;
    QAnno_811CAMPO2: TStringField;
    Q820: TOracleDataSet;
    QAnno_810ANNO: TIntegerField;
    QAnno_811ANNO: TIntegerField;
    Q820PROGRESSIVO: TIntegerField;
    Q820ANNO: TIntegerField;
    Q820MESE: TIntegerField;
    Q820CAUSALE: TStringField;
    Q820Liquidabile: TStringField;
    Q820ORE_TEORICHE: TStringField;
    Q820ORE: TStringField;
    Q820DAL: TIntegerField;
    Q820AL: TIntegerField;
    procedure Q820PickListValidate(Sender: TField);
    procedure A094FSkLimitiStrDtM1Create(Sender: TObject);
    procedure A094FSkLimitiStrDtM1Destroy(Sender: TObject);
    procedure T800PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure BDET800NOMECAMPO1Validate(Sender: TField);
    procedure QAnno_810Apply(DataSet: TDataSet);
    procedure QAnno_811Apply(DataSet: TDataSet);
    procedure ValidateOreMinuti(Sender: TField);
    procedure Q820NewRecord(DataSet: TDataSet);
    procedure Q820AfterPost(DataSet: TDataSet);
    procedure T800BeforeDelete(DataSet: TDataSet);
    procedure T800BeforePost(DataSet: TDataSet);
    procedure T800AfterPost(DataSet: TDataSet);
    procedure QAnno_810ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure QAnno_811ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure Q820BeforeEdit(DataSet: TDataSet);
    procedure QAnno_810AfterScroll(DataSet: TDataSet);
    procedure QAnno_811AfterScroll(DataSet: TDataSet);
    procedure QAnno_810ANNOValidate(Sender: TField);
    procedure QAnno_811ANNOValidate(Sender: TField);
  private
    procedure AggiornaEtichette(Tipo, Rag1, Rag2: String);
    procedure dsrT825StateChange(Sender: TObject);
  public
    A094FSkLimitiStraordMW: TA094FSkLimitiStraordMW;
    function GetProgressivo:Integer;  //richiamata da MW per ottenere progressivo di selAnagrafe
    procedure SettaProgressivo;
end;

var
  A094FSkLimitiStrDtM1: TA094FSkLimitiStrDtM1;

implementation

uses A094USkLimitiStr;

{$R *.DFM}

procedure TA094FSkLimitiStrDtM1.A094FSkLimitiStrDtM1Create(
  Sender: TObject);
{Progressivo dipendente}
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
  A094FSkLimitiStraordMW:=TA094FSkLimitiStraordMW.Create(Self);
  A094FSkLimitiStraordMW.AggiornaEtichetteCampi:=AggiornaEtichette;
  A094FSkLimitiStraordMW.ProgressivoCorrente:=getProgressivo;
  A094FSkLimitiStraordMW.SelT820_Funzioni:=Q820;
  A094FSkLimitiStraordMW.selt810.OnPostError:=PostError;
  A094FSkLimitiStraordMW.selt811.OnPostError:=PostError;
  A094FSkLimitiStraordMW.dsrT825.OnStateChange:=dsrT825StateChange;
  with A094FSkLimitiStr do
  begin
    DBGrid3.DataSource:=A094FSkLimitiStraordMW.dsrT810;
    DBGrid2.DataSource:=A094FSkLimitiStraordMW.dsrT811;
    dbGrid4.DataSource:=A094FSkLimitiStraordMW.dsrT825;
    DBText1.DataSource:=A094FSkLimitiStraordMW.dsrLook1;
    DBText2.DataSource:=A094FSkLimitiStraordMW.dsrLook2;
    DBText3.DataSource:=A094FSkLimitiStraordMW.dsrLook1;
    DBText4.DataSource:=A094FSkLimitiStraordMW.dsrLook2;
    DBLookupComboBox1.ListSource:=A094FSkLimitiStraordMW.dsrLook1;
    DBLookupComboBox2.ListSource:=A094FSkLimitiStraordMW.dsrLook2;
    DBLookupComboBox3.ListSource:=A094FSkLimitiStraordMW.dsrLook1;
    DBLookupComboBox4.ListSource:=A094FSkLimitiStraordMW.dsrLook2;
  end;
  T800.Open;
  QAnno_810.Open;
  QAnno_811.Open;
  with A094FSkLimitiStraordMW.selT275 do
  begin
    A094FSKLimitiStr.DBGrid1.Columns[5].PickList.Add(A000LimiteMensileLiquidabile);
    A094FSKLimitiStr.DBGrid1.Columns[5].PickList.Add(A000LimiteMensileResiduabile);
    Open;
    while not Eof do
    begin
      A094FSKLimitiStr.DBGrid1.Columns[5].PickList.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    Close;
  end;
  SettaProgressivo;
end;

procedure TA094FSkLimitiStrDtM1.SettaProgressivo;
begin
  with A094FSkLimitiStr do
  begin
    Q820.Close;
    Q820.SetVariable('Progressivo',C700Progressivo);
    Q820.Open;
    Q820.SearchRecord('Anno;Mese',VarArrayOf([R180Anno(DataCorrente),R180Mese(DataCorrente)]),[srFromBeginning]);

    A094FSkLimitiStraordMW.selT825.Close;
    A094FSkLimitiStraordMW.selT825.SetVariable('Progressivo',C700Progressivo);
    A094FSkLimitiStraordMW.selT825.Open;

    if A094FSkLimitiStrDtM1 <> nil then
      CaricaElencoMesi;
  end;
end;

procedure TA094FSkLimitiStrDtM1.AggiornaEtichette(Tipo,Rag1,Rag2:String);
begin
  if Tipo = 'L' then
  begin
    A094FSkLimitiStr.LCampo1.Caption:=Rag1;
    A094FSkLimitiStr.LCampo2.Caption:=Rag2;
    if Rag2 = '' then
      A094FSkLimitiStr.DBLookupComboBox2.Visible:=False
    else
      A094FSkLimitiStr.DBLookupComboBox2.Visible:=True;
  end
  else
  begin
    A094FSkLimitiStr.RCampo1.Caption:=Rag1;
    A094FSkLimitiStr.RCampo2.Caption:=Rag2;
    if Rag2 = '' then
      A094FSkLimitiStr.DBLookupComboBox4.Visible:=False
    else
      A094FSkLimitiStr.DBLookupComboBox4.Visible:=True;
  end;
end;

function TA094FSkLimitiStrDtM1.GetProgressivo: Integer;
begin
  Result:=C700Progressivo;
end;

//Tabella T800
procedure TA094FSkLimitiStrDtM1.T800BeforeDelete(DataSet: TDataSet);
begin
  if DataSet = Q820 then
    A094FSkLimitiStraordMW.SelT820BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA094FSkLimitiStrDtM1.BDET800NOMECAMPO1Validate(Sender: TField);
begin
  if (Sender.IsNull) or (Sender.AsString='') then
    Raise Exception.Create('Deve essere inserito il campo');
end;

procedure TA094FSkLimitiStrDtM1.T800BeforePost(DataSet: TDataSet);
begin
  if DataSet = T800 then
  begin
    A094FSkLimitiStraordMW.T800BeforePost(DataSet);
  end;
  if DataSet = Q820 then
  begin
    A094FSkLimitiStraordMW.SelT820BeforePost;
  end;
  if DataSet = QAnno_810 then
    A094FSkLimitiStraordMW.selAnnoBeforePost(DataSet);
  if DataSet = QAnno_811 then
    A094FSkLimitiStraordMW.selAnnoBeforePost(DataSet);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA094FSkLimitiStrDtM1.T800PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('Record già esistente');
  Action:=daAbort;
end;

procedure TA094FSkLimitiStrDtM1.T800AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA094FSkLimitiStrDtM1.PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('Record già esistente');
  Action:=daAbort;
end;

//Tabella Q810
procedure TA094FSkLimitiStrDtM1.ValidateOreMinuti(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

procedure TA094FSkLimitiStrDtM1.QAnno_810AfterScroll(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.RefrAnno(DataSet.FieldByName('ANNO').AsInteger,
                                  DataSet.FieldByName('CAMPO1').AsString,
                                  DataSet.FieldByName('CAMPO2').AsString,
                                  'L');
end;

procedure TA094FSkLimitiStrDtM1.QAnno_810ANNOValidate(Sender: TField);
begin
  A094FSkLimitiStraordMW.CambiaData(Sender.AsString,'L');
end;

procedure TA094FSkLimitiStrDtM1.QAnno_810Apply(DataSet: TDataSet);
var FAnno: Integer;
    FCampo1,FCampo2: String;
begin
  //SessioneOracle.ApplyUpdates([QAnno_810],True);
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  FAnno:=QAnno_810Anno.AsInteger;
  FCampo1:=QAnno_810Campo1.AsString;
  FCampo2:=QAnno_810Campo2.AsString;
  QAnno_810.Refresh;
  QAnno_810.Locate('Anno;Campo1;Campo2',VarArrayOf([FAnno,FCampo1,FCampo2]),[]);
end;

//Tabella QAnno_811
procedure TA094FSkLimitiStrDtM1.QAnno_811AfterScroll(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.RefrAnno(DataSet.FieldByName('ANNO').AsInteger,
                                  DataSet.FieldByName('CAMPO1').AsString,
                                  DataSet.FieldByName('CAMPO2').AsString,
                                  'R');
end;

procedure TA094FSkLimitiStrDtM1.QAnno_811ANNOValidate(Sender: TField);
begin
  A094FSkLimitiStraordMW.CambiaData(Sender.AsString,'R');
end;

procedure TA094FSkLimitiStrDtM1.QAnno_811Apply(DataSet: TDataSet);
var FAnno: Integer;
    FCampo1,FCampo2: String;
begin
  SessioneOracle.ApplyUpdates([QAnno_811],True);
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  FAnno:=QAnno_811Anno.AsInteger;
  FCampo1:=QAnno_811Campo1.AsString;
  FCampo2:=QAnno_811Campo2.AsString;
  QAnno_811.Close;
  QAnno_811.Open;
  QAnno_811.Locate('Anno;Campo1;Campo2',VarArrayOf([FAnno,FCampo1,FCampo2]),[]);
end;

//Tabella Q820
procedure TA094FSkLimitiStrDtM1.Q820NewRecord(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820NewRecord;
end;

procedure TA094FSkLimitiStrDtM1.Q820AfterPost(DataSet: TDataSet);
begin
  //SessioneOracle.ApplyUpdates([Q820],True);
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A094FSkLimitiStr.CaricaElencoMesi;
end;

procedure TA094FSkLimitiStrDtM1.A094FSkLimitiStrDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  FreeAndNil(A094FSkLimitiStraordMW);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA094FSkLimitiStrDtM1.QAnno_810ApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: String);
begin
  Applied:=True;
  A094FSkLimitiStraordMW.SincronizzaT810(QAnno_810, Action);
end;

procedure TA094FSkLimitiStrDtM1.QAnno_811ApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: String);
begin
  Applied:=True;
  A094FSkLimitiStraordMW.SincronizzaT811(QAnno_811,Action);
end;

procedure TA094FSkLimitiStrDtM1.Q820BeforeEdit(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820BeforeEdit;
end;

procedure TA094FSkLimitiStrDtM1.Q820PickListValidate(Sender: TField);
var i,k:Integer;
    Trov:Boolean;
begin
  if Sender.IsNull or (Sender.AsString = '') then
    exit;
  Trov:=False;
  with A094FSkLimitiStr do
  begin
    k:=-1;
    for i:=0 to DbGrid1.Columns.Count - 1 do
      if DbGrid1.Columns[i].FieldName = Sender.FieldName then
      begin
        k:=i;
        Break;
      end;
    if k = -1 then exit;
    for i:=0 to DbGrid1.Columns[k].PickList.Count - 1 do
      if Sender.AsString = DbGrid1.Columns[k].PickList[i] then
      begin
        Trov:=True;
        Break;
      end;
    if not Trov then
      raise Exception.Create('Valore non presente nella lista!');
  end;
end;

procedure TA094FSkLimitiStrDtM1.dsrT825StateChange(Sender: TObject);
begin
  if (A094FSkLimitiStraordMW.selT825.State = dsInsert) then
  begin

    A094FSkLimitiStr.GetSelAnagrafeInterna;
    if (A094FSkLimitiStr.C700SelAnagrafeInterna <> nil) and (A094FSkLimitiStr.C700SelAnagrafeInterna.RecordCount = 0) then
    begin
      R180MessageBox('Inserimento impossibile!' + #13#10 + 'Nessun dipendente selezionato!',INFORMA);
      A094FSkLimitiStraordMW.selT825.Cancel;
      exit;
    end;
  end;
end;

end.
