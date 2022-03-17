unit A055UTurnazioni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Grids,
  DBGrids, Mask, DBCtrls, RegistrazioneLog, ActnList,
  ImgList, ToolWin, A000UCostanti, A000USessione, A000UInterfaccia, A054UCicliTurni,
  C011UDBList, Variants, System.Actions;

type
  TA055FTurnazioni = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    BModifica: TBitBtn;
    BConferma: TBitBtn;
    BAnnulla: TBitBtn;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure BModificaClick(Sender: TObject);
    procedure BAnnullaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure BConfermaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A055FTurnazioni: TA055FTurnazioni;

procedure OpenA055Turnazioni(Cod:String);

implementation

uses A055UTurnazioniDtM1;

{$R *.DFM}

procedure OpenA055Turnazioni(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA055Turnazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
A055FTurnazioni:=TA055FTurnazioni.Create(nil);
with A055FTurnazioni do
  try
    A055FTurnazioniDtM1:=TA055FTurnazioniDtM1.Create(nil);
    A055FTurnazioniDtM1.Q640.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A055FTurnazioniDtM1.Free;
    Free;
  end;
end;

procedure TA055FTurnazioni.BModificaClick(Sender: TObject);
{Abilito le modifiche ai Tipi operatore}
begin
  A055FTurnazioniDtM1.A055MW.Q641.ReadOnly:=False;
  BModifica.Enabled:=False;
  BConferma.Enabled:=True;
  BAnnulla.Enabled:=True;
  Panel1.Enabled:=False;
end;

procedure TA055FTurnazioni.BAnnullaClick(Sender: TObject);
{Annullo le modifiche ai Tipi operatore}
begin
  A055FTurnazioniDtM1.A055MW.Q641.CancelUpdates;
  A055FTurnazioniDtM1.A055MW.Q641.ReadOnly:=True;
  BModifica.Enabled:=True;
  BConferma.Enabled:=False;
  BAnnulla.Enabled:=False;
  Panel1.Enabled:=True;
end;

procedure TA055FTurnazioni.BConfermaClick(Sender: TObject);
{Confermo le modifiche ai Tipi operatore}
begin
  if A055FTurnazioniDtM1.A055MW.Q641.State in [dsEdit,dsInsert] then
    A055FTurnazioniDtM1.A055MW.Q641.Post;
  try
    try
      A055FTurnazioniDtM1.A055MW.SettaOrdineProgressivo(1000);
      SessioneOracle.ApplyUpdates([A055FTurnazioniDtM1.A055MW.Q641],True);
      A055FTurnazioniDtM1.A055MW.SettaOrdineProgressivo(0);
      SessioneOracle.ApplyUpdates([A055FTurnazioniDtM1.A055MW.Q641],True);
      SessioneOracle.Commit;
      RegistraLog.SettaProprieta('M','T641_MOLTTURNAZIONE',Copy(Name,1,4),nil,True);
      RegistraLog.InserisciDato('CODICE',A055FTurnazioniDtM1.A055MW.Q641Turnazione.AsString,'');
      RegistraLog.RegistraOperazione;
    except
      SessioneOracle.Rollback;
      raise;
    end;
  finally
    A055FTurnazioniDtM1.A055MW.Q641.ReadOnly:=True;
    A055FTurnazioniDtM1.A055MW.Q641.Close;
    A055FTurnazioniDtM1.A055MW.Q641.Open;
    BModifica.Enabled:=True;
    BConferma.Enabled:=False;
    BAnnulla.Enabled:=False;
    Panel1.Enabled:=True;
  end;
end;

procedure TA055FTurnazioni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BModifica.Enabled:=(DButton.State = dsBrowse) and (DButton.Dataset.RecordCount > 0);
end;

procedure TA055FTurnazioni.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A055FTurnazioniDtM1.Q640;
  DBGrid1.DataSource:=A055FTurnazioniDtM1.A055MW.D641;
  inherited;
end;

procedure TA055FTurnazioni.DButtonDataChange(Sender: TObject; Field: TField);
{Leggo i tipi operatori della squadra}
begin
  if (Field = nil) and (DButton.State = dsBrowse) then
    with A055FTurnazioniDtM1.A055MW.Q641 do
      begin
        Close;
        SetVariable('Turnazione',A055FTurnazioniDtM1.Q640Codice.AsString);
        Open;
      end;
end;

procedure TA055FTurnazioni.DBGrid1EditButtonClick(Sender: TObject);
{Richiamo l'elenco delle turnazioni o degli orari}
begin
  if (SolaLettura) or (A055FTurnazioniDtM1.A055MW.Q641.ReadOnly)  then exit;
  with A055FTurnazioniDtM1 do
    begin
    C011FDBList:=TC011FDBList.Create(nil);
    C011FDBList.Chiave:=DbGrid1.SelectedField.Text;
    try
      C011FDBList.DataSource1.DataSet:=A055MW.Q610;
      C011FDBList.Caption:='Elenco Cicli';
      if C011FDBList.ShowModal = mrOK then
      begin
        if A055MW.Q641.State = dsBrowse then
          A055MW.Q641.Edit;
        DbGrid1.SelectedField.AsString:=C011FDBList.DataSource1.DataSet.FieldByName('Codice').AsString;
      end;
    finally
      C011FDBList.Release;
    end;
    end;
end;

procedure TA055FTurnazioni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
    if not A055FTurnazioniDtM1.A055MW.Q641.ReadOnly then
      Action:=caNone;
end;

procedure TA055FTurnazioni.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione cicli}
begin
  OpenA054CicliTurni((PopupMenu1.PopupComponent as TDBGrid).SelectedField.AsString);
  A055FTurnazioniDtM1.A055MW.Q610.Refresh;
end;

procedure TA055FTurnazioni.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.ReadOnly:=SolaLettura;
end;

end.
