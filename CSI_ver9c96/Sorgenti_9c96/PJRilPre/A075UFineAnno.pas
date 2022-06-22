unit A075UFineAnno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, C001StampaLib, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia,
  ExtCtrls,DB,checklst, ComCtrls, C700USelezioneAnagrafe, C012UVisualizzaTesto,
  Mask,C004UParamForm, Menus, SelAnagrafe, C005UDatiAnagrafici,
  Variants, A075UFineAnnoMW, A083UMsgElaborazioni, System.StrUtils;


type
  TA075FFineAnno = class(TForm)
    LDaData: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    chkCalendari: TCheckBox;
    chkProfiliAsse: TCheckBox;
    EAnno: TMaskEdit;
    chkResiduiBuoniTicket: TCheckBox;
    chkProfiliIndividuali: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    grpLimitiEccedenze: TGroupBox;
    chkLimitiIndividualiMensili: TCheckBox;
    chkLimitiMensili: TCheckBox;
    rgpLimiti: TRadioGroup;
    chkResiduiCrediti: TCheckBox;
    chkDebitiAggiuntivi: TCheckBox;
    chkDebitiAggiuntiviIndiv: TCheckBox;
    chkTriggerBefore: TCheckBox;
    chkTriggerAfter: TCheckBox;
    chkResiduiOre: TCheckBox;
    chkResiduiAsse: TCheckBox;
    grpResiduiAssenza: TGroupBox;
    memResiduiAssenza: TMemo;
    chkLimitiIndividualiAnnuali: TCheckBox;
    btnSrcResiduiTriggerBefore: TBitBtn;
    btnSrcResiduiTriggerAfter: TBitBtn;
    chkLimitiIndividualiAnnualiOvr: TCheckBox;
    chkLimitiIndividualiMensiliOvr: TCheckBox;
    chkResiduiBuoniTicketOvr: TCheckBox;
    chkResiduiOreOvr: TCheckBox;
    chkResiduiAsseOvr: TCheckBox;
    pnlAzioni: TPanel;
    BtnStampa: TBitBtn;
    btnAnomalie: TBitBtn;
    BtnClose: TBitBtn;
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EAnnoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnSrcResiduiTriggerBeforeClick(Sender: TObject);
    procedure chkResiduiBuoniTicketClick(Sender: TObject);
    procedure chkResiduiOreClick(Sender: TObject);
    procedure chkResiduiAsseClick(Sender: TObject);
    procedure chkLimitiIndividualiAnnualiClick(Sender: TObject);
    procedure chkLimitiIndividualiMensiliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkLimitiMensiliClick(Sender: TObject);
  private
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScorriQueryAnagrafica;
    procedure LogContatoriResidui;
  end;

var
  A075FFineAnno: TA075FFineAnno;

procedure OpenA075FineAnno(Prog:LongInt);

implementation

uses A075UFineAnnoDtM1;

{$R *.DFM}

