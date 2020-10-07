unit A064UBudgetStraordinarioDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, CheckLst,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, StrUtils, Math;

type
  TMesi = record
    Minuti:Integer;
    MinFruito:Integer;
    Importo:Real;
    ImpFruito:Real;
  end;

  TA064FBudgetStraordinarioDtM = class(TR004FGestStoricoDtM)
    selT713: TOracleDataSet;
    selT275: TOracleDataSet;
    dsrT275: TDataSource;
    selT714: TOracleDataSet;
    dsrT714: TDataSource;
    selbV430: TOracleDataSet;
    selbV430MATRICOLA: TStringField;
    selbV430COGNOME: TStringField;
    selbV430NOME: TStringField;
    selT713CODGRUPPO: TStringField;
    selT713DESCRIZIONE: TStringField;
    selT713FILTRO_ANAGRAFE: TStringField;
    selT713TIPO: TStringField;
    selT713ANNO: TFloatField;
    selT713DECORRENZA: TDateTimeField;
    selT713DECORRENZA_FINE: TDateTimeField;
    selT713ORE: TStringField;
    selT713IMPORTO: TFloatField;
    selT714CODGRUPPO: TStringField;
    selT714TIPO: TStringField;
    selT714DECORRENZA: TDateTimeField;
    selT714MESE: TFloatField;
    selT714ORE: TStringField;
    selT714IMPORTO: TFloatField;
    selT714ORE_FRUITO: TStringField;
    selT714IMPORTO_FRUITO: TFloatField;
    updT714: TOracleQuery;
    dsrV430: TDataSource;
    selbT713: TOracleDataSet;
    updT713: TOracleQuery;
    selcT713: TOracleDataSet;
    selT714ORE_AUTO: TStringField;
    selT714IMPORTO_AUTO: TFloatField;
    selT714ORE_RESIDUO: TStringField;
    selT714IMPORTO_RESIDUO: TFloatField;
    selT714ORE_RESIDUO_AUTO: TStringField;
    selT714IMPORTO_RESIDUO_AUTO: TFloatField;
    delT714: TOracleQuery;
    seldT713: TOracleDataSet;
    selaT714: TOracleQuery;
    updaT713: TOracleQuery;
    seleT713: TOracleDataSet;
    selV430: TOracleDataSet;
    selaV430: TOracleDataSet;
    selaT713: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    updaT714: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT713AfterScroll(DataSet: TDataSet);
    procedure selT713NewRecord(DataSet: TDataSet);
    procedure selT713AfterCancel(DataSet: TDataSet);
    procedure selT713CODGRUPPOValidate(Sender: TField);
    procedure selT713DECORRENZAValidate(Sender: TField);
    procedure selT713DECORRENZA_FINEValidate(Sender: TField);
    procedure selT713FILTRO_ANAGRAFEValidate(Sender: TField);
    procedure selT714BeforeInsert(DataSet: TDataSet);
    procedure selT714BeforeDelete(DataSet: TDataSet);
    procedure selT714CalcFields(DataSet: TDataSet);
    procedure selT714AfterPost(DataSet: TDataSet);
    procedure selT714BeforePost(DataSet: TDataSet);
    procedure selT713FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    AggiornaPeriodo,AggiornaFiltroAnagrafe:Boolean;
    StatoSelT713:String;
    MinTotFruito:Integer;
    ImpTotFruito:Real;
    ArrMesi:Array[1..12] of TMesi;
    wAnno:Integer;
    wDecorrenza,wDecorrenzaFine:TDateTime;
    wCodGruppo,wTipo,wFiltroAnagrafe:String;
  public
    { Public declarations }
    VariazioneOre,VariazioneImp:Boolean;
    DecIniOld,DecFinOld:TDateTime;
    lstListaGruppi: TStringList;
    procedure AperturaDettaglio;
    procedure CaricamentoMesi;
    procedure AperturaDipendenti;
    procedure EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
    procedure StruttureDisponibili(pAnno:Integer;ListaGruppi:TStringList);
    procedure CaricaListaAnni(AnnoNew:String);
  end;

var
  A064FBudgetStraordinarioDtM: TA064FBudgetStraordinarioDtM;

implementation

uses A064UBudgetStraordinario, A063UBudgetGenerazioneMW;

{$R *.dfm}

procedure TA064FBudgetStraordinarioDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstListaGruppi:=TStringList.Create;
  InizializzaDataSet(selT713,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evBeforeInsert,
                              evAfterDelete,
                              evAfterPost]);
  InterfacciaR004.LChiavePrimaria.Add('DECORRENZA');
  selT713.Filtered:=Trim(Parametri.Inibizioni.Text) <> '';
  A064FBudgetStraordinario.DButton.DataSet:=selT713;
  CaricaListaAnni(IntToStr(R180Anno(Parametri.DataLavoro)));
  selT275.Open;
end;

procedure TA064FBudgetStraordinarioDtM.CaricaListaAnni(AnnoNew:String);
var i:Integer;
  AnnoOld:String;
begin
  with A064FBudgetStraordinario do
  begin
    AnnoOld:=cmbFiltroAnno.Text;
    cmbFiltroAnno.Items.Clear;
    seleT713.Close;
    seleT713.Open;
    while not seleT713.Eof do
    begin
      cmbFiltroAnno.Items.Add(seleT713.FieldByName('ANNO').AsString);
      seleT713.Next;
    end;
    for i:=0 to cmbFiltroAnno.Items.Count - 1 do
      if cmbFiltroAnno.Items[i] = AnnoNew then
        cmbFiltroAnno.ItemIndex:=i;
    if (cmbFiltroAnno.ItemIndex = -1)
    and (cmbFiltroAnno.Items.Count > 0) then
    begin
      cmbFiltroAnno.ItemIndex:=0;
      AnnoNew:=cmbFiltroAnno.Text;
    end;
    if AnnoOld <> AnnoNew then
      cmbFiltroAnnoChange(nil);
  end;
end;

procedure TA064FBudgetStraordinarioDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstListaGruppi);
end;

