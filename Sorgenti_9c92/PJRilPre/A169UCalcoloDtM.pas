unit A169UCalcoloDtM;

interface

uses
  Forms, SysUtils, Classes, QueryStorico, DB, Oracle, OracleData, A000UInterfaccia, A000UCostanti, A000USessione,
  C180FunzioniGenerali ;

type
  TGiorniMese = record
    Data:TDateTime;
    QuotaGG:Real;
    SaltaProva,SospendiPT,SospendiQuote:String;
  end;

  TA169FCalcoloDtM = class(TDataModule)
    selT770: TOracleDataSet;
    selT760: TOracleDataSet;
    selT775: TOracleDataSet;
    selT040B: TOracleDataSet;
    selT775Gen: TOracleDataSet;
    ControlloT770: TOracleDataSet;
    selT460: TOracleDataSet;
    selT774: TOracleDataSet;
    selT774ANNO: TFloatField;
    selT774CODGRUPPO: TStringField;
    selT774CODTIPOQUOTA: TStringField;
    selT774PROGRESSIVO: TIntegerField;
    selT774MATRICOLA: TStringField;
    selT774COGNOME: TStringField;
    selT774NOME: TStringField;
    selT774DATAINIZIO: TDateTimeField;
    selT774DATAFINE: TDateTimeField;
    selT774GG_SERVIZIO: TFloatField;
    selT774PESO_INDIVIDUALE: TFloatField;
    selT774QUOTA_INDIVIDUALE: TFloatField;
    selT774QUOTA_ASSEGNATA: TFloatField;
    selT774PESO_CALCOLATO: TFloatField;
    selT774QUOTA_CALCOLATA: TFloatField;
    selT774OBIETTIVI_ASSEGNATI: TStringField;
    selSG735: TOracleDataSet;
    selT768: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    QSIncentivi:TQueryStorico;
    DSIncentivi:TDipendenteInServizio;
    PeriodoProva:TPeriodoProva;
    DatiStorici:String;
    GiorniMese: array [1..31] of TGiorniMese;
  public
    { Public declarations }
    QuotaIndividuale,PesoCalcolato,QuotaCalcolata:Real;
    TotDip,TotalePesi,TotaleQuote,TotalePesiCalc,TotaleQuoteCalc:Real;
    lstMatricole:TStringList;
    procedure CalcolaQuota(Tipo,CodQuota:String;Prog,Anno:Integer;GGServ,PesoInd:Real);
    procedure AggiornaTotali(Anno:Integer;CodGruppo,CodQuota:String);
  end;

//var
//  A169FCalcoloDtM: TA169FCalcoloDtM;

implementation

{$R *.dfm}

procedure TA169FCalcoloDtM.CalcolaQuota(Tipo,CodQuota:String;Prog,Anno:Integer;GGServ,PesoInd:Real);
var DataApp,InizioProva,FineProva,GGCorr:TDateTime;
  Dato1,Dato2,Dato3,RegDato1,RegDato2,RegDato3,ProporzionePT,ProporzioneGGServ,SaltaProva,TipoQuoteQuant,Flex:String;
  Quota,QuotaTot,App,GG,PesoTot,GGTot,GGPT,PT:Real;
  i,DurataProva:Integer;
  GGOK,SospendiPT:Boolean;
