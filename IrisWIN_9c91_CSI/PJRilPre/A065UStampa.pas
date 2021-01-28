unit A065UStampa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils, Math,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt, ExtCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, R450;

type
  TProgMesi = record
    Mese: Integer;
    Prog: Integer;
  end;

  TA065FStampa = class(TR002FQRep)
    bndTestGruppi: TQRGroup;
    dlblCodGruppo: TQRDBText;
    lblGruppo: TQRLabel;
    lblDescGruppo: TQRLabel;
    lblTitoloBudget: TQRLabel;
    lblTitoloFruito: TQRLabel;
    lblTitoloResiduo: TQRLabel;
    bndDettMesi: TQRBand;
    dlblOreMese: TQRDBText;
    lblMese: TQRLabel;
    dlblOreFruitoMese: TQRDBText;
    dlblOreResiduoMese: TQRDBText;
    bndDettDipendenti: TQRSubDetail;
    lblBadge: TQRLabel;
    lblNominativo: TQRLabel;
    lblOreFruito: TQRLabel;
    lblF15: TQRLabel;
    bndTotMesi: TQRBand;
    lblTotSoldiMese: TQRLabel;
    bndTotGruppi: TQRBand;
    LTotRep: TQRLabel;
    lblTotOreFruitoGruppo: TQRLabel;
    lblTotSoldiGruppo: TQRLabel;
    lblTotOreResiduoGruppo: TQRLabel;
    lblTotOreGruppo: TQRLabel;
    lblTitoloTotMese: TQRLabel;
    lblTotOreFruitoMese: TQRLabel;
    lblSoldi: TQRLabel;
    lblTitoloMonetizzazione: TQRLabel;
    bndTestDipendenti: TQRBand;
    lblTitoloFruitoDip: TQRLabel;
    lblTitoloMonetizzazioneDip: TQRLabel;
    lblTitoloBadgeDip: TQRLabel;
    lblTitoloNominativoDip: TQRLabel;
    lblTitoloFascia15Dip: TQRLabel;
    lblTitoloFascia30Dip: TQRLabel;
    lblTitoloFascia50Dip: TQRLabel;
    lblF30: TQRLabel;
    lblF50: TQRLabel;
    lblOreFuoriBudget: TQRLabel;
    lblTotOreFuoriBudgetMese: TQRLabel;
    lblTotF15: TQRLabel;
    lblTotF30: TQRLabel;
    lblTotF50: TQRLabel;
    QRShape1: TQRShape;
    lblNumDip: TQRLabel;
    bndTotGenerale: TQRBand;
    LTotGenerale: TQRLabel;
    lblTotOreGenerale: TQRLabel;
    lblTotOreFruitoGenerale: TQRLabel;
    lblTotOreResiduoGenerale: TQRLabel;
    lblTotSoldiGenerale: TQRLabel;
    lblTitoloBudgetGenerale: TQRLabel;
    lblTitoloFruitoGenerale: TQRLabel;
    lblTitoloResiduoGenerale: TQRLabel;
    lblTitoloMonetizzazioneGenerale: TQRLabel;
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRepAfterPreview(Sender: TObject);
    procedure QRepAfterPrint(Sender: TObject);
    procedure bndTestGruppiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndDettMesiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTestDipendentiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndDettDipendentiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotMesiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotGruppiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure bndTotGeneraleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    TotOreGenerale,TotOreFruitoGenerale,TotOreResiduoGenerale:Integer;
    TotOreGruppo,TotOreFruitoGruppo,TotOreResiduoGruppo,TotOreFruitoMese,TotOreFB,TotOreF15,TotOreF30,TotOreF50:Integer;
    TotSoldiGenerale,TotSoldiGruppo,TotSoldiMese:Real;
    ThousandSepOri: Char;
    ProgMesi: array of TProgMesi;
  public
    { Public declarations }
    Anno,DaMese,AMese,Mese:Integer;
    R450DtM:TR450DtM1;
  end;

