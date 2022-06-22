unit B014UBrowseStruttura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Variants, ComCtrls,
  B014UIntegrazioneAnagraficaDtM;
  
type
  TB014FBrowseStruttura = class(TForm)
    dgrdIADati: TDBGrid;
    Panel2: TPanel;
    Label3: TLabel;
    edtFiltroIADati: TEdit;
    btnRefresh: TBitBtn;
    StatusBar1: TStatusBar;
    btnEseguiStruttura: TBitBtn;
    Label1: TLabel;
    edtScript: TEdit;
    btnEseguiScript: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnEseguiStrutturaClick(Sender: TObject);
    procedure btnEseguiScriptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NomeStruttura,TestoSQL:String;
  end;

var
  B014FBrowseStruttura: TB014FBrowseStruttura;

implementation

uses B014UMonitorIntegrazioneDtM;

{$R *.DFM}

procedure TB014FBrowseStruttura.FormShow(Sender: TObject);
begin
  TestoSQL:=B014FMonitorIntegrazioneDtM.selIADati.SQL.Text;
end;

procedure TB014FBrowseStruttura.btnEseguiScriptClick(Sender: TObject);
begin
  if Trim(edtScript.Text) = '' then
    exit;
  if MessageDlg('Eseguire lo script indicato?',mtConfirmation,[mbNo,mbYes],0) <> mrYes then
    exit;
  if edtScript.Text[Length(edtScript.Text)] <> ';' then
    edtScript.Text:=edtScript.Text + ';';
  with B014FMonitorIntegrazioneDtM.scrGenerico do
  begin
    SQL.Clear;
    SQL.Add('begin');
    SQL.Add(edtScript.Text);
    SQL.Add('end;');
    Execute;
    ShowMessage('Script eseguito correttamente');
  end;
end;

procedure TB014FBrowseStruttura.btnEseguiStrutturaClick(Sender: TObject);
begin
  if MessageDlg('Eseguire la struttura con il filtro indicato?',mtConfirmation,[mbNo,mbYes],0) <> mrYes then
    exit;
  B014FIntegrazioneAnagraficaDtM.ElaborazioneStrutture(NomeStruttura,edtFiltroIADati.Text);
end;

procedure TB014FBrowseStruttura.btnRefreshClick(Sender: TObject);
begin
  with B014FMonitorIntegrazioneDtM.selIADati do
  begin
    SQL.Clear;
    SQL.Add(TestoSQL);
    if Trim(edtFiltroIADati.Text) <> '' then
      SQL.Add('WHERE ' + edtFiltroIADati.Text);
    Close;
    Open;
    StatusBar1.SimpleText:=IntToStr(RecordCount) + ' Record';
  end;
end;

end.
