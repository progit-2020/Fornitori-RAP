unit A077UGeneratoreStampeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, R003UGeneratoreStampeMW,
  Oracle, Data.DB, OracleData, StrUtils, C180FunzioniGenerali, A000UInterfaccia;

type
  TA077FGeneratoreStampeMW = class(TR003FGeneratoreStampeMW)
    Ins920_1: TOracleQuery;
    Ins920_2: TOracleQuery;
    Ins920_3: TOracleQuery;
    Ins920_4: TOracleQuery;
    Ins920_5: TOracleQuery;
    Ins920_6: TOracleQuery;
    Ins920_7: TOracleQuery;
    Ins920_8: TOracleQuery;
    Ins920_9: TOracleQuery;
    Ins920_10: TOracleQuery;
    Ins920_11: TOracleQuery;
    Ins920_12: TOracleQuery;
    Ins920_13: TOracleQuery;
    Ins920_14: TOracleQuery;
    Ins920_15: TOracleQuery;
    Ins920_16: TOracleQuery;
    Ins920_17: TOracleQuery;
    Ins920_18: TOracleQuery;
    Ins920_19: TOracleQuery;
    Ins920_20: TOracleQuery;
    Ins920_21: TOracleQuery;
    Ins920_22: TOracleQuery;
    Ins920_23: TOracleQuery;
    Ins920_24: TOracleQuery;
    Ins920_25: TOracleQuery;
    selT162: TOracleDataSet;
    selM020: TOracleDataSet;
    seldistT195: TOracleDataSet;
    selT240: TOracleDataSet;
    selSG650: TOracleDataSet;
    selT241: TOracleDataSet;
    Ins920_26: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  protected
    procedure CaricaSerbatoi; override;
    procedure CaricaTabelleCollegate; override;
  public
    function getListAssenze: TStringList;
    function getListPresenze: TStringList;
    function getListIndPresenza: TStringList;
    function getListRimborsi: TStringList;
    function getListVociPaghe: TStringList;
    function getListOrgSindacali: TStringList;
    function getListCorsiFormazione(Tutto: Boolean; Anno: Integer): TStringList;
    function getListRecapitoSindacato: TStringList;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA077FGeneratoreStampeMW.CaricaSerbatoi;
var
  i: Integer;
