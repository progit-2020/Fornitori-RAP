unit A114UEstrazioniStampe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, Db, ImgList, ActnList, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  C700USelezioneAnagrafe, SelAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, A113UParEstrazioniStampe, Mask,
  OracleData, C004UParamForm, Variants, A083UMsgElaborazioni, System.Actions;

type
  TA114FEstrazioniStampe = class(TForm)
    ActionList1: TActionList;
    actVisualizzaFile: TAction;
    actEsci: TAction;
    actEseguiInvio: TAction;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    VisualizzaFile: TMenuItem;
    VisualizzaFile1: TMenuItem;
    EseguiInvio: TMenuItem;
    N4: TMenuItem;
    Esci: TMenuItem;
    Panel2: TPanel;
    btnEsci: TBitBtn;
    btnEsegui: TBitBtn;
    btnAnteprima: TBitBtn;
    btnAnomalie: TBitBtn;
    VisualizzaAnomalie1: TMenuItem;
    actAnomalie: TAction;
    pmnParametri: TPopupMenu;
    NuovoElemento1: TMenuItem;
    actVisualizzaBatch: TAction;
    N2: TMenuItem;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    LblNomeFile: TLabel;
    edtNomeFile: TEdit;
    rgpFileEsistente: TRadioGroup;
    dCmbParametri: TDBLookupComboBox;
    Label1: TLabel;
    edtDescrStampa: TEdit;
    Label2: TLabel;
    edtNomeStampa: TEdit;
    ProgressBar1: TProgressBar;
    procedure dCmbParametriKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dCmbParametriCloseUp(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure VisualizzaFile1Click(Sender: TObject);
    procedure EsciClick(Sender: TObject);
    procedure dCmbParametriKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    sPv_LogStatistiche: TStringList;
    //procedure AggiungiMessaggioLog(sMessaggio:string);
    procedure CreaTabellaTemporanea;
    procedure PopolaTabellaTemporanea;
    procedure CreaTabellaOracle;
    procedure EliminaTabellaOracle;
    procedure PopolaTabellaOracle;
    procedure PopolaFileAscii;
    procedure VerificaValoreNull(xCampo:TField);
    function FormattaValoreCampo(NomeCampo:string; DimensioneCampo:integer; ValoreCampo:string):string;
  public
    { Public declarations }
  end;

var
  A114FEstrazioniStampe: TA114FEstrazioniStampe;
//Costanti per la gestione del TIPO dato
const sPc_StrutturaImpiego:string = 'STRUTTURA IMPIEGO';
const sPc_CodDipartimentoImpiego:string = 'DIPARTIMENTO IMPIEGO';
const sPc_DescDipartimentoImpiego:string = 'DESC.DIPART.IMPIEGO';
const sPc_UnitaOperativaImpiego:string = 'UNITA OPERATIVA';
const sPc_TotaleOreUOImpiego:string = 'ORE UNITA OPERATIVA';
const sPc_SommaRicorrenzeN:string = 'NON SOMMARE';
const sPc_SommaRicorrenzeS:string = 'SOMMA SEMPRE';
//const sPc_SommaRicorrenzeX:string = 'SOMMA SE TOT = 0';
const sPc_SommaRicorrenzeX:string = 'CUMULA STORICO';

procedure OpenA114EstrazioniStampe;

implementation

uses A114UEstrazioniStampeDtm, A114UVisFile;

{$R *.DFM}

procedure OpenA114EstrazioniStampe;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA114EstrazioniStampe') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A114FEstrazioniStampeDtM:=TA114FEstrazioniStampeDtM.Create(nil);
  A114FEstrazioniStampe:=TA114FEstrazioniStampe.Create(nil);
  try
    A114FEstrazioniStampe.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A114FEstrazioniStampe.Free;
    A114FEstrazioniStampeDtM.Free;
  end;
end;

procedure TA114FEstrazioniStampe.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A114',Parametri.ProgOper);
  dCmbParametri.KeyValue:=C004FParamForm.GetParametro('PARAMETRI','');
  if C004FParamForm.GetParametro('ESISTENTE','R') = 'R' then
    RgpFileEsistente.ItemIndex:=1
  else
    RgpFileEsistente.ItemIndex:=0;
  sPv_LogStatistiche:=TStringList.Create;
  dCmbParametriCloseUp(nil);
  btnAnomalie.Enabled:=False;
end;

procedure TA114FEstrazioniStampe.dCmbParametriCloseUp(Sender: TObject);
begin
  VisualizzaAnomalie1.Enabled:=False;
  with A114FEstrazioniStampeDtm do
  begin
    if SelT930TIPO_FILE.AsString = 'A' then
    begin
      LblNomeFile.Caption:='Nome file ascii:';
      rgpFileEsistente.Caption:='File esistente';
      btnAnteprima.Caption:='Vis.file ascii';
      VisualizzaFile1.Caption:='Vis.file ascii';
    end
    else
    begin
      LblNomeFile.Caption:='Nome tabella oracle:';
      rgpFileEsistente.Caption:='Tabella esistente';
      btnAnteprima.Caption:='Vis.tab.oracle';
      VisualizzaFile1.Caption:='Vis.tab.oracle';
    end;
    edtNomeFile.Text:=SelT930.FieldByName('NOME_FILE').AsString;
    edtNomeStampa.Text:=SelT930.FieldByName('CODICE_STAMPA').AsString;
    edtDescrStampa.Text:=SelT930.FieldByName('TITOLO').AsString;
  end;
end;

procedure TA114FEstrazioniStampe.NuovoElemento1Click(Sender: TObject);
begin
  with A114FEstrazioniStampeDtm do
  begin
    OpenA113ParEstrazioniStampe(SelT930CODICE_PAR.AsString);
    SelT930.DisableControls;
    SelT930.Refresh;
    SelT930.EnableControls;
  end;
end;

procedure TA114FEstrazioniStampe.EsciClick(Sender: TObject);
begin
  Close;
end;

procedure TA114FEstrazioniStampe.VisualizzaFile1Click(Sender: TObject);
begin
  with A114FEstrazioniStampeDtm do
  begin
    if SelT930TIPO_FILE.AsString = 'A' then
    begin
      if not fileexists(SelT930.FieldByName('NOME_FILE').AsString) then
        raise exception.Create('File ''' + SelT930.FieldByName('NOME_FILE').AsString + ''' inesistente');
      try
        A114FVisFile:=TA114FVisFile.Create(nil);
        A114FVisFile.Caption:='<A114> File ascii di estrazione dati dal generatore di stampe';
        A114FVisFile.DbGrdLog.Visible:=False;
        A114FVisFile.memoAnomalie.Align:=alClient;
        A114FVisFile.memoAnomalie.Clear;
        A114FVisFile.memoAnomalie.Lines.LoadFromFile(SelT930.FieldByName('NOME_FILE').AsString);
        A114FVisFile.ShowModal;
      finally
        A114FVisFile.Free;
      end;
    end
    else
    begin
      QSelect.Close;
      QSelect.SQL.Clear;
      QSelect.SQL.Add('SELECT * FROM T920_' + SelT930.FieldByName('NOME_FILE').AsString);
      try
        QSelect.Open;
      except
        on e:exception do
          if Pos('ORA-00942', e.Message) > 0 then
            raise exception.Create('Tabella oracle ' + SelT930.FieldByName('NOME_FILE').AsString + ' inesistente')
          else
            raise;
      end;
      try
        screen.Cursor:=crHourGlass;
        A114FVisFile:=TA114FVisFile.Create(nil);
        A114FVisFile.Caption:='<A114> Tabella oracle di estrazione dati dal generatore di stampe';
        A114FVisFile.memoAnomalie.Visible:=False;
        A114FVisFile.DbGrdLog.Align:=alClient;
        A114FVisFile.DbGrdLog.Columns.Clear;
        QSelect.Close;
        QSelect.SQL.Clear;
        QSelect.SQL.Add('SELECT * FROM T920_' + SelT930.FieldByName('NOME_FILE').AsString);
        QSelect.Open;
        A114FVisFile.DbGrdLog.DataSource:=DSelect;
        screen.Cursor:=crDefault;
        A114FVisFile.ShowModal;
      finally
        A114FVisFile.Free;
      end;
    end;
  end;
end;

procedure TA114FEstrazioniStampe.btnEseguiClick(Sender: TObject);
var
  sQuery,sChiave:string;
begin
  sQuery:='';
  sPv_LogStatistiche.Clear;
  RegistraMsg.IniziaMessaggio('A114');
  ProgressBar1.Position:=0;
  Screen.Cursor:=crHourGlass;
  with A114FEstrazioniStampeDtm do
  begin
    //Cancello i vecchi dati dal file di Log
    DelT932.SetVariable('Operatore',Parametri.Operatore);
    DelT932.SetVariable('Maschera','A114');
    DelT932.Execute;
    //Seleziono i campi che fanno parte della parametrizzazione
    SelT931.Close;
    SelT931.SetVariable('codicepar', dCmbParametri.KeyValue);
    SelT931.Open;
    sChiave:='';
    while not SelT931.eof do
    begin
      sQuery:=sQuery + SelT931DATO.asString + ', ';
      if SelT931.FieldByName('CHIAVE').asString = 'S' then
        sChiave:=sChiave + SelT931DATO.asString + ',';
      SelT931.Next;
    end;
    sQuery:=sQuery + 'PROGRESSIVO, T430DATADECORRENZA';
    //Eseguo la query sulla tabella generata dal generatore di stampe che deve già essere ordinata per dipendente
    QSelect.Close;
    QSelect.SQL.Clear;
    QSelect.SQL.Add('SELECT ' + sQuery + ' FROM T920' + SelT930TABELLA_GENERATA.asString);
    if sChiave <> '' then
      QSelect.SQL.Add('ORDER BY ' + Copy(sChiave,1,length(sChiave) - 1));
    //AggiungiMessaggioLog('Query di estrazione dati dal generatore di stampe: ' + QSelect.SQL.Text);
    RegistraMsg.InserisciMessaggio('I','Query di estrazione dati dal generatore di stampe: ' + QSelect.SQL.Text);
    QSelect.Open;
    ProgressBar1.Min:=0;
    ProgressBar1.Max:=QSelect.RecordCount * 2;
    sPv_LogStatistiche.Add('Records presenti sulla tabella ' + SelT930TABELLA_GENERATA.asString + ': ' + inttostr(QSelect.RecordCount));
    RegistraMsg.InserisciMessaggio('I','Records presenti sulla tabella ' + SelT930TABELLA_GENERATA.asString + ': ' + inttostr(QSelect.RecordCount));
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                 //
    //                                           CREAZIONE DELLA TABELLA TEMPORANEA                                    //
    //                                                    (client dataset)                                             //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ProgressBar1.StepBy(1);
    CreaTabellaTemporanea;
    ProgressBar1.StepBy(1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                 //
    //                                         POPOLAMENTO DELLA TABELLA TEMPORANEA                                    //
    //                                                    (client dataset)                                             //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    PopolaTabellaTemporanea;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                 //
    //                                         CREAZIONE FILE ASCII/TABELLA ORACLE                                     //
    //                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Mi posiziono sul primo record della tabella temporanea
    TabellaTemp.First;
    if SelT930TIPO_FILE.AsString = 'A' then  //FILE ASCII
      PopolaFileAscii
    else if SelT930TIPO_FILE.AsString = 'O' then  //TABELLA ORACLE
    begin
      //AggiungiMessaggioLog('INIZIO POPOLAMENTO TABELLA ORACLE ' + SelT930.FieldByName('NOME_FILE').AsString);
      RegistraMsg.InserisciMessaggio('I','INIZIO POPOLAMENTO TABELLA ORACLE ' + SelT930.FieldByName('NOME_FILE').AsString);
      if rgpFileEsistente.ItemIndex = 0 then  //Aggiungi
      begin
        //AggiungiMessaggioLog('Apertura tabella oracle in modalità ''Aggiungi''');
        RegistraMsg.InserisciMessaggio('I','Apertura tabella oracle in modalità ''Aggiungi''');
        //Verifico che la tabella oracle sia già esistente
        QSelect.Close;
        QSelect.SQL.Clear;
        QSelect.SQL.Add('SELECT * FROM T920_' + SelT930.FieldByName('NOME_FILE').AsString);
        try
          QSelect.Open;
          //AggiungiMessaggioLog('La tabella oracle esiste già');
          RegistraMsg.InserisciMessaggio('A','La tabella oracle esiste già');
        except
          on e:exception do
          begin
            //Se viene generato l'errore oracle "Table or view does not exists" gestisco l'errore
            //e creo la tabella
            if Pos('ORA-00942', e.Message) > 0 then
            begin
              //AggiungiMessaggioLog('La tabella oracle non esiste');
              RegistraMsg.InserisciMessaggio('A','La tabella oracle non esiste');
              //Creo la tabella
              ProgressBar1.StepBy(1);
              CreaTabellaOracle;
            end
            else
            begin
              Screen.Cursor:=crDefault;
              raise;
            end;
          end;
        end;
        //Popolo la tabella Oracle
        PopolaTabellaOracle;
      end
      else
      begin
        //AggiungiMessaggioLog('Apertura tabella oracle in modalità ''Ricrea''');
        RegistraMsg.InserisciMessaggio('I','Apertura tabella oracle in modalità ''Ricrea''');
        //Elimino la tabella esistente
        ProgressBar1.StepBy(1);
        EliminaTabellaOracle;
        //Creo la tabella
        ProgressBar1.StepBy(1);
        CreaTabellaOracle;
        //Popolo la tabella Oracle
        PopolaTabellaOracle;
      end;
      //AggiungiMessaggioLog('FINE POPOLAMENTO TABELLA ORACLE');
      RegistraMsg.InserisciMessaggio('I','FINE POPOLAMENTO TABELLA ORACLE');
    end;
    ProgressBar1.Position:=Progressbar1.Max;
  end;
  Screen.Cursor:=crDefault;
  ShowMessage('Elaborazione terminata!');
  ProgressBar1.Position:=0;  
  //AggiungiMessaggioLog('Elaborazione terminata!');
  RegistraMsg.InserisciMessaggio('I','Elaborazione terminata!');
  //for i:=0 to sPv_LogStatistiche.Count-1 do
  //  AggiungiMessaggioLog(sPv_LogStatistiche[i]);

  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    btnAnomalie.Enabled:=True;
    if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata',INFORMA);
end;

procedure TA114FEstrazioniStampe.PopolaTabellaTemporanea;
var
  nProgressivo, i, n, nVariazioniMax, nStruttura:integer;
  sDep:string;
  bInserisci:boolean;
  nElaborati, nScartati, nInseriti: integer;
  dDecorrenzaValore: TDateTime;
  sDecorrenzaValore:string;
begin
  sDep:='';
  nElaborati:=0;
  nScartati:=0;
  nInseriti:=0;
  //AggiungiMessaggioLog('INIZIO POPOLAMENTO TABELLA TEMPORANEA');
  RegistraMsg.InserisciMessaggio('I','INIZIO POPOLAMENTO TABELLA TEMPORANEA');
  with A114FEstrazioniStampeDtm do
  begin
    nProgressivo:=0;
    nStruttura:=1;
    QSelect.First;
    //Inizio l'elaborazione e la scrittura delle informazioni nella tabella temporanea
    while not QSelect.Eof do
    begin
      n:=0;
      nElaborati:=nElaborati+1;
      //Se sono su un nuovo dipendente
      if nProgressivo <> QSelect.FieldByName('PROGRESSIVO').asInteger then
      begin
        sDecorrenzaValore:='';
        //Aggiungo il record nella tabella temporanea
        if TabellaTemp.State = dsInsert then
        begin
          bInserisci:=True;
          //Prima di effetture il post, controllo che tutti i campi che fanno parte dell'INDICE siano valorizzati
          for i:=0 to TabellaTemp.FieldCount - 1 do
          begin
            VerificaValoreNull(TabellaTemp.Fields[i]);

            if (TabellaTemp.Fields[i].IsIndexField) and (TabellaTemp.Fields[i].asString='') then
            begin
              //AggiungiMessaggioLog('>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - Campo chiave ' + TabellaTemp.Fields[i].FieldName + ' non valorizzato');
              RegistraMsg.InserisciMessaggio('A','>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - Campo chiave ' + TabellaTemp.Fields[i].FieldName + ' non valorizzato','',nProgressivo);
              bInserisci:=False;
            end;
          end;
          if bInserisci then
          begin
            try
              nInseriti:=nInseriti+1;
              TabellaTemp.Post;
              //AggiungiMessaggioLog('>>>>Inserito record: ' + sDep);
            except
              on e:exception do
              begin
                nScartati:=nScartati+1;
                //AggiungiMessaggioLog('>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - ' + e.Message);
                RegistraMsg.InserisciMessaggio('A','>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - ' + e.Message,'',nProgressivo);
                TabellaTemp.CancelUpdates;
              end;
            end;
          end
          else
          begin
            nScartati:=nScartati+1;
            TabellaTemp.CancelUpdates;
          end;
        end;
        TabellaTemp.Insert;
        for i:=0 to QSelect.FieldCount - 3 do
        //Elaboro solo fino a FieldCount-3 xche non devo considerare l'ultimo campo che ho aggiunto io ed il PROGRESSIVO E LA DECORRENZA del dipendente...
        begin
          if Pos('|', TabellaTemp.Fields[n].FieldName) > 0 then
            sDep:=Copy(TabellaTemp.Fields[n].FieldName,1,Pos('|', TabellaTemp.Fields[n].FieldName)-1)
          else
            sDep:=TabellaTemp.Fields[n].FieldName;
          while QSelect.Fields[i].FieldName <> sDep do
          begin
            n:=n+1;
            if Pos('|', TabellaTemp.Fields[n].FieldName) > 0 then
              sDep:=Copy(TabellaTemp.Fields[n].FieldName,1,Pos('|', TabellaTemp.Fields[n].FieldName)-1)
            else
              sDep:=TabellaTemp.Fields[n].FieldName;
          end;
          //Prima di inserire un campo, verifico il VALORE_NULL
          TabellaTemp.FieldByName(TabellaTemp.Fields[n].FieldName).asString:=FormattaValoreCampo(QSelect.Fields[i].FieldName, QSelect.Fields[i].Size, QSelect.Fields[i].AsString);
          //Il codice che segue controlla se il dato è valorizzato
          //e se per il campo è stato indicato il valore sPc_SommaRicorrenzeX nella PARAMETRIZZAZIONE ESTRAZIONE
          //memorizza in una stringa la decorrenza per tale valore
          //Es. FERIE MATURATE
          //Nel caso in cui la stampa fatta con il generatore tira fuori 10 righe per ogni dipendente
          //le prime 5 riferite al primo periodo storico e se altre 5 al secondo periodo storico,
          //puo accadere che la competenza di ferie non sia indicata nel rpimo periodo ma nel secondo
          //Io memorizzo la data di decorrenza del primo periodo storico in cui trovo una competenza diversa
          //da ZERO in modo da poter sommare eventuali competenze di altre causali che si trovano nella
          //stessa colonna e riferite allo stesso periodo storico.
          //Uso una stringa con i valori separati dal PIPE poiche potrei voler gestire più di un campo con questa modalità:
          //se oltre alle ferie maturate volessi gestire anche un altro valore ho necessità di salvarmi nella stringa
          //qual è la decorrenza per il primo valore (FERIEMATUTATE=01/01/2003) e per il secondo valore in quanto potrebbero
          //essere diverse.
          if SelT931.SearchRecord('DATO', QSelect.Fields[i].FieldName, [srFromBeginning]) then
            if SelT931.FieldByName('SOMMA_RICORRENZE').asString = sPc_SommaRicorrenzeX then
              if QSelect.Fields[i].AsFloat <> 0 then
                sDecorrenzaValore:='|' + QSelect.Fields[i].FieldName + '=' + FormatDateTime('dd/mm/yyyy',QSelect.FieldByName('T430DATADECORRENZA').AsDateTime) + '|';
          n:=n+1;
        end;
      end
      else
      //Elaboro un altro record riferito al medesimo dipendente...
      begin
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       //                                       Verifico se è cambiata la struttura                                    //
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       if SelT931.SearchRecord('TIPO', sPc_StrutturaImpiego, [srFromBeginning]) then
       begin
         //Se la struttura di impiego è valorizzata
         if QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString <> '' then
         begin
           //Verifico se è diversa da quella memorizzata in precedenza
           if SelT931.FieldByName('VARIAZIONI_MAX').asString='' then
             nVariazioniMax:=1
           else
             nVariazioniMax:=SelT931.FieldByName('VARIAZIONI_MAX').asInteger;
           for n:=1 to nVariazioniMax do
           begin
             //Se esiste un campo vuoto per il dato corrente e se il dato è cambiato
             if TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString = '' then
             begin
               //(n=1) significa che il primo campo che indica la struttura è vuoto
               // oppure
               //l'ultimo campo valorizzato con la struttura ha un valore diverso da quella corrente
               if (n=1) or (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n-1)).asString <> QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString) then
               begin
                 TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString:=FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
                 nStruttura:=n;
               end;
               break;
             end;
           end;
         end;
       end;
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       //                                       Verifico se è cambiato il dipartimento                                 //
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       if SelT931.SearchRecord('TIPO', sPc_CodDipartimentoImpiego, [srFromBeginning]) then
       begin
         //Se il dipartimento di impiego è valorizzato
         if QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString <> '' then
         begin
           //Verifico se è diversa da quella memorizzata in precedenza
           if SelT931.FieldByName('VARIAZIONI_MAX').asString='' then
             nVariazioniMax:=1
           else
             nVariazioniMax:=SelT931.FieldByName('VARIAZIONI_MAX').asInteger;
           for n:=1 to nVariazioniMax do
           begin
             //Se esiste un campo vuoto per il dato corrente e se il dato è cambiato
             if TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString = '' then
             begin
               //(n=1) significa che il primo campo che indica la struttura è vuoto
               // oppure
               //l'ultimo campo valorizzato con la struttura ha un valore diverso da quella corrente
               if (n=1) or (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n-1)).asString <> QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString) then
               begin
                 TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString:=FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
                 //Cerco la descrizione del dipartimento di impiego
                 if SelT931.SearchRecord('TIPO', sPc_DescDipartimentoImpiego, [srFromBeginning]) then
                   TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString:=FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
               end;
               break;
             end;
           end;
         end;
       end;
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       //                                       Verifico se è cambiata l'unità operativa                               //
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       if SelT931.SearchRecord('TIPO', sPc_UnitaOperativaImpiego, [srFromBeginning]) then
       begin
         //Se l'unità operativa è valorizzata
         if QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString <> '' then
         begin
           //Verifico se è diversa da quella memorizzata in precedenza
           if SelT931.FieldByName('VARIAZIONI_MAX').asString='' then
             nVariazioniMax:=1
           else
             nVariazioniMax:=SelT931.FieldByName('VARIAZIONI_MAX').asInteger;
           for n:=1 to nVariazioniMax do
           begin
             //Se esiste un campo vuoto per il dato corrente e se il dato è cambiato
             if TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n) + inttostr(nStruttura)).asString = '' then
             begin
               //(n=1) significa che il primo campo che indica la struttura è vuoto
               // oppure
               //l'ultimo campo valorizzato con la struttura ha un valore diverso da quella corrente
               if (n=1) or (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n-1) + inttostr(nStruttura)).asString <> QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString) then
               begin
                 TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n) + inttostr(nStruttura)).asString:=FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
                 //Cerco il totale delle ore lavorate
                 if SelT931.SearchRecord('TIPO', sPc_TotaleOreUOImpiego, [srFromBeginning]) then
                   TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n) + inttostr(nStruttura)).asString:=FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
               end;
               break;
             end;
           end;
         end;
       end;
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       //                              Valorizzo tutti i campi con TIPO non specificato                                //
       //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       for i:=0 to QSelect.FieldCount - 3 do
       begin
         if SelT931.SearchRecord('DATO', QSelect.Fields[i].FieldName, [srFromBeginning]) then
           if SelT931.FieldByName('TIPO').asString = '' then
           begin
             if QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString <> '' then
             begin
               //Verifico se è diversa da quella memorizzata in precedenza
               if SelT931.FieldByName('VARIAZIONI_MAX').asString='' then
                 nVariazioniMax:=1
               else
                 nVariazioniMax:=SelT931.FieldByName('VARIAZIONI_MAX').asInteger;
               if nVariazioniMax = 1 then
               begin
                 //Se il campo è numerico ed è indicato il formato allora devo sommarlo a quello già presente...
                 if (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).DataType = ftInteger) or
                    (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).DataType = ftFloat) then
                 begin
                   //Verifico il valore del campo 'SOMMA_RICORRENZE'
                   if SelT931.FieldByName('SOMMA_RICORRENZE').asString = sPc_SommaRicorrenzeS then
                     //Sommo il valore a quello esistente
                     TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat:=TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat + QSelect.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat
                   else if SelT931.FieldByName('SOMMA_RICORRENZE').asString = sPc_SommaRicorrenzeX then
                   begin
                     //Nell'esempio riportato sopra relativo alle ferie MATURATEm, può accadere che si debbano
                     //sommare competenze di ferie diverse riferite allo stesso periodo storico
                     dDecorrenzaValore:=0;
                     //costruisco in una stringa temporanea il valore da ricercare nella stringa contenente tutte le decorrenze
                     sDep:='|' + SelT931.FieldByName('DATO').asString + '='; //+ FormatDateTime('dd/mm/yyyy',QSelect.FieldByName('T430DATADECORRENZA').AsDateTime) + '|';
                     //cerco nella stringa contenente tutte le decorrenze per lo stesso dipendente se compare già il campo che sto esaminando (FERIE_MATURATE)
                     if Pos(sDep, sDecorrenzaValore) = 0 then
                     begin
                       //Se non compare e se il dato (FERI MATURATE) ha un valore significativo e cioè diverso da ZERO
                       if QSelect.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat <> 0 then
                         //allora aggiungo alla stringa delle decorrenze anche quella corrente
                         sDecorrenzaValore:=sDecorrenzaValore + sDep + FormatDateTime('dd/mm/yyyy',QSelect.FieldByName('T430DATADECORRENZA').AsDateTime) + '|';
                     end;
                     //Leggo la decorrenza per il campo in oggetto dalla stringa contenente tutte le decorrenze
                     if Pos(sDep, sDecorrenzaValore) <> 0 then
                     begin
                       sDep:=Copy(sDecorrenzaValore, Pos(sDep, sDecorrenzaValore)+1,length(sDecorrenzaValore));
                       sDep:=Copy(sDep, 1, Pos('|',sDep)-1);
                       sDep:=Copy(sDep, Pos('=',sDep)+1,length(sDep));
                       //trasformo in DATA il valore che ho letto
                       dDecorrenzaValore:=encodedate(strtoint(copy(sdep,7,4)),strtoint(copy(sdep,4,2)),strtoint(copy(sdep,1,2)));
                     end;
                     //Se ho un valore significativo per la decorrenza e se la decorrenza corrente è uguale a
                     //quella di riferimento per il dato (FERIE MATURATE) allora sommo il valore corrente ad eventuali
                     //altri già conteggiati
                     if dDecorrenzaValore <> 0 then
                       //Sommo solo se il valore presente è 0 (ZERO)
                       if QSelect.FieldByName('T430DATADECORRENZA').AsDateTime = dDecorrenzaValore then
                         TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat:=TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat + QSelect.FieldByName(SelT931.FieldByName('DATO').asString).AsFloat;
                   end;
                 end
                 else if TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).DataType = ftString then
                 begin
                   //l'ultimo campo valorizzato con la struttura ha un valore diverso da quella corrente
                   if TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).AsString = '' then
                     TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString).asString:= FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
                 end;
               end
               else
               begin
                 for n:=1 to nVariazioniMax do
                 begin
                   //NON POSSO AVERE CAMPI NUMERICI XCHE NON E' PREVISTO NELLA PARAMETRIZZAZIONE
                   //(n=1) significa che il primo campo che indica la struttura è vuoto
                   // oppure
                   //l'ultimo campo valorizzato con la struttura ha un valore diverso da quella corrente
                   if (n=1) or (TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n-1)).asString <> QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString) then
                     TabellaTemp.FieldByName(SelT931.FieldByName('DATO').asString + '|' + inttostr(n)).asString:= FormattaValoreCampo(SelT931.FieldByName('DATO').asString, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).Size, QSelect.FieldByName(SelT931.FieldByName('DATO').asString).asString);
                   break;
                 end;
               end;
             end;
         end;
       end;
      end;
      nProgressivo:=QSelect.FieldByName('PROGRESSIVO').asInteger;
      QSelect.Next;
      ProgressBar1.StepBy(1);
    end;
    if TabellaTemp.State = dsInsert then
    begin
      bInserisci:=True;
      //Prima di effetture il post, controllo che tutti i campi che fanno parte dell'INDICE siano valorizzati
      for i:=0 to TabellaTemp.FieldCount - 1 do
      begin

        VerificaValoreNull(TabellaTemp.Fields[i]);

        if (TabellaTemp.Fields[i].IsIndexField) and (TabellaTemp.Fields[i].asString='') then
        begin
          //AggiungiMessaggioLog('>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - Campo chiave ' + TabellaTemp.Fields[i].FieldName + ' non valorizzato');
          RegistraMsg.InserisciMessaggio('A','>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - Campo chiave ' + TabellaTemp.Fields[i].FieldName + ' non valorizzato','',nProgressivo);
          bInserisci:=False;
        end;
      end;
      if bInserisci then
      begin
        try
          TabellaTemp.Post;
          nInseriti:=nInseriti+1;
          //AggiungiMessaggioLog('>>>>Inserito record: ' + sDep);
        except
          on e:exception do
          begin
            nScartati:=nScartati+1;
            //AggiungiMessaggioLog('>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - ' + e.Message);
            RegistraMsg.InserisciMessaggio('A','>>>>Record non inserito per il progressivo ' + inttostr(nProgressivo) + ' - ' + e.Message,'',nProgressivo);
            TabellaTemp.CancelUpdates;
          end;
        end;
      end
      else
      begin
        nScartati:=nScartati+1;
        TabellaTemp.CancelUpdates;
      end;