begin
  QuotaIndividuale:=0;
  QuotaCalcolata:=0;
  PesoCalcolato:=0;
  selT775Gen.Close;
  selT775Gen.SetVariable('ANNO',Anno);
  selT775Gen.Open;
  GGTot:=0;
  QuotaTot:=0;
  if Tipo = 'C' then  //Calcolo la quota proporzionata
    GGTot:=365;
  //Calcolo la Quota individuale come se il dip. fosse in servizio tutto l'anno
  QSIncentivi.GetDatiStorici(DatiStorici,Prog,StrToDate('01/01/'+IntToStr(Anno)),StrToDate('31/12/'+IntToStr(Anno)));
  DataApp:=StrToDate('31/01/'+IntToStr(Anno));
  while DataApp <= StrToDate('31/12/' + IntToStr(Anno)) do  //Per ogni dip. per ogni mese dell'anno
  begin
    Quota:=0;
    QSIncentivi.LocDatoStorico(DataApp); //Leggo i dati storici a fine mese
    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
      Dato1:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString;
    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      Dato2:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString;
    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      Dato3:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString;
    //Leggo le quote a fine mese
    selT770.Close;
    selT770.SetVariable('DATO1',Dato1);
    selT770.SetVariable('DATO2',Dato2);
    selT770.SetVariable('DATO3',Dato3);
    selT770.SetVariable('CODQUOTA',CodQuota);
    selT770.SetVariable('DATA',DataApp);
    selT770.Open;
    if selT770.RecordCount > 0 then
    begin
      Quota:=selT770.FieldByName('IMPORTO').AsFloat;
      RegDato1:=selT770.FieldByName('DATO1').AsString;
      RegDato2:=selT770.FieldByName('DATO2').AsString;
      RegDato3:=selT770.FieldByName('DATO3').AsString;
    end;
    if Tipo = 'C' then
    begin
      //Leggo le regole di calcolo a fine mese
      selT760.Close;
      selT760.SetVariable('LIVELLO',Dato1);
      selT760.SetVariable('DECORRENZA',DataApp);
      selT760.Open;
      ProporzionePT:='N';
      ProporzioneGGServ:='0';
      TipoQuoteQuant:='G';
      if selT760.RecordCount > 0 then
      begin
        ProporzionePT:=selT760.FieldByName('PROPORZIONE_PARTTIME').AsString;
        ProporzioneGGServ:=selT760.FieldByName('PROPORZIONE_INCENTIVI').AsString;
        TipoQuoteQuant:=selT760.FieldByName('TIPO_QUOTEQUANT').AsString;
      end;
      for i:=1 to 31 do
      begin
        GiorniMese[i].Data:=(R180InizioMese(DataApp)-1) + i;;
        GiorniMese[i].QuotaGG:=Quota / R180GiorniMese(DataApp);
        GiorniMese[i].SaltaProva:='';
        GiorniMese[i].SospendiPT:='';
        GiorniMese[i].SospendiQuote:='';
      end;
    end;
    selT775.Close;
    selT775.SetVariable('PROGRESSIVO',Prog);
    selT775.SetVariable('DATA',DataApp);
    selT775.SetVariable('CODQUOTA',' AND CODTIPOQUOTA = ''' + CodQuota + '''');
    selT775.Open;
    if selT775.RecordCount > 0 then
    begin
      GG:=0;
      App:=0;
      while not selT775.Eof do
      begin
        GG:=GG + selT775.FieldByName('GIORNI').AsInteger;
        if selT775.FieldByName('IMPORTO').AsFloat <> -1 then
          App:=App + (selT775.FieldByName('IMPORTO').AsFloat *
                      selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(DataApp))
        else
          App:=App + (Quota * selT775.FieldByName('PERCENTUALE').AsFloat / 100) *
                     (selT775.FieldByName('GIORNI').AsInteger / R180GiorniMese(DataApp));
        if Tipo = 'C' then
        begin
          for i:=1 to 31 do
          begin
            if (GiorniMese[i].Data <= selT775.FieldByName('SCADENZA').AsDateTime) and
               (GiorniMese[i].Data >= selT775.FieldByName('DECORRENZA').AsDateTime) then
              if (selT775.FieldByName('IMPORTO').AsFloat = 0) or (selT775.FieldByName('PERCENTUALE').AsFloat = 0) then
                GiorniMese[i].QuotaGG:=0
              else
                GiorniMese[i].QuotaGG:=App/GG;
          end;
        end;
        selT775.Next;
      end;
      if R180GiorniMese(DataApp) - GG > 0 then
        App:=App + (Quota * (R180GiorniMese(DataApp) - GG) / R180GiorniMese(DataApp));
      Quota:=App;
    end;
    //Considerazione Assenze che decurtano la quota base
    selT040B.Close;
    selT040B.SetVariable('DATO1',Dato1);
    selT040B.SetVariable('DATO2',Dato2);
    selT040B.SetVariable('DATO3',Dato3);
    selT040B.SetVariable('DADATA',R180InizioMese(DataApp));
    selT040B.SetVariable('ADATA',DataApp);
    selT040B.SetVariable('PROG',Prog);
    selT040B.Open;
    if Quota <> 0 then
    begin
      App:=0;
      GG:=R180GiorniMese(DataApp);
      while not selT040B.Eof do
      begin
        GG:=GG - 1;
        if selT040B.FieldByName('CONSIDERA_SALDO').AsString = 'S' then
        begin
          if selT040B.FieldByName('IMPORTO').AsFloat <> -1 then
            App:=App + (selT040B.FieldByName('IMPORTO').AsFloat / R180GiorniMese(DataApp))
          else
            App:=App + ((Quota * selT040B.FieldByName('PERCENTUALE').AsFloat / 100) / R180GiorniMese(DataApp));
        end;
        selT040B.Next;
      end;
      Quota:=App + (Quota / R180GiorniMese(DataApp) * GG);
    end;
    //--Leggo le quote ind. generali
    SaltaProva:='N';
    if selT775Gen.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]) then
    begin
      while (not selT775Gen.Eof) and
        (selT775Gen.FieldByName('PROGRESSIVO').AsInteger = Prog) do
      begin
        if (DataApp >= selT775Gen.FieldByName('DECORRENZA').AsDateTime) and
           (DataApp <= selT775Gen.FieldByName('SCADENZA').AsDateTime) then
          //12/01/2015 Corretto campo errato.
          SaltaProva:=selT775Gen.FieldByName('SALTAPROVA').AsString;
        if Tipo = 'C' then
        begin
          for i:=1 to 31 do
          begin
            if (GiorniMese[i].Data <= selT775Gen.FieldByName('SCADENZA').AsDateTime) and
               (GiorniMese[i].Data >= selT775Gen.FieldByName('DECORRENZA').AsDateTime) then
            begin
              GiorniMese[i].SaltaProva:=selT775Gen.FieldByName('SALTAPROVA').AsString;
              GiorniMese[i].SospendiPT:=selT775Gen.FieldByName('SOSPENDI_PT').AsString;
              GiorniMese[i].SospendiQuote:=selT775Gen.FieldByName('SOSPENDI_QUOTE').AsString;
            end;
          end;
        end;
        selT775Gen.Next;
      end;
    end;
    //--Considero il Periodo di prova alla data FINE del mese che sto elaborando con impostazione a 0 di QuotaBase
    DurataProva:=0;
      FineProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
    if Parametri.CampiRiferimento.C6_DurataProva <> '' then
      DurataProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_DurataProva).AsInteger;
    if DurataProva <> 0 then
    begin
      InizioProva:=QSIncentivi.FieldByName('T430INIZIO').AsDateTime;
      if (Parametri.CampiRiferimento.C6_InizioProva <> '') then
      begin
        if QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime <> 0 then
          InizioProva:=QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C6_InizioProva).AsDateTime;
      end;
      FineProva:=InizioProva + DurataProva - 1;
      if PeriodoProva.GetPeriodoProva(Prog,DurataProva,InizioProva) then
        FineProva:=PeriodoProva.FinePeriodoProva;
      DurataProva:=Trunc(FineProva - InizioProva) + 1;
      //Se il dip. a fine mese è in prova non matura incentivi
      if DataApp - InizioProva + 1 <= DurataProva then
      begin
        if SaltaProva = 'N' then
          Quota:=0;
      end;
    end;
    QuotaTot:=QuotaTot + Quota;
    if Tipo = 'C' then
    begin
      GGCorr:=R180InizioMese(DataApp);
      GG:=0;
      GGPT:=0;
      while GGCorr <= DataApp do  //Ciclo su ogni giorno del mese
      begin
        GGOK:=True;
        //Proporzionamento sui giorni di servizio
        QSIncentivi.LocDatoStorico(GGCorr); //Leggo i dati storici per ogni giorno del periodo
        if not DSIncentivi.DipendenteInServizio(Prog,GGCorr,GGCorr) then
        begin
          GG:=GG + 1;
          GGOK:=False;
        end;
        //Se Dato1 del giorno è diverso da quello delle regole T760 controllo che cmq. ci siano le regole anche per lui
        if GGOK and (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString <> Dato1) then //Dato1: regole T760
        begin
          selT760.Close;
          selT760.SetVariable('LIVELLO',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString);
          selT760.SetVariable('DECORRENZA',GGCorr);
          selT760.Open;
          if selT760.RecordCount <= 0 then
          begin
            GG:=GG + 1;
            GGOK:=False;
          end;
        end;
        if GGOK and  //Controllo se per i dati del giorno esistono cmq. delle quote
          (((Trim(RegDato1) <> '') and
           (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString <> RegDato1)) or
          ((Parametri.CampiRiferimento.C7_Dato2 <> '') and (Trim(RegDato2) <> '') and
           (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString <> RegDato2)) or
          ((Parametri.CampiRiferimento.C7_Dato3 <> '') and (Trim(RegDato3) <> '') and
           (QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString <> RegDato3))) then
        begin
          ControlloT770.Close;
          ControlloT770.SetVariable('DATO1',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato1).AsString);
          ControlloT770.SetVariable('DATO2',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato2).AsString);
          ControlloT770.SetVariable('DATO3',QSIncentivi.FieldByName('T430' + Parametri.CampiRiferimento.C7_Dato3).AsString);
          ControlloT770.SetVariable('CODQUOTA',CodQuota);
          ControlloT770.SetVariable('DATA',DataApp);
          ControlloT770.Open;
          if ControlloT770.RecordCount <= 0 then
          begin
            GG:=GG + 1;
            GGOK:=False;
          end;
        end;
        //Proporzionamento sulla sospensione della maturazione - Quote individuali
        if GGOK then
        begin
          if GiorniMese[R180Giorno(GGCorr)].SospendiQuote = 'S' then
          begin
            GG:=GG + 1;
            GGOK:=False;
          end;
        end;
        //Proporzionamento sul periodo di prova
        if GGOK and
          (FineProva <> QSIncentivi.FieldByName('T430INIZIO').AsDateTime) and (GGCorr <= FineProva) then
        begin
          if GiorniMese[R180Giorno(GGCorr)].SaltaProva = 'N' then
          begin
            GG:=GG + 1;
            GGOK:=False;
          end;
        end;
        if GGOK and (GiorniMese[R180Giorno(GGCorr)].QuotaGG > 0) then  //Proporzionamento part-time
        begin
          if (ProporzionePT = 'S') and
             (Trim(QSIncentivi.FieldByName('T430PARTTIME').AsString) <> '') then
          begin
            if selT460.SearchRecord('CODICE',QSIncentivi.FieldByName('T430PARTTIME').AsString,[srFromBeginning]) then
            begin
              SospendiPT:=False;
              if (selT040B.Active) and (selT040B.SearchRecord('DATA',GGCorr,[srFromBeginning])) and
                 (selT040B.FieldByName('SOSPENDI_PT').AsString = 'S') then
                SospendiPT:=True;
              if GiorniMese[R180Giorno(GGCorr)].SospendiPT = 'S' then
                SospendiPT:=True;
              if SospendiPT then
              begin
                if (selT460.FieldByName('PIANTA').AsFloat <> 0) and (selT460.FieldByName('PIANTA').AsFloat <> 100) then
                  GGPT:=GGPT + (1 - (selT460.FieldByName('PIANTA').AsFloat / 100));
              end
              else
              begin
                if (selT460.FieldByName('INCENTIVI').AsFloat <> 0) and (selT460.FieldByName('INCENTIVI').AsFloat <> 100) then
                begin
//                  GGPT:=GGPT + (1 - (selT460.FieldByName('INCENTIVI').AsFloat / 100));
                  PT:=selT460.FieldByName('INCENTIVI').AsFloat;
                  Flex:='*';
                  if TipoQuoteQuant = 'S' then   //Schede quant.
                  begin
                    selT768.Close;
                    selT768.SetVariable('ANNO',R180Anno(GGCorr));
                    selT768.SetVariable('QUOTA',CodQuota);
                    selT768.SetVariable('PROG',Prog);
                    selT768.Open;
                    if selT768.RecordCount > 0 then //se la scheda del dip. è firmata per l'anno guardo la flex
                    begin
                      if Pos(',',selT768.FieldByName('FLESSIBILITA').AsString) > 0 then //Flex
                        Flex:='S'
                      else
                        Flex:='N';
                    end
                    else //altrimenti guardo se è firmata per l'anno prec.
                    begin
                      selT768.Close;
                      selT768.SetVariable('ANNO',R180Anno(GGCorr)-1);
                      selT768.Open;
                      if selT768.RecordCount > 0 then
                      begin
                        if Pos(',',selT768.FieldByName('FLESSIBILITA').AsString) > 0 then //Flex
                          Flex:='S'
                        else
                          Flex:='N';
                      end;
                    end;
                  end;
                  R180SetVariable(selSG735,'QUOTA',CodQuota);
                  R180SetVariable(selSG735,'FLEX',Flex);
                  R180SetVariable(selSG735,'DATARIF',GGCorr);
                  R180SetVariable(selSG735,'PARTTIME',PT);
                  selSG735.Open;
                  if selSG735.RecordCount > 0 then
                    PT:=selSG735.FieldByName('PERC').AsFloat;
                  GGPT:=GGPT + (1 - (PT / 100));
                end;
              end;
            end;
          end;
        end;
        GGCorr:=GGCorr + 1;
      end;
      if R180GiorniMese(DataApp) - GG < R180GiorniMese(DataApp) then
      begin
        if (ProporzioneGGServ = '0') and (R180GiorniMese(DataApp) - GG <= 15) then //Lavorato > 15gg
          GGTot:=GGTot - R180GiorniMese(DataApp);
        if (ProporzioneGGServ = '1') then
          GGTot:=GGTot - GG;
      end;
      GGTot:=GGTot - GGPT;
    end;
    DataApp:=R180FineMese(R180AddMesi(DataApp,1));
  end;
  QuotaIndividuale:=R180Arrotonda(QuotaTot,0.01,'P');
  if Tipo = 'C' then  //Quota calcolata
  begin
    PesoTot:=PesoInd;
    if GGServ < GGTot then
      GGTot:=GGServ;
    if (PesoTot > 0) then
    begin
      PesoCalcolato:=R180Arrotonda(PesoTot / 365 * GGTot,0.01,'P');
      QuotaCalcolata:=R180Arrotonda(QuotaTot * R180Arrotonda(PesoTot / 365 * GGTot,0.01,'P'),0.01,'P');
    end;
  end;
end;

procedure TA169FCalcoloDtM.AggiornaTotali(Anno:Integer;CodGruppo,CodQuota:String);
begin
  TotalePesi:=0;
  TotaleQuote:=0;
  TotalePesiCalc:=0;
  TotaleQuoteCalc:=0;
  selT774.Close;
  selT774.SetVariable('ANNO',Anno);
  selT774.SetVariable('CODICE',CodGruppo);
  selT774.SetVariable('CODQUOTA',CodQuota);
  selT774.Open;
  selT774.First;
  TotDip:=selT774.RecordCount;
  lstMatricole.Clear;
  while not selT774.Eof do
  begin
    if selT774.FieldByName('PESO_INDIVIDUALE').AsFloat > 0 then
    begin
      TotalePesi:=TotalePesi + selT774.FieldByName('PESO_INDIVIDUALE').AsFloat;
      TotaleQuote:=TotaleQuote + selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat;
      TotalePesiCalc:=TotalePesiCalc + selT774.FieldByName('PESO_CALCOLATO').AsFloat;
      TotaleQuoteCalc:=TotaleQuoteCalc + selT774.FieldByName('QUOTA_CALCOLATA').AsFloat;
    end;
    if (selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat = 0) or
       (selT774.FieldByName('PESO_INDIVIDUALE').AsFloat <= 0) then
      lstMatricole.Add(selT774.FieldByName('MATRICOLA').AsString);
    selT774.Next;
  end;
  TotaleQuote:=R180Arrotonda(TotaleQuote,0.01,'P');
  TotaleQuoteCalc:=R180Arrotonda(TotaleQuoteCalc,0.01,'P');
end;

procedure TA169FCalcoloDtM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    {$IFNDEF IRISWEB}
    if Password(Application.Name) = -1 then
      Application.Terminate;
    A000ParamDBOracle(SessioneOracle);
    {$ENDIF}
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  QSIncentivi:=TQueryStorico.Create(nil);
  QSIncentivi.Session:=SessioneOracle;
  DSIncentivi:=TDipendenteInServizio.Create(nil);
  DSIncentivi.Session:=SessioneOracle;
  PeriodoProva:=TPeriodoProva.Create(nil);
  PeriodoProva.Session:=SessioneOracle;
  DatiStorici:='T430INIZIO,T430FINE,T430PARTTIME';
  if Parametri.CampiRiferimento.C6_DurataProva <> '' then
    DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C6_DurataProva;
  if Parametri.CampiRiferimento.C6_InizioProva <> '' then
    DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C6_InizioProva;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato1;
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato2;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    DatiStorici:=DatiStorici + ',T430' + Parametri.CampiRiferimento.C7_Dato3;
  selT460.Open;
  lstMatricole:=TStringList.Create;
end;

procedure TA169FCalcoloDtM.DataModuleDestroy(Sender: TObject);
begin
  QSIncentivi.Free;
  DSIncentivi.Free;
  FreeAndNil(PeriodoProva);
  FreeAndNil(lstMatricole);
  selT460.Close;
end;

end.