begin
  //Descrizione dei serbatoi disponibili
  SetLength(Serbatoi,27);
  //Inizializzazioni
  for i:=0 to High(Serbatoi) do
  begin
    Serbatoi[i].Esclusivo:=False;
    Serbatoi[i].DatoDalAl:='';
  end;

  Serbatoi[0].N:=507;
  Serbatoi[0].R:=001;
  Serbatoi[0].M:=0;
  Serbatoi[0].X:=0;
  Serbatoi[0].Multiplo:=False;
  Serbatoi[0].Nome:='Dati anagrafici';
  Serbatoi[0].Tabelle:='T030_ANAGRAFICO,V430_STORICO';
  Serbatoi[0].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[1].N:=1;
  Serbatoi[1].M:=5;
  Serbatoi[1].X:=5;
  Serbatoi[1].Multiplo:=True;
  Serbatoi[1].Nome:='Riepiloghi mensili';
  Serbatoi[1].Applicazione:='RILPRE,STAGIU';

  Serbatoi[2].N:=1950;
  Serbatoi[2].M:=24;
  Serbatoi[2].X:=24;
  Serbatoi[2].Multiplo:=True;
  Serbatoi[2].Nome:='Assestamento ore anni prec.';
  Serbatoi[2].Applicazione:='RILPRE';

  Serbatoi[3].N:=400;
  Serbatoi[3].M:=1;
  Serbatoi[3].X:=1;
  Serbatoi[3].Multiplo:=True;
  Serbatoi[3].Nome:='Indennità di presenza';
  Serbatoi[3].Applicazione:='RILPRE';

  Serbatoi[4].N:=1700;
  Serbatoi[4].M:=2;
  Serbatoi[4].X:=2;
  Serbatoi[4].Multiplo:=True;
  Serbatoi[4].Nome:='Riepilogo presenze';
  Serbatoi[4].Applicazione:='RILPRE';

  Serbatoi[5].N:=1800;
  Serbatoi[5].M:=3;
  Serbatoi[5].X:=3;
  Serbatoi[5].Multiplo:=True;
  Serbatoi[5].Nome:='Riepilogo assenze';
  Serbatoi[5].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[6].N:=800;
  Serbatoi[6].M:=4;
  Serbatoi[6].X:=4;
  Serbatoi[6].Multiplo:=True;
  Serbatoi[6].Nome:='Dati giornalieri';
  Serbatoi[6].Applicazione:='RILPRE';

  Serbatoi[7].N:=1300;
  Serbatoi[7].M:=6;
  Serbatoi[7].X:=6;
  Serbatoi[7].Multiplo:=True;
  Serbatoi[7].Nome:='Missioni/Trasferte';
  Serbatoi[7].Applicazione:='RILPRE,MISTRA';

  Serbatoi[8].N:=1600;
  Serbatoi[8].M:=7;
  Serbatoi[8].X:=7;
  Serbatoi[8].Multiplo:=True;
  Serbatoi[8].Nome:='Missioni: rimborsi';
  Serbatoi[8].Applicazione:='RILPRE,MISTRA';

  Serbatoi[9].N:=1400;
  Serbatoi[9].M:=14;
  Serbatoi[9].X:=14;
  Serbatoi[9].Multiplo:=True;
  Serbatoi[9].Nome:='Missioni: indennità km';
  Serbatoi[9].Applicazione:='RILPRE,MISTRA';

  Serbatoi[10].N:=2100;
  Serbatoi[10].M:=16;
  Serbatoi[10].X:=16;
  Serbatoi[10].Multiplo:=True;
  Serbatoi[10].Nome:='Missioni: anticipi';
  Serbatoi[10].Applicazione:='RILPRE,MISTRA';

  Serbatoi[11].N:=1900;
  Serbatoi[11].M:=8;
  Serbatoi[11].X:=8;
  Serbatoi[11].Multiplo:=True;
  Serbatoi[11].Nome:='Voci paghe scaricate';
  Serbatoi[11].Applicazione:='RILPRE,STAGIU,MISTRA';

  Serbatoi[12].N:=300;
  Serbatoi[12].M:=9;
  Serbatoi[12].X:=9;
  Serbatoi[12].Multiplo:=True;
  Serbatoi[12].Nome:='Turni di reperibilità';
  Serbatoi[12].Applicazione:='RILPRE';

  Serbatoi[13].N:=1500;
  Serbatoi[13].M:=10;
  Serbatoi[13].X:=10;
  Serbatoi[13].Multiplo:=True;
  Serbatoi[13].Nome:='Corsi di formazione';
  Serbatoi[13].Applicazione:='STAGIU';

  Serbatoi[14].N:=1000;
  Serbatoi[14].M:=11;
  Serbatoi[14].X:=11;
  Serbatoi[14].Multiplo:=True;
  Serbatoi[14].Nome:='Iscrizioni sindacali';
  Serbatoi[14].Applicazione:='RILPRE';

  Serbatoi[15].N:=1100;
  Serbatoi[15].M:=12;
  Serbatoi[15].X:=12;
  Serbatoi[15].Multiplo:=True;
  Serbatoi[15].Nome:='Organismi sindacali';
  Serbatoi[15].Applicazione:='RILPRE';

  Serbatoi[16].N:=1200;
  Serbatoi[16].M:=13;
  Serbatoi[16].X:=13;
  Serbatoi[16].Multiplo:=True;
  Serbatoi[16].Nome:='Permessi sindacali';
  Serbatoi[16].Applicazione:='RILPRE';

  Serbatoi[17].N:=2000;
  Serbatoi[17].M:=15;
  Serbatoi[17].X:=15;
  Serbatoi[17].Multiplo:=True;
  Serbatoi[17].Nome:='Incentivi';
  Serbatoi[17].Applicazione:='RILPRE';

  Serbatoi[18].N:=2200;
  Serbatoi[18].M:=17;
  Serbatoi[18].X:=17;
  Serbatoi[18].Multiplo:=True;
  Serbatoi[18].Nome:='Rischi/Prescrizioni';
  Serbatoi[18].Applicazione:='STAGIU';

  Serbatoi[19].N:=2300;
  Serbatoi[19].M:=18;
  Serbatoi[19].X:=18;
  Serbatoi[19].Multiplo:=True;
  Serbatoi[19].Nome:='Incarichi';
  Serbatoi[19].Applicazione:='STAGIU';

  Serbatoi[20].N:=2700;
  Serbatoi[20].M:=23;
  Serbatoi[20].X:=23;
  Serbatoi[20].Multiplo:=True;
  Serbatoi[20].Nome:='Inc.: verifiche indennità';
  Serbatoi[20].Applicazione:='STAGIU';

  Serbatoi[21].N:=2400;
  Serbatoi[21].M:=19;
  Serbatoi[21].X:=19;
  Serbatoi[21].Multiplo:=True;
  Serbatoi[21].Nome:='Messaggi per WEB';
  Serbatoi[21].Applicazione:='RILPRE';

  Serbatoi[22].N:=2430;
  Serbatoi[22].M:=20;
  Serbatoi[22].X:=20;
  Serbatoi[22].Multiplo:=True;
  Serbatoi[22].Nome:='Iter autorizzativi da WEB';
  Serbatoi[22].Applicazione:='RILPRE';

  Serbatoi[23].N:=2500;
  Serbatoi[23].M:=21;
  Serbatoi[23].X:=21;
  Serbatoi[23].Multiplo:=True;
  Serbatoi[23].Nome:='Carta dei servizi';
  Serbatoi[23].Applicazione:='RILPRE';

  Serbatoi[24].N:=2600;
  Serbatoi[24].M:=22;
  Serbatoi[24].X:=22;
  Serbatoi[24].Multiplo:=True;
  Serbatoi[24].Nome:='Valutazioni';
  Serbatoi[24].Applicazione:='RILPRE,STAGIU';

  Serbatoi[25].N:=2800;
  Serbatoi[25].M:=25;
  Serbatoi[25].X:=25;
  Serbatoi[25].Multiplo:=True;
  Serbatoi[25].Nome:='Iter autorizzativi WEB';
  Serbatoi[25].Applicazione:='RILPRE';

  Serbatoi[26].N:=2900;
  Serbatoi[26].M:=26;
  Serbatoi[26].X:=26;
  Serbatoi[26].Multiplo:=True;
  Serbatoi[26].Nome:='Indennità di funzione';
  Serbatoi[26].Applicazione:=IfThen(Parametri.CampiRiferimento.C3_Indennita_Funzione <> '','RILPRE','NESSUNO');