procedure OpenA075FineAnno(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA075FineAnno') of
    'N','R':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A075FFineAnno:=TA075FFineAnno.Create(nil);
  with A075FFineAnno do
    try
      C700Progressivo:=Prog;
      A075FFineAnnoDtM1:=TA075FFineAnnoDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A075FFineAnnoDtM1.Free;
      Free;
    end;
end;

procedure TA075FFineAnno.btnSrcResiduiTriggerBeforeClick(Sender: TObject);
var
  LLst: TStringList;
  LObjName: string;
  LTitolo: string;
begin
  if Sender = btnSrcResiduiTriggerBefore then
  begin
    LObjName:='RESIDUI_TRIGGER_BEFORE';
    LTitolo:='Sorgente procedura Oracle eseguita prima del calcolo dei residui';
  end
  else if Sender = btnSrcResiduiTriggerAfter then
  begin
    LObjName:='RESIDUI_TRIGGER_AFTER';
    LTitolo:='Sorgente procedura Oracle eseguita dopo il calcolo dei residui';
  end;

  Screen.Cursor:=crHourGlass;
  LLst:=TStringList.Create;
  try
    R180OracleObjectSource(LObjName,SessioneOracle,LLst);
    OpenC012VisualizzaTesto(LTitolo,'',LLst);
  finally
    FreeAndNil(LLst);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA075FFineAnno.BtnStampaClick(Sender: TObject);
var
  LMsg: String;
  LDatiNonSovrascritti: String;
begin
  // determina le eventuali opzioni da ribaltare sul nuovo anno, ma da non sovrascrivere se già presenti
  LDatiNonSovrascritti:='';
  if chkLimitiIndividualiAnnuali.Checked and not chkLimitiIndividualiAnnualiOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + '- limiti eccedenze individuali annuali'#13#10;
  if chkLimitiIndividualiMensili.Checked and not chkLimitiIndividualiMensiliOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + '- limiti eccedenze individuali mensili'#13#10;
  if chkResiduiBuoniTicket.Checked and not chkResiduiBuoniTicketOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiBuoniTicket.Caption)]);
  if chkResiduiOre.Checked and not chkResiduiOreOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiOre.Caption)]);
  if chkResiduiAsse.Checked and not chkResiduiAsseOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiAsse.Caption)]);

  // prepara il messaggio di conferma operazione
  LMsg:='Verranno generati i dati per l''anno ' + EAnno.Text + '.'#13#10;
  if LDatiNonSovrascritti <> '' then
    LMsg:=LMsg +
          'Attenzione!'#13#10 +
          'I seguenti dati non verranno sovrascritti da questa elaborazione:'#13#10 +
          LDatiNonSovrascritti;
  if R180MessageBox(LMsg + 'Vuoi continuare?',DOMANDA) = mrNo then
    Exit;

  // operazioni iniziali
  btnAnomalie.Enabled:=False;
  A075FFineAnnoDtM1.A075MW.selDatiBloccati.Close;
  RegistraMsg.IniziaMessaggio('A075');
  A075FFineAnnoDtM1.A075MW.NuovoAnno:=EAnno.Text;

  // elaborazione
  ScorriQueryAnagrafica;

  // verifica esito elaborazione
  if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
  begin
    btnAnomalie.Enabled:=True;
    if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA075FFineAnno.chkLimitiIndividualiAnnualiClick(Sender: TObject);
begin
  chkLimitiIndividualiAnnualiOvr.Enabled:=chkLimitiIndividualiAnnuali.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkLimitiIndividualiAnnualiOvr.Checked:=False;
end;

procedure TA075FFineAnno.chkLimitiIndividualiMensiliClick(Sender: TObject);
begin
  chkLimitiIndividualiMensiliOvr.Enabled:=chkLimitiIndividualiMensili.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkLimitiIndividualiMensiliOvr.Checked:=False;
  // determina se visualizzare il radiogroup di opzione dei limiti mensili
  rgpLimiti.Visible:=(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked);
end;

procedure TA075FFineAnno.chkLimitiMensiliClick(Sender: TObject);
begin
  // determina se visualizzare il radiogroup di opzione dei limiti mensili
  rgpLimiti.Visible:=(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked);
end;

procedure TA075FFineAnno.chkResiduiAsseClick(Sender: TObject);
begin
  chkResiduiAsseOvr.Enabled:=chkResiduiAsse.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiAsseOvr.Checked:=False;
end;

procedure TA075FFineAnno.chkResiduiBuoniTicketClick(Sender: TObject);
begin
  chkResiduiBuoniTicketOvr.Enabled:=chkResiduiBuoniTicket.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiBuoniTicketOvr.Checked:=False;
end;

procedure TA075FFineAnno.chkResiduiOreClick(Sender: TObject);
begin
  chkResiduiOreOvr.Enabled:=chkResiduiOre.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiOreOvr.Checked:=False;
end;

procedure TA075FFineAnno.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A075','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A075FFineAnnoDtM1.A075MW);
end;

