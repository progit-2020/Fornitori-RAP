unit P656UElaborazioneFLUPER;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, ComCtrls, ExtCtrls, Grids, DBGrids, Mask, Oracle,
  OracleData, C001StampaLib, C004UParamForm, C005UDatiAnagrafici,
  C180FunzioniGenerali, C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia,
  P999UGenerale, SelAnagrafe, Menus, Spin, Variants,
  Math, A083UMsgElaborazioni, P946UCalcoloFLUPERDtm, A000UMessaggi;

type
  TP656FElaborazioneFLUPER = class(TForm)
    Panel0: TPanel;
    Panel1: TPanel;
    pnlElaborazioni: TPanel;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnDisattivaElaborazioni: TBitBtn;
    btnAnomalie: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkEsportazioneFile: TCheckBox;
    chkElaboraDatiFLUSSOA: TCheckBox;
    lblNomeFileOutput: TLabel;
    edtNomeFileOutput: TEdit;
    sbtNomeFileOutput: TSpeedButton;
    SaveDialog1: TSaveDialog;
    lblMeseElaborazione: TLabel;
    edtMeseDa: TMaskEdit;
    sbtMeseDa: TSpeedButton;
    lblDataChiusura: TLabel;
    edtDataChiusura: TMaskEdit;
    sbtDataChiusura: TSpeedButton;
    btnVisualizzaFile: TBitBtn;
    rgpStatoCedolini: TRadioGroup;
    chkChiusura: TCheckBox;
    chkAnnullaFLUPER: TCheckBox;
    chkElaboraDatiFLUSSOB1_36: TCheckBox;
    chkElaboraDatiFLUSSOB37: TCheckBox;
    Label1: TLabel;
    sbtMeseA: TSpeedButton;
    edtMeseA: TMaskEdit;
    RbtA: TRadioButton;
    RbtB: TRadioButton;
    pnlBar: TPanel;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDisattivaElaborazioniClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure sbtMeseDaClick(Sender: TObject);
    procedure sbtNomeFileOutputClick(Sender: TObject);
    procedure chkElaboraDatiFLUSSOAClick(Sender: TObject);
    procedure sbtDataChiusuraClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure sbtMeseAClick(Sender: TObject);
    procedure RbtAClick(Sender: TObject);
    procedure RbtBClick(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure edtMeseADblClick(Sender: TObject);
  private
    { Private declarations }
    dPv_DataInizio, dPv_DataFine:TDateTime;
    Id_FLUSSO_Aperto:Integer;
    //Variabili per calcolo
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneDipendenti(nMesiDaElaborare:integer);
    procedure EstrazioneDipendenti(nMesiDaElaborare:integer);
    procedure DisabilitaComponenti;
    procedure AbilitaComponenti;
    procedure AbilitazioniIniziali;
    procedure ChiusuraFornitura(nMesiDaElaborare:integer);
  end;

var
  P656FElaborazioneFLUPER: TP656FElaborazioneFLUPER;

procedure OpenP656FElaborazioneFLUPER(Prog:LongInt);

implementation

uses R004UGestStoricoDTM, P656UElaborazioneFLUPERDtm, C012UVisualizzaTesto,
     A003UDataLavoroBis;

{$R *.DFM}

procedure OpenP656FElaborazioneFLUPER(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP656FElaborazioneFLUPER') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP656FElaborazioneFLUPERDtm,P656FElaborazioneFLUPERDtm);
  Application.CreateForm(TP656FElaborazioneFLUPER,P656FElaborazioneFLUPER);
  C700Progressivo:=Prog;
  try
    P656FElaborazioneFLUPER.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P656FElaborazioneFLUPER.Free;
    P656FElaborazioneFLUPERDtm.Free;
  end;
end;

procedure TP656FElaborazioneFLUPER.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
  if edtDataChiusura.Text = '  /  /    ' then
    edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
end;

procedure TP656FElaborazioneFLUPER.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P656',Parametri.ProgOper);
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DatiSelezionati:=C700CampiBase + ',DATANAS';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;  //Commessa: MAN/08 SVILUPPO#184 riesame del 20/03
  frmSelAnagrafe.CreaSelAnagrafe(P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW, SessioneOracle,StatusBar,0,False);
  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
  //Impostazione abilitazioni iniziali sui componenti
  AbilitazioniIniziali;
end;

procedure TP656FElaborazioneFLUPER.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP656FElaborazioneFLUPER.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not btnChiudi.Enabled then
    Action:=caNone
  else
  begin
    PutParametriFunzione;
    C004FParamForm.Free;
  end;
end;

procedure TP656FElaborazioneFLUPER.btnEseguiClick(Sender: TObject);
var
  d,dd,m,mm,y,yy:Word;
  nMesiDaElaborare:integer;
begin
  //Setto stato di non presenza di anomalie
  RegistraMsg.IniziaMessaggio('P656');
  dPv_DataInizio:=R180InizioMese(StrToDate('01/'+edtMeseDa.Text));
  dPv_DataFine:=R180FineMese(StrToDate('01/'+edtMeseA.Text));
  DecodeDate(dPv_DataInizio,y,m,d);
  DecodeDate(dPv_DataFine,yy,mm,dd);
  if yy <> y then
  //if dPv_DataFine < dPv_DataInizio then  MAN/08 SVILUPPO#184 riesame del 20/03/2015 errore test date
  begin
    edtMeseDa.SetFocus;
    raise exception.create(A000MSG_P656_ERR_DATE_ANNO);
  end;
  if mm < m then
  begin
    edtMeseA.SetFocus;
    raise exception.create(A000MSG_P656_ERR_MESE);
  end;
  //Elaborazione o Annullamento del Flusso
  nMesiDaElaborare:=(mm-m)+1;
  if chkElaboraDatiFlussoA.Checked or
     chkElaboraDatiFlussoB1_36.Checked or
     chkElaboraDatiFLUSSOB37.Checked or
     chkAnnullaFLUPER.Checked then
    ElaborazioneDipendenti(nMesiDaElaborare);
  //Chiusura della fornitura
  if chkChiusura.Checked then
    if (R180MessageBox(A000MSG_P656_DLG_CHIUSURA,DOMANDA) = mrYes) then
      ChiusuraFornitura(nMesiDaElaborare);
  //Esportazione dati su file sequenziale
  if chkEsportazioneFile.Checked then
    EstrazioneDipendenti(nMesiDaElaborare);
  if Registramsg.ContieneTipoA then
  begin
    if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata correttamente.',INFORMA);
end;

procedure TP656FElaborazioneFLUPER.ElaborazioneDipendenti(nMesiDaElaborare:integer);
//Ciclo di scorrimento ed elaborazione dei dipendenti
var
  dMyData:TDateTime;
  DatiFlup946:TDatiFlup946;
  Msg:String;
begin
  //Verifico se esiste fornitura precedente non chiusa dandone segnalazione
  with P656FElaborazioneFLUPERDtm do
  begin
    Msg:=P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW.VerificaFornitureAnte(R180FineMese(StrToDate('01/'+edtMeseA.Text)));
    if Msg <> '' then
    begin
      if R180MessageBox(Msg, DOMANDA) = mrNo then
       exit;
    end;

    P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW.InizializzaConteggi(dPv_DataInizio,dPv_DataFine);
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount * nMesiDaElaborare;
    DisabilitaComponenti;
    dMyData:=R180FineMese(dPv_DataInizio);

    DatiFLUP946.ElaboraDatiFLUSSOA:=chkElaboraDatiFLUSSOA.Checked;
    DatiFLUP946.ElaboraDatiFLUSSOB1_36:=chkElaboraDatiFLUSSOB1_36.Checked;
    DatiFLUP946.ElaboraDatiFLUSSOB37:=chkElaboraDatiFLUSSOB37.Checked;
    case rgpStatoCedolini.ItemIndex of
      0:DatiFLUP946.StatoCedolini:='''S''';
      1:DatiFLUP946.StatoCedolini:='''S'',''N''';
      2:DatiFLUP946.StatoCedolini:='''N''';
    end;

    while dMyData <= dPv_DataFine do
    begin
      DatiFLUP946.DataElaborazione:=dMyData;

      //Leggo la testa per impostare Id_FLUSSO_Aperto
      Id_FLUSSO_Aperto:=P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW.TestataFLUPER(DatiFLUP946.DataElaborazione,(chkElaboraDatiFlussoA.Checked) or (chkElaboraDatiFlussoB1_36.Checked) or (chkElaboraDatiFLUSSOB37.Checked));
      Msg:=P656FElaborazioneFluperMW.VerificaIdFlusso(Id_FLUSSO_Aperto,DatiFLUP946.DataElaborazione);
      if Msg <> '' then
      begin
        ProgressBar1.Position:=0;
        AbilitaComponenti;
        raise Exception.Create(msg);
      end;

      //Configuro variabili per calcolo fluper
      DatiFLUP946.ID_FLUPER:=Id_FLUSSO_Aperto;
      try
        //MAN/08 SVILUPPO#184 Riesame del 20/03/2015 su selezione anagrafica
        if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(dMyData), R180FineMese(dMyData)) then
          C700SelAnagrafe.Close;
        C700SelAnagrafe.Open;
        C700SelAnagrafe.First;

        while not C700SelAnagrafe.Eof do
        begin
          frmSelAnagrafe.VisualizzaDipendente;
          Application.ProcessMessages;
          P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW.ElaboraDipendente(DatiFLUP946, chkAnnullaFLUPER.checked);
          ProgressBar1.StepBy(1);
          C700SelAnagrafe.Next;
        end;
        P656FElaborazioneFLUPERDtM.P656FElaborazioneFluperMW.FineElabTestata(DatiFLUP946);
      except
        SessioneOracle.Rollback;
        AbilitaComponenti;
        ProgressBar1.Position:=0;
        raise;
      end;
      dMyData:=R180FineMese(R180AddMesi(dMyData,1));
    end;
    AbilitaComponenti;
    ProgressBar1.Position:=0;    
  end;
end;

procedure TP656FElaborazioneFLUPER.ChiusuraFornitura(nMesiDaElaborare:integer);
//Chiusura della fornitura mensile
var
  dMyData:TDateTime;
  Msg,sAnomalia: string;
begin
  sAnomalia:='';
  screen.Cursor:=crHourglass;
  ProgressBar1.Max:=nMesiDaElaborare;
  DisabilitaComponenti;
  with P656FElaborazioneFLUPERDtm.P656FElaborazioneFluperMW do
  begin
    dMyData:=R180FineMese(dPv_DataInizio);
    while dMyData <= dPv_DataFine do
    begin
      //Leggo la testa per impostare Id_FLUSSO_Aperto
      Id_FLUSSO_Aperto:=TestataFLUPER(dMyData,(chkElaboraDatiFlussoA.Checked) or (chkElaboraDatiFlussoB1_36.Checked) or (chkElaboraDatiFLUSSOB37.Checked));
      Msg:=VerificaIdFlusso(Id_FLUSSO_Aperto,dMyData);
      if Msg <> '' then
      begin
        screen.Cursor:=crDefault;
        AbilitaComponenti;
        //23/03/2015 in caso di errore durante il ciclo mancava rollback. meglio tardi che mai
        SessioneOracle.Rollback;
        raise Exception.Create(msg);
      end;
      //caratto 20/03/2015 VerificaIdFlusso controlla che id_flusso sia > 0 pertanto il test successivo
      //è inutile e fuorviante.
      (*
      if Id_FLUSSO_Aperto <> 0 then
      begin
        updP662.SetVariable('IdFLUPER',Id_FLUSSO_Aperto);
        updP662.SetVariable('DataChiusura',StrToDate(edtDataChiusura.Text));
        updP662.Execute;
      end
      else
        //Segnalazione anomalia di non esistenza elaborato da chiudere
        sAnomalia:=sAnomalia + 'Non esiste fornitura da chiudere relativa al mese ' + FormatDateTime('mm/yyyy',dMyData) + #$A#$D;
      *)
      ChiudiFornitura(Id_FLUSSO_Aperto,StrToDate(edtDataChiusura.Text));

      dMyData:=R180FineMese(R180AddMesi(dMyData,1));
    end;
    //caratto 20/03/2015 togliendo il test Id_FLUSSO_Aperto <> 0 diventa inutile il registramsg
    (*
    if sAnomalia <> '' then
    begin
      //Registra anomalie
      RegistraMsg.InserisciMessaggio('A',sAnomalia,'');
    end;
    *)
    SessioneOracle.Commit;
  end;
  AbilitaComponenti;
  screen.Cursor:=crDefault;
end;

procedure TP656FElaborazioneFLUPER.EstrazioneDipendenti(nMesiDaElaborare:integer);
//Estrazione su file dei dati dei dipendenti selezionati
var
  dMyData:TDateTime;
  Msg: String;
  F: TextFile;
begin
  //Lettura record di setup
  with P656FElaborazioneFLUPERDtm.P656FElaborazioneFluperMW do
  begin
    Msg:=VerificaEstrazione(dPv_DataInizio,dPv_DataFine);
    if Msg <> '' then
    begin
      R180MessageBox(Msg, ERRORE);
      exit;
    end;

    if FileExists(edtNomeFileOutput.Text) then
    begin
      if R180MessageBox(A000MSG_P656_DLG_FILE_ESISTENTE, DOMANDA) = mrNo then
       exit
      else if DeleteFile(edtNomeFileOutput.Text)=False then
      begin
        R180MessageBox(A000MSG_P656_ERR_DEL_FILE, ERRORE);
        exit;
      end;
    end;
    screen.Cursor:=crHourglass;
    AssignFile(F,edtNomeFileOutput.Text);
    Rewrite(F);
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=nMesiDaElaborare;
    dMyData:=R180FineMese(dPv_DataInizio);
    while dMyData <= dPv_DataFine do
    begin
      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(dMyData), R180FineMese(dMyData)) then
        C700SelAnagrafe.Close;
      C700SelAnagrafe.Open;

      C700MergeSelAnagrafe(selP663,False);
      ElaboraEstrazione(dMyData,RbtA.Checked,F);
      ProgressBar1.StepBy(1);
      dMyData:=R180FineMese(R180AddMesi(dMyData,1));
    end;
  end;
  CloseFile(F);
  ProgressBar1.Position:=0;  
  screen.Cursor:=crDefault;
