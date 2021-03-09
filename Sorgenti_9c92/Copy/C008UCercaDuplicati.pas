unit C008UCercaDuplicati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CheckLst, Oracle, OracleData, Menus, Db, C180FunzioniGenerali,
  Grids, DBGrids, Variants;

type
  TC008FCercaDuplicati = class(TForm)
    lstColonne: TCheckListBox;
    Splitter1: TSplitter;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    selDuplicati: TOracleDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    Accedia1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Accedia1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Row_ID,Codice:String;
    Standard:Boolean;
    ODS:TOracleDataSet;
  end;

var
  C008FCercaDuplicati: TC008FCercaDuplicati;

implementation

{$R *.DFM}

procedure TC008FCercaDuplicati.FormCreate(Sender: TObject);
begin
  Standard:=True;
end;

procedure TC008FCercaDuplicati.FormShow(Sender: TObject);
var i:Integer;
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=ODS.Session;
    SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYYHH24MI"');
    Execute;
  finally
    Free;
  end;
  if Standard then
  begin
    lstColonne.Items.Clear;
    with TStringList.Create do
    try
      CommaText:=Codice;
      for i:=0 to ODS.FieldCount -1 do
        if (ODS.Fields[i].FieldKind = fkData) and (IndexOf(ODS.Fields[i].FieldName) = -1) then
        begin
          lstColonne.Items.Add(ODS.Fields[i].FieldName);
          lstColonne.Checked[lstColonne.Items.Count - 1]:=True;
        end;
    finally
      Free;
    end;
  end
  else
    for i:=0 to lstColonne.Items.Count -1 do
      lstColonne.Checked[i]:=True;
end;

procedure TC008FCercaDuplicati.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstColonne.Items.Count - 1 do
    lstColonne.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TC008FCercaDuplicati.BitBtn1Click(Sender: TObject);
var i:Integer;
    S:String;
begin
  S:='';
  for i:=0 to lstColonne.Items.Count - 1 do
    if lstColonne.Checked[i] then
    begin
      if S <> '' then S:=S + '||';
      S:=S + lstColonne.Items[i]
    end;
  with selDuplicati do
  begin
    if Standard then
    begin
      SQL.Clear;
      Row_ID:=ODS.RowId;
      SQL.Add('SELECT :CODICE,ROWID FROM ' + R180EstraiNomeTabella(ODS.SQL.Text));
      SQL.Add('WHERE ROWID <> :ROW_ID');
      SQL.Add('AND :CAMPI =');
      SQL.Add('(SELECT :CAMPI FROM ' + R180EstraiNomeTabella(ODS.SQL.Text) + ' WHERE ROWID = :ROW_ID)');
    end;
    DeclareVariable('CODICE',otSubst);
    DeclareVariable('CAMPI',otSubst);
    DeclareVariable('ROW_ID',otString);
    SetVariable('CODICE',Codice);
    SetVariable('CAMPI',S);
    SetVariable('ROW_ID',Row_ID);
    Session:=ODS.Session;
    Close;
    Open;
  end;
end;

procedure TC008FCercaDuplicati.Accedia1Click(Sender: TObject);
begin
  if not selDuplicati.Active then exit;
  (*Chiave:=VarArrayCreate([0,selDuplicati.FieldCount - 1],VarVariant);
  for i:=0 to selDuplicati.FieldCount - 1 do
    Chiave[i]:=selDuplicati.Fields[i].AsString;*)
  ODS.SearchRecord('ROWID',selDuplicati.RowID,[srFromBeginning]);
end;

procedure TC008FCercaDuplicati.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=ODS.Session;
    SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    Execute;
  finally
    Free;
  end;
end;

end.