//      sDep:='';
    end;
  end;
  //sPv_LogStatistiche.Add('Tabella temporanea - records elaborati: ' + inttostr(nElaborati));
  //sPv_LogStatistiche.Add('Tabella temporanea - records inseriti: ' + inttostr(nInseriti));
  //sPv_LogStatistiche.Add('Tabella temporanea - records scartati: ' + inttostr(nScartati));
  RegistraMsg.InserisciMessaggio('I','Tabella temporanea - records elaborati: ' + inttostr(nElaborati));
  RegistraMsg.InserisciMessaggio('I','Tabella temporanea - records inseriti: ' + inttostr(nInseriti));
  RegistraMsg.InserisciMessaggio('I','Tabella temporanea - records scartati: ' + inttostr(nScartati));
  //AggiungiMessaggioLog('FINE POPOLAMENTO TABELLA TEMPORANEA');
  RegistraMsg.InserisciMessaggio('I','FINE POPOLAMENTO TABELLA TEMPORANEA');
end;

Procedure TA114FEstrazioniStampe.VerificaValoreNull(xCampo:TField);
var
  sCampo:string;
begin
  with A114FEstrazioniStampeDtm do
  begin

    //Verifico che il campo STRUTTURA IMPIEGO, se non valorizzato, contenga il valore indicato in valore null
    if SelT931.SearchRecord('TIPO', sPc_StrutturaImpiego, [srFromBeginning]) then
    begin
      sCampo:='';
      if Pos('|', xCampo.FieldName) > 0 then
      begin
        sCampo:=Copy(xCampo.FieldName,1,Pos('|', xCampo.FieldName) - 1);
        if (SelT931.FieldByName('DATO').asString = sCampo) and (xCampo.AsString='') then
          xCampo.AsString:=FormattaValoreCampo(sCampo, xCampo.Size, xCampo.AsString);
      end;
    end;

    //Verifico che il campo DIPARTIMENTO IMPIEGO, se non valorizzato, contenga il valore indicato in valore null
    if SelT931.SearchRecord('TIPO', sPc_CodDipartimentoImpiego, [srFromBeginning]) then
    begin
      sCampo:='';
      if Pos('|', xCampo.FieldName) > 0 then
      begin
        sCampo:=Copy(xCampo.FieldName,1,Pos('|', xCampo.FieldName) - 1);
        if (SelT931.FieldByName('DATO').asString = sCampo) and (xCampo.AsString='') then
          xCampo.AsString:=FormattaValoreCampo(sCampo, xCampo.Size, xCampo.AsString);
      end;
    end;

    //Verifico che il campo DESC.DIPART.IMPIEGO, se non valorizzato, contenga il valore indicato in valore null
    if SelT931.SearchRecord('TIPO', sPc_DescDipartimentoImpiego, [srFromBeginning]) then
    begin
      sCampo:='';
      if Pos('|', xCampo.FieldName) > 0 then
      begin
        sCampo:=Copy(xCampo.FieldName,1,Pos('|', xCampo.FieldName) - 1);
        if (SelT931.FieldByName('DATO').asString = sCampo) and (xCampo.AsString='') then
          xCampo.AsString:=FormattaValoreCampo(sCampo, xCampo.Size, xCampo.AsString);
      end;
    end;

    //Verifico che il campo UNITA' OPERATIVA, se non valorizzato, contenga il valore indicato in valore null
    if SelT931.SearchRecord('TIPO', sPc_UnitaOperativaImpiego, [srFromBeginning]) then
    begin
      sCampo:='';
      if Pos('|', xCampo.FieldName) > 0 then
      begin
        sCampo:=Copy(xCampo.FieldName,1,Pos('|', xCampo.FieldName) - 1);
        if (SelT931.FieldByName('DATO').asString = sCampo) and (xCampo.AsString='') then
          xCampo.AsString:=FormattaValoreCampo(sCampo, xCampo.Size, xCampo.AsString);
      end;
    end;

     //Verifico che il campo ORE LAV. UNITA' OPERATIVA, se non valorizzato, contenga il valore indicato in valore null
    if SelT931.SearchRecord('TIPO', sPc_TotaleOreUOImpiego, [srFromBeginning]) then
    begin
      sCampo:='';
      if Pos('|', xCampo.FieldName) > 0 then
      begin
        sCampo:=Copy(xCampo.FieldName,1,Pos('|', xCampo.FieldName) - 1);
        if (SelT931.FieldByName('DATO').asString = sCampo) and (xCampo.AsString='') then
          xCampo.AsString:=FormattaValoreCampo(sCampo, xCampo.Size, xCampo.AsString);
      end;
    end;

  end;