procedure TA075FFineAnno.ScorriQueryAnagrafica;
begin
  Screen.Cursor:=crHourGlass;
  with A075FFineAnnoDtM1.A075MW do
  begin
    lstCausali.Clear;
    lstCausali.Add(Format('%-7s %-11s %-13s',['Causale','Raggr.caus.','Raggr.residui']));
    lstCausali.Add('');
    memResiduiAssenza.Lines.Clear;
    NuovoAnno:=EAnno.Text;

    // salva le opzioni selezionate sul middleware
    Opzioni.TriggerBefore:=chkTriggerBefore.Checked;
    Opzioni.TriggerAfter:=chkTriggerAfter.Checked;

    Opzioni.Calendari:=chkCalendari.Checked;
    Opzioni.ProfiliAsse:=chkProfiliAsse.Checked;
    Opzioni.ProfiliIndividuali:=chkProfiliIndividuali.Checked;
    Opzioni.DebitiAggiuntivi:=chkDebitiAggiuntivi.Checked;
    Opzioni.DebitiAggiuntiviIndiv:=chkDebitiAggiuntiviIndiv.Checked;
    Opzioni.LimitiIndividualiMensili.Selected:=chkLimitiIndividualiMensili.Checked;
    Opzioni.LimitiIndividualiMensili.Overwrite:=chkLimitiIndividualiMensiliOvr.Checked;
    Opzioni.LimitiIndividualiAnnuali.Selected:=chkLimitiIndividualiAnnuali.Checked;
    Opzioni.LimitiIndividualiAnnuali.Overwrite:=chkLimitiIndividualiAnnualiOvr.Checked;
    Opzioni.LimitiMensili:=chkLimitiMensili.Checked;
    Opzioni.LimitiItemIndex:=rgpLimiti.ItemIndex;

    Opzioni.ResiduiBuoniTicket.Selected:=chkResiduiBuoniTicket.Checked;
    Opzioni.ResiduiBuoniTicket.Overwrite:=chkResiduiBuoniTicketOvr.Checked;
    Opzioni.ResiduiCrediti:=chkResiduiCrediti.Checked;
    Opzioni.ResiduiOre.Selected:=chkResiduiOre.Checked;
    Opzioni.ResiduiOre.Overwrite:=chkResiduiOreOvr.Checked;
    Opzioni.ResiduiAsse.Selected:=chkResiduiAsse.Checked;
    Opzioni.ResiduiAsse.Overwrite:=chkResiduiAsseOvr.Checked;

    // azzera i dati di riepilogo per le statistiche di elaborazione
    RiepilogoElab.Clear;

    // esegue i passaggi selezionati
    RegistraMsg.InserisciMessaggio('I',Format('Generazione dei dati per l''anno %s',[NuovoAnno]));

    // calendari
    if chkCalendari.Checked then
    begin
      StatusBar1.Panels[1].Text:='Generazione calendari';
      StatusBar1.Repaint;
      GeneraCalendario;
    end;

    // profili assenza
    if chkProfiliAsse.Checked then
    begin
      StatusBar1.Panels[1].Text:='Generazione profili assenze';
      StatusBar1.Repaint;
      GeneraProfili;
    end;

    // debiti aggiuntivi
    if chkDebitiAggiuntivi.Checked then
    begin
      StatusBar1.Panels[1].Text:='Generazione debiti aggiuntivi';
      StatusBar1.Repaint;
      GeneraDebiti;
    end;

    // limiti eccedenze mensili
    if chkLimitiMensili.Checked then
    begin
      StatusBar1.Panels[1].Text:='Generazione limiti eccedenze mensili';
      StatusBar1.Repaint;
      GeneraLimitiMensili(rgpLimiti.ItemIndex);
    end;

    // limiti individuali
    if (chkResiduiOre.Checked) or (chkResiduiAsse.Checked) or (chkResiduiBuoniTicket.Checked) or
       (chkProfiliIndividuali.Checked) or (chkDebitiAggiuntiviIndiv.Checked) or
       (chkLimitiIndividualiMensili.Checked) or (chkLimitiIndividualiAnnuali.Checked) or
       (chkResiduiCrediti.Checked) then
    begin
      StatusBar1.Panels[1].Text:='Generazione residui';
      StatusBar1.Repaint;

      if C700SelAnagrafe.GetVariable('DATALAVORO') <> DataRif then
      begin
        C700SelAnagrafe.Close;
        C700SelAnagrafe.SetVariable('DATALAVORO',DataRif);
        C700SelAnagrafe.Open;
      end;
      C700SelAnagrafe.First;
      ProgressBar1.Position:=0;
      ProgressBar1.Max:=C700SelAnagrafe.RecordCount;

      // log su messaggi elaborazioni
      if C700SelAnagrafe.RecordCount > 0 then
      begin
        RegistraMsg.InserisciMessaggio('I',Format('Inizio elaborazione dei dati individuali per %d anagrafiche',[C700SelAnagrafe.RecordCount]));
        if chkTriggerBefore.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkTriggerBefore.Caption]));
        if chkTriggerAfter.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkTriggerAfter.Caption]));
        if chkProfiliIndividuali.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkProfiliIndividuali.Caption]));
        if chkDebitiAggiuntiviIndiv.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkDebitiAggiuntiviIndiv.Caption]));
        if chkLimitiIndividualiAnnuali.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkLimitiIndividualiAnnuali.Caption,IfThen(chkLimitiIndividualiAnnualiOvr.Checked,'con','senza')]));
        if chkLimitiIndividualiMensili.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkLimitiIndividualiMensili.Caption,IfThen(chkLimitiIndividualiMensiliOvr.Checked,'con','senza')]));
        if chkLimitiMensili.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkLimitiMensili.Caption]));
        if rgpLimiti.Visible then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: tipo ribaltamento limiti mensili: %s',[rgpLimiti.Items[rgpLimiti.ItemIndex]]));
        if chkResiduiBuoniTicket.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiBuoniTicket.Caption,IfThen(chkResiduiBuoniTicketOvr.Checked,'con','senza')]));
        if chkResiduiCrediti.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkResiduiCrediti.Caption]));
        if chkResiduiOre.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiOre.Caption,IfThen(chkResiduiOreOvr.Checked,'con','senza')]));
        if chkResiduiAsse.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiAsse.Caption,IfThen(chkResiduiAsseOvr.Checked,'con','senza')]));
      end
      else
      begin
        RegistraMsg.InserisciMessaggio('I','Elaborazione dei dati individuali non effettuata: nessuna anagrafica selezionata');
      end;

      // ciclo di elaborazione sulle anagrafiche selezionate
      frmSelAnagrafe.ElaborazioneInterrompibile:=True;
      Self.Enabled:=False;
      try
        while not C700SelAnagrafe.Eof do
        begin
          frmSelAnagrafe.VisualizzaDipendente;
          ProgressBar1.StepBy(1);
          ProgrAnagafica:=C700Progressivo;
          SelAnagrafeRapportiUniti:=C700SelAnagrafe.FieldByName('RAPPORTI_UNITI').AsString;
          ResiduiDipendente;
          C700SelAnagrafe.Next;
        end;
      finally
        if C700SelAnagrafe.RecordCount > 0 then
          RegistraMsg.InserisciMessaggio('I','Fine elaborazione dei dati individuali');

        // registra i contatori dei residui
        LogContatoriResidui;

        frmSelAnagrafe.ElaborazioneInterrompibile:=False;
        Self.Enabled:=True;
        frmSelAnagrafe.VisualizzaDipendente;
      end;
    end;
  end;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
  StatusBar1.Panels[1].Text:='Operazione terminata';
  RegistraMsg.InserisciMessaggio('I','Elaborazione terminata');
  memResiduiAssenza.Lines.Assign(A075FFineAnnoDtM1.A075MW.lstCausali);