var
  A065FStampa: TA065FStampa;

implementation

uses A065UStampaBudgetDtM, A065UStampaBudget;

{$R *.dfm}

procedure TA065FStampa.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  ThousandSepOri:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator;
  if QRep.Exporting and (QRep.ExportFilter is TQRXLSFilter) then
      {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=#0;
  TotOreGenerale:=0;
  TotOreFruitoGenerale:=0;
  TotOreResiduoGenerale:=0;
  TotSoldiGenerale:=0;
end;

procedure TA065FStampa.bndTotGeneraleBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lblTotOreGenerale.Caption:=R180MinutiOre(TotOreGenerale);
  lblTotOreFruitoGenerale.Caption:=R180MinutiOre(TotOreFruitoGenerale);
  lblTotOreResiduoGenerale.Caption:=R180MinutiOre(TotOreResiduoGenerale);
  lblTotSoldiGenerale.Caption:='€' + Format('%10.2n',[TotSoldiGenerale]);
end;

procedure TA065FStampa.QRepAfterPreview(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA065FStampa.QRepAfterPrint(Sender: TObject);
begin
  if {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator = #0 then {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:=ThousandSepOri;
end;

procedure TA065FStampa.bndTestGruppiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var DataMin,DataMax,DataCorr:TDateTime;
  S:String;
begin
  with A065FStampaBudgetDtM do
    lblDescGruppo.Caption:=VarToStr(selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([cdsStampa.FieldByName('CODGRUPPO').AsString,A065FStampaBudget.dcmbTipo.KeyValue,cdsStampa.FieldByName('DECORRENZA').AsString]),'DESCRIZIONE'));
  TotOreGruppo:=0;
  TotOreFruitoGruppo:=0;
  TotOreResiduoGruppo:=0;
  TotSoldiGruppo:=0;
  if A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#' then
    with A065FStampaBudgetDtM do
    begin
      //Ad ogni fine mese tra la data inizio e la data fine estraggo la distinct dei dipendenti del filtro anagrafe
      SetLength(ProgMesi,0);
      DataMin:=StrToDateTime(cdsStampa.FieldByName('DECORRENZA').AsString);
      DataMax:=R180FineMese(EncodeDate(Anno,AMese,1));
      DataCorr:=DataMin;
      while DataCorr <= DataMax do
      begin
        with selaV430 do
        begin
          S:=StringReplace(QVistaOracle,
                           ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                           ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                           [rfIgnoreCase]);
          S:=StringReplace(S,
                           ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                           ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                           [rfIgnoreCase]);
          R180SetVariable(selaV430,'QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
          R180SetVariable(selaV430,'C700DATADAL',DataCorr);
          R180SetVariable(selaV430,'DATALAVORO',R180FineMese(DataCorr));
          R180SetVariable(selaV430,'FILTRO',VarToStr(selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([cdsStampa.FieldByName('CODGRUPPO').AsString,A065FStampaBudget.dcmbTipo.KeyValue,cdsStampa.FieldByName('DECORRENZA').AsString]),'FILTRO_ANAGRAFE')));
          Open;
          First;
          while not Eof do
          begin
            SetLength(ProgMesi,Length(ProgMesi) + 1);
            ProgMesi[High(ProgMesi)].Mese:=R180Mese(DataCorr);
            ProgMesi[High(ProgMesi)].Prog:=FieldByName('PROGRESSIVO').AsInteger;
            Next;
          end;
        end;
        DataCorr:=R180FineMese(DataCorr) + 1;
      end;
    end;
end;

procedure TA065FStampa.bndDettMesiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Mese:=A065FStampaBudgetDtM.cdsStampa.FieldByName('Mese').AsInteger;
  lblMese.Caption:=R180NomeMese(A065FStampaBudgetDtM.cdsStampa.FieldByName('MESE').AsInteger);
  if A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#' then
  begin
    // recupero i totali di gruppo
    if R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE').AsString) <> 0 then
      TotOreGruppo:=R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE').AsString) + TotOreFruitoGruppo;
    if R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString) <> 0 then
      TotOreFruitoGruppo:=R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString);
  end
  else
  begin
    // incremento i totali generali
    inc(TotOreGenerale,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE').AsString));
    inc(TotOreFruitoGenerale,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString));
    inc(TotOreResiduoGenerale,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_RESIDUO').AsString));
    // incremento i totali di gruppo
    inc(TotOreGruppo,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE').AsString));
    inc(TotOreFruitoGruppo,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString));
    inc(TotOreResiduoGruppo,R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_RESIDUO').AsString));
  end;
  // azzero totali di mese
  TotOreFruitoMese:=0;
  TotOreFB:=0;
  TotOreF15:=0;
  TotOreF30:=0;
  TotOreF50:=0;
  TotSoldiMese:=0;
  if R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_RESIDUO').AsString) <= 0 then
    dlblOreResiduoMese.Font.Style:=[fsBold]
  else
    dlblOreResiduoMese.Font.Style:=[];
  if A065FStampaBudget.chkDettaglioDipendenti.Checked
  and (R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString) <> 0) then
    with A065FStampaBudgetDtM do
    begin
      selbV430.Close;
      selbV430.SetVariable('QVISTAORACLE',QVistaOracle + #10#13 + QVistaInServizioPeriodica);
      selbV430.SetVariable('LIVELLO',IfThen(A065FStampaBudget.chkCostoInMoneta.Checked,',T430' + Parametri.CampiRiferimento.C2_Livello,''));
      selbV430.SetVariable('DATA_SCHEDA',EncodeDate(Anno,Mese,1));
      selbV430.SetVariable('C700DATADAL',EncodeDate(Anno,Mese,1));
      selbV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(Anno,Mese,1)));
      selbV430.SetVariable('FILTRO',VarToStr(selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([cdsStampa.FieldByName('CODGRUPPO').AsString,A065FStampaBudget.dcmbTipo.KeyValue,cdsStampa.FieldByName('DECORRENZA').AsString]),'FILTRO_ANAGRAFE')));
      selbV430.Open;
    end;
