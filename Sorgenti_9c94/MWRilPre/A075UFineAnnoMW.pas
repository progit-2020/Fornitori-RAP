unit A075UFineAnnoMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DatiBloccati, R005UDataModuleMW, Oracle, DB, OracleData,Math,StrUtils,
  A000UInterfaccia, A000UCostanti, A000USessione, C180FunzioniGenerali, R450, R600,
  R100UCreditiFormativiDtM, QueryStorico;

type
  TAbbattimentiSaldiOrari = record
    Raggr:String;
    Abbattimento:Integer;
  end;

  // tipi di residui da calcolare
  TResidui = record
  const
    Calendari                            = '<CALENDARI>';
    ProfiliAssenza                       = '<PROFILI_ASSENZA>';
    ProfiliAssenzaIndividuali            = '<PROFILI_ASSENZA_IND>';
    DebitiAggiuntivi                     = '<DEBITI_AGGIUNTIVI>';
    DebitiAggiuntiviIndividuali          = '<DEBITI_AGGIUNTIVI_IND>';
    LimitiIndividualiAnnuali             = '<LIMITI_ECCEDENZE_IND_ANNO>';
    LimitiIndividualiAnnualiOver         = '<LIMITI_ECCEDENZE_IND_ANNO_OVER>';
    LimitiIndividualiMensili             = '<LIMITI_ECCEDENZE_IND_MESE>';
    LimitiIndividualiMensiliOver         = '<LIMITI_ECCEDENZE_IND_MESE_OVER>';
    LimitiIndividualiMensiliDicembre     = '<LIMITI_ECCEDENZE_12_IND_MESE>';
    LimitiIndividualiMensiliDicembreOver = '<LIMITI_ECCEDENZE_12_IND_MESE_OVER>';
    LimitiEccedenzeMensili               = '<LIMITI_ECCEDENZE>';
    LimitiEccedenzeMensiliDicembre       = '<LIMITI_ECCEDENZE_12>';
    BuoniPasto                           = '<BUONI_PASTO>';
    BuoniPastoOver                       = '<BUONI_PASTO_OVER>';
    CreditiFormativi                     = '<CREDITI_FORMATIVI>';
    SaldoOre                             = '<SALDI_ORE>';
    SaldoOreOver                         = '<SALDI_ORE_OVER>';
    Assenze                              = '<ASSENZE>';
    AssenzeOver                          = '<ASSENZE_OVER>';
  end;

  // opzioni di passaggio anno
  //   per alcune è prevista la possibilità di sovrascrittura (e sono tipizzate come TOpzione invece di Boolean)
  TOpzione = record
    Selected: Boolean;
    Overwrite: Boolean;
  end;

  TOpzioniPassaggio = record
    TriggerBefore: Boolean;
    TriggerAfter: Boolean;
    Calendari: Boolean;
    ProfiliAsse: Boolean;
    ProfiliIndividuali: Boolean;
    DebitiAggiuntivi: Boolean;
    DebitiAggiuntiviIndiv: Boolean;
    LimitiIndividualiMensili: TOpzione;
    LimitiIndividualiAnnuali: TOpzione;
    LimitiMensili: Boolean;
    LimitiItemIndex: Integer;
    ResiduiBuoniTicket: TOpzione;
    ResiduiCrediti: Boolean;
    ResiduiOre: TOpzione;
    ResiduiAsse: TOpzione;
    function ToProcedureParam: String; inline;
  end;

  TDatoRiepilogo = record
    ContaNonSovrascritti: Integer;
    procedure Clear; inline;
  end;

  // dati di riepilogo elaborazione
  TDatiRiepilogo = record
    LimitiIndividualiMensili: TDatoRiepilogo;
    LimitiIndividualiAnnuali: TDatoRiepilogo;
    ResiduiBuoniTicket: TDatoRiepilogo;
    ResiduiOre: TDatoRiepilogo;
    ResiduiAssenze: TDatoRiepilogo;
    procedure Clear; inline;
  end;

  TA075FFineAnnoMW = class(TR005FDataModuleMW)
    Q010: TOracleDataSet;
    GeneraCal: TOracleQuery;
    GeneraProf: TOracleQuery;
    scrGeneraDebiti: TOracleQuery;
    delLimitiMens: TOracleQuery;
    LimitiMensili: TOracleQuery;
    scrGeneraProfiliInd: TOracleQuery;
    scrGeneraDebitiIndiv: TOracleQuery;
    scrT263: TOracleQuery;
    Del130: TOracleQuery;
    Ins130: TOracleQuery;
    delT131: TOracleQuery;
    insT131: TOracleQuery;
    delT264: TOracleQuery;
    selT264: TOracleDataSet;
    updT264: TOracleQuery;
    scrT692: TOracleQuery;
    delT820: TOracleQuery;
    insT820: TOracleQuery;
    SelSG655: TOracleDataSet;
    scrSG256: TOracleQuery;
    Q262: TOracleDataSet;
    SelT430: TOracleDataSet;
    insT825: TOracleQuery;
    delT825: TOracleQuery;
    scrTriggerBefore: TOracleQuery;
    scrTriggerAfter: TOracleQuery;
    selProcResidui: TOracleDataSet;
    insT264: TOracleQuery;
    selT264RaggrAnno: TOracleDataSet;
    selCountT692: TOracleQuery;
    selCountT820: TOracleQuery;
    selCountT825: TOracleQuery;
    selCountT130_T131: TOracleQuery;
    selCountT264: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    R450DtM1:TR450DtM1;
    R600DtM1:TR600DtM1;
    R100FCreditiFormativiDtM:TR100FCreditiFormativiDtM;
    FDipInSer:TDipendenteInServizio;
    procedure GeneraLimitiIndividualiMensili(Prog, Tipo: Integer; const PSovrascrivi: Boolean);
    procedure GeneraLimitiIndividualiAnnuali(Prog: Integer; const PSovrascrivi: Boolean);
    function ResiduiBuoniTicketPresenti(Prog: LongInt): Boolean; inline;
    procedure GeneraResiduiBuoniTicket(Prog: Integer; const PSovrascrivi: Boolean);
    procedure GeneraResiduiCrediti(Prog: Integer);
    function ResiduiAssenzePresenti(Prog: LongInt): Boolean; inline;
    procedure GeneraResiduiAsse(Prog: Integer; const PSovrascrivi: Boolean);
    function ResiduiLimitiIndividualiMensiliPresenti(Prog: LongInt): Boolean; inline;
    function ResiduiLimitiIndividualiAnnualiPresenti(Prog: LongInt): Boolean; inline;
    function ResiduiOrePresenti(Prog: LongInt): Boolean; inline;
  public
    DataRif:TDateTime;
    NuovoAnno: String;
    SelAnagrafeRapportiUniti:String;
    LstCausali:TStringList;
    SelDatiBloccati:TDatiBloccati;
    ProgrAnagafica:Integer;
    EsisteProcResiduiBefore: Boolean;
    EsisteProcResiduiAfter: Boolean;
    Opzioni: TOpzioniPassaggio;
    RiepilogoElab: TDatiRiepilogo;
    procedure ResiduiDipendente;
    procedure GeneraCalendario;
    procedure GeneraDebiti;
    procedure GeneraDebitiIndividuali(Prog: Integer);
    procedure GeneraLimitiMensili(Tipo: Integer);
    procedure GeneraProfili;
    procedure GeneraProfiliIndividuali(Prog: Integer);
    procedure GeneraResiduiOre(Prog: Integer; NuovoAnno: String; const PSovrascrivi: Boolean); // usato da A029ULiquidazione
  end;

implementation

{$R *.dfm}

