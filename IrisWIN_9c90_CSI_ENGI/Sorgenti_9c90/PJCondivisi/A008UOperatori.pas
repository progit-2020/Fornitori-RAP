
unit A008UOperatori;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Menus, Buttons, ComCtrls,
  Mask, DB, Grids, DBGrids, A000UCostanti, A000USessione,A000UInterfaccia,
  ActnList, ImgList, ToolWin, OracleData, Variants, C180FunzioniGenerali,
  C600USelAnagrafe, System.Actions, System.StrUtils, System.Math,
  System.ImageList;

type
  TA008FOperatori = class(TR001FGestTab)
    Panel2: TPanel;
    grpProfili: TGroupBox;
    Label3: TLabel;
    dlckPermessi: TDBLookupComboBox;
    Label5: TLabel;
    dlckFiltroAnagrafe: TDBLookupComboBox;
    Label6: TLabel;
    dlckFiltroFunzioni: TDBLookupComboBox;
    Label7: TLabel;
    dlckFiltroDizionario: TDBLookupComboBox;
    PopupMenu1: TPopupMenu;
    Nuovolemento1: TMenuItem;
    dlblScadenzaPassword: TDBText;
    pmnOperatore: TPopupMenu;
    Riabilitaoperatore: TMenuItem;
    N4: TMenuItem;
    Riabilitaoperatore1: TMenuItem;
    actRiabOper: TAction;
    grpAnagraficoRiferimento: TGroupBox;
    lblMatricola: TLabel;
    lblNominativo: TLabel;
    lblCodFiscale: TLabel;
    pnlDatiOperatore: TPanel;
    edtMatricola: TEdit;
    edtNominativo: TEdit;
    edtCodFiscale: TEdit;
    lblAzienda: TLabel;
    lblOperatore: TLabel;
    lblPassword: TLabel;
    DBText1: TDBText;
    lblScadenza: TLabel;
    dlblScadenzaUtente: TDBText;
    lblscadenzaUtente: TLabel;
    EAzienda2: TDBLookupComboBox;
    EPassWord: TDBEdit;
    EOperatore: TDBEdit;
    Label8: TLabel;
    EOccupato: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    dchkNuovaPsw: TDBCheckBox;
    DedtVCess: TDBEdit;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    btnPulisciSelezione: TBitBtn;
    btnCercaAnagrafica: TBitBtn;
    procedure EAzienda2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Chiudi1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TCancClick(Sender: TObject);
    procedure Nuovolemento1Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure actRiabOperExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EAzienda2CloseUp(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnPulisciSelezioneClick(Sender: TObject);
    procedure btnCercaAnagraficaClick(Sender: TObject);
  private
    FGestSelAnag: Boolean;
    FOldAziendaKeyValue: Variant;
  public
    Inserimento:Boolean;
    procedure OnAziendaChange;
    procedure AggiornaDatiAnagraficaCollegata;
    procedure ResetSelAnagrafe;
    property GestSelAnag: Boolean read FGestSelAnag;
  end;

var
  A008FOperatori: TA008FOperatori;

implementation

uses A008UOperatoriDtM1, A008UProfili;

{$R *.DFM}

procedure TA008FOperatori.FormCreate(Sender: TObject);
begin
  inherited;
  Inserimento:=False;
  DBCheckBox3.Visible:=(Parametri.CampiRiferimento.C5_IntegrazAnag = 'F') or
                       (Parametri.CampiRiferimento.C5_IntegrazAnag = 'T');

  FOldAziendaKeyValue:=null;
  OnAziendaChange;
end;

procedure TA008FOperatori.FormDestroy(Sender: TObject);
begin
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA008FOperatori.FormShow(Sender: TObject);
begin
  inherited;

  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600DatiVisualizzati:='MATRICOLA,COGNOME,NOME,CODFISCALE';
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600Progressivo:=0;
end;

procedure TA008FOperatori.FormActivate(Sender: TObject);
{Stabilisco i collegamenti a DButton}
begin
  DButton.DataSet:=A008FOperatoriDtM1.QI070;
  A008FOperatoriDtM1.AziendaCorrente:=A008FOperatoriDtM1.QI070.FieldByName('AZIENDA').AsString;
  A008FOperatoriDtM1.AggiornaFiltroProfili;
  inherited;
end;

procedure TA008FOperatori.btnCercaAnagraficaClick(Sender: TObject);
var
  LAziendaCorr: string;
  LFound: Boolean;
  LMsg: String;
begin
  LAziendaCorr:=A008FOperatoriDtM1.QI070.FieldByName('AZIENDA').AsString;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    // ricerca progressivo
    if C600frmSelAnagrafe.C600SelAnagrafe.RecordCount = 0 then
    begin
      R180MessageBox('Nessuna anagrafica selezionata!',INFORMA);
    end
    else
    begin
      Screen.Cursor:=crHourGlass;
      LFound:=False;
      try
        C600frmSelAnagrafe.C600SelAnagrafe.First;
        while not C600frmSelAnagrafe.C600SelAnagrafe.Eof do
        begin
          LFound:=A008FOperatoriDtM1.QI070.SearchRecord('AZIENDA;T030_PROGRESSIVO',VarArrayOf([LAziendaCorr,C600frmSelAnagrafe.C600SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger]),[srFromBeginning]);
          if LFound then
            Break;
          C600frmSelAnagrafe.C600SelAnagrafe.Next;
        end;
      finally
        Screen.Cursor:=crDefault;
      end;
      if not LFound then
      begin
        if C600frmSelAnagrafe.C600SelAnagrafe.RecordCount = 1 then
          LMsg:=Format('Nessun operatore è collegato all''anagrafica selezionata'#13#10'(%s %s)',
                       [C600frmSelAnagrafe.C600SelAnagrafe.FieldByName('COGNOME').AsString,
                        C600frmSelAnagrafe.C600SelAnagrafe.FieldByName('NOME').AsString])
        else
          LMsg:=Format('Nessun operatore è collegato ad alcuna'#13#10'delle %d anagrafiche selezionate!',
                       [C600frmSelAnagrafe.C600SelAnagrafe.RecordCount]);
        R180MessageBox(LMsg,INFORMA);
      end;
    end;
  end;
end;

procedure TA008FOperatori.btnPulisciSelezioneClick(Sender: TObject);
begin
  // annullamento del progressivo collegato
  if A008FOperatoriDtM1.QI070.State in [dsInsert,dsEdit] then
  begin
    A008FOperatoriDtM1.QI070.FieldByName('T030_PROGRESSIVO').Value:=null;
    AggiornaDatiAnagraficaCollegata;
  end;

  // reset selezione anagrafica
  if Assigned(C600frmSelAnagrafe) then
    ResetSelAnagrafe;
end;

procedure TA008FOperatori.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    // imposta il progressivo della selezione anagrafica se richiesto
    if A008FOperatoriDtM1.QI070.State in [dsInsert,dsEdit] then
    begin
      if (C600frmSelAnagrafe.C600SelAnagrafe.Active) and
         (C600frmSelAnagrafe.C600SelAnagrafe.RecordCount > 0) then
      begin
        A008FOperatoriDtM1.QI070.FieldByName('T030_PROGRESSIVO').AsInteger:=C600frmSelAnagrafe.C600Progressivo;
      end
      else
      begin
        A008FOperatoriDtM1.QI070.FieldByName('T030_PROGRESSIVO').Value:=null;
      end;
      AggiornaDatiAnagraficaCollegata;
    end;
  end;
end;

procedure TA008FOperatori.OnAziendaChange;
begin
  FGestSelAnag:=(Parametri.CampiRiferimento.C33_Link_I070_T030 = 'O') or
                (Parametri.CampiRiferimento.C33_Link_I070_T030 = 'F');
  grpAnagraficoRiferimento.Visible:=FGestSelAnag;
  grpAnagraficoRiferimento.Caption:='Anagrafica di riferimento' + IfThen(Parametri.CampiRiferimento.C33_Link_I070_T030 = 'O',' (*)');
  Self.Height:=380 + IfThen(grpAnagraficoRiferimento.Visible,grpAnagraficoRiferimento.Height);
  if FGestSelAnag then
  begin
    AggiornaDatiAnagraficaCollegata;
  end;
end;

procedure TA008FOperatori.AggiornaDatiAnagraficaCollegata;
// aggiorna i dati anagrafici del progressivo eventualmente associato all'operatore
var
  LProg: Integer;
  LMatricola: string;
  LNominativo: String;
  LCodFiscale: string;
begin
  LMatricola:='';
  LNominativo:='';
  LCodFiscale:='';

  LProg:=A008FOperatoriDtM1.QI070.FieldByName('T030_PROGRESSIVO').AsInteger;
  if LProg <> 0 then
  begin
    A008FOperatoriDtM1.selT030.Close;
    A008FOperatoriDtM1.selT030.SetVariable('PROGRESSIVO',LProg);
    A008FOperatoriDtM1.selT030.Open;
    if A008FOperatoriDtM1.selT030.RecordCount > 0 then
    begin
      LMatricola:=A008FOperatoriDtM1.selT030.FieldByName('MATRICOLA').AsString;
      LNominativo:=Format('%s %s',[A008FOperatoriDtM1.selT030.FieldByName('COGNOME').AsString,A008FOperatoriDtM1.selT030.FieldByName('NOME').AsString]);
      LCodFiscale:=A008FOperatoriDtM1.selT030.FieldByName('CODFISCALE').AsString;
    end;
  end;

  edtMatricola.Text:=LMatricola;
  edtNominativo.Text:=LNominativo;
  edtCodFiscale.Text:=LCodFiscale;

  // gestione abilitazioni
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnPulisciSelezione.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnCercaAnagrafica.Visible:=DButton.State = dsBrowse;
end;

procedure TA008FOperatori.TCancClick(Sender: TObject);
begin
  with A008FOperatoriDtM1.QI070 do
    if (FieldByName('Azienda').AsString = 'AZIN') and
       (FieldByName('Utente').AsString = 'SYSMAN') then
      raise Exception.Create('Impossibile cancellare l''operatore SYSMAN!')
    else
      inherited;
end;

procedure TA008FOperatori.Nuovolemento1Click(Sender: TObject);
begin
  if PopupMenu1.PopupComponent = dlckPermessi then
    A008FProfili.PageControl1.ActivePage:=A008FProfili.tabPermessi
  else if PopupMenu1.PopupComponent = dlckFiltroAnagrafe then
    A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroAnagrafe
  else if PopupMenu1.PopupComponent = dlckFiltroFunzioni then
    A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroFunzioni
  else if PopupMenu1.PopupComponent = dlckFiltroDizionario then
    A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroDizionario;
  A008FProfili.PageControl1Change(nil);
  A008FProfili.SelCorrenteDist.SearchRecord('PROFILO',TDBLookupComboBox(PopupMenu1.PopupComponent).Text,[srFromBeginning]);
  A008FProfili.ShowModal;
end;

procedure TA008FOperatori.Chiudi1Click(Sender: TObject);
begin
  Close;
end;

procedure TA008FOperatori.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
    DButton.DataSet:=nil;
end;

procedure TA008FOperatori.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT I070.* FROM I070_UTENTI I070');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('I070.AZIENDA');
  NomiCampiR001.Add('I070.UTENTE');
  NomiCampiR001.Add('I070.PROGRESSIVO');
  NomiCampiR001.Add('I070.PASSWD');
  NomiCampiR001.Add('I070.OCCUPATO');
  NomiCampiR001.Add('I070.INTEGRAZIONEANAGRAFE');
  NomiCampiR001.Add('I070.SBLOCCO');
  NomiCampiR001.Add('I070.PERMESSI');
  NomiCampiR001.Add('I070.FILTRO_ANAGRAFE');
  NomiCampiR001.Add('I070.FILTRO_FUNZIONI');
  NomiCampiR001.Add('I070.FILTRO_DIZIONARIO');
  inherited;
end;

procedure TA008FOperatori.DButtonDataChange(Sender: TObject; Field: TField);
var Sysdate:TDateTime;
begin
  inherited;
  Sysdate:=Trunc(R180Sysdate(A008FOperatoriDtM1.QI090.Session));
  if Field <> nil then
    exit;
  // scadenza password
  dlblScadenzaPassword.Visible:=A008FOperatoriDtM1.QI090.FieldByName('VALID_PASSWORD').AsInteger > 0;
  if not dlblScadenzaPassword.Visible then
    lblScadenza.Caption:='Scadenza password: illimitata'
  else
    lblScadenza.Caption:='Scadenza:';
  // scadenza accesso utente
  if (A008FOperatoriDtM1.QI070.FieldByName('UTENTE').AsString <> 'SYSMAN') and
     (A008FOperatoriDtM1.QI090.FieldByName('VALID_UTENTE').AsInteger > 0) then
  begin
    if (not A008FOperatoriDtM1.QI070.FieldByName('DATA_ACCESSO').IsNull) and
       (A008FOperatoriDtM1.QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
       (R180AddMesi(A008FOperatoriDtM1.QI070.FieldByName('DATA_ACCESSO').AsDateTime,A008FOperatoriDtM1.QI090.FieldByName('VALID_UTENTE').AsInteger) <= Sysdate) then
      lblScadenzaUtente.Caption:='Accesso scaduto:'
    else
      lblScadenzaUtente.Caption:='Scadenza accesso:';
  end
  else
  begin
    dlblScadenzaUtente.Caption:='';
    lblScadenzaUtente.Caption:='Scadenza accesso: illimitata';
  end;

  if lblScadenzaUtente.Caption <> 'Accesso scaduto:' then
  begin
    RiabilitaOperatore.Enabled:=false;
    RiabilitaOperatore1.Enabled:=false;
    lblScadenzaUtente.Font.Color:=clBlack;
  end
  else
    begin
    RiabilitaOperatore.Enabled:=true;
    RiabilitaOperatore1.Enabled:=true;
    lblScadenzaUtente.Font.Color:=clred;
  end;
end;

procedure TA008FOperatori.DButtonStateChange(Sender: TObject);
begin
  inherited;

  // aggiorna anagrafica rif.
  if FGestSelAnag then
  begin

    AggiornaDatiAnagraficaCollegata;
  end;
end;

procedure TA008FOperatori.actRiabOperExecute(Sender: TObject);
var oper: Integer;
begin
  inherited;
  if MessageDlg('Riabilitare l''operatore selezionato?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
  with A008FOperatoriDtM1.OperSQL do
  begin
    SQL.Clear;
    SQL.Add(Format('UPDATE MONDOEDP.I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = TRUNC(SYSDATE) WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[EAzienda2.Text,EOperatore.Text]));
    Execute;
    SessioneOracle.Commit;
    oper:=Dbutton.DataSet.FieldByName('PROGRESSIVO').AsInteger;
    Dbutton.DataSet.Refresh;
    A008FOperatoriDtM1.QI070.SearchRecord('PROGRESSIVO',oper,[srFromBeginning]);
  end;
end;

procedure TA008FOperatori.EAzienda2CloseUp(Sender: TObject);
begin
  inherited;

  // se necessario forza un afterscroll (qualora sia disattivato) su QI090 per aggiornare i parametri
  if (@A008FOperatoriDtM1.QI090.AfterScroll = nil) then //and (A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').AsString <> A008FOperatoriDtM1.AziendaCorrente) then
    A008FOperatoriDtM1.QI090AfterScroll(A008FOperatoriDtM1.QI090);

  if (FGestSelAnag (*and (VarToStr(EAzienda2.KeyValue) <> A008FOperatoriDtM1.AziendaCorrente*)) then
    ResetSelAnagrafe;
end;

procedure TA008FOperatori.EAzienda2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;

  // se necessario forza un afterscroll (qualora sia disattivato) su QI090 per aggiornare i parametri
  if (@A008FOperatoriDtM1.QI090.AfterScroll = nil) then //and (A008FOperatoriDtM1.QI090.FieldByName('AZIENDA').AsString <> A008FOperatoriDtM1.AziendaCorrente) then
    A008FOperatoriDtM1.QI090AfterScroll(A008FOperatoriDtM1.QI090);

  if (FGestSelAnag (*and (VarToStr(EAzienda2.KeyValue) <> A008FOperatoriDtM1.AziendaCorrente*)) then
    ResetSelAnagrafe;
end;

procedure TA008FOperatori.ResetSelAnagrafe;
begin
  //Farlo solo se è stata cambiata l'azienda, altrimenti perde i riferimenti al vecchio filtro sulla vecchia selezione
  if EAzienda2.KeyValue <> FOldAziendaKeyValue then
  begin
    FOldAziendaKeyValue:=EAzienda2.KeyValue;
    try
      C600frmSelAnagrafe.DistruggiSelAnagrafe;
    except
    end;
    Parametri.ColonneStruttura.Clear;
    C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,nil,0,False);
    C600frmSelAnagrafe.C600Progressivo:=0;
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.Singolodipendente1.Checked:=False;

    // se la selezione è resettata annulla il progressivo dell'anagrafica collegata eventualmente impostato
    if A008FOperatoriDtM1.QI070.State in [dsInsert,dsEdit] then
    begin
      A008FOperatoriDtM1.QI070.FieldByName('T030_PROGRESSIVO').Value:=null;
      AggiornaDatiAnagraficaCollegata;
    end;
  end;
end;

end.
