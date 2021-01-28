unit Ac04UStampaRendiProj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, Grids, DBGrids, ExtCtrls, DB, ComCtrls,
  checklst, Mask, Menus, Variants, Math, StrUtils, OracleData, QRPDFFilt,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C013UCheckList, C180FunzioniGenerali,
  C700USelezioneAnagrafe, SelAnagrafe, RegistrazioneLog, Rp502Pro;

type
  TAc04FStampaRendiProj = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel1: TPanel;
    clbProgetti: TCheckListBox;
    Panel2: TPanel;
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    lblFeste: TLabel;
    edtPartnerName: TEdit;
    lblPartnerName: TLabel;
    chkSoloAttRend: TCheckBox;
    edtNumColAltriProgetti: TSpinEdit;
    lblNumColAltriProgetti: TLabel;
    chkSezGiustificaRitardi: TCheckBox;
    lblMeseDal: TLabel;
    sbtDaData: TSpeedButton;
    lblMeseAl: TLabel;
    sbtAData: TSpeedButton;
    edtDaData: TMaskEdit;
    edtAData: TMaskEdit;
    chkTipoTempo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtDaDataExit(Sender: TObject);
    procedure sbtDaDataClick(Sender: TObject);
    procedure edtADataDblClick(Sender: TObject);
    procedure edtADataExit(Sender: TObject);
    procedure sbtADataClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtNumColAltriProgettiExit(Sender: TObject);
  private
    FMyC004: TC004FParamForm;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AggiornaDate;
    procedure RecuperaDipendenti;
    procedure RecuperaListaFiltroProgetti;
    procedure RecuperaProjSel;
    procedure ScorriQueryAnagrafica;
  public
    SolaLettura: Boolean;
    DocumentoPDF,TipoModulo: String;
    procedure SelezionaProj;
  end;

var
  Ac04FStampaRendiProj: TAc04FStampaRendiProj;

procedure OpenAc04FStampaRendiProj(Prog:LongInt);

implementation

uses Ac04UStampa, Ac04UStampaRendiProjDM;

{$R *.DFM}

procedure OpenAc04FStampaRendiProj(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc04FStampaRendiProj') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Ac04FStampaRendiProj:=TAc04FStampaRendiProj.Create(nil);
  Ac04FStampaRendiProj.SolaLettura:=SolaLettura;
  with Ac04FStampaRendiProj do
    try
      C700Progressivo:=Prog;
      Ac04FStampaRendiProjDM:=TAc04FStampaRendiProjDM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Ac04FStampaRendiProjDM.Free;
      Free;
    end;
end;

procedure TAc04FStampaRendiProj.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  Ac04FStampa:=TAc04FStampa.Create(nil);
  SolaLettura:=False;
end;

procedure TAc04FStampaRendiProj.FormShow(Sender: TObject);
var
  i: Integer;
begin
  if TipoModulo = 'CS' then
    CreaC004(SessioneOracle,'Ac04',Parametri.ProgOper) //parametri dell'operatore
  else
    SolaLettura:=True;
  FMyC004:=CreaC004(SessioneOracle,'Ac04',-1,False); //parametri aziendali
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW,SessioneOracle,StatusBar,0,False);
  edtDaData.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  edtAData.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  AggiornaDate;
  //frmSelAnagrafe.SelezionePeriodica:=True;
  RecuperaListaFiltroProgetti;
  GetParametriFunzione;
  edtPartnerName.ReadOnly:=SolaLettura;
  chkTipoTempo.Enabled:=not SolaLettura;
  chkSezGiustificaRitardi.Enabled:=not SolaLettura;
  SelezionaProj;
  RecuperaProjSel;
end;

procedure TAc04FStampaRendiProj.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  if TipoModulo = 'CS' then
    C004FParamForm.Free;
  FreeAndNil(FMyC004);
end;

procedure TAc04FStampaRendiProj.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Ac04FStampa);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc04FStampaRendiProj.GetParametriFunzione;
{Leggo i parametri della form}
begin
  //parametri dell'operatore
  if TipoModulo = 'CS' then
  begin
    with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
      if ListaProjSel = '' then
        ListaProjSel:=C004FParamForm.GetParametro('ListaProjSel','');
    chkSoloAttRend.Checked:=C004FParamForm.GetParametro('SoloAttRend','N') = 'S';
    edtNumColAltriProgetti.Text:=C004FParamForm.GetParametro('NumColAltriProgetti','5');
  end;

  //parametri aziendali
  edtPartnerName.Text:=FMyC004.GetParametro('PartnerName','Municipality of Torino');
  chkTipoTempo.Checked:=FMyC004.GetParametro('TipoTempo','N') = 'S';
  chkSezGiustificaRitardi.Checked:=FMyC004.GetParametro('SezGiustificaRitardi','N') = 'S';
