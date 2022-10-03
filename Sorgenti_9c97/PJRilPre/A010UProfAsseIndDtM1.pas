unit A010UProfAsseIndDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, DBCtrls, Forms, Dialogs, StdCtrls,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, RegistrazioneLog, Oracle,
  OracleData, C180FunzioniGenerali, Variants;

type
  TA010FProfAsseIndDtM1 = class(TDataModule)
    D260: TDataSource;
    T263: TOracleDataSet;
    T263Progressivo: TFloatField;
    T263Anno: TFloatField;
    T263CodRaggr: TStringField;
    T263UMisura: TStringField;
    T263Competenza1: TStringField;
    T263Retribuzione1: TFloatField;
    T263Competenza2: TStringField;
    T263Retribuzione2: TFloatField;
    T263Competenza3: TStringField;
    T263Retribuzione3: TFloatField;
    T263Competenza4: TStringField;
    T263Retribuzione4: TFloatField;
    T263Competenza5: TStringField;
    T263Retribuzione5: TFloatField;
    T263Competenza6: TStringField;
    T263Retribuzione6: TFloatField;
    T263Aggiornabile: TStringField;
    T263D_Raggruppamento: TStringField;
    T263DATARES: TDateTimeField;
    T263DECURTAZIONE: TStringField;
    Q260: TOracleDataSet;
    T263RAPPORTI_UNITI: TStringField;
    T263Dal: TDateTimeField;
    T263Al: TDateTimeField;
    selT265: TOracleDataSet;
    T263Note: TStringField;
    procedure L007FProfAsseIndDtM1Create(Sender: TObject);
    procedure T263NewRecord(DataSet: TDataSet);
    procedure BDET263Competenza1Validate(Sender: TField);
    procedure Q260AfterOpen(DataSet: TDataSet);
    procedure A010FProfAsseIndDtM1Destroy(Sender: TObject);
    procedure T263BeforeDelete(DataSet: TDataSet);
    procedure T263BeforePost(DataSet: TDataSet);
    procedure T263AfterDelete(DataSet: TDataSet);
    procedure T263AfterPost(DataSet: TDataSet);
    procedure T263AfterInsert(DataSet: TDataSet);
    procedure Q260FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure T263CodRaggrChange(Sender: TField);
    procedure Q260AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A010FProfAsseIndDtM1: TA010FProfAsseIndDtM1;

implementation

uses A010UProfAsseInd;

{$R *.DFM}

