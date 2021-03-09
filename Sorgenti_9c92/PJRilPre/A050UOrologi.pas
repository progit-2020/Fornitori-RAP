unit A050UOrologi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Menus, Buttons, ExtCtrls, ComCtrls, R001UGESTTAB,Mask, DBCtrls,
  ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants,
  A021UCausGiustif, L001Call, A031UParScarico;

type
  TA050FOrologi = class(TR001FGestTab)
    Panel2: TPanel;
    DBECodice: TDBEdit;
    DBEDescr: TDBEdit;
    DBRGFunzione: TDBRadioGroup;
    LCodice: TLabel;
    LDescrizione: TLabel;
    Label1: TLabel;
    ECausale: TDBLookupComboBox;
    DBRadioGroup1: TDBRadioGroup;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    dEdtPostazione: TDBEdit;
    Label3: TLabel;
    dEdtIndirizzoTerm: TDBEdit;
    Label4: TLabel;
    dEdtIndirizzoIP: TDBEdit;
    dChkRicezione: TDBCheckBox;
    dchkApplicaPercorrenza: TDBCheckBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dedtIndirizzo: TDBEdit;
    lblIndirizzo: TLabel;
    drgpTipoLocalita: TDBRadioGroup;
    lblDLocalita: TLabel;
    dcmbDLocalita: TDBLookupComboBox;
    dedtCodLocalita: TDBEdit;
    lblCodLocalita: TLabel;
    dedtRilevatore: TDBEdit;
    Label5: TLabel;
    dcmbScarico: TDBLookupComboBox;
    Label6: TLabel;
    procedure ECausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBRGFunzioneChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure drgpTipoLocalitaChange(Sender: TObject);
    procedure dcmbDLocalitaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dedtRilevatoreChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A050FOrologi: TA050FOrologi;

procedure OpenA050Orologi(Cod:String);

implementation

uses A050UOrologiDtM1;

{$R *.DFM}

procedure OpenA050Orologi(Cod:String);
{Gestione orologi di presenza e di mensa}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA050Orologi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A050FOrologi:=TA050FOrologi.Create(nil);
  with A050FOrologi do
  try
    //A050FOrologiDtM1:=TA050FOrologiDtM1.Create(nil);
    Application.CreateForm(TA050FOrologiDtM1,A050FOrologiDtM1);
    A050FOrologiDtM1.Q361.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A050FOrologiDtM1.Free;
    Release;
  end;
end;

procedure TA050FOrologi.DBRGFunzioneChange(Sender: TObject);
begin
  Label1.Enabled:=DBRGFunzione.ItemIndex = 2;
  ECausale.Enabled:=DBRGFunzione.ItemIndex = 2;
  dchkApplicaPercorrenza.Enabled:=DBRGFunzione.ItemIndex in [0,2];
  if (DBRGFunzione.ItemIndex <> 2) and (DButton.State in [dsEdit,dsInsert]) then
    ECausale.Field.Clear;
end;

procedure TA050FOrologi.Nuovoelemento1Click(Sender: TObject);
var
  Griglia:TInserisciDLL;
  i:integer;
begin
  if PopupMenu1.PopupComponent = ECausale then
  begin
    OpenA021CausGiustif(ECausale.Text);
    A050FOrologiDtM1.Q305.Refresh;
  end
  else if PopupMenu1.PopupComponent = dcmbDLocalita then
  begin
    if A050FOrologiDtM1.Q361.FieldByName('TIPO_LOCALITA').AsString = 'P' then
      with A050FOrologiDtM1.SelLocalita do
      begin
        Griglia.NomeTabella:='M042_LOCALITA';
        Griglia.Titolo:='Località trasferta';
        for i:=0 to FieldCount -1 do
        begin
          Griglia.Display[i]:=Fields[i].DisplayLabel;
          Griglia.Size[i]:=Fields[i].DisplayWidth;
        end;
        Inserisci(Griglia,dcmbDLocalita.Text);
        Refresh;
      end;
  end
  else if PopupMenu1.PopupComponent = dcmbScarico then
  begin
    OpenA031ParScarico(dcmbScarico.Text);
    A050FOrologiDtM1.selI100.Refresh;
  end
end;

procedure TA050FOrologi.dcmbDLocalitaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      begin
        (Sender as TDBLookupComboBox).Field.Clear;
        if ((Sender as TDBLookupComboBox).Field.FieldKind = fkLookup) and (Pos(';',(Sender as TDBLookupComboBox).Field.KeyFields) = 0) then
        begin
          (Sender as TDBLookupComboBox).Field.Dataset.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
          (Sender as TDBLookupComboBox).Field.FocusControl;
        end
        else
          (Sender as TDBLookupComboBox).Field.Clear;
      end;
  end;
end;

procedure TA050FOrologi.dedtRilevatoreChange(Sender: TObject);
begin
  inherited;
  dcmbScarico.Enabled:=Trim(dedtRilevatore.Text) <> '';
  if (not dcmbScarico.Enabled) and (DButton.State in [dsEdit,dsInsert]) then
    DButton.Dataset.FieldByName('SCARICO').AsString:='';
end;

procedure TA050FOrologi.drgpTipoLocalitaChange(Sender: TObject);
begin
  inherited;
  with A050FOrologiDtM1 do
  begin
    //Ripulisco tutti i campi
    if DButton.state in [dsInsert,dsEdit] then
    begin
      dCmbDLocalita.KeyValue:='';
      dEdtCodLocalita.Field.Clear;
    end;
    SelLocalita.Close;
    if drgpTipoLocalita.ItemIndex = 0 then
    begin
      SelLocalita.SQL.Text:='SELECT CODICE, CITTA DESCRIZIONE FROM T480_COMUNI ORDER BY CITTA';
      lblCodLocalita.Caption:='Codice Istat';
      dCmbDLocalita.PopupMenu:=nil;
    end
    else if drgpTipoLocalita.ItemIndex = 1 then
    begin
      SelLocalita.SQL.Text:='SELECT CODICE, DESCRIZIONE FROM M042_LOCALITA ORDER BY DESCRIZIONE';
      lblCodLocalita.Caption:='Codice';
      dCmbDLocalita.PopupMenu:=PopupMenu1;
    end;
    SelLocalita.Open;
  end;
end;

procedure TA050FOrologi.ECausaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

end.
