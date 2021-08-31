unit C016UElencoVoci;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, Oracle, OracleData, 
  Menus, ActnList, A000UInterfaccia, Variants;
type
  TC016FElencoVoci = class(TForm)
    dgrdElencoVoci: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Dsel200: TDataSource;
    pmnRicerca: TPopupMenu;
    Testocontenuto1: TMenuItem;
    sel200: TOracleDataSet;
    sel200COD_VOCE: TStringField;
    sel200COD_VOCE_SPECIALE: TStringField;
    sel200DESCRIZIONE: TStringField;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    Successivo1: TMenuItem;
    lblCodContratto: TLabel;
    procedure dgrdElencoVociDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dgrdElencoVociTitleClick(Column: TColumn);
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
  private
    { Private declarations }
    SqlText: String;
    ColonnaOrdinamento: Integer;
    OrdinamentoDiscendente: Boolean;
    TestoContenuto: String;
  public
    { Public declarations }
    DecorrenzaElencoVoci: TDateTime;
    CodContrattoElencoVoci: String;
    CodVoceElencoVoci: String;
    CodVoceSpecialeElencoVoci: String;
    DescrizioneVoceElencoVoci: String;
    TestoFiltroSql: String;
  end;

var
  C016FElencoVoci: TC016FElencoVoci;

implementation

{$R *.DFM}

procedure TC016FElencoVoci.dgrdElencoVociDblClick(Sender: TObject);
begin
  CodVoceElencoVoci:=sel200.FieldByName('COD_VOCE').AsString;
  CodVoceSpecialeElencoVoci:=sel200.FieldByName('COD_VOCE_SPECIALE').AsString;
  DescrizioneVoceElencoVoci:=sel200.FieldByName('DESCRIZIONE').AsString;
  ModalResult:=mrOK;
end;

procedure TC016FElencoVoci.FormActivate(Sender: TObject);
begin
  lblCodContratto.Caption:=CodContrattoElencoVoci;
  with sel200 do
  begin
    Session:=SessioneOracle;
    // Se il contratto non è definito eseguo una query sulle voci di tutti i contratti
    DeleteVariables;
    DeclareVariable('Decorrenza',otDate);
    SQL.Clear;
    if CodContrattoElencoVoci = '' then
    begin
      SQL.Add('SELECT DISTINCT COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE');
      SQL.Add('FROM P200_VOCI T1');
      SQL.Add('WHERE DECORRENZA =');
      SQL.Add('  (SELECT MAX(DECORRENZA) FROM P200_VOCI WHERE');
      SQL.Add('    DECORRENZA <= :Decorrenza AND');
      SQL.Add('    COD_CONTRATTO = T1.COD_CONTRATTO AND');
      SQL.Add('    COD_VOCE = T1.COD_VOCE AND');
      SQL.Add('    COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE)');
    end
    else
    begin
      DeclareVariable('CodContratto',otString);
      SQL.Add('SELECT COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE');
      SQL.Add('FROM P200_VOCI T1');
      SQL.Add('WHERE COD_CONTRATTO = :CodContratto');
      SQL.Add('  AND DECORRENZA =');
      SQL.Add('  (SELECT MAX(DECORRENZA) FROM P200_VOCI WHERE');
      SQL.Add('    DECORRENZA <= :Decorrenza AND');
      SQL.Add('    COD_CONTRATTO = T1.COD_CONTRATTO AND');
      SQL.Add('    COD_VOCE = T1.COD_VOCE AND');
      SQL.Add('    COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE)');
    end;
    if TestoFiltroSql <> '' then
      SQL.Add(TestoFiltroSql);
    SqlText:=Sql.Text;
    ColonnaOrdinamento:=2;
    SQL.Add('ORDER BY DESCRIZIONE,COD_VOCE,COD_VOCE_SPECIALE');
    Close;
    SetVariable('Decorrenza',DecorrenzaElencoVoci);
    if CodContrattoElencoVoci <> '' then
      SetVariable('CodContratto',CodContrattoElencoVoci);
    Open;
    SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([CodVoceElencoVoci,CodVoceSpecialeElencoVoci]),[srFromBeginning]);
  end;
  OrdinamentoDiscendente:=False;
end;

procedure TC016FElencoVoci.dgrdElencoVociTitleClick(Column: TColumn);
begin
  sel200.Sql.Text:=SqlText;
  if Column.Index = ColonnaOrdinamento then
    OrdinamentoDiscendente:=not(OrdinamentoDiscendente)
  else
    OrdinamentoDiscendente:=False;
  case Column.Index of
    0: //Ordinamento per codice voce e codice voce speciale
    begin
      if OrdinamentoDiscendente then
        sel200.SQL.Add('ORDER BY COD_VOCE DESC,COD_VOCE_SPECIALE')
      else
        sel200.SQL.Add('ORDER BY COD_VOCE,COD_VOCE_SPECIALE');
    end;
    1: //Ordinamento per codice voce speciale e codice voce
    begin
      if OrdinamentoDiscendente then
        sel200.SQL.Add('ORDER BY COD_VOCE_SPECIALE DESC,COD_VOCE')
      else
        sel200.SQL.Add('ORDER BY COD_VOCE_SPECIALE,COD_VOCE');
    end;
    2: //Ordinamento per descrizione, codice voce e codice voce speciale
    begin
      if OrdinamentoDiscendente then
        sel200.SQL.Add('ORDER BY DESCRIZIONE DESC,COD_VOCE,COD_VOCE_SPECIALE')
      else
        sel200.SQL.Add('ORDER BY DESCRIZIONE,COD_VOCE,COD_VOCE_SPECIALE');
    end;
  end;
  ColonnaOrdinamento:=Column.Index;
  sel200.Close;
  sel200.Open;
  sel200.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([CodVoceElencoVoci,CodVoceSpecialeElencoVoci]),[srFromBeginning]);
end;

procedure TC016FElencoVoci.actRicercaTestoContenutoExecute(
  Sender: TObject);
var
  Trovato: Integer;
begin
  if sender = actRicercaTestoContenuto then
  begin
    TestoContenuto:=UpperCase(sel200.FieldByName(dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName).AsString);
    if InputQuery('Ricerca per testo contenuto',dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName,TestoContenuto) then
    begin
      Trovato:=0;
      while (not sel200.Eof) and (Trovato = 0) do
      begin
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(sel200.FieldByName(dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName).AsString));
        if Trovato = 0 then
          sel200.Next;
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
          dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName +'"');
        sel200.First;
      end;
    end;
  end
  else
  begin
    Trovato:=0;
    while (not sel200.Eof) and (Trovato = 0) do
    begin
      if Trovato = 0 then
        sel200.Next;
      Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(sel200.FieldByName(dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName).AsString));
    end;
    if Trovato = 0 then
    begin
      ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dgrdElencoVoci.Columns[ColonnaOrdinamento].FieldName +'"');
      sel200.First;
    end;
  end;
end;

end.