end;

procedure TA077FGeneratoreStampeMW.CaricaTabelleCollegate;
var
  i: Integer;
begin
  //Descrizione delle tabelle collegate
  SetLength(TabelleCollegate,26);
  for i:=0 to High(TabelleCollegate) do
  begin
    TabelleCollegate[i].Esiste:=False;
    TabelleCollegate[i].Totalizzato:=False;
    TabelleCollegate[i].DaTotalizzare:=True;
    TabelleCollegate[i].Ordinato:=True;
    TabelleCollegate[i].Data[2]:='';
    TabelleCollegate[i].DatiDalAl:='';
    TabelleCollegate[i].InsDaSelect:=False;
  end;
  //Ind.Presenza
  TabelleCollegate[0].M:=1;
  TabelleCollegate[0].NomeKey:='T920_KEY1';
  TabelleCollegate[0].KeyTotale:='T920_KEYTOT1';
  TabelleCollegate[0].Join:='T0.PROGRESSIVO = PROGRESSIVO1(+)';
  TabelleCollegate[0].Progressivo:='PROGRESSIVO1';
  TabelleCollegate[0].Data[1]:='DATAINDPRESENZA';
  TabelleCollegate[0].DettaglioPeriodico:='M';
  TabelleCollegate[0].DatiNecessari:='DATAINDPRESENZA';
  TabelleCollegate[0].OQIns:=Ins920_1;
  //Causali di presenza
  TabelleCollegate[1].M:=2;
  TabelleCollegate[1].NomeKey:='T920_KEY2';
  TabelleCollegate[1].KeyTotale:='T920_KEYTOT2';
  TabelleCollegate[1].Join:='T0.PROGRESSIVO = PROGRESSIVO2(+)';
  TabelleCollegate[1].Progressivo:='PROGRESSIVO2';
  TabelleCollegate[1].Data[1]:='DATARIEPILOGOPRES';
  TabelleCollegate[1].DettaglioPeriodico:='M';
  TabelleCollegate[1].DatiNecessari:='DATARIEPILOGOPRES';
  TabelleCollegate[1].OQIns:=Ins920_2;
    //Causali di assenza
  TabelleCollegate[2].M:=3;
  TabelleCollegate[2].NomeKey:='T920_KEY3';
  TabelleCollegate[2].KeyTotale:='T920_KEYTOT3';
  TabelleCollegate[2].Join:='T0.PROGRESSIVO = PROGRESSIVO3(+)';
  TabelleCollegate[2].Progressivo:='PROGRESSIVO3';
  TabelleCollegate[2].Data[1]:='DATARIEPILOGOASS';
  TabelleCollegate[2].DettaglioPeriodico:='G';
  TabelleCollegate[2].DatiNecessari:='DATARIEPILOGOASS,MISURAASSENZE';
  TabelleCollegate[2].OQIns:=Ins920_3;
    //Dati giornalieri
  TabelleCollegate[3].M:=4;
  TabelleCollegate[3].NomeKey:='T920_KEY4';
  TabelleCollegate[3].KeyTotale:='T920_KEYTOT4';
  TabelleCollegate[3].Join:='T0.PROGRESSIVO = PROGRESSIVO4(+) AND T4.DATACONTEGGIO(+) BETWEEN T0.T430DATADECORRENZA AND T0.T430DATAFINE';
  TabelleCollegate[3].Progressivo:='PROGRESSIVO4';
  TabelleCollegate[3].Data[1]:='DATACONTEGGIO';
  TabelleCollegate[3].DettaglioPeriodico:='G';
  TabelleCollegate[3].DatiNecessari:='DATACONTEGGIO';
  TabelleCollegate[3].OQIns:=Ins920_4;
    //Dati mensili
  TabelleCollegate[4].M:=5;
  TabelleCollegate[4].NomeKey:='T920_KEY5';
  TabelleCollegate[4].KeyTotale:='T920_KEYTOT5';
  TabelleCollegate[4].Join:='T0.PROGRESSIVO = PROGRESSIVO5(+)';
  TabelleCollegate[4].Progressivo:='PROGRESSIVO5';
  TabelleCollegate[4].Data[1]:='DATARIEPILOGOMENSILE';
  TabelleCollegate[4].DettaglioPeriodico:='M';
  TabelleCollegate[4].DatiNecessari:='DATARIEPILOGOMENSILE';
  TabelleCollegate[4].OQIns:=Ins920_5;
    //Missioni/Trasferte
  TabelleCollegate[5].M:=6;
  TabelleCollegate[5].NomeKey:='T920_KEY6';
  TabelleCollegate[5].KeyTotale:='T920_KEYTOT6';
  TabelleCollegate[5].Join:='T0.PROGRESSIVO = PROGRESSIVO6(+)';
  TabelleCollegate[5].Progressivo:='PROGRESSIVO6';
  TabelleCollegate[5].Data[1]:='MT_MESESCARICO';
  TabelleCollegate[5].DettaglioPeriodico:='M';
  TabelleCollegate[5].DatiNecessari:='MT_MESESCARICO';
  TabelleCollegate[5].DatiDalAl:='MT_MESESCARICO,MT_MESECOMPETENZA,MT_DADATA';
  TabelleCollegate[5].OQIns:=Ins920_6;
    //Missioni:Rimborsi
  TabelleCollegate[6].M:=7;
  TabelleCollegate[6].NomeKey:='T920_KEY7';
  TabelleCollegate[6].KeyTotale:='T920_KEYTOT7';
  TabelleCollegate[6].Join:='T0.PROGRESSIVO = PROGRESSIVO7(+)';
  TabelleCollegate[6].Progressivo:='PROGRESSIVO7';
  TabelleCollegate[6].Data[1]:='MR_MESESCARICO';
  TabelleCollegate[6].DettaglioPeriodico:='M';
  TabelleCollegate[6].DatiNecessari:='MR_MESESCARICO';
  TabelleCollegate[6].DatiDalAl:='MR_MESESCARICO,MR_MESECOMPETENZA,MR_DADATA';
  TabelleCollegate[6].OQIns:=Ins920_7;
    //Voci paghe scaricate
  TabelleCollegate[7].M:=8;
  TabelleCollegate[7].NomeKey:='T920_KEY8';
  TabelleCollegate[7].KeyTotale:='T920_KEYTOT8';
  TabelleCollegate[7].Join:='T0.PROGRESSIVO = PROGRESSIVO8(+)';
  TabelleCollegate[7].Progressivo:='PROGRESSIVO8';
  TabelleCollegate[7].Data[1]:='VP_MESECOMPETENZA';
  TabelleCollegate[7].DettaglioPeriodico:='M';
  TabelleCollegate[7].DatiNecessari:='VP_MESECOMPETENZA,VP_MISURA';
  TabelleCollegate[7].OQIns:=Ins920_8;
    //Turni di reperibilità
  TabelleCollegate[8].M:=9;
  TabelleCollegate[8].NomeKey:='T920_KEY9';
  TabelleCollegate[8].KeyTotale:='T920_KEYTOT9';
  TabelleCollegate[8].Join:='T0.PROGRESSIVO = PROGRESSIVO9(+)';
  TabelleCollegate[8].Progressivo:='PROGRESSIVO9';
  TabelleCollegate[8].Data[1]:='IR_DATA';
  TabelleCollegate[8].DettaglioPeriodico:='M';
  TabelleCollegate[8].DatiNecessari:='IR_DATA';
  TabelleCollegate[8].OQIns:=Ins920_9;
    //Corsi di formazione
  TabelleCollegate[9].M:=10;
  TabelleCollegate[9].NomeKey:='T920_KEY10';
  TabelleCollegate[9].KeyTotale:='T920_KEYTOT10';
  TabelleCollegate[9].Join:='T0.PROGRESSIVO = PROGRESSIVO10(+)';
  TabelleCollegate[9].Progressivo:='PROGRESSIVO10';
  TabelleCollegate[9].Data[1]:='CF_DATA_PARTECIPAZIONE';
  TabelleCollegate[9].DettaglioPeriodico:='G';
  TabelleCollegate[9].DatiNecessari:='CF_DATA_PARTECIPAZIONE';
  TabelleCollegate[9].OQIns:=Ins920_10;
    //Iscrizioni ai sindacati (organizzazioni sindacali)
  TabelleCollegate[10].M:=11;
  TabelleCollegate[10].NomeKey:='T920_KEY11';
  TabelleCollegate[10].KeyTotale:='T920_KEYTOT11';
  TabelleCollegate[10].Join:='T0.PROGRESSIVO = PROGRESSIVO11(+)';
  TabelleCollegate[10].Progressivo:='PROGRESSIVO11';
  TabelleCollegate[10].Data[1]:='IS_DATA_ISCRIZIONE';
  TabelleCollegate[10].DettaglioPeriodico:='G';
  TabelleCollegate[10].DatiNecessari:='IS_DATA_ISCRIZIONE';
  TabelleCollegate[10].OQIns:=Ins920_11;
    //Organismi sindacali
  TabelleCollegate[11].M:=12;
  TabelleCollegate[11].NomeKey:='T920_KEY12';
  TabelleCollegate[11].KeyTotale:='T920_KEYTOT12';
  TabelleCollegate[11].Join:='T0.PROGRESSIVO = PROGRESSIVO12(+)';
  TabelleCollegate[11].Progressivo:='PROGRESSIVO12';
  TabelleCollegate[11].Data[1]:='OS_DATA_INIZIO';
  TabelleCollegate[11].DettaglioPeriodico:='G';
  TabelleCollegate[11].DatiNecessari:='OS_DATA_INIZIO';
  TabelleCollegate[11].OQIns:=Ins920_12;
    //Permessi sindacali
  TabelleCollegate[12].M:=13;
  TabelleCollegate[12].NomeKey:='T920_KEY13';
  TabelleCollegate[12].KeyTotale:='T920_KEYTOT13';
  TabelleCollegate[12].Join:='T0.PROGRESSIVO = PROGRESSIVO13(+)';
  TabelleCollegate[12].Progressivo:='PROGRESSIVO13';
  TabelleCollegate[12].Data[1]:='PS_DATA';
  TabelleCollegate[12].DettaglioPeriodico:='G';
  TabelleCollegate[12].DatiNecessari:='PS_DATA';
  TabelleCollegate[12].OQIns:=Ins920_13;
    //Missioni: indennità km
  TabelleCollegate[13].M:=14;
  TabelleCollegate[13].NomeKey:='T920_KEY14';
  TabelleCollegate[13].KeyTotale:='T920_KEYTOT14';
  TabelleCollegate[13].Join:='T0.PROGRESSIVO = PROGRESSIVO14(+)';
  TabelleCollegate[13].Progressivo:='PROGRESSIVO14';
  TabelleCollegate[13].Data[1]:='MK_MESESCARICO';
  TabelleCollegate[13].DettaglioPeriodico:='M';
  TabelleCollegate[13].DatiNecessari:='MK_MESESCARICO';
  TabelleCollegate[13].DatiDalAl:='MK_MESESCARICO,MK_MESECOMPETENZA,MK_DADATA';
  TabelleCollegate[13].OQIns:=Ins920_14;
    //Incentivi
  TabelleCollegate[14].M:=15;
  TabelleCollegate[14].NomeKey:='T920_KEY15';
  TabelleCollegate[14].KeyTotale:='T920_KEYTOT15';
  TabelleCollegate[14].Join:='T0.PROGRESSIVO = PROGRESSIVO15(+)';
  TabelleCollegate[14].Progressivo:='PROGRESSIVO15';
  TabelleCollegate[14].Data[1]:='QI_DATA';
  TabelleCollegate[14].DettaglioPeriodico:='M';
  TabelleCollegate[14].DatiNecessari:='QI_DATA';
  TabelleCollegate[14].OQIns:=Ins920_15;
    //Missioni: Anticipi
  TabelleCollegate[15].M:=16;
  TabelleCollegate[15].NomeKey:='T920_KEY16';
  TabelleCollegate[15].KeyTotale:='T920_KEYTOT16';
  TabelleCollegate[15].Join:='T0.PROGRESSIVO = PROGRESSIVO16(+)';
  TabelleCollegate[15].Progressivo:='PROGRESSIVO16';
  TabelleCollegate[15].Data[1]:='MA_DATAMISSIONE';
  TabelleCollegate[15].DettaglioPeriodico:='G';
  TabelleCollegate[15].DatiNecessari:='MA_DATAMISSIONE';
  TabelleCollegate[15].OQIns:=Ins920_16;
    //Rischi/Prescrizioni
  TabelleCollegate[16].M:=17;
  TabelleCollegate[16].NomeKey:='T920_KEY17';
  TabelleCollegate[16].KeyTotale:='T920_KEYTOT17';
  TabelleCollegate[16].Join:='T0.PROGRESSIVO = PROGRESSIVO17(+)';
  TabelleCollegate[16].Progressivo:='PROGRESSIVO17';
  TabelleCollegate[16].Data[1]:='RP_DATA_PERIODO';
  TabelleCollegate[16].DettaglioPeriodico:='G';
  TabelleCollegate[16].DatiNecessari:='RP_DATA_PERIODO';
  TabelleCollegate[16].OQIns:=Ins920_17;
    //Incarichi
  TabelleCollegate[17].M:=18;
  TabelleCollegate[17].NomeKey:='T920_KEY18';
  TabelleCollegate[17].KeyTotale:='T920_KEYTOT18';
  TabelleCollegate[17].Join:='T0.PROGRESSIVO = PROGRESSIVO18(+)';
  TabelleCollegate[17].Progressivo:='PROGRESSIVO18';
  TabelleCollegate[17].Data[1]:='IN_DATA_AFFIDAMENTO';
  TabelleCollegate[17].Data[2]:='IN_DATA_SCADENZA';
  TabelleCollegate[17].DettaglioPeriodico:='G';
  TabelleCollegate[17].DatiNecessari:='IN_DATA_AFFIDAMENTO,IN_DATA_SCADENZA';
  TabelleCollegate[17].OQIns:=Ins920_18;
    //Messaggi per il WEB
  TabelleCollegate[18].M:=19;
  TabelleCollegate[18].NomeKey:='T920_KEY19';
  TabelleCollegate[18].KeyTotale:='T920_KEYTOT19';
  TabelleCollegate[18].Join:='T0.PROGRESSIVO = PROGRESSIVO19(+)';
  TabelleCollegate[18].Progressivo:='PROGRESSIVO19';
  TabelleCollegate[18].Data[1]:='MW_DATA';
  TabelleCollegate[18].DettaglioPeriodico:='G';
  TabelleCollegate[18].DatiNecessari:='MW_DATA';
  TabelleCollegate[18].OQIns:=Ins920_19;
    //Iter autorizzativi WEB
  TabelleCollegate[19].M:=20;
  TabelleCollegate[19].NomeKey:='T920_KEY20';
  TabelleCollegate[19].KeyTotale:='T920_KEYTOT20';
  TabelleCollegate[19].Join:='T0.PROGRESSIVO = PROGRESSIVO20(+)';
  TabelleCollegate[19].Progressivo:='PROGRESSIVO20';
  TabelleCollegate[19].Data[1]:='RW_DATA1';
  TabelleCollegate[19].Data[2]:='RW_DATA2';
  TabelleCollegate[19].DettaglioPeriodico:='G';
  TabelleCollegate[19].DatiNecessari:='RW_DATA1,RW_DATA2';
  TabelleCollegate[19].OQIns:=Ins920_20;
    //Carta dei servizi
  TabelleCollegate[20].M:=21;
  TabelleCollegate[20].NomeKey:='T920_KEY21';
  TabelleCollegate[20].KeyTotale:='T920_KEYTOT21';
  TabelleCollegate[20].Join:='T0.PROGRESSIVO = PROGRESSIVO21(+)';
  TabelleCollegate[20].Progressivo:='PROGRESSIVO21';
  TabelleCollegate[20].Data[1]:='CS_DATA';
  TabelleCollegate[20].DettaglioPeriodico:='G';
  TabelleCollegate[20].DatiNecessari:='CS_DATA';
  TabelleCollegate[20].OQIns:=Ins920_21;
    //Valutazioni
  TabelleCollegate[21].M:=22;
  TabelleCollegate[21].NomeKey:='T920_KEY22';
  TabelleCollegate[21].KeyTotale:='T920_KEYTOT22';
  TabelleCollegate[21].Join:='T0.PROGRESSIVO = PROGRESSIVO22(+)';
  TabelleCollegate[21].Progressivo:='PROGRESSIVO22';
  TabelleCollegate[21].Data[1]:='VA_DATA_VALUTAZIONE';
  TabelleCollegate[21].DettaglioPeriodico:='G';
  TabelleCollegate[21].DatiNecessari:='VA_DATA_VALUTAZIONE';
  TabelleCollegate[21].OQIns:=Ins920_22;
    //Inc.: verifiche indennità
  TabelleCollegate[22].M:=23;
  TabelleCollegate[22].NomeKey:='T920_KEY23';
  TabelleCollegate[22].KeyTotale:='T920_KEYTOT23';
  TabelleCollegate[22].Join:='T0.PROGRESSIVO = PROGRESSIVO23(+)';
  TabelleCollegate[22].Progressivo:='PROGRESSIVO23';
  TabelleCollegate[22].Data[1]:='IV_DATA_VERIFICA';
  TabelleCollegate[22].DettaglioPeriodico:='G';
  TabelleCollegate[22].DatiNecessari:='IV_DATA_VERIFICA,IV_COD_TIPO_VERIFICA';
  TabelleCollegate[22].OQIns:=Ins920_23;
    //Inc.: verifiche indennità
  TabelleCollegate[23].M:=24;
  TabelleCollegate[23].NomeKey:='T920_KEY24';
  TabelleCollegate[23].KeyTotale:='T920_KEYTOT24';
  TabelleCollegate[23].Join:='T0.PROGRESSIVO = PROGRESSIVO24(+)';
  TabelleCollegate[23].Progressivo:='PROGRESSIVO24';
  TabelleCollegate[23].Data[1]:='VAP_DATA_VARIAZIONE';
  TabelleCollegate[23].DettaglioPeriodico:='M';
  TabelleCollegate[23].DatiNecessari:='VAP_ANNO_COMPETENZA,VAP_DATA_VARIAZIONE';
  TabelleCollegate[23].OQIns:=Ins920_24;
    //Iter autorizzativi WEB
  TabelleCollegate[24].M:=25;
  TabelleCollegate[24].NomeKey:='T920_KEY25';
  TabelleCollegate[24].KeyTotale:='T920_KEYTOT25';
  TabelleCollegate[24].Join:='T0.PROGRESSIVO = PROGRESSIVO25(+)';
  TabelleCollegate[24].Progressivo:='PROGRESSIVO25';
  TabelleCollegate[24].Data[1]:='IA_DAL';
  TabelleCollegate[24].Data[2]:='IA_AL';
  TabelleCollegate[24].DettaglioPeriodico:='G';
  TabelleCollegate[24].DatiNecessari:='IA_DAL,IA_AL';
  TabelleCollegate[24].OQIns:=Ins920_25;
    //Indennità di funzione
  TabelleCollegate[25].M:=26;
  TabelleCollegate[25].NomeKey:='T920_KEY26';
  TabelleCollegate[25].KeyTotale:='T920_KEYTOT26';
  TabelleCollegate[25].Join:='T0.PROGRESSIVO = PROGRESSIVO26(+)';
  TabelleCollegate[25].Progressivo:='PROGRESSIVO26';
  TabelleCollegate[25].Data[1]:='IF_DATA';
  TabelleCollegate[25].DettaglioPeriodico:='G';
  TabelleCollegate[25].DatiNecessari:='IF_DATA';
  TabelleCollegate[25].OQIns:=Ins920_26;

  //Gestione campi data per individuare il periodo di validità del dato
  for i:=0 to High(TabelleCollegate) do
    if TabelleCollegate[i].Data[2] <> TabelleCollegate[i].Data[1] then
      TabelleCollegate[i].Data[2]:=TabelleCollegate[i].Data[1];