end;

procedure TP656FElaborazioneFLUPER.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtMeseDa.Text:=C004FParamForm.GetParametro('edtMeseDa',FormatDateTime('mm/yyyy',R180AddMesi(Parametri.DataLavoro,-4)));
  edtMeseA.Text:=C004FParamForm.GetParametro('edtMeseA',FormatDateTime('mm/yyyy',R180AddMesi(Parametri.DataLavoro,-2)));
  chkElaboraDatiFlussoA.Checked:=(C004FParamForm.GetParametro('chkElaboraDatiFlussoA','') = 'S');
  chkElaboraDatiFlussoB1_36.Checked:=(C004FParamForm.GetParametro('chkElaboraDatiFlussoB1_36','') = 'S');
  chkElaboraDatiFLUSSOB37.Checked:=(C004FParamForm.GetParametro('chkElaboraDatiFLUSSOB37','') = 'S');
  chkAnnullaFLUPER.Checked  :=(C004FParamForm.GetParametro('chkAnnullaFLUPER','') = 'S');
  chkChiusura.Checked         :=(C004FParamForm.GetParametro('chkChiusura','') = 'S');
  chkEsportazioneFile.Checked :=(C004FParamForm.GetParametro('chkEsportazioneFile','') = 'S');
  RbtA.Checked :=(C004FParamForm.GetParametro('RbtA','') = 'S');
  RbtB.Checked :=(C004FParamForm.GetParametro('RbtB','') = 'S');  
  edtNomeFileOutput.Text:=C004FParamForm.GetParametro('edtNomeFileOutput','');