procedure TA075FFineAnnoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  R450DtM1:=TR450DtM1.Create(nil);
  R600DtM1:=TR600DtM1.Create(Self);
  R600DtM1.PassaggioDiAnno:=True;
  R100FCreditiFormativiDtM:=TR100FCreditiFormativiDtM.Create(nil);
  selDatiBloccati:=TDatiBloccati.Create(Self);
  lstCausali:=TStringList.Create;
  Q010.Open;
  FDipInSer:=TDipendenteInServizio.Create(nil);
  FDipInSer.Session:=SessioneOracle;
  // verifica se esistono le procedure personalizzate prima / dopo il calcolo dei residui
  selProcResidui.Open;
  EsisteProcResiduiBefore:=selProcResidui.SearchRecord('OBJECT_NAME','RESIDUI_TRIGGER_BEFORE',[srFromBeginning]);
  EsisteProcResiduiAfter:=selProcResidui.SearchRecord('OBJECT_NAME','RESIDUI_TRIGGER_AFTER',[srFromBeginning]);
  selProcResidui.CloseAll;
end;

procedure TA075FFineAnnoMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(R450DtM1);
  FreeAndNil(R600DtM1);
  FreeAndNil(R100FCreditiFormativiDtM);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(lstCausali);
  if FDipInSer <> nil then
    FreeAndNil(FDipInSer);
  inherited;
end;

procedure TA075FFineAnnoMW.ResiduiDipendente;
var
  LElencoResidui: String;
  LElencoResiduiPresenti: String;
begin
  if FDipInSer.DipendenteInServizio(ProgrAnagafica,EncodeDate(R180Anno(DataRif),1,1),EncodeDate(R180Anno(DataRif),12,31)) then
    if (FDipInSer.DipendenteInServizio(ProgrAnagafica,EncodeDate(R180Anno(DataRif),1,1),EncodeDate(R180Anno(DataRif),1,1))) or
       (SelAnagrafeRapportiUniti = 'S') then
    begin
      // imposta una stringa contenente i residui selezionati per il passaggio di anno
      LElencoResidui:=Opzioni.ToProcedureParam;
      LElencoResiduiPresenti:='';

      // procedura RESIDUI_TRIGGER_BEFORE
      if Opzioni.TriggerBefore then
      begin
        scrTriggerBefore.SetVariable('PROGRESSIVO',ProgrAnagafica);
        scrTriggerBefore.SetVariable('ANNO',NuovoAnno);
        scrTriggerBefore.SetVariable('ELENCO_RESIDUI',LElencoResidui);
        try
          scrTriggerBefore.Execute;

          // log di esecuzione della procedura
          RegistraLog.SettaProprieta('I','',NomeOwner,nil,True);
          RegistraLog.InserisciDato('PROCEDURE','','RESIDUI_TRIGGER_BEFORE');
          RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(ProgrAnagafica));
          RegistraLog.InserisciDato('ANNO','',NuovoAnno);
          RegistraLog.InserisciDato('ELENCO_RESIDUI','',LElencoResidui);
          RegistraLog.RegistraOperazione;
          SessioneOracle.Commit;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Procedura Oracle precedente all''elaborazione',E.Message]),'',ProgrAnagafica);
        end;
      end;

      // profili individuali
      if Opzioni.ProfiliIndividuali then
      begin
        // genera i residui
        GeneraProfiliIndividuali(ProgrAnagafica);
      end;

      // debiti aggiuntivi individuali
      if Opzioni.DebitiAggiuntiviIndiv then
      begin
        // genera i residui
        GeneraDebitiIndividuali(ProgrAnagafica);
      end;

      // saldo ore
      if Opzioni.ResiduiOre.Selected then
      begin
        // determina se sono già presenti dei residui
        if ResiduiOrePresenti(ProgrAnagafica) then
          LElencoResiduiPresenti:=LElencoResiduiPresenti + TResidui.SaldoOre;

        // genera i residui
        GeneraResiduiOre(ProgrAnagafica,NuovoAnno,Opzioni.ResiduiOre.Overwrite);
      end;

      // assenze
      if Opzioni.ResiduiAsse.Selected then
      begin
        // determina se sono già presenti dei residui
        if ResiduiAssenzePresenti(ProgrAnagafica) then
          LElencoResiduiPresenti:=LElencoResiduiPresenti + TResidui.Assenze;

        // genera i residui
        GeneraResiduiAsse(ProgrAnagafica,Opzioni.ResiduiAsse.Overwrite);
      end;

      // buoni pasto / ticket
      if Opzioni.ResiduiBuoniTicket.Selected then
      begin
        // determina se sono già presenti dei residui
        if ResiduiBuoniTicketPresenti(ProgrAnagafica) then
          LElencoResiduiPresenti:=LElencoResiduiPresenti + TResidui.BuoniPasto;

        // genera i residui
        GeneraResiduiBuoniTicket(ProgrAnagafica,Opzioni.ResiduiBuoniTicket.Overwrite);
      end;

      // limiti individuali mensili
      if Opzioni.LimitiIndividualiMensili.Selected then
      begin
        // determina se sono già presenti dei residui
        if ResiduiLimitiIndividualiMensiliPresenti(ProgrAnagafica) then
          LElencoResiduiPresenti:=LElencoResiduiPresenti + TResidui.LimitiIndividualiMensili;

        // genera i residui
        GeneraLimitiIndividualiMensili(ProgrAnagafica,Opzioni.LimitiItemIndex,Opzioni.LimitiIndividualiMensili.Overwrite);
      end;

      // limiti individuali annuali
      if Opzioni.LimitiIndividualiAnnuali.Selected then
      begin
        // determina se sono già presenti dei residui
        if ResiduiLimitiIndividualiAnnualiPresenti(ProgrAnagafica) then
          LElencoResiduiPresenti:=LElencoResiduiPresenti + TResidui.LimitiIndividualiAnnuali;

        // genera i residui
        GeneraLimitiIndividualiAnnuali(ProgrAnagafica,Opzioni.LimitiIndividualiAnnuali.Overwrite);
      end;

      // crediti formativi
      if Opzioni.ResiduiCrediti then
      begin
        // genera i residui
        GeneraResiduiCrediti(ProgrAnagafica);
      end;

      // procedura RESIDUI_TRIGGER_AFTER
      if Opzioni.TriggerAfter then
      begin
        scrTriggerAfter.SetVariable('PROGRESSIVO',ProgrAnagafica);
        scrTriggerAfter.SetVariable('ANNO',NuovoAnno);
        scrTriggerAfter.SetVariable('ELENCO_RESIDUI',LElencoResidui);
        scrTriggerAfter.SetVariable('ELENCO_RESIDUI_PRESENTI',LElencoResiduiPresenti);
        try
          scrTriggerAfter.Execute;

          // log di esecuzione della procedura
          RegistraLog.SettaProprieta('I','',NomeOwner,nil,True);
          RegistraLog.InserisciDato('PROCEDURE','','RESIDUI_TRIGGER_AFTER');
          RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(ProgrAnagafica));
          RegistraLog.InserisciDato('ANNO','',NuovoAnno);
          RegistraLog.InserisciDato('ELENCO_RESIDUI','',LElencoResidui);
          RegistraLog.InserisciDato('ELENCO_RESIDUI_PRESENTI','',LElencoResiduiPresenti);
          RegistraLog.RegistraOperazione;
          SessioneOracle.Commit;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Procedura Oracle successiva all''elaborazione',E.Message]),'',ProgrAnagafica);
        end;
      end;
    end;
end;

procedure TA075FFineAnnoMW.GeneraCalendario;
begin
  // log su messaggi elaborazioni
  RegistraMsg.InserisciMessaggio('I','Generazione calendari');

  Q010.First;
  while not Q010.Eof do
  begin
    GeneraCal.SetVariable('DAL',DataRif);
    GeneraCal.SetVariable('AL',EncodeDate(StrToInt(NuovoAnno),12,31));
    GeneraCal.SetVariable('COD',Q010.FieldByName('CODICE').AsString);
    try
      GeneraCal.Execute;
      RegistraLog.SettaProprieta('I','T011_CALENDARI',NomeOwner,nil,True);
      RegistraLog.InserisciDato('CODICE','',Q010.FieldByName('CODICE').AsString);
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.RegistraOperazione;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Calendari',E.Message]));
    end;
    SessioneOracle.Commit;
    Q010.Next;
  end;