procedure TA064FBudgetStraordinarioDtM.BeforePostNoStorico(DataSet: TDataSet);
var
  IniOld,FinOld:TDateTime;
  DecorrenzaUnica,AggiornaOre,AggiornaImp,FiltroOk,Visualizza:Boolean;
  Riga,Decorrenze,S,AbilitatoOld:String;
  A063MW:TA063FBudgetGenerazioneMW;
  OQ:TOracleQuery;
  i:Integer;
begin
  if selT713.State in [dsEdit] then
    AbilitatoOld:=Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').medpOldValue, selT713.FieldByName('TIPO').medpOldValue, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').medpOldValue) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').medpOldValue), selT713.FieldByName('DESCRIZIONE').medpOldValue]);
  AggiornaPeriodo:=False;
  AggiornaOre:=False;
  AggiornaImp:=False;
  AggiornaFiltroAnagrafe:=False;
  StatoSelT713:=IfThen(selT713.State in [dsEdit],'M','I');
  try
    if Trim(selT713.FieldByName('CODGRUPPO').AsString) = '' then
    begin
      A064FBudgetStraordinario.dedtCodGruppo.SetFocus;
      raise exception.Create('Indicare il codice del gruppo del budget di straordinario!');
    end;
    if Trim(selT713.FieldByName('TIPO').AsString) = '' then
    begin
      A064FBudgetStraordinario.dcmbTipoQuota.SetFocus;
      raise exception.Create('Indicare il tipo del budget di straordinario!');
    end;
    if Trim(selT713.FieldByName('ANNO').AsString) = '' then
    begin
      A064FBudgetStraordinario.dedtAnno.SetFocus;
      raise exception.Create('Indicare l''anno di riferimento!');
    end
    else
      for i:=0 to A064FBudgetStraordinario.cmbFiltroAnno.Items.Count - 1 do
        if (Trim(selT713.FieldByName('ANNO').AsString) = A064FBudgetStraordinario.cmbFiltroAnno.Items[i])
        and (A064FBudgetStraordinario.cmbFiltroAnno.Text <> A064FBudgetStraordinario.cmbFiltroAnno.Items[i]) then
        begin
          A064FBudgetStraordinario.dedtAnno.SetFocus;
          raise exception.Create('L''anno di riferimento deve essere uguale a quello indicato in Filtro anno!');
        end;
    if selT713.FieldByName('DECORRENZA').AsDateTime > selT713.FieldByName('DECORRENZA_FINE').AsDateTime then
      raise exception.Create('Il mese di inizio validità non può essere successivo al mese di fine validità!');
    //Controllo che non sia stato inserito un codice gruppo che non si poteva visualizzare
    //if selT713.State in [dsInsert] then
    begin
      Visualizza:=False;
      selbT713.Close;
      selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
      selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
      selbT713.SetVariable('ID_RIGA',IfThen(selT713.State in [dsInsert],'ROWIDROWIDROWIDROW',selT713.Rowid));
      selbT713.Open;
      if (Trim(Parametri.Inibizioni.Text) <> '')
      and not selbT713.Eof then
      begin
        for i:=0 to lstListaGruppi.Count - 1 do
          if Trim(Copy(lstListaGruppi[i],1,10)) = selT713.FieldByName('CODGRUPPO').AsString then
          begin
            Visualizza:=True;
            Break;
          end;
      end
      else
        Visualizza:=True;
      if not Visualizza then
        raise exception.Create('Non è possibile effettuare ' + IfThen(selT713.State in [dsInsert],'l''inserimento','la modifica')  + ' in quanto il codice gruppo indicato è già legato ad un filtro anagrafe che non estrarrebbe nessun dipendente nel periodo indicato per l''operatore corrente!');
    end;
    if Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
    begin
      A064FBudgetStraordinario.dedtFiltroAnagrafe.SetFocus;
      raise exception.Create('Indicare il filtro anagrafe!');
    end
    else
    begin
      OQ:=TOracleQuery.Create(nil);
      try
        OQ.Session:=SessioneOracle;
        OQ.SQL.Text:=QVistaOracle;
        OQ.SQL.Insert(0,'SELECT COUNT(*) FROM');
        OQ.Sql.Add('AND (');
        Riga:=Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
        // sostituisce la parola riservata :NOME_UTENTE con un valore costante convenzionale
        // (l'execute ha infatti il solo fine di verificare la sintassi del filtro di selezione)
        Riga:=StringReplace(Riga,':NOME_UTENTE','''PROVA''',[rfReplaceAll,rfIgnoreCase]);
        OQ.Sql.Add(Riga);
        OQ.Sql.Add(')');
        //Imposto la data di lavoro per i dati storici
        OQ.DeclareVariable('DataLavoro',otDate);
        OQ.SetVariable('DataLavoro',Parametri.DataLavoro);
        try
          OQ.Execute;
        except
          on E:Exception do
          begin
            ShowMessage('Filtro anagrafe errato!' + #13#10 + E.Message);
            Abort;
          end;
        end;
      finally
        OQ.Free;
      end;
      //Controllo che l'utente veda i dipendenti del filtro anagrafe
      EseguiFiltroAnagrafeUtente(selT713.FieldByName('ANNO').AsInteger,R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime),R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
      if selV430.Active and (selV430.RecordCount > 0) then
      begin
        FiltroOk:=False;
        selaV430.Close;
        S:=StringReplace(QVistaOracle,
                         ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                         ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                         [rfIgnoreCase]);
        S:=StringReplace(S,
                         ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                         ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                         [rfIgnoreCase]);
        selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
        selaV430.SetVariable('C700DATADAL',selT713.FieldByName('DECORRENZA').AsDateTime);
        selaV430.SetVariable('DATALAVORO',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
        selaV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
        selaV430.Open;
        while not selaV430.Eof do
        begin
          if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
          begin
            FiltroOk:=True;
            Break;
          end;
          selaV430.Next;
        end;
        if not FiltroOk and (selT713.State in [dsInsert]) then
          raise exception.Create('Non è possibile effettuare l''inserimento in quanto il filtro anagrafe indicato non estrarrebbe nessun dipendente nel periodo indicato per l''operatore corrente!');
      end;
    end;
    if (selT713.State in [dsEdit]) then
    begin
      if (selT713.FieldByName('DECORRENZA').AsDateTime <> DecIniOld)
      or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> DecFinOld) then
      begin
        selaT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
        selaT714.SetVariable('DECORRENZA',DecIniOld);
        selaT714.Execute;
        if StrToIntDef(VarToStr(selaT714.Field(0)),0) > 0 then
          if R180MessageBox('Attenzione! E'' già stato registrato del fruito per il gruppo ' + selT713.FieldByName('CODGRUPPO').AsString + ' nel periodo ' + FormatDateTime('mm',DecIniOld) + '-' + FormatDateTime('mm/yyyy',DecFinOld) + '. Proseguire con la modifica del periodo di validità, sovrascrivendo l''assegnazione mensile del budget?','DOMANDA') <> mrYes then
            abort
          else
            AggiornaPeriodo:=True;
      end;
      if Trim(selT713.FieldByName('FILTRO_ANAGRAFE').AsString) <> Trim(VarToStr(selT713.FieldByName('FILTRO_ANAGRAFE').medpOldValue)) then
        if R180MessageBox('Attenzione! Il filtro anagrafe indicato differisce da quello precedentemente impostato. Per ognuno dei tipi del gruppo ' + selT713.FieldByName('CODGRUPPO').AsString + ' nel periodo ' + FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime) + ' verrà applicato il nuovo filtro e bisognerà ricalcolare il fruito. Proseguire?','DOMANDA') <> mrYes then
          abort
        else
          AggiornaFiltroAnagrafe:=True;
      if Trim(selT713.FieldByName('ORE').AsString) <> Trim(VarToStr(selT713.FieldByName('ORE').medpOldValue)) then
        if R180MessageBox('Attenzione! E'' stato modificato il valore di Ore. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?','DOMANDA') <> mrYes then
          abort
        else
          AggiornaOre:=True;
      if R180AzzeraPrecisione(selT713.FieldByName('IMPORTO').AsFloat - StrToFloatDef(VarToStr(selT713.FieldByName('IMPORTO').medpOldValue),0),2) <> 0 then
        if R180MessageBox('Attenzione! E'' stato modificato il valore di Importo. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?','DOMANDA') <> mrYes then
          abort
        else
          AggiornaImp:=True;
    end;
    Screen.Cursor:=crHourGlass;
    A064FBudgetStraordinario.ProgressBar1.Max:=7;
    A064FBudgetStraordinario.StatusBar.Panels[2].Text:='Salvataggio in corso...';
    A064FBudgetStraordinario.StatusBar.Repaint;
    //Controllo che non esista la stessa chiave
    selcT713.Close;
    selcT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    selcT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
    selcT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selcT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
    if selT713.State in [dsInsert] then
      selcT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW')
    else
      selcT713.SetVariable('ID_RIGA',selT713.Rowid);
    selcT713.Open;
    if selcT713.RecordCount > 0 then
      raise exception.Create('Chiave già esistente nel periodo ' + selcT713.FieldByName('DECORRENZA').AsString + '-' + selcT713.FieldByName('DECORRENZA_FINE').AsString + '!');
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    //Controllo che ci sia corrispondenza di filtri anagrafe per i diversi tipi dello stesso gruppo nello stesso periodo
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW');
    selbT713.Open;
    if not AggiornaFiltroAnagrafe then
    begin
      while not selbT713.Eof do
      begin
        if selbT713.FieldByName('FILTRO_ANAGRAFE').AsString <> selT713.FieldByName('FILTRO_ANAGRAFE').AsString then
          if R180MessageBox('Attenzione! Il filtro anagrafe indicato differisce da quello già impostato per gli altri tipi del gruppo ' + selT713.FieldByName('CODGRUPPO').AsString + ' nel periodo ' + FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime) + '. Per ognuno di essi verrà applicato il nuovo filtro e bisognerà ricalcolare il fruito. Proseguire?','DOMANDA') <> mrYes then
            abort
          else
          begin
            AggiornaFiltroAnagrafe:=True;
            Break;
          end;
        selbT713.Next;
      end;
    end;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    //Controllo che ci sia corrispondenza di periodi per i diversi tipi dello stesso gruppo
    selbT713.First;
    DecorrenzaUnica:=True;
    while not selbT713.Eof do
    begin
      if selbT713.RecNo = 1 then
      begin
        IniOld:=selbT713.FieldByName('DECORRENZA').AsDateTime;
        FinOld:=selbT713.FieldByName('DECORRENZA_FINE').AsDateTime;
      end
      else if (selbT713.FieldByName('DECORRENZA').AsDateTime <> IniOld)
           or (selbT713.FieldByName('DECORRENZA_FINE').AsDateTime <> FinOld) then
        DecorrenzaUnica:=False;
      if Pos(FormatDateTime('mm',selbT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selbT713.FieldByName('DECORRENZA_FINE').AsDateTime),Decorrenze) = 0 then
        Decorrenze:=IfThen(Decorrenze <> '',Decorrenze + Chr(10),Decorrenze) + FormatDateTime('mm',selbT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selbT713.FieldByName('DECORRENZA_FINE').AsDateTime);
      selbT713.Next;
    end;
    if not DecorrenzaUnica
    or (    (selT713.State in [dsInsert])
        and (selbT713.RecordCount > 0)
        and (   (IniOld <> selT713.FieldByName('DECORRENZA').AsDateTime)
             or (FinOld <> selT713.FieldByName('DECORRENZA_FINE').AsDateTime))) then
      raise exception.create('Il periodo indicato interseca periodi già impostati per gli altri tipi dello stesso gruppo!' + Chr(10) + Decorrenze + Chr(10) + 'Utilizzare un periodo già esistente!')
    else if (selbT713.RecordCount > 1)
        and (   (IniOld <> selT713.FieldByName('DECORRENZA').AsDateTime)
             or (FinOld <> selT713.FieldByName('DECORRENZA_FINE').AsDateTime)) then
    begin
      if R180MessageBox('Il periodo indicato differisce dal periodo (' + Decorrenze + ') già impostato per gli altri tipi dello stesso gruppo. Proseguendo verrà modificato il periodo su tutti i tipi del gruppo e, per ognuno di essi, verrà sovrascritta l''assegnazione mensile del budget. Proseguire?','DOMANDA') <> mrYes then
        abort
      else
      begin
        updT713.SetVariable('DEC_INI_NEW',selT713.FieldByName('DECORRENZA').AsDateTime);
        updT713.SetVariable('DEC_FIN_NEW',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
        updT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
        updT713.SetVariable('DEC_OLD',IniOld);
        updT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
        updT713.Execute;
        AggiornaPeriodo:=True;
      end;
    end
    else if not AggiornaPeriodo
        and (selT713.State in [dsEdit])
        and (   (selT713.FieldByName('DECORRENZA').AsDateTime <> DecIniOld)
             or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> DecFinOld)) then
      if R180MessageBox('Attenzione! E'' stato modificato il periodo di validità dei dati. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?','DOMANDA') <> mrYes then
        abort
      else
        AggiornaPeriodo:=True;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    inherited;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    //Aggiorno la decorrenza del dettaglio mensile
    if AggiornaPeriodo then
    begin
      updT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      updT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
      updT714.SetVariable('DEC_NEW',selT713.FieldByName('DECORRENZA').AsDateTime);
      { TODO : TEST IW 15 }
      // Dai test effettuati non sembra si possa arrivare a questo codice con il dataset
      // in stato dsInsert.
      updT714.SetVariable('DEC_OLD',selT713.FieldByName('DECORRENZA').medpOldValue);
      updT714.Execute;
    end;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    //Ricalcolo il dettaglio mensile di tutto il gruppo a parità di decorrenza
    if AggiornaPeriodo or AggiornaFiltroAnagrafe then
    begin
      seldT713.Close;
      seldT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      seldT713.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
      seldT713.Open;
      A063MW:=TA063FBudgetGenerazioneMW.Create(nil);
      while not seldT713.Eof do
      begin
        if AggiornaPeriodo then
          A063MW.CalcoloBudgetMensile(seldT713.FieldByName('CODGRUPPO').AsString,
                                      seldT713.FieldByName('TIPO').AsString,
                                      seldT713.FieldByName('DECORRENZA').AsDateTime,
                                      seldT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                      seldT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                      seldT713.FieldByName('ORE').AsString,
                                      seldT713.FieldByName('IMPORTO').AsFloat,
                                      True,
                                      True);
        updaT714.SetVariable('CODGRUPPO',seldT713.FieldByName('CODGRUPPO').AsString);
        updaT714.SetVariable('TIPO',seldT713.FieldByName('TIPO').AsString);
        updaT714.SetVariable('DECORRENZA',seldT713.FieldByName('DECORRENZA').AsDateTime);
        updaT714.Execute;
        seldT713.Next;
      end;
      FreeAndNil(A063MW);
    end;
    //Ricalcolo il dettaglio mensile del budget corrente
    if (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaOre or AggiornaImp then
    begin
      A063MW:=TA063FBudgetGenerazioneMW.Create(nil);
      A063MW.CalcoloBudgetMensile(selT713.FieldByName('CODGRUPPO').AsString,
                                  selT713.FieldByName('TIPO').AsString,
                                  selT713.FieldByName('DECORRENZA').AsDateTime,
                                  selT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                  selT713.FieldByName('DECORRENZA_FINE').AsDateTime,
                                  selT713.FieldByName('ORE').AsString,
                                  selT713.FieldByName('IMPORTO').AsFloat,
                                  (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaOre,
                                  (selT713.State in [dsInsert]) or AggiornaPeriodo or AggiornaImp);
      FreeAndNil(A063MW);
    end;
    if AggiornaPeriodo or AggiornaFiltroAnagrafe then
    begin
      updaT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      updaT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
      updaT714.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
      updaT714.Execute;
    end;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
    //Aggiorno il filtro anagrafe su tutto il gruppo a parità di decorrenza
    if AggiornaFiltroAnagrafe then
    begin
      updaT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
      updaT713.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
      updaT713.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
      updaT713.SetVariable('FILTRO_ANAGRAFE',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
      updaT713.Execute;
    end;
    A064FBudgetStraordinario.ProgressBar1.StepBy(1);
  finally
    Screen.Cursor:=crDefault;
    A064FBudgetStraordinario.ProgressBar1.Position:=0;
    A064FBudgetStraordinario.StatusBar.Panels[2].Text:='';
    A064FBudgetStraordinario.StatusBar.Repaint;
  end;
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    if selT713.State in [dsInsert] then
      lstListaGruppi.Add(Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]))
    else if selT713.State in [dsEdit] then
      for i:=0 to lstListaGruppi.Count - 1 do
        if AbilitatoOld = lstListaGruppi[i] then
        begin
          lstListaGruppi[i]:=IfThen(FiltroOk,Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]),'');
          Break;
        end;
  end;
  wAnno:=selT713.FieldByName('ANNO').AsInteger;
  wCodGruppo:=selT713.FieldByName('CODGRUPPO').AsString;
  wTipo:=selT713.FieldByName('TIPO').AsString;
  wDecorrenza:=selT713.FieldByName('DECORRENZA').AsDateTime;
  wDecorrenzaFine:=selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
  wFiltroAnagrafe:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString;