end;

procedure TAc04FStampaRendiProj.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  //parametri dell'operatore
  if TipoModulo = 'CS' then
  begin
    RecuperaProjSel;
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('ListaProjSel',Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.ListaProjSel);
    C004FParamForm.PutParametro('SoloAttRend',IfThen(chkSoloAttRend.Checked,'S','N'));
    C004FParamForm.PutParametro('NumColAltriProgetti',edtNumColAltriProgetti.Text);
  end;

  //parametri aziendali
  if not SolaLettura then
  begin
    FMyC004.Cancella001;
    FMyC004.PutParametro('PartnerName',edtPartnerName.Text);
    FMyC004.PutParametro('TipoTempo',IfThen(chkTipoTempo.Checked,'S','N'));
    FMyC004.PutParametro('SezGiustificaRitardi',IfThen(chkSezGiustificaRitardi.Checked,'S','N'));
  end;

  try SessioneOracle.Commit; except end;
end;

procedure TAc04FStampaRendiProj.edtDaDataExit(Sender: TObject);
begin
  AggiornaDate;
end;

procedure TAc04FStampaRendiProj.edtNumColAltriProgettiExit(Sender: TObject);
begin
  if edtNumColAltriProgetti.Text = '' then
    edtNumColAltriProgetti.Text:='0';
end;

procedure TAc04FStampaRendiProj.sbtDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=Copy(DateToStr(DataOut(StrToDate('01/' + edtDaData.Text),'Dal mese','M')),4,7);
  AggiornaDate;
end;

procedure TAc04FStampaRendiProj.edtADataDblClick(Sender: TObject);
begin
  edtAData.Text:=edtDaData.Text;
end;

procedure TAc04FStampaRendiProj.edtADataExit(Sender: TObject);
begin
  AggiornaDate;
end;

procedure TAc04FStampaRendiProj.sbtADataClick(Sender: TObject);
begin
  edtAData.Text:=Copy(DateToStr(DataOut(StrToDate('01/' + edtAData.Text),'Al mese','M')),4,7);
  AggiornaDate;
end;

procedure TAc04FStampaRendiProj.AggiornaDate;
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    Dal:=StrToDate('01/' + edtDaData.Text);
    Al:=R180FineMese(StrToDate('01/' + edtAData.Text));
    if C700SelAnagrafe <> nil then
    begin
      RecuperaDipendenti;
      RecuperaListaFiltroProgetti;
    end;
  end;
end;

procedure TAc04FStampaRendiProj.RecuperaDipendenti;
var OldProg:Integer;
begin
  OldProg:=C700Progressivo;
  C700DataDal:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Dal;
  C700DataLavoro:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Al;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(C700DataDal,C700DataLavoro) then
    C700SelAnagrafe.Close;
  with C700SelAnagrafe do
  begin
    Open;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    C700Progressivo:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    C700OldProgressivo:=C700Progressivo;
    StatusBar.SimpleText:=IntToStr(RecordCount) + ' Records';
    frmSelAnagrafe.VisualizzaDipendente;
  end;
end;

procedure TAc04FStampaRendiProj.RecuperaListaFiltroProgetti;
var i,OldProg:Integer;
    ListaProj,sProj:String;
