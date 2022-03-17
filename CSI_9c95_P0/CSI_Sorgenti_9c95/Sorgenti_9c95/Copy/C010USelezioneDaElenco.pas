unit C010USelezioneDaElenco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, Oracle, OracleData, A000UCostanti, A000USessione,
  Menus, ActnList, Variants, System.Actions;
type
  TC010FSelezioneDaElenco = class(TForm)
    dgrdSelezioneDaElenco: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    selDati: TOracleDataSet;
    selDatiCOD_VOCE: TStringField;
    selDatiCOD_VOCE_SPECIALE: TStringField;
    selDatiDESCRIZIONE: TStringField;
    DselDati: TDataSource;
    pmnRicerca: TPopupMenu;
    Successivo1: TMenuItem;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    Testocontenuto1: TMenuItem;
    procedure dgrdSelezioneDaElencoDblClick(Sender: TObject);
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dgrdSelezioneDaElencoTitleClick(Column: TColumn);
  private
    { Private declarations }
    ColonnaOrdinamento: Integer;
    TestoContenuto: String;
    OrdinamentoDiscendente: Boolean;
  public
    { Public declarations }
    ODS:TOracleDataSet;
  end;

var
  C010FSelezioneDaElenco: TC010FSelezioneDaElenco;

implementation

{$R *.DFM}

{Serve per ricercare all'interno di una tabella:
 cercare se possibile di usare la C015 (che fa anche la gestione della tabella) anche se riguarda solo la ricerca}

{Esempio di utilizzo
    C010FSelezioneDaElenco:=TC010FSelezioneDaElenco.Create(nil);
    try
      C010FSelezioneDaElenco.Caption:='Elenco banche';
      C010FSelezioneDaElenco.ODS:=Q010;
      C010FSelezioneDaElenco.DselDati.DataSet:=C010FSelezioneDaElenco.ODS;
      if (C010FSelezioneDaElenco.ShowModal = mrOK) and (DButton.State in [dsInsert,dsEdit]) then
        Q430.FieldByName('COD_BANCA').AsString:=Q010.FieldByName('COD_BANCA').AsString;
    finally
      FreeAndNil(C010FSelezioneDaElenco);
    end;}

procedure TC010FSelezioneDaElenco.dgrdSelezioneDaElencoDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TC010FSelezioneDaElenco.actRicercaTestoContenutoExecute(
  Sender: TObject);
var
  Trovato: Integer;
begin
  if sender = actRicercaTestoContenuto then
  begin
    TestoContenuto:=UpperCase(selDati.FieldByName(dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName).AsString);
    if InputQuery('Ricerca per testo contenuto',dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName,TestoContenuto) then
    begin
      Trovato:=0;
      while (not selDati.Eof) and (Trovato = 0) do
      begin
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(selDati.FieldByName(dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName).AsString));
        if Trovato = 0 then
          selDati.Next;
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
          dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName +'"');
        selDati.First;
      end;
    end;
  end
  else
  begin
    Trovato:=0;
    while (not selDati.Eof) and (Trovato = 0) do
    begin
      if Trovato = 0 then
        selDati.Next;
      Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(selDati.FieldByName(dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName).AsString));
    end;
    if Trovato = 0 then
    begin
      ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName +'"');
      selDati.First;
    end;
  end;
end;

procedure TC010FSelezioneDaElenco.FormShow(Sender: TObject);
begin
  selDati:=ODS;
end;

procedure TC010FSelezioneDaElenco.dgrdSelezioneDaElencoTitleClick(Column: TColumn);
var
  SqlText: String;
  i: Integer;
begin
  SqlText:=selDati.SQL.Text;
  i:=Pos('ORDER BY',UpperCase(SqlText));
  if i > 0 then
    SqlText:=Copy(SqlText,1,i - 1) + ' ORDER BY ' + dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName
  else
    SqlText:=SqlText + ' ORDER BY ' + dgrdSelezioneDaElenco.Columns[ColonnaOrdinamento].FieldName;
  if Column.Index = ColonnaOrdinamento then
  begin
    if OrdinamentoDiscendente then
      SqlText:=SqlText + ' DESC';
    OrdinamentoDiscendente:=not(OrdinamentoDiscendente);
  end;
  ColonnaOrdinamento:=Column.Index;
  selDati.SQL.Clear;
  seldati.SQL.Add(SqlText);
  selDati.Close;
  selDati.Open;
end;

end.