end;

procedure TA064FBudgetStraordinarioDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  CaricaListaAnni(IntToStr(wAnno));
  AperturaDettaglio;
  if AggiornaPeriodo or AggiornaFiltroAnagrafe then
    ShowMessage('Il fruito è stato azzerato per tutti tipi del gruppo ' + selT713.FieldByName('CODGRUPPO').AsString + ' nel periodo ' + FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime) + '!');
  if (StatoSelT713 = 'I') or AggiornaPeriodo or AggiornaFiltroAnagrafe then
    if R180MessageBox('Attenzione! Si rende necessario controllare che i dipendenti selezionati non si trovino contemporaneamente negli altri gruppi. Si vuole accedere ora alla maschera di allineamento del budget per effettuare questa operazione?','DOMANDA') <> mrYes then
      ShowMessage('Ricordarsi di lanciare manualmente il "Controllo sovrapposizione filtri anagrafe" dalla maschera <A063> Allineamento del budget')
    else
    begin
      ShowMessage('Lanciare il "Controllo sovrapposizione filtri anagrafe" dalla maschera <A063> Allineamento del budget');
      A064FBudgetStraordinario.actAccediAllineamentoBudgetExecute(nil);
    end;
end;

procedure TA064FBudgetStraordinarioDtM.AfterDelete(DataSet: TDataSet);
begin
  CaricaListaAnni(IntToStr(wAnno));
  AperturaDettaglio;
