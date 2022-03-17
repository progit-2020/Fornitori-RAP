unit A100UDistanzeChilometriche;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Menus, A106UDistanzeTrasferta,
  ActnList, System.Actions;

type
  TA100FDistanzeChilometriche = class(TForm)
    dGrdDistanze: TDBGrid;
    Panel1: TPanel;
    btnOk: TBitBtn;
    BtnAnnulla: TBitBtn;
    chkAndataRitorno: TCheckBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    N1: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo2: TMenuItem;
    procedure dGrdDistanzeColEnter(Sender: TObject);
    procedure Ricercatestocontenuto1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dGrdDistanzeTitleClick(Column: TColumn);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    ColonnaOrdinamento: Integer;
    TestoContenuto: String;
  public
    { Public declarations }
  end;

var
  A100FDistanzeChilometriche: TA100FDistanzeChilometriche;
procedure OpenA100DistanzeChilometriche;

implementation

uses A100UMISSIONIDTM;

{$R *.dfm}

procedure OpenA100DistanzeChilometriche;
begin
  A100FDistanzeChilometriche:=TA100FDistanzeChilometriche.Create(nil);
  try
    A100FDistanzeChilometriche.ShowModal;
  finally
    A100FDistanzeChilometriche.Free;
  end;
end;


procedure TA100FDistanzeChilometriche.FormActivate(Sender: TObject);
begin
  with A100FMISSIONIDTM do
  begin
    A100FMissioniMW.ImpostaSelM041;
    dGrdDistanze.DataSource:=A100FMissioniMW.DSelM041;
  end;
end;

procedure TA100FDistanzeChilometriche.btnOkClick(Sender: TObject);
begin
  with A100FMISSIONIDTM do
  begin
    if chkAndataRitorno.Checked then
      A100FMissioniMW.QM052.FieldByName('KMPERCORSI').AsFloat:=A100FMissioniMW.SelM041.FieldByName('CHILOMETRI').AsFloat * 2
    else
      A100FMissioniMW.QM052.FieldByName('KMPERCORSI').AsFloat:=A100FMissioniMW.SelM041.FieldByName('CHILOMETRI').AsFloat;
  end;
  A100FDistanzeChilometriche.Close;
end;

procedure TA100FDistanzeChilometriche.Nuovoelemento1Click(Sender: TObject);
begin
  try
    A106UDistanzeTrasferta.OpenA106DistanzeTrasferta;
  finally
    A100FMISSIONIDTM.A100FMissioniMW.ImpostaSelM041;
    ColonnaOrdinamento:=0;
  end;
end;

procedure TA100FDistanzeChilometriche.dGrdDistanzeTitleClick(Column: TColumn);
var
  sCampo, sOrder, sNewOrder, sOldOrder:string;
  i:integer;
begin
  sNewOrder:='';
  with A100FMISSIONIDTM do
  begin
    sOldOrder:=A100FMissioniMW.SelM041.GetVariable('ORDERBY');
    sCampo:=Column.FieldName;
    for i:=0 to dGrdDistanze.Columns.Count-1 do
    begin
      if dGrdDistanze.Columns[i].FieldName<>Column.FieldName then
        sNewOrder:=sNewOrder + ',' + dGrdDistanze.Columns[i].FieldName + ' ASC';
    end;
    sOrder:='ORDER BY ' + sCampo + ' ASC' + sNewOrder;
    if sOrder=sOldOrder then
      sOrder:='ORDER BY ' + sCampo + ' DESC' + sNewOrder;
    A100FMissioniMW.SelM041.Close;
    A100FMissioniMW.SelM041.ClearVariables;
    A100FMissioniMW.SelM041.SetVariable('ORDERBY',sOrder);
    A100FMissioniMW.SelM041.Open;
  end;
  ColonnaOrdinamento:=Column.Index;
end;

procedure TA100FDistanzeChilometriche.FormResize(Sender: TObject);
begin
  BtnOk.Left:=Trunc((Panel1.Width/2) - (BtnOk.Width+10));
  BtnAnnulla.Left:=Trunc((Panel1.Width/2) + 10);
end;

procedure TA100FDistanzeChilometriche.Ricercatestocontenuto1Click(
  Sender: TObject);
var
  Trovato: Integer;
begin
  with A100FMISSIONIDTM do
  begin
    if sender = actRicercaTestoContenuto then
    begin
      TestoContenuto:=Trim(UpperCase(A100FMissioniMW.SelM041.FieldByName(dGrdDistanze.Columns[ColonnaOrdinamento].FieldName).AsString));
      if InputQuery('Ricerca per testo contenuto',dGrdDistanze.Columns[ColonnaOrdinamento].Title.Caption,TestoContenuto) then
      begin
        Trovato:=0;
        while (not A100FMissioniMW.SelM041.Eof) and (Trovato = 0) do
        begin
          Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(A100FMissioniMW.SelM041.FieldByName(dGrdDistanze.Columns[ColonnaOrdinamento].FieldName).AsString));
          if Trovato = 0 then
            A100FMissioniMW.SelM041.Next;
        end;
        if Trovato = 0 then
        begin
          ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
            dGrdDistanze.Columns[ColonnaOrdinamento].Title.Caption +'"');
          A100FMissioniMW.SelM041.First;
        end;
      end;
    end
    else
    begin
      Trovato:=0;
      while (not A100FMissioniMW.SelM041.Eof) and (Trovato = 0) do
      begin
        if Trovato = 0 then
          A100FMissioniMW.SelM041.Next;
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(A100FMissioniMW.SelM041.FieldByName(dGrdDistanze.Columns[ColonnaOrdinamento].FieldName).AsString));
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
        dGrdDistanze.Columns[ColonnaOrdinamento].Title.Caption +'"');
        A100FMissioniMW.SelM041.First;
      end;
    end;
  end;
end;

procedure TA100FDistanzeChilometriche.dGrdDistanzeColEnter(Sender: TObject);
begin
  ColonnaOrdinamento:=dGrdDistanze.SelectedIndex;
end;

end.
