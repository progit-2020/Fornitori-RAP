unit A119UPartecipazioneScioperi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls,
  A000UCostanti, A000UInterfaccia, A000USessione, A011UComuniProvinceRegioni, OracleData,
  System.Actions, C600USelAnagrafe, C180FunzioniGenerali, C020UVisualizzaDataSet,
  System.StrUtils, System.Math, Vcl.Buttons;

type
  TA119FPartecipazioneScioperi = class(TR001FGestTab)
    pnlDati: TPanel;
    lblData: TLabel;
    lblCausale: TLabel;
    dedtData: TDBEdit;
    dcmbCausale: TDBLookupComboBox;
    lblDescCausale: TLabel;
    drgpTipoGiust: TDBRadioGroup;
    dedtDaOre: TDBEdit;
    dedtAOre: TDBEdit;
    lblDaOre: TLabel;
    lblAOre: TLabel;
    dedtSelezioneAnagrafica: TDBEdit;
    lblSelezioneAnagrafica: TLabel;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    lblGGNotifica: TLabel;
    dedtGGNotifica: TDBEdit;
    lblDescGGNotifica: TLabel;
    actVisDettaglioDip: TAction;
    actBloccaRiepiloghi: TAction;
    actImporta: TAction;
    actImportaTutti: TAction;
    actAnnullaAut: TAction;
    pmnDettaglio: TPopupMenu;
    mnuVisDettaglioDip: TMenuItem;
    mnuBloccaRiepiloghi: TMenuItem;
    mnuAnnullaAut: TMenuItem;
    actSbloccaRiepiloghi: TAction;
    mnuImportaGiust: TMenuItem;
    mnuSbloccaRiepiloghi: TMenuItem;
    grpEventi: TGroupBox;
    dgrdEventi: TDBGrid;
    grpNotifiche: TGroupBox;
    pnlFiltriDettaglio: TPanel;
    rgpAutorizzate: TRadioGroup;
    rgpBloccate: TRadioGroup;
    btnImporta: TBitBtn;
    dgrdDettEvento: TDBGrid;
    spl1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure drgpTipoGiustClick(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure dcmbCausaleClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dedtGGNotificaChange(Sender: TObject);
    procedure rgpAutorizzateClick(Sender: TObject);
    procedure rgpBloccateClick(Sender: TObject);
    procedure actVisDettaglioDipExecute(Sender: TObject);
    procedure actBloccaRiepiloghiExecute(Sender: TObject);
    procedure actImportaExecute(Sender: TObject);
    procedure actImportaTuttiExecute(Sender: TObject);
    procedure actAnnullaAutExecute(Sender: TObject);
    procedure pmnDettaglioPopup(Sender: TObject);
  private
    procedure SetDescrizioneCausale;
    procedure SetDescrizioneGGNotifica;
  public
    procedure OnInserimento;
  end;

var
  A119FPartecipazioneScioperi: TA119FPartecipazioneScioperi;
  procedure OpenA119Scioperi; overload;
  procedure OpenA119Scioperi(Id: Integer); overload;

implementation

uses A119UPartecipazioneScioperiDM, A119UPartecipazioneScioperiMW;

{$R *.dfm}

procedure OpenA119Scioperi;
begin
  OpenA119Scioperi(-1);
end;

procedure OpenA119Scioperi(Id: Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA119Scioperi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA119FPartecipazioneScioperi, A119FPartecipazioneScioperi);
  Application.CreateForm(TA119FPartecipazioneScioperiDM, A119FPartecipazioneScioperiDM);
  if Id > 0 then
    A119FPartecipazioneScioperiDM.selT250.SearchRecord('ID',Id,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    A119FPartecipazioneScioperi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A119FPartecipazioneScioperi.Free;
    A119FPartecipazioneScioperiDM.Free;
  end;
end;

procedure TA119FPartecipazioneScioperi.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A119FPartecipazioneScioperiDM.selT250;
  dcmbCausale.ListSource:=A119FPartecipazioneScioperiDM.A119MW.dsrT265;
  dgrdDettEvento.DataSource:=A119FPartecipazioneScioperiDM.A119MW.dsrT251;
  inherited;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure TA119FPartecipazioneScioperi.FormDestroy(Sender: TObject);
begin
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA119FPartecipazioneScioperi.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=Trim(X);
  end;
begin
  // impedisce di includere i dipendenti cessati nella selezione per lo sciopero
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Enabled:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Checked:=False;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if (DButton.State in [dsEdit,dsInsert]) and (C600frmSelAnagrafe.C600ModalResult = mrOK) then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    //DButton.DataSet.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=TrasformaV430(S);
    DButton.DataSet.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;

procedure TA119FPartecipazioneScioperi.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  SetDescrizioneCausale;
  SetDescrizioneGGNotifica;
end;

procedure TA119FPartecipazioneScioperi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
  drgpTipoGiustClick(nil);
  dcmbCausaleClick(nil);
end;

procedure TA119FPartecipazioneScioperi.OnInserimento;
// metodo da utilizzare in risposta a un inserimento sul dataset
begin
  drgpTipoGiustClick(nil);
  dcmbCausaleClick(nil);
  dedtData.SetFocus;
end;

procedure TA119FPartecipazioneScioperi.pmnDettaglioPopup(Sender: TObject);
// determina gli elementi visibili del popup menu di dettaglio richiesta
var
  Bloccato, Autorizzato: Boolean;
  TipoRich: string;
begin
  with A119FPartecipazioneScioperiDM.A119MW.selT251 do
  begin
    Bloccato:=FieldByName('BLOCCATO').AsString = 'S';
    Autorizzato:=FieldByName('AUTORIZZATO').AsString = 'S';
    TipoRich:=FieldByName('TIPO_RICHIESTA').AsString;
  end;

  // visibilità elementi
  // visualizzazione dettaglio
  actVisDettaglioDip.Visible:=True;
  // blocco / sblocco riepiloghi
  actBloccaRiepiloghi.Visible:=not Bloccato;
  actSbloccaRiepiloghi.Visible:=Bloccato;
  // annullamento autorizzazione
  actAnnullaAut.Visible:=Autorizzato;
  // importazione giustificativi
  actImporta.Visible:=Autorizzato and (TipoRich = A119_TR_D);
end;

procedure TA119FPartecipazioneScioperi.rgpAutorizzateClick(Sender: TObject);
// filtra le notifiche
begin
  A119FPartecipazioneScioperiDM.A119MW.FiltraNotifiche(rgpAutorizzate.ItemIndex,rgpBloccate.ItemIndex);
end;

procedure TA119FPartecipazioneScioperi.rgpBloccateClick(Sender: TObject);
begin
  A119FPartecipazioneScioperiDM.A119MW.FiltraNotifiche(rgpAutorizzate.ItemIndex,rgpBloccate.ItemIndex);
end;

procedure TA119FPartecipazioneScioperi.dcmbCausaleClick(Sender: TObject);
begin
  SetDescrizioneCausale;
end;

procedure TA119FPartecipazioneScioperi.dcmbCausaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  // gestione pulizia campo
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA119FPartecipazioneScioperi.dedtGGNotificaChange(Sender: TObject);
begin
  inherited;
  SetDescrizioneGGNotifica;
end;

procedure TA119FPartecipazioneScioperi.SetDescrizioneCausale;
begin
  if dcmbCausale.KeyValue = null then
    lblDescCausale.Caption:=''
  else
    lblDescCausale.Caption:=VarToStr(A119FPartecipazioneScioperiDM.A119MW.selT265.Lookup('CODICE',dcmbCausale.KeyValue,'DESCRIZIONE'));
end;

procedure  TA119FPartecipazioneScioperi.SetDescrizioneGGNotifica;
var
  DataSciopero: TDateTime;
  NumGG: Integer;
  DataIniStr: String;
begin
  lblDescGGNotifica.Caption:='';
  if (dedtData.Text <> '') and (dedtGGNotifica.Text <> '') then
  begin
    if (TryStrToDate(dedtData.Text,DataSciopero)) and
       (TryStrToInt(dedtGGNotifica.Text,NumGG)) then
    begin
      DataIniStr:=FormatDateTime('dd/mm/yyyy',DataSciopero - NumGG);
      lblDescGGNotifica.Caption:=Format('(a partire dal %s)',[DataIniStr]);
    end;
  end;
end;

procedure TA119FPartecipazioneScioperi.drgpTipoGiustClick(Sender: TObject);
begin
  inherited;
  // abilitazione dei dati da ore / a ore in base al tipo giustificativo
  dedtDaOre.Enabled:=drgpTipoGiust.ItemIndex > 0;
  dedtAOre.Enabled:=drgpTipoGiust.ItemIndex > 2;
  lblDaOre.Enabled:=dedtDaOre.Enabled;
  lblAOre.Enabled:=dedtAOre.Enabled;
  if drgpTipoGiust.ItemIndex = 1 then
    dedtDaOre.Text:='';
end;

// #######################################################################
// ################## AZIONI SULLA TABELLA DI DETTAGLIO ##################
// #######################################################################

procedure TA119FPartecipazioneScioperi.actVisDettaglioDipExecute(Sender: TObject);
// visualizza dettaglio dipendenti tramite form a popup
var
  Largh: Integer;
begin
  with A119FPartecipazioneScioperiDM.A119MW do
  begin
    CaricaDettaglioDipendenti(selT251.FieldByName('ID').AsInteger);

    Largh:=400 + IfThen(selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible,150);
    OpenC020VisualizzaDataSet(Format('Notifica adesione sciopero di %s',[selT251.FieldByName('NOMINATIVO').AsString]),
                              selT252,Largh,400);
  end;
end;

procedure TA119FPartecipazioneScioperi.actAnnullaAutExecute(Sender: TObject);
// annulla l'autorizzazione della richiesta
var
  Id, Prog: Integer;
  Autorizzato: Boolean;
  Data: TDateTime;
  Msg: String;
begin
  with A119FPartecipazioneScioperiDM.A119MW do
  begin
    Id:=selT251.FieldByName('ID').AsInteger;
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Data:=selT251.FieldByName('DATA').AsDateTime;
    Autorizzato:=selT251.FieldByName('AUTORIZZATO').AsString = 'S';

    // azione impedita se richiesta non autorizzata
    if not Autorizzato then
      raise Exception.Create('Impossibile annullare l''autorizzazione ad una richiesta non autorizzata');

    try
      // effettua annullamento autorizzazione
      AnnullaAutorizzazione(Id,Prog,Data);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      Msg:='Annullamento effettuato!';
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Msg:=Format('Annullamento non effettuato: %s',[E.Message]);
      end;
    end;

    // aggiornamento tabella
    selT251.Close;
    selT251.Open;

    // messaggio finale
    R180MessageBox(Msg,INFORMA);
  end;
end;

procedure TA119FPartecipazioneScioperi.actBloccaRiepiloghiExecute(Sender: TObject);
// blocca / sblocca i riepiloghi in base al corrispondente flag della richiesta
var
  Bloccato: Boolean;
  Prog: Integer;
  Data: TDateTime;
  Msg: String;
begin
  with A119FPartecipazioneScioperiDM.A119MW do
  begin
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Data:=selT251.FieldByName('DATA').AsDateTime;
    Bloccato:=selT251.FieldByName('BLOCCATO').AsString = 'S';

    try
      // effettua blocco / sblocco riepiloghi T250 in base al flag
      if Bloccato then
        SbloccaRiepiloghiT250(Prog,Data)
      else
        BloccaRiepiloghiT250(Prog,Data);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      Msg:=Format('%s riepiloghi effettuato!',[IfThen(Bloccato,'Sblocco','Blocco')]);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        Msg:=Format('%s riepiloghi non effettuato!',[IfThen(Bloccato,'Sblocco','Blocco')]);
      end;
    end;

    // aggiornamento tabella
    selT251.Close;
    selT251.Open;

    // messaggio finale
    R180MessageBox(Msg,INFORMA);
  end;
end;

procedure TA119FPartecipazioneScioperi.actImportaExecute(Sender: TObject);
// effettua l'inserimento dei giustificativi sui dipendenti compresi nella richiesta selezionata
var
  Autorizzato: Boolean;
  Id, Prog: Integer;
  TipoRichiesta: String;
begin
  with A119FPartecipazioneScioperiDM.A119MW do
  begin
    Id:=selT251.FieldByName('ID').AsInteger;
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Autorizzato:=selT251.FieldByName('AUTORIZZATO').AsString = 'S';
    TipoRichiesta:=selT251.FieldByName('TIPO_RICHIESTA').AsString;

    // azione impedita se richiesta non autorizzata
    if not Autorizzato then
      raise Exception.Create('Impossibile importare una richiesta non autorizzata');

    // azione impedita se richiesta non da importare
    if TipoRichiesta <> A119_TR_D then
      raise Exception.Create('Impossibile importare una richiesta non definitiva');

    // visibilità campi per esito importazione
    selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible:=True;
    selT252.FieldByName('D_ANOMALIE').Visible:=True;

    // importa i giustificativi per la richiesta
    try
      ImportaGiustificativi(Id,Prog);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      R180MessageBox('Importazione effettuata',INFORMA);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        R180MessageBox('Importazione non effettuata a causa di anomalie.'#13#10'Verificare il dettaglio.',INFORMA);
        // visualizza anomalie importazione
        actVisDettaglioDipExecute(nil);
      end;
    end;

    // aggiornamento tabella
    selT251.Close;
    selT251.Open;
  end;
end;

procedure TA119FPartecipazioneScioperi.actImportaTuttiExecute(Sender: TObject);
// effettua l'inserimento dei giustificativi per tutte le richieste presenti
var
  NumElab,NumErr: Integer;
begin
  // conferma operazione
  if R180MessageBox('Confermi l''importazione dei giustificativi per tutte le richieste autorizzate?',DOMANDA) = mrNo then
    Exit;

  // ciclo sulle richieste autorizzate per importazione
  NumElab:=0;
  NumErr:=0;
  with A119FPartecipazioneScioperiDM.A119MW do
  begin
    PulisciAnomalieImportazione;
    selT251.First;
    while not selT251.Eof do
    begin
      if (selT251.FieldByName('AUTORIZZATO').AsString = 'S') and
         (selT251.FieldByName('TIPO_RICHIESTA').AsString = A119_TR_D) then
      begin
        // importa i giustificativi per la richiesta
        try
          inc(NumElab);
          ImportaGiustificativi(selT251.FieldByName('ID').AsInteger,selT251.FieldByName('PROGRESSIVO').AsInteger);
          SessioneOracle.Commit;
        except
          on E: Exception do
          begin
            inc(NumErr);
            SessioneOracle.Rollback;
          end;
        end;
      end;
      selT251.Next;
    end;
  end;

  // messaggio finale
  if NumElab = 0 then
  begin
    // nessuna richiesta importata
    R180MessageBox('Nessuna richiesta da importare!',INFORMA);
  end
  else
  begin
    // una o più richieste importate

    // visibilità campi per esito importazione
    A119FPartecipazioneScioperiDM.A119MW.selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible:=True;
    A119FPartecipazioneScioperiDM.A119MW.selT252.FieldByName('D_ANOMALIE').Visible:=True;

    // aggiorna tabella
    A119FPartecipazioneScioperiDM.A119MW.selT251.Close; // v. evento OnCalcFields
    A119FPartecipazioneScioperiDM.A119MW.selT251.Open; // v. evento OnCalcFields

    // messaggio
    if NumErr = 0 then
    begin
      R180MessageBox('Importazione di tutti i giustificativi effettuata correttamente',INFORMA);
    end
    else
    begin
      R180MessageBox('Importazione di tutti i giustificativi effettuata con errori.'#13#10 +
                     'Una o più richieste non sono state importate.',ESCLAMA);
    end;
  end;
end;

end.
