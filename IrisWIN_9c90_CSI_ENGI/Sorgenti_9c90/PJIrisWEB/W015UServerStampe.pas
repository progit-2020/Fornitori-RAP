unit W015UServerStampe;

interface

uses
  DBClient, Classes, SysUtils, StrUtils, IWTemplateProcessorHTML,
  IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton,
  DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, RegistrazioneLog,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  A000UInterfaccia, A000USessione, A000UCostanti,
  C180FunzioniGenerali, R010UPaginaWeb,
  IWVCLBaseContainer, IWContainer, Forms,
  IWVCLComponent, R012UWebAnagrafico, ActiveX, MConnect,
  ActnList, meIWComboBox, meIWLabel, meIWEdit, meIWButton,
  meIWLink, W000UMessaggi, IWCompExtCtrls, meIWRadioGroup;

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TW015FServerStampe = class(TR012FWebAnagrafico)
    DCOMConnection1: TDCOMConnection;
    DCOMConnection2: TDCOMConnection;
    lblPeriodoDal: TmeIWLabel;
    lblPeriodoAl: TmeIWLabel;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    btnStampa: TmeIWButton;
    lblParametrizzazione: TmeIWLabel;
    cmbParametrizzazione: TmeIWComboBox;
    rgpFormatoStampa: TmeIWRadioGroup;
    lblFormatoStampa: TmeIWLabel;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, SyncObjs;

function TW015FServerStampe.InizializzaAccesso:Boolean;
begin
  Result:=True;
  VisualizzaDipendenteCorrente;
end;

procedure TW015FServerStampe.IWAppFormCreate(Sender: TObject);
var Dal,Al:TDateTime;
begin
  inherited;
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE';
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',Al);
  GetDipendentiDisponibili(Al);
  cmbParametrizzazione.Items.Clear;
  with WR000DM.selT910 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      //if FieldByName('APPLICAZIONE').AsString = 'RILPRE' then
        cmbParametrizzazione.Items.Add(StringReplace(Format('%-20s %s',[FieldByName('CODICE').AsString,FieldByName('TITOLO').AsString]),' ',SPAZIO,[rfReplaceAll]));
      Next;
    end;
    //CloseAll;  //Alberto: serve aperto quando si lancia la stampa
    cmbParametrizzazione.RequireSelection:=cmbParametrizzazione.Items.Count > 0;
    if cmbParametrizzazione.Items.Count > 0 then
      cmbParametrizzazione.ItemIndex:=0;
  end;
  cmbDipendentiDisponibili.ItemIndex:=0;
  CambioDipendenteAsync:=True;
end;

procedure TW015FServerStampe.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=True;
  inherited;
end;

procedure TW015FServerStampe.btnAggiornamentoClick(Sender: TObject);
var DataI,DataF:TDateTime;
    CodiceStampa: WideString;
    SelezioneAnagrafica,Mat,NomeFile:String;
    OrderBy:Integer;
    DettaglioLog:OleVariant;
begin
  lblCommentoCorrente.Caption:='';
  DettaglioLog:='';
  CodiceStampa:=Trim(Copy(StringReplace(cmbParametrizzazione.Text,SPAZIO,' ',[rfReplaceAll]),1,20));
  if CodiceStampa = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W015_MSG_SPECIFICARE_STAMPA));
    exit;
  end;
  DataI:=StrToDate(edtDal.Text);
  DataF:=StrToDate(edtAl.Text);
  if DataF < DataI then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W015_ERR_DATE_NON_CORRETTE));
    exit;
  end;
  if R180Anno(DataI) < R180Anno(DataF) - 1 then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W015_MSG_PERIODO_MAGGIORE_2_ANNI));
    exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W015_ERR_FMT_STOP_DATA_ANTECEDENTE),[DateToStr(Parametri.WEBCartelliniDataMin)]));
    exit;
  end;
  try
    if rgpFormatoStampa.ItemIndex = 0 then
      NomeFile:=GetNomeFile('pdf')
    else
      NomeFile:=GetNomeFile('xls');
    ForceDirectories(ExtractFileDir(NomeFile));
    SelezioneAnagrafica:=selAnagrafeW.SubstitutedSQL;
    if cmbDipendentiDisponibili.ItemIndex <> 0 then
    begin
      // 12.2.6
      //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8));
      Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
      OrderBy:=Pos('ORDER BY',UpperCase(SelezioneAnagrafica));
      if OrderBy = 0 then
        SelezioneAnagrafica:=SelezioneAnagrafica + ' AND T030.MATRICOLA =''' + Mat + ''''
      else
        Insert(' AND T030.MATRICOLA =''' + Mat + ''' ',SelezioneAnagrafica,OrderBy);
    end;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
    begin
      CoInitialize(nil);
    end;
    if VarToStr(WR000DM.selT910.Lookup('CODICE',CodiceStampa,'APPLICAZIONE')) = 'PAGHE' then
    begin
      if not DCOMConnection2.Connected then
        DCOMConnection2.Connected:=True;
      try
        DCOMConnection2.AppServer.CreaStampa(SelezioneAnagrafica,
                                             CodiceStampa,
                                             NomeFile,
                                             IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'),
                                             Parametri.Operatore,
                                             Parametri.Azienda,
                                             VarToStr(WR000DM.selT910.Lookup('CODICE',CodiceStampa,'APPLICAZIONE')),
                                             WR000DM.selAnagrafe.Session.LogonDataBase,
                                             DataI,
                                             DataF,
                                             DettaglioLog);
      finally
        DCOMConnection2.Connected:=False;
      end;
    end
    else
    begin
      if not DCOMConnection1.Connected then
        DCOMConnection1.Connected:=True;
      try
        DCOMConnection1.AppServer.CreaStampa(SelezioneAnagrafica,
                                             CodiceStampa,
                                             NomeFile,
                                             IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'),
                                             Parametri.Operatore,
                                             Parametri.Azienda,
                                             VarToStr(WR000DM.selT910.Lookup('CODICE',CodiceStampa,'APPLICAZIONE')),
                                             WR000DM.selAnagrafe.Session.LogonDataBase,
                                             DataI,
                                             DataF,
                                             DettaglioLog);
      finally
        DCOMConnection1.Connected:=False;
      end;
    end;

    if FileExists(NomeFile) then
      VisualizzaFile(NomeFile,Copy(cmbParametrizzazione.Text,22,MAXINT),nil,nil)
    else
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W015_ERR_TAB_NON_COMPATIBILE));
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W015_PARAM_STAMPA_NON_DISPONIB),[E.message]));
  end;
end;

procedure TW015FServerStampe.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selT910.CloseAll; except end;
  end;
end;

end.
