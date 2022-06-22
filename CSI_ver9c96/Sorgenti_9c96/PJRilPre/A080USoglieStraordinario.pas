unit A080USoglieStraordinario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  OracleData, C013UCheckList,
  A000UInterfaccia, C180FunzioniGenerali, C600USelAnagrafe;

type
  TA080FSoglieStraordinario = class(TR004FGestStorico)
    dgrdT028: TDBGrid;
    Panel1: TPanel;
    dsrT028: TDataSource;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    dgrdT027: TDBGrid;
    Splitter1: TSplitter;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnCausaliGGLavClick(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dgrdT027EditButtonClick(Sender: TObject);
  private
    { Private declarations }
    FTipoCartellino:String;
    procedure PutTipoCartellino(Valore:String);
  public
    { Public declarations }
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

var
  A080FSoglieStraordinario: TA080FSoglieStraordinario;

implementation

{$R *.dfm}

uses A080USoglieStraordinarioDtM;

procedure TA080FSoglieStraordinario.FormCreate(Sender: TObject);
begin
  inherited;
  FTipoCartellino:='';
  A080FSoglieStraordinarioDtM:=TA080FSoglieStraordinarioDtM.Create(Self);
end;

procedure TA080FSoglieStraordinario.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A080FSoglieStraordinarioDtM.selT027;
  dsrT028.DataSet:=A080FSoglieStraordinarioDtM.selT028;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure TA080FSoglieStraordinario.PutTipoCartellino(Valore:String);
begin
  FTipoCartellino:=Valore;
  A080FSoglieStraordinarioDtM.TipoCartellino:=Valore;
end;

procedure TA080FSoglieStraordinario.btnCausaliGGLavClick(Sender: TObject);
begin
  inherited;
  with TC013FCheckList.Create(nil) do
  try
    clbListaDati.Items.Text:=R180GetStringList(A080FSoglieStraordinarioDtM.selT275,'CODICE,DESCRIZIONE');
    clbListaDati.Items.Insert(0,'<*L>  Eccedenza liquidabile');
    R180PutCheckList(A080FSoglieStraordinarioDtM.selT027.FieldByName('CAUSALI_GGLAV').AsString,5,clbListaDati);
    if (ShowModal = mrOK) and (DButton.State in [dsInsert,dsEdit]) then
      A080FSoglieStraordinarioDtM.selT027.FieldByName('CAUSALI_GGLAV').AsString:=R180GetCheckList(5,clbListaDati);
  finally
    Free;
  end;
end;

procedure TA080FSoglieStraordinario.C600frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
var S:String;
begin
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text:=A080FSoglieStraordinarioDtM.selT027.FieldByName('SELEZIONE_ANAGRAFE').AsString;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    S:=StringReplace(S,#13#10,' ',[rfReplaceAll]);
    A080FSoglieStraordinarioDtM.selT027.FieldByName('SELEZIONE_ANAGRAFE').AsString:=S;
  end;
end;

procedure TA080FSoglieStraordinario.dgrdT027EditButtonClick(Sender: TObject);
begin
  inherited;
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  if dgrdT027.SelectedField.FieldName = 'SELEZIONE_ANAGRAFE' then
    C600frmSelAnagrafebtnSelezioneClick(C600frmSelAnagrafe.btnSelezione)
  else if R180In(dgrdT027.SelectedField.FieldName,['CAUSALI_GGLAV','CAUSALI_GGNONLAV']) then
  begin
    with TC013FCheckList.Create(nil) do
    try
      clbListaDati.Items.Text:=R180GetStringList(A080FSoglieStraordinarioDtM.selT275,'CODICE,DESCRIZIONE');
      if dgrdT027.SelectedField.FieldName = 'CAUSALI_GGLAV' then
        clbListaDati.Items.Insert(0,'<*L>  Eccedenza liquidabile');
      R180PutCheckList(A080FSoglieStraordinarioDtM.selT027.FieldByName(dgrdT027.SelectedField.FieldName).AsString,5,clbListaDati);
      if (ShowModal = mrOK) and (DButton.State in [dsInsert,dsEdit]) then
        A080FSoglieStraordinarioDtM.selT027.FieldByName(dgrdT027.SelectedField.FieldName).AsString:=R180GetCheckList(5,clbListaDati);
    finally
      Free;
    end;
  end;
end;

procedure TA080FSoglieStraordinario.DButtonStateChange(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsInsert,dsEdit];
  if dsrT028.DataSet <> nil then
    TOracleDataSet(dsrT028.DataSet).ReadOnly:=not(DButton.State in [dsEdit]);
end;

procedure TA080FSoglieStraordinario.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A080FSoglieStraordinarioDtM);
end;

end.