begin
  RecuperaProjSel;
  Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.SLProgetti.Clear;
  clbProgetti.Clear;
  ListaProj:=',';
  OldProg:=C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  Screen.Cursor:=crHourGlass;
  C700SelAnagrafe.First;
  for i:=0 to C700SelAnagrafe.RecordCount - 1 do
    with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW,selT750Lista do
    begin
      R180SetVariable(selT750Lista,'PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      R180SetVariable(selT750Lista,'DAL',Dal);
      R180SetVariable(selT750Lista,'AL',Al);
      Filtered:=True;//Filtro dizionario
      Open;
      First;
      while not Eof do
      begin
        if not R180InConcat(FieldByName('ID_T750').AsString,ListaProj) then
        begin
          sProj:=Format('%-20s %10s-%10s %-100s %-s',[FieldByName('C_PROGETTO').AsString,FieldByName('DEC_PROGETTO').AsString,FieldByName('SCA_PROGETTO').AsString,FieldByName('D_PROGETTO').AsString,FieldByName('ID_T750').AsString]);
          SLProgetti.Add(sProj);
          clbProgetti.Items.Add(Copy(sProj,1,144)); //escludo l'ID in visualizzazione
          ListaProj:=ListaProj + FieldByName('ID_T750').AsString + ',';
        end;
        Next;
      end;
      C700SelAnagrafe.Next;
    end;
  C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  frmSelAnagrafe.VisualizzaDipendente;
  SelezionaProj;
  RecuperaProjSel;
  Screen.Cursor:=crDefault;
end;

procedure TAc04FStampaRendiProj.RecuperaProjSel;
var i,j:Integer;
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    ListaProjSel:='';
    for i:=0 to clbProgetti.Count - 1 do
      if clbProgetti.Checked[i] then
        for j:=0 to SLProgetti.Count - 1 do
          if Copy(SLProgetti[j],1,144) = clbProgetti.Items[i] then
          begin
            ListaProjSel:=ListaProjSel + IfThen(ListaProjSel <> '',',') + Trim(Copy(SLProgetti[j],145));//recupera l'id del progetto selezionato
            Break;//esce dal ciclo su SLProgetti
          end;
  end;
end;

procedure TAc04FStampaRendiProj.SelezionaProj;
var i:Integer;
    sLPS,sIdT750:String;
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    sLPS:=ListaProjSel + IfThen(ListaProjSel <> '',',');
    while sLPS <> '' do
    begin
      sIdT750:=Copy(sLPS,1,Pos(',',sLPS) - 1);
      sLPS:=Trim(Copy(sLPS,Pos(',',sLPS) + 1));
      for i:=0 to clbProgetti.Items.Count - 1 do
        if SLProgetti.IndexOf(clbProgetti.Items[i] + sIdT750) >= 0 then
          clbProgetti.Checked[i]:=True;
    end;
  end;
end;

procedure TAc04FStampaRendiProj.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(Ac04FStampa.RepR);
end;

procedure TAc04FStampaRendiProj.BtnStampaClick(Sender: TObject);
begin
  with Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW do
  begin
    if Al > R180AddMesi(Dal,12) - 1 then
      raise exception.Create(A000MSG_Ac04_ERR_PERIODO_LUNGO);
    if C700SelAnagrafe.RecordCount = 0 then
      raise exception.Create(A000MSG_ERR_NO_DIP);
    RecuperaProjSel;
    if ListaProjSel = '' then
      raise exception.Create(A000MSG_ERR_SELEZIONARE_ELEMENTO);

    PartnerName:=edtPartnerName.Text;
    TipoTempo:=chkTipoTempo.Checked;
    SezGiustificaRitardi:=chkSezGiustificaRitardi.Checked;
    SoloAttRend:=chkSoloAttRend.Checked;
    nProMax:=StrToInt(edtNumColAltriProgetti.Text);

   CreaTabellaStampa;
  end;
  try
    Screen.Cursor:=crHourGlass;
    ScorriQueryAnagrafica;
  finally
    Screen.Cursor:=crDefault;
  end;
  // crea la stampa
  Ac04FStampa.SettaDataset;
  if (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
  begin
    Ac04FStampa.RepR.PrinterSettings.UseStandardprinter:=True;
    Ac04FStampa.RepR.ShowProgress:=False;
    Ac04FStampa.RepR.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else
    Ac04FStampa.RepR.Preview;
  Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.cdsStampaAnagrafico.Close;
  Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.cdsStampaDettaglio.Close;
end;

procedure TAc04FStampaRendiProj.ScorriQueryAnagrafica;
begin
  RegistraMsg.IniziaMessaggio('Ac04');
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.R502ProDtM1:=TR502ProDtM1.Create(Self);
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.StepBy(1);
      Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.ElaboraDipendente;
      C700SelAnagrafe.Next;
    end;
  finally
    FreeAndNil(Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.R502ProDtM1);
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.Position:=0;
  end;
end;

procedure TAc04FStampaRendiProj.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Al;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc04FStampaRendiProj.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Dal;
  C700DataLavoro:=Ac04FStampaRendiProjDM.Ac04FStampaRendiProjMW.Al;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  RecuperaListaFiltroProgetti;
end;

end.
