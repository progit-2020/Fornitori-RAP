unit P555UElencoDipendenti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus, Clipbrd, ComCtrls,
  C180FunzioniGenerali, Oracle, OracleData;

type
  TP555FElencoDipendenti = class(TForm)
    DbGrdDipendenti: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    MnuDipendenti: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N9: TMenuItem;
    Copia1: TMenuItem;
    Panel2: TPanel;
    lblAnno: TLabel;
    edtAnno: TEdit;
    lblCodTabella: TLabel;
    edtTabella: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    CopiaInExcel: TMenuItem;
    StatusBar1: TStatusBar;
    lblTabella: TLabel;
    lblRiga: TLabel;
    lblColonna: TLabel;
    procedure CopiaInExcelClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P555FElencoDipendenti: TP555FElencoDipendenti;

  procedure OpenP555ElencoDipendenti(Anno,Colonna,Riga:Integer;CodTabella:String);

implementation

uses P555UContoAnnualeDtM;

{$R *.dfm}

procedure OpenP555ElencoDipendenti(Anno,Colonna,Riga:Integer;CodTabella:String);
begin
  Application.CreateForm(TP555FElencoDipendenti, P555FElencoDipendenti);
  try
    with P555FContoAnnualeDtM.selDip do
    begin
      Close;
      SetVariable('Anno',Anno);
      SetVariable('Colonna',Colonna);
      SetVariable('Riga',Riga);
      SetVariable('CodTabella',CodTabella);
      Open;
      P555FElencoDipendenti.StatusBar1.Panels[0].Text:=IntToStr(RecordCount) +  ' Records';
    end;
    P555FElencoDipendenti.edtAnno.Text:=IntToStr(Anno);
    P555FElencoDipendenti.edtTabella.Text:=CodTabella;
    with P555FContoAnnualeDtM do
    begin
      P555FElencoDipendenti.lblTabella.Caption:=selP552.FieldByName('DESCRIZIONE').AsString;
      if selP552Riga.SearchRecord('ANNO;COD_TABELLA;RIGA',VarArrayOf([AnnoRegole,CodTabella,Riga]),[srFromBeginning]) then
        P555FElencoDipendenti.lblRiga.Caption:=selP552Riga.FieldByName('DESCRIZIONE').AsString + ' - ' + selP552Riga.FieldByName('VALORE_COSTANTE').AsString;
      if selP552Col.SearchRecord('ANNO;COD_TABELLA;COLONNA',VarArrayOf([AnnoRegole,CodTabella,Colonna]),[srFromBeginning]) then
        P555FElencoDipendenti.lblColonna.Caption:=selP552Col.FieldByName('DESCRIZIONE').AsString;
    end;
    P555FElencoDipendenti.ShowModal;
  finally
    FreeAndNil(P555FElencoDipendenti);
  end;
end;

procedure TP555FElencoDipendenti.Selezionatutto1Click(Sender: TObject);
begin
  DbGrdDipendenti.SelectedRows.Clear;
  with DbGrdDipendenti.DataSource.DataSet do
  begin
    DisableControls;
    First;
    try
      while not EOF do
      begin
        DbGrdDipendenti.SelectedRows.CurrentRowSelected:=True;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TP555FElencoDipendenti.Annullatutto1Click(Sender: TObject);
begin
  DbGrdDipendenti.SelectedRows.Clear;
end;

procedure TP555FElencoDipendenti.Invertiselezione1Click(Sender: TObject);
begin
  with DbGrdDipendenti.DataSource.DataSet do
  begin
    DisableControls;
    First;
    try
      while not EOF do
      begin
        DbGrdDipendenti.SelectedRows.CurrentRowSelected := not DbGrdDipendenti.SelectedRows.CurrentRowSelected;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TP555FElencoDipendenti.CopiaInExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dbGrdDipendenti,Sender = CopiaInExcel);
end;

end.
