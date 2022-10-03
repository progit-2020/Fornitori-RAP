unit A022UContratti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, Mask, DBCtrls, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TFasce = record
    DAOre,AOre:TDateTime;
    Fascia:String;
  end;

  TA022FContratti = class(TR001FGestTab)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    ETipo: TDBRadioGroup;
    EIndTurno: TDBRadioGroup;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    PopupMenu1: TPopupMenu;
    Copiasurigaprecedente1: TMenuItem;
    Copiasurigasuccessiva1: TMenuItem;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    dedtMaxResiduabile: TDBEdit;
    lblArrIndTurnoPal: TLabel;
    dedtArrIndTurnoPal: TDBEdit;
    actFasceMagg: TAction;
    FasceMagg1: TMenuItem;
    dchkOreLavFasceConAss: TDBCheckBox;
    procedure DButtonStateChange(Sender: TObject);
    procedure ETipoClick(Sender: TObject);
    procedure ETipoChange(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Copiasurigasuccessiva1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actFasceMaggExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A022FContratti: TA022FContratti;

procedure OpenA022Contratti(cod:string);

implementation

uses A022UContrattiDtM1, A022UMaggiorazioni;

{$R *.DFM}

procedure OpenA022Contratti(cod:string);
{Gestione Contratti}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA022Contratti') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A022FContratti:=TA022FContratti.Create(nil);
  A022FContrattiDtM1:=TA022FContrattiDtM1.Create(nil);
  with A022FContratti do
  try
    DButton.DataSet:=A022FContrattiDtM1.T200;
    DButton.DataSet.Locate('Codice',cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A022FContrattiDtM1.Free;
    Release;
  end;
end;

procedure TA022FContratti.DButtonStateChange(Sender: TObject);
{Non visualizzo le fasce di maggiorazione se sono in inserimento}
begin
  inherited;
  if DButton.State = dsInsert then PageControl1.ActivePage:=TabSheet1;
  TabSheet2.TabVisible:=DButton.State <> dsInsert;
end;

procedure TA022FContratti.ETipoChange(Sender: TObject);
{Abilito/disabilito Indennità turno}
begin
  if DButton.State = dsBrowse then
    ETipoClick(Sender);
end;

procedure TA022FContratti.ETipoClick(Sender: TObject);
{Abilito/disabilito Indennità turno}
begin
  EIndTurno.Enabled:=ETipo.ItemIndex < 2;
  lblArrIndTurnoPal.Enabled:=ETipo.ItemIndex < 2;
  dedtArrIndTurnoPal.Enabled:=ETipo.ItemIndex < 2;
end;

procedure TA022FContratti.DBGrid1EditButtonClick(Sender: TObject);
{Attivo la finestra di scelta fasce di maggiorazioni}
begin
  actFasceMaggExecute(nil);
end;

procedure TA022FContratti.PopupMenu1Popup(Sender: TObject);
begin
  with A022FContrattiDtM1 do
    begin
    Copiasurigaprecedente1.Enabled:=(T201Giorno.AsString > '1') and (T201.State = dsBrowse);
    Copiasurigasuccessiva1.Enabled:=(T201Giorno.AsString < '9') and (T201.State = dsBrowse);
    end;
end;

procedure TA022FContratti.Copiasurigasuccessiva1Click(Sender: TObject);
var Fasce:Array[1..12] of Variant;
    i:Word;
begin
  for i:=1 to 12 do
    with A022FContrattiDtM1.T201 do
      Fasce[i]:=Fields[i + 2].Value;
  with A022FContrattiDtM1.T201 do
    begin
    if Sender = Copiasurigaprecedente1 then
      Prior
    else
      Next;
    Edit;
    for i:=1 to 12 do
      Fields[i + 2].Value:=Fasce[i];
    Post;
    end;
end;

procedure TA022FContratti.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A022FContrattiDtM1.T200;
  inherited;
end;

procedure TA022FContratti.actFasceMaggExecute(Sender: TObject);
begin
  inherited;
  A022FMaggiorazioni:=TA022FMaggiorazioni.Create(Application);
  with A022FMaggiorazioni do
    try
    if ShowModal = mrOk then
      if Trim(EMaggiorazioni.Text) <> '' then
        with A022FContrattiDtM1 do
          begin
          T201.Edit;
          A022FContratti.DBGrid1.SelectedField.Clear;
          A022FContratti.DBGrid1.SelectedField.AsString:=EMaggiorazioni.Text;
          end;
    finally
    Release;
    A022FContrattiDtM1.T210.Refresh;
    end;
end;

end.
