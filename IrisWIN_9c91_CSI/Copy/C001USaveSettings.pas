unit C001USaveSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, Menus,DB,DBCtrls, Oracle, Variants;

type
  TC001FSaveForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EdtNomeStampa: TEdit;
    EdtDescr: TEdit;
    LblNomeStampa: TLabel;
    LblDescr: TLabel;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AggiungiVoce(NomeStampa,Descr:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Delete1Click(Sender: TObject);
  private
    { Private declarations }
    OpenMode: Integer;
  public
    { Public declarations }
    StampaAttiva : String;
    procedure SetOpenMode (Value : Integer);
  end;

var
  C001FSaveForm: TC001FSaveForm;

implementation

uses C001StampaLib,C001USettings,C001UFiltroTabelle,C001UFiltroTabelleDtM,A000UCostanti, A000USessione;

{$R *.DFM}

procedure TC001FSaveForm.FormCreate(Sender: TObject);
begin
  with C001FFiltroTabelleDtM do
  begin
    Q900.Close;
    Q900.SetVariable('CODICEINTERNO',CODINT);
    Q900.Open;
  end;
end;

procedure TC001FSaveForm.FormActivate(Sender: TObject);
begin
  if OpenMode = 0 then
    begin
      LblNomeStampa.Visible := True;
      EdtNomeStampa.Visible := True;
      LblDescr.Visible := True;
      EdtDescr.Visible := True;
      C001FSaveForm.Caption := 'Salva impostazioni di stampa';
      DBGrid1.DataSource.DataSet.Locate('NOMESTAMPA',ConfigAttiva,[]);
    end
  else
    begin
      LblNomeStampa.Visible := False;
      EdtNomeStampa.Visible := False;
      LblDescr.Visible := False;
      EdtDescr.Visible := False;
      C001FSaveForm.Caption := 'Leggi impostazioni di stampa'
    end;
end;

procedure TC001FSaveForm.SetOpenMode (Value : Integer);
begin
  OpenMode:=Value;    // Modalità di apertura della Form : 1 per scegliere un file
                      //                                   0 per salvare un file
end;

procedure TC001FSaveForm.BitBtn1Click(Sender: TObject);
begin
  with C001FFiltroTabelleDTM do
    if OpenMode = 0 then
      AggiungiVoce(EdtNomeStampa.Text,EdtDescr.Text)
    else if OpenMode = 1 then
      if Q900.FieldbyName('NOMESTAMPA').AsString <> '' then
      begin
        StampaAttiva:=Q900.FieldByName('NOMESTAMPA').AsString;
        ListaSettaggi.Clear;
        selT901.Close;
        selT901.SetVariable('CODICEINTERNO',CODINT);
        selT901.SetVariable('NOMESTAMPA',StampaAttiva);
        selT901.Open;
        while not selT901.Eof do
        begin
          ListaSettaggi.Add(selT901.FieldByName('RIGA').AsString);
          selT901.Next;
        end;
        selT901.Close;
      end;
end;

procedure TC001FSaveForm.AggiungiVoce(NomeStampa,Descr:String);
var i:Integer;
begin
  with C001FFiltroTabelleDTM do
  begin
    Q900.Filter:=Format('NOMESTAMPA = ''%s''',[NomeStampa]);
    Q900.Filtered:=True;
    if Q900.RecordCount > 0 then
    begin
      if MessageDlg('E'' già stata salvata una stampa con il nome: '+ NomeStampa+#13+
                    'Sovrascrivere le impostazioni',mtWarning,[mbYes,mbNo],0)=mrYes then
      begin
        Q900.Edit;
        Q900.FieldByName('DESCRIZIONE').AsString:=Descr;
        Q900.Post;
        selT901.Close;
        selT901.SetVariable('CODICEINTERNO',CODINT);
        selT901.SetVariable('NOMESTAMPA',NomeStampa);
        selT901.Open;
        while not selT901.Eof do
          selT901.Delete;
        for i:=0 to Listasettaggi.Count - 1 do
        begin
          selT901.Append;
          selT901.FieldByName('CODICEINTERNO').AsString:=CODINT;
          selT901.FieldByName('NOMESTAMPA').AsString:=Nomestampa;
          selT901.FieldByName('NUMRIGA').AsInteger:=i;
          selT901.FieldByName('RIGA').AsString:=ListaSettaggi[i];
          selT901.Post;
        end;
        selT901.Close;
        Q900.Session.Commit;
      end;
    end
    else
    begin
      Q900.Insert;
      Q900.FieldByName('CODICEINTERNO').AsString:=CODINT;
      Q900.FieldByName('NOMESTAMPA').AsString:=NomeStampa;
      Q900.FieldByName('DESCRIZIONE').AsString:=Descr;
      Q900.Post;
      selT901.Close;
      selT901.SetVariable('CODICEINTERNO',CODINT);
      selT901.SetVariable('NOMESTAMPA',NomeStampa);
      selT901.Open;
      while not selT901.Eof do
        selT901.Delete;
      for i:=0 to Listasettaggi.Count - 1 do
      begin
        selT901.Append;
        selT901.FieldByName('CODICEINTERNO').AsString:=CODINT;
        selT901.FieldByName('NOMESTAMPA').AsString:=Nomestampa;
        selT901.FieldByName('NUMRIGA').AsInteger:=i;
        selT901.FieldByName('RIGA').AsString:=ListaSettaggi[i];
        selT901.Post;
      end;
      selT901.Close;
      Q900.Session.Commit;
    end;
    Q900.Filtered:=False;
  end;
end;

procedure TC001FSaveForm.Delete1Click(Sender: TObject);
begin
  with C001FFiltroTabelleDtM do
  begin
    Q900.Delete;
    Q900.Session.Commit;
    Q900.Refresh;
  end;
end;

procedure TC001FSaveForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TC001FSaveForm.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn1Click(nil);
  if Trim(edtNomeStampa.Text) <> '' then
    ModalResult:=mrOK;
end;

end.