procedure TA010FProfAsseIndDtM1.L007FProfAsseIndDtM1Create(
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
  T263.Open;
  Q260.Open;
end;

procedure TA010FProfAsseIndDtM1.T263NewRecord(DataSet: TDataSet);
{Record nuovo:Unita di misura = Giorni}
begin
  T263.FieldByName('Progressivo').AsInteger:=C700Progressivo;
  T263.FieldByName('UMisura').AsString:='G';
  T263.FieldByName('Aggiornabile').AsString:='N';
end;

procedure TA010FProfAsseIndDtM1.BDET263Competenza1Validate(Sender: TField);
{Controllo sui dati competenze: i giorno possono avere la parte dedcimale .5
 e le ore possono avere i minuti < 60}
begin
  if T263.FieldByName('UMisura').AsString = 'G' then
  begin
    if (Copy(Sender.AsString,6,1) <> '5') and
       (Trim(Copy(Sender.AsString,6,1)) <> '') then
      Raise Exception.Create('E'' ammesso solo .5 come parte decimale dei giorni');
  end
  else
    //if (Copy(Sender.AsString,6,2) > '59') then
    //  Raise Exception.Create('I minuti devono essere minori di 60');
    OreMinutiValidate(Sender.AsString);
end;

procedure TA010FProfAsseIndDtM1.Q260AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA010FProfAsseIndDtM1.Q260AfterScroll(DataSet: TDataSet);
begin
  T263CodRaggrChange(T263.FieldByName('CODRAGGR'));
end;

procedure TA010FProfAsseIndDtM1.A010FProfAsseIndDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA010FProfAsseIndDtM1.T263BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA010FProfAsseIndDtM1.T263BeforePost(DataSet: TDataSet);
var AA,MM,GG:Word;
    Errore:Boolean;
    Msg:String;

  procedure VerificaAnnuale;
  begin
    DecodeDate(T263.FieldByName('DAL').AsDateTime,AA,MM,GG);
    if (MM <> 01) or (GG <> 01) then
      Errore:=True;
    DecodeDate(T263.FieldByName('AL').AsDateTime,AA,MM,GG);
    if (MM <> 12) or (GG <> 31) then
      Errore:=True;
    if Errore then
    begin
      T263.FieldByName('DAL').AsDateTime:=EncodeDate(AA,01,01);
      T263.FieldByName('AL').AsDateTime:=EncodeDate(AA,12,31);
      Raise Exception.Create('Se il raggruppamento è ad anno solare, il periodo deve comprendere un intero anno.');
    end;
  end;

begin
  Errore:=False;
  (*
  if Q260.FieldByName('CONTASOLARE').AsString = 'S' then
    VerificaAnnuale
  else
  begin
    selT265.Open;
    if selT265.Locate('CODICE',Q260.FieldByName('CODICE').AsString,[]) then
      VerificaAnnuale;
    selT265.Close;
  end;
  *)
  //Test intersezione periodi profili assenza
  with TOracleQuery.Create(self) do
  begin
    Errore:=False;
    Session:=SessioneOracle;
    SQL.Add('SELECT T263.CODRAGGR, T263.DAL, T263.AL');
    SQL.Add('FROM T263_PROFASSIND T263');
    SQL.Add('WHERE T263.CODRAGGR = :COD_RAGGR');
    SQL.Add('AND :NEW_DAL <= T263.AL');
    SQL.Add('AND :NEW_AL >= T263.DAL');
    SQL.Add('AND (:IDRIGA IS NULL OR :IDRIGA <> ROWID)');
    SQL.Add('AND T263.PROGRESSIVO = :INPROG');
    SQL.Add('ORDER BY T263.CODRAGGR, T263.DAL, T263.AL');
    DeclareVariable('COD_RAGGR',otString);
    DeclareVariable('NEW_DAL',otDate);
    DeclareVariable('NEW_AL',otDate);
    DeclareVariable('INPROG',otInteger);
    DeclareVariable('IDRIGA',otString);
    SetVariable('COD_RAGGR',T263.FieldByName('CODRAGGR').AsString);
    SetVariable('NEW_DAL',T263.FieldByName('DAL').AsDateTime);
    SetVariable('NEW_AL',T263.FieldByName('AL').AsDateTime);
    if T263.State = dsEdit then
      SetVariable('IDRIGA',T263.RowID)
    else
      SetVariable('IDRIGA',null);
    SetVariable('INPROG',T263.FieldByName('PROGRESSIVO').AsInteger);
    Execute;
    if RowCount > 0 then
    begin
      Errore:=True;
      Msg:='Il periodo indicato (' + T263.FieldByName('DAL').AsString + ' - ' + T263.FieldByName('AL').AsString +
           ') si interseca con il periodo ' + FieldAsString(1) + ' - ' + FieldAsString(2) + '.'
    end;
    Free;
  end;
  if Errore then
    Raise Exception.Create(Msg);

  if QueryPK1.EsisteChiave('T263_PROFASSIND',T263.RowId,T263.State,['PROGRESSIVO','DAL','CODRAGGR'],[T263Progressivo.AsString,T263Dal.AsString,T263CodRaggr.AsString]) then
    raise Exception.Create('Profilo già esistente!');
  T263Competenza1.AsString:=StringReplace(T263Competenza1.AsString,' ','',[rfReplaceAll]);
  T263Competenza2.AsString:=StringReplace(T263Competenza2.AsString,' ','',[rfReplaceAll]);
  T263Competenza3.AsString:=StringReplace(T263Competenza3.AsString,' ','',[rfReplaceAll]);
  T263Competenza4.AsString:=StringReplace(T263Competenza4.AsString,' ','',[rfReplaceAll]);
  T263Competenza5.AsString:=StringReplace(T263Competenza5.AsString,' ','',[rfReplaceAll]);
  T263Competenza6.AsString:=StringReplace(T263Competenza6.AsString,' ','',[rfReplaceAll]);
  T263Decurtazione.AsString:=StringReplace(T263Decurtazione.AsString,' ','',[rfReplaceAll]);
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA010FProfAsseIndDtM1.T263CodRaggrChange(Sender: TField);
var i:Integer;
    ContASolare:Boolean;
begin
  with A010FProfAsseInd do
  begin
    ContASolare:=VarToStr(Q260.Lookup('CODICE',Sender.AsString,'CONTASOLARE')) = 'S';
    drdgRapportiUniti.Enabled:=ContASolare;
    drdgUMisura.Enabled:=ContASolare;
    lblDataRes.Enabled:=ContASolare;
    dedtDataRes.Enabled:=ContASolare;
    lblCompetenze.Enabled:=ContASolare;
    lblPercentuale.Enabled:=ContASolare;
    for i:=1 to 6 do
      TLabel(FindComponent('lblFascia' + IntToStr(i))).Enabled:=ContASolare;
    for i:=2 to 13 do
      TDBEdit(FindComponent('DBEdit' + IntToStr(i))).Enabled:=ContASolare;
    if (T263.State in [dsEdit,dsInsert]) and (not drdgUMisura.Enabled) then
    begin
      T263.FieldByName('UMISURA').AsString:=VarToStr(Q260.Lookup('CODICE',Sender.AsString,'UMISURA'));
      drdgUMisuraClick(nil);
    end;
  end;
end;

procedure TA010FProfAsseIndDtM1.T263AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA010FProfAsseIndDtM1.T263AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA010FProfAsseIndDtM1.T263AfterInsert(DataSet: TDataSet);
begin
  A010FProfAsseInd.drdgUMisuraClick(nil);
end;

procedure TA010FProfAsseIndDtM1.Q260FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('RAGGRUPPAMENTI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
