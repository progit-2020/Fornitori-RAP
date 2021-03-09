unit W024URichiestaStraordinariDM;

interface

uses
  SysUtils, StrUtils, Classes, Math, DB, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, C018UIterAutDM, C180FunzioniGenerali,
  DatiBloccati, R400UCartellinoDtM;

type
  TW024FRichiestaStraordinariDM = class(TDataModule)
    selT070: TOracleDataSet;
    selT820: TOracleDataSet;
    selT820PROGRESSIVO: TIntegerField;
    selT820ANNO: TIntegerField;
    selT820MESE: TIntegerField;
    selT820DAL: TIntegerField;
    selT820AL: TIntegerField;
    selT820CAUSALE: TStringField;
    selT820LIQUIDABILE: TStringField;
    selT820ORE_TEORICHE: TStringField;
    selT820ORE: TStringField;
    selT065: TOracleDataSet;
    selT065DATA: TDateTimeField;
    selT065TIPO: TStringField;
    selT065Desc_Tipo: TStringField;
    selT065ORE_ECCED_CALC: TStringField;
    selT065ORE_ECCEDENTI: TStringField;
    selT065ORE_DACOMPENSARE: TStringField;
    selT065ORE_DALIQUIDARE: TStringField;
    selT065MESSAGGI: TStringField;
    selT065CF_DATA: TStringField;
    selT065CF_ORE_ECCED_VALID: TStringField;
    selT065CF_ORE_COMP_VALID: TStringField;
    selT065CF_ORE_LIQ_VALID: TStringField;
    selT065CF_ORE_ECCEDENTI: TStringField;
    selT065CF_ORE_DACOMPENSARE: TStringField;
    selT065CF_ORE_DALIQUIDARE: TStringField;
    selT065CF_ORE_ECCED_AUTORIZ: TStringField;
    selT065CF_ORE_COMP_AUTORIZ: TStringField;
    selT065CF_ORE_LIQ_AUTORIZ: TStringField;
    selT065CF_ORE_COMPENSABILI_ANNO: TStringField;
    selT065CF_ORE_COMPENSATE_ANNO: TStringField;
    selT065CF_RES_ORE_COMP_ANNO: TStringField;
    selT065CF_ORE_LIQUIDABILI_ANNO: TStringField;
    selT065CF_ORE_LIQUIDATE_ANNO: TStringField;
    selT065CF_RES_ORE_LIQ_ANNO: TStringField;
    selT065CF_RIEP_ORE_COMP: TStringField;
    selT065CF_RIEP_ORE_LIQ: TStringField;
    selT025: TOracleDataSet;
    selT825: TOracleDataSet;
    selLimitiMensili: TOracleDataSet;
    selT065ID: TFloatField;
    selT065ID_REVOCA: TFloatField;
    selT065ID_REVOCATO: TFloatField;
    selT065PROGRESSIVO: TIntegerField;
    selT065NOMINATIVO: TStringField;
    selT065MATRICOLA: TStringField;
    selT065SESSO: TStringField;
    selT065COD_ITER: TStringField;
    selT065TIPO_RICHIESTA: TStringField;
    selT065AUTORIZZ_AUTOMATICA: TStringField;
    selT065REVOCABILE: TStringField;
    selT065DATA_RICHIESTA: TDateTimeField;
    selT065LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT065DATA_AUTORIZZAZIONE: TDateTimeField;
    selT065AUTORIZZAZIONE: TStringField;
    selT065NOMINATIVO_RESP: TStringField;
    selT065AUTORIZZ_AUTOM_PREV: TStringField;
    selT065AUTORIZZ_PREV: TStringField;
    selT065RESPONSABILE_PREV: TStringField;
    selT065AUTORIZZ_UTILE: TStringField;
    selT065AUTORIZZ_REVOCA: TStringField;
    selT065D_TIPO_RICHIESTA: TStringField;
    selT065D_RESPONSABILE: TStringField;
    selT065D_AUTORIZZAZIONE: TStringField;
    selArrotondamento: TOracleDataSet;
    selaT820: TOracleDataSet;
    selaT065: TOracleDataSet;
    selT065ID_CONGUAGLIO: TIntegerField;
    selT852: TOracleDataSet;
    selT065ORE_CAUSALIZZATE: TStringField;
    selT065CAUSALE: TStringField;
    selT065CF_CAUSALE_AUTORIZ: TStringField;
    selT065CF_ORE_CAUS_AUTORIZ: TStringField;
    selT065MIN_ORE_DALIQUIDARE: TStringField;
    T065P_GESTIONESTRAORDINARIO: TOracleQuery;
    selT065MIN_ORE_DACOMPENSARE: TStringField;
    updT065: TOracleQuery;
    selT065Limiti: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT065CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FMinArr:Integer;
    FMinOredaLiquidare,FMinOreDaCompensare,FMaxOreDaLiquidare,FMaxOreDaCompensare:Integer;
    procedure AutorizzateDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus:String);
    procedure InAutorizzDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus:String);
    function AutorizzazioneManuale(Progressivo:Integer;Data:TDateTime;OreComp,OreLiq,Causale,OreCaus:String):Boolean;
    procedure AggiornamentoSchedaRiepilogativa(Progressivo:Integer; DataI,DataF:TDateTime);
  public
    { Public declarations }
    //selDatiBloccati:TDatiBloccati;
    TipoRichStr:String;
    GestioneCausale,CampiCalcolati,AggiornaTotali:Boolean;
    C018:TC018FIterAutDM;
    C90_W024MMIndietro:Integer;
    C90_W026UtilizzoDal,C90_W026UtilizzoAl:String;
    selAnagrafeW:TOracleDataSet;
    procedure RecuperaLimitiAnnuali(FiltroDip:String;Anno:Integer;var OreComp,OreLiq:String);
    procedure RecuperaLimitiMensili(FiltroDip:String;Data:TDateTime;var OreComp,OreLiq:String);
    procedure GetMinArr;
    procedure CalcolaLimitiLiquidazioneRecupero;
    procedure AggiornaSaldiSchede;
    property MinArr:Integer read FMinArr;
    property MinOreDaLiquidare:Integer read FMinOredaLiquidare;
    property MinOreDaCompensare:Integer read FMinOreDaCompensare;
    property MaxOreDaLiquidare:Integer read FMaxOreDaLiquidare;
    property MaxOreDaCompensare:Integer read FMaxOreDaCompensare;
  end;

