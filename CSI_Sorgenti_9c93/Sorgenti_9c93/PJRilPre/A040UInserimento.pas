unit A040UInserimento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Buttons, Db, DBCtrls, Mask, ExtCtrls, Menus, checklst, Variants, StrUtils, OracleData,
  A000UInterfaccia, A000UMessaggi, A039URegReperib, A083UMsgElaborazioni,
  C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe, RegistrazioneLog;

type
  TA040FInserimento = class(TForm)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Panel2: TPanel;
    BtnOK: TBitBtn;
    BtnAnnulla: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    LContratto: TLabel;
    DBLookupProgressivo: TDBLookupComboBox;
    DBLookupTurno1: TDBLookupComboBox;
    DBLookupTurno2: TDBLookupComboBox;
    CheckListBox1: TCheckListBox;
    PopupMenu3: TPopupMenu;
    Datianagrafici1: TMenuItem;
    Label4: TLabel;
    PopupMenu2: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    dCmbDatoLibero: TDBLookupComboBox;
    lblDatoLibero: TLabel;
    btnElimina: TBitBtn;
    dCmbMatricola: TDBLookupComboBox;
    dCmbBadge: TDBLookupComboBox;
    DBLookupTurno3: TDBLookupComboBox;
    Label6: TLabel;
    chkTuttiDip: TCheckBox;
    btnAnomalie: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure DBLookupProgressivoCloseUp(Sender: TObject);
    procedure DBLookupProgressivoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbMatricolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Datianagrafici1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure chkTuttiDipClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pulisci;
    procedure AggiornaParametri(Sender: TObject);
  public
    { Public declarations }
  end;

var
  A040FInserimento: TA040FInserimento;

implementation

uses A040UPianifRep,A040UPianifRepDtM1;

{$R *.DFM}

procedure TA040FInserimento.FormShow(Sender: TObject);
var i,m,a,g:Word;
    D:TDatetime;
    cDL:Integer;
begin
  DBLookupProgressivo.ListSource:=C700SrcAnagrafe;
  dCmbBadge.ListSource:=C700SrcAnagrafe;
  dCmbMatricola.ListSource:=C700SrcAnagrafe;
  C700SelAnagrafe.FieldByName('MATRICOLA').DisplayWidth:=12;
  C700SelAnagrafe.FieldByName('CHR_BADGE').DisplayWidth:=12;
  with A040FPianifRepDtM1.A040MW do
  begin
    DBLookupTurno1.DataSource:=dsrParametri;
    DBLookupTurno2.DataSource:=dsrParametri;
    DBLookupTurno3.DataSource:=dsrParametri;
    dCmbDatoLibero.DataSource:=dsrParametri;
    DBLookupTurno1.ListSource:=D350;
    DBLookupTurno2.ListSource:=D350;
    DBLookupTurno3.ListSource:=D350;
    dCmbDatoLibero.ListSource:=dsrDatoLibero;
  end;
  DbLookupTurno1.KeyValue:='';
  DbLookupTurno2.KeyValue:='';
  DbLookupTurno3.KeyValue:='';
  cDL:=R180GetColonnaDBGrid(A040FPianifRep.dGrdPianif,'DATOLIBERO');
  dCmbDatoLibero.Enabled:=A040FPianifRep.dGrdPianif.Columns[cDL].Visible;
  if dCmbDatoLibero.Enabled then
    dCmbDatoLibero.KeyValue:='';
  lblDatoLibero.Visible:=dCmbDatoLibero.Enabled;
  if lblDatoLibero.Visible then
    lblDatoLibero.Caption:=A040FPianifRepDtM1.selT380.FieldByName('DATOLIBERO').DisplayLabel;
  // caricamento lista giorni
  CheckListBox1.Items.Clear;
  if A040FPianifRepDtM1.selT380.RecordCount > 0 then
    D:=A040FPianifRepDtM1.selT380.FieldByName('DATA').AsDateTime
  else
    D:=EncodeDate(A040FPianifRep.EAnno.Value,A040FPianifRep.EMese.Value,1);
  DecodeDate(D,a,m,g);
  for i:=1 to R180GiorniMese(D) do
    CheckListBox1.Items.Add(FormatDateTime('ddd dd/mm/yyyy',EncodeDate(a,m,i)));
  // pulizia campi anagrafici
  Pulisci;
  btnAnomalie.Enabled:=False;
  chkTuttiDip.SetFocus;
end;

procedure TA040FInserimento.Pulisci;
begin
  dCmbBadge.KeyValue:=Null;
  dCmbMatricola.KeyValue:=Null;
  DBLookupProgressivo.KeyValue:=Null;
  LContratto.Caption:='Contratto: ';
end;

procedure TA040FInserimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dCmbMatricola.ListSource:=nil;
  DBLookupProgressivo.ListSource:=nil;
  dCmbBadge.ListSource:=nil;
  if A040FPianifRepDtM1.A040MW.cdsParametri.State in [dsEdit,dsInsert] then
    A040FPianifRepDtM1.A040MW.cdsParametri.Cancel;
end;

procedure TA040FInserimento.chkTuttiDipClick(Sender: TObject);
begin
  Label4.Enabled:=not chkTuttiDip.Checked;
  dcmbMatricola.Enabled:=not chkTuttiDip.Checked;
  Label5.Enabled:=not chkTuttiDip.Checked;
  dcmbBadge.Enabled:=not chkTuttiDip.Checked;
  Label1.Enabled:=not chkTuttiDip.Checked;
  DBLookupProgressivo.Enabled:=not chkTuttiDip.Checked;
  LContratto.Enabled:=not chkTuttiDip.Checked;
