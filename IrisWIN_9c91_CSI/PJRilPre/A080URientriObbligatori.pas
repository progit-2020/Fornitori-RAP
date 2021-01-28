unit A080URientriObbligatori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C013UCheckList, Grids, DBGrids;

type
  TA080FRientriObbligatori = class(TR004FGestStorico)
    pnlDati: TPanel;
    dedtGiorniLavorativi: TDBEdit;
    lblGiorniLavorativi: TLabel;
    lblRientriObbligatori: TLabel;
    dedtRientriObbligatori: TDBEdit;
    dgrdT029: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTipoCartellino:String;
    procedure PutTipoCartellino(Valore:String);
  public
    { Public declarations }
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

var
  A080FRientriObbligatori: TA080FRientriObbligatori;


implementation

uses A080URientriObbligatoriDtM;

{$R *.dfm}

procedure TA080FRientriObbligatori.FormCreate(Sender: TObject);
begin
  inherited;
  FTipoCartellino:='';
  A080FRientriObbligatoriDtM:=TA080FRientriObbligatoriDtM.Create(Self);
end;

procedure TA080FRientriObbligatori.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A080FRientriObbligatoriDtM.selT029;
  A080FRientriObbligatoriDtM.selT029.Open;
  actVisioneCorrente.Execute;
end;

procedure TA080FRientriObbligatori.PutTipoCartellino(Valore:String);
begin
  FTipoCartellino:=Valore;
  A080FRientriObbligatoriDtM.TipoCartellino:=Valore;
end;

end.