implementation

{$R *.dfm}

procedure TW024FRichiestaStraordinariDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  C90_W024MMIndietro:=StrToIntDef(Parametri.CampiRiferimento.C90_W024MMIndietro,1);
  FMinArr:=1;
  //selDatiBloccati:=TDatiBloccati.Create(nil);
  //selDatiBloccati.TipoLog:=''; // evita la creazione di un file di log
 except
 end;
end;

procedure TW024FRichiestaStraordinariDM.RecuperaLimitiAnnuali(FiltroDip:String;Anno:Integer;var OreComp,OreLiq:String);
begin

  OreComp:='';
  OreLiq:='';
  R180SetVariable(selT825,'FILTRO_DIP',FiltroDip);
  if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
  begin
    if selT825.VariableIndex('DATALAVORO') = -1 then
      selT825.DeclareVariable('DATALAVORO',otDate);
    R180SetVariable(selT825,'DATALAVORO',Parametri.DataLavoro);
  end
  else if selT825.VariableIndex('DATALAVORO') > -1 then
    selT825.DeleteVariable('DATALAVORO');
  R180SetVariable(selT825,'ANNO',Anno);
  selT825.Open;
  //Per il dipendente prendo i limiti solo se almeno uno è definitivo
  if WR000DM.Responsabile or (selT825.FieldByName('DEFINITIVI').AsString = 'S') then
  begin
    OreComp:=R180MinutiOre(selT825.FieldByName('RESIDUABILE').AsInteger);
    OreLiq:=R180MinutiOre(selT825.FieldByName('LIQUIDABILE').AsInteger);
  end;
end;

