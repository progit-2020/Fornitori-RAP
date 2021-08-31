unit A088UDatiLiberiIterMissioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, DB, ComCtrls, DBCtrls, DBGrids, Math,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData, Grids, ImgList,
  Menus, ToolWin, System.Actions, Vcl.StdCtrls, Vcl.ExtCtrls,
  ToolbarFiglio, A000UMessaggi;

type
  TA088FDatiLiberiIterMissioni = class(TR001FGestTab)
    pnlDetail: TPanel;
    pnlMaster: TPanel;
    dgrdDatiLiberi: TDBGrid;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdCategorie: TDBGrid;
    splMasterDetail: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
  private
  public
  end;

var
  A088FDatiLiberiIterMissioni: TA088FDatiLiberiIterMissioni;

procedure OpenA088DatiLiberiIterMissioni(const PCodice: String);

implementation

uses A088UDatiLiberiIterMissioniDtM;

{$R *.dfm}

procedure OpenA088DatiLiberiIterMissioni(const PCodice: String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA088MotivazioniMissioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A088FDatiLiberiIterMissioni:=TA088FDatiLiberiIterMissioni.Create(nil);
  with A088FDatiLiberiIterMissioni do
  try
    A088FDatiLiberiIterMissioniDtM:=TA088FDatiLiberiIterMissioniDtM.Create(nil);
    A088FDatiLiberiIterMissioniDtM.selM025.SearchRecord('CODICE',PCodice,[srFromBeginning]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A088FDatiLiberiIterMissioniDtM);
    Free;
  end;
end;

procedure TA088FDatiLiberiIterMissioni.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A088FDatiLiberiIterMissioniDtM.selM024;

  inherited;

  frmToolbarFiglio.TFDButton:=A088FDatiLiberiIterMissioniDtM.dsrM025;
  frmToolbarFiglio.TFDBGrid:=dgrdDatiLiberi;
  frmToolbarFiglio.tlbarFiglio.HandleNeeded;//necessario per XE3
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=dgrdCategorie;
  frmToolbarFiglio.AbilitaAzioniTF(nil);

  A088FDatiLiberiIterMissioniDtM.PopolaListeValori;
end;

procedure TA088FDatiLiberiIterMissioni.Copiada1Click(Sender: TObject);
begin
  // le categorie di sistema (ordine 0) non sono duplicabili
  if A088FDatiLiberiIterMissioniDtM.selM024.FieldByName('ORDINE').AsInteger = 0 then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A088_ERR_FMT_DUP_CAT0),[A088FDatiLiberiIterMissioniDtM.selM024.FieldByName('DESCRIZIONE').AsString]));

  inherited;
end;

procedure TA088FDatiLiberiIterMissioni.FormDestroy(Sender: TObject);
begin
  // se debug distrugge datamodulo (evita memory leak)
  if DebugHook <> 0 then
  begin
    if A088FDatiLiberiIterMissioniDtM <> nil then
      A088FDatiLiberiIterMissioniDtM.Free;
  end;
  inherited;
end;

end.