end;

procedure TA075FFineAnnoMW.GeneraDebiti;
begin
  // log su messaggi elaborazioni
  RegistraMsg.InserisciMessaggio('I','Generazione debiti aggiuntivi');

  scrGeneraDebiti.SetVariable('NuovoAnno',StrToInt(NuovoAnno));
  try
    scrGeneraDebiti.Execute;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Debiti aggiuntivi',E.Message]));
  end;
end;

procedure TA075FFineAnnoMW.GeneraDebitiIndividuali(Prog:LongInt);
begin
  with scrGeneraDebitiIndiv do
  begin
    SetVariable('Prog',Prog);
    SetVariable('NuovoAnno',StrToInt(NuovoAnno));
    try
      Execute;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Debiti aggiuntivi individuali',E.Message]),'',Prog);
    end;
  end;
end;

function TA075FFineAnnoMW.ResiduiLimitiIndividualiMensiliPresenti(Prog: LongInt): Boolean;
// restituisce True se sono presenti residui dei limiti individuali mensili
// per il progressivo indicato (per il nuovo anno)
// oppure False altrimenti
begin
  selCountT820.SetVariable('PROGRESSIVO',Prog);
  selCountT820.SetVariable('ANNO',StrToInt(NuovoAnno));
  selCountT820.Execute;
  Result:=selCountT820.FieldAsInteger(0) > 0;
end;

procedure TA075FFineAnnoMW.GeneraLimitiIndividualiMensili(Prog:LongInt;Tipo:Integer; const PSovrascrivi: Boolean);
var
  LDupVal: Boolean;