procedure TW024FRichiestaStraordinariDM.RecuperaLimitiMensili(FiltroDip:String;Data:TDateTime;var OreComp,OreLiq:String);
begin
  OreComp:='';
  OreLiq:='';
  //Non prelevo i limiti per il mese in lavorazione se è Gennaio, perché D_FIN e FINE finirebbero nell'anno precedente
  if (R180Mese(Data) = 1) and (Data = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro))) then
    Exit;
  //Prelevo i totali da inizio anno fino, al massimo, a 2 mesi precedenti a sysdate
  //Se i limiti sono definitivi prelevo dalla scheda riepilogativa, altrimenti dai limiti mensili
  R180SetVariable(selLimitiMensili,'FILTRO_DIP',FiltroDip);
  if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
  begin
    if selLimitiMensili.VariableIndex('DATALAVORO') = -1 then
      selLimitiMensili.DeclareVariable('DATALAVORO',otDate);
    R180SetVariable(selLimitiMensili,'DATALAVORO',Parametri.DataLavoro);
  end
  else if selLimitiMensili.VariableIndex('DATALAVORO') > -1 then
    selLimitiMensili.DeleteVariable('DATALAVORO');
  R180SetVariable(selLimitiMensili,'ANNO',R180Anno(Data));
  R180SetVariable(selLimitiMensili,'INIZIO',EncodeDate(R180Anno(Data),1,1));
  if Data = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)) then
    R180SetVariable(selLimitiMensili,'FINE',R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro - 1)))
  else
    R180SetVariable(selLimitiMensili,'FINE',Data);
  selLimitiMensili.Open;
  OreComp:=R180MinutiOre(selLimitiMensili.FieldByName('ORE_RESIDUATE').AsInteger);
  OreLiq:=R180MinutiOre(selLimitiMensili.FieldByName('ORE_LIQUIDATE').AsInteger);
end;

procedure TW024FRichiestaStraordinariDM.AutorizzateDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus:String);
begin
  OreComp:='';
  OreLiq:='';
  Causale:='';
  OreCaus:='';
  //Prelevo la somma delle autorizzazioni del mese
  with selaT065 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Data);
    Open;
    while not Eof do
    begin
      if FieldByName('STATO').AsString = 'S' then
      begin
        selT852.Close;
        selT852.SetVariable('ID',FieldByName('ID').AsInteger);
        selT852.Open;
        while not selT852.Eof do
        begin
          if selT852.FieldByName('DATO').AsString = 'ORE_DACOMPENSARE' then
            OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'ORE_DALIQUIDARE' then
            OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString))
          else if selT852.FieldByName('DATO').AsString = 'CAUSALE' then
            Causale:=selT852.FieldByName('VALORE').AsString
          else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE' then
            OreCaus:=R180MinutiOre(R180OreMinutiExt(OreCaus) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString));
          selT852.Next;
        end;
      end
      else if FieldByName('STATO').AsString = 'N' then
      begin
        OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + 0);
        OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + 0);
        if not FieldByName('CAUSALE').IsNull then
        begin
          Causale:=FieldByName('CAUSALE').AsString;
          OreCaus:=R180MinutiOre(R180OreMinutiExt(OreCaus) + 0);
        end;
      end;
      Next;
    end;
    //Potrebbe essere stato salvato 0 in Ore_Causalizzate, ma equivale a vuoto, per il successivo controllo sui limiti
    if Causale = '' then
      OreCaus:='';
  end;
end;

procedure TW024FRichiestaStraordinariDM.InAutorizzDelMese(Progressivo:Integer;Data:TDateTime;var OreComp,OreLiq,Causale,OreCaus:String);
begin
  OreComp:='';
  OreLiq:='';
  Causale:='';
  OreCaus:='';
  //Prelevo la somma delle richieste in autorizzazione del mese
  with selaT065 do
  begin
    First;
    while not Eof do
    begin
      if R180In(FieldByName('TIPO_RICHIESTA').AsString,['A','I']) then
      begin
        //il dipendente non deve vedere le quantità impostate dal responsabile finché non autorizza
        if (FieldByName('TIPO_RICHIESTA').AsString = 'A') or not WR000DM.Responsabile then
        begin
          OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + R180OreMinutiExt(FieldByName('ORE_DACOMPENSARE').AsString));
          OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + R180OreMinutiExt(FieldByName('ORE_DALIQUIDARE').AsString));
          if not FieldByName('CAUSALE').IsNull then
          begin
            Causale:=FieldByName('CAUSALE').AsString;
            OreCaus:=R180MinutiOre(R180OreMinutiExt(OreCaus) + R180OreMinutiExt(FieldByName('ORE_CAUSALIZZATE').AsString));
          end;
        end
        else
        begin
          selT852.Close;
          selT852.SetVariable('ID',FieldByName('ID').AsInteger);
          selT852.Open;
          while not selT852.Eof do
          begin
            if selT852.FieldByName('DATO').AsString = 'ORE_DACOMPENSARE' then
              OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString))
            else if selT852.FieldByName('DATO').AsString = 'ORE_DALIQUIDARE' then
              OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString))
            else if selT852.FieldByName('DATO').AsString = 'CAUSALE' then
              Causale:=selT852.FieldByName('VALORE').AsString
            else if selT852.FieldByName('DATO').AsString = 'ORE_CAUSALIZZATE' then
              OreCaus:=R180MinutiOre(R180OreMinutiExt(OreCaus) + R180OreMinutiExt(selT852.FieldByName('VALORE').AsString));
            selT852.Next;
          end;
        end;
      end;
      Next;
    end;
  end;