end;

procedure TP656FElaborazioneFLUPER.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('edtMeseDa',edtMeseDa.Text);
  C004FParamForm.PutParametro('edtMeseA',edtMeseA.Text);
  if chkElaboraDatiFlussoA.Checked then
    C004FParamForm.PutParametro('chkElaboraDatiFlussoA','S')
  else
    C004FParamForm.PutParametro('chkElaboraDatiFlussoA','N');
  if chkElaboraDatiFlussoB1_36.Checked then
    C004FParamForm.PutParametro('chkElaboraDatiFlussoB1_36','S')
  else
    C004FParamForm.PutParametro('chkElaboraDatiFlussoB1_36','N');
  if chkElaboraDatiFLUSSOB37.Checked then
    C004FParamForm.PutParametro('chkElaboraDatiFLUSSOB37','S')
  else
    C004FParamForm.PutParametro('chkElaboraDatiFLUSSOB37','N');
  if chkAnnullaFLUPER.Checked then
    C004FParamForm.PutParametro('chkAnnullaFLUPER','S')
  else
    C004FParamForm.PutParametro('chkAnnullaFLUPER','N');
  if chkChiusura.Checked then
    C004FParamForm.PutParametro('chkChiusura','S')
  else
    C004FParamForm.PutParametro('chkChiusura','N');
  if chkEsportazioneFile.Checked then
    C004FParamForm.PutParametro('chkEsportazioneFile','S')
  else
    C004FParamForm.PutParametro('chkEsportazioneFile','N');
  if RbtA.Checked then
    C004FParamForm.PutParametro('RbtA','S')
  else
    C004FParamForm.PutParametro('RbtA','N');
  if RbtB.Checked then
    C004FParamForm.PutParametro('RbtB','S')
  else
    C004FParamForm.PutParametro('RbtB','N');
  C004FParamForm.PutParametro('edtNomeFileOutput',edtNomeFileOutput.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP656FElaborazioneFLUPER.DisabilitaComponenti;
//Disabilito i componenti sui quali non devono poter agire
begin
  //Panel2
  btnEsegui.Enabled:=False;
  btnAnomalie.Enabled:=False;
  btnChiudi.Enabled:=False;
end;

procedure TP656FElaborazioneFLUPER.edtMeseADblClick(Sender: TObject);
begin
  edtMeseA.Text:=edtMeseDa.Text;
end;

procedure TP656FElaborazioneFLUPER.AbilitaComponenti;
//Riabilito i componenti disabilitati
begin
  btnEsegui.Enabled:=not SolaLettura;
  if Registramsg.ContieneTipoA then
    btnAnomalie.Enabled:=True;
  btnChiudi.Enabled:=True;
end;

procedure TP656FElaborazioneFLUPER.AbilitazioniIniziali;
//Imposto abilitazioni iniziali per i componenti
begin
  chkAnnullaFLUPER.Enabled:=not(chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB1_36.Checked or chkElaboraDatiFLUSSOB37.Checked or
    chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFlussoA.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFlussoB1_36.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkElaboraDatiFLUSSOB37.Enabled:=not (chkAnnullaFLUPER.Checked or chkEsportazioneFile.Checked or chkChiusura.Checked);
  chkChiusura.Enabled:=not (chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB1_36.Checked or chkElaboraDatiFLUSSOB37.Checked);
  sbtDataChiusura.Enabled:=chkChiusura.Checked;
  edtDataChiusura.Enabled:=chkChiusura.Checked;
  chkEsportazioneFile.Enabled:=not (chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB1_36.Checked or chkElaboraDatiFLUSSOB37.Checked);
  RbtA.Enabled:=chkEsportazioneFile.Enabled;
  RbtB.Enabled:=chkEsportazioneFile.Enabled;
  edtNomeFileOutput.Enabled:=chkEsportazioneFile.Checked;
  sbtNomeFileOutput.Enabled:=chkEsportazioneFile.Checked;
  btnVisualizzaFile.Enabled:=chkEsportazioneFile.Checked;
  if not chkElaboraDatiFlussoA.Enabled then chkElaboraDatiFlussoA.Checked:=False;
  if not chkElaboraDatiFlussoB1_36.Enabled then chkElaboraDatiFlussoB1_36.Checked:=False;
  if not chkElaboraDatiFLUSSOB37.Enabled then chkElaboraDatiFLUSSOB37.Checked:=False;
  if not chkEsportazioneFile.Enabled then
    chkEsportazioneFile.Checked:=False;
  if not chkAnnullaFLUPER.Enabled then
    chkAnnullaFLUPER.Checked:=False;
  if not chkChiusura.Enabled then
    chkChiusura.Checked:=False;
  btnEsegui.Enabled:=((not SolaLettura) and (chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB1_36.Checked or chkElaboraDatiFlussoB37.Checked or
                     chkAnnullaFluper.Checked or chkChiusura.Checked or chkEsportazioneFile.Checked)) or
                     (SolaLettura and (not chkChiusura.Checked) and chkEsportazioneFile.Checked);
  frmSelAnagrafe.pnlSelAnagrafe.Visible:=chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked
                                         or chkElaboraDatiFlussoB1_36.Checked or chkElaboraDatiFLUSSOB37.Checked or chkEsportazioneFile.Checked;
  frmSelAnagrafe.btnEreditaSelezione.Visible:=True;
  pnlBar.Visible:=chkAnnullaFLUPER.Checked or chkElaboraDatiFlussoA.Checked or chkElaboraDatiFlussoB1_36.Checked
                  or chkElaboraDatiFLUSSOB37.Checked;
  pnlElaborazioni.Align:=alTop;
  pnlBar.Align:=alBottom;
end;

procedure TP656FElaborazioneFLUPER.btnDisattivaElaborazioniClick(
  Sender: TObject);
begin
  chkElaboraDatiFlussoA.Checked:=False;
  chkElaboraDatiFlussoB1_36.Checked:=False;
  chkElaboraDatiFLUSSOB37.Checked:=False;
  chkAnnullaFLUPER.Checked:=False;
  chkChiusura.Checked:=False;
  chkEsportazioneFile.Checked:=False;
end;

procedure TP656FElaborazioneFLUPER.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'P656','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TP656FElaborazioneFLUPER.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=R180FineMese(StrToDate('01/'+edtMeseA.Text));
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  if C005DataVisualizzazione = 0 then
    C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TP656FElaborazioneFLUPER.frmSelAnagrafebtnEreditaSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
end;

procedure TP656FElaborazioneFLUPER.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  try
    C700DataLavoro:=R180FineMese(StrToDate('01/'+edtMeseA.Text));
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  if C700DataLavoro = 0 then
    C700DataLavoro:=Parametri.DataLavoro;

  try
    C700DataDal:=StrToDate('01/'+edtMeseDa.Text);
  except
    C700DataDal:=Parametri.DataLavoro;
  end;
  if C700DataDal = 0 then
    C700DataDal:=Parametri.DataLavoro;

  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TP656FElaborazioneFLUPER.sbtMeseDaClick(
  Sender: TObject);
//Richiesta data cedolino tramite calendario
begin
  edtMeseDa.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtMeseDa.Text),'Mese inizio elaborazione','M'));
