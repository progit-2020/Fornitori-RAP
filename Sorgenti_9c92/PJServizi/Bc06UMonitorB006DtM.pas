
unit Bc06UMonitorB006DtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, Oracle, OracleData,
  System.Generics.Collections, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.Controls, Vcl.Forms, Dialogs, Math,
  Variants, strUtils, A000UCostanti, A000USessione, A000UInterfaccia, Bc06UClassi,
  Bc06UExecMonitorB006DtM, C180FunzioniGenerali;

type
  TBc06FMonitorB006DtM = class(TR004FGestStoricoDtM)
    dsrI191: TDataSource;
    dsrInfoControlli: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI190AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure cdsInfoControlliAfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    ArrayTimers: array of TTimer;
  public
    Bc06FExecMonitorB006DtM: TBc06FExecMonitorB006DtM;
    procedure StartMonitor;
    procedure StopMonitor;
    procedure OnTimerTick(Sender:TObject);
    procedure ControllaOra(optID: Integer = -1; optDB: string = '');
  end;

var
  Bc06FMonitorB006DtM: TBc06FMonitorB006DtM;

implementation

uses Bc06UConfigMonitorB006,Bc06UMonitorB006;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TBc06FMonitorB006DtM.DataModuleCreate(Sender: TObject);
begin
try
  inherited;
  Bc06FExecMonitorB006DtM:=TBc06FExecMonitorB006DtM.Create(nil);
  Bc06FExecMonitorB006DtM.TipoModulo:=Bc06FExecMonitorB006DtM.ModuloClientServer;
  Bc06FExecMonitorB006DtM.SessioneOracleBc06:=SessioneOracle;
  Bc06FExecMonitorB006DtM.ConnettiDataBase(SessioneOracle.LogonDatabase);
  InizializzaDataSet(Bc06FExecMonitorB006DtM.selI190,[evBeforePostNoStorico,
                                                      evBeforeDelete,
                                                      evAfterDelete,
                                                      evAfterPost]);
  Bc06FExecMonitorB006DtM.selI190.AfterScroll:=selI190AfterScroll;

  Bc06FExecMonitorB006DtM.cdsInfoControlli.AfterScroll:=cdsInfoControlliAfterScroll;
  SetLength(ArrayTimers,0);
except
  on Exc:Exception do
  begin
    ShowMessage(Exc.Message);
  end;
end;

end;

procedure TBc06FMonitorB006DtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  StopMonitor;
  FreeAndNil(Bc06FExecMonitorB006DtM);
end;

procedure TBc06FMonitorB006DtM.cdsInfoControlliAfterScroll(DataSet: TDataSet);
var
  CurrMsgControllo:TMsgControlloIstanza;
  cdsRecNo :Integer;
  CurosoreHG:Boolean;
begin
  CurosoreHG:=Screen.Cursor = crHourGlass;
  Screen.Cursor:=crHourGlass;
  try
    if (Bc06FMonitorB006 <> nil) and (DataSet.State = dsBrowse) then
    begin
      cdsRecNo:=DataSet.RecNo;
      if not Bc06FExecMonitorB006DtM.MsgControlli.ContainsKey(cdsRecNo) then
      begin
        Bc06FMonitorB006.memMsg1.Lines.Text:='Errore di programma: log per questa istanza non trovati!';
        Bc06FMonitorB006.memMsg2.Lines.Text:='Errore di programma: log per questa istanza non trovati!';
        Exit;
      end;
      CurrMsgControllo:=Bc06FExecMonitorB006DtM.MsgControlli.Items[cdsRecNo];
      Bc06FMonitorB006.memMsg1.Lines.Assign(CurrMsgControllo.Msg1);
      Bc06FMonitorB006.memMsg2.Lines.Assign(CurrMsgControllo.Msg2);

      //Abilita i filtri solo se è già stata fatta un "ControllaOra" lettura in precedenza
      if (DataSet.FieldByName('F_Utente').AsBoolean) and (DataSet.FieldByName('ESITO_CONTROLLO').AsInteger >= 0) then
      begin
        R180AbilitaOggetti(Bc06FMonitorB006.pnlFiltroUtente, True);
        R180AbilitaOggetti(Bc06FMonitorB006.frmInputPeriodo, True);

        Bc06FMonitorB006.frmInputPeriodo.DataInizio:=DataSet.FieldByName('F_DataI').AsDateTime;
        Bc06FMonitorB006.frmInputPeriodo.DataFine:=DataSet.FieldByName('F_DataF').AsDateTime;

        Bc06FMonitorB006.cmbTipo.ItemIndex:=IfThen(DataSet.FieldByName('F_Tipo').AsInteger>=0,DataSet.FieldByName('F_Tipo').AsInteger,0);
        Bc06FMonitorB006.cmbAzienda.Items.CommaText:=DataSet.FieldByName('LstAziende').AsString;
        Bc06FMonitorB006.cmbAzienda.ItemIndex:=IfThen(DataSet.FieldByName('F_Azienda').AsInteger>=0,DataSet.FieldByName('F_Azienda').AsInteger,0);
      end
      else
      begin
        Bc06FMonitorB006.frmInputPeriodo.DataInizio:=0;
        Bc06FMonitorB006.frmInputPeriodo.DataFine:=0;

        Bc06FMonitorB006.cmbTipo.ItemIndex:=0;
        Bc06FMonitorB006.cmbAzienda.Items.Clear;
        Bc06FMonitorB006.cmbAzienda.Text:='';
        R180AbilitaOggetti(Bc06FMonitorB006.pnlFiltroUtente, False);
        R180AbilitaOggetti(Bc06FMonitorB006.frmInputPeriodo, False);
      end;
    end;
  finally
    if not CurosoreHG then
      Screen.Cursor:=crDefault;
  end;