begin
  // se è richiesta la sovrascrittura elimina i dati precedenti
  if PSovrascrivi then
  begin
    // elimina il record eventualmente già presente
    delT820.SetVariable('Progressivo',Prog);
    delT820.SetVariable('Anno',StrToInt(NuovoAnno));
    try
      delT820.Execute;

      // log di eliminazione
      RegistraLog.SettaProprieta('C','T820_LIMITIIND',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.InserisciDato('SOVRASCRIVI','',IfThen(PSovrascrivi,'S','N'));
      RegistraLog.RegistraOperazione;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Limiti eccedenze',E.Message]),'',Prog);
    end;

    // commit
    SessioneOracle.Commit;
  end;

  // inserimento dei nuovi record su ogni mese
  insT820.SetVariable('Progressivo',Prog);
  insT820.SetVariable('Anno',StrToInt(NuovoAnno));
  insT820.SetVariable('Mese',Tipo);
  insT820.SetVariable('ERR_DUP_VAL','N');
  try
    insT820.Execute;

    // aggiorna contatori di riepilogo
    // (incrementa il contatore se almeno un record risulta duplicato e non sovrascritto)
    LDupVal:=VarToStr(insT820.GetVariable('ERR_DUP_VAL')) = 'S';
    if LDupVal then
    begin
      // inserimento non effettuato: aggiorna contatore di riepilogo
      inc(RiepilogoElab.LimitiIndividualiMensili.ContaNonSovrascritti);
    end
    else
    begin
      // log di inserimento
      RegistraLog.SettaProprieta('I','T820_LIMITIIND',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.InserisciDato('TIPO','',IfThen(Tipo = 0,'MESE PER MESE','DICEMBRE'));
      RegistraLog.RegistraOperazione;
    end;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Limiti eccedenze',E.Message]),'',Prog);
  end;

  // commit
  SessioneOracle.Commit;
end;

function TA075FFineAnnoMW.ResiduiLimitiIndividualiAnnualiPresenti(Prog: LongInt): Boolean;
// restituisce True se sono presenti residui dei limiti individuali annuali
// per il progressivo indicato (per il nuovo anno)
// oppure False altrimenti
begin
  selCountT825.SetVariable('PROGRESSIVO',Prog);
  selCountT825.SetVariable('ANNO',StrToInt(NuovoAnno));
  selCountT825.Execute;
  Result:=selCountT825.FieldAsInteger(0) > 0;
end;

procedure TA075FFineAnnoMW.GeneraLimitiIndividualiAnnuali(Prog:LongInt; const PSovrascrivi: Boolean);
var
  LDupVal: Boolean;
begin
  // se è richiesta la sovrascrittura elimina i dati precedenti
  if PSovrascrivi then
  begin
    // elimina il record eventualmente già presente
    delT825.SetVariable('Progressivo',Prog);
    delT825.SetVariable('Anno',StrToInt(NuovoAnno));
    try
      delT825.Execute;

      // log di eliminazione
      RegistraLog.SettaProprieta('C','T825_LIQUIDINDANNUO',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.InserisciDato('SOVRASCRIVI','',IfThen(PSovrascrivi,'S','N'));
      RegistraLog.RegistraOperazione;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Limiti eccedenze',E.Message]),'',Prog);
    end;

    // commit
    SessioneOracle.Commit;
  end;

  // inserimento del nuovo record
  insT825.SetVariable('Progressivo',Prog);
  insT825.SetVariable('Anno',StrToInt(NuovoAnno));
  insT825.SetVariable('ERR_DUP_VAL','N');
  try
    insT825.Execute;

    // aggiorna contatori di riepilogo
    LDupVal:=VarToStr(insT825.GetVariable('ERR_DUP_VAL')) = 'S';
    if LDupVal then
    begin
      // inserimento non effettuato: aggiorna contatore di riepilogo
      inc(RiepilogoElab.LimitiIndividualiAnnuali.ContaNonSovrascritti);
    end
    else
    begin
      // log di inserimento
      RegistraLog.SettaProprieta('I','T825_LIQUIDINDANNUO',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.RegistraOperazione;
    end;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Limiti eccedenze',E.Message]),'',Prog);
  end;

  // commit
  SessioneOracle.Commit;
end;

procedure TA075FFineAnnoMW.GeneraLimitiMensili(Tipo:Integer);
begin
  // log su messaggi elaborazioni
  RegistraMsg.InserisciMessaggio('I','Generazione limiti eccedenze mensili: ' + IfThen(Tipo = 0,'mese per mese','solo dicembre'));

  if TRUE (*SovrascriviDatiPrecedenti*) then
  begin
    delLimitiMens.SetVariable('ANNO',StrToInt(NuovoAnno));
    try
      delLimitiMens.Execute;

      // log di eliminazione
      RegistraLog.SettaProprieta('C','T810_LIQUIDABILE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.RegistraOperazione;
      RegistraLog.SettaProprieta('C','T811_RESIDUABILE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.RegistraOperazione;
    except
      on E:Exception do
        //A075FFineAnno.lstErrori.Add(Format('%-8s %-30s %-20s %-s',['','','Limiti eccedenze',E.Message]));
        RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Limiti eccedenze',E.Message]));
    end;
    SessioneOracle.Commit;
  end;
  LimitiMensili.SetVariable('ANNO',StrToInt(NuovoAnno));
  LimitiMensili.SetVariable('MESE',Tipo);
  try
    LimitiMensili.Execute;

    // log di inserimento
    RegistraLog.SettaProprieta('I','T810_LIQUIDABILE',NomeOwner,nil,True);
    RegistraLog.InserisciDato('ANNO','',NuovoAnno);
    RegistraLog.RegistraOperazione;
    RegistraLog.SettaProprieta('I','T811_RESIDUABILE',NomeOwner,nil,True);
    RegistraLog.InserisciDato('ANNO','',NuovoAnno);
    RegistraLog.RegistraOperazione;
  except
    on E:Exception do
      //A075FFineAnno.lstErrori.Add(Format('%-8s %-30s %-20s %-s',['','','Limiti eccedenze',E.Message]));
      RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Limiti eccedenze',E.Message]));
  end;
  SessioneOracle.Commit;
end;

procedure TA075FFineAnnoMW.GeneraProfili;
var i:Integer;
begin
  // log su messaggi elaborazioni
  RegistraMsg.InserisciMessaggio('I','Generazione profili assenza');

  GeneraProf.SetVariable('YEAR',StrToInt(NuovoAnno));
  try
    GeneraProf.Execute;
    with TStringList.Create do
    try
      CommaText:=VarToStr(GeneraProf.GetVariable('DUPLICATI'));
      for i:=0 to Count - 1 do
      begin
        if Trim(Strings[i]) <> '' then
          RegistraMsg.InserisciMessaggio('A',Format('%-20s Profilo:%-5s Raggr:%-5s già esistente',['Profili assenza',Names[i],ValueFromIndex[i]]));
      end;
    finally
      Free;
    end;
    RegistraLog.SettaProprieta('I','T262_PROFASSANN',NomeOwner,nil,True);
    RegistraLog.InserisciDato('ANNO','',NuovoAnno);
    RegistraLog.RegistraOperazione;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Profili assenza',E.Message]));
  end;
  SessioneOracle.Commit;
end;

procedure TA075FFineAnnoMW.GeneraProfiliIndividuali(Prog:LongInt);
begin
  with scrGeneraProfiliInd do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Anno',StrToInt(NuovoAnno) - 1);
    try
      Execute;
    except
      on E:Exception do
        //A075FFineAnno.lstErrori.Add(Format('%-8s %-30s %-20s %-s',[C700SelAnagrafe.FieldByName('MATRICOLA').AsString,C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + C700SelAnagrafe.FieldByName('NOME').AsString,'Profili individuali',E.Message]));
        RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Profili individuali',E.Message]),'',Prog);
    end;
  end;
end;

function TA075FFineAnnoMW.ResiduiAssenzePresenti(Prog: LongInt): Boolean;
// restituisce True se sono presenti residui assenze
// per il progressivo indicato (per il nuovo anno)
// oppure False altrimenti
begin
  selCountT264.SetVariable('PROGRESSIVO',Prog);
  selCountT264.SetVariable('ANNO',StrToInt(NuovoAnno));
  selCountT264.Execute;
  Result:=selCountT264.FieldAsInteger(0) > 0;
end;

procedure TA075FFineAnnoMW.GeneraResiduiAsse(Prog:LongInt; const PSovrascrivi: Boolean);
var Rag,RagRes,RagResPrec,ElencoRag:String;
    G:TGiustificativo;
    i:Integer;
    MaxResiduo,MaxResiduoAC,MaxResiduoAP,ResiduoAC,ResiduoAP,App,DiffResiduoAC:Real;
    CompetenzeA075:array [1..6] of Real;
    ResA075,RespRecA075:array [1..6] of String;
    FruizCompPrecCumuloT_A075:String;
    MaxRes,S:String;
    D:TDateTime;
  procedure ResettaResidui(ResiduoPrecedente:Boolean);
  var i:Integer;
      ResConcat:String;
  begin
    with delT264 do
    begin
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('ANNO',StrToInt(NuovoAnno));
      SetVariable('CODRAGGR',IfThen(ResiduoPrecedente,RagResPrec,RagRes));
      Execute;
    end;
    if Q262.FieldByName('TIPOCUMULO').AsString = 'T' then
    begin
      for i:=1 to 6 do
        ResConcat:=ResConcat + ResA075[i];
      if ResConcat = '' then
        exit;
    end;
    with insT264 do
    begin
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('ANNO',StrToInt(NuovoAnno));
      SetVariable('CODRAGGR',IfThen(ResiduoPrecedente,RagResPrec,RagRes));
      SetVariable('FRUIZCOMPPREC_CUMULO_T',FruizCompPrecCumuloT_A075);
      for i:=1 to 6 do
        SetVariable('RESIDUO' + IntToStr(i),IfThen(ResiduoPrecedente,ResPrecA075[i],ResA075[i]));
      try
        Execute;
        ElencoRag:=ElencoRag + '<' + IfThen(ResiduoPrecedente,RagResPrec,RagRes) + '>';
        RegistraLog.SettaProprieta('I','T264_RESIDASSANN',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
        RegistraLog.InserisciDato('ANNO','',NuovoAnno);
        RegistraLog.InserisciDato('CODRAGGR','',Rag);
        if ResiduoPrecedente then
          RegistraLog.InserisciDato('RAGGR_RESIDUO_PREC','',RagResPrec)
        else
          RegistraLog.InserisciDato('RAGGRUPPAMENTO_RESIDUO','',RagRes);
        RegistraLog.RegistraOperazione;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Causali assenza',E.Message]),'',Prog);
      end;
    end;
  end;
  procedure CumulaResidui(ResiduoPrecedente:Boolean);
  var i:Integer;
      r:Real;
      S1,S2:String;
  begin
    with selT264 do
    begin
      Close;
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('ANNO',StrToInt(NuovoAnno));
      SetVariable('CODRAGGR',IfThen(ResiduoPrecedente,RagResPrec,RagRes));
      Open;
      for i:=1 to 6 do
      begin
        S1:=FieldByName('RESIDUO' + IntToStr(i)).AsString;
        S2:=IfThen(ResiduoPrecedente,ResPrecA075[i],ResA075[i]);
        r:=R180StrToGiorniOre(S1,R600DtM1.UMisura) + R180StrToGiorniOre(S2,R600DtM1.UMisura);
        if ResiduoPrecedente then
          ResPrecA075[i]:=R180GiorniOreToStr(r,R600DtM1.UMisura)
        else
          ResA075[i]:=R180GiorniOreToStr(r,R600DtM1.UMisura);
      end;
    end;
    with updT264 do
    try
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('ANNO',StrToInt(NuovoAnno));
      SetVariable('CODRAGGR',IfThen(ResiduoPrecedente,RagResPrec,RagRes));
      for i:=1 to 6 do
        SetVariable('RESIDUO' + IntToStr(i),IfThen(ResiduoPrecedente,ResPrecA075[i],ResA075[i]));
      Execute;
      RegistraLog.SettaProprieta('I','T264_RESIDASSANN',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.InserisciDato('CODRAGGR','',Rag);
      if ResiduoPrecedente then
        RegistraLog.InserisciDato('RAGGR_RESIDUO_PREC','',RagResPrec)
      else
        RegistraLog.InserisciDato('RAGGRUPPAMENTO_RESIDUO','',RagRes);
      RegistraLog.RegistraOperazione;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Causali assenza',E.Message]),'',Prog);
    end;
  end;
begin
  if selDatiBloccati.DatoBloccato(Prog,EncodeDate(StrToInt(NuovoAnno),1,1),'T264') then
    exit;

  // estrae i raggruppamenti dell'anno per il progressivo indicato
  selT264RaggrAnno.Close;
  selT264RaggrAnno.SetVariable('PROGRESSIVO',Prog);
  selT264RaggrAnno.SetVariable('ANNO',StrToInt(NuovoAnno){ - 1});
  selT264RaggrAnno.Open;

  ElencoRag:='';
  with Q262 do
  begin
    Close;
    D:=EncodeDate(StrToInt(NuovoAnno) - 1,12,31);
    SetVariable('ANNO',StrToInt(NuovoAnno) - 1);
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA',EncodeDate(StrToInt(NuovoAnno) - 1,12,31));
    Open;
    Rag:='';
    while not Eof do
    begin
      if Rag <> FieldByName('CODRAGGR').AsString then
      begin
        Rag:=FieldByName('CODRAGGR').AsString;
        RagRes:=FieldByName('RAGGRUPPAMENTO_RESIDUO').AsString;
        RagResPrec:=FieldByName('RAGGR_RESIDUO_PREC').AsString;
        FruizCompPrecCumuloT_A075:='';
        if RagRes = '' then
          RagRes:=Rag;
        G.Inserimento:=False;
        G.Modo:='I';
        G.Causale:=FieldByName('CODICE').AsString;
        S:=Format('%-7s %-11s %-13s',[G.Causale,Rag,RagRes + IfThen(RagResPrec <> '','/','') + RagResPrec]);
        if lstCausali.IndexOf(S) = -1 then
          lstCausali.Add(S);
        R600DtM1.GetAssenze(Prog,D,D,Date,G);
        //Riduco il residuo eliminando le competenze dell'anno precedente se queste scadono  il 31/12
        //if FieldByName('DATARES').AsDateTime = D then
        if R600DtM1.EsisteResiduo and (R600DtM1.ptLimiteResiduo = D) then
        begin
          R600DtM1.GetResiduo:=R180GiorniOreToStr(R180StrToGiorniOre(R600DtM1.GetCompCorr,R600DtM1.UMisura) - R180StrToGiorniOre(R600DtM1.GetFruitoCorr,R600DtM1.UMisura),R600DtM1.UMisura);
          RagResPrec:='';
        end
        else if (RagResPrec = RagRes) or (R180StrToGiorniOre(R600DtM1.GetResiduoPrec,R600DtM1.UMisura) <= 0) then
          //Annullo la distinzione per il raggruppamento del residuo precedente se non ci sono le condizioni
          RagResPrec:='';
        //Calcolo limite residuabile
        MaxRes:=FieldByName('MAXRESIDUO').AsString;
        if (Trim(MaxRes) <> '.') and (Trim(MaxRes) <> '') then
          try
            MaxResiduo:=R180StrToGiorniOre(MaxRes,R600DtM1.UMisura);
            (*
            if R600DtM1.UMisura = 'G' then
            begin
              MaxRes:=StringReplace(MaxRes,' ','0',[rfReplaceAll]);
              MaxRes:=StringReplace(MaxRes,'.',{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,[rfReplaceAll]);
              MaxResiduo:=StrToFloat(MaxRes);
            end
            else
              MaxResiduo:=R180OreMinutiExt(MaxRes);
            *)
          except
            MaxResiduo:=99999999;
          end
        else
          MaxResiduo:=99999999;
        if (Trim(FieldByName('MAXRESIDUO_CORR').AsString) <> '.') and (Trim(FieldByName('MAXRESIDUO_CORR').AsString) <> '') then
          try
            MaxResiduoAC:=R180StrToGiorniOre(FieldByName('MAXRESIDUO_CORR').AsString,R600DtM1.UMisura);
          except
            MaxResiduoAC:=99999999;
          end
        else
          MaxResiduoAC:=99999999;
        if (Trim(FieldByName('MAXRESIDUO_PREC').AsString) <> '.') and (Trim(FieldByName('MAXRESIDUO_PREC').AsString) <> '') then
          try
            MaxResiduoAP:=R180StrToGiorniOre(FieldByName('MAXRESIDUO_PREC').AsString,R600DtM1.UMisura);
          except
            MaxResiduoAP:=99999999;
          end
        else
          MaxResiduoAP:=99999999;

        //Torino_ITC
        if False then //FieldByName('MAXRESIDUO_CORR_TIPO').AsString = 'C' then
        begin
          for i:=6 downto 1 do
            MaxResiduoAC:=MaxResiduoAC + R600DtM1.VisCompetenzeAC[i];
          MaxResiduoAC:=MaxResiduoAC / 2;
          if R600DtM1.UMisura = 'O' then
            MaxResiduoAC:=round(MaxResiduoAC)
          else if (MaxResiduoAC - trunc(MaxResiduoAC)) < 0.5 then
            MaxResiduoAC:=trunc(MaxResiduoAC);
          if R180StrToGiorniOre(R600DtM1.GetResiduoCorr,R600DtM1.UMisura) > MaxResiduoAC then
            DiffResiduoAC:=R180StrToGiorniOre(R600DtM1.GetResiduoCorr,R600DtM1.UMisura) - MaxResiduoAC
          else
            DiffResiduoAC:=0;
          R600DtM1.GetResiduoCorr:=R180GiorniOreToStr(R180StrToGiorniOre(R600DtM1.GetResiduoCorr,R600DtM1.UMisura) - DiffResiduoAC,R600DtM1.UMisura);
          R600DtM1.GetResiduo:=R180GiorniOreToStr(R180StrToGiorniOre(R600DtM1.GetResiduo,R600DtM1.UMisura) - DiffResiduoAC,R600DtM1.UMisura);
        end;

        //Calcolo residui a fine anno
        MaxResiduoAC:=min(MaxResiduoAC,R180StrToGiorniOre(R600DtM1.GetResiduoCorr,R600DtM1.UMisura));
        MaxResiduoAP:=min(MaxResiduoAP,R180StrToGiorniOre(R600DtM1.GetResiduoPrec,R600DtM1.UMisura));
        try
          ResiduoAP:=R180StrToGiorniOre(R600DtM1.GetResiduo,R600DtM1.UMisura);
        except
          ResiduoAP:=99999999;
        end;
        MaxResiduo:=min(MaxResiduo,ResiduoAP);
        //Alberto 28/11/2012: Aggunta gestione dei limiti su ano prec/corr
        MaxResiduo:=min(MaxResiduo,MaxResiduoAC + MaxResiduoAP);
        R600DtM1.GetResiduoCorr:=R180GiorniOreToStr(MaxResiduoAC,R600DtM1.UMisura);
        R600DtM1.GetResiduoPrec:=R180GiorniOreToStr(MaxResiduoAP,R600DtM1.UMisura);

        //Riduzione competenze in base al limite residuabile
        if MaxResiduo >= 0 then
        try
          for i:=6 downto 1 do
            if R600DtM1.Competenze[i] > MaxResiduo then
            begin
              R600DtM1.Competenze[i]:=MaxResiduo;
              MaxResiduo:=0;
            end
            else
              MaxResiduo:=MaxResiduo - R600DtM1.Competenze[i];
        except
        end;
        //Registro il residuo dell'anno precedente per gestione del raggruppamento diverso eventuale
        ResiduoAC:=R180StrToGiorniOre(R600DtM1.GetResiduoCorr,R600DtM1.UMisura);
        for i:=1 to 6 do
        begin
          CompetenzeA075[i]:=R600DtM1.Competenze[i];
          ResA075[i]:='';
          RespRecA075[i]:='';
        end;
        //Valorizzo ResA075 e ResPrecA075 per successivo utilizzo
        if Q262.FieldByName('TIPOCUMULO').AsString = 'T' then
        begin
          if R600DtM1.FruizCompPrecCumuloT > 0 then
            FruizCompPrecCumuloT_A075:=R180MinutiOre(R600DtM1.FruizCompPrecCumuloT);
          for i:=0 to Min(5,High(R600DtM1.RecupCumuloT)) do
            ResA075[i + 1]:=R180MinutiOre(R600DtM1.RecupCumuloT[i]);
        end
        else
        begin
          for i:=1 to 6 do
          begin
            if RagResPrec <> '' then
            begin
              App:=min(CompetenzeA075[i],ResiduoAC);
              CompetenzeA075[i]:=CompetenzeA075[i] - App;
              ResiduoAC:=ResiduoAC - App;
            end
            else
              App:=CompetenzeA075[i];
            ResA075[i]:=R180GiorniOreToStr(App,R600DtM1.UMisura);
          end;
          if RagResPrec <> '' then
            for i:=1 to 6 do
              ResPrecA075[i]:=R180GiorniOreToStr(CompetenzeA075[i],R600DtM1.UMisura);
        end;

        // inserimento residuo sul raggruppamento indicato se è richiesta la sovrascrittura
        if (PSovrascrivi or (not selT264RaggrAnno.SearchRecord('CODRAGGR',RagRes,[srFromBeginning]))) then
        begin
          if (RagRes <> Rag) and
             (Pos('<' + RagRes + '>',ElencoRag) > 0) and
             (VarToStr(Lookup('CODRAGGR;CUMULA_RAGGR_BASE',VarArrayOf([RagRes,'0']),'CUMULA_RAGGR_BASE')) = '0') then
            CumulaResidui(False)
          else
            ResettaResidui(False);
        end
        else
        begin
          // inserimento non effettuato: aggiorna contatore di riepilogo
          inc(RiepilogoElab.ResiduiAssenze.ContaNonSovrascritti);
        end;

        if (RagResPrec <> '') and
           (Q262.FieldByName('TIPOCUMULO').AsString <> 'T') then
        begin
          // inserimento residuo sul raggruppamento indicato per gli anni precedenti se è richiesta la sovrascrittura
          if (PSovrascrivi or (not selT264RaggrAnno.SearchRecord('CODRAGGR',RagResPrec,[srFromBeginning]))) then
          begin
            if (Pos('<' + RagResPrec + '>',ElencoRag) > 0) and
               (VarToStr(Lookup('CODRAGGR;CUMULA_RAGGR_BASE',VarArrayOf([RagResPrec,'0']),'CUMULA_RAGGR_BASE')) = '0') then
              CumulaResidui(True)
            else
              ResettaResidui(True);
          end
          else
          begin
            // inserimento non effettuato: aggiorna contatore di riepilogo
            inc(RiepilogoElab.ResiduiAssenze.ContaNonSovrascritti);
          end;
        end;

        SessioneOracle.Commit;
      end;

      Next;
    end;

//    // aggiorna contatori di riepilogo
//    if LNonSovrascritto then
//      inc(RiepilogoElab.ResiduiAssenze.ContaNonSovrascritti);

    selT264RaggrAnno.CloseAll;
  end; // end with Q262
end;

function TA075FFineAnnoMW.ResiduiBuoniTicketPresenti(Prog: LongInt): Boolean;
// restituisce True se sono presenti residui buoni pasto / ticket
// per il progressivo indicato (per il nuovo anno)
// oppure False altrimenti
begin
  selCountT692.SetVariable('PROGRESSIVO',Prog);
  selCountT692.SetVariable('ANNO',StrToInt(NuovoAnno));
  selCountT692.Execute;
  Result:=selCountT692.FieldAsInteger(0) > 0;
end;

procedure TA075FFineAnnoMW.GeneraResiduiBuoniTicket(Prog:LongInt; const PSovrascrivi: Boolean);
var
  LDupVal: Boolean;
begin
  if selDatiBloccati.DatoBloccato(Prog,Encodedate(StrToInt(NuovoAnno),1,1),'T692') then
    exit;

  // imposta le variabili per l'inserimento
  scrT692.SetVariable('PROGRESSIVO',Prog);
  scrT692.SetVariable('ANNO',StrToInt(NuovoAnno) - 1);
  scrT692.SetVariable('SOVRASCRIVI',IfThen(PSovrascrivi,'S','N'));
  scrT692.SetVariable('ERR_DUP_VAL','N');
  try
    scrT692.Execute;

    // aggiorna contatori di riepilogo
    LDupVal:=VarToStr(scrT692.GetVariable('ERR_DUP_VAL')) = 'S';
    if LDupVal then
    begin
      // inserimento non effettuato: aggiorna contatore di riepilogo
      inc(RiepilogoElab.ResiduiBuoniTicket.ContaNonSovrascritti);
    end
    else
    begin
      // log di inserimento
      RegistraLog.SettaProprieta('I','T692_RESIDUOBUONI',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
      RegistraLog.InserisciDato('ANNO','',NuovoAnno);
      RegistraLog.RegistraOperazione;
    end;
  except
    on E:Exception do
      RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Buoni pasto',E.Message]),'',Prog);
  end;

  // commit
  SessioneOracle.Commit;
end;

procedure TA075FFineAnnoMW.GeneraResiduiCrediti(Prog:LongInt);
var
  nResiduo:Real;
  sValoreCampo:string;
  a:word;
begin
  if selDatiBloccati.DatoBloccato(Prog,Encodedate(StrToInt(NuovoAnno),1,1),'SG656') then
    exit;
  //Leggo il profilo crediti assegnato al dipendente alla DataA
  SelT430.Close;
  SelT430.SetVariable('nomecampo', Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti);
  SelT430.SetVariable('Datain',EncodeDate(StrToInt(NuovoAnno) - 1,12,31));
  SelT430.SetVariable('nprogressivo',Prog);
  try
    SelT430.Open;
    sValoreCampo:=SelT430.FieldByName('campo').AsString;
  except
    sValoreCampo:='';
  end;
  if sValoreCampo <> '' then
  begin
    //leggere dalla tabella sg655 tutti i profili esistenti con CODICE=sValoreCampo
    //ed ANNO=Anno(Fine)
    a:=R180Anno(EncodeDate(StrToInt(NuovoAnno) - 1,12,31));
    SelSG655.Close;
    SelSG655.SetVariable('nanno',a);
    SelSG655.SetVariable('scodice',sValoreCampo);
    SelSG655.Open;
    SelSG655.First;
    while not SelSG655.Eof do
    begin
      with R100FCreditiFormativiDtM do
      begin
        ConteggioCrediti(Prog, EncodeDate(StrToInt(NuovoAnno) - 1,1,1), EncodeDate(StrToInt(NuovoAnno) - 1,12,31), Self.SelSG655.FieldByName('PROFILO_CREDITI').AsString);
        nResiduo:=CompResCrediti.nResAnnoCorr;
      end;
      with scrSG256 do
      begin
        SetVariable('PROGRESSIVO',Prog);
        SetVariable('ANNO',StrToInt(NuovoAnno));
        SetVariable('CREDITI',nResiduo);
        SetVariable('PROFILO',Self.SelSG655.FieldByName('PROFILO_CREDITI').AsString);
        try
          Execute;
          RegistraLog.SettaProprieta('I','SG656_RESIDUOCREDITI',NomeOwner,nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
          RegistraLog.InserisciDato('ANNO','',NuovoAnno);
          RegistraLog.InserisciDato('CREDITI','',FloatToStr(nResiduo));
          RegistraLog.InserisciDato('PROFILO','',Self.SelSG655.FieldByName('PROFILO_CREDITI').AsString);
          RegistraLog.RegistraOperazione;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Crediti formativi',E.Message]),'',Prog);
        end;
        //SessioneOracle.Commit;
      end;
      SelSG655.Next;
    end;
    SessioneOracle.Commit;
  end
  else
    RegistraMsg.InserisciMessaggio('A',Format('%-20s %-s',['Crediti formativi','Valore del campo CREDITI FORMATIVI nella gestione aziende non presente']));
end;

function TA075FFineAnnoMW.ResiduiOrePresenti(Prog: LongInt): Boolean;
// restituisce True se sono presenti residui saldi ore
// per il progressivo indicato (per il nuovo anno)
// oppure False altrimenti
begin
  selCountT130_T131.SetVariable('PROGRESSIVO',Prog);
  selCountT130_T131.SetVariable('ANNO',StrToInt(NuovoAnno));
  selCountT130_T131.Execute;
  Result:=selCountT130_T131.FieldAsInteger('COUNT_T130') + selCountT130_T131.FieldAsInteger('COUNT_T131') > 0;
end;

procedure TA075FFineAnnoMW.GeneraResiduiOre(Prog:LongInt; NuovoAnno:String; const PSovrascrivi: Boolean);
//Residui saldi ore e causali di presenza
var
  A,B,i,j,MaxRes,OreRes,BORes,BOResPrec,AbbAtt,AbbPrec,AbbTot:Integer;
  Residuo:Boolean;
  AbbattimentiSaldiOrari:array of TAbbattimentiSaldiOrari;
  LDupVal: Boolean;
  procedure AddAbbattimentiSaldiOrari(Raggr:String; Minuti:Integer);
  var i,k:Integer;
  begin
    k:=-1;
    for i:=0 to High(AbbattimentiSaldiOrari) do
      if AbbattimentiSaldiOrari[i].Raggr = Raggr then
      begin
        k:=i;
        Break;
      end;
    if k = -1 then
    begin
      SetLength(AbbattimentiSaldiOrari,Length(AbbattimentiSaldiOrari) + 1);
      k:=High(AbbattimentiSaldiOrari);
      AbbattimentiSaldiOrari[k].Raggr:=Raggr;
      AbbattimentiSaldiOrari[k].Abbattimento:=0;
    end;
    inc(AbbattimentiSaldiOrari[k].Abbattimento,Minuti);
  end;
  procedure GeneraCompetenzeIndividuali(idx,Anno:Integer);
  begin
    with scrT263 do
    begin
      SetVariable('PROGRESSIVO',Prog);
      SetVariable('DAL',EncodeDate(Anno,1,1));
      SetVariable('CODRAGGR',AbbattimentiSaldiOrari[idx].Raggr);
      SetVariable('COMPETENZA',R180MinutiOre(AbbattimentiSaldiOrari[idx].Abbattimento));
      try
        Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A',Format('%-20s Registrazione abbattimenti su raggr: %s - %-s',['Saldi ore',AbbattimentiSaldiOrari[idx].Raggr,E.Message]),'',Prog);
      end;
    end;
  end;
begin
  try
    //Calcolo dati riepilogativi
    R450DtM1.ConteggiMese('Generico',StrToInt(NuovoAnno) - 1,12,Prog);
    //Per il tipo di conteggio Gestione Residui e azzeramento periodico,
    //considero solo il saldo dell'ultimo periodo
    if (R450DtM1.r455_tipocon = 4) and (R450DtM1.MesiSaldoPrec > 0) and R450DtM1.PAAzzeramentoPeriodico then
    begin
      R450DtM1.salannoatt:=R450DtM1.salcompannoatt + R450DtM1.salliqannoatt;
      if (R450DtM1.salannoatt < 0) and (R450DtM1.AbbattimentoFissoRecupero = 'S') then  //Per MONDOVI_ASL 16
      begin
        //Aggiunta del saldo anno precedente solo se quello attuale è negativo
        inc(R450DtM1.salcompannoatt,min(R450DtM1.salcompannoprec + R450DtM1.salliqannoprec,-R450DtM1.salannoatt));
        inc(R450DtM1.salannoatt,min(R450DtM1.salcompannoprec + R450DtM1.salliqannoprec,-R450DtM1.salannoatt));
      end;
    end;
  except
  end;
  //Elaboro solo se il residuo ore non risulta bloccato
  if not selDatiBloccati.DatoBloccato(Prog,Encodedate(StrToInt(NuovoAnno),1,1),'T130') then
  begin
    // se è richiesta la sovrascrittura elimina i dati precedenti
    if PSovrascrivi then
    begin
      with Del130 do
      begin
        SetVariable('PROGRESSIVO',Prog);
        SetVariable('ANNO',StrToInt(NuovoAnno));
        Execute;
      end;
    end;

    dec(R450DtM1.salannoatt,IfThen(R450DtM1.SaldoNegativoMinimoTipo = '1',R450DtM1.SaldoNegativoMinimoEcced,0));
    dec(R450DtM1.salcompannoatt,IfThen(R450DtM1.SaldoNegativoMinimoTipo = '1',R450DtM1.SaldoNegativoMinimoEcced,0));
    //Per tipo conteggio Gestione Recuperi, EccSoloCompRes contiene il saldo compensabile
    if (R450DtM1.r455_tipocon = 4) then
    begin
      if R450DtM1.MesiSaldoPrec > 0 then
        R450DtM1.EccSoloCompRes:=R450DtM1.salcompannoatt
      else
        R450DtM1.EccSoloCompRes:=R450DtM1.salcompannoatt + R450DtM1.salcompannoprec;
      if (R450DtM1.EccSoloCompRes < 0) and (not R450DtM1.ResidCompNegativo) then
        R450DtM1.EccSoloCompRes:=0;
    end;
    { modifiche 20/03/2009 per separare i limiti residuabili
    if StringReplace(StringReplace(Trim(R450DtM1.PALimite),'.','',[]),':','',[]) <> '' then
    begin
      if not R450DtM1.PALimiteSaldoAtt then
        dec(R450DtM1.salannoatt,Max(0,R450DtM1.salannoatt - R180OreMinutiExt(R450DtM1.PALimite)))
      else
        dec(R450DtM1.salannoatt,Max(0,R450DtM1.salliqannoatt + R450DtM1.salcompannoatt - R180OreMinutiExt(R450DtM1.PALimite)));
    end;
    }
    BORes:=R450DtM1.BancaOreResidua;
    BOResPrec:=R450DtM1.BancaOreResiduaPrec;
    AbbAtt:=0;
    AbbPrec:=0;
    AbbTot:=0;
    if (R450DtM1.r455_tipocon = 4) and (R450DtM1.BancaOreEsclusaSaldi <> 'S') then
    begin
      A:=R450DtM1.salliqannoatt + R450DtM1.salcompannoatt;
      if A > 0 then
        A:=A + min(0,R450DtM1.salliqannoprec + R450DtM1.salcompannoprec);
      AbbAtt:=Max(0,A - R450DtM1.PALimitesaldoAtt);
      A:=R450DtM1.salliqannoatt + R450DtM1.salcompannoatt - AbbAtt;

      B:=R450DtM1.salliqannoprec + R450DtM1.salcompannoprec;
      if B > 0 then
        B:=B + min(0,R450DtM1.salliqannoatt + R450DtM1.salcompannoatt);
      AbbPrec:=Max(0,B - R450DtM1.PALimitesaldoPrec);
      B:=R450DtM1.salliqannoprec + R450DtM1.salcompannoprec - AbbPrec;
      (*
      AbbAtt:=Max(0,R450DtM1.salliqannoatt + R450DtM1.salcompannoatt - R450DtM1.PALimitesaldoAtt);
      A:=min(R450DtM1.PALimitesaldoAtt,R450DtM1.salliqannoatt + R450DtM1.salcompannoatt);
      AbbPrec:=Max(0,R450DtM1.salliqannoprec + R450DtM1.salcompannoprec - R450DtM1.PALimitesaldoPrec);
      B:=min(R450DtM1.PALimitesaldoPrec,R450DtM1.salliqannoprec + R450DtM1.salcompannoprec);
      *)
      AbbTot:=Max(0,min(A + B,R450DtM1.salannoatt) - R450DtM1.PALimite);
      R450DtM1.salannoatt:=min(R450DtM1.PALimite,min(A + B,R450DtM1.salannoatt));
      //Alberto 21/10/2009: abbatto la banca ore se ci sono i limiti
      BOResPrec:=min(R450DtM1.PALimitesaldoPrec,R450DtM1.BancaOreResiduaPrec);
      BORes:=min(R450DtM1.PALimitesaldoAtt,R450DtM1.BancaOreResidua);
      A:=max(0,BOResPrec + BORes - min(R450DtM1.PALimite,BOResPrec + BORes));
      B:=max(0,min(A,BOResPrec));
      dec(BOResPrec,B);
      dec(A,B);
      dec(BORes,max(0,min(A,BORes)));
    end;
    { modifiche.fine }
    if (R450DtM1.EccSoloCompRes > R450DtM1.salannoatt) and (R450DtM1.salannoatt > 0) then
      R450DtM1.EccSoloCompRes:=R450DtM1.salannoatt;
    if R450DtM1.salannoatt <= 0 then
      if (not R450DtM1.ResidCompNegativo) or (R450DtM1.EccSoloCompRes > 0) then
        R450DtM1.EccSoloCompRes:=0;

    Ins130.SetVariable('PROGRESSIVO',Prog);
    Ins130.SetVariable('ANNO',StrToInt(NuovoAnno));
    if R450DtM1.BancaOreResidAnnoPrec = 'S' then
      Ins130.SetVariable('BANCA_ORE',R180MinutiOre(BORes + BOResPrec))
    else
    begin
      Ins130.SetVariable('BANCA_ORE',R180MinutiOre(BORes));
      //Alberto 22/06/2006: La banca ore persa deve abbattere i saldi!
      if R450DtM1.BancaOreEsclusaSaldi <> 'S' then
      begin
        inc(AbbPrec,Max(0,BOResPrec));
        dec(R450DtM1.salannoatt,Max(0,BOResPrec));
        if R450DtM1.EccSoloCompRes > 0 then
          dec(R450DtM1.EccSoloCompRes,Min(R450DtM1.EccSoloCompRes,Max(0,BOResPrec)));
      end;
    end;
    Ins130.SetVariable('SALDOORELAV',R180MinutiOre(R450DtM1.salannoatt));
    Ins130.SetVariable('RIPOSICOMP',R180MinutiOre(R450DtM1.salripcom));
    case R450DtM1.PATipoResiduo of
      0:Ins130.SetVariable('ORECOMPENSABILI',R180MinutiOre(R450DtM1.EccSoloCompRes));
      1:Ins130.SetVariable('ORECOMPENSABILI',R180MinutiOre(0));
      2:if R450DtM1.salannoatt > 0 then
          Ins130.SetVariable('ORECOMPENSABILI',R180MinutiOre(R450DtM1.salannoatt))
        else
          Ins130.SetVariable('ORECOMPENSABILI',R180MinutiOre(0));
    end;
    Ins130.SetVariable('ERR_DUP_VAL','N');

    // effettua inserimento dati
    try
      Ins130.Execute;

      LDupVal:=VarToStr(Ins130.GetVariable('ERR_DUP_VAL')) = 'S';
      if LDupVal then
      begin
        // inserimento non effettuato: aggiorna contatore di riepilogo
        inc(RiepilogoElab.ResiduiOre.ContaNonSovrascritti);
      end
      else
      begin
        // log inserimento
        RegistraLog.SettaProprieta('I','T130_RESIDANNOPREC',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
        RegistraLog.InserisciDato('ANNO','',NuovoAnno);
        RegistraLog.RegistraOperazione;
      end;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Saldi ore',E.Message]),'',Prog);
    end;
    if R450DtM1.PARaggrLimite <> '' then
      AddAbbattimentiSaldiOrari(R450DtM1.PARaggrLimite,AbbTot);
    if R450DtM1.PARaggrLimiteSaldoAtt <> '' then
      AddAbbattimentiSaldiOrari(R450DtM1.PARaggrLimiteSaldoAtt,AbbAtt);
    if R450DtM1.PARaggrLimiteSaldoPrec <> '' then
      AddAbbattimentiSaldiOrari(R450DtM1.PARaggrLimiteSaldoPrec,AbbPrec);
    for i:=0 to High(AbbattimentiSaldiOrari) do
      GeneraCompetenzeIndividuali(i,StrToInt(NuovoAnno));
  end;
  //Residui causali di presenza
  //Elaboro solo se il residuo presenze non risulta bloccato
  if not selDatiBloccati.DatoBloccato(Prog,Encodedate(StrToInt(NuovoAnno),1,1),'T131') then
  begin
    // se è richiesta la sovrascrittura elimina i dati precedenti
    if PSovrascrivi then
    begin
      with delT131 do
      begin
        SetVariable('PROGRESSIVO',Prog);
        SetVariable('ANNO',StrToInt(NuovoAnno));
        try
          Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Causali presenza',E.Message]),'',Prog);
        end;
      end;
    end;

    for i:=0 to High(R450DtM1.RiepPres) do
    begin
      MaxRes:=R180OreMinutiExt(VarToStr(R450DtM1.selT275.Lookup('CODICE',R450Dtm1.RiepPres[i].Causale,'RESIDUABILE')));
      if MaxRes > 0 then
        with insT131 do
        begin
          Residuo:=False;
          ClearVariables;
          SetVariable('PROGRESSIVO',Prog);
          SetVariable('ANNO',StrToInt(NuovoAnno));
          SetVariable('CAUSALE',R450DtM1.RiepPres[i].Causale);
          for j:=6 downto 1 do
          begin
            OreRes:=min(MaxRes,R450DtM1.RiepPres[i].Residuo[j]);
            dec(MaxRes,OreRes);
            if OreRes <> 0 then
              Residuo:=True;
            SetVariable('ORE_FASCIA' + IntToStr(j),R180MinutiOre(OreRes));
          end;
          if Residuo then
          try
            Execute;
          except
            on E:Exception do
              RegistraMsg.InserisciMessaggio('A',Format('%-8s %-30s %-20s %-s',[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,'Causali presenza',E.Message]),'',Prog);
          end;
        end;
    end;
  end;
  SessioneOracle.Commit;
end;

{ TOpzioniPassaggio }

function TOpzioniPassaggio.ToProcedureParam: String;
begin
  Result:=
    // calendari
    IfThen(Calendari,
      TResidui.Calendari
    ) +
    // profili assenza
    IfThen(ProfiliAsse,
      TResidui.ProfiliAssenza
    ) +
    IfThen(ProfiliIndividuali,
      TResidui.ProfiliAssenzaIndividuali
    ) +
    // debiti aggiuntivi
    IfThen(DebitiAggiuntivi,
      TResidui.DebitiAggiuntivi
    ) +
    IfThen(DebitiAggiuntiviIndiv,
      TResidui.DebitiAggiuntiviIndividuali
    ) +
    // limiti eccedenze
    //   individuali annuali
    IfThen(LimitiIndividualiAnnuali.Selected,
      IfThen(LimitiIndividualiAnnuali.Overwrite,
        TResidui.LimitiIndividualiAnnualiOver,
        TResidui.LimitiIndividualiAnnuali
      )
    ) +
    //   individuali mensili
    IfThen(LimitiIndividualiMensili.Selected,
      IfThen(LimitiItemIndex = 0,
        // mese per mese
        IfThen(LimitiIndividualiMensili.Overwrite,
          TResidui.LimitiIndividualiMensiliOver,
          TResidui.LimitiIndividualiMensili
        ),
        // solo dicembre
        IfThen(LimitiIndividualiMensili.Overwrite,
          TResidui.LimitiIndividualiMensiliDicembreOver,
          TResidui.LimitiIndividualiMensiliDicembre
        )
      )
    ) +
    //    eccedenze mensili
    IfThen(LimitiMensili,
      IfThen(LimitiItemIndex = 0,
        TResidui.LimitiEccedenzeMensili,
        TResidui.LimitiEccedenzeMensiliDicembre
      )
    ) +
    // residui
    //   buoni pasto / ticket
    IfThen(ResiduiBuoniTicket.Selected,
      IfThen(ResiduiBuoniTicket.Overwrite,
        TResidui.BuoniPastoOver,
        TResidui.BuoniPasto
      )
    ) +
    //    crediti formativi
    IfThen(ResiduiCrediti,TResidui.CreditiFormativi) +
    //    saldo ore
    IfThen(ResiduiOre.Selected,
      IfThen(ResiduiOre.Overwrite,
        TResidui.SaldoOreOver,
        TResidui.SaldoOre
      )
    ) +
    //    assenze
    IfThen(ResiduiAsse.Selected,
      IfThen(ResiduiAsse.Overwrite,
        TResidui.AssenzeOver,
        TResidui.Assenze
      )
    );
end;

{ TDatoRiepilogo }

procedure TDatoRiepilogo.Clear;
begin
  ContaNonSovrascritti:=0;
end;

{ TDatiRiepilogo }

procedure TDatiRiepilogo.Clear;
begin
  LimitiIndividualiMensili.Clear;
  LimitiIndividualiAnnuali.Clear;
  ResiduiBuoniTicket.Clear;
  ResiduiOre.Clear;
  ResiduiAssenze.Clear;
end;

end.