end;

function TW024FRichiestaStraordinariDM.AutorizzazioneManuale(Progressivo:Integer;Data:TDateTime;OreComp,OreLiq,Causale,OreCaus:String):Boolean;
var TrovComp,TrovLiq,TrovCaus:Boolean;
begin
  Result:=False;
  TrovComp:=False;
  TrovLiq:=False;
  TrovCaus:=False;
  //Prelevo i limiti mensili
  selaT820.Close;
  selaT820.SetVariable('PROGRESSIVO',Progressivo);
  selaT820.SetVariable('ANNO',R180Anno(Data));
  selaT820.SetVariable('MESE',R180Mese(Data));
  selaT820.Open;
  while not selaT820.Eof do
  begin
    //Verifico il limite sul compensabile
    if (selaT820.FieldByName('CAUSALE').AsString = '* B')
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'N') then
    begin
      TrovComp:=True;
      Result:=R180MinutiOre(R180OreMinutiExt(selaT820.FieldByName('ORE').AsString)) <> OreComp;
    end
    //Verifico il limite sul liquidabile
    else if (selaT820.FieldByName('CAUSALE').AsString = '* L')
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'S') then
    begin
      TrovLiq:=True;
      Result:=R180MinutiOre(R180OreMinutiExt(selaT820.FieldByName('ORE').AsString)) <> OreLiq;
    end
    //Verifico il limite sulla causale
    else if (Causale <> '')
    and (selaT820.FieldByName('CAUSALE').AsString = Causale)
    and (selaT820.FieldByName('LIQUIDABILE').AsString = 'S') then
    begin
      TrovCaus:=True;
      Result:=R180MinutiOre(R180OreMinutiExt(selaT820.FieldByName('ORE').AsString)) <> OreCaus;
    end
    //C'è una situazione sui limiti che non mi aspettavo
    else
      Result:=True;
    //Se c'è stato un intervento manuale esco dal ciclo e poi dalla funzione
    if Result then
      Break;
    selaT820.Next;
  end;
  //Se non esiste un limite che mi aspettavo, allora c'è stato un intervento manuale (da operatore lato IrisWin)
  Result:=Result or
          ((not TrovComp) and (OreComp <> '')) or
          ((not TrovLiq) and (OreLiq <> '')) or
          ((not TrovCaus) and (OreCaus <> ''));
end;

procedure TW024FRichiestaStraordinariDM.selT065CalcFields(DataSet: TDataSet);
var sOreComp,sOreLiq,sCausale,sOreCaus:String;
    CompDelMese,LiqDelMese,CausDelMeseAut,CausDelMeseInAut:Integer;