end;

procedure TA075FFineAnno.LogContatoriResidui;
// registra i contatori dei dati non sovrascritti come anomalie di cui tenere conto
var
  LRiep: TDatiRiepilogo;
begin
  LRiep:=A075FFineAnnoDtM1.A075MW.RiepilogoElab;

  if LRiep.LimitiIndividualiMensili.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Limiti delle ecc. individuali mensili: %d record già presenti non sono stati sovrascritti',[LRiep.LimitiIndividualiMensili.ContaNonSovrascritti]));
  if LRiep.LimitiIndividualiAnnuali.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Limiti delle ecc. individuali annuali: %d record già presenti non sono stati sovrascritti',[LRiep.LimitiIndividualiAnnuali.ContaNonSovrascritti]));
  if LRiep.ResiduiBuoniTicket.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui buoni pasto / ticket: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiBuoniTicket.ContaNonSovrascritti]));
  if LRiep.ResiduiOre.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui saldo ore annuo: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiOre.ContaNonSovrascritti]));
  if LRiep.ResiduiAssenze.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui assenze: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiAssenze.ContaNonSovrascritti]));
end;

procedure TA075FFineAnno.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A075',Parametri.ProgOper);
  GetParametriFunzione;

  // opzioni per procedure before / after residui
  chkTriggerBefore.Enabled:=A075FFineAnnoDtM1.A075MW.EsisteProcResiduiBefore;
  btnSrcResiduiTriggerBefore.Visible:=A075FFineAnnoDtM1.A075MW.EsisteProcResiduiBefore;
  if chkTriggerBefore.Enabled then
  begin
    // se è specificata l'opzione aziendale di impostazione, utilizza questa
    if Parametri.CampiRiferimento.C35_ResiduiTriggerBefore <> '' then
      chkTriggerBefore.Checked:=Parametri.CampiRiferimento.C35_ResiduiTriggerBefore = 'S';
  end
  else
  begin
    chkTriggerBefore.Checked:=False;
  end;
  chkTriggerAfter.Enabled:=A075FFineAnnoDtM1.A075MW.EsisteProcResiduiAfter;
  btnSrcResiduiTriggerAfter.Visible:=A075FFineAnnoDtM1.A075MW.EsisteProcResiduiAfter;
  if chkTriggerAfter.Enabled then
  begin
    // se è specificata l'opzione aziendale di impostazione, utilizza questa
    if Parametri.CampiRiferimento.C35_ResiduiTriggerAfter <> '' then
      chkTriggerAfter.Checked:=Parametri.CampiRiferimento.C35_ResiduiTriggerAfter = 'S';
  end
  else
  begin
    chkTriggerAfter.Checked:=False;
  end;

  EAnno.Text:=FormatDateTime('yyyy',Parametri.DataLavoro);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',RAPPORTI_UNITI';
  C700DataLavoro:=Parametri.DataLavoro;
  A075FFineAnnoDtM1.A075MW.DataRif:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
  frmSelAnagrafe.CreaSelAnagrafe(A075FFineAnnoDtM1.A075MW,SessioneOracle,StatusBar1,0,False);
  btnAnomalie.Enabled:=False;
