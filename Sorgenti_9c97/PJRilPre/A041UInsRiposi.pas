unit A041UInsRiposi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, DBCtrls,DB,C180FunzioniGenerali, Menus,
   Checklst, RegistrazioneLog, SelAnagrafe, A003UDataLavoroBis,
   C005UDatiAnagrafici, {C012UVisualizzaTesto,}
  A016UCausAssenze, Variants,   Oracle, OracleData,
  A083UMsgElaborazioni, A000UMessaggi;

type
  TA041FInsRiposi = class(TForm)
    btnEsegui: TBitBtn;
    StatusBar: TStatusBar;
    Progress: TProgressBar;
    BtnClose: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnAnomalie: TBitBtn;
    sbtDataDa: TSpeedButton;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    sbtDataA: TSpeedButton;
    edtDataDa: TMaskEdit;
    edtDataA: TMaskEdit;
    procedure btnEseguiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure sbtDataDaClick(Sender: TObject);
    procedure sbtDataAClick(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataAExit(Sender: TObject);
  private
    { Private declarations }
    DataI,DataF:TDateTime;
    procedure ScorriSelAnagrafe;
    procedure AggiornaSelAnagrafe;
   public
    { Public declarations }
    (*Caratto 17/04/2013 Rimosse perchè non usate
    AbilCont:Boolean;
    CausPres,CausAss:String;
    *)
  end;

var
  A041FInsRiposi: TA041FInsRiposi;

procedure OpenA041InsRiposi(Prog:LongInt);

implementation

uses A041UInsRiposiDtM1;

{$R *.DFM}

procedure OpenA041InsRiposi(Prog:LongInt);
{Inserimento automatico dei riposi}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA041InsRiposi') of
    'N','R':
      begin
        ShowMessage('Funzione non abilitata!');
        Exit;
      end;
  end;
  A041FInsRiposi:=TA041FInsRiposi.Create(nil);
  with A041FInsRiposi do
    try
      C700Progressivo:=Prog;
      A041FInsRiposiDtM1:=TA041FInsRiposiDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A041FInsRiposiDtM1.Free;
      Free;
    end;
end;

procedure TA041FInsRiposi.FormCreate(Sender: TObject);
begin
  (*Caratto 17/04/2013 Rimosse perchè non usate
  AbilCont:=False;
  CausPres:='';
  CausAss:='';
  *)
  btnAnomalie.Enabled:=False;
end;

procedure TA041FInsRiposi.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A041FInsRiposiDtM1.A041FInsRiposiMW,SessioneOracle,StatusBar,0,False);
  DataI:=R180InizioMese(Parametri.DataLavoro);
  edtDataDa.Text:=FormatDateTime('mm/yyyy',DataI);
  DataF:=R180FineMese(Parametri.DataLavoro);
  edtDataA.Text:=FormatDateTime('mm/yyyy',DataF);
  //NomeFile:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\A041_' + Parametri.Azienda + '_' + Parametri.Operatore + '.log';
end;

procedure TA041FInsRiposi.AggiornaSelAnagrafe;
begin
  with C700SelAnagrafe do
    if GetVariable('DataLavoro') <> DataF then
    begin
      Close;
      SetVariable('DataLavoro',DataF);
      Open;
      frmSelAnagrafe.NumRecords;
    end;
end;

procedure TA041FInsRiposi.btnEseguiClick(Sender: TObject);
var Riga:String;
begin
  if DataI > DataF then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  if FormatDateTime('yyyy',DataI) <> FormatDateTime('yyyy',DataF) then
    raise Exception.Create(A000MSG_ERR_DATE_STESSO_ANNO);
  Progress.Position:=0;
  AggiornaSelAnagrafe;

  A041FInsRiposiDtM1.A041FInsRiposiMW.InizializzaSelDatiBloccati;

  RegistraMsg.IniziaMessaggio('A041');
  try
