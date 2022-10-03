unit A136URelazioniAnagrafe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Oracle, OracleData, Buttons, ExtCtrls, Grids, DBGrids,
  C015UElencoValori, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TA136FRelazioniAnagrafe = class(TR004FGestStorico)
    dgrdRelazioni: TDBGrid;
    Splitter1: TSplitter;
    memRelazione: TMemo;
    pnlBottom: TPanel;
    btnComponiRelazione: TButton;
    btnVerificaSQL: TButton;
    btnInserisciTag: TButton;
    pnlTitoloRelazione: TPanel;
    btnStampaRelazioni: TButton;
    lblCampo1NonEsistente: TLabel;
    lblCampo2NonEsistente: TLabel;
    procedure dgrdRelazioniEditButtonClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnComponiRelazioneClick(Sender: TObject);
    procedure btnVerificaSQLClick(Sender: TObject);
    procedure btnInserisciTagClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStampaRelazioniClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    RichiamoEsterno: Boolean;
  public
    { Public declarations }
    ValoreDato: String;
    procedure AbilitaComponenti;
    procedure ImpostaMsgWarning (Tipo:String; Campo:String); //Richiamata dal MW per impsotare etichette di warning
  end;

var
  A136FRelazioniAnagrafe: TA136FRelazioniAnagrafe;

procedure OpenA136FRelazioniAnagrafe(Tabella,Colonna,Valore:String;Data:TDateTime);

implementation

uses
  A136URelazioniAnagrafeDtm, A136UComposizioneRelazione, A136UStampaRelazioni;

{$R *.dfm}