end;

procedure TA077FGeneratoreStampeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT162.Open;

    //Descrizione delle Variazioni di Formato
  SetLength(VariazioniFormato,14);
  VariazioniFormato[0].Dato:='ASSENZEDELMESE';
  VariazioniFormato[0].Colonna:='MISURAASSENZE';
  VariazioniFormato[0].Formati:='G=1,O=2';
  VariazioniFormato[1].Dato:='COMPASSANNOPREC';
  VariazioniFormato[1].Colonna:='MISURAASSENZE';
  VariazioniFormato[1].Formati:='G=1,O=2';
  VariazioniFormato[2].Dato:='COMPASSANNOCORR';
  VariazioniFormato[2].Colonna:='MISURAASSENZE';
  VariazioniFormato[2].Formati:='G=1,O=2';
  VariazioniFormato[3].Dato:='COMPASSTOTALI';
  VariazioniFormato[3].Colonna:='MISURAASSENZE';
  VariazioniFormato[3].Formati:='G=1,O=2';
  VariazioniFormato[4].Dato:='ASSFRUITEANNOPREC';
  VariazioniFormato[4].Colonna:='MISURAASSENZE';
  VariazioniFormato[4].Formati:='G=1,O=2';
  VariazioniFormato[5].Dato:='ASSFRUITEANNOCORR';
  VariazioniFormato[5].Colonna:='MISURAASSENZE';
  VariazioniFormato[5].Formati:='G=1,O=2';
  VariazioniFormato[6].Dato:='ASSENZEFRUITE';
  VariazioniFormato[6].Colonna:='MISURAASSENZE';
  VariazioniFormato[6].Formati:='G=1,O=2';
  VariazioniFormato[7].Dato:='ASSENZERESIDUEANNOPREC';
  VariazioniFormato[7].Colonna:='MISURAASSENZE';
  VariazioniFormato[7].Formati:='G=1,O=2';
  VariazioniFormato[8].Dato:='ASSENZERESIDUEANNOCORR';
  VariazioniFormato[8].Colonna:='MISURAASSENZE';
  VariazioniFormato[8].Formati:='G=1,O=2';
  VariazioniFormato[9].Dato:='ASSENZERESIDUE';
  VariazioniFormato[9].Colonna:='MISURAASSENZE';
  VariazioniFormato[9].Formati:='G=1,O=2';
  VariazioniFormato[10].Dato:='COMPETENZEPARZIALI';
  VariazioniFormato[10].Colonna:='MISURAASSENZE';
  VariazioniFormato[10].Formati:='G=1,O=2';
  VariazioniFormato[11].Dato:='RESIDUOPARZIALE';
  VariazioniFormato[11].Colonna:='MISURAASSENZE';
  VariazioniFormato[11].Formati:='G=1,O=2';
  VariazioniFormato[12].Dato:='COMPETENZEDELPERIODO';
  VariazioniFormato[12].Colonna:='MISURAASSENZE';
  VariazioniFormato[12].Formati:='G=1,O=2';
  VariazioniFormato[13].Dato:='VP_VALORE';
  VariazioniFormato[13].Colonna:='VP_MISURA';
  VariazioniFormato[13].Formati:='N=1,V=1,H=2';

  //Descrizione dei controlli associati alle opzioni avanzate
  SetLength(OpzioniAvanzate,3);
  OpzioniAvanzate[0].Opzione:='REC_SINDACATO_11';
  OpzioniAvanzate[1].Opzione:='REC_SINDACATO_12';
  OpzioniAvanzate[2].Opzione:='REC_SINDACATO_13';