end;

procedure TP656FElaborazioneFLUPER.sbtNomeFileOutputClick(
  Sender: TObject);
begin
  SaveDialog1.Title := 'Nome file di esportazione';
  if edtNomeFileOutput.Text <> '' then
    SaveDialog1.FileName:=edtNomeFileOutput.Text;
  if SaveDialog1.Execute then
    edtNomeFileOutput.Text:=SaveDialog1.FileName;
end;

procedure TP656FElaborazioneFLUPER.chkElaboraDatiFLUSSOAClick(
  Sender: TObject);
begin
  AbilitazioniIniziali;
end;

procedure TP656FElaborazioneFLUPER.sbtDataChiusuraClick(Sender: TObject);
//Richiesta data chiusura tramite calendario
begin
  edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataChiusura.Text),'Data chiusura','G'));
end;

procedure TP656FElaborazioneFLUPER.btnVisualizzaFileClick(
  Sender: TObject);
begin
  try
    OpenC012VisualizzaTesto('<P656> Visualizzazione file di esportazione della fornitura FLUPER',edtNomeFileOutput.Text,nil,
                            'Visualizzazione file di esportazione dati della fornitura FLUPER nel periodo mese '+ edtMeseDa.Text + ' - ' + edtMeseA.Text);
  except
    raise Exception.Create('Impossibile visualizzare il file. File inesistente.');
  end;
end;

procedure TP656FElaborazioneFLUPER.sbtMeseAClick(Sender: TObject);
begin
  edtMeseA.Text:=FormatDateTime('mm/yyyy',DataOut(StrToDate('01/'+edtMeseA.Text),'Mese fine elaborazione','M'));
end;

procedure TP656FElaborazioneFLUPER.RbtAClick(Sender: TObject);
begin
  RbtB.Checked:=False;
end;

procedure TP656FElaborazioneFLUPER.RbtBClick(Sender: TObject);
begin
  RbtA.Checked:=False;
end;

end.