end;

procedure TA065FStampa.bndTestDipendentiBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString) <> 0;
end;

procedure TA065FStampa.bndDettDipendentiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var Tot,TotM,Fruito:Integer;
    MOld:String;
    Soldi:Real;
    AbbattiOre,ProgMeseTrov:Boolean;
    DataMin,DataMax,DataCorr:TDateTime;
    j,k:Integer;
    OreEccProg,OreLiqProg:Integer;
begin
  if R180OreMinutiExt(A065FStampaBudgetDtM.cdsStampa.FieldByName('ORE_FRUITO').AsString) <> 0 then
    with A065FStampaBudgetDtM do
    begin
      lblBadge.Caption:=selbV430.FieldByName('T430BADGE').AsString;
      lblNominativo.Caption:=selbV430.FieldByName('COGNOME').AsString + ' ' + selbV430.FieldByName('NOME').AsString;
      if A065FStampaBudget.chkCostoInMoneta.Checked then
      begin
        R180SetVariable(Q730,'LIVELLO',selbV430.FieldByName('T430' + Parametri.CampiRiferimento.C2_Livello).AsString);
        R180SetVariable(Q730,'DATA',R180FineMese(EncodeDate(Anno,Mese,1)));
        Q730.Open;
        Q730.First;
      end;
      lblF15.Caption:='';
      lblF30.Caption:='';
      lblF50.Caption:='';
      Tot:=0;
      TotM:=0;
      MOld:='';
      Soldi:=0;
      if (A065FStampaBudget.dcmbTipo.KeyValue = '#LIQ#')
      or (A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#') then
        inc(TotOreFB,selbV430.FieldByName('LIQ_FUORI_BUDGET').AsInteger);
      if (A065FStampaBudget.dcmbTipo.KeyValue = '#LIQ#')
      or (A065FStampaBudget.dcmbTipo.KeyValue = '#B.O#') then
      begin
        selT071.Close;
        selT071.SetVariable('PROGRESSIVO',selbV430.FieldByName('PROGRESSIVO').AsInteger);
        selT071.SetVariable('DATA',EncodeDate(Anno,A065FStampaBudgetDtM.cdsStampa.FieldByName('Mese').AsInteger,1));
        selT071.Open;
        while not selT071.Eof do
        begin
          if MOld <> selT071.FieldByName('MAGGIORAZIONE').AsString then
          begin
            if MOld = '15' then
            begin
              lblF15.Caption:=R180MInutiOre(TotM);
              TotOreF15:=TotOreF15 + TotM;
            end
            else if MOld = '30' then
            begin
              lblF30.Caption:=R180MInutiOre(TotM);
              TotOreF30:=TotOreF30 + TotM;
            end
            else if MOld = '50' then
            begin
              lblF50.Caption:=R180MInutiOre(TotM);
              TotOreF50:=TotOreF50 + TotM;
            end;
            MOld:=selT071.FieldByName('MAGGIORAZIONE').AsString;
            TotM:=0;
          end;
          if A065FStampaBudget.dcmbTipo.KeyValue = '#LIQ#' then
          begin
            Fruito:=R180OreMinutiExt(selT071.FieldByName('LIQUIDNELMESE').AsString);
            if A065FStampaBudget.chkCostoInMoneta.Checked and Q730.Locate('CAUSALE;MAGGIORAZIONE',VarArrayOf([A065FStampaBudget.dcmbTipo.KeyValue,StrToFloat(MOld)]),[]) then
              Soldi:=Soldi + StrToFloat(StringReplace(R180Centesimi(Fruito),'.',{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,[])) * Q730.FieldByName('TARIFFA_LIQ').AsFloat;
          end
          else
          begin
            Fruito:=R180OreMinutiExt(selT071.FieldByName('BANCA_ORE').AsString);
            if A065FStampaBudget.chkCostoInMoneta.Checked and Q730.Locate('CAUSALE;MAGGIORAZIONE',VarArrayOf([A065FStampaBudget.dcmbTipo.KeyValue,StrToFloat(MOld)]),[]) then
              Soldi:=Soldi + StrToFloat(StringReplace(R180Centesimi(Fruito),'.',{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,[])) * Q730.FieldByName('TARIFFA_MAT').AsFloat;
          end;
          TotOreFruitoMese:=TotOreFruitoMese + Fruito;
          TotM:=TotM + Fruito;
          Tot:=Tot + Fruito;
          selT071.Next;
        end;
      end
      else if (A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#') then
      begin
        //Per il dipendente, partendo dall'ultima decorrenza, prelevo le sue ore, eventualmente decurtate dei mesi precedenti fuori dal gruppo
        OreEccProg:=0;
        OreLiqProg:=0;
        AbbattiOre:=False;
        DataMin:=EncodeDate(Anno,1,1);
        DataMax:=R180FineMese(EncodeDate(Anno,cdsStampa.FieldByName('Mese').AsInteger,1));
        DataCorr:=DataMax;
        while DataCorr >= DataMin do
        begin
          ProgMeseTrov:=False;
          for j:=0 to High(ProgMesi) do
            if (ProgMesi[j].Mese = R180Mese(DataCorr))
            and (ProgMesi[j].Prog = selbV430.FieldByName('PROGRESSIVO').AsInteger) then
            begin
              ProgMeseTrov:=True;
              R450DtM.ConteggiMese('Generico',R180Anno(DataCorr),R180Mese(DataCorr),selbV430.FieldByName('PROGRESSIVO').AsInteger);
              if not AbbattiOre then
              begin
                OreEccProg:=OreEccProg + Max(0,R450DtM.salliqannoatt + R450DtM.salcompannoatt);
                //AbbattiOre:=OreEccProg > 0;
                AbbattiOre:=(OreEccProg > 0) or (R450DtM.ttrovscheda[R180Mese(DataCorr)] = 1);
              end;
              OreLiqProg:=OreLiqProg +
                          R180SommaArray(R450DtM.tLiqNelMese) + //straordinario liquidato nel mese: sempre positivo
                          R450DtM.L07.OreCompLiquidate; //banca ore liquidata nel mese: potrebbe essere negativo in caso di variazione
              for k:=0 to High(R450DtM.RiepPres) do
                if R450DtM.selT275.Lookup('CODICE',R450DtM.RiepPres[k].Causale,'ABBATTE_BUDGET') = 'L' then
                  OreLiqProg:=OreLiqProg + R180SommaArray(R450DtM.RiepPres[k].LiquidatoMese)
                else if R450DtM.selT275.Lookup('CODICE',R450DtM.RiepPres[k].Causale,'ABBATTE_BUDGET') = 'M' then
                  OreLiqProg:=OreLiqProg + R180SommaArray(R450DtM.RiepPres[k].OreReseMese);
              Break;
            end;
          if (not ProgMeseTrov)
          and AbbattiOre then
          begin
            R450DtM.ConteggiMese('Generico',R180Anno(DataCorr),R180Mese(DataCorr),selbV430.FieldByName('PROGRESSIVO').AsInteger);
            OreEccProg:=Max(0,OreEccProg - Max(0,R450DtM.salliqannoatt + R450DtM.salcompannoatt));
            AbbattiOre:=False;
          end;
          DataCorr:=R180InizioMese(DataCorr) - 1;
        end;
        Fruito:=Max(0,OreEccProg) + Max(0,OreLiqProg);
        TotOreFruitoMese:=TotOreFruitoMese + Fruito;
        Tot:=Tot + Fruito;
      end
      else
      begin
        selT074.Close;
        selT074.SetVariable('PROGRESSIVO',selbV430.FieldByName('PROGRESSIVO').AsInteger);
        selT074.SetVariable('DATA',EncodeDate(Anno,A065FStampaBudgetDtM.cdsStampa.FieldByName('Mese').AsInteger,1));
        selT074.SetVariable('CAUSALE',A065FStampaBudget.dcmbTipo.KeyValue);
        selT074.Open;
        while not selT074.Eof do
        begin
          if MOld <> selT074.FieldByName('MAGGIORAZIONE').AsString then
          begin
            if MOld = '15' then
            begin
              lblF15.Caption:=R180MInutiOre(TotM);
              TotOreF15:=TotOreF15 + TotM;
            end
            else if MOld = '30' then
            begin
              lblF30.Caption:=R180MInutiOre(TotM);
              TotOreF30:=TotOreF30 + TotM;
            end
            else if MOld = '50' then
            begin
              lblF50.Caption:=R180MInutiOre(TotM);
              TotOreF50:=TotOreF50 + TotM;
            end;
            MOld:=selT074.FieldByName('MAGGIORAZIONE').AsString;
            TotM:=0;
          end;
          Fruito:=R180OreMinutiExt(selT074.FieldByName('ORE').AsString);
          TotOreFruitoMese:=TotOreFruitoMese + Fruito;
          TotM:=TotM + Fruito;
          Tot:=Tot + Fruito;
          selT074.Next;
        end;
      end;
      if MOld = '15' then
      begin
        lblF15.Caption:=R180MInutiOre(TotM);
        TotOreF15:=TotOreF15 + TotM;
      end
      else if MOld = '30' then
      begin
        lblF30.Caption:=R180MInutiOre(TotM);
        TotOreF30:=TotOreF30 + TotM;
      end
      else if MOld = '50' then
      begin
        lblF50.Caption:=R180MInutiOre(TotM);
        TotOreF50:=TotOreF50 + TotM;
      end;
      lblOreFruito.Caption:=R180MinutiOre(Tot);
      if (   (A065FStampaBudget.dcmbTipo.KeyValue = '#LIQ#')
          or (A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#'))
      and (A065FStampaBudgetDtM.selbV430.FieldByName('LIQ_FUORI_BUDGET').AsInteger <> 0) then
        lblOreFuoriBudget.Caption:=Format('(%s)',[R180MinutiOre(A065FStampaBudgetDtM.selbV430.FieldByName('LIQ_FUORI_BUDGET').AsInteger)])
      else
        lblOreFuoriBudget.Caption:='';
      lblSoldi.Caption:='€' + Format('%10.2n',[Soldi]);
      TotSoldiMese:=TotSoldiMese + Soldi;//StrToFloat(Format('%10.2n',[Soldi]));
      TotSoldiGruppo:=TotSoldiGruppo + Soldi;//StrToFloat(Format('%10.2n',[Soldi]));
      TotSoldiGenerale:=TotSoldiGenerale + Soldi;//StrToFloat(Format('%10.2n',[Soldi]));
    end;
  PrintBand:=Tot > 0;
end;

procedure TA065FStampa.bndTotMesiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  lblTotOreFruitoMese.Caption:=R180MinutiOre(TotOreFruitoMese);
  if (   (A065FStampaBudget.dcmbTipo.KeyValue = '#LIQ#')
      or (A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#'))
  and (TotOreFB <> 0) then
    lblTotOreFuoriBudgetMese.Caption:=Format('(%s)',[R180MinutiOre(TotOreFB)])
  else
    lblTotOreFuoriBudgetMese.Caption:='';
  lblTotF15.Caption:=R180MinutiOre(TotOreF15);
  lblTotF30.Caption:=R180MinutiOre(TotOreF30);
  lblTotF50.Caption:=R180MinutiOre(TotOreF50);
  lblTotSoldiMese.Caption:='€' + Format('%10.2n',[TotSoldiMese]);
  PrintBand:=TotOreFruitoMese > 0;
end;

procedure TA065FStampa.bndTotGruppiBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var S:String;
  MaxOreGruppo:Integer;
begin
  with A065FStampaBudgetDtM do
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
    selaV430.SetVariable('C700DATADAL',EncodeDate(Anno,DaMese,1));
    selaV430.SetVariable('DATALAVORO',R180FineMese(EncodeDate(Anno,AMese,1)));
    selaV430.SetVariable('FILTRO',VarToStr(selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([cdsStampa.FieldByName('CODGRUPPO').AsString,A065FStampaBudget.dcmbTipo.KeyValue,cdsStampa.FieldByName('DECORRENZA').AsString]),'FILTRO_ANAGRAFE')));
    selaV430.Open;
    lblNumDip.Caption:='(N. Dip. ' + IntToStr(selaV430.RecordCount) + ')';
    MaxOreGruppo:=R180OreMinutiExt(VarToStr(selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([cdsStampa.FieldByName('CODGRUPPO').AsString,A065FStampaBudget.dcmbTipo.KeyValue,cdsStampa.FieldByName('DECORRENZA').AsString]),'ORE')));
  end;
  if A065FStampaBudget.dcmbTipo.KeyValue = '#ECC#' then
  begin
    TotOreGruppo:=IfThen(TotOreGruppo > MaxOreGruppo,MaxOreGruppo,TotOreGruppo);
    TotOreResiduoGruppo:=TotOreGruppo - TotOreFruitoGruppo;
    // incremento i totali generali
    inc(TotOreGenerale,TotOreGruppo);
    inc(TotOreFruitoGenerale,TotOreFruitoGruppo);
    inc(TotOreResiduoGenerale,TotOreResiduoGruppo);
  end;
  lblTotOreGruppo.Caption:=R180MinutiOre(TotOreGruppo);
  lblTotOreFruitoGruppo.Caption:=R180MinutiOre(TotOreFruitoGruppo);
  lblTotOreResiduoGruppo.Caption:=R180MinutiOre(TotOreResiduoGruppo);
  lblTotSoldiGruppo.Caption:='€' + Format('%10.2n',[TotSoldiGruppo]);
end;

end.
