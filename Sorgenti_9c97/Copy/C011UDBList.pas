unit C011UDBList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBCtrls, StdCtrls, Buttons, ExtCtrls, Variants;

type
  TC011FDBList = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupListBox1: TDBLookupListBox;
    DataSource1: TDataSource;
    procedure DBLookupListBox1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Chiave:String;
  end;

var
  C011FDBList: TC011FDBList;

implementation

{$R *.DFM}

procedure TC011FDBList.FormCreate(Sender: TObject);
begin
  Chiave:='';
end;

procedure TC011FDBList.FormActivate(Sender: TObject);
begin
  DataSource1.DataSet.FieldByName(DbLookUpListBox1.KeyField).DisplayWidth:=8;
  DataSource1.DataSet.Locate(DbLookUpListBox1.KeyField,Chiave,[loPartialKey]);
end;

procedure TC011FDBList.DBLookupListBox1DblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.
