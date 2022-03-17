unit L001UCampiAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, A000UInterfaccia,
  RegistrazioneLog, OracleData, Oracle, Variants, A188UCampiAnagrafeMW;

type
  TL001FCampiAnagrafe = class(TForm)
    D010: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    I010: TOracleDataSet;
    I010NOME_CAMPO: TStringField;
    I010NOME_LOGICO: TStringField;
    I010POSIZIONE: TFloatField;
    I010VAL_DEFAULT: TStringField;
    Button1: TButton;
    I010RICERCA: TIntegerField;
    I010APPLICAZIONE: TStringField;
    I010PROVVEDIMENTO: TStringField;
    procedure I010BeforeInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure I010AfterOpen(DataSet: TDataSet);
    procedure I010PostError(DataSet: TDataSet; E: EDatabaseError;var Action: TDataAction);
    procedure I010AfterPost(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormDestroy(Sender: TObject);
  private
    ModificaUtente:Boolean;
    A188MW:TA188FCampiAnagrafeMW;
  public
    DefAnagrafe:TFieldDefs;
  end;

var
  L001FCampiAnagrafe: TL001FCampiAnagrafe;

implementation

{$R *.DFM}

procedure TL001FCampiAnagrafe.DBGrid1TitleClick(Column: TColumn);
begin
  I010.DisableControls;
  I010.SetVariable('ORDINAMENTO',Column.FieldName + ', nvl(RICERCA,99999999), nvl(POSIZIONE,99999999), NOME_LOGICO');
  I010.Close;
  I010.Open;
  I010.EnableControls;
end;

procedure TL001FCampiAnagrafe.FormCreate(Sender: TObject);
begin
  I010.Session:=SessioneOracle;
  A188MW:=TA188FCampiAnagrafeMW.Create(nil);
  A188MW.selCols.Session:=SessioneOracle;
  A188MW.I010:=I010;
end;

procedure TL001FCampiAnagrafe.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A188MW);
end;

procedure TL001FCampiAnagrafe.I010AfterOpen(DataSet: TDataSet);
begin
  A188MW.DefAnagrafe:=DefAnagrafe;
  A188MW.I010AfterOpen;
end;

procedure TL001FCampiAnagrafe.I010BeforeInsert(DataSet: TDataSet);
begin
  A188MW.I010BeforeInsert;
end;

procedure TL001FCampiAnagrafe.I010PostError(DataSet: TDataSet;E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('Nome gia'' usato per altro dato');
  Action:=daAbort;
end;

procedure TL001FCampiAnagrafe.I010AfterPost(DataSet: TDataSet);
begin
  if ModificaUtente then
  begin
    RegistraLog.SettaProprieta('M','I010_CAMPIANAGARFICI',Copy(Name,1,4),I010,True);
    RegistraLog.RegistraOperazione;
    RegistraLog.Session.Commit;
  end;
  A188MW.I010AfterPost;
end;

procedure TL001FCampiAnagrafe.Button1Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    A188MW.AssegnaValoriDefault;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

end.