end;

procedure TBc06FMonitorB006DtM.selI190AfterScroll(DataSet: TDataSet);
begin
  Bc06FExecMonitorB006DtM.selI190AfterScroll(DataSet);
  if Bc06FConfigMonitorB006 <> nil then
    Bc06FConfigMonitorB006.AbilitaComponenti;
end;

procedure TBc06FMonitorB006DtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  Bc06FExecMonitorB006DtM.selI190BeforePost(DataSet);
  inherited;
end;

procedure TBc06FMonitorB006DtM.StartMonitor;
var
  ID,idx:Integer;
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
begin
  if Bc06FExecMonitorB006DtM.MonitorAttivo then
    raise Exception.Create('Il monitoraggio è già attivo.');
  if (Bc06FExecMonitorB006DtM.Configurazione = nil) or (Bc06FExecMonitorB006DtM.MsgControlli = nil) or (Bc06FExecMonitorB006DtM.cdsInfoControlli.RecordCount = 0) then
    raise Exception.Create('Configurazione non caricata!'); // Non deve MAI succedere

  try
    SetLength(ArrayTimers,Bc06FExecMonitorB006DtM.Configurazione.Servizi.Keys.Count);
    idx:=0;
    for ID in Bc06FExecMonitorB006DtM.Configurazione.Servizi.Keys do // Ciclo nei servizi
    begin
      // Istanzio i timer che lanceranno i controlli
      ConfServizio:=Bc06FExecMonitorB006DtM.Configurazione.Servizi.Items[ID];
      ArrayTimers[idx]:=TTimer.Create(Self);
      ArrayTimers[idx].Interval:=ConfServizio.IntervalloMS;
      ArrayTimers[idx].Tag:=ConfServizio.ID;
      ArrayTimers[idx].OnTimer:=OnTimerTick;
      ArrayTimers[idx].Enabled:=True;
      Inc(idx);
    end;
    Bc06FExecMonitorB006DtM.MonitorAttivo:=True;
  except
    on E:Exception do
    begin
      // Annullo tutto
      StopMonitor;
      raise Exception.Create('Errore durante l''avvio del monitor: ' + E.Message);
    end;
  end;
  Bc06FExecMonitorB006DtM.cdsInfoControlli.EnableControls;
end;

procedure TBc06FMonitorB006DtM.StopMonitor;
var
  CurrTimer:TTimer;
begin
  // Arresto e disalloco i timer, se presenti
  for CurrTimer in ArrayTimers do
  begin
    CurrTimer.Enabled:=False;
    CurrTimer.Free;
  end;
  SetLength(ArrayTimers,0);
  // Segnalo che il monitor è arrestato
  Bc06FExecMonitorB006DtM.MonitorAttivo:=False;
end;

procedure TBc06FMonitorB006DtM.OnTimerTick(Sender:TObject);
var
  IDConfServizio:Integer;
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
  EsitoSummary:String;