end;

function TA114FEstrazioniStampe.FormattaValoreCampo(NomeCampo:string; DimensioneCampo:integer; ValoreCampo:string):string;
var
  sValoreNull:string;
begin
  with A114FEstrazioniStampeDtm do
  begin
    result:='';
    //Prima di inserire un campo, verifico il VALORE_NULL
    sValoreNull:='';
    if SelT931.SearchRecord('DATO', NomeCampo, [srFromBeginning]) then
      sValoreNull:=SelT931.FieldByName('VALORE_NULL').AsString;
    if (sValoreNull <> '') and (ValoreCampo = '') then
      result:=StringOfChar(sValoreNull[1],DimensioneCampo)
    else if ValoreCampo <> '' then
      result:=ValoreCampo;
  end;
end;

procedure TA114FEstrazioniStampe.CreaTabellaTemporanea;
var
  sChiave, sDep:string;
  i, n, nVariazioni, nVariazioniStruttura, nVariazioniMax, nStruttura, nLunghezzaRecord, nLunghezzaCampo:integer;
  bDipartimentoImpiego, bUnitaOperativaImpiego:boolean;
begin
  nLunghezzaRecord:=0;
  //AggiungiMessaggioLog('INIZIO CREAZIONE TABELLA TEMPORANEA');
  RegistraMsg.InserisciMessaggio('I','INIZIO CREAZIONE TABELLA TEMPORANEA');
  with A114FEstrazioniStampeDtm do
  begin
    sChiave:='';
    bDipartimentoImpiego:=False;
    bUnitaOperativaImpiego:=False;
    nStruttura:=0;
    //Ricreo la tabella temporanea
    if TabellaTemp.Active then
      TabellaTemp.EmptyDataSet;
    TabellaTemp.Close;
    TabellaTemp.FieldDefs.Clear;
    if not QSelect.Eof then
    begin
      for i:=0 to QSelect.FieldCount - 1 do
      begin
        //Aggiungo i campi del Dataset alla tabella temporanea
        if (QSelect.Fields[i].FieldName <> 'PROGRESSIVO') and
           (QSelect.Fields[i].FieldName <> 'T430DATADECORRENZA') then
        begin
          //Se lo trovo nella tabella della parametrizzazione...
          if SelT931.SearchRecord('DATO', QSelect.Fields[i].FieldName, [srFromBeginning]) then
          begin
            //Leggo il numero massimo di varizioni ammesse per il campo in oggetto
            if SelT931.FieldByName('VARIAZIONI_MAX').asString='' then
              nVariazioniMax:=1
            else
              nVariazioniMax:=SelT931.FieldByName('VARIAZIONI_MAX').asInteger;
            //Inizio l'elaborazione dei dati e l'aggiunta dei campi alla tabella temporanea...
            if SelT931.FieldByName('TIPO').asString = sPc_StrutturaImpiego then
            begin
              //Memorizzo le variazioni max della struttura in una variabile che utilizzo per gestire
              //la ripetizione delle unità operative per ogni struttura
              nStruttura:=nVariazioniMax;
              nVariazioni:=1;
              //Aggiungo tante strutture di impiego quante indicate dal campo VARIAZIONI MAX
              while nVariazioni <=  nVariazioniMax do
              begin
                if QSelect.Fields[i].DataType = ftString then
                begin
                  TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni), QSelect.Fields[i].DataType, QSelect.Fields[i].Size);
                  //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                  //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                  RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                  RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                  nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[i].Size;
                end
                else
                begin
                  Screen.Cursor:=crDefault;
                  raise exception.Create('Il campo ' + QSelect.Fields[i].FieldName + ' deve essere alfanumerico oppure il formato non è indicato nella ''Parametrizzione estrazione dati''.' + #$D#$A + 'Modificare il formato del campo nella stampa ' + SelT930CODICE_STAMPA.AsString + ' dal Generatore di Stampe ed eseguirne l''anteprima oppure inserire un formato valido nella ''Parametrizzione estrazione dati''.');
                end;
               //Verifico se fa parte della chiave oppure no
               if SelT931.FieldByName('CHIAVE').asString = 'S' then
                 sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + ';';
                nVariazioni:=nVariazioni+1;
              end;
            end
            else if SelT931.FieldByName('TIPO').asString = sPc_CodDipartimentoImpiego then
            begin
              if not bDipartimentoImpiego then
              begin
                nVariazioni:=1;
                //Aggiungo tante strutture di impiego quante indicate dal campo VARIAZIONI MAX
                while nVariazioni <=  nVariazioniMax do
                begin
                  if QSelect.Fields[i].DataType = ftString then
                  begin
                    TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni), QSelect.Fields[i].DataType, QSelect.Fields[i].Size);
                    //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                    //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                    RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                    RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                    nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[i].Size;                    
                  end
                  else
                  begin
                    Screen.Cursor:=crDefault;
                    raise exception.Create('Il campo ' + QSelect.Fields[i].FieldName + ' deve essere alfanumerico.' + #$D#$A + 'Modificare il formato del campo nella stampa ' + SelT930CODICE_STAMPA.AsString + ' dal Generatore di Stampe ed eseguirne l''anteprima.');
                  end;
                  //Verifico se fa parte della chiave oppure no
                  if SelT931.FieldByName('CHIAVE').asString = 'S' then
                    sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + ';';
                  if SelT931.SearchRecord('TIPO', sPc_DescDipartimentoImpiego, [srFromBeginning]) then
                  begin
                    n:=0;
                    while QSelect.Fields[n].FieldName <> SelT931.FieldByName('DATO').asString do
                      n:=n+1;
                    if QSelect.Fields[n].DataType = ftString then
                    begin
                      TabellaTemp.FieldDefs.Add(QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni), QSelect.Fields[n].DataType, QSelect.Fields[n].Size);
                      //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni));
                      //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                      RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni));
                      RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                      nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[n].Size;
                    end
                    else
                    begin
                      Screen.Cursor:=crDefault;
                      raise exception.Create('Il campo ' + QSelect.Fields[n].FieldName + ' deve essere alfanumerico.' + #$D#$A + 'Modificare il formato del campo nella stampa ' + SelT930CODICE_STAMPA.AsString + ' dal Generatore di Stampe ed eseguirne l''anteprima.');
                    end;
                    //Verifico se fa parte della chiave oppure no
                    if SelT931.FieldByName('CHIAVE').asString = 'S' then
                      sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + ';';
                  end;
                  nVariazioni:=nVariazioni+1;
                end;
                bDipartimentoImpiego:=True;
              end;
            end
            else if SelT931.FieldByName('TIPO').asString = sPc_UnitaOperativaImpiego then
            begin
              if not bUnitaOperativaImpiego then
              begin
                nVariazioniStruttura:=1;
                while nVariazioniStruttura <=  nStruttura do
                begin
                  nVariazioni:=1;
                  //Aggiungo tante unità operative quante indicate dal campo VARIAZIONI MAX
                  while nVariazioni <=  nVariazioniMax do
                  begin
                    if QSelect.Fields[i].DataType = ftString then
                    begin
                      TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura), QSelect.Fields[i].DataType, QSelect.Fields[i].Size);
                      //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura));
                      //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                      RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura));
                      RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                      nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[i].Size;
                    end
                    else
                    begin
                      Screen.Cursor:=crDefault;
                      raise exception.Create('Il campo ' + QSelect.Fields[i].FieldName + ' deve essere alfanumerico.' + #$D#$A + 'Modificare il formato del campo nella stampa ' + SelT930CODICE_STAMPA.AsString + ' dal Generatore di Stampe ed eseguirne l''anteprima.');
                    end;
                    //Verifico se fa parte della chiave oppure no
                    if SelT931.FieldByName('CHIAVE').asString = 'S' then
                      sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura) + ';';
                    nVariazioni:=nVariazioni+1;
                  end;
                  //Aggiungo il totale ore lavorate
                  if SelT931.SearchRecord('TIPO', sPc_TotaleOreUOImpiego, [srFromBeginning]) then
                  begin
                    n:=0;
                    while QSelect.Fields[n].FieldName <> SelT931.FieldByName('DATO').asString do
                      n:=n+1;
                    nVariazioni:=1;
                    while nVariazioni <=  nVariazioniMax do
                    begin
                      if QSelect.Fields[n].DataType = ftString then
                      begin
                        TabellaTemp.FieldDefs.Add(QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura), QSelect.Fields[n].DataType, QSelect.Fields[n].Size);
                        //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura));
                        //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                        RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[n].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura));
                        RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                        nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[n].Size;
                      end
                      else
                      begin
                        Screen.Cursor:=crDefault;
                        raise exception.Create('Il campo ' + QSelect.Fields[n].FieldName + ' deve essere alfanumerico.' + #$D#$A + 'Modificare il formato del campo nella stampa ' + SelT930CODICE_STAMPA.AsString + ' dal Generatore di Stampe ed eseguirne l''anteprima.');
                      end;
                      //Verifico se fa parte della chiave oppure no
                      if SelT931.FieldByName('CHIAVE').asString = 'S' then
                        sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + inttostr(nVariazioniStruttura) + ';';
                      nVariazioni:=nVariazioni+1;
                    end;
                  end;
                  nVariazioniStruttura:=nVariazioniStruttura+1;
                end;
                bUnitaOperativaImpiego:=True;
              end;
            end
            else if SelT931.FieldByName('TIPO').asString = '' then
            begin
              nVariazioni:=1;
              while nVariazioni <=  nVariazioniMax do
              begin
                if QSelect.Fields[i].DataType = ftString then
                //Aggiungo il campo nella tabella
                begin
                  if nVariazioniMax = 1 then
                  begin
                    TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName, QSelect.Fields[i].DataType, QSelect.Fields[i].Size);
                    //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName);
                    RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName);
                    //Verifico se fa parte della chiave oppure no
                    if SelT931.FieldByName('CHIAVE').asString = 'S' then
                      sChiave:=sChiave + QSelect.Fields[i].FieldName + ';';
                  end
                  else
                  begin
                    TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni), QSelect.Fields[i].DataType, QSelect.Fields[i].Size);
                    //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                    RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni));
                    //Verifico se fa parte della chiave oppure no
                    if SelT931.FieldByName('CHIAVE').asString = 'S' then
                      sChiave:=sChiave + QSelect.Fields[i].FieldName + '|' + inttostr(nVariazioni) + ';';
                  end;
                  //AggiungiMessaggioLog('    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                  RegistraMsg.InserisciMessaggio('I','    Dimensione campo: ' + inttostr(QSelect.Fields[i].Size));
                  nLunghezzaRecord:=nLunghezzaRecord + QSelect.Fields[i].Size;
                end
                else if ((QSelect.Fields[i].DataType = ftInteger) or (QSelect.Fields[i].DataType = ftFloat)) then
                begin
                  //Controllo il formato indicato
                  if SelT931.FieldByName('FORMATO').asString = '' then
                    raise exception.create('Formato non indicato per il dato stampa ''' + QSelect.Fields[i].FieldName + ''' nella maschera ''<A113> Parametrizzazione estrazione dati dal generatore di stampe''.');
                  n:=Pos('%',SelT931.FieldByName('FORMATO').asString);
                  n:=n+1;
                  sDep:='';
                  while (Ord(SelT931.FieldByName('FORMATO').asString[n]) > 47) and (Ord(SelT931.FieldByName('FORMATO').asString[n]) < 58) do
                  begin
                    sDep:=sDep + SelT931.FieldByName('FORMATO').asString[n];
                    n:=n+1;
                  end;
                  nLunghezzaCampo:=strtoint(sDep);
                  //I campi numerici non possono avere più di una variazione, per cui lo inserisco senza numero al fondo
                  TabellaTemp.FieldDefs.Add(QSelect.Fields[i].FieldName, QSelect.Fields[i].DataType, 0);
                  //AggiungiMessaggioLog('    Aggiunto il campo: ' + QSelect.Fields[i].FieldName);
                  //AggiungiMessaggioLog('    Dimensione campo: NUMERICO');
                  RegistraMsg.InserisciMessaggio('I','    Aggiunto il campo: ' + QSelect.Fields[i].FieldName);
                  RegistraMsg.InserisciMessaggio('I','    Dimensione campo: NUMERICO');
                  nLunghezzaRecord:=nLunghezzaRecord + nLunghezzaCampo;
                  //Verifico se fa parte della chiave oppure no
                  if SelT931.FieldByName('CHIAVE').asString = 'S' then
                    sChiave:=sChiave + QSelect.Fields[i].FieldName + ';';
                end;
                nVariazioni:=nVariazioni+1;
              end;
            end;
          end
          else
            //Se il dato presente nella query sel non è stato trovato nella parametrizzazione
            //AggiungiMessaggioLog('>>>>Il campo ' + QSelect.Fields[i].FieldName + ' non risulta essere presente nella parametrizzazione');
            RegistraMsg.InserisciMessaggio('A','>>>>Il campo ' + QSelect.Fields[i].FieldName + ' non risulta essere presente nella parametrizzazione');
        end;
      end;
      TabellaTemp.IndexDefs.Clear;
      sChiave:=Copy(sChiave,1,length(sChiave)-1);
      if sChiave <> '' then
      begin
        //AggiungiMessaggioLog('Chiave tabella: ' + sChiave);
        RegistraMsg.InserisciMessaggio('I','Chiave tabella: ' + sChiave);
        //TabellaTemp.IndexDefs.Add('Primario',(sChiave),[ixUnique]);
        TabellaTemp.IndexDefs.Add('Primario',(sChiave),[]);
        TabellaTemp.IndexName:='Primario';
      end;
      TabellaTemp.CreateDataSet;
      TabellaTemp.LogChanges:=False;
    end;
  end;
  //AggiungiMessaggioLog('Lunghezza totale record: ' + inttostr(nLunghezzaRecord) + ' caratteri');
  //AggiungiMessaggioLog('FINE CREAZIONE TABELLA TEMPORANEA');
  RegistraMsg.InserisciMessaggio('I','Lunghezza totale record: ' + inttostr(nLunghezzaRecord) + ' caratteri');
  RegistraMsg.InserisciMessaggio('I','FINE CREAZIONE TABELLA TEMPORANEA');
end;

procedure TA114FEstrazioniStampe.PopolaFileAscii;
var
  F:TextFile;
  sDep, sDep2, sFormato:string;
  i,n:integer;
  nElaborati, nInseriti, nLunghezzaCampo: integer;
begin
  nElaborati:=0;
  nInseriti:=0;
  with A114FEstrazioniStampeDtm do
  begin
    //AggiungiMessaggioLog('POPOLAMENTO FILE ASCII ' + SelT930.FieldByName('NOME_FILE').AsString);
    RegistraMsg.InserisciMessaggio('I','POPOLAMENTO FILE ASCII ' + SelT930.FieldByName('NOME_FILE').AsString);
    //Apro il file ascii indicato nella parametrizzazione verificando il parametro Ricrea/Aggiungi
    AssignFile(F, SelT930.FieldByName('NOME_FILE').AsString);   { File selected in dialog box }
    if rgpFileEsistente.ItemIndex = 0 then  //Aggiungi
    begin
      Append(F);
      //AggiungiMessaggioLog('Apertura del file in modalità ''Aggiungi''');
      RegistraMsg.InserisciMessaggio('I','Apertura del file in modalità ''Aggiungi''');
    end
    else                                    //Ricrea
    begin
      Rewrite(F);
      //AggiungiMessaggioLog('Apertura del file in modalità ''Ricrea''');
      RegistraMsg.InserisciMessaggio('I','Apertura del file in modalità ''Ricrea''');
    end;
    //Scorro i record fino alla fine e valorizzo la stringa da scrivere nel file di testo
    //AggiungiMessaggioLog('Inizio elaborazione records');
    RegistraMsg.InserisciMessaggio('I','Inizio elaborazione records');
    while not TabellaTemp.Eof do
    begin
      sDep:='';
      nElaborati:=nElaborati + 1;
      for i:=0 to TabellaTemp.Fields.Count - 1 do
      begin
        sFormato:='';
        if (TabellaTemp.Fields[i].DataType = ftInteger) or (TabellaTemp.Fields[i].DataType = ftFloat) then
        begin
          if SelT931.SearchRecord('DATO', TabellaTemp.Fields[i].FieldName, [srFromBeginning]) then
            if SelT931.FieldByName('FORMATO').asString <> '' then
              sFormato:=SelT931.FieldByName('FORMATO').asString;
        end;
        if sFormato = '' then
          sDep:=sDep + Format('%-' + inttostr(TabellaTemp.Fields[i].Size) + 's', [TabellaTemp.Fields[i].AsString])
        else
        begin
          //Trovo la lunghezza del campo
          n:=Pos('%',sFormato)+1;
          sDep2:='';
          while (Ord(sFormato[n]) > 47) and (Ord(sFormato[n]) < 58) do
          begin
            sDep2:=sDep2 + SelT931.FieldByName('FORMATO').asString[n];
            n:=n+1;
          end;
          nLunghezzaCampo:=strtoint(sDep2);
          if Pos('D',UpperCase(sFormato)) > 0 then
            sFormato:=Format(sFormato,[TabellaTemp.Fields[i].AsInteger])
          else
            sFormato:=Format(sFormato,[TabellaTemp.Fields[i].AsFloat]);
          sFormato:=StringReplace(sFormato,',','',[rfReplaceAll]);
          sFormato:=Trim(StringReplace(sFormato,'.','',[rfReplaceAll]));
          sFormato:=StringOfChar('0', nLunghezzaCampo - Length(sFormato)) + sFormato;
          sDep:=sDep + sFormato;
        end;
      end;
      //Scrivo la stringa nel file
      Writeln(F,sDep);
      nInseriti:=nInseriti+1;
      //AggiungiMessaggioLog('>>>>Inserimento riga nel file: ' + sDep);
      TabellaTemp.Next;
      ProgressBar1.StepBy(1);
    end;
    //AggiungiMessaggioLog('Fine elaborazione records');
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione records');
    //sPv_LogStatistiche.Add('File ascii - records elaborati: ' + inttostr(nElaborati));
    //sPv_LogStatistiche.Add('File ascii - records inseriti: ' + inttostr(nInseriti));
    RegistraMsg.InserisciMessaggio('I','File ascii - records elaborati: ' + inttostr(nElaborati));
    RegistraMsg.InserisciMessaggio('I','File ascii - records inseriti: ' + inttostr(nInseriti));
    CloseFile(F);
    //AggiungiMessaggioLog('Chiusura del file');
    //AggiungiMessaggioLog('FINE POPOLAMENTO FILE ASCII');
    RegistraMsg.InserisciMessaggio('I','Chiusura del file');
    RegistraMsg.InserisciMessaggio('I','FINE POPOLAMENTO FILE ASCII');
  end;