procedure OpenA136FRelazioniAnagrafe(Tabella,Colonna,Valore:String;Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA136FRelazioniAnagrafe') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA136FRelazioniAnagrafe, A136FRelazioniAnagrafe);
  Application.CreateForm(TA136FRelazioniAnagrafeDtm, A136FRelazioniAnagrafeDtm);
  try
    Screen.Cursor:=crDefault;
    if (Tabella <> '') and (Colonna <> '') then
    begin
      A136FRelazioniAnagrafe.RichiamoEsterno:=True;
      if A136FRelazioniAnagrafeDtm.selI030.SearchRecord('TABELLA;COLONNA',VarArrayOf([Tabella,Colonna]),[srFromEnd])then
      repeat
        if  (Data >= A136FRelazioniAnagrafeDtm.selI030.FieldByName('DECORRENZA').AsDateTime)
        and (Data <= A136FRelazioniAnagrafeDtm.selI030.FieldByName('DECORRENZA_FINE').AsDateTime) then
          Break;
      until not A136FRelazioniAnagrafeDtm.selI030.SearchRecord('TABELLA;COLONNA',VarArrayOf([Tabella,Colonna]),[srBackward]);
      A136FRelazioniAnagrafe.ValoreDato:=Valore;
      if not SolaLettura and A136FRelazioniAnagrafe.actModifica.Enabled then
        A136FRelazioniAnagrafeDtm.selI030.Edit;
      A136FRelazioniAnagrafe.btnComponiRelazioneClick(nil);
    end;
    A136FRelazioniAnagrafe.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A136FRelazioniAnagrafe.Free;
    A136FRelazioniAnagrafeDtm.Free;
  end;
end;

procedure TA136FRelazioniAnagrafe.FormCreate(Sender: TObject);
begin
  inherited;
  Parametri.I035_ModificaAbbinamenti:='S';
  RichiamoEsterno:=False;
end;

procedure TA136FRelazioniAnagrafe.FormShow(Sender: TObject);
begin
  inherited;
  if not RichiamoEsterno then
    Visionecorrente1Click(nil);  //Visionecorrente.Checked:=True;
end;

procedure TA136FRelazioniAnagrafe.ImpostaMsgWarning(Tipo, Campo: String);
begin
  if Tipo = 'TABELLA' then
  begin
    lblCampo1NonEsistente.Caption:='';  //reset
    if Campo <> '' then
      lblCampo1NonEsistente.Caption:='Attenzione! Il dato ' + Campo + ' non esiste!';
  end
  else if Tipo = 'TAB_ORIGINE' then
  begin
    lblCampo2NonEsistente.Caption:='';  //reset
    if Campo <> '' then
      lblCampo2NonEsistente.Caption:='Attenzione! Il dato ' + Campo + ' non esiste!';
  end;
end;

procedure TA136FRelazioniAnagrafe.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA136FRelazioniAnagrafe.AbilitaComponenti;
var
  CamAbi:Boolean;
  ColOri,MemRel:String;
begin
  CamAbi:=A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.VerificaCampiAbilitati(SolaLettura);
  ColOri:=Trim(A136FRelazioniAnagrafeDtm.selI030.FieldByName('COL_ORIGINE').AsString);
  MemRel:=memRelazione.Text;
  //
  actModifica.Enabled:=(not SolaLettura) and CamAbi and (DButton.State = dsBrowse);
  actCancella.Enabled:=(not SolaLettura) and CamAbi and (DButton.State = dsBrowse);
//Danilo 02/10/2008  btnComponiRelazione.Enabled:=(SolaLettura and CamAbi and (ColOri <> '')) or ((not SolaLettura) and (DButton.State <> dsBrowse) and CamAbi and ((ColOri <> '') or ((ColOri  = '') and (MemRel = ''))));
  btnComponiRelazione.Enabled:=(SolaLettura and (ColOri <> '')) or ((not SolaLettura) and (DButton.State <> dsBrowse) and ((ColOri <> '') or ((ColOri  = '') and (MemRel = '')))) or ((not SolaLettura) and (DButton.State = dsBrowse) and (not actModifica.Enabled));
  memRelazione.ReadOnly:=SolaLettura or ((not SolaLettura) and ((DButton.State = dsBrowse) or (not CamAbi)));
  btnInserisciTag.Enabled:=not (SolaLettura or ((not SolaLettura) and ((DButton.State = dsBrowse) or (not CamAbi))));
  btnVerificaSQL.Enabled:=not SolaLettura;
end;

procedure TA136FRelazioniAnagrafe.btnVerificaSQLClick(Sender: TObject);
begin
  ShowMessage(A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.VerificaSQLRelazione(memRelazione.Text));
end;

procedure TA136FRelazioniAnagrafe.btnComponiRelazioneClick(Sender: TObject);
begin
  A136FRelazioniAnagrafeDtM.selI030TIPO.OnValidate(A136FRelazioniAnagrafeDtM.selI030TIPO);
  if not Assigned(A136FComposizioneRelazione) then
    A136FComposizioneRelazione:=TA136FComposizioneRelazione.Create(nil);
  if A136FComposizioneRelazione.Apri then
  begin
    A136FComposizioneRelazione.ShowModal;
    if SolaLettura and A136FComposizioneRelazione.Confermato then
    begin
      A136FRelazioniAnagrafeDtM.selI030.ReadOnly:=False;
      A136FRelazioniAnagrafeDtM.selI030.Edit;
      A136FRelazioniAnagrafeDtM.selI030.Post;
      A136FRelazioniAnagrafeDtM.selI030.ReadOnly:=True;
    end;
  end;
  FreeAndNil(A136FComposizioneRelazione);
end;

procedure TA136FRelazioniAnagrafe.btnInserisciTagClick(Sender: TObject);
var S:String;
    i:Integer;
begin
  inherited;
  S:=memRelazione.Text;
  i:=memRelazione.SelStart + 1;
  Insert('<#>',S,i);
  memRelazione.Lines.BeginUpdate;
  memRelazione.Text:=S;
  memRelazione.Lines.EndUpdate;
  memRelazione.SetFocus;
  memRelazione.SelStart:=i - 1 + 3;
  memRelazione.SelLength:=0;
end;

procedure TA136FRelazioniAnagrafe.btnStampaRelazioniClick(Sender: TObject);
begin
  inherited;
  if not Assigned(A136FStampaRelazioni) then
    A136FStampaRelazioni:=TA136FStampaRelazioni.Create(nil);
  A136FStampaRelazioni.ShowModal;
  FreeAndNil(A136FStampaRelazioni);
end;

procedure TA136FRelazioniAnagrafe.dgrdRelazioniEditButtonClick(Sender: TObject);
var
  vCodice:Variant;
  SqlColonne:String;
begin
  inherited;
  with A136FRelazioniAnagrafeDtm do
  begin
    if (selI030.ReadOnly) or (selI030.State <> dsInsert) then
      exit;
    SqlColonne:=A136FRelazioniAnagrafeMW.selCols.SQL.Text;
    SqlColonne:=StringReplace(SqlColonne,':TABELLA',''''+selI030.FieldByName('TABELLA').AsString +'''',[rfReplaceAll]);
    OpenC015FElencoValori('COLS','<A136> Selezione della colonna pilotata',SqlColonne,'COLUMN_NAME',vCodice,nil,350);
    if not VarIsClear(vCodice) then
      selI030.FieldByName('COLONNA').asString:=VarToStr(vCodice[0]);
  end;
end;

end.