end;

procedure TA064FBudgetStraordinarioDtM.BeforeDelete(DataSet: TDataSet);
var AbilitatoOld:String;
  i:Integer;
begin
  inherited;
  delT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  delT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  delT714.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
  delT714.Execute;
  wAnno:=selT713.FieldByName('ANNO').AsInteger;
  AbilitatoOld:=Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').medpOldValue, selT713.FieldByName('TIPO').medpOldValue, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').medpOldValue) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').medpOldValue), selT713.FieldByName('DESCRIZIONE').medpOldValue]);
  for i:=0 to lstListaGruppi.Count - 1 do
    if AbilitatoOld = lstListaGruppi[i] then
    begin
      lstListaGruppi[i]:='';
      Break;
    end;
end;

procedure TA064FBudgetStraordinarioDtM.selT713AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A064FBudgetStraordinario.cmbDalMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
  A064FBudgetStraordinario.cmbAlMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
  AperturaDettaglio;
  A064FBudgetStraordinario.btnDipendenti.Enabled:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
  A064FBudgetStraordinario.AbilitaAzioni;
end;

procedure TA064FBudgetStraordinarioDtM.selT713NewRecord(DataSet: TDataSet);
begin
  inherited;
  if A064FBudgetStraordinario.cmbFiltroAnno.Text = '' then
    selT713.FieldByName('ANNO').AsInteger:=R180Anno(Parametri.DataLavoro)
  else
    selT713.FieldByName('ANNO').AsInteger:=StrToInt(A064FBudgetStraordinario.cmbFiltroAnno.Text);
  selT713.FieldByName('DECORRENZA').AsDateTime:=EncodeDate(selT713.FieldByName('ANNO').AsInteger,1,1);
  selT713.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(selT713.FieldByName('ANNO').AsInteger,12,31);
  A064FBudgetStraordinario.cmbDalMese.Text:='1';
  A064FBudgetStraordinario.cmbAlMese.Text:='12';
  selT713.FieldByName('ORE').AsString:='00.00';
  selT713.FieldByName('IMPORTO').AsFloat:=0;
