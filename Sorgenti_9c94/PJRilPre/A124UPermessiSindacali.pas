unit A124UPermessiSindacali;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000USessione, A000UInterfaccia, C001UFiltroTabelleDtM,
  C700USelezioneAnagrafe, C001UFiltroTabelle, C001UScegliCampi, A000UMessaggi,
  A002UInterfacciaSt, C005UDatiAnagrafici, ActnList, ImgList, ToolWin,
  SelAnagrafe, Variants, Grids, DBGrids, Oracle, OracleData, StrUtils,
  A023UTimbMese, A121UOrganizzSindacali, C180FunzioniGenerali,
  A083UMsgElaborazioni, System.Actions;

type
  TA124FPermessiSindacali = class(TR001FGestTab)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    grdPermessi: TDBGrid;
    Label1: TLabel;
    Label4: TLabel;
    dEdtDalle: TDBEdit;
    Label5: TLabel;
    dEdtAlle: TDBEdit;
    lblOre: TLabel;
    dEdtOre: TDBEdit;
    grbProtocollo: TGroupBox;
    dEdtNumProt: TDBEdit;
    lblNumProt: TLabel;
    lblDataProt: TLabel;
    dtpDataProt: TDateTimePicker;
    grbModifica: TGroupBox;
    lblNumProtMod: TLabel;
    lblDataProtMod: TLabel;
    dtpDataProtMod: TDateTimePicker;
    dEdtNumProtMod: TDBEdit;
    dtpData: TDateTimePicker;
    dChkAbbatte: TDBCheckBox;
    PopupMenu2: TPopupMenu;
    RitornaallostatoMODIFICATO1: TMenuItem;
    PopupMenu3: TPopupMenu;
    Copiapermesso1: TMenuItem;
    Permessi1: TMenuItem;
    Label10: TLabel;
    btnElimina: TBitBtn;
    lblStato: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblTipo: TLabel;
    lblDescSindacato: TLabel;
    lblDescOrganismo: TLabel;
    dCmbSindacato: TDBLookupComboBox;
    dCmbOrganismo: TDBLookupComboBox;
    ToolButton2: TToolButton;
    Permessi2: TMenuItem;
    GroupBox1: TGroupBox;
    dGrdCompetenze: TDBGrid;
    btnCompetenze: TSpeedButton;
    rgpModalita: TRadioGroup;
    ProgressBar1: TProgressBar;
    btnAnomalie: TBitBtn;
    lblCompetenze: TLabel;
    drdgTipoPermesso: TDBRadioGroup;
    btnVisualizzaTimbGius: TToolButton;
    ToolButton5: TToolButton;
    actVisualizzaTimbGius: TAction;
    procedure actVisualizzaTimbGiusExecute(Sender: TObject);
    procedure dEdtAlleExit(Sender: TObject);
    procedure dEdtOreDblClick(Sender: TObject);
    procedure drdgTipoPermessoClick(Sender: TObject);
    procedure dCmbSindacatoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnCompetenzeClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
    procedure RitornaallostatoMODIFICATO1Click(Sender: TObject);
    procedure dtpDataChange(Sender: TObject);
    procedure Copiapermesso1Click(Sender: TObject);
    procedure dEdtDalleChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dtpDataProtChange(Sender: TObject);
    procedure dtpDataProtModChange(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure Permessi1Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure Permessi2Click(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dCmbSindacatoCloseUp(Sender: TObject);
    procedure dCmbOrganismoCloseUp(Sender: TObject);
    procedure dCmbOrganismoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbSindacatoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    A023:TA023FTimbMese;
    procedure CambiaProgressivo;
    procedure InserimentoCollettivo;
    procedure CancellazioneCollettiva(Tipo:String);
  public
    SuperoCompetOre,SuperoCompetDalle,SuperoCompetAlle:String;
  end;

var
  A124FPermessiSindacali: TA124FPermessiSindacali;

procedure OpenA124PermessiSindacali(Prog:LongInt);

implementation

uses A124UPermessiSindacaliDtM, A124USuperoCompetenze;

{$R *.DFM}

procedure OpenA124PermessiSindacali(Prog:LongInt);
{Iscrizione Sindacati}
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA124PermessiSindacali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A124FPermessiSindacali:=TA124FPermessiSindacali.Create(nil);
  with A124FPermessiSindacali do
    try
      C700Progressivo:=Prog;
      A124FPermessiSindacaliDtM:=TA124FPermessiSindacaliDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A124FPermessiSindacaliDtM.Free;
      Free;
    end;
end;

procedure TA124FPermessiSindacali.CambiaProgressivo;
begin
  with A124FPermessiSindacaliDtM do
  begin
    selT248.SetVariable('Progressivo',C700Progressivo);
    selT248.Close;
    selT248.Open;
    NumRecords;
  end;
  actVisualizzaTimbGius.Enabled:=C700Progressivo <> 0;
end;

procedure TA124FPermessiSindacali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  //Abilitazione pulsanti
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    TPrimo.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TPrec.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TSucc.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TUltimo.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TCerca.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    btnRefresh.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TModif.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    TStampa.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    //Abilitazione selezione anagrafiche e modalità collettiva-singola
    frmSelAnagrafe.Enabled:=DataSetInUso.State = dsBrowse;
    rgpModalita.Enabled:=DataSetInUso.State = dsBrowse;
    //Abilitazione pulsante Anomalie - Elimina
    btnAnomalie.Enabled:=(DataSetInUso.State = dsBrowse) and (RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB);
    btnElimina.Visible:=(DataSetInUso.State in [dsEdit,dsInsert]) and (Azione = 'C');
    //Abilitazione Protocollo Modifica
    dEdtNumProtMod.Enabled:=(DataSetInUso.State = dsEdit) or
                           ((DataSetInUso.State = dsInsert) and (SelezioneCollettiva) and (Azione = 'C'));
    lblNumProtMod.Enabled:=dEdtNumProtMod.Enabled;
    dtpDataProtMod.Enabled:=dEdtNumProtMod.Enabled;
    lblDataProtMod.Enabled:=dEdtNumProtMod.Enabled;
    //Abilitazione griglia Permessi
    grdPermessi.Enabled:=(DataSetInUso.State = dsBrowse) and (not SelezioneCollettiva);
    //Abilitazione campi principali
    dCmbSindacato.Enabled:=((not SelezioneCollettiva) and (DataSetInUso.State in [dsEdit,dsInsert]) and (Azione <> 'C')) or
                           ((SelezioneCollettiva) and (DataSetInUso.State = dsInsert));
  end;
  dCmbOrganismo.Enabled:=dCmbSindacato.Enabled;
  dtpData.Enabled:=dCmbSindacato.Enabled;
  dEdtDalle.Enabled:=dCmbSindacato.Enabled;
  dEdtAlle.Enabled:=dCmbSindacato.Enabled;
  dEdtOre.Enabled:=dCmbSindacato.Enabled;
  dChkAbbatte.Enabled:=dCmbSindacato.Enabled;
  drdgTipoPermesso.Enabled:=dCmbSindacato.Enabled;
  //Abilitazione Protocollo
  lblNumProt.Enabled:=dCmbSindacato.Enabled;
  dEdtNumProt.Enabled:=dCmbSindacato.Enabled;
  lblDataProt.Enabled:=dCmbSindacato.Enabled;
  dtpDataProt.Enabled:=dCmbSindacato.Enabled;
end;

procedure TA124FPermessiSindacali.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA124FPermessiSindacali.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA124FPermessiSindacali.FormShow(Sender: TObject);
begin
  inherited;
  A124FPermessiSindacaliDtM.A124MW.DataSetInUso:=A124FPermessiSindacaliDtM.selT248;
  DButton.DataSet:=A124FPermessiSindacaliDtM.A124MW.DataSetInUso;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME,CONTRATTO';
  C700DatiSelezionati:=C700CampiBase + ',''(Contr.''||T430CONTRATTO||'')'' CONTRATTO';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A124FPermessiSindacaliDtM.A124MW, SessioneOracle, StatusBar,2,True);
  C700SelAnagrafe.OnFilterRecord:=A124FPermessiSindacaliDtM.A124MW.SelAnagrafeOnFilterRecord;
  dGrdCompetenze.DataSource:=A124FPermessiSindacaliDtM.A124MW.dsrCompetenze;
  dCmbOrganismo.ListSource:=A124FPermessiSindacaliDtM.A124MW.dsrT245;
  dCmbSindacato.ListSource:=A124FPermessiSindacaliDtM.A124MW.dsrT240;
end;

procedure TA124FPermessiSindacali.Stampa1Click(Sender: TObject);
begin
    QueryStampa.Clear;
    QueryStampa.Add('select T1.*, T1.ROWID, ');
    QueryStampa.Add('T2.DESCRIZIONE SINDACATO, T2.RSU, T2.RAGGRUPPAMENTO, T2.SINDACATI_RAGGRUPPATI, T3.DESCRIZIONE ORGANISMO ');
    QueryStampa.Add('from T248_PERMESSISINDACALI T1, T240_ORGANIZZAZIONISINDACALI T2, T245_ORGANISMISINDACALI T3 ');
    QueryStampa.Add('where T1.COD_SINDACATO = T2.CODICE ');
    QueryStampa.Add('and T2.DECORRENZA = (SELECT MAX(DECORRENZA) ');
    QueryStampa.Add('                       FROM T240_ORGANIZZAZIONISINDACALI ');
    QueryStampa.Add('                      WHERE CODICE = T2.CODICE ');
    QueryStampa.Add('                        AND DECORRENZA < T1.DATA) ');
    QueryStampa.Add('and T1.COD_ORGANISMO = T3.CODICE ');
    QueryStampa.Add('order by T1.data desc, T1.cod_sindacato, T1.cod_organismo ');
    NomiCampiR001.Clear;
    NomiCampiR001.Add('T1.PROGRESSIVO');
    NomiCampiR001.Add('T1.DATA');
    NomiCampiR001.Add('T1.NUMERO_PROT');
    NomiCampiR001.Add('T1.DATA_PROT');
    NomiCampiR001.Add('T1.DALLE');
    NomiCampiR001.Add('T1.ALLE');
    NomiCampiR001.Add('T1.ORE');
    NomiCampiR001.Add('T1.ABBATTE_COMPETENZE');
    NomiCampiR001.Add('T1.COD_SINDACATO');
    NomiCampiR001.Add('T1.COD_ORGANISMO');
    NomiCampiR001.Add('T.STATO');
    NomiCampiR001.Add('T1.PROT_MODIFICA');
    NomiCampiR001.Add('T1.DATA_MODIFICA');
    NomiCampiR001.Add('T2.DESCRIZIONE');
    NomiCampiR001.Add('T2.RSU');
    NomiCampiR001.Add('T2.RAGGRUPPAMENTO');
    NomiCampiR001.Add('T2.SINDACATI_RAGGRUPPATI');
    NomiCampiR001.Add('T3.DESCRIZIONE');
  inherited;
end;

procedure TA124FPermessiSindacali.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA121OrganizzSindacali(A124FPermessiSindacaliDtM.selT248.FieldByName('COD_SINDACATO').AsString);
end;

procedure TA124FPermessiSindacali.btnCompetenzeClick(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
    if btnCompetenze.Down then
    begin
      Compet:=True;
      Competenze;
      if selCompetenze.RecordCount = 0 then
        lblCompetenze.Caption:=A000MSG_A124_MSG_NO_COMP_CONTRATTO
      else
        lblCompetenze.Caption:='';
    end
    else
    begin
      Compet:=False;
      selCompetenze.Close;
      lblCompetenze.Caption:='';
    end;
end;

procedure TA124FPermessiSindacali.TCancClick(Sender: TObject);
begin
  if Sender = btnElimina then
  begin
    RegistraMsg.IniziaMessaggio('A124');
    if A124FPermessiSindacaliDtM.A124MW.SelezioneCollettiva then
    begin
      ProgressBar1.Position:=0;
      A124FPermessiSindacaliDtM.A124MW.PreparaCancellazioneCollettiva('E');
      CancellazioneCollettiva('E');
      A124FPermessiSindacaliDtM.A124MW.DataSetInUso.Cancel;
      ProgressBar1.Position:=0;
      btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    end
    else
      inherited;
  end
  else
  begin
    A124FPermessiSindacaliDtM.A124MW.Azione:='C';
    A124FPermessiSindacaliDtM.A124MW.PreparaCancellazione;
  end;
end;

procedure TA124FPermessiSindacali.TModifClick(Sender: TObject);
begin
  if A124FPermessiSindacaliDtM.selT248.FieldByName('STATO').AsString = 'C' then
    raise exception.Create(Format(A000MSG_A124_ERR_FMT_PERM_CANCELLATO,['modificare']))
  else
  begin
    A124FPermessiSindacaliDtM.A124MW.Azione:='M';
    inherited;
  end;
end;

procedure TA124FPermessiSindacali.btnEliminaClick(Sender: TObject);
begin
  TCancClick(Sender);
end;

procedure TA124FPermessiSindacali.RitornaallostatoMODIFICATO1Click(
  Sender: TObject);
begin
  lblStato.Caption:='MODIFICATO';
  A124FPermessiSindacaliDtM.A124MW.Azione:='M';
  A124FPermessiSindacaliDtM.A124MW.RipristinaStatoModificato;
  actRefreshExecute(nil);
end;

procedure TA124FPermessiSindacali.dtpDataChange(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    AbbatteCompetenze:=IfThen(dChkAbbatte.Checked,'S','N');
    DatasetInUso.FieldByName('DATA').AsDateTime:=Trunc(dtpData.Date);
    if SelezioneCollettiva then
      AggiornaSindacatiMC
    else
      AggiornaSindacati;
    if (DatasetInUso.State in [dsEdit,dsInsert]) and (DatasetInUso.FieldByName('ORE').IsNull) then
      ValorizzNumOre;
  end;
end;

procedure TA124FPermessiSindacali.Copiapermesso1Click(Sender: TObject);
begin
  A124FPermessiSindacaliDtM.A124MW.CopiaPermesso;
  with A124FPermessiSindacaliDtM do
    selT248.OnNewRecord:=selT248NewRecord;//tolto in CopiaPermesso
end;

procedure TA124FPermessiSindacali.dEdtDalleChange(Sender: TObject);
begin
  if A124FPermessiSindacaliDtM.A124MW.DatasetInUso.State in [dsEdit,dsInsert] then
    if Trim(TDBEdit(Sender).Text) = '.' then
      TDBEdit(Sender).Field.Clear;
end;

procedure TA124FPermessiSindacali.DButtonDataChange(Sender: TObject;Field: TField);
var TipoSind:String;
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    // Valorizzazione label STATO
    lblStato.Caption:=IfThen(DataSetInUso.FieldByName('STATO').AsString = 'O','ORIGINALE',
                      IfThen(DataSetInUso.FieldByName('STATO').AsString = 'M','MODIFICATO',
                      IfThen(DataSetInUso.FieldByName('STATO').AsString = 'C','CANCELLATO','')));
    // Valorizzazione campi Data
    dtpData.DateTime:=DataSetInUso.FieldByName('DATA').AsDateTime;
    dtpDataProt.DateTime:=DataSetInUso.FieldByName('DATA_PROT').AsDateTime;
    dtpDataProtMod.DateTime:=DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime;
    // Valorizzazione label TIPO e descrizioni sindacato-organismo
    AbbatteCompetenze:=IfThen(dChkAbbatte.Checked,'S','N');
    if SelezioneCollettiva then
      AggiornaSindacatiMC
    else
      AggiornaSindacati;
    lblDescSindacato.Caption:=AggiornaDescrizioni('S',VarToStr(dCmbSindacato.KeyValue),TipoSind);
    lblTipo.Caption:=TipoSind;
    lblDescOrganismo.Caption:=AggiornaDescrizioni('O',VarToStr(dCmbOrganismo.KeyValue),TipoSind);
    // Valorizzazione label COMPETENZE
    lblCompetenze.Caption:='';
    if selCompetenze.Active then
    begin
      Competenze;
      if selCompetenze.RecordCount = 0 then
        lblCompetenze.Caption:=A000MSG_A124_MSG_NO_COMP_CONTRATTO;
    end;
  end;
end;

procedure TA124FPermessiSindacali.dtpDataProtChange(Sender: TObject);
begin
  inherited;
  A124FPermessiSindacaliDtM.A124MW.DataSetInUso.FieldByName('DATA_PROT').AsDateTime:=Trunc(dtpDataProt.Date);
end;

procedure TA124FPermessiSindacali.dtpDataProtModChange(Sender: TObject);
begin
  inherited;
  A124FPermessiSindacaliDtM.A124MW.DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime:=Trunc(dtpDataProtMod.Date);
end;

procedure TA124FPermessiSindacali.TInserClick(Sender: TObject);
begin
  Panel2.SetFocus;
  A124FPermessiSindacaliDtM.A124MW.Azione:='';
  if C700Progressivo <= 0 then
    raise exception.create(A000MSG_ERR_NO_DIP);
  A124FPermessiSindacaliDtM.A124MW.PreparaInserimento;
  inherited;
end;

procedure TA124FPermessiSindacali.Permessi1Click(Sender: TObject);
begin
  inherited;
  Permessi1.Checked:=not Permessi1.Checked;
  A124FPermessiSindacaliDtM.A124MW.ImpostaFiltroPermessi(Permessi1.Checked,Permessi2.Checked);
  NumRecords;
end;

procedure TA124FPermessiSindacali.PopupMenu3Popup(Sender: TObject);
begin
  inherited;
  CopiaPermesso1.Enabled:=(not SolaLettura) and (not A124FPermessiSindacaliDtM.A124MW.SelezioneCollettiva);
end;

procedure TA124FPermessiSindacali.PopupMenu2Popup(Sender: TObject);
begin
  inherited;
  RitornaallostatoModificato1.Enabled:= (not SolaLettura) and (not A124FPermessiSindacaliDtM.A124MW.SelezioneCollettiva) and
                  (A124FPermessiSindacaliDtM.selT248.FieldByName('STATO').AsString = 'C');
end;

procedure TA124FPermessiSindacali.TRegisClick(Sender: TObject);
begin
  try
    dtpData.SetFocus;
  except
  end;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    Controlli;
    RegistraMsg.IniziaMessaggio('A124');
    if SelezioneCollettiva then
    begin
      ProgressBar1.Position:=0;
      if Azione = 'C' then
      begin
        PreparaCancellazioneCollettiva('C');
        CancellazioneCollettiva('C');
        DataSetInUso.Cancel;
      end
      else
      begin
        PreparaInserimentoCollettivo;
        ImpostaFiltroInserimentoCollettivo;
        DataSetInUso.Cancel;
        InserimentoCollettivo;
      end;
      ProgressBar1.Position:=0;
      btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);  //Abilito il pulsante Anomalie
    end
    else
    begin //Inserimento singolo
      inherited;
      actRefreshExecute(nil);
    end;
  end;
end;

procedure TA124FPermessiSindacali.InserimentoCollettivo;
var Inserito:Boolean;
  PosOrderBy,Conta:Integer;
  Filtro,Messaggio:String;
begin
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    OldProg:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Conta:=0;
    C700SelAnagrafe.Filtered:=True;
    C700selAnagrafe.First;
    ProgressBar1.Max:=C700selAnagrafe.RecordCount;
    while not C700selAnagrafe.Eof do
    begin
    //Ciclo sui dipendenti estratti dalla C700+Filtro
      ProgressBar1.StepBy(1);
      Inserito:=False;
      with C700SelAnagrafe do
        Nominativo:=FieldByName('MATRICOLA').AsString + ' - ' + FieldByName('COGNOME').AsString + ' ' + FieldByName('NOME').AsString;
      InserisciPermesso;
      repeat //Ciclo sulla conferma dell'inserimento --> scattano BeforePost e AfterPost di selT248
        Messaggio:='';
        try
          SuperoCompetResiduo:='';
          selT248.Post;
          Inserito:=True;
          Conta:=Conta+1;
        except
          on E:exception do
            Messaggio:=E.Message;
        end;
        if SuperoCompetResiduo <> '' then //Nel caso di 'supero competenze' richiedo nuovi valori
        begin
          OpenA124SuperoCompetenze(Nominativo,SuperoCompetResiduo);
          if SuperoCompetOre = 'AnnullaDip' then
          begin
            selT248.Cancel;
            Break;
          end
          else if SuperoCompetOre = 'AnnullaOp' then
          begin
            selT248.Cancel;
            ProgressBar1.Position:=0;
            C700SelAnagrafe.Filtered:=False;
            CercaDip(OldProg);
            R180MessageBox(Format(A000MSG_A124_MSG_FMT_PERMESSI_INSERITI,[IntToStr(Conta)]) + IfThen((RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB),#$D#$A + A000MSG_A124_MSG_ANOMALIE),'INFORMA');
            Abort;
          end
          else
          begin  //Assegno nuovi valori e rifaccio il Post
            selT248.FieldByName('ORE').AsString:=SuperoCompetOre;
            if Trim(SuperoCompetDalle) <> '.' then
              selT248.FieldByName('DALLE').AsString:=SuperoCompetDalle;
            if Trim(SuperoCompetAlle) <> '.' then
              selT248.FieldByName('ALLE').AsString:=SuperoCompetAlle;
          end
        end
        else if Messaggio <> '' then  //Nel caso di exception generica carico il Messaggio sulla ListaAnomalie
        begin
          RegistraMsg.InserisciMessaggio('A',Nominativo + ': Inserimento fallito - ' + Messaggio,'',C700Progressivo);
          selT248.Cancel;
          Break;
        end;
      until Inserito;
      SessioneOracle.Commit; //Commit su ogni dipendente
      C700selAnagrafe.Next;
    end;
    C700SelAnagrafe.Filtered:=False;
    CercaDip(OldProg);
    R180MessageBox(Format(A000MSG_A124_MSG_FMT_PERMESSI_INSERITI,[IntToStr(Conta)]) + IfThen((RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB),#$D#$A + A000MSG_A124_MSG_ANOMALIE),'INFORMA');
  end;
end;

procedure TA124FPermessiSindacali.CancellazioneCollettiva(Tipo:String);
var Messaggio:String;
begin
  with A124FPermessiSindacaliDtM.A124MW,selT248Canc do
  begin
    OldProg:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Conta:=0;
    First;
    while not Eof do
    begin
      ProgressBar1.StepBy(1);
      CercaDip(FieldByName('PROGRESSIVO').AsInteger);
      CancellaPermesso;
      if Tipo = 'C' then
        Next;
      SessioneOracle.Commit; //Commit su ogni dipendente
    end;
    CercaDip(OldProg);
  end;
  Messaggio:=Format(IfThen(Tipo = 'C',A000MSG_A124_MSG_FMT_PERMESSI_STATO_CANC,A000MSG_A124_MSG_FMT_PERMESSI_CANCELLATI),[IntToStr(A124FPermessiSindacaliDtM.A124MW.Conta)]);
  if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
    Messaggio:=Messaggio + #$D#$A + A000MSG_A124_MSG_ANOMALIE;
  R180MessageBox(Messaggio,'INFORMA');
end;

procedure TA124FPermessiSindacali.Permessi2Click(Sender: TObject);
begin
  inherited;
  Permessi2.Checked:=not Permessi2.Checked;
  A124FPermessiSindacaliDtM.A124MW.ImpostaFiltroPermessi(Permessi1.Checked,Permessi2.Checked);
  NumRecords;
end;

procedure TA124FPermessiSindacali.rgpModalitaClick(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    SelezioneCollettiva:=rgpModalita.ItemIndex = 1;
    btnCompetenze.Enabled:=not SelezioneCollettiva;
    dGrdCompetenze.Enabled:=not SelezioneCollettiva;
    if SelezioneCollettiva then
    begin
    //Modalità collettiva
      DataSetInUso:=cdsT248;
      DButton.DataSet:=DataSetInUso;
      cdsT248.Close;
      cdsT248.CreateDataSet;
      cdsT248.Open;
      dcmbSindacato.ListSource:=dsrT240C;
    end
    else
    begin
    //Modalità singola
      DataSetInUso:=selT248;
      DButton.DataSet:=DataSetInUso;
      dcmbSindacato.ListSource:=dsrT240;
      actRefreshExecute(nil);
    end;
  end;
end;

procedure TA124FPermessiSindacali.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A124','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A124FPermessiSindacaliDtM.A124MW);
end;

procedure TA124FPermessiSindacali.dCmbSindacatoCloseUp(Sender: TObject);
var TipoSind:String;
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    lblDescSindacato.Caption:=AggiornaDescrizioni('S',dCmbSindacato.Text,TipoSind);
    lblTipo.Caption:=TipoSind;
    if (DataSetInUso.State in [dsEdit,dsInsert]) and (DataSetInUso.FieldByName('ORE').IsNull) then
      ValorizzNumOre;
  end;
end;

procedure TA124FPermessiSindacali.dCmbSindacatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var TipoSind:String;
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    lblDescSindacato.Caption:=AggiornaDescrizioni('S',dCmbSindacato.Text,TipoSind);
    lblTipo.Caption:=TipoSind;
    if (DataSetInUso.State in [dsEdit,dsInsert]) and (DataSetInUso.FieldByName('ORE').IsNull) then
      ValorizzNumOre;
  end;
end;

procedure TA124FPermessiSindacali.dCmbOrganismoCloseUp(Sender: TObject);
var TipoSind:String;
begin
  inherited;
  lblDescOrganismo.Caption:=A124FPermessiSindacaliDtM.A124MW.AggiornaDescrizioni('O',dCmbOrganismo.Text,TipoSind);
end;

procedure TA124FPermessiSindacali.dCmbOrganismoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var TipoSind:String;
begin
  inherited;
  lblDescOrganismo.Caption:=A124FPermessiSindacaliDtM.A124MW.AggiornaDescrizioni('O',dCmbOrganismo.Text,TipoSind);
end;

procedure TA124FPermessiSindacali.dCmbSindacatoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TA124FPermessiSindacali.drdgTipoPermessoClick(Sender: TObject);
begin
  inherited;
  dEdtDalle.Enabled:=dRdgTipoPermesso.ItemIndex = 0;
  dEdtAlle.Enabled:=dRdgTipoPermesso.ItemIndex = 0;
  with A124FPermessiSindacaliDtM.A124MW do
    if (DataSetInUso.State in [dsEdit,dsInsert]) and (DataSetInUso.FieldByName('ORE').IsNull) then
      ValorizzNumOre;
end;

procedure TA124FPermessiSindacali.dEdtOreDblClick(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
    if DataSetInUso.State in [dsEdit,dsInsert] then
      ValorizzNumOre;
end;

procedure TA124FPermessiSindacali.dEdtAlleExit(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
    if DataSetInUso.State in [dsEdit,dsInsert] then
      ValorizzNumOre;
end;

procedure TA124FPermessiSindacali.actVisualizzaTimbGiusExecute(Sender: TObject);
begin
  inherited;
  with A124FPermessiSindacaliDtM.A124MW do
  begin
    Q040.SetVariable('PROGRESSIVO',C700Progressivo);
    Q040.SetVariable('DATAINIZIO',R180InizioMese(Trunc(dtpData.Date)));
    Q040.SetVariable('DATAFINE',R180FineMese(Trunc(dtpData.Date)));
    Q040.Open;
    Q100.SetVariable('PROGRESSIVO',C700Progressivo);
    Q100.SetVariable('DATAINIZIO',R180InizioMese(Trunc(dtpData.Date)));
    Q100.SetVariable('DATAFINE',R180FineMese(Trunc(dtpData.Date)));
    Q100.Open;
    Q275.Open;
    Q305.Open;
    A023:=TA023FTimbMese.Create(nil);
    try
      A023.Anno:=R180Anno(Trunc(dtpData.Date));
      A023.Mese:=R180Mese(Trunc(dtpData.Date));
      A023.Q040:=Q040;
      A023.Q100:=Q100;
      A023.Q275:=Q275;
      A023.Q305:=Q305;
      A023.CaricaEdit;
      A023.ShowModal;
    finally
      Q040.Close;
      Q100.Close;
      Q275.Close;
      Q305.Close;
      FreeAndNil(A023);
    end;
  end;
end;

end.