end;

function TA077FGeneratoreStampeMW.getListAssenze: TStringList;
begin
  Result:=TStringList.Create;
  Q265.First;
  while not Q265.Eof do
  begin
    Result.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
    Q265.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListPresenze: TStringList;
begin
  Result:=TStringList.Create;
  Q275.First;
  while not Q275.Eof do
  begin
    Result.Add(Format('%-5s %s',[Q275.FieldByName('CODICE').AsString,Q275.FieldByName('DESCRIZIONE').AsString]));
    Q275.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListIndPresenza: TStringList;
begin
  Result:=TStringList.Create;
  selT162.First;
  while not selT162.Eof do
  begin
    Result.Add(Format('%-5s %s',[selT162.FieldByName('CODICE').AsString,selT162.FieldByName('DESCRIZIONE').AsString]));
    selT162.Next;
  end;
end;

function TA077FGeneratoreStampeMW.getListRimborsi: TStringList;
begin
  Result:=TStringList.Create;
  selM020.Open;
  while not selM020.Eof do
  begin
    Result.Add(Format('%-5s %s',[selM020.FieldByName('CODICE').AsString,selM020.FieldByName('DESCRIZIONE').AsString]));
    selM020.Next;
  end;
  selM020.Close;
end;

function TA077FGeneratoreStampeMW.getListVociPaghe: TStringList;
begin
  Result:=TStringList.Create;
  seldistT195.Open;
  while not seldistT195.Eof do
  begin
    Result.Add(Format('%-10s',[seldistT195.FieldByName('VOCEPAGHE').AsString]));
    seldistT195.Next;
  end;
  seldistT195.Close;