end;

procedure TA064FBudgetStraordinarioDtM.selT714AfterPost(DataSet: TDataSet);
var
  Mese,i:Integer;
  MinDiff,MinInPiu,MinTot,MinTotPrec,MinTotFruitoSucc:Integer;
  ImpDiff,ImpInPiu,ImpTot,ImpTotPrec,ImpTotFruitoSucc:Real;
  BM:TBookMark;
begin
  with selT714 do
    try
      AfterPost:=nil;
      BeforePost:=nil;
      BM:=GetBookMark;
      Mese:=FieldByName('MESE').AsInteger;
      //Prelevo i valori totali e le differenze
      MinTot:=0;
      MinTotPrec:=0;
      MinTotFruitoSucc:=0;
      ImpTot:=0;
      ImpTotPrec:=0;
      ImpTotFruitoSucc:=0;
      if FieldByName('TIPO').AsString = '#ECC#' then
      begin
        First;
        while not Eof do
        begin
          MinTotFruito:=0;
          ImpTotFruito:=0;
          for i:=1 to FieldByName('MESE').AsInteger - 1 do
          begin
            if ArrMesi[i].MinFruito <> 0 then
              MinTotFruito:=ArrMesi[i].MinFruito;
            if ArrMesi[i].ImpFruito <> 0 then
              ImpTotFruito:=ArrMesi[i].ImpFruito;
          end;
          Edit;
          if VariazioneOre then
            if R180OreMinutiExt(FieldByName('ORE').AsString) > (R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - MinTotFruito) then
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - MinTotFruito);
          if VariazioneImp then
            if FieldByName('IMPORTO').AsFloat > (selT713.FieldByName('IMPORTO').AsFloat - ImpTotFruito) then
              FieldByName('IMPORTO').AsFloat:=selT713.FieldByName('IMPORTO').AsFloat - ImpTotFruito;
          Post;
          Next;
        end;
        if (VariazioneOre and (R180OreMinutiExt(FieldByName('ORE').AsString) < 0))
        or (VariazioneImp and (FieldByName('IMPORTO').AsFloat < 0)) then
          ShowMessage('Attenzione! La variazione produce disponibilità negativa sull''ultimo mese!');
      end
      else
      begin
        First;
        while not Eof do
        begin
          MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
          ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
          if FieldByName('MESE').AsInteger < Mese then
          begin
            MinTotPrec:=MinTotPrec + R180OreMinutiExt(FieldByName('ORE').AsString);
            ImpTotPrec:=ImpTotPrec + FieldByName('IMPORTO').AsFloat;
          end;
          if FieldByName('MESE').AsInteger > Mese then
          begin
            MinTotFruitoSucc:=MinTotFruitoSucc + R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
            ImpTotFruitoSucc:=ImpTotFruitoSucc + FieldByName('IMPORTO_FRUITO').AsFloat;
          end;
          Next;
        end;
        if VariazioneOre then
        begin
          GoToBookMark(BM);
          if R180OreMinutiExt(FieldByName('ORE').AsString) >= (Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito) - MinTotPrec - MinTotFruitoSucc) then
          begin
            Edit;
            MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
            FieldByName('ORE').AsString:=R180MinutiOre(Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito) - MinTotPrec - MinTotFruitoSucc);
            MinTot:=MinTot - R180OreMinutiExt(FieldByName('ORE').AsString);
            Post;
          end;
          MinDiff:=MinTot - Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito);
          //Incremento le ore sull'ultimo record, se negative
          if MinDiff < 0 then
          begin
            Last;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
            begin
              Edit;
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
              Post;
              if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
                MinDiff:=0
              else
                MinDiff:=R180OreMinutiExt(FieldByName('ORE').AsString);
            end;
          end;
          //Giro per ricalcolo ore
          GoToBookMark(BM);
          if not Eof then
            Next;
          while not Eof and (MinDiff <> 0) do
          begin
            MinInPiu:=R180OreMinutiExt(FieldByName('ORE').AsString) - R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString);
            Edit;
            if (MinInPiu - MinDiff) < 0 then
            begin
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinInPiu);
              MinDiff:=MinDiff - MinInPiu;
            end
            else
            begin
              FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
              MinDiff:=0;
            end;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < 0 then
            begin
              MinDiff:=MinDiff - R180OreMinutiExt(FieldByName('ORE').AsString);
              FieldByName('ORE').AsString:='00.00';
            end;
            if R180OreMinutiExt(FieldByName('ORE').AsString) < R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) then
            begin
              MinDiff:=MinDiff + R180OreMinutiExt(FieldByName('ORE_FRUITO').AsString) - R180OreMinutiExt(FieldByName('ORE').AsString);
              FieldByName('ORE').AsString:=FieldByName('ORE_FRUITO').AsString;
            end;
            Post;
            Next;
          end;
        end;
        if VariazioneImp then
        begin
          GoToBookMark(BM);
          if FieldByName('IMPORTO').AsFloat >= (Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito) - ImpTotPrec - ImpTotFruitoSucc) then
          begin
            Edit;
            ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
            FieldByName('IMPORTO').AsFloat:=Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito) - ImpTotPrec - ImpTotFruitoSucc;
            ImpTot:=ImpTot - FieldByName('IMPORTO').AsFloat;
            Post;
          end;
          ImpDiff:=ImpTot - Max(selT713.FieldByName('IMPORTO').AsFloat,ImpTotFruito);
          //Incremento l'importo sull'ultimo record, se negativo
          if ImpDiff < 0 then
          begin
            Last;
            if FieldByName('IMPORTO').AsFloat < 0 then
            begin
              Edit;
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
              Post;
              if FieldByName('IMPORTO').AsFloat < 0 then
                ImpDiff:=0
              else
                ImpDiff:=FieldByName('IMPORTO').AsFloat;
            end;
          end;
          //Giro per ricalcolo importo
          GoToBookMark(BM);
          if not Eof then
            Next;
          while not Eof and (ImpDiff <> 0) do
          begin
            ImpInPiu:=FieldByName('IMPORTO').AsFloat - FieldByName('IMPORTO_FRUITO').AsFloat;
            Edit;
            if (ImpInPiu - ImpDiff) < 0 then
            begin
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpInPiu;
              ImpDiff:=ImpDiff - ImpInPiu;
            end
            else
            begin
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
              ImpDiff:=0;
            end;
            if FieldByName('IMPORTO').AsFloat < 0 then
            begin
              ImpDiff:=ImpDiff - FieldByName('IMPORTO').AsFloat;
              FieldByName('IMPORTO').AsFloat:=0;
            end;
            if FieldByName('IMPORTO').AsFloat < FieldByName('IMPORTO_FRUITO').AsFloat then
            begin
              ImpDiff:=ImpDiff + FieldByName('IMPORTO_FRUITO').AsFloat - FieldByName('IMPORTO').AsFloat;
              FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO_FRUITO').AsFloat;
            end;
            Post;
            Next;
          end;
        end;
        //Controllo i totali
        MinTot:=0;
        ImpTot:=0;
        First;
        while not Eof do
        begin
          MinTot:=MinTot + R180OreMinutiExt(FieldByName('ORE').AsString);
          ImpTot:=ImpTot + FieldByName('IMPORTO').AsFloat;
          Next;
        end;
        MinDiff:=MinTot - Max(R180OreMinutiExt(selT713.FieldByName('ORE').AsString),MinTotFruito);
        ImpDiff:=ImpTot - selT713.FieldByName('IMPORTO').AsFloat;
        Edit;
        if VariazioneOre and (MinDiff <> 0) then
          FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('ORE').AsString) - MinDiff);
        if VariazioneImp and (ImpDiff <> 0) then
          FieldByName('IMPORTO').AsFloat:=FieldByName('IMPORTO').AsFloat - ImpDiff;
        Post;
        if (VariazioneOre and (R180OreMinutiExt(FieldByName('ORE').AsString) < 0))
        or (VariazioneImp and (FieldByName('IMPORTO').AsFloat < 0)) then
          ShowMessage('Attenzione! La variazione produce disponibilità negativa sull''ultimo mese!');
      end;
    finally
      CaricamentoMesi;
      GoToBookMark(BM);
      FreeBookMark(BM);
      AfterPost:=selT714AfterPost;
      BeforePost:=selT714BeforePost;
    end;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TA064FBudgetStraordinarioDtM.selT714BeforePost(DataSet: TDataSet);
