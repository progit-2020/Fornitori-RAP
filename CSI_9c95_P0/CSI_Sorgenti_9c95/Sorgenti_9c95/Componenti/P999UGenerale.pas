unit P999UGenerale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Math, Variants, C180FUNZIONIGENERALI;


type
  TVF = record
    CodContratto:String;
    CodVoce:String;
    CodVoceSpeciale:String;
  end;

  TEccezioniElenco = record
    Codice:String;
    Descrizione:String;
  end;

  TQueryVoce = class(TOracleDataSet)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function GetVoce(CodContratto,CodVoce,CodVoceSpeciale:String; DataCassa,DataCompetenza:TDateTime):Boolean;
  published
    { Published declarations }
  end;

  TQueryCambio = class(TOracleQuery)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function CambioValuta(CodValuta1,CodValuta2:String;Decorrenza:TDateTime):Real;
  published
    { Published declarations }
  end;

  function P999FormattaValore(Valore,FormatoFile,Numerico,CodArrotFile:String;Arrot,Centesimi:Boolean):String;
  function P999ContrattoPresente(CodContratto,ElencoCodContratti:String):Boolean;
  function P999CreaElencoVoci(VoceFissa:TVF):String;

const
  //Lughezza campo quantità su cedolino
  LunCampoQuantita:Integer = 10;
  //Lughezza campo datobase su cedolino
  LunCampoDatoBase:Integer = 15;
  //Numero assegni familiari mensili
  NumeroAnfMensili = 26;
  //Voci stipendiali fisse
  VFPremioOperositaIRPEFTFR:TVF =
     (CodContratto:'''EDPSC'''; CodVoce:'01200'; CodVoceSpeciale:'BASE');
  VFArrotondamento:TVF =
     (CodContratto:''; CodVoce:'04990'; CodVoceSpeciale:'BASE');
  VFArrotondamentoPrecedente:TVF =
     (CodContratto:''; CodVoce:'04991'; CodVoceSpeciale:'BASE');
  VFAssegnoNucleoFamiliare:TVF =
     (CodContratto:''; CodVoce:'07000'; CodVoceSpeciale:'BASE');
  VFDetrazioniIRPEFTotali:TVF =
     (CodContratto:''; CodVoce:'10000'; CodVoceSpeciale:'BASE');
  VFBloccoDetrazioniIRPEF:TVF =
     (CodContratto:''; CodVoce:'10001'; CodVoceSpeciale:'BASE');
  VFDetrazioniIRPEFTotaliCong:TVF =
     (CodContratto:''; CodVoce:'10002'; CodVoceSpeciale:'CONG');
  VFBloccoDetrazioniIRPEFCong:TVF =
     (CodContratto:''; CodVoce:'10003'; CodVoceSpeciale:'CONG');
  VFImponibileTFSDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10040'; CodVoceSpeciale:'BASE');
  VFImponibileINPSEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10055'; CodVoceSpeciale:'BASE');
  VFImponibileINAILDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10060'; CodVoceSpeciale:'BASE');
  VFImponibileINAILEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10065'; CodVoceSpeciale:'BASE');
  VFImponibileTFRDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10070'; CodVoceSpeciale:'BASE');
  VFImponibileIRAPEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10100'; CodVoceSpeciale:'BASE');
  VFImponibileIRAPAssimEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10102'; CodVoceSpeciale:'BASE');
  VFImponibileIRPEF:TVF =
     (CodContratto:''; CodVoce:'10200'; CodVoceSpeciale:'BASE');
  VFDeduzioneIRPEFNoTax:TVF =
     (CodContratto:''; CodVoce:'10201'; CodVoceSpeciale:'BASE');
  VFDeduzioneIRPEFFam:TVF =
     (CodContratto:''; CodVoce:'10204'; CodVoceSpeciale:'BASE');
  VFDeduzioneIRPEFFPCDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10205'; CodVoceSpeciale:'BASE');
  VFDeduzioneIRPEFFPCEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10206'; CodVoceSpeciale:'BASE');
  VFImponibileIRPEFTassazioneSep:TVF =
     (CodContratto:''; CodVoce:'10220'; CodVoceSpeciale:'BASE');
  VFImponibileIRPEFPerTFR:TVF =
     (CodContratto:''; CodVoce:'10230'; CodVoceSpeciale:'BASE');
  VFImponibileIRPEFCong:TVF =
     (CodContratto:''; CodVoce:'10240'; CodVoceSpeciale:'CONG');
  VFDeduzioneIRPEFNoTaxCong:TVF =
     (CodContratto:''; CodVoce:'10241'; CodVoceSpeciale:'CONG');
  VFDeduzioneIRPEFNoTaxBaseCong:TVF =
     (CodContratto:''; CodVoce:'10242'; CodVoceSpeciale:'CONG');
  VFDeduzioneIRPEFFamCong:TVF =
     (CodContratto:''; CodVoce:'10244'; CodVoceSpeciale:'CONG');
  VFDeduzioneIRPEFFPCDipCong:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10245'; CodVoceSpeciale:'CONG');
  VFDeduzioneIRPEFFPCEnteCong:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10246'; CodVoceSpeciale:'CONG');
  VFImponibileAssicDetraibili:TVF =
     (CodContratto:''; CodVoce:'10402'; CodVoceSpeciale:'BASE');
  VFImponibileLegge1222010Art9C2:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'10510'; CodVoceSpeciale:'BASE');
  VFRitenutaCPDELDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11010'; CodVoceSpeciale:'BASE');
  VFRitenutaONAOSIDipPerc:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11030'; CodVoceSpeciale:'BASE');
  VFRitenutaONAOSIDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11035'; CodVoceSpeciale:'BASE');
  VFRitenutaINPSEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11055'; CodVoceSpeciale:'BASE');
  VFRitenutaINAILDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11060'; CodVoceSpeciale:'BASE');
  VFRitenutaINAILEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11065'; CodVoceSpeciale:'BASE');
  VFRitenutaINAILEnteQuotaAss:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11067'; CodVoceSpeciale:'BASE');
  VFRitenutaFPCDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11080'; CodVoceSpeciale:'BASE');
  VFQuotaIngressoFPCDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11082'; CodVoceSpeciale:'BASE');
  VFRitenutaFPCEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11085'; CodVoceSpeciale:'BASE');
  VFQuotaIngressoFPCEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11087'; CodVoceSpeciale:'BASE');
  VFRitenutaINPSIscrittiDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11160'; CodVoceSpeciale:'BASE');
  VFRitenutaINPSIscrittiEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11165'; CodVoceSpeciale:'BASE');
  VFRitenutaINPSReligDip:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11170'; CodVoceSpeciale:'BASE');
  VFRitenutaINPSReligEnte:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11175'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFLorda:TVF =
     (CodContratto:''; CodVoce:'11200'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFNetta:TVF =
     (CodContratto:''; CodVoce:'11210'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFTassazioneSep:TVF =
     (CodContratto:''; CodVoce:'11220'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFPerTFR:TVF =
     (CodContratto:''; CodVoce:'11230'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFLordaCong:TVF =
     (CodContratto:''; CodVoce:'11240'; CodVoceSpeciale:'CONG');
  VFAddizComunaleIRPEF:TVF =
     (CodContratto:''; CodVoce:'11250'; CodVoceSpeciale:'BASE');
  VFAddizComunaleIRPEFTotale:TVF =
     (CodContratto:''; CodVoce:'11252'; CodVoceSpeciale:'BASE');
  VFAddizComunaleAccIRPEF:TVF =
     (CodContratto:''; CodVoce:'11255'; CodVoceSpeciale:'BASE');
  VFAddizProvincialeIRPEF:TVF =
     (CodContratto:''; CodVoce:'11260'; CodVoceSpeciale:'BASE');
  VFAddizProvincialeIRPEFTotale:TVF =
     (CodContratto:''; CodVoce:'11262'; CodVoceSpeciale:'BASE');
  VFAddizProvincialeAccIRPEF:TVF =
     (CodContratto:''; CodVoce:'11265'; CodVoceSpeciale:'BASE');
  VFAddizRegionaleIRPEF:TVF =
     (CodContratto:''; CodVoce:'11270'; CodVoceSpeciale:'BASE');
  VFAddizRegionaleIRPEFTotale:TVF =
     (CodContratto:''; CodVoce:'11272'; CodVoceSpeciale:'BASE');
  VFAddizRegionaleAccIRPEF:TVF =
     (CodContratto:''; CodVoce:'11275'; CodVoceSpeciale:'BASE');
  VFRitenutaIRPEFAcconto:TVF =
     (CodContratto:''; CodVoce:'11500'; CodVoceSpeciale:'BASE');
  VFRiduzioneLegge122Del2010:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'11510'; CodVoceSpeciale:'BASE');
  VFContrSolidLegge148Del2011:TVF =
     (CodContratto:''; CodVoce:'11525'; CodVoceSpeciale:'BASE');
  VFTotaleCompetenze:TVF =
     (CodContratto:''; CodVoce:'12940'; CodVoceSpeciale:'BASE');
  VFTotaleRitenute:TVF =
     (CodContratto:''; CodVoce:'12960'; CodVoceSpeciale:'BASE');
  VFTotaleNettoAPagare:TVF =
     (CodContratto:''; CodVoce:'12990'; CodVoceSpeciale:'BASE');
  VFTotaleNettoAPagareValuta:TVF =
     (CodContratto:''; CodVoce:'12991'; CodVoceSpeciale:'BASE');
  VFTakeHome:TVF =
     (CodContratto:''; CodVoce:'12995'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerLavDipAltriRedd:TVF =
     (CodContratto:''; CodVoce:'13010'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerLavDipAltriReddCong:TVF =
     (CodContratto:''; CodVoce:'13012'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerConiugeCarico:TVF =
     (CodContratto:''; CodVoce:'13020'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerConiugeCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13022'; CodVoceSpeciale:'CONG');
  VFDeduzioniPerConiugeCarico:TVF =
     (CodContratto:''; CodVoce:'13024'; CodVoceSpeciale:'BASE');
  VFDeduzioniPerConiugeCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13025'; CodVoceSpeciale:'CONG');
  VFDeduzioniPerFigliCarico:TVF =
     (CodContratto:''; CodVoce:'13034'; CodVoceSpeciale:'BASE');
  VFDeduzioniPerFigliCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13035'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFiglio1Carico:TVF =
     (CodContratto:''; CodVoce:'13040'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerFiglio1CaricoCong:TVF =
     (CodContratto:''; CodVoce:'13042'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFigliSuccCarico:TVF =
     (CodContratto:''; CodVoce:'13050'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerFigliSuccCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13052'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFigli3Carico:TVF =
     (CodContratto:''; CodVoce:'13060'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerFigli3CaricoCong:TVF =
     (CodContratto:''; CodVoce:'13062'; CodVoceSpeciale:'CONG');
  VFDeduzioniPerFigli3Carico:TVF =
     (CodContratto:''; CodVoce:'13064'; CodVoceSpeciale:'BASE');
  VFDeduzioniPerFigli3CaricoCong:TVF =
     (CodContratto:''; CodVoce:'13065'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerAltriFamiliariCarico:TVF =
     (CodContratto:''; CodVoce:'13070'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerAltriFamiliariCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13072'; CodVoceSpeciale:'CONG');
  VFDeduzioniPerAltriFamiliariCarico:TVF =
     (CodContratto:''; CodVoce:'13074'; CodVoceSpeciale:'BASE');
  VFDeduzioniPerAltriFamiliariCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13075'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFigliAgevCarico:TVF =
     (CodContratto:''; CodVoce:'13080'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerFigliAgevCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13082'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerOneriCong:TVF =
     (CodContratto:''; CodVoce:'13090'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFigliHandCarico:TVF =
     (CodContratto:''; CodVoce:'13100'; CodVoceSpeciale:'BASE');
  VFDetrazioniPerFigliHandCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13102'; CodVoceSpeciale:'CONG');
  VFDeduzioniPerFigliHandCarico:TVF =
     (CodContratto:''; CodVoce:'13104'; CodVoceSpeciale:'BASE');
  VFDeduzioniPerFigliHandCaricoCong:TVF =
     (CodContratto:''; CodVoce:'13105'; CodVoceSpeciale:'CONG');
  VFDetrazioniRedditiMinIndetCong:TVF =
     (CodContratto:''; CodVoce:'13112'; CodVoceSpeciale:'CONG');
  VFDetrazioniRedditiMinDetCong:TVF =
     (CodContratto:''; CodVoce:'13122'; CodVoceSpeciale:'CONG');
  VFDetrazioniProgrImposiz:TVF =
     (CodContratto:''; CodVoce:'13130'; CodVoceSpeciale:'BASE');
  VFDetrazioniProgrImposizCong:TVF =
     (CodContratto:''; CodVoce:'13132'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFamNumerose:TVF =
     (CodContratto:''; CodVoce:'13150'; CodVoceSpeciale:'BASE');
  VFCreditoRiconosPerFamNumerose:TVF =
     (CodContratto:''; CodVoce:'13151'; CodVoceSpeciale:'BASE');
  VFCreditoAggRiconosPerFamNumeroseMeseCong:TVF =
     (CodContratto:''; CodVoce:'13151'; CodVoceSpeciale:'CONG');
  VFDetrazioniPerFamNumeroseCong:TVF =
     (CodContratto:''; CodVoce:'13152'; CodVoceSpeciale:'CONG');
  VFCreditoRiconosPerFamNumeroseCong:TVF =
     (CodContratto:''; CodVoce:'13154'; CodVoceSpeciale:'CONG');
  VFBonusRiduzCuneoFiscale:TVF =
     (CodContratto:''; CodVoce:'13160'; CodVoceSpeciale:'BASE');
  VFBonusRiduzCuneoFiscaleCong:TVF =
     (CodContratto:''; CodVoce:'13162'; CodVoceSpeciale:'CONG');
  VFRedditiAssimilatiNoDetrazioni:TVF =
     (CodContratto:''; CodVoce:'14010'; CodVoceSpeciale:'BASE');
  VFRetribuzioniFisse:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'14100'; CodVoceSpeciale:'BASE');
  VFRetribuzioniAccessorie:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'14110'; CodVoceSpeciale:'BASE');
  VFRetribuzioniFiniTFR:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'14120'; CodVoceSpeciale:'BASE');
  VFCompetenzeCorrentiINPS:TVF =
     (CodContratto:'''EDP'',''EDPEL'''; CodVoce:'14200'; CodVoceSpeciale:'BASE');
  EccezioniElenco:array [1..4] of TEccezioniElenco =
    (
      (Codice:'a';Descrizione:'IRPEF a tassazione separata'),
      (Codice:'b';Descrizione:'Imputazione di competenza con aliquote di cassa - solo D.M.A.'),
      (Codice:'c';Descrizione:'IRPEF per TFR'),
      (Codice:'d';Descrizione:'Esclusione assoggettamenti su arretrati/sindacali')
    );

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TQueryVoce]);
end;

constructor TQueryVoce.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  SQL.Add('SELECT ID_VOCE,DECORRENZA,TIPO,CASSA_COMPETENZA,ONERI_DETRAZIONI,CUMULO_IN_CALCOLO,');
  SQL.Add('ECCEZIONI_SENSIBILI,IMPORTO,IMPORTO_COLONNA,RIDOTTA_PARTTIME_VERT,RIDOTTA_PARTTIME_ORIZZ,RID_MESE_ASS_CESS,');
  SQL.Add('DESCRIZIONE,VOCE_QUANTITA,COD_MISURAQUANTITA,RITENUTA_MASSIMALI_SCAGLIONI,RITENUTA_PERC,');
  SQL.Add('NO_CEDOLINO_NORMALE,FORZA_GGCALCOLO_QUOTE,IMPORTO_AUTOMATICO,IMPORTO_AUTOMATICO_TIPO,PROGRAMMATA,IMPORTO_MASSIMO');
  SQL.Add(' FROM P200_VOCI T1 WHERE');
  SQL.Add('COD_CONTRATTO = :Cod_Contratto AND');
  SQL.Add('COD_VOCE = :Cod_Voce AND');
  SQL.Add('COD_VOCE_SPECIALE = :Cod_Voce_Speciale AND');
  SQL.Add('DECORRENZA = (');
  SQL.Add('SELECT MAX(DECORRENZA) FROM P200_VOCI');
  SQL.Add('WHERE ((DECORRENZA <= :DataCassa AND CASSA_COMPETENZA IN (''CS'',''CC'')) OR');
  SQL.Add('(DECORRENZA <= :DataCompetenza AND CASSA_COMPETENZA = ''CM'')) AND');
  SQL.Add('COD_CONTRATTO = T1.COD_CONTRATTO AND');
  SQL.Add('COD_VOCE = T1.COD_VOCE AND');
  SQL.Add('COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE)');
  DeclareVariable('Cod_Contratto',otString);
  DeclareVariable('Cod_Voce',otString);
  DeclareVariable('Cod_Voce_Speciale',otString);
  DeclareVariable('DataCassa',otDate);
  DeclareVariable('DataCompetenza',otDate);
end;

function TQueryVoce.GetVoce(CodContratto,CodVoce,CodVoceSpeciale:String; DataCassa,DataCompetenza:TDateTime):Boolean;
begin
  if (GetVariable('Cod_Contratto') <> CodContratto) or
     (GetVariable('Cod_Voce') <> CodVoce) or
     (GetVariable('Cod_Voce_Speciale') <> CodVoceSpeciale) or
     (GetVariable('DataCassa') <> DataCassa) or
     (GetVariable('DataCompetenza') <> DataCompetenza) then
  begin
    SetVariable('Cod_Contratto',CodContratto);
    SetVariable('Cod_Voce',CodVoce);
    SetVariable('Cod_Voce_Speciale',CodVoceSpeciale);
    SetVariable('DataCassa',DataCassa);
    SetVariable('DataCompetenza',DataCompetenza);
    Close;
    Open;
  end;
  Result:=not Eof;
end;

destructor TQueryVoce.Destroy;
begin
  Close;
  inherited Destroy;
end;

function P999FormattaValore(Valore,FormatoFile,Numerico,CodArrotFile:String;Arrot,Centesimi:Boolean):String;
//Formatta i valori in base a quanto previsto dal FORMATO_FILE per esportazione del mod. 770 su file
var
  rLung:Integer;
  sNumZeri:String;
  iNumDec,iMaxDec:Integer;
begin
  Result:=Valore;
  //Se il valore è più lungo di 16 crt.(lunghezza massima) formatto il campo come stringa e spazi a
  //sinistra per una lunghezza pari al primo multiplo di 15 successivo.
  if Length(Result) > 16 then
  begin
    rLung:=Trunc((Length(Result) - 16) /15);
    rLung:=((rLung + 1) * 15) + 16;
    Result:=Format('%-*.*s',[rLung,rLung,Result]);
  end
  else
  begin
    if Arrot or (not Arrot and ((Numerico = 'N') or (Trim(CodArrotFile) = ''))) then
    begin
      if (FormatoFile = 'CF') or (FormatoFile = 'AN') or (FormatoFile = 'PN') or (FormatoFile = 'PR') or (FormatoFile = 'PE') or
         (FormatoFile = 'CN') or (FormatoFile = 'PI') or (Valore = '') then
        Result:=Format('%-16.16s',[UpperCase(Valore)])
      else if (FormatoFile = 'CB') or (FormatoFile = 'CB12') then
        Result:=Format('%16.16s',[StringReplace(StringReplace(Valore,' ','0',[rfReplaceAll]),'X','1',[rfReplaceAll])])
      else if (FormatoFile = 'DA') or (FormatoFile = 'DT') or (FormatoFile = 'D4') or (FormatoFile = 'D6') or (FormatoFile = 'DN') then
        Result:=Format('%16.16s',[StringReplace(Valore,'/','',[rfReplaceAll])])
      else if (FormatoFile = 'NP') or (FormatoFile = 'NU') or (FormatoFile = 'NP100') or (FormatoFile = 'NU100') then
      begin
        Result:=StringReplace(Valore,'.','',[rfReplaceAll]);
        if (FormatoFile = 'NP100') or (FormatoFile = 'NU100') then
            Result:=FloatToStr(Trunc(StrToFloat(Result) * 100));
        if Pos(',',Result) > 0 then
          Result:=Copy(Result,1,Pos(',',Result) - 1);
        Result:=Format('%16.16s',[Result]);
      end
      else if (FormatoFile = 'N1') or (FormatoFile = 'N2') or (FormatoFile = 'N3') or (FormatoFile = 'N4') or
              (FormatoFile = 'N5') or (FormatoFile = 'N6') or (FormatoFile = 'N10')  or (FormatoFile = 'N11') then
      begin
        Result:=StringReplace(Valore,'.','',[rfReplaceAll]);
        sNumZeri:=Copy(FormatoFile,2,Length(FormatoFile) - 1);
        if Pos(',',Result) > 0 then
          Result:=Copy(Result,1,Pos(',',Result) - 1);
        Result:=Format('%16.*d',[StrToInt(sNumZeri),StrToInt64(Result)]);
      end
      else if (FormatoFile = 'PC') or (FormatoFile = 'QU') then
      begin
        iMaxDec:=0;
        if FormatoFile = 'PC' then
          iMaxDec:=3
        else if FormatoFile = 'QU' then
          iMaxDec:=5;
        Result:=StringReplace(Valore,'.','',[rfReplaceAll]);
        Result:=FloatToStr(StrToFloat(Result));
        if Pos(',',Result) > 0 then
          iNumDec:=Min(iMaxDec,Length(Result) - Pos(',',Result))
        else
          iNumDec:=0;

        Result:=Format('%*.*n',[16,iNumDec,StrToFloat(Result)]);
        Result:=Format('%16.16s',[StringReplace(Result,'.','',[rfReplaceAll])]);
      end
      else if (FormatoFile = 'VP') or (FormatoFile = 'VN') then
      begin
        Result:=StringReplace(Valore,'.','',[rfReplaceAll]);
        Result:=Format('%16.2n',[StrToFloat(Result)]);
        Result:=StringReplace(Result,'.','',[rfReplaceAll]);
        Result:=Format('%16.16s',[StringReplace(Result,'.','',[rfReplaceAll])]);
      end
      else
        //Se non esistono formattazioni, formatto di tipo 'AN' (lung.16 con rienpimento di spazi a destra)
        Result:=Format('%-16.16s',[UpperCase(Valore)]);
    end
    else if (not Arrot) and (Numerico = 'S') and (Trim(CodArrotFile) <> '') then //Se no Arrot e dato Numerico e CodArrot not null
    begin
      if Centesimi then
        Result:=FloatToStr(R180Arrotonda(StrToFloatDef(StringReplace(Result,'.','',[rfReplaceAll]),0) * 100,1,'P'));
      Result:=Format('%16.16s',[StringReplace(Result,'.','',[rfReplaceAll])]);
    end;
  end;
end;

function P999ContrattoPresente(CodContratto,ElencoCodContratti:String):Boolean;
//Ricerca un contratto all'interno di un elenco
begin
  if Pos('''' + CodContratto + '''',ElencoCodContratti) > 0 then
     Result:=True
  else
     Result:=False;
end;

function P999CreaElencoVoci(VoceFissa:TVF):String;
//Crea un elenco di voci in base ad una voce fissa
var SL:TStringList;
    i:Integer;
begin
  Result:='';
  SL:=TStringList.Create;
  SL.CommaText:=VoceFissa.CodContratto;
  for i:=0 to SL.Count - 1 do
  begin
    if i > 0 then
      Result:=Result + ',';
    Result:=Result + '''' + StringReplace(SL.Strings[i],'''','',[rfReplaceAll]) +
                     ' ' + VoceFissa.CodVoce +
                     ' ' + VoceFissa.CodVoceSpeciale + '''';
  end;
  FreeAndNil(SL);
end;

constructor TQueryCambio.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  SQL.Add('declare');
  SQL.Add('begin');
  SQL.Add('  :wcoeff_cambio:=0;');
  SQL.Add('  begin');
  SQL.Add('    select coeff_calcoli');
  SQL.Add('    into  :wcoeff_cambio');
  SQL.Add('    from');
  SQL.Add('     (select decode(cod_valuta1,:cod_valuta1,coeff_calcoli,:cod_valuta2,1/coeff_calcoli) coeff_calcoli');
  SQL.Add('      from  p032_cambi');
  SQL.Add('      where (   (cod_valuta1 = :cod_valuta1 and cod_valuta2 = :cod_valuta2)');
  SQL.Add('             or (cod_valuta1 = :cod_valuta2 and cod_valuta2 = :cod_valuta1))');
  SQL.Add('      and   :decorrenza between decorrenza and decorrenza_fine');
  SQL.Add('      and   coeff_calcoli > 0');
  SQL.Add('      order by decode(cod_valuta1,:cod_valuta1,1,:cod_valuta2,2))');
  SQL.Add('    where  rownum < 2;');
  SQL.Add('  exception');
  SQL.Add('    when no_data_found then');
  SQL.Add('      :wcoeff_cambio:=0;');
  SQL.Add('  end;');
  SQL.Add('  if :wcoeff_cambio = 0 then');
  SQL.Add('    begin');
  SQL.Add('      select decode(:cod_valuta1,a.cod_valuta1,a.coeff_calcoli,1/a.coeff_calcoli) *');
  SQL.Add('             decode(:cod_valuta2,b.cod_valuta1,1/b.coeff_calcoli,b.coeff_calcoli)');
  SQL.Add('      into  :wcoeff_cambio');
  SQL.Add('      from  p032_cambi a,');
  SQL.Add('            p032_cambi b');
  SQL.Add('      where (      (     a.cod_valuta1 = :cod_valuta1');
  SQL.Add('                    and (   (a.cod_valuta2 = b.cod_valuta1 and b.cod_valuta2 = :cod_valuta2)');
  SQL.Add('                         or (a.cod_valuta2 = b.cod_valuta2 and b.cod_valuta1 = :cod_valuta2)))');
  SQL.Add('             or    (     a.cod_valuta2 = :cod_valuta1');
  SQL.Add('                    and (   (a.cod_valuta1 = b.cod_valuta1 and b.cod_valuta2 = :cod_valuta2)');
  SQL.Add('                         or (a.cod_valuta1 = b.cod_valuta2 and b.cod_valuta1 = :cod_valuta2))))');
  SQL.Add('      and   :decorrenza between a.decorrenza and a.decorrenza_fine');
  SQL.Add('      and   :decorrenza between b.decorrenza and b.decorrenza_fine');
  SQL.Add('      and   a.coeff_calcoli > 0');
  SQL.Add('      and   b.coeff_calcoli > 0');
  SQL.Add('      and   rownum < 2;');
  SQL.Add('    exception');
  SQL.Add('      when no_data_found then');
  SQL.Add('        :wcoeff_cambio:=0;');
  SQL.Add('    end;');
  SQL.Add('  end if;');
  SQL.Add('end;');
  DeclareVariable('wcoeff_cambio',otFloat);
  DeclareVariable('cod_valuta1',otString);
  DeclareVariable('cod_valuta2',otString);
  DeclareVariable('decorrenza',otDate);
end;

function TQueryCambio.CambioValuta(CodValuta1,CodValuta2:String;Decorrenza:TDateTime):Real;
//Ricerca il coefficiente di cambio tra 2 valute ad una data
begin
  if CodValuta1 = CodValuta2 then
  begin
    Result:=1;
    Exit;
  end;
  if (CodValuta1 <> GetVariable('cod_valuta1'))
  or (CodValuta2 <> GetVariable('cod_valuta2'))
  or (Decorrenza <> GetVariable('decorrenza')) then
  begin
    SetVariable('cod_valuta1',CodValuta1);
    SetVariable('cod_valuta2',CodValuta2);
    SetVariable('decorrenza',Decorrenza);
    Execute;
  end;
  Result:=GetVariable('wcoeff_cambio');
end;

destructor TQueryCambio.Destroy;
begin
  inherited Destroy;
end;

end.


