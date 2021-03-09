unit A111UParMessaggi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione, A000UInterfaccia, R001UGESTTAB, StdCtrls, ExtCtrls, ActnList, ImgList, Db, Menus, ComCtrls,
  ToolWin, DBCtrls, Buttons, Mask, Grids, DBGrids, Spin, SelAnagrafe, OracleData, Variants,
  A062UQueryServizio, C700USelezioneAnagrafe, System.Actions, A000UMessaggi;

type
  TA111FParMessaggi = class(TR001FGestTab)
    Panel2: TPanel;
    GpbTracciato: TGroupBox;
    dEdtCodice: TDBEdit;
    dEdtDescrizione: TDBEdit;
    dRgpTipoSupporto: TDBRadioGroup;
    dEdtNome: TDBEdit;
    sbtNomeFile: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dGrdTracciato: TDBGrid;
    SaveDialog1: TSaveDialog;
    dCmbFormatoData: TDBComboBox;
    lblProva: TLabel;
    dChkDefault: TDBCheckBox;
    edtNumeroRipetiz: TSpinEdit;
    edtNumeroGiorniValid: TSpinEdit;
    edtMesiIndietro: TSpinEdit;
    lblNumeroRipetiz: TLabel;
    lblNumeroGiorniValid: TLabel;
    lblMesiIndietro: TLabel;
    lblFiltroAnagr: TLabel;
    dCmbFiltroAnagr: TDBLookupComboBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrpTipoFiltro: TDBRadioGroup;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    drgpTipoRegistrazione: TDBRadioGroup;
    drgpRegistraMessaggi: TDBRadioGroup;
    lblValiditaDati: TLabel;
    edtValiditaDati: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dRgpTipoSupportoChange(Sender: TObject);
    procedure sbtNomeFileClick(Sender: TObject);
    procedure dCmbFormatoDataChange(Sender: TObject);
    procedure dgrpTipoFiltroChange(Sender: TObject);
    procedure dCmbFiltroAnagrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A111FParMessaggi: TA111FParMessaggi;

procedure OpenA111ParMessaggi(Cod:String);

implementation

uses A111UParMessaggiDTM1;

{$R *.DFM}

procedure OpenA111ParMessaggi(Cod:String);
{Parametrizzazione file seq.}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA111ParMessaggi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A111FParMessaggi:=TA111FParMessaggi.Create(nil);
  with A111FParMessaggi do
  try
    A111FParMessaggiDtM1:=TA111FParMessaggiDtM1.Create(nil);
    A111FParMessaggiDtM1.selT291.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A111FParMessaggiDtM1.Free;
    Release;
  end;
end;

procedure TA111FParMessaggi.FormCreate(Sender: TObject);
begin
  inherited;
  R001LinkC700:=False;
end;

procedure TA111FParMessaggi.FormShow(Sender: TObject);
begin
  inherited;
  // Inizializzazione selezione anagrafica
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase + ',T430TERMINALI,T430PASSENZE';
  C700DataLavoro:=Parametri.DataLavoro;
  A111FParMessaggi.frmSelAnagrafe.CreaSelAnagrafe(A111FParMessaggiDtM1.A111MW,SessioneOracle,A111FParMessaggi.StatusBar,2,False);

  DButton.DataSet:=A111FParMessaggiDtM1.selT291;
  edtNumeroRipetiz.Enabled:=False;
  edtNumeroGiorniValid.Enabled:=False;
  edtMesiIndietro.Enabled:=False;
  edtValiditaDati.Enabled:=False;
  dGrdTracciato.DataSource:=A111FParMessaggiDTM1.A111MW.dsrT292;
  frmSelanagrafe.Visible:=False;
end;

procedure TA111FParMessaggi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  A111FParMessaggiDTM1.A111MW.selT003.Refresh;
end;

procedure TA111FParMessaggi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  edtNumeroRipetiz.Enabled:=DButton.State in [dsEdit,dsInsert];
  edtNumeroGiorniValid.Enabled:=DButton.State in [dsEdit,dsInsert];
  edtMesiIndietro.Enabled:=DButton.State in [dsEdit,dsInsert];
  edtValiditaDati.Enabled:=DButton.State in [dsEdit,dsInsert];
  NuovoElemento1.Visible:=(DButton.State in [dsEdit,dsInsert]);
  dCmbFiltroAnagr.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA111FParMessaggi.dRgpTipoSupportoChange(Sender: TObject);
// scelta tipo file A-O
begin
  inherited;
  sbtNomeFile.Enabled:=dRgpTipoSupporto.ItemIndex = 0;
  dGrdTracciato.Columns[4].Visible:=dRgpTipoSupporto.ItemIndex = 0;
  dGrdTracciato.Columns[5].Visible:=dRgpTipoSupporto.ItemIndex = 1;
end;

procedure TA111FParMessaggi.sbtNomeFileClick(Sender: TObject);
begin
  inherited;
  with A111FParMessaggiDtM1 do
  begin
    if (selT291.CachedUpDates)and(selT291.State in [dsEdit,dsInsert]) then
    begin
      SaveDialog1.Title:='Scelta nome file di scarico';
      if not(selT291Nome_File.IsNull) then
        SaveDialog1.FileName:=selT291Nome_File.Value;
      if SaveDialog1.Execute then
        selT291Nome_File.Value:=SaveDialog1.FileName;
    end;
  end;
end;

procedure TA111FParMessaggi.dCmbFormatoDataChange(Sender: TObject);
// formattazione data da accodare al nome file
begin
  inherited;
  if dCmbFormatoData.Text = '' then
    LblProva.Caption:=''
  else
    LblProva.Caption:=FormatDateTime(dCmbFormatoData.Text,Now);
end;

procedure TA111FParMessaggi.dgrpTipoFiltroChange(Sender: TObject);
begin
  if dgrpTipoFiltro.ItemIndex = 0 then
  begin
    dCmbFiltroAnagr.ListSource:=A111FParMessaggiDtM1.A111MW.dsrT003;
    if DButton.State in [dsEdit,dsInsert] then
      dCmbFiltroAnagr.Field.Clear;
  end
  else
  begin
    dCmbFiltroAnagr.ListSource:=A111FParMessaggiDtM1.A111MW.dsrT002;
    if DButton.State in [dsEdit,dsInsert] then
      dCmbFiltroAnagr.Field.Clear;
  end;
end;

procedure TA111FParMessaggi.dCmbFiltroAnagrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA111FParMessaggi.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if dgrpTipoFiltro.ItemIndex = 1 then
  begin
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA062QueryServizio(dcmbFiltroAnagr.Text,'');
    C700DatiSelezionati:=C700CampiBase;
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe;
    A111FParMessaggiDtM1.A111MW.selT002.Refresh;
  end
  else
  begin
    C700FSelezioneAnagrafe.ApriSelezione(dcmbFiltroAnagr.Text);
    frmSelAnagrafe.btnSelezioneClick(Sender);
    A111FParMessaggiDTM1.A111MW.selT003.Refresh;
  end;
end;

end.