begin
  Bc06FMonitorB006.BloccaInterfaccia;
  try
    // Svuoto il log ad ogni controllo se c'è un solo servizio da controllare oppure se abbiamo
    // raggiungo un gran numero di righe
    if ((Bc06FExecMonitorB006DtM.Configurazione.Servizi <> nil) and (Bc06FExecMonitorB006DtM.Configurazione.Servizi.Count = 1)) or
       (Bc06FMonitorB006.memLogControllo.Lines.Count > 5000) then
      Bc06FMonitorB006.SvuotaLog;

    IDConfServizio:=(Sender as TTimer).Tag;
    ConfServizio:=Bc06FExecMonitorB006DtM.Configurazione.Servizi[IDConfServizio]; // Se ho un'eccezione significa errore del programma
    for ConfIstanza in ConfServizio.Istanze do
      Bc06FMonitorB006.AggiungiLineeLog(Bc06FExecMonitorB006DtM.LanciaControllo(ConfServizio,ConfIstanza), True);

  finally
    Bc06FMonitorB006.AggiornaInterfaccia;
  end;
end;

procedure TBc06FMonitorB006DtM.ControllaOra(optID: Integer = -1; optDB: string = '');
var
  ConfServizio:TConfServizio;
  ConfIstanza:TConfIstanza;
  strFitroUtente:String;
  strAzienda:String;
begin
  if (Bc06FExecMonitorB006DtM.Configurazione = nil) or (Bc06FExecMonitorB006DtM.MsgControlli = nil) or (Bc06FExecMonitorB006DtM.cdsInfoControlli.RecordCount = 0) then
    raise Exception.Create('Configurazione non caricata!'); // Non deve mai succedere

  // Svuoto il log ad ogni controllo se c'è un solo servizio da controllare oppure se abbiamo
  // raggiungo un gran numero di righe
  if ((Bc06FExecMonitorB006DtM.Configurazione.Servizi <> nil) and (Bc06FExecMonitorB006DtM.Configurazione.Servizi.Count = 1)) or
     (Bc06FMonitorB006.memLogControllo.Lines.Count > 5000) then
    Bc06FMonitorB006.SvuotaLog;

  // Gli errori sono gestiti internamente in LanciaControllo
  for ConfServizio in Bc06FExecMonitorB006DtM.Configurazione.Servizi.Values do
  begin
    if (optID=-1) and (optDB='') then
    begin
      for ConfIstanza in ConfServizio.Istanze do
      begin
        Bc06FMonitorB006.AggiungiLineeLog(Bc06FExecMonitorB006DtM.LanciaControllo(ConfServizio,ConfIstanza), True);
      end;
    end
    else
    begin
      for ConfIstanza in ConfServizio.Istanze do
      begin
        if (ConfIstanza.IDServizio=optID) and (ConfIstanza.DataBase=optDB) then
        begin
          strFitroUtente:='';
          if Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Tipo').AsInteger > 0 then
            strFitroUtente:=strFitroUtente + ' and TIPO = ''' +  Bc06FMonitorB006.cmbTipo.Items[Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Tipo').AsInteger] + '''';
          //if Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Azienda').AsInteger > 0 then strFitroUtente:=strFitroUtente + ' and AZIENDA_MSG = ''' +  Bc06FMonitorB006.cmbAzienda.Items[Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Azienda').AsInteger] + '''';
          if Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Azienda').AsInteger > 0 then
          begin
            strAzienda:=Bc06FMonitorB006.cmbAzienda.Items[Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_Azienda').AsInteger];
            strFitroUtente:=strFitroUtente + ' and ((AZIENDA_MSG = ''' + strAzienda +''') or (USR_I100F_MSG(''' + strAzienda + ''',MSG) = ''S''))';
          end;
          strFitroUtente:=strFitroUtente + ' and DATA_MSG BETWEEN TO_DATE (''';
          strFitroUtente:=strFitroUtente + ifThen(Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_DataI').AsDateTime > 0 , Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_DataI').AsString,'30/12/1899');
          strFitroUtente:=strFitroUtente + ''', ''dd/mm/yyyy'') AND TO_DATE (''' + ifThen(Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_DataF').AsDateTime > 0 , DateTimeToStr(Bc06FExecMonitorB006DtM.cdsInfoControlli.FieldByName('F_DataF').AsDateTime + 1), '31/12/3999') + ''', ''dd/mm/yyyy'')'; //alla DataF inserita aggiungo un giorno per prendere tutte le ore
          Bc06FMonitorB006.AggiungiLineeLog(Bc06FExecMonitorB006DtM.LanciaControllo(ConfServizio,ConfIstanza,strFitroUtente), True);
          Break;
        end;
      end;
    end;
  end;
end;

end.