begin
  with selT065 do
  begin
    if CampiCalcolati then
    begin
      FieldByName('Desc_Tipo').AsString:=IfThen(FieldByName('TIPO').AsString = 'C','Corrente','Conguaglio');
      //Imposto lo stato fittizio "Non autorizzabile" per lo Straordinario annuo:
      //Stato non impostato e ((Richiesta più vecchia del mese precedente a sysdate) o (Periodo abilitato scaduto) o (Blocchi sui riepiloghi))
      if (TipoRichStr <> '1') and (FieldByName('AUTORIZZAZIONE').IsNull) then
        if FieldByName('DATA').AsDateTime < R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)) then
        begin
          FieldByName('D_Tipo_Richiesta').AsString:='X';
          FieldByName('D_Avvertimenti').AsString:='Mese non più ' + IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'R','richiedibile','autorizzabile') + ' via web';
        end
        else if not R180Between(R180Giorno(Date),StrToIntDef(C90_W026UtilizzoDal,1),StrToIntDef(C90_W026UtilizzoAl,31)) then
        begin
          FieldByName('D_Tipo_Richiesta').AsString:='X';
          FieldByName('D_Avvertimenti').AsString:=FormatDateTime('dd/mm/yyyy',Date) + ' esterno al periodo di ' + IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'R','richiesta','autorizzazione');
        end
        else if WR000DM.selDatiBloccati.DatoBloccato(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,'T820') then
        begin
          FieldByName('D_Tipo_Richiesta').AsString:='X';
          FieldByName('D_Avvertimenti').AsString:='Saldi mensili non modificabili';
        end;
      if FieldByName('D_Tipo_Richiesta').IsNull then
        FieldByName('D_Tipo_Richiesta').AsString:=FieldByName('TIPO_RICHIESTA').AsString;
      FieldByName('D_Responsabile').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);
      FieldByName('D_Autorizzazione').AsString:=IfThen(FieldByName('AUTORIZZAZIONE').AsString = 'S','Si',IfThen(FieldByName('AUTORIZZAZIONE').AsString = 'N','No',''));
      FieldByName('CF_Data').AsString:=FormatDateTime('mm/yyyy',FieldByName('DATA').AsDateTime);
    end;
    if CampiCalcolati or AggiornaTotali then
    begin
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      //Prelevo i dati di validazione e autorizzazione
      if C018.EsisteFase[T065FASE_VALIDAZIONE] then
      begin
        FieldByName('CF_ORE_ECCED_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','1').Valore;
        FieldByName('CF_ORE_COMP_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','1').Valore;
        FieldByName('CF_ORE_LIQ_VALID').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','1').Valore;
        FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','2').Valore;
        FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','2').Valore;
        FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','2').Valore;
        FieldByName('CF_CAUSALE_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('CAUSALE','2').Valore;
        FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE','2').Valore;
      end
      else
      begin
        FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_ECCEDENTI','1').Valore;
        FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DACOMPENSARE','1').Valore;
        FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_DALIQUIDARE','1').Valore;
        FieldByName('CF_CAUSALE_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('CAUSALE','1').Valore;
        FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=C018.GetDatoAutorizzatore('ORE_CAUSALIZZATE','1').Valore;
      end;
      //Per il Validatore imposto i dati della richiesta ancora da validare
      if (C018.FaseLivello[FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] = 1) and (FieldByName('D_TIPO_RICHIESTA').AsString = 'A') then
      begin
        FieldByName('CF_ORE_ECCED_VALID').AsString:=FieldByName('ORE_ECCEDENTI').AsString;
        FieldByName('CF_ORE_COMP_VALID').AsString:=FieldByName('ORE_DACOMPENSARE').AsString;
        FieldByName('CF_ORE_LIQ_VALID').AsString:=FieldByName('ORE_DALIQUIDARE').AsString;
      end;
      //Aggiorno i dati di autorizzazione in base allo stato reale della richiesta (altrimenti, per lo stato fittizio X, non saprebbe quali dati prendere)
      FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'A',FieldByName('ORE_ECCEDENTI').AsString,IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'V',FieldByName('CF_ORE_ECCED_VALID').AsString,FieldByName('CF_ORE_ECCED_AUTORIZ').AsString));
      FieldByName('CF_ORE_COMP_AUTORIZ').AsString:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'A',FieldByName('ORE_DACOMPENSARE').AsString,IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'V',FieldByName('CF_ORE_COMP_VALID').AsString,FieldByName('CF_ORE_COMP_AUTORIZ').AsString));
      FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'A',FieldByName('ORE_DALIQUIDARE').AsString,IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'V',FieldByName('CF_ORE_LIQ_VALID').AsString,FieldByName('CF_ORE_LIQ_AUTORIZ').AsString));
      FieldByName('CF_CAUSALE_AUTORIZ').AsString:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'A',FieldByName('CAUSALE').AsString,FieldByName('CF_CAUSALE_AUTORIZ').AsString);
      FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:=IfThen(FieldByName('TIPO_RICHIESTA').AsString = 'A',FieldByName('ORE_CAUSALIZZATE').AsString,FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
    end;
    if CampiCalcolati then
    begin
      if TipoRichStr <> '1' then
      begin
        //Avvertimento di Autorizzazione manuale
        AutorizzateDelMese(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus);
        CompDelMese:=IfThen(FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),R180OreMinutiExt(sOreComp),0);
        LiqDelMese:=IfThen(FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),R180OreMinutiExt(sOreLiq),0);
        CausDelMeseAut:=IfThen(FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)),R180OreMinutiExt(sOreCaus),0);
        if VarToStr(WR000DM.selT275.Lookup('CODICE',sCausale,'ORENORMALI')) <> 'A' then
          LiqDelMese:=LiqDelMese + CausDelMeseAut;
        FieldByName('D_Avvertimenti').AsString:=Trim(FieldByName('D_Avvertimenti').AsString + CRLF + IfThen(AutorizzazioneManuale(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus),'Esiste autorizzazione manuale'));
        //Recupero i limiti annuali
        RecuperaLimitiAnnuali('= ' + FieldByName('PROGRESSIVO').AsString,R180Anno(FieldByName('DATA').AsDateTime),sOreComp,sOreLiq);
        FieldByName('CF_Ore_Compensabili_Anno').AsString:=sOreComp;
        FieldByName('CF_Ore_Liquidabili_Anno').AsString:=sOreLiq;
        //Se ho recuperato dei limiti...(quindi sempre tranne che dipendente senza limiti definitivi)
        if FieldByName('CF_Ore_Compensabili_Anno').AsString <> '' then
        begin
          //Calcolo le quantità richieste/autorizzate del mese precedente a sysdate (escludo le richieste R,X,N perché non contengono ore autorizzate o in attesa di autorizzazione)
          if (FieldByName('DATA').AsDateTime = R180InizioMese(R180AddMesi(Date,-C90_W024MMIndietro)))
          and (R180Between(R180Giorno(Date),StrToIntDef(C90_W026UtilizzoDal,1),StrToIntDef(C90_W026UtilizzoAl,31)))
          and (not WR000DM.selDatiBloccati.DatoBloccato(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,'T820'))
          then
          begin
            InAutorizzDelMese(FieldByName('PROGRESSIVO').AsInteger,FieldByName('DATA').AsDateTime,sOreComp,sOreLiq,sCausale,sOreCaus);
            CompDelMese:=CompDelMese + R180OreMinutiExt(sOreComp);
            LiqDelMese:=LiqDelMese + R180OreMinutiExt(sOreLiq);
            CausDelMeseInAut:=R180OreMinutiExt(sOreCaus);
            if VarToStr(WR000DM.selT275.Lookup('CODICE',sCausale,'ORENORMALI')) <> 'A' then
              LiqDelMese:=LiqDelMese + CausDelMeseInAut;
          end;
          //Assegno i totali, eventualmente aggiungendo le quantità richieste/autorizzate del mese precedente a sysdate
          RecuperaLimitiMensili('= ' + FieldByName('PROGRESSIVO').AsString,FieldByName('DATA').AsDateTime,sOreComp,sOreLiq);
          FieldByName('CF_Ore_Compensate_Anno').AsString:=R180MinutiOre(R180OreMinutiExt(sOreComp) + CompDelMese);
          FieldByName('CF_Res_Ore_Comp_Anno').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('CF_Ore_Compensabili_Anno').AsString) - R180OreMinutiExt(FieldByName('CF_Ore_Compensate_Anno').AsString));
          FieldByName('CF_Ore_Liquidate_Anno').AsString:=R180MinutiOre(R180OreMinutiExt(sOreLiq) + LiqDelMese);
          FieldByName('CF_Res_Ore_Liq_Anno').AsString:=R180MinutiOre(R180OreMinutiExt(FieldByName('CF_Ore_Liquidabili_Anno').AsString) - R180OreMinutiExt(FieldByName('CF_Ore_Liquidate_Anno').AsString));
          //Visualizzo i totali in un'unica colonna
          FieldByName('CF_Riep_Ore_Comp').AsString:=FieldByName('CF_Ore_Compensabili_Anno').AsString + ' ' + FieldByName('CF_Ore_Compensate_Anno').AsString + ' ' + FieldByName('CF_Res_Ore_Comp_Anno').AsString;
          FieldByName('CF_Riep_Ore_Liq').AsString:=FieldByName('CF_Ore_Liquidabili_Anno').AsString + ' ' + FieldByName('CF_Ore_Liquidate_Anno').AsString + ' ' + FieldByName('CF_Res_Ore_Liq_Anno').AsString;
        end;
      end;
      //In caso di dipendente o validatore, se la riga non è ancora stata autorizzata, svuoto i campi di autorizzazione (che mi servivano per i calcolare totali dello Straordinario annuo)
      if (C018.FaseLivello[FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] <> 2)
      and not R180In(FieldByName('D_TIPO_RICHIESTA').AsString,['S','N']) then
      begin
        FieldByName('CF_ORE_ECCED_AUTORIZ').AsString:='';
        FieldByName('CF_ORE_COMP_AUTORIZ').AsString:='';
        FieldByName('CF_ORE_LIQ_AUTORIZ').AsString:='';
        FieldByName('CF_CAUSALE_AUTORIZ').AsString:='';
        FieldByName('CF_ORE_CAUS_AUTORIZ').AsString:='';
      end;
    end;
  end;