end;

procedure TA040FInserimento.BtnOKClick(Sender: TObject);
var i,OldProg:Integer;
begin
  with A040FPianifRepDtM1.A040MW do
  begin
    btnAnomalie.Enabled:=False;
    DataControllo:=EncodeDate(A040FPianifRep.EAnno.Value,A040FPianifRep.EMese.Value,1);
    Turno1Value:=DBLookUpTurno1.KeyValue;
    Turno2Value:=DBLookUpTurno2.KeyValue;
    Turno3Value:=DBLookUpTurno3.KeyValue;
    DatoLiberoValue:=dCmbDatoLibero.KeyValue;
    NonContDipPian:=(chkTuttiDip.Checked and (C700SelAnagrafe.RecordCount > 1)) or A040FPianifRep.chkNonContDipPian.Checked;
    TuttiDip:=chkTuttiDip.Checked;
    AssenzaTuttiSi:=False;
    AssenzaTuttiNo:=False;
    ListaGiorniSel.Clear;
    for i:=0 to CheckListBox1.Items.Count - 1 do
      if CheckListBox1.Checked[i] then
        ListaGiorniSel.Append(CheckListBox1.Items[i]);
    Dipendente:=dbLookupProgressivo.Text;
    Controlli(IfThen(Sender = BtnOK,'I','C'));
    try
      ElaborazioneInterrotta:=False;
      Screen.Cursor:=crHourGlass;
      RegistraMsg.IniziaMessaggio('A040');
      if chkTuttiDip.Checked then
      begin
        OldProg:=-1;
        if Trim(Dipendente) <> '' then
          OldProg:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        C700SelAnagrafe.First;
      end;
      while not C700SelAnagrafe.Eof do
      begin
        if chkTuttiDip.Checked then
          AggiornaParametri(nil);
        TestoAnomalia:='';
        if ControlliInd then
        begin
          if Sender = BtnOK then
            InserisciGestioneMensile
          else
            CancellaGestioneMensile;
        end;
        if ElaborazioneInterrotta then
          abort;
        if chkTuttiDip.Checked then
          C700SelAnagrafe.Next
        else
          Break;
      end;
    finally
      if chkTuttiDip.Checked then
        C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
      AggiornaParametri(nil);
      RefreshT380;
      Screen.Cursor:=crDefault;
      btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoI;
      ShowMessage(IfThen(btnAnomalie.Enabled,IfThen(RegistraMsg.ContieneTipoA,A000MSG_MSG_ELABORAZIONE_ANOMALIE,A000MSG_MSG_ELABORAZIONE_SEGNALAZIONI),A000MSG_MSG_ELABORAZIONE_TERMINATA));
    end;
  end;
end;

procedure TA040FInserimento.DBLookupProgressivoCloseUp(Sender: TObject);
begin
  if (Sender as TDBLookupComboBox).Text = '' then
    Pulisci
  else
    AggiornaParametri(Sender);
end;

procedure TA040FInserimento.DBLookupProgressivoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
    Pulisci
  else
    AggiornaParametri(Sender);
end;

procedure TA040FInserimento.dCmbMatricolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA040FInserimento.AggiornaParametri(Sender: TObject);
begin
  DBLooKUpProgressivo.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  dCmbBadge.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  dCmbMatricola.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  with A040FPianifRepDtM1.A040MW do
  begin
    CercaContratto(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,R180FineMese(EncodeDate(A040FPianifRep.EAnno.Value,A040FPianifRep.EMese.Value,1)));
    LContratto.Caption:='Contratto: ' + Q430Contratto.FieldByName('Contratto').AsString + ' ' + Q430Contratto.FieldByName('Descrizione').AsString;
  end;
end;

procedure TA040FInserimento.Nuovoelemento1Click(Sender: TObject);
{Gestione delle regole di reperibilità}
begin
  OpenA039RegReperib((PopUpMenu1.PopupComponent as TDBLookupComboBox).Text);
  with A040FPianifRepDtM1.A040MW.Q350 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA040FInserimento.Datianagrafici1Click(Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  try
    C005FDatiAnagrafici.ShowDipendente(C700Progressivo);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA040FInserimento.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TA040FInserimento.btnAnomalieClick(Sender: TObject);
begin
  A040FPianifRep.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A040','');
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  C700Creazione(SessioneOracle);
  A040FPianifRep.frmSelAnagrafe.SelezionePeriodica:=True;
  A040FPianifRep.frmSelAnagrafe.RipristinaC00SelAnagrafe;
  A040FPianifRepDtM1.A040MW.selT380.Close;
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  A040FPianifRepDtM1.A040MW.ImpostaCampiLookup;
  A040FPianifRepDtM1.A040MW.selT380.Open;
  DBLookupProgressivo.ListSource:=C700SrcAnagrafe;
  dCmbBadge.ListSource:=C700SrcAnagrafe;
  dCmbMatricola.ListSource:=C700SrcAnagrafe;
  C700SelAnagrafe.FieldByName('MATRICOLA').DisplayWidth:=12;
  C700SelAnagrafe.FieldByName('CHR_BADGE').DisplayWidth:=12;
end;

end.
