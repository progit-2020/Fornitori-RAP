unit A086UMotivazioniRichieste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, Datasnap.DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, OracleData, System.Actions,
  C180FunzioniGenerali;

type
  TA086FMotivazioniRichieste = class(TR001FGestTab)
    dgrdMotivazioni: TDBGrid;
    pnlTipo: TPanel;
    cmbTipo: TComboBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipoChange(Sender: TObject);
    procedure cmbTipoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  end;

var
  A086FMotivazioniRichieste: TA086FMotivazioniRichieste;

procedure OpenA086MotivazioniRichieste(Tipo: String; Codice: String);

implementation

uses A086UMotivazioniRichiesteDtM;

{$R *.dfm}

procedure OpenA086MotivazioniRichieste(Tipo: String; Codice: String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA086MotivazioniRichieste') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A086FMotivazioniRichieste:=TA086FMotivazioniRichieste.Create(nil);
  with A086FMotivazioniRichieste do
  try
    A086FMotivazioniRichiesteDtM:=TA086FMotivazioniRichiesteDtM.Create(nil);
    A086FMotivazioniRichiesteDtM.selT106.SearchRecord('TIPO;CODICE',VarArrayOf([Tipo,Codice]),[srFromBeginning]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A086FMotivazioniRichiesteDtM.Free;
    Free;
  end;
end;

procedure TA086FMotivazioniRichieste.cmbTipoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  DS: TClientDataSet;
  NRec: Integer;
begin
  inherited;
  DS:=A086FMotivazioniRichiesteDtM.A086MW.cdsTipologie;
  NRec:=Index + 1;
  if R180Between(NRec,1,DS.RecordCount) then
  begin
    DS.RecNo:=Index + 1;
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,DS.FieldByName('DESCRIZIONE').AsString);
  end;
end;

procedure TA086FMotivazioniRichieste.FormCreate(Sender: TObject);
begin
  inherited;
  // la colonna tipo viene nascosta al momento
  dgrdMotivazioni.Columns[0].Visible:=False;
end;

procedure TA086FMotivazioniRichieste.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A086FMotivazioniRichiesteDtM.selT106;

  inherited;

  // popola combobox dei tipi
  A086FMotivazioniRichiesteDtM.A086MW.cdsTipologie.First;
  while not A086FMotivazioniRichiesteDtM.A086MW.cdsTipologie.Eof do
  begin
    cmbTipo.Items.Add(A086FMotivazioniRichiesteDtM.A086MW.cdsTipologie.FieldByName('CODICE').AsString);
    A086FMotivazioniRichiesteDtM.A086MW.cdsTipologie.Next;
  end;
  cmbTipo.ItemIndex:=0;
  cmbTipoChange(nil);
end;

procedure TA086FMotivazioniRichieste.cmbTipoChange(Sender: TObject);
var
  Codice: String;
begin
  Codice:=cmbTipo.Text;
  A086FMotivazioniRichiesteDtM.A086MW.FiltraSelT106(Codice);
  A086FMotivazioniRichiesteDtM.selT106NewRecord(nil);
  NumRecords;
end;

end.