end;

function TA077FGeneratoreStampeMW.getListOrgSindacali: TStringList;
begin
  Result:=TStringList.Create;
  selT240.Open;
  while not selT240.Eof do
  begin
    Result.Add(Format('%-10s %s',[selT240.FieldByName('CODICE').AsString,selT240.FieldByName('DESCRIZIONE').AsString]));
    selT240.Next;
  end;
  selT240.Close;
end;

function TA077FGeneratoreStampeMW.getListCorsiFormazione(Tutto: Boolean; Anno: Integer): TStringList;
begin
  Result:=TStringList.Create;
  selSG650.Open;
  while not selSG650.Eof do
  begin
    if Tutto or (R180Anno(selSG650.FieldByName('DATA_INIZIO').AsDateTime) = Anno) then
      Result.Add(Format('%-20s %s',[selSG650.FieldByName('CODICE').AsString,selSG650.FieldByName('DESCRIZIONE').AsString]));
    selSG650.Next;
  end;
  selSG650.Close;
end;

function TA077FGeneratoreStampeMW.getListRecapitoSindacato: TStringList;
begin
  Result:=TStringList.Create;
  selT241.Open;
  while not selT241.Eof do
  begin
    Result.Add(selT241.FieldByName('RECAPITO').AsString);
    selT241.Next;
  end;
  selT241.Close;
end;

end.