end;

procedure TA075FFineAnno.EAnnoChange(Sender: TObject);
var
  LAnno: Integer;
begin
  // imposta la data di riferimento al 1 gennaio dell'anno indicato
  {
  try
    A075FFineAnnoDtM1.A075MW.DataRif:=EncodeDate(StrToInt(EAnno.Text),1,1);
  except
  end;
  }
  if TryStrToInt(EAnno.Text, LAnno) then
    TryEncodeDate(LAnno,1,1,A075FFineAnnoDtM1.A075MW.DataRif);
end;

procedure TA075FFineAnno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA075FFineAnno.FormCreate(Sender: TObject);
begin
  rgpLimiti.Visible:=False;
end;

procedure TA075FFineAnno.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA075FFineAnno.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA075FFineAnno.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA075FFineAnno.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  if chkTriggerBefore.Checked then
    C004FParamForm.PutParametro('TRIGGER_BEFORE','S')
  else
    C004FParamForm.PutParametro('TRIGGER_BEFORE','N');
  if chkTriggerAfter.Checked then
    C004FParamForm.PutParametro('TRIGGER_AFTER','S')
  else
    C004FParamForm.PutParametro('TRIGGER_AFTER','N');
  try SessioneOracle.Commit; except end;
end;

procedure TA075FFineAnno.GetParametriFunzione;
begin
  chkTriggerBefore.Checked:=C004FParamForm.GetParametro('TRIGGER_BEFORE','N') = 'S';
  chkTriggerAfter.Checked:=C004FParamForm.GetParametro('TRIGGER_AFTER','N') = 'S';
end;

end.
