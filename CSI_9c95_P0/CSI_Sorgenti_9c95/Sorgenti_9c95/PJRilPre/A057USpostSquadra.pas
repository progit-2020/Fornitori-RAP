unit A057USpostSquadra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia,
  A000UMessaggi, Spin, DBCtrls, Menus, Grids, DBGrids, SelAnagrafe,
  ComCtrls, C005UDatiAnagrafici, A003UDataLavoroBis, A006UModelliOrario, A053USquadre, Variants;

type
  TA057FSpostSquadra = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    EOrario: TDBLookupComboBox;
    Label6: TLabel;
    DBText1: TDBText;
    BInserimento: TBitBtn;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Cancella1: TMenuItem;
    Nuovoelemento1: TMenuItem;
    Label5: TLabel;
    DBText2: TDBText;
    ESquadra: TDBLookupComboBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    cmbTurno1: TComboBox;
    lblTurno1: TLabel;
    lblTurno2: TLabel;
    cmbTurno2: TComboBox;
    procedure ESquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Cancella1Click(Sender: TObject);
    procedure BInserimentoClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
    Data:TDateTime;
  end;

var
  A057FSpostSquadra: TA057FSpostSquadra;

procedure OpenA057SpostSquadra(Prog:LongInt);

implementation

uses A057USpostSquadraDtM1;

{$R *.DFM}

procedure OpenA057SpostSquadra(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA057SpostSquadra') of
    'N':
        begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A057FSpostSquadra:=TA057FSpostSquadra.Create(nil);
  with A057FSpostSquadra do
    try
      C700Progressivo:=Prog;
      A057FSpostSquadraDtM1:=TA057FSpostSquadraDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A057FSpostSquadraDtM1.Free;
      Free;
    end;
end;

procedure TA057FSpostSquadra.FormCreate(Sender: TObject);
begin
  Data:=Parametri.DataLavoro;
  Label3.Caption:=FormatDateTime('dd mmmm yyyy',Data);
end;

procedure TA057FSpostSquadra.FormShow(Sender: TObject);
begin
  ESquadra.KeyValue:=A057FSpostSquadraDtM1.Q600.FieldByName('Codice').AsString;
  EOrario.KeyValue:=A057FSpostSquadraDtM1.Q020.FieldByName('Codice').AsString;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,True);
end;

procedure TA057FSpostSquadra.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  with A057FSpostSquadraDtM1.Q630 do
  begin
    Close;
    SetVariable('Progressivo',C700Progressivo);
    Open;
  end;
end;

procedure TA057FSpostSquadra.BitBtn1Click(Sender: TObject);
begin
  Data:=DataOut(Data,'Giorno di spostamento squadra','G');
  Label3.Caption:=FormatDateTime('dd mmmm yyyy',Data);
end;

procedure TA057FSpostSquadra.Cancella1Click(Sender: TObject);
{Cancello lo spostamento specificata sulla griglia}
begin
  with A057FSpostSquadraDtM1 do
    if Q630.RecordCount > 0 then
      if MessageDlg(A000MSG_A057_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin
        Q630.ReadOnly:=False;
        Q630.Delete;
        SessioneOracle.ApplyUpdates([Q630],True);
        SessioneOracle.Commit;
        Q630.ReadOnly:=True;
        Q630.Close;
        Q630.Open;
      end;
end;

procedure TA057FSpostSquadra.BInserimentoClick(Sender: TObject);
{Inserisco lo spostamento specificato cancellando eventualmente quello già esistente
 nella stessa data}
begin
  if Trim(ESquadra.Text) = '' then
    raise Exception.Create(A000MSG_A057_ERR_SQUADRA_NON_SPECIFICATA);
  if Trim(EOrario.Text) = '' then
    raise Exception.Create(A000MSG_A057_ERR_ORARIO_NON_SPECIF);
  if (cmbTurno1.Text <> '') and (cmbTurno1.Text = cmbTurno2.Text) then
    //Non permetto i due turni uguali
    raise Exception.Create(A000MSG_A057_ERR_PIANIF_TURNO_DOPPIO);
  if (cmbTurno1.Text = '') and (cmbTurno2.Text <> '') then
    //Non permetto di pianificare il secondo turno senza aver pianificato il primo
    raise Exception.Create(A000MSG_A057_ERR_PIANIF_SEC_TURNO);
  if (cmbTurno1.Text <> '') and ((cmbTurno1.Text <= '0') or (cmbTurno1.Text > '99')) then
    //I turni devono essere compresi tra 1 e 99
    raise Exception.Create(A000MSG_A057_ERR_TURNO);
  if (cmbTurno2.Text <> '') and ((cmbTurno2.Text <= '0') or (cmbTurno2.Text > '99')) then
    //I turni devono essere compresi tra 1 e 99
    raise Exception.Create(A000MSG_A057_ERR_TURNO);
  if cmbTurno1.Text <> '' then
    cmbTurno1.Text:=IntToStr(StrToInt(cmbTurno1.Text));
  if cmbTurno2.Text <> '' then
    cmbTurno2.Text:=IntToStr(StrToInt(cmbTurno2.Text));
  with A057FSpostSquadraDtM1 do
  begin
    Q630.ReadOnly:=False;
    if Q630.Locate('Progressivo;Data;Squadra',VarArrayOf([C700Progressivo,Data,ESquadra.Text]),[]) then
      Q630.Delete;
    Q630.AppendRecord([C700Progressivo,Data,ESquadra.Text,EOrario.Text,cmbTurno1.Text,cmbTurno2.Text]);
    try
      SessioneOracle.ApplyUpdates([Q630],True);
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      raise;
    end;
    Q630.ReadOnly:=True;
    Q630.Close;
    Q630.Open;
  end;
end;

procedure TA057FSpostSquadra.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione orari e squadre}
begin
  if PopupMenu2.PopupComponent = EOrario then
  begin
    OpenA006ModelliOrario(EOrario.Text);
    A057FSpostSquadraDtM1.Q020.DisableControls;
    A057FSpostSquadraDtM1.Q020.Refresh;
    A057FSpostSquadraDtM1.Q020.EnableControls;
  end
  else
  begin
    OpenA053Squadre(ESquadra.Text);
    A057FSpostSquadraDtM1.Q600.DisableControls;
    A057FSpostSquadraDtM1.Q600.Refresh;
    A057FSpostSquadraDtM1.Q600.EnableControls;
  end;
end;

procedure TA057FSpostSquadra.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Data;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA057FSpostSquadra.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Data;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA057FSpostSquadra.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA057FSpostSquadra.ESquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
