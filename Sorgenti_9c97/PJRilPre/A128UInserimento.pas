unit A128UInserimento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,Db, DBCtrls, Mask, ExtCtrls, Menus, checklst, StrUtils,
  C180FunzioniGenerali, RegistrazioneLog, C005UDatiAnagrafici, OracleData,
  C700USelezioneAnagrafe, A000UInterfaccia, A127UTurniPrestazioniAggiuntive, Variants;

type
  TA128FInserimento = class(TForm)
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
    btnElimina: TBitBtn;
    dCmbMatricola: TDBLookupComboBox;
    dCmbBadge: TDBLookupComboBox;
    lblPartTime: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dCmbMatricolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnOKClick(Sender: TObject);
    procedure DBLookupProgressivoCloseUp(Sender: TObject);
    procedure DBLookupProgressivoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Datianagrafici1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
  private
    { Private declarations }
    procedure AggiornaParametri(Sender: TObject);
    procedure Pulisci;
  public
    { Public declarations }
  end;

var
  A128FInserimento: TA128FInserimento;

implementation

uses A128UPianPrestazioniAggiuntive,A128UPianPrestazioniAggiuntiveDtm;

{$R *.DFM}

procedure TA128FInserimento.FormShow(Sender: TObject);
var i,m,a,g:Word;
    D:TDatetime;
begin
  DBLookupProgressivo.ListSource:=C700SrcAnagrafe;
  dCmbBadge.ListSource:=C700SrcAnagrafe;
  dCmbMatricola.ListSource:=C700SrcAnagrafe;
  C700SelAnagrafe.FieldByName('MATRICOLA').DisplayWidth:=12;
  C700SelAnagrafe.FieldByName('CHR_BADGE').DisplayWidth:=12;
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
  begin
    DbLookupTurno1.DataSource:=dsrParametri;
    DbLookupTurno2.DataSource:=dsrParametri;
    DbLookupTurno1.ListSource:=D330;
    DbLookupTurno2.ListSource:=D330;
  end;
  DbLookupTurno1.KeyValue:='';
  DbLookupTurno2.KeyValue:='';
  // caricamento lista giorni
  CheckListBox1.Items.Clear;
  if A128FPianPrestazioniAggiuntiveDtm.selT332.RecordCount > 0 then
    D:=A128FPianPrestazioniAggiuntiveDtm.selT332.FieldByName('DATA').AsDateTime
  else
    D:=A128FPianPrestazioniAggiuntiveDtm.A128MW.DataInizio;
  DecodeDate(D,a,m,g);
  for i:=1 to R180GiorniMese(D) do
    CheckListBox1.Items.Add(FormatDateTime('ddd dd/mm/yyyy',EncodeDate(a,m,i)));
  // pulizia campi anagrafici
  Pulisci;
end;

procedure TA128FInserimento.Pulisci;
begin
  dCmbBadge.KeyValue:=Null;
  dCmbMatricola.KeyValue:=Null;
  DBLookupProgressivo.KeyValue:=Null;
  LContratto.Caption:='Contratto: ';
  lblPartTime.Caption:='Part-time: ';
end;

procedure TA128FInserimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dCmbMatricola.ListSource:=nil;
  DBLookupProgressivo.ListSource:=nil;
  dCmbBadge.ListSource:=nil;
  if A128FPianPrestazioniAggiuntiveDtM.A128MW.cdsParametri.State in [dsEdit,dsInsert] then
    A128FPianPrestazioniAggiuntiveDtM.A128MW.cdsParametri.Cancel;
end;

procedure TA128FInserimento.BtnOKClick(Sender: TObject);
var i:Integer;
begin
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
    try
      Screen.Cursor:=crHourGlass;
      Dipendente:=dbLookupProgressivo.Text;
      ListaGiorniSel.Clear;
      for i:=0 to CheckListBox1.Items.Count - 1 do
        if CheckListBox1.Checked[i] then
          ListaGiorniSel.Append(CheckListBox1.Items[i]);
      Turno1Value:=DBLookUpTurno1.KeyValue;
      Turno2Value:=DBLookUpTurno2.KeyValue;
      InserisciGestioneMensile;
    finally
      RefreshSelT332;
      Screen.Cursor:=crDefault;
    end;
end;

procedure TA128FInserimento.btnEliminaClick(Sender: TObject);
var i:Integer;
begin
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
    try
      Screen.Cursor:=crHourGlass;
      Dipendente:=dbLookupProgressivo.Text;
      ListaGiorniSel.Clear;
      for i:=0 to CheckListBox1.Items.Count - 1 do
        if CheckListBox1.Checked[i] then
          ListaGiorniSel.Append(CheckListBox1.Items[i]);
      Turno1Value:=DBLookUpTurno1.KeyValue;
      Turno2Value:=DBLookUpTurno2.KeyValue;
      CancellaGestioneMensile;
    finally
      Screen.Cursor:=crDefault;
    end;
end;

procedure TA128FInserimento.DBLookupProgressivoCloseUp(Sender: TObject);
begin
  if (Sender as TDBLookupComboBox).Text = '' then
    Pulisci
  else
    AggiornaParametri(Sender);
end;

procedure TA128FInserimento.DBLookupProgressivoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
    Pulisci
  else
    AggiornaParametri(Sender);
end;

procedure TA128FInserimento.dCmbMatricolaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA128FInserimento.AggiornaParametri(Sender: TObject);
begin
  DBLooKUpProgressivo.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  dCmbBadge.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  dCmbMatricola.KeyValue:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
  begin
    CercaContratto(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,R180FineMese(EncodeDate(A128FPianPrestazioniAggiuntive.EAnno.Value,A128FPianPrestazioniAggiuntive.EMese.Value,1)));
    LContratto.Caption:='Contratto: ' + Q430Contratto.FieldByName('Contratto').AsString + ' ' + Q430Contratto.FieldByName('Descrizione').AsString;
    lblPartTime.Caption:='Part-time: ' + IfThen(Q430Contratto.FieldByName('PERCPT').AsFloat = 100,'Tempo pieno',Q430Contratto.FieldByName('PERCPT').AsString + '%');
  end;
end;

procedure TA128FInserimento.Nuovoelemento1Click(Sender: TObject);
{Gestione delle regole del turno di prestazioni aggiuntive}
begin
  OpenA127TurniPrestazioniAggiuntive((PopUpMenu1.PopupComponent as TDBLookupComboBox).Text);
  with A128FPianPrestazioniAggiuntiveDtm.A128MW.Q330 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

procedure TA128FInserimento.Datianagrafici1Click(Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  try
    C005FDatiAnagrafici.ShowDipendente(C700Progressivo);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA128FInserimento.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i]:=Sender = Selezionatutto1;
end;

end.
