unit B019USchedulazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Grids, DBGrids, ActnList, ImgList, Db, Menus, ComCtrls,
  ToolWin, C180FunzioniGenerali, C012UVisualizzaTesto, C013UCheckList, Variants, ExtCtrls,
  ToolbarFiglio, StdCtrls, System.Actions;

type
  TB019FSchedulazione = class(TR001FGestTab)
    Splitter1: TSplitter;
    Panel2: TPanel;
    dsrT926: TDataSource;
    frmToolbarFiglio: TfrmToolbarFiglio;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    SaveDialog3: TSaveDialog;
    popmnuStampeSchedulate: TPopupMenu;
    Eseguiora1: TMenuItem;
    GroupBox1: TGroupBox;
    dGrdSchedulazione: TDBGrid;
    GroupBox2: TGroupBox;
    dgrdT926: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdT926EditButtonClick(Sender: TObject);
    procedure frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B019FSchedulazione: TB019FSchedulazione;

implementation

uses B019UGeneratoreStampeDtM, B014UCopiaSchedulazione;

{$R *.DFM}

procedure TB019FSchedulazione.dgrdT926EditButtonClick(Sender: TObject);
var lst:TStringList;
    BottoniC012:TMsgDlgButtons;
begin
  inherited;
  if DButton.State <> dsBrowse then
    exit;
  lst:=TStringList.Create;
  with B019FGeneratoreStampeDtM.selT926 do
  try
    if not (dsrT926.State in [dsEdit,dsInsert]) then
      Edit;
    BottoniC012:=[mbOK,mbCancel];
    if dgrdT926.SelectedField = FieldByName('DAL') then
    begin
      lst.Text:=FieldByName('DAL').AsString;
      OpenC012VisualizzaTesto(FieldByName('DAL').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('DAL').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('AL') then
    begin
      lst.Text:=FieldByName('AL').AsString;
      OpenC012VisualizzaTesto(FieldByName('AL').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('AL').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('NOME_FILE') then
    begin
      lst.Text:=FieldByName('NOME_FILE').AsString;
      OpenC012VisualizzaTesto(FieldByName('NOME_FILE').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('NOME_FILE').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('NOME_LOG') then
    begin
      lst.Text:=FieldByName('NOME_LOG').AsString;
      OpenC012VisualizzaTesto(FieldByName('NOME_LOG').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('NOME_LOG').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('SEMAFORO') then
    begin
      lst.Text:=FieldByName('SEMAFORO').AsString;
      OpenC012VisualizzaTesto(FieldByName('SEMAFORO').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('SEMAFORO').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('INTESTAZIONE_LOG') then
    begin
      lst.Text:=FieldByName('INTESTAZIONE_LOG').AsString;
      OpenC012VisualizzaTesto(FieldByName('INTESTAZIONE_LOG').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('INTESTAZIONE_LOG').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('DETTAGLIO_LOG') then
    begin
      lst.Text:=FieldByName('DETTAGLIO_LOG').AsString;
      OpenC012VisualizzaTesto(FieldByName('DETTAGLIO_LOG').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('DETTAGLIO_LOG').AsString:=Trim(lst.Text);
    end
    else if dgrdT926.SelectedField = FieldByName('CMD_AFTER') then
    begin
      lst.Text:=FieldByName('CMD_AFTER').AsString;
      OpenC012VisualizzaTesto(FieldByName('CMD_AFTER').DisplayLabel,'',lst,'',BottoniC012);
      FieldByName('CMD_AFTER').AsString:=Trim(lst.Text);
    end;
  finally
    lst.Free;
  end;
end;

procedure TB019FSchedulazione.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  B019FGeneratoreStampeDtM.selT910.Close;
end;

procedure TB019FSchedulazione.FormCreate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=B019FGeneratoreStampeDtM.selT925;
  dsrT926.DataSet:=B019FGeneratoreStampeDtM.selT926;
  with B019FGeneratoreStampeDtM.selT910 do
  begin
    Open;
    while not Eof do
    begin
      dgrdT926.Columns[R180GetColonnaDBGrid(dgrdT926,'CODICE_STAMPA')].PickList.Add(FieldByName('CODICE').AsString);
      Next;
    end;
    //Close;
  end;
  with B019FGeneratoreStampeDtM.selT003Nome do
  begin
    Open;
    while not Eof do
    begin
      dgrdT926.Columns[R180GetColonnaDBGrid(dgrdT926,'SELEZIONE')].PickList.Add(FieldByName('NOME').AsString);
      Next;
    end;
    Close;
  end;
  with B019FGeneratoreStampeDtM.selCols do
  begin
    dgrdT926.Columns[R180GetColonnaDBGrid(dgrdT926,'ROTTURA')].PickList.Add('<SALTO_PAGINA>');
    Open;
    while not Eof do
    begin
      dgrdT926.Columns[R180GetColonnaDBGrid(dgrdT926,'ROTTURA')].PickList.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
    end;
    Close;
  end;
end;

procedure TB019FSchedulazione.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=dsrT926;
  frmToolbarFiglio.TFDBGrid:=dgrdT926;
  dsrT926.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=dgrdSchedulazione;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TB019FSchedulazione.frmToolbarFiglioactTFGenerica1Execute(
  Sender: TObject);
begin
  inherited;
  with B019FGeneratoreStampeDtM do
  begin
    Elaborazione(True);
  end;
end;

end.