begin
  inherited;
  VariazioneOre:=R180OreMinutiExt(selT714.FieldByName('ORE').AsString) <> ArrMesi[selT714.FieldByName('MESE').AsInteger].Minuti;
  VariazioneImp:=selT714.FieldByName('IMPORTO').AsFloat <> ArrMesi[selT714.FieldByName('MESE').AsInteger].Importo;
  selT714.FieldByName('ORE').AsString:=Trim(selT714.FieldByName('ORE').AsString);
  (*if VariazioneOre and (R180OreMinutiExt(selT714.FieldByName('ORE').AsString) < R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString)) then
    raise exception.create('Non è possibile indicare un valore inferiore alle ore già fruite!');
  if VariazioneImp and (selT714.FieldByName('IMPORTO').AsFloat < selT714.FieldByName('IMPORTO_FRUITO').AsFloat) then
    raise exception.create('Non è possibile indicare un valore inferiore all''importo già fruito!');*)
end;

procedure TA064FBudgetStraordinarioDtM.selT714CalcFields(DataSet: TDataSet);
var OreMese: String;
  ImpMese: Real;
  RigaMese: Integer;
begin
  inherited;
  if selT714.RecordCount > 0 then
  begin
    RigaMese:=selT714.FieldByName('MESE').AsInteger - R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime) + 1;
    OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) div selT714.RecordCount);
    ImpMese:=R180Arrotonda(selT713.FieldByName('IMPORTO').AsFloat / selT714.RecordCount,0.01,'P');
    if RigaMese = selT714.RecordCount then
    begin
      if selT714.FieldByName('TIPO').AsString = '#ECC#' then
      begin
        OreMese:=selT713.FieldByName('ORE').AsString;
        ImpMese:=selT713.FieldByName('IMPORTO').AsFloat;
      end
      else
      begin
        OreMese:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - (R180OreMinutiExt(OreMese) * (selT714.RecordCount - 1)));
        ImpMese:=selT713.FieldByName('IMPORTO').AsFloat - (ImpMese * (selT714.RecordCount - 1));
      end;
    end
    else if selT714.FieldByName('TIPO').AsString = '#ECC#' then
    begin
      OreMese:=R180MinutiOre(R180OreMinutiExt(OreMese) * RigaMese);
      ImpMese:=ImpMese * RigaMese;
    end;
    selT714.FieldByName('ORE_AUTO').AsString:=OreMese;
    selT714.FieldByName('ORE_RESIDUO_AUTO').AsString:=R180MinutiOre(R180OreMinutiExt(selT714.FieldByName('ORE_AUTO').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString));
    selT714.FieldByName('ORE_RESIDUO').AsString:=R180MinutiOre(R180OreMinutiExt(selT714.FieldByName('ORE').AsString) - R180OreMinutiExt(selT714.FieldByName('ORE_FRUITO').AsString));
    selT714.FieldByName('IMPORTO_AUTO').AsFloat:=ImpMese;
    selT714.FieldByName('IMPORTO_RESIDUO_AUTO').AsFloat:=selT714.FieldByName('IMPORTO_AUTO').AsFloat - selT714.FieldByName('IMPORTO_FRUITO').AsFloat;
    selT714.FieldByName('IMPORTO_RESIDUO').AsFloat:=selT714.FieldByName('IMPORTO').AsFloat - selT714.FieldByName('IMPORTO_FRUITO').AsFloat;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.selT713AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A064FBudgetStraordinario.cmbDalMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA').AsDateTime));
  A064FBudgetStraordinario.cmbAlMese.Text:=IntToStr(R180Mese(selT713.FieldByName('DECORRENZA_FINE').AsDateTime));
  AperturaDettaglio;