//    R180AppendFile(NomeFile,'INIZIO INSERIMENTO RIPOSI ' + DateTimeToStr(Now));
    //if FileExists(NomeFile) then
    //  DeleteFile(NomeFile);
    Progress.Max:=C700SelAnagrafe.RecordCount;
    Progress.Position:=0;
    with A041FInsRiposiDtM1.A041FInsRiposiMW do
    begin
      DataInizio:=DataI;
      DataFine:=DataF;
      //Massimo 23/07/2013 abbinamento già fatto in CreaSelAnagrafe
      //SelAnagrafe:=C700SelAnagrafe;

      InizializzaComponentiElaborazione;
      //R502ProDtM1:=TR502ProDtM1.Create(nil);  //Alberto 19/06/2006
      //R502ProDtM1.PeriodoConteggi(DataI - 1,DataF + 1);
    end;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      ScorriSelAnagrafe;  //Ciclo su C700
    except
      on E: Exception do
      begin
        Riga:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
              C700SelAnagrafe.FieldByName('NOME').AsString + ': ATTENZIONE Inserimento riposi fallito ';
        //R180AppendFile(NomeFile,Riga);
        //R180AppendFile(NomeFile,'  ' + E.Message);
        RegistraMsg.InserisciMessaggio('A',Riga,'',C700Progressivo);
        RegistraMsg.InserisciMessaggio('A','  ' + E.Message,'',C700Progressivo);
      end;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    frmSelAnagrafe.VisualizzaDipendente;
    Self.Enabled:=True;
    A041FInsRiposiDtM1.A041FInsRiposiMW.DistruggiComponentiElaborazione;
    Progress.Position:=0;
    SessioneOracle.Commit;
//    R180AppendFile(NomeFile,'FINE INSERIMENTO RIPOSI ' + DateTimeToStr(Now));
//    btnAnomalie.Enabled:=(selDatiBloccati.FileLog <> '') or (Anomalie);
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    if btnAnomalie.Enabled then
    begin
      if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox('Elaborazione terminata',INFORMA);
  end;
end;

procedure TA041FInsRiposi.ScorriSelAnagrafe;
{Procedura che assegna i giorni di riposo.}
begin
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.EOF do
  begin
    Progress.StepBy(1);
    frmSelAnagrafe.VisualizzaDipendente;
    A041FInsRiposiDtM1.A041FInsRiposiMW.ElaboraDipendente;
    C700SelAnagrafe.Next;
  end;
end;

procedure TA041FInsRiposi.sbtDataAClick(Sender: TObject);
begin
  DataF:=R180FineMese(DataOut(StrToDate('01/' + edtDataA.Text),'Al mese','M'));
  edtDataA.Text:=FormatDateTime('mm/yyyy',DataF);
end;

procedure TA041FInsRiposi.sbtDataDaClick(Sender: TObject);
begin
  DataI:=R180InizioMese(DataOut(StrToDate('01/' + edtDataDa.Text),'Dal mese','M'));
  edtDataDa.Text:=FormatDateTime('mm/yyyy',DataI);
end;

procedure TA041FInsRiposi.edtDataAExit(Sender: TObject);
begin
  try
    DataF:=R180FineMese(StrToDate('01/' + (Sender as TMaskEdit).Text));
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create('Indicare una data valida!');
  end;
end;

procedure TA041FInsRiposi.edtDataDaExit(Sender: TObject);
begin
  try
    DataI:=R180InizioMese(StrToDate('01/' + (Sender as TMaskEdit).Text));
  except
    (Sender as TMaskEdit).SetFocus;
    raise exception.create('Indicare una data valida!');
  end;
end;

procedure TA041FInsRiposi.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA041FInsRiposi.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA041FInsRiposi.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA041FInsRiposi.btnAnomalieClick(Sender: TObject);
begin
  //OpenC012VisualizzaTesto('<A041> Anomalie inserimento riposi',NomeFile,nil,'');
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A041','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A041FInsRiposiDtM1.A041FInsRiposiMW);
end;

end.
