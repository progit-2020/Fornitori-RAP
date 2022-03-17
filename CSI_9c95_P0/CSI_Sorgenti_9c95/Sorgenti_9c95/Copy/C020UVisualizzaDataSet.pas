unit C020UVisualizzaDataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Data.DB, Vcl.Menus, System.Actions,
  Vcl.ActnList, C180FunzioniGenerali, OracleData;

type
  TC020FVisualizzaDataSet = class(TForm)
    pnlBotttom: TPanel;
    btnChiudi: TBitBtn;
    dGrdVisualizzazione: TDBGrid;
    dsrGenerico: TDataSource;
    ppMnu: TPopupMenu;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    actRicercaTestoContenuto1: TMenuItem;
    actSuccessivo1: TMenuItem;
    N1: TMenuItem;
    actSelezionaTutto: TAction;
    actDeselezionaTutto: TAction;
    actInvertiSelezione: TAction;
    actCopia: TAction;
    actCopiaInExcel: TAction;
    Deselezionatatutto1: TMenuItem;
    Deselezionatatutto2: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel1: TMenuItem;
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure actSelezionaTuttoExecute(Sender: TObject);
    procedure actDeselezionaTuttoExecute(Sender: TObject);
    procedure actInvertiSelezioneExecute(Sender: TObject);
    procedure actCopiaExecute(Sender: TObject);
    procedure actCopiaInExcelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dGrdVisualizzazioneTitleClick(Column: TColumn);
  private
    { Private declarations }
    TestoContenuto, UltimaColonna:string;
  public
    { Public declarations }
  end;

var
  C020FVisualizzaDataSet: TC020FVisualizzaDataSet;


procedure OpenC020VisualizzaDataSet(inCaption:string; inDts:TDataSet; inW:integer; inH:integer); overload;

implementation

{$R *.dfm}

procedure OpenC020VisualizzaDataSet(inCaption:string; inDts:TDataSet; inW:integer; inH:integer);
begin
  C020FVisualizzaDataSet:=TC020FVisualizzaDataSet.Create(nil);
  try
    C020FVisualizzaDataSet.Height:=inH;
    C020FVisualizzaDataSet.Width:=inW;
    C020FVisualizzaDataSet.Caption:=inCaption;
    C020FVisualizzaDataSet.dsrGenerico.DataSet:=inDts;
    C020FVisualizzaDataSet.ShowModal;
  finally
    FreeAndNil(C020FVisualizzaDataSet);
  end;
end;

procedure TC020FVisualizzaDataSet.actCopiaExecute(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dGrdVisualizzazione,Sender = actCopiaInExcel);
end;

procedure TC020FVisualizzaDataSet.actCopiaInExcelExecute(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dGrdVisualizzazione,Sender = actCopiaInExcel);
end;

procedure TC020FVisualizzaDataSet.actDeselezionaTuttoExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'N');
end;

procedure TC020FVisualizzaDataSet.actInvertiSelezioneExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'C');
end;

procedure TC020FVisualizzaDataSet.actRicercaTestoContenutoExecute(Sender: TObject);
var
  Trovato:integer;
begin
  if (Sender = actRicercaTestoContenuto) or (TestoContenuto = '') then
  begin
    TestoContenuto:=UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString);
    if InputQuery('Ricerca per testo contenuto',dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName,TestoContenuto) then
    begin
      Trovato:=0;
      dsrGenerico.DataSet.DisableControls;
      while (not dsrGenerico.DataSet.Eof) and (Trovato = 0) do
      begin
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString));
        if Trovato = 0 then
          dsrGenerico.DataSet.Next;
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
          dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName +'"');
        dsrGenerico.DataSet.First;
      end;
      dsrGenerico.DataSet.EnableControls;
    end;
  end
  else
  begin
    Trovato:=0;
    dsrGenerico.DataSet.DisableControls;
    while (not dsrGenerico.DataSet.Eof) and (Trovato = 0) do
    begin
      if Trovato = 0 then
        dsrGenerico.DataSet.Next;
      Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(dsrGenerico.DataSet.FieldByName(dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName).AsString));
    end;
    if Trovato = 0 then
    begin
      ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dGrdVisualizzazione.Columns[dGrdVisualizzazione.SelectedIndex].FieldName +'"');
      dsrGenerico.DataSet.First;
    end;
    dsrGenerico.DataSet.EnableControls;
  end;
end;

procedure TC020FVisualizzaDataSet.actSelezionaTuttoExecute(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dGrdVisualizzazione,'S');
end;

procedure TC020FVisualizzaDataSet.btnChiudiClick(Sender: TObject);
begin
  Close;
end;

procedure TC020FVisualizzaDataSet.dGrdVisualizzazioneTitleClick(Column: TColumn);
var
  i:integer;
begin
  with dGrdVisualizzazione.DataSource do
    if DataSet is TClientDataSet then
    begin
      for i:=0 to dGrdVisualizzazione.Columns.Count - 1 do
        dGrdVisualizzazione.Columns[i].Title.Font.Color:=clBlue;
      Column.Title.Font.Color:=clRed;
      (DataSet as TClientDataSet).IndexDefs.Clear;
      if UltimaColonna = Column.Field.FieldName then
      begin
        (DataSet as TClientDataSet).IndexDefs.Add('INDD' + Column.Index.ToString,Column.Field.FieldName,[ixDescending]);
        (DataSet as TClientDataSet).IndexName:='INDD' + Column.Index.ToString;
        UltimaColonna:='';
      end
      else
      begin
        (DataSet as TClientDataSet).IndexDefs.Add('INDC' + Column.Index.ToString,Column.Field.FieldName,[]);
        (DataSet as TClientDataSet).IndexName:='INDC' + Column.Index.ToString;
        UltimaColonna:=Column.Field.FieldName;
      end;
    end;
end;

procedure TC020FVisualizzaDataSet.FormShow(Sender: TObject);
begin
  dGrdVisualizzazione.ReadOnly:=dGrdVisualizzazione.DataSource.DataSet is TClientDataSet;
end;

end.