end;

procedure TA064FBudgetStraordinarioDtM.selT713CODGRUPPOValidate(Sender: TField);
var i:Integer;
  Assegna:Boolean;
begin
  inherited;
  if selT713.State in [dsInsert] then
  begin
    Assegna:=False;
    selbT713.Close;
    selbT713.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
    selbT713.SetVariable('DEC_INI',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbT713.SetVariable('DEC_FIN',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbT713.SetVariable('ID_RIGA','ROWIDROWIDROWIDROW');
    selbT713.Open;
    if not selbT713.Eof and (selbT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '') then
    begin
      if Trim(Parametri.Inibizioni.Text) <> '' then
      begin
        for i:=0 to lstListaGruppi.Count - 1 do
          if Trim(Copy(lstListaGruppi[i],1,10)) = selT713.FieldByName('CODGRUPPO').AsString then
          begin
            Assegna:=True;
            Break;
          end;
      end
      else
        Assegna:=True;
      if Assegna then
        selT713.FieldByName('FILTRO_ANAGRAFE').AsString:=selbT713.FieldByName('FILTRO_ANAGRAFE').AsString;
    end;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.selT713DECORRENZAValidate(Sender: TField);
begin
  inherited;
  if selT713.State in [dsInsert] then
    DecIniOld:=selT713.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TA064FBudgetStraordinarioDtM.selT713DECORRENZA_FINEValidate(Sender: TField);
begin
  inherited;
  if selT713.State in [dsInsert] then
    DecFinOld:=selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
end;

procedure TA064FBudgetStraordinarioDtM.selT713FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var i: Integer;
begin
  inherited;
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    Accept:=False;
    for i:=0 to lstListaGruppi.Count - 1 do
      if Format('%-10s %-5s %10s %-100s',[selT713.FieldByName('CODGRUPPO').AsString, selT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selT713.FieldByName('DECORRENZA_FINE').AsDateTime), selT713.FieldByName('DESCRIZIONE').AsString]) = lstListaGruppi[i] then
      begin
        Accept:=True;
        Break;
      end;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.selT713FILTRO_ANAGRAFEValidate(
  Sender: TField);
begin
  inherited;
  A064FBudgetStraordinario.btnDipendenti.Enabled:=selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> '';
end;

procedure TA064FBudgetStraordinarioDtM.AperturaDettaglio;
begin
  selT714.Close;
  selT714.SetVariable('CODGRUPPO',selT713.FieldByName('CODGRUPPO').AsString);
  selT714.SetVariable('TIPO',selT713.FieldByName('TIPO').AsString);
  selT714.SetVariable('DECORRENZA',selT713.FieldByName('DECORRENZA').AsDateTime);
  selT714.Open;
  CaricamentoMesi;
end;

procedure TA064FBudgetStraordinarioDtM.CaricamentoMesi;
var i:Integer;
begin
  MinTotFruito:=0;
  ImpTotFruito:=0;
  for i:=1 to High(ArrMesi) do
  begin
    ArrMesi[i].Minuti:=R180OreMinutiExt(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'ORE')));
    ArrMesi[i].MinFruito:=R180OreMinutiExt(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'ORE_FRUITO')));
    ArrMesi[i].Importo:=StrToFloatDef(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'IMPORTO')),0);
    ArrMesi[i].ImpFruito:=StrToFloatDef(VarToStr(selT714.Lookup('MESE',VarArrayOf([i]),'IMPORTO_FRUITO')),0);
    //
    if selT714.FieldByName('TIPO').AsString <> '#ECC#' then
    begin
      MinTotFruito:=MinTotFruito + ArrMesi[i].MinFruito;
      ImpTotFruito:=ImpTotFruito + ArrMesi[i].ImpFruito;
    end;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.AperturaDipendenti;
