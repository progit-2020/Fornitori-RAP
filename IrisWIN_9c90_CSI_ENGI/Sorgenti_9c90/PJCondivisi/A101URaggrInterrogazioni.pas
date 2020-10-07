unit A101URaggrInterrogazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  A101URaggrInterrogazioniDtm, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls,
  ToolbarFiglio, Vcl.Grids, Vcl.DBGrids, A000USessione, C180FunzioniGenerali,
  OracleData;

type
  TA101FRaggrInterrogazioni = class(TR001FGestTab)
    pnlAssociazioni: TPanel;
    dGrdAssociazioni: TDBGrid;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dGrdRaggrinterrogazioni: TDBGrid;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dGrdAssociazioniDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A101FRaggrInterrogazioni: TA101FRaggrInterrogazioni;

procedure OpenA101RaggrInterrogazioni(NomeRaggr:string);

implementation

{$R *.dfm}

procedure OpenA101RaggrInterrogazioni(NomeRaggr:string);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA101RaggrInterrogazioni') of
    'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A101FRaggrInterrogazioniDtm:=TA101FRaggrInterrogazioniDtm.Create(nil);
  A101FRaggrInterrogazioni:=TA101FRaggrInterrogazioni.Create(nil);
  try
    A101FRaggrInterrogazioniDtm.selT005.SearchRecord('DESCRIZIONE',NomeRaggr,[srFromBeginning]);
    A101FRaggrInterrogazioni.ShowModal;
  finally
    FreeAndNil(A101FRaggrInterrogazioni);
    FreeAndNil(A101FRaggrInterrogazioniDtm);
  end;
end;

procedure TA101FRaggrInterrogazioni.dGrdAssociazioniDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',(Sender as TDBGrid).DataSource.DataSet.FieldByName('COD_QUERY').AsString) then
  begin
    (Sender as TDBGrid).Canvas.Brush.Color:=clSilver;
    (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TA101FRaggrInterrogazioni.FormCreate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A101FRaggrInterrogazioniDtm.selT005;
  dGrdAssociazioni.DataSource:=A101FRaggrInterrogazioniDtm.dsrT006;
end;

procedure TA101FRaggrInterrogazioni.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=A101FRaggrInterrogazioniDtm.dsrT006;
  frmToolbarFiglio.TFDBGrid:=dGrdAssociazioni;
  SetLength(frmToolbarFiglio.lstLock,3);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);

  //Carico elenco interrogazioni di servizio, tenedo conto del filtro dizionario
  A101FRaggrInterrogazioniDtm.A101MW.selT002.First;
  while not A101FRaggrInterrogazioniDtm.A101MW.selT002.Eof do
  begin
    dGrdAssociazioni.Columns[R180GetColonnaDBGrid(dGrdAssociazioni,'COD_QUERY')].PickList.Add(A101FRaggrInterrogazioniDtm.A101MW.selT002.FieldByName('NOME').AsString);
    A101FRaggrInterrogazioniDtm.A101MW.selT002.Next;
  end;
end;

end.
