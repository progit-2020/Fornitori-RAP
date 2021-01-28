unit L001UTabelle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB, A000UInterfaccia, A000UCostanti, A000USessione,
  RegistrazioneLog, OracleData, Variants, C180FunzioniGenerali;

type

  TInserisciDLL = record
    NomeTabella:String;
    Titolo:string;
    Display:array [0..8] of String;
    Size:array [0..8] of integer;
    FiltroDizAllinea: String;
  end;

  TL001FTabelle = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    Table1: TOracleDataSet;
    procedure Table1EditError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure Table1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure Table1DeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure DBGrid1Exit(Sender: TObject);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Table1AfterDelete(DataSet: TDataSet);
  private
    OldCodice: String;
  public
    NomeTabella: String;
    FiltroDizAllinea: String;
  end;

var
  L001FTabelle: TL001FTabelle;

implementation

{$R *.DFM}

procedure TL001FTabelle.Table1EditError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  R180MessageBox('Record bloccato da altro utente!',ESCLAMA);
  Action:=daAbort;
end;

procedure TL001FTabelle.Table1PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  (*if E is EDBEngineError then
     ShowMessage('Trovata una corrispondenza su altri archivi' + chr(13)+'Impossibile modificare')
  else*)
     R180MessageBox('Il codice indicato è già presente in archivio!',INFORMA);
  Action:=daAbort;
end;

procedure TL001FTabelle.Table1DeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  R180MessageBox('Trovata una corrispondenza su altri archivi' + CRLF + 'Impossibile cancellare',INFORMA);
  Action:=daAbort;
end;

procedure TL001FTabelle.DBGrid1Exit(Sender: TObject);
{Confermo la variazione}
begin
  if Table1.State in [dsInsert,dsEdit] then
    Table1.Post;
end;

procedure TL001FTabelle.Table1BeforePost(DataSet: TDataSet);
begin
  (*case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',DataSet.FieldByName('CODICE').AsString,0,0);
    dsEdit:RegistraLog.SettaProprieta('M',DataSet.FieldByName('CODICE').AsString,0,0);
  end;*)
  if Dataset.State = dsInsert then
    OldCodice:=''
  else
    OldCodice:=DataSet.FieldByName('CODICE').medpOldValue;
end;

procedure TL001FTabelle.Table1BeforeDelete(DataSet: TDataSet);
begin 
  //RegistraLog.SettaProprieta('C',DataSet.FieldByName('CODICE').AsString,0,0);
  OldCodice:=DataSet.FieldByName('CODICE').AsString;
end;

procedure TL001FTabelle.Table1AfterDelete(DataSet: TDataSet);
begin
  if FiltroDizAllinea <> '' then
    A000AggiornaFiltroDizionario(FiltroDizAllinea,OldCodice,'');
end;

procedure TL001FTabelle.Table1AfterPost(DataSet: TDataSet);
var T:String;
begin
  if NomeTabella = 'T480_COMUNI' then
    T:='COMUNI'
  else
    T:=NomeTabella;
  //RegistraLog.RegistraOperazione('L001',T);
  if FiltroDizAllinea <> '' then
    A000AggiornaFiltroDizionario(FiltroDizAllinea,OldCodice,DataSet.FieldByName('CODICE').AsString);
end;

procedure TL001FTabelle.FormCreate(Sender: TObject);
begin
  Table1.Session:=SessioneOracle;
end;

procedure TL001FTabelle.FormDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;
end.