var s:String;
begin
  if (selT713.FieldByName('DECORRENZA').AsDateTime <> selbV430.GetVariable('C700DATADAL'))
  or (selT713.FieldByName('DECORRENZA_FINE').AsDateTime <> selbV430.GetVariable('DATALAVORO'))
  or (selT713.FieldByName('FILTRO_ANAGRAFE').AsString <> selbV430.GetVariable('FILTRO')) then
  begin
    selbV430.Close;
    //selbV430.SetVariable('QVISTAORACLE',QVistaOraclePeriodica + #10#13 + QVistaInServizioPeriodica);
    S:=StringReplace(QVistaOracle,
                     ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                     ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                     [rfIgnoreCase]);
    S:=StringReplace(S,
                     ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                     ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                     [rfIgnoreCase]);
    selbV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
    selbV430.SetVariable('C700DATADAL',selT713.FieldByName('DECORRENZA').AsDateTime);
    selbV430.SetVariable('DATALAVORO',selT713.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbV430.SetVariable('FILTRO',selT713.FieldByName('FILTRO_ANAGRAFE').AsString);
    selbV430.Open;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.EseguiFiltroAnagrafeUtente(pAnno,pDaMese,pAMese:Integer);
var S:String;
begin
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    if (pAnno > 0) and (pDaMese > 0) and (pAMese > 0) and
       (   (selV430.GetVariable('C700DATADAL') <> EncodeDate(pAnno,pDaMese,1))
        or (selV430.GetVariable('DATALAVORO') <> R180FineMese(EncodeDate(pAnno,pAMese,1)))) then
    begin
      selV430.Close;
      S:=StringReplace(QVistaOracle,
                       ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                       ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                       [rfIgnoreCase]);
      S:=StringReplace(S,
                       ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                       ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                       [rfIgnoreCase]);
      selV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
      selV430.SetVariable('C700DATADAL',EncodeDate(pAnno,pDaMese,1));
      selV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(pAnno,pAMese,1)));
      selV430.SetVariable('FILTRO',Parametri.Inibizioni.Text);
      if Pos(':NOME_UTENTE',Parametri.Inibizioni.Text) > 0  then
      begin
        try
          selV430.DeleteVariable('NOME_UTENTE');
        except
        end;
        selV430.DeclareVariable('NOME_UTENTE',otString);
        selV430.SetVariable('NOME_UTENTE',Parametri.Operatore);
      end;
      selV430.Open;
    end;
  end;
end;

procedure TA064FBudgetStraordinarioDtM.StruttureDisponibili(pAnno:Integer;ListaGruppi:TStringList);
//Estrazione delle strutture disponibili per l'operatore (FiltroAnagrafe e anno)
var
  FiltroOk: Boolean;
  s,FiltroOld: String;
  DecIniOld,DecFinOld: TDateTime;
begin
  if pAnno > 0 then
  begin
    Screen.Cursor:=crHourGlass;
    selaT713.Close;
    selaT713.SetVariable('FiltroPeriodo','WHERE ANNO = ' + IntToStr(pAnno));
    selaT713.Open;
    ListaGruppi.Clear;
    FiltroOk:=False;
    FiltroOld:='*';
    DecIniOld:=EncodeDate(pAnno,1,1) - 1;
    DecFinOld:=EncodeDate(pAnno,1,1) - 1;
    while not selaT713.Eof do
    begin
      if (Trim(Parametri.Inibizioni.Text) <> '') then
      begin
        if (selaT713.FieldByName('FILTRO_ANAGRAFE').AsString <> FiltroOld)
        or (selaT713.FieldByName('DECORRENZA').AsDateTime <> DecIniOld)
        or (selaT713.FieldByName('DECORRENZA_FINE').AsDateTime <> DecFinOld) then
        begin
          FiltroOk:=False;
          EseguiFiltroAnagrafeUtente(pAnno,R180Mese(selaT713.FieldByName('DECORRENZA').AsDateTime),R180Mese(selaT713.FieldByName('DECORRENZA_FINE').AsDateTime));
          if selV430.Active and (selV430.RecordCount > 0) then
          begin
            selaV430.Close;
            S:=StringReplace(QVistaOracle,
                             ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                             ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                             [rfIgnoreCase]);
            S:=StringReplace(S,
                             ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                             ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                             [rfIgnoreCase]);
            selaV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
            selaV430.SetVariable('C700DATADAL',selaT713.FieldByName('DECORRENZA').AsDateTime);
            selaV430.SetVariable('DATALAVORO',selaT713.FieldByName('DECORRENZA_FINE').AsDateTime);
            selaV430.SetVariable('FILTRO',selaT713.FieldByName('FILTRO_ANAGRAFE').AsString);
            selaV430.Open;
            while not selaV430.Eof do
            begin
              if selV430.SearchRecord('PROGRESSIVO',selaV430.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
              begin
                FiltroOk:=True;
                Break;
              end;
              selaV430.Next;
            end;
          end;
          FiltroOld:=selaT713.FieldByName('FILTRO_ANAGRAFE').AsString;
          DecIniOld:=selaT713.FieldByName('DECORRENZA').AsDateTime;
          DecFinOld:=selaT713.FieldByName('DECORRENZA_FINE').AsDateTime;
        end
      end
      else
        FiltroOk:=True;
      if FiltroOk then
        ListaGruppi.Add(Format('%-10s %-5s %10s %-100s',[selaT713.FieldByName('CODGRUPPO').AsString, selaT713.FieldByName('TIPO').AsString, FormatDateTime('mm',selaT713.FieldByName('DECORRENZA').AsDateTime) + '-' + FormatDateTime('mm/yyyy',selaT713.FieldByName('DECORRENZA_FINE').AsDateTime), selaT713.FieldByName('DESCRIZIONE').AsString]));
      selaT713.Next;
    end;
    Screen.Cursor:=crDefault;
  end;
end;

end.