end;

procedure TA114FEstrazioniStampe.CreaTabellaOracle;
var
  n,i,nLunghezzaCampo:integer;
  sDep, sChiaveTabella:string;
  UtentiOracle:TStringList;
begin
  sChiaveTabella:='';
  with A114FEstrazioniStampeDtm do
  begin
    QSelect.Close;
    QSelect.SQL.Clear;
    QSelect.SQL.Add('CREATE TABLE T920_' + SelT930.FieldByName('NOME_FILE').AsString);
    QSelect.SQL.Add('(');
    for i:=0 to TabellaTemp.Fields.Count - 1 do
    begin
      if (TabellaTemp.Fields[i].DataType = ftInteger) or (TabellaTemp.Fields[i].DataType = ftFloat) then
      begin
        nLunghezzaCampo:=0;
        //Verifico se nella parametrizzazione è indicato un formato...
        if SelT931.SearchRecord('DATO', TabellaTemp.Fields[i].FieldName, [srFromBeginning]) then
        begin
          if SelT931.FieldByName('FORMATO').asString <> '' then
          begin
            n:=Pos('%',SelT931.FieldByName('FORMATO').asString);
            n:=n+1;
            sDep:='';
            while (Ord(SelT931.FieldByName('FORMATO').asString[n]) > 47) and (Ord(SelT931.FieldByName('FORMATO').asString[n]) < 58) do
            begin
              sDep:=sDep + SelT931.FieldByName('FORMATO').asString[n];
              n:=n+1;
            end;
            nLunghezzaCampo:=strtoint(sDep);
          end;
        end;
      end
      else
        nLunghezzaCampo:=TabellaTemp.Fields[i].Size;

      if TabellaTemp.Fields[i].IsIndexField then
      begin
        QSelect.SQL.Add(StringReplace(TabellaTemp.Fields[i].FieldName,'|','',[rfReplaceAll]) + ' VARCHAR2(' + inttostr(nLunghezzaCampo) + ') not null');
        sChiaveTabella:=sChiaveTabella + TabellaTemp.Fields[i].FieldName + ',';
      end
      else
        QSelect.SQL.Add(StringReplace(TabellaTemp.Fields[i].FieldName,'|','',[rfReplaceAll]) + ' VARCHAR2(' + inttostr(nLunghezzaCampo) + ')');
      if i < TabellaTemp.Fields.Count - 1 then
        QSelect.SQL.Add(',');
    end;
    QSelect.SQL.Add(')');
    QSelect.SQL.Add('tablespace ' + Parametri.TSAusiliario);
    QSelect.SQL.Add('noparallel');
    QSelect.SQL.Add('storage');
    QSelect.SQL.Add('(');
    QSelect.SQL.Add('  initial 256K');
    QSelect.SQL.Add('  next 256K');
    QSelect.SQL.Add('  pctincrease 0');
    QSelect.SQL.Add(')');
    QSelect.Open;
    //AggiungiMessaggioLog('Creata tabella oracle con il seguente script: ' + stringreplace(QSelect.SQL.Text, #$D#$A, ' ', [rfReplaceAll]));
    RegistraMsg.InserisciMessaggio('I','Creata tabella oracle con il seguente script: ' + stringreplace(QSelect.SQL.Text, #$D#$A, ' ', [rfReplaceAll]));
    //Creo la chiave primaria se esiste
    if sChiaveTabella <> '' then
    begin
      sChiaveTabella:=Copy(sChiaveTabella,1,length(sChiaveTabella)-1);
      sChiaveTabella:=StringReplace(sChiaveTabella,'|','',[rfReplaceAll]);
      QSelect.Close;
      QSelect.SQL.Clear;
      QSelect.SQL.Add('alter table T920_' + SelT930.FieldByName('NOME_FILE').AsString);
      QSelect.SQL.Add('  add constraint T920_' + SelT930.FieldByName('NOME_FILE').AsString + '_PK primary key (' + sChiaveTabella + ')');
      QSelect.SQL.Add('  using index');
      QSelect.SQL.Add('  tablespace ' + Parametri.TSAusiliario);
      QSelect.SQL.Add('  storage');
      QSelect.SQL.Add('  (');
      QSelect.SQL.Add('    initial 256K');
      QSelect.SQL.Add('    next 256K');
      QSelect.SQL.Add('    pctincrease 0');
      QSelect.SQL.Add('  )');
      QSelect.Open;
      //AggiungiMessaggioLog('Creata chiave della tabella oracle con il seguente script: ' + stringreplace(QSelect.SQL.Text, #$D#$A, ' ', [rfReplaceAll]));
      RegistraMsg.InserisciMessaggio('I','Creata chiave della tabella oracle con il seguente script: ' + stringreplace(QSelect.SQL.Text, #$D#$A, ' ', [rfReplaceAll]));
    end;
    //Concedo il privilegio in lettura all'utente P00
    UtentiOracle:=TStringList.Create;
    UtentiOracle.CommaText:=SelT930.FieldByName('UTENTI_PRIVILEGI').AsString;
    for i:=0 to UtentiOracle.Count - 1 do
    begin
      QSelect.Close;
      QSelect.SQL.Clear;
      QSelect.SQL.Add('grant select on T920_' + SelT930.FieldByName('NOME_FILE').AsString + ' to ' + UtentiOracle[i]);
      try
        QSelect.Open;
        //AggiungiMessaggioLog('Concesso il privilegio in lettura all''utente oracle ' + UtentiOracle[i] + ' per la tabella T920_' + SelT930.FieldByName('NOME_FILE').AsString);
        RegistraMsg.InserisciMessaggio('I','Concesso il privilegio in lettura all''utente oracle ' + UtentiOracle[i] + ' per la tabella T920_' + SelT930.FieldByName('NOME_FILE').AsString);
      except
        //AggiungiMessaggioLog('NON concesso il privilegio in lettura all''utente oracle ' + UtentiOracle[i] + ' per la tabella T920_' + SelT930.FieldByName('NOME_FILE').AsString);
        RegistraMsg.InserisciMessaggio('A','NON concesso il privilegio in lettura all''utente oracle ' + UtentiOracle[i] + ' per la tabella T920_' + SelT930.FieldByName('NOME_FILE').AsString);
      end;
    end;
  end;
end;

procedure TA114FEstrazioniStampe.EliminaTabellaOracle;
begin
  with A114FEstrazioniStampeDtm do
  begin
    //Elimino la tabella oracle
    QSelect.Close;
    QSelect.SQL.Clear;
    if Parametri.VersioneOracle >= 10 then
      QSelect.SQL.Add('DROP TABLE T920_' + SelT930.FieldByName('NOME_FILE').AsString + ' PURGE')
    else
      QSelect.SQL.Add('DROP TABLE T920_' + SelT930.FieldByName('NOME_FILE').AsString);
    try
      QSelect.Open;
      //AggiungiMessaggioLog('Eliminata tabella oracle esistente');
      RegistraMsg.InserisciMessaggio('I','Eliminata tabella oracle esistente');
    except
      on e:exception do
        if Pos('ORA-00942', e.Message) > 0 then
          //AggiungiMessaggioLog('La tabella oracle non esiste');
          RegistraMsg.InserisciMessaggio('A','La tabella oracle non esiste');
        else
          raise;
    end;
  end;
end;

procedure TA114FEstrazioniStampe.PopolaTabellaOracle;
var
  i:integer;
  sDep, sNomeCampo:string;
  nElaborati, nInseriti, nScartati: integer;
  sFormato:string;
begin
  with A114FEstrazioniStampeDtm do
  begin
    sDep:='';
    nElaborati:=0;
    nInseriti:=0;
    nScartati:=0;
    sNomeCampo:='';
    QSelect.Close;
    QSelect.SQL.Clear;
    QSelect.SQL.Add('select t.*, t.rowid from T920_' + SelT930.FieldByName('NOME_FILE').AsString + ' t');
    QSelect.Open;
    while not TabellaTemp.Eof do
    begin
      nElaborati:=nElaborati+1;
      QSelect.Insert;
      for i:=0 to TabellaTemp.FieldCount-1 do
      begin
        sNomeCampo:=StringReplace(TabellaTemp.Fields[i].FieldName,'|','',[rfReplaceAll]);
        sFormato:='';
        if (TabellaTemp.Fields[i].DataType = ftInteger) or (TabellaTemp.Fields[i].DataType = ftFloat) then
        begin
          if SelT931.SearchRecord('DATO', TabellaTemp.Fields[i].FieldName, [srFromBeginning]) then
            if SelT931.FieldByName('FORMATO').asString <> '' then
              sFormato:=SelT931.FieldByName('FORMATO').asString;
        end;
        if sFormato = '' then
        begin
          Qselect.FieldByName(sNomeCampo).asString:=TabellaTemp.Fields[i].AsString;
          sDep:=sDep + sNomeCampo + '=' + TabellaTemp.Fields[i].AsString + '; ';
        end
        else
        begin
          try
            if Pos('D',UpperCase(sFormato)) > 0 then
              sFormato:=Format(sFormato,[TabellaTemp.Fields[i].AsInteger])
            else
              sFormato:=Format(sFormato,[TabellaTemp.Fields[i].AsFloat]);
            sFormato:=StringReplace(sFormato,',','',[rfReplaceAll]);
            sFormato:=Trim(StringReplace(sFormato,'.','',[rfReplaceAll]));
            sFormato:=StringOfChar('0', Qselect.FieldByName(sNomeCampo).Size - Length(sFormato)) + sFormato;
            Qselect.FieldByName(sNomeCampo).asString:=sFormato;
            sDep:=sDep + sNomeCampo + '=' + sFormato;
          except
            on e:exception do
            begin
              //AggiungiMessaggioLog('ATTENZIONE: si è verificato il seguente errore: ' + e.Message);
              RegistraMsg.InserisciMessaggio('A','ATTENZIONE: si è verificato il seguente errore: ' + e.Message);
              Qselect.FieldByName(sNomeCampo).asString:=TabellaTemp.Fields[i].AsString;
              sDep:=sDep + sNomeCampo + '=' + TabellaTemp.Fields[i].AsString + '; ';
            end;
          end;
        end;
      end;
      try
        QSelect.Post;
        nInseriti:=nInseriti+1;
        //AggiungiMessaggioLog('>>>>Inserito record: ' + sDep);
      except
      on e:exception do
        begin
          nScartati:=nScartati+1;
          if Pos('ORA-00001', e.Message) > 0 then
            //AggiungiMessaggioLog('>>>>Chiave duplicata per il record: ' + sDep)
            RegistraMsg.InserisciMessaggio('A','>>>>Chiave duplicata per il record: ' + sDep)
          else
          begin
            Screen.Cursor:=crDefault;
            raise;
          end;
        end;
      end;
      TabellaTemp.Next;
      ProgressBar1.StepBy(1);
    end;
  end;
  //sPv_LogStatistiche.Add('Tabella oracle - records elaborati: ' + inttostr(nElaborati));
  //sPv_LogStatistiche.Add('Tabella oracle - records inseriti: ' + inttostr(nInseriti));
  //sPv_LogStatistiche.Add('Tabella oracle - records inseriti: ' + inttostr(nScartati));
  RegistraMsg.InserisciMessaggio('I','Tabella oracle - records elaborati: ' + inttostr(nElaborati));
  RegistraMsg.InserisciMessaggio('I','Tabella oracle - records inseriti: ' + inttostr(nInseriti));
  RegistraMsg.InserisciMessaggio('I','Tabella oracle - records inseriti: ' + inttostr(nScartati));
end;

procedure TA114FEstrazioniStampe.dCmbParametriKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
    dCmbParametriCloseUp(Sender);
end;

procedure TA114FEstrazioniStampe.btnAnomalieClick(Sender: TObject);
begin
  {
  with A114FEstrazioniStampeDtm do
  begin
    A114FVisFile:=TA114FVisFile.Create(nil);
    try
      Screen.Cursor:=crHourGlass;
      A114FVisFile.Caption:='<A114> Log estrazione dati dal generatore di stampe';
      A114FVisFile.DbGrdLog.DataSource:=D932;
      A114FVisFile.DbGrdLog.Columns.Clear;
      A114FVisFile.DbGrdLog.Columns.Add;
      A114FVisFile.DbGrdLog.Columns[0].FieldName:=SelT932DATA.FieldName;
      A114FVisFile.DbGrdLog.Columns.Add;
      A114FVisFile.DbGrdLog.Columns[1].FieldName:=SelT932DESCRIZIONE.FieldName;
      A114FVisFile.DbGrdLog.Columns[1].Width:=A114FVisFile.Width - A114FVisFile.DbGrdLog.Columns[0].Width;
      SelT932.Close;
      SelT932.SetVariable('OPERATORE',Parametri.Operatore);
      SelT932.SetVariable('MASCHERA','A114');
      SelT932.Open;
      A114FVisFile.memoAnomalie.Visible:=False;
      A114FVisFile.DbGrdLog.Align:=alClient;
      Screen.Cursor:=crDefault;
      A114FVisFile.ShowModal;
    finally
      A114FVisFile.Free;
    end;
  end;
  }
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A114','');
end;

procedure TA114FEstrazioniStampe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // salvataggio ultima parametrizzazione usata dall'utente
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('PARAMETRI',VarToStr(dCmbParametri.KeyValue));
  if RgpFileEsistente.ItemIndex = 1 then
    C004FParamForm.PutParametro('ESISTENTE','R')
  else
    C004FParamForm.PutParametro('ESISTENTE','A');
  FreeAndNil(sPv_LogStatistiche);
  FreeAndNil(C004FParamForm);
  try SessioneOracle.Commit; except end;
end;

{
procedure TA114FEstrazioniStampe.AggiungiMessaggioLog(sMessaggio:string);
begin
  with A114FEstrazioniStampeDtm do
  begin
    If not SelT932.Active then
    begin
      SelT932.SetVariable('OPERATORE', Parametri.operatore);
      SelT932.SetVariable('MASCHERA','A114');
      SelT932.Open;
    end;
    SelT932.Insert;
    SelT932.FieldByName('OPERATORE').asString:=Parametri.Operatore;
    SelT932.FieldByName('MASCHERA').asString:='A114';
    SelT932.FieldByName('DATA').asDateTime:=Now;
    SelT932.FieldByName('DESCRIZIONE').asString:=sMessaggio;
    SelT932.Post;
  end;
end;
}

procedure TA114FEstrazioniStampe.dCmbParametriKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