end;

procedure TW024FRichiestaStraordinariDM.GetMinArr;
begin
  FMinArr:=1;
  if TipoRichStr <> '1' then
  begin
    R180SetVariable(selArrotondamento,'PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selArrotondamento,'DATA',R180FineMese(selT065.FieldByName('DATA').AsDateTime));
    selArrotondamento.Open;
    if selArrotondamento.RecordCount > 0 then
      FMinArr:=R180OreMinutiExt(selArrotondamento.FieldByName('MIN_ARR').AsString);
  end;
end;

procedure TW024FRichiestaStraordinariDM.AggiornaSaldiSchede;
var AggEseguito:Boolean;
begin
  if Parametri.CampiRiferimento.C90_W024AggScheda <> 'S' then
    exit;

  AggEseguito:=False;
  (*
  selT065.First;
  while not selT065.Eof do
  begin
    if (selT065.FieldByName('TIPO_RICHIESTA').AsString = 'R') and
       (selT065.FieldByName('ID_CONGUAGLIO').AsInteger >= 0) and
       (selT065.FieldByName('DATA').AsDateTime = R180AddMesi(R180InizioMese(Date),-1)) then
    begin
      AggiornamentoSchedaRiepilogativa(selT065.FieldByName('PROGRESSIVO').AsInteger,selT065.FieldByName('DATA').AsDateTime,R180FineMese(R180AddMesi(R180InizioMese(Date),-1)));
      AggEseguito:=True;
    end;
     selT065.Next;
  end;
  *)
  AggiornamentoSchedaRiepilogativa(selT065.FieldByName('PROGRESSIVO').AsInteger,R180AddMesi(R180InizioMese(Date),-1),R180FineMese(R180AddMesi(R180InizioMese(Date),-1)));
  AggEseguito:=True;
  if AggEseguito then
    selT065.Refresh;
  selT065.First;
end;


procedure TW024FRichiestaStraordinariDM.AggiornamentoSchedaRiepilogativa(Progressivo:Integer; DataI,DataF:TDateTime);
var
  A,M,G,A2,M2,G2:Word;
  MsgErr: String;
  AnomalieBloccantiDesc:String;
  R400FCartellinoDtM:TR400FCartellinoDtM;
begin
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  R400FCartellinoDtM:=TR400FCartellinoDtM.Create(Self);
  try
    R400FCartellinoDtM.Q950Int.Close;
    R400FCartellinoDtM.Q950Int.SetVariable('Codice',R400FCartellinoDtM.Q950Lista.FieldByName('CODICE').AsString);
    R400FCartellinoDtM.Q950Int.Open;
    R400FCartellinoDtM.selDatiBloccati.Close;
    R400FCartellinoDtM.SoloAggiornamento:=True;
    R400FCartellinoDtM.IgnoraAnomalie:=False;
    R400FCartellinoDtM.AggiornamentoScheda:=True;
    R400FCartellinoDtM.AutoGiustificazione:=False;
    R400FCartellinoDtM.CalcoloCompetenze:=False;
    R400FCartellinoDtM.lstDettaglio.Clear;
    R400FCartellinoDtM.lstRiepilogo.Clear;
    R400FCartellinoDtM.CampiIntestazione:='T430INIZIO,T430FINE';
    R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;
    MsgErr:=R400FCartellinoDtM.CalcoloCartelliniWeb(Progressivo,
                                                    A,M,G,A2,M2,G2,
                                                    False,
                                                    False,
                                                    False);

    AnomalieBloccantiDesc:=R400FCartellinoDtM.lstAnomalie.Text;
    R400FCartellinoDtM.A027SelAnagrafe:=nil;
  finally
    FreeAndNil(R400FCartellinoDtM);
  end;
end;

procedure TW024FRichiestaStraordinariDM.CalcolaLimitiLiquidazioneRecupero;
var MinEcc,MinComp,LiqTot,CompTot,CompTotPrec,SaldoTot,StraordEsc:Integer;
begin
  FMinOreDaLiquidare:=0;
  FMaxOreDaLiquidare:=99999;
  FMinOreDaCompensare:=0;
  FMaxOreDaCompensare:=99999;

  if TipoRichStr = '4' then
  begin
    {Sistema di riferimento:
      L <= Saldo + R*
      L >= saldo + R* - 20hr
      R* >= L - Saldo
      R* >= L - Saldo + 20hr
     dove:
      Saldo = Saldo complessivo al mese corrente, da scheda riepilogativa
            = SaldoTot
      L = liquidabile del mese corrente già destinato/da destinare in liquidazione (possono arrivare solo dal mese corrente)
        = LiqTot
      R* = ore dei mesi passati, ma destinate/da destinare in recupero sul mese corrente (possono arrivare da più mesi diversi)
         = CompTotPrec
    }
    selT065Limiti.Close;
    R180SetVariable(selT065Limiti,'PROGRESSIVO',selT065.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selT065Limiti,'DATA',R180AddMesi(R180InizioMese(Date),-1));
    //R180SetVariable(selT065Limiti,'DATA',R180AddMesi(R180InizioMese(Date),0));
    R180SetVariable(selT065Limiti,'IDRIGA',selT065.RowID);
    selT065Limiti.Open;

    MinEcc:=R180OreMinutiExt(selT065.FieldByName('ORE_ECCEDENTI').AsString);          //ore disponibili in destinazione per il mese corrente
    StraordEsc:=selT065Limiti.FieldByName('STRAORD_ESC').AsInteger;                   //eccedenza esclusa (STESC) del mese corrente
    LiqTot:=selT065Limiti.FieldByName('ORE_DALIQUIDARE').AsInteger;     //[L]     ore liquidate sul mese corrente
    CompTot:=selT065Limiti.FieldByName('ORE_DACOMPENSARE').AsInteger;   //        ore compensate sul mese corrente
    CompTotPrec:=selT065Limiti.FieldByName('ORE_DACOMPENSARE_PREC').AsInteger;   //[R*]    ore recuperate sui mesi precedenti, ma con MESE_RIFERIMENTO = mese corrente
    SaldoTot:=selT065Limiti.FieldByName('SALDO_COMPLESSIVO').AsInteger; //[Saldo] saldo sulla scheda riepilogativa del mese corrente

    if selT065.FieldByName('ID_CONGUAGLIO').AsInteger = 0 then
    begin
      StraordEsc:=min(StraordEsc,MinEcc);
      SaldoTot:=SaldoTot + StraordEsc + CompTotPrec;
      FMinOreDaLiquidare:=max(0,SaldoTot - (20*60));
      FMinOreDaLiquidare:=min(FMinOredaLiquidare,MinEcc);

      FMaxOreDaLiquidare:=max(FMinOreDaLiquidare,SaldoTot);
      FMaxOreDaLiquidare:=min(FMaxOreDaLiquidare,MinEcc);

      if (MinArr <> 1) and (FMinOreDaLiquidare > 0) then
        FMinOreDaLiquidare:=Trunc(R180Arrotonda(FMinOreDaLiquidare,MinArr,'E'));
      if (MinArr <> 1) and (FMaxOreDaLiquidare > 0) then
        FMaxOreDaLiquidare:=Trunc(R180Arrotonda(FMaxOreDaLiquidare,MinArr,'D'));
      if FMinOreDaLiquidare > FMaxOreDaLiquidare then
        FMinOreDaLiquidare:=FMaxOreDaLiquidare;

      FMaxOreDaCompensare:=max(0,MinEcc - FMinOreDaLiquidare);
      FMinOreDaCompensare:=max(0,MinEcc - FMaxOreDaLiquidare);
    end
    else if selT065.FieldByName('ID_CONGUAGLIO').AsInteger = -1 then
    begin
      CompTot:=min(CompTot,StraordEsc - min(StraordEsc,LiqTot));     //CompTot relativo alle ore escluse
      LiqTot:=LiqTot - min(StraordEsc,LiqTot);       //LiqTot relativo alle ore normali
      SaldoTot:=SaldoTot + CompTot + CompTotPrec;
      FMinOreDaCompensare:=max(0,LiqTot - SaldoTot);
      FMinOreDaCompensare:=min(FMinOreDaCompensare,MinEcc);
      if (MinArr <> 1) and (FMinOreDaCompensare > 0) then
        FMinOreDaCompensare:=Trunc(R180Arrotonda(FMinOreDaCompensare,MinArr,'E'));
      FMaxOreDaCompensare:=max(0,LiqTot - SaldoTot + (20*60));
      FMaxOreDaCompensare:=min(FMaxOreDaCompensare,MinEcc);
      if (MinArr <> 1) and (FMaxOreDaCompensare > 0) then
        FMaxOreDaCompensare:=Trunc(R180Arrotonda(FMaxOreDaCompensare,MinArr,'D'));
      FMaxOreDaLiquidare:=max(0,MinEcc - FMinOreDaCompensare);
      FMinOreDaLiquidare:=max(0,MinEcc - FMaxOreDaCompensare);
    end;
  end;
end;

end.
