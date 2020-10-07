unit A054UCicliTurni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  StdCtrls, Mask, DBCtrls, RegistrazioneLog, ActnList,
  ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, A006UModelliOrario, A016UCausAssenze,
  C011UDBList, Variants, C180FunzioniGenerali, OracleData, System.Actions;

type
  TA054FCicliTurni = class(TR001FGestTab)
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
    procedure FormActivate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure BModificaClick(Sender: TObject);
    procedure BConfermaClick(Sender: TObject);
    procedure BAnnullaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A054FCicliTurni: TA054FCicliTurni;

procedure OpenA054CicliTurni(Cod:String);

implementation

uses A054UCicliTurniDtM1;

{$R *.DFM}

procedure OpenA054CicliTurni(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA054CicliTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
A054FCicliTurni:=TA054FCicliTurni.Create(nil);
with A054FCicliTurni do
  try
    A054FCicliTurniDtM1:=TA054FCicliTurniDtM1.Create(nil);
    A054FCicliTurniDtM1.Q610.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A054FCicliTurniDtM1.Free;
    Free;
  end;
end;

procedure TA054FCicliTurni.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A054FCicliTurniDtM1.Q610;
  DBGrid1.DataSource:=A054FCicliTurniDtM1.A054MW.D611;
  inherited;
end;

procedure TA054FCicliTurni.DButtonDataChange(Sender: TObject;
  Field: TField);
{Leggo il ciclo del codice corrispondente}
begin
  if (Field = nil) and (DButton.State = dsBrowse) then
    with A054FCicliTurniDtM1.A054MW.Q611 do
    begin
      Close;
      SetVariable('Ciclo',A054FCicliTurniDtM1.Q610Codice.AsString);
      Open;
    end;
end;

procedure TA054FCicliTurni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BModifica.Enabled:=(DButton.State = dsBrowse) and (DButton.Dataset.RecordCount > 0);
end;

procedure TA054FCicliTurni.BModificaClick(Sender: TObject);
begin
  A054FCicliTurniDtM1.A054MW.Q611.ReadOnly:=False;
  BModifica.Enabled:=False;
  BConferma.Enabled:=True;
  BAnnulla.Enabled:=True;
  Panel1.Enabled:=False;
end;

procedure TA054FCicliTurni.BConfermaClick(Sender: TObject);
{Confermo le modifiche del ciclo}
begin
  if A054FCicliTurniDtM1.A054MW.Q611.State in [dsEdit,dsInsert] then
    A054FCicliTurniDtM1.A054MW.Q611.Post;
  try
    try
      A054FCicliTurniDtM1.A054MW.SettaGiornoProgressivo(1000);
      SessioneOracle.ApplyUpdates([A054FCicliTurniDtM1.A054MW.Q611],True);
      A054FCicliTurniDtM1.A054MW.SettaGiornoProgressivo(0);
      SessioneOracle.ApplyUpdates([A054FCicliTurniDtM1.A054MW.Q611],True);
      SessioneOracle.Commit;
      RegistraLog.SettaProprieta('M','T611_CICLIGIORNALIERI',Copy(Name,1,4),nil,True);
      RegistraLog.InserisciDato('CODICE',A054FCicliTurniDtM1.A054MW.Q611Ciclo.AsString,'');
      RegistraLog.RegistraOperazione;
    except
      SessioneOracle.Rollback;
      raise;
    end;
  finally
    A054FCicliTurniDtM1.A054MW.Q611.ReadOnly:=True;
    A054FCicliTurniDtM1.A054MW.Q611.Close;
    A054FCicliTurniDtM1.A054MW.Q611.Open;
    BModifica.Enabled:=True;
    BConferma.Enabled:=False;
    BAnnulla.Enabled:=False;
    Panel1.Enabled:=True;
  end;
end;

procedure TA054FCicliTurni.BAnnullaClick(Sender: TObject);
{Annullo le modifiche al Ciclo}
begin
  A054FCicliTurniDtM1.A054MW.Q611.CancelUpdates;
  A054FCicliTurniDtM1.A054MW.Q611.ReadOnly:=True;
  BModifica.Enabled:=True;
  BConferma.Enabled:=False;
  BAnnulla.Enabled:=False;
  Panel1.Enabled:=True;
end;

procedure TA054FCicliTurni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
    if not A054FCicliTurniDtM1.A054MW.Q611.ReadOnly then
      Action:=caNone;
end;

procedure TA054FCicliTurni.DBGrid1CellClick(Column: TColumn);
var
  IOrario, ITurno:Integer;
begin
  inherited;
  if R180In(Column.Index,[R180GetColonnaDBGrid(DBGrid1,'TURNO1'),R180GetColonnaDBGrid(DBGrid1,'TURNO2')]) then
    with A054FCicliTurniDtm1 do
    begin
      IOrario:=R180GetColonnaDBGrid(DBGrid1,Column.FieldName);
      DBGrid1.Columns[IOrario].PickList.Clear;
      ITurno:=1;
      if A054MW.Q021.SearchRecord('CODICE',A054MW.Q611.FieldByName('ORARIO').AsString,[srFromBeginning]) then
      begin
        DBGrid1.Columns[IOrario].PickList.Add('M - Solo orario');
        DBGrid1.Columns[IOrario].PickList.Add('A - Assenza');
        DBGrid1.Columns[IOrario].PickList.Add('0 - Riposo');
        repeat
          DBGrid1.Columns[IOrario].PickList.Add(IntToStr(ITurno));
          inc(ITurno);
        until Not A054MW.Q021.SearchRecord('CODICE',A054MW.Q611.FieldByName('ORARIO').AsString,[]);
      end;
    end;
end;

procedure TA054FCicliTurni.DBGrid1EditButtonClick(Sender: TObject);
{Richiamo l'elenco degli orari o delle assenze}
begin
  if (SolaLettura) or (A054FCicliTurniDtM1.A054MW.Q611.ReadOnly) then exit;
  with A054FCicliTurniDtM1 do
    begin
    C011FDBList:=TC011FDBList.Create(nil);
    C011FDBList.Chiave:=DbGrid1.SelectedField.Text;
    try
      if DbGrid1.SelectedField = A054MW.Q611ORARIO then
        begin
        C011FDBList.DataSource1.DataSet:=A054MW.Q020;
        C011FDBList.Caption:='Elenco Orari';
        end
      else
        begin
        C011FDBList.DataSource1.DataSet:=A054MW.Q265;
        C011FDBList.Caption:='Elenco Assenze';
        end;
      if (C011FDBList.ShowModal = mrOK) then
      begin
        if A054MW.Q611.State = dsBrowse then
          A054MW.Q611.Edit;
        DbGrid1.SelectedField.AsString:=C011FDBList.DataSource1.DataSet.FieldByName('Codice').AsString;
      end;
    finally
      C011FDBList.Release;
    end;
    end;
end;

procedure TA054FCicliTurni.Nuovoelemento1Click(Sender: TObject);
begin
  if DbGrid1.SelectedField = A054FCicliTurniDtM1.A054MW.Q611ORARIO then
  begin
    OpenA006ModelliOrario(A054FCicliTurniDtM1.A054MW.Q611ORARIO.AsString);
    A054FCicliTurniDtM1.A054MW.Q020.Refresh;
    A054FCicliTurniDtM1.A054MW.Q021.Refresh; // daniloc. 09.07.2010
  end
  else
  begin
    OpenA016CausAssenze(A054FCicliTurniDtM1.A054MW.Q611CAUSALE.AsString);
    A054FCicliTurniDtM1.A054MW.Q265.Refresh;
  end;
end;

procedure TA054FCicliTurni.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid1.ReadOnly:=SolaLettura;
end;

end.
