unit A021UCausGiustifDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  C180FunzioniGenerali, Variants, ControlloVociPaghe,
  A000UMessaggi;

type
  TA021FCausGiustifDtM1 = class(TDataModule)
    D300: TDataSource;
    T305: TOracleDataSet;
    T305Codice: TStringField;
    T305Descrizione: TStringField;
    T305CodRaggr: TStringField;
    T305VocePaghe1: TStringField;
    T305VocePaghe2: TStringField;
    T305VocePaghe3: TStringField;
    T305VocePaghe4: TStringField;
    T305D_CodRaggr: TStringField;
    T305SIGLA: TStringField;
    Q300: TOracleDataSet;
    Q265: TOracleDataSet;
    Q275: TOracleDataSet;
    T305ASSEST_ANNUO: TStringField;
    T305ABBATTE_ECC_GIORN: TStringField;
    T305LIMITE_LIQ: TStringField;
    T305BANCAORE_NEGATIVA: TStringField;
    T305DATA_MIN_ASSEST: TDateTimeField;
    procedure T305BeforePost(DataSet: TDataSet);
    procedure A021FCausGiustifDtM1Create(Sender: TObject);
    procedure BDET305CodiceValidate(Sender: TField);
    procedure A021FCausGiustifDtM1Destroy(Sender: TObject);
    procedure T305BeforeDelete(DataSet: TDataSet);
    procedure T305AfterPost(DataSet: TDataSet);
    procedure T305AfterDelete(DataSet: TDataSet);
    procedure T305DATA_MIN_ASSESTSetText(Sender: TField; const Text: string);
    procedure T305DATA_MIN_ASSESTGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    selControlloVociPaghe:TControlloVociPaghe;
  public
    { Public declarations }
  end;

var
  A021FCausGiustifDtM1: TA021FCausGiustifDtM1;

implementation

{$R *.DFM}

procedure TA021FCausGiustifDtM1.A021FCausGiustifDtM1Create(
  Sender: TObject);
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
  T305.Open;
  Q300.Open;
  Q265.Open;
  Q275.Open;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
end;

procedure TA021FCausGiustifDtM1.T305BeforePost(DataSet: TDataSet);
{Controllo che il codice non sia già usato per altre causali}
var VoceOld:String;
begin
  if QueryPK1.EsisteChiave('T305_CAUGIUSTIF',T305.RowId,T305.State,['CODICE'],[T305Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');  Q265.Close;
  Q265.SetVariable('Codice',T305.FieldByName('Codice').AsString);
  Q265.Open;
  if Q265.RecordCount > 0 then
    Raise Exception.Create(A000MSG_ERR_CODICE_ASS_DUPLICATO);
  Q275.Close;
  Q275.SetVariable('Codice',T305.FieldByName('Codice').AsString);
  Q275.Open;
  if Q275.RecordCount > 0 then
    Raise Exception.Create(A000MSG_ERR_CODICE_PRES_DUPLICATO);
  //Controllo voci paghe
  if (DataSet.State = dsInsert) or (T305.FieldByName('VOCEPAGHE1').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T305.FieldByName('VOCEPAGHE1').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T305.FieldByName('VOCEPAGHE1').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T305.FieldByName('VOCEPAGHE1').AsString);
  if (DataSet.State = dsInsert) or (T305.FieldByName('VOCEPAGHE2').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T305.FieldByName('VOCEPAGHE2').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T305.FieldByName('VOCEPAGHE2').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T305.FieldByName('VOCEPAGHE2').AsString);
  if (DataSet.State = dsInsert) or (T305.FieldByName('VOCEPAGHE3').medpOldValue = null)  then
    VoceOld:=''
  else
    VoceOld:=T305.FieldByName('VOCEPAGHE3').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T305.FieldByName('VOCEPAGHE3').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T305.FieldByName('VOCEPAGHE3').AsString);
  if (DataSet.State = dsInsert) or (T305.FieldByName('VOCEPAGHE4').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T305.FieldByName('VOCEPAGHE4').medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,T305.FieldByName('VOCEPAGHE4').AsString) then
    if R180MessageBox(selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      selControlloVociPaghe.ValutaInserimentoVocePaghe(T305.FieldByName('VOCEPAGHE4').AsString);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA021FCausGiustifDtM1.T305DATA_MIN_ASSESTGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TA021FCausGiustifDtM1.T305DATA_MIN_ASSESTSetText(Sender: TField;
  const Text: string);
begin
  if Text <> '' then
    Sender.AsDateTime:=StrToDate('01/' + Text);
end;

procedure TA021FCausGiustifDtM1.BDET305CodiceValidate(Sender: TField);
begin
  if (T305.State in [dsInsert,dsEdit]) and (Trim(T305Sigla.AsString) = '') then
    T305Sigla.AsString:=Copy(T305Codice.AsString,1,1);
end;

procedure TA021FCausGiustifDtM1.A021FCausGiustifDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  FreeAndNil(selControlloVociPaghe);
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA021FCausGiustifDtM1.T305BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA021FCausGiustifDtM1.T305AfterPost(DataSet: TDataSet);
var S:String;
begin
  RegistraLog.RegistraOperazione;
  with DataSet do
    begin
    S:=FieldByName('CODICE').AsString;
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
    end;
end;

procedure TA021FCausGiustifDtM1.T305AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

end.
