unit A016UCausAssenzeStoricoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  System.Generics.Collections, StrUtils, Math, C180FunzioniGenerali, A000UCostanti, Oracle,
  Datasnap.DBClient, A000UMessaggi;

type
  TA016ElementoListaStorico = class
    ColonnaDato,Descrizione:String;
    Decorrenza,FineDecorrenza:TDateTime;
    ValoreDato,DescValoreDato:String;
    IndiceDato:Integer;
  end;

  TA016DescrizioneElementoStorico = record
    Nome,Descrizione:String;
  end;

  TA106TipoDescrValoreCampo = (tdvcValorizzazioneGiornaliera,
                               tdvcSiNo,
                               tdvcStatoCompatibilita);

  TA016FCausAssenzeStoricoMW = class(TR005FDataModuleMW)
    selT230: TOracleDataSet;
    selT230ID: TIntegerField;
    selT230DESCRIZIONE: TStringField;
    selT230VALORGIOR_COMP: TStringField;
    selT230VALORGIOR: TStringField;
    selT230HMASSENZA: TStringField;
    selT230VALORGIOR_ORE: TStringField;
    selT230VALORGIOR_ORECOMP: TStringField;
    selT230VALORGIOR_ORE_PROPPT: TStringField;
    selT265: TOracleDataSet;
    selT230CODICE: TStringField;
    selT230DECORRENZA: TDateTimeField;
    selT230DECORRENZA_FINE: TDateTimeField;
    selT230CAUSALI_COMPATIBILI: TStringField;
    selT230STATO_COMPATIBILITA: TStringField;
    selT230HMASSENZA_PROPPT: TStringField;
    selT230DESC_CAUSALE: TStringField;
    insT230Nuovo: TOracleQuery;
    selT230CAUSALI_CHECKCOMPETENZE: TStringField;
    insT230NuovoCompleto: TOracleQuery;
    cdsStoriaParamStorizz: TClientDataSet;
    cdsStoriaParamStorizzDATO: TStringField;
    cdsStoriaParamStorizzVALORE: TStringField;
    cdsStoriaParamStorizzDECORRENZA: TStringField;
    cdsStoriaParamStorizzFINE_DECORRENZA: TStringField;
    selT230CAUSALE_VISUALCOMPETENZE: TStringField;
    selT230SCARICOPAGHE_FRUIZ_GG: TStringField;
    selT230SCARICOPAGHE_FRUIZ_ORE: TStringField;
    selT230CAUSALE_FRUIZORE: TStringField;
    selT230CAUSALE_HMASSENZA: TStringField;
    selT230CHECK_SOLOCOMPETENZE: TStringField;
    dsrT265: TDataSource;
    selT230ABBATTE_STRIND: TStringField;
    selT230SCELTA_ORARIO: TStringField;
    selT230RENDICONTA_PROGETTI: TStringField;
    selT230CONDIZIONE_ALLEGATI: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ValidaCampoOrario(Sender: TField);
    procedure selT230CAUSALI_COMPATIBILIGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
     FIDCausale:Integer;
     FStoriaDati:TObjectList<TA016ElementoListaStorico>;
     FDecorrenze:TArray<TDateTime>; // Array con tutte le decorrenze esistenti per questa causale
     FIndiceDecorrenzaCorrente:Integer; // Indice in FDecorrenze del periodo corrente
     function CampoInListaStorico(NomeCampo:String):Boolean;
     function GetDescrizioneValoreCampo(Item:String;TipoDescr:TA106TipoDescrValoreCampo):String;
     const
       D_DatiStoricizzatiT230: array[0..19] of TA016DescrizioneElementoStorico = (
         (Nome:'DESCRIZIONE';                Descrizione:'Descrizione'),
         (Nome:'VALORGIOR';                  Descrizione:'Valorizzazione giornaliera'),
         (Nome:'VALORGIOR_ORE';              Descrizione:'Ore valorizzazione giornaliera'),
         (Nome:'VALORGIOR_COMP';             Descrizione:'Valorizzazione giornaliera per competenze'),
         (Nome:'VALORGIOR_ORECOMP';          Descrizione:'Ore valorizzazione giornaliera per competenze'),
         (Nome:'VALORGIOR_ORE_PROPPT';       Descrizione:'Proporziona valor. giornaliera se part-time'),
         (Nome:'HMASSENZA';                  Descrizione:'HH:MM per giorno di assenza'),
         (Nome:'HMASSENZA_PROPPT';           Descrizione:'Proporziona HH:MM assenza se part-time'),
         (Nome:'CAUSALI_COMPATIBILI';        Descrizione:'Causali compatibili'),
         (Nome:'STATO_COMPATIBILITA';        Descrizione:'Stato di compatibilità'),
         (Nome:'CAUSALI_CHECKCOMPETENZE';    Descrizione:'Controllo aggiuntivo competenze'),
         (Nome:'CAUSALE_VISUALCOMPETENZE';   Descrizione:'Visualizza le competenze di'),
         (Nome:'SCARICOPAGHE_FRUIZ_GG';      Descrizione:'Fruizioni giornaliere abilitate allo scarico paghe'),
         (Nome:'SCARICOPAGHE_FRUIZ_ORE';     Descrizione:'Fruizioni orarie abilitate allo scarico paghe'),
         (Nome:'CAUSALE_FRUIZORE';           Descrizione:'Causale da inserire se fruizione oraria'),
         (Nome:'CAUSALE_HMASSENZA';          Descrizione:'Causale cumulativa giornaliera delle fruizioni orarie'),
         (Nome:'CHECK_SOLOCOMPETENZE';       Descrizione:'Esclusione dei controlli utente'),
         (Nome:'ABBATTE_STRIND';             Descrizione:'Abbatte la maturazione di straordinario e indennità'),
         (Nome:'SCELTA_ORARIO';              Descrizione:'Considera il giustif. dalle..alle nella scelta dell''orario'),
         (Nome:'RENDICONTA_PROGETTI';        Descrizione:'Considera per rendicontazione progetti')
      );
      D_ValorizzazioneGiornaliera: array[0..6] of TItemsValues = (
        (Item:'-';     Value:'Come Valorizzazione giornaliera'),
        (Item:'A';     Value:'Monte ore sett./gg. lav.'),
        (Item:'B';     Value:'Ore teoriche dell''orario'),
        (Item:'C';     Value:'Monte ore sett./6'),
        (Item:'D';     Value:'Ore teoriche da anagrafico'),
        (Item:'E';     Value:'Ore del debito giornaliero'),
        (Item:'F';     Value:'Ore fisse')
      );
      D_SiNo: array[0..1] of TItemsValues = (
        (Item:'S';     Value:'Sì'),
        (Item:'N';     Value:'No')
      );
      D_StatoCompatibilita: array[0..2] of TItemsValues = (
        (Item:'D';     Value:'Disattivato'),
        (Item:'C';     Value:'Compatibile'),
        (Item:'I';     Value:'Incompatibile')
      );
      DescrizioneIniziale:String = 'Parametri originali';
      ValorGior_OreFisse_Value = 'F';
  public
    constructor Create(AOwner: TComponent); override;
    property IDCausale:Integer read FIDCausale;
    property StoriaDati:TObjectList<TA016ElementoListaStorico> read FStoriaDati;
    property Decorrenze:TArray<TDateTime> read FDecorrenze;
    property IndiceDecorrenzaCorrente:Integer read FIndiceDecorrenzaCorrente;
    procedure Inizializza(IDCausale:Integer);
    function GetDescrizioneCampo(Campo:String):String;
    procedure ElaboraStoriaDati(DataPeriodo:TDateTime);
    procedure CreaRecordVuoto(ID:Integer);
    procedure CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
    procedure SvuotaCDSStoriaDati;
    procedure ValorizzaCDSStoriaDati;
    procedure ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
    class function ControllaCampiObbligatori(DataSet:TDataSet): String;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TA016FCausAssenzeStoricoMW.Create(AOwner: TComponent);
begin
  inherited;
  FIDCausale:=-1;
  FStoriaDati:=nil;
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
  cdsStoriaParamStorizz.CreateDataSet;
end;

procedure TA016FCausAssenzeStoricoMW.Inizializza(IDCausale:Integer);
begin
  // Reimposto il MW allo stato iniziale
  selT230.Close;
  selT230.ClearVariables;
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
  cdsStoriaParamStorizz.EmptyDataSet;
  // Imposto le variabili interne
  FIDCausale:=IDCausale;
  selT230.SetVariable('ID',FIDCausale);
end;

class function TA016FCausAssenzeStoricoMW.ControllaCampiObbligatori(DataSet:TDataSet): String;
begin
  Result:='';
  if (DataSet.FieldByName('VALORGIOR').AsString = ValorGior_OreFisse_Value) and
     (DataSet.FieldByName('VALORGIOR_ORE').AsString.Trim.Length = 0) then
  begin
    Result:='VALORGIOR_ORE';
    Exit;
  end;

  if (DataSet.FieldByName('VALORGIOR_COMP').AsString = ValorGior_OreFisse_Value) and
     (DataSet.FieldByName('VALORGIOR_ORECOMP').AsString.Trim.Length = 0) then
  begin
    Result:='VALORGIOR_ORECOMP';
    Exit;
  end;
end;

procedure TA016FCausAssenzeStoricoMW.selT230CAUSALI_COMPATIBILIGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString <> '' then
    Text:=Sender.AsString
  else
    Text:=A000MSG_A016_MSG_NO_CAUSALI_COMP;
end;

procedure TA016FCausAssenzeStoricoMW.ValidaCampoOrario(Sender: TField);
var
  StringFieldSender:TStringField;
begin
  StringFieldSender:=(Sender as TStringField);
  R180OraValidate(StringFieldSender.AsString);
end;

function TA016FCausAssenzeStoricoMW.CampoInListaStorico(NomeCampo:String):Boolean;
var
  ElemListaCorrente:TA016DescrizioneElementoStorico;
begin
  Result:=False;
  for ElemListaCorrente in D_DatiStoricizzatiT230 do
  begin
    if Lowercase(ElemListaCorrente.Nome) = Lowercase(NomeCampo) then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TA016FCausAssenzeStoricoMW.GetDescrizioneValoreCampo(Item:String;TipoDescr:TA106TipoDescrValoreCampo):String;
var
  I:Integer;
begin
  Result:='';
  case TipoDescr of
    tdvcValorizzazioneGiornaliera:
    begin
      for I:=0 to (Length(D_ValorizzazioneGiornaliera) - 1) do
      begin
        if Item = D_ValorizzazioneGiornaliera[I].Item then
        begin
          Result:=D_ValorizzazioneGiornaliera[I].Value;
          Break;
        end;
      end;
    end;
    tdvcSiNo:
    begin
      for I:=0 to (Length(D_SiNo) - 1) do
      begin
        if Item = D_SiNo[I].Item then
        begin
          Result:=D_SiNo[I].Value;
          Break;
        end;
      end;
    end;
    tdvcStatoCompatibilita:
    begin
      for I:=0 to (Length(D_StatoCompatibilita) - 1) do
      begin
        if Item = D_StatoCompatibilita[I].Item then
        begin
          Result:=D_StatoCompatibilita[I].Value;
          Break;
        end;
      end;
    end;
  end;
end;

function TA016FCausAssenzeStoricoMW.GetDescrizioneCampo(Campo:String):String;
var
  I:Integer;
begin
  Result:='';
  for I:=0 to (Length(D_DatiStoricizzatiT230) - 1) do
  begin
    if Lowercase(Campo) = Lowercase(D_DatiStoricizzatiT230[I].Nome) then
    begin
      Result:=D_DatiStoricizzatiT230[I].Descrizione;
      Break;
    end;
  end;
end;

{ Inizialmente questo metodo estraeva uno storico per tutti i periodi disponibili,
  "appiattendo" le modifiche come la funzione "Storia del dipendente".
  Successivamente si è deciso di estrarre un solo periodo.
  Per ora lo mantengo così nel caso si decidesse di apportare ulteriori modifiche,
  nel caso si può pensare di modificarlo per evitare il doppio ciclo che a questo punto
  si può evitare. }
procedure TA016FCausAssenzeStoricoMW.ElaboraStoriaDati(DataPeriodo:TDateTime);
var
  I:Integer;
  ElementoListaStorico:TA016ElementoListaStorico;
  IndiceDatoCorrente:Integer;
  DataPeriodoFilterStr:String;
begin
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  if selT230.State <> dsBrowse then
    raise Exception.Create(A000MSG_A016_ERR_STORIA_T230);
  if (selT230.RecordCount > 0) then
  begin
    FStoriaDati:=TObjectList<TA016ElementoListaStorico>.Create(True);
    ElementoListaStorico:=nil;
    IndiceDatoCorrente:=0;
    DataPeriodoFilterStr:=FloatToStr(Trunc(DataPeriodo));
    selT230.DisableControls;
    selT230.Filter:='(DECORRENZA <= ' + DataPeriodoFilterStr + ') AND (DECORRENZA_FINE >= ' + DataPeriodoFilterStr + ')';
    selT230.Filtered:=True;
    try
      try
        for I:=0 to (selT230.FieldCount - 1) do
        begin
          if CampoInListaStorico(selT230.Fields[I].FieldName) then
          begin
            selT230.First;
            ElementoListaStorico:=TA016ElementoListaStorico.Create;
            StoriaDati.Add(ElementoListaStorico);
            ElementoListaStorico.Decorrenza:=selT230.FieldByName('DECORRENZA').AsDateTime;
            ElementoListaStorico.FineDecorrenza:=selT230.FieldByName('DECORRENZA_FINE').AsDateTime;
            ElementoListaStorico.ColonnaDato:=selT230.Fields[I].FieldName;
            ElementoListaStorico.Descrizione:=GetDescrizioneCampo(selT230.Fields[I].FieldName);
            ElementoListaStorico.ValoreDato:=selT230.Fields[I].AsString;
            if (ElementoListaStorico.ColonnaDato = 'VALORGIOR') or (ElementoListaStorico.ColonnaDato = 'VALORGIOR_COMP') then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcValorizzazioneGiornaliera)
            else if R180In(ElementoListaStorico.ColonnaDato,['VALORGIOR_ORE_PROPPT',
                                                             'HMASSENZA_PROPPT',
                                                             'SCARICOPAGHE_FRUIZ_GG',
                                                             'SCARICOPAGHE_FRUIZ_ORE',
                                                             'CHECK_SOLOCOMPETENZE',
                                                             'ABBATTE_STRIND']) then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcSiNo)
            else if (ElementoListaStorico.ColonnaDato = 'STATO_COMPATIBILITA') then
              ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcStatoCompatibilita)
            else if (ElementoListaStorico.ColonnaDato = 'CAUSALI_COMPATIBILI') then
            begin
              if (selT230.Fields[I].AsString <> '') then
                ElementoListaStorico.DescValoreDato:=selT230.Fields[I].AsString
              else
                ElementoListaStorico.DescValoreDato:=A000MSG_A016_MSG_NO_CAUSALI_COMP;
            end
            else
              ElementoListaStorico.DescValoreDato:=selT230.Fields[I].AsString;
            ElementoListaStorico.IndiceDato:=IndiceDatoCorrente;
            while not selT230.Eof do
            begin
              if (ElementoListaStorico.ValoreDato <> selT230.Fields[I].AsString) then
              begin
                ElementoListaStorico:=TA016ElementoListaStorico.Create;
                StoriaDati.Add(ElementoListaStorico);
                ElementoListaStorico.IndiceDato:=IndiceDatoCorrente;
                ElementoListaStorico.Decorrenza:=selT230.FieldByName('DECORRENZA').AsDateTime;
                ElementoListaStorico.FineDecorrenza:=selT230.FieldByName('DECORRENZA_FINE').AsDateTime;
                ElementoListaStorico.ColonnaDato:=selT230.Fields[I].FieldName;
                ElementoListaStorico.Descrizione:=GetDescrizioneCampo(selT230.Fields[I].FieldName);
                ElementoListaStorico.ValoreDato:=selT230.Fields[I].AsString;
                if (ElementoListaStorico.ColonnaDato = 'VALORGIOR') or (ElementoListaStorico.ColonnaDato = 'VALORGIOR_COMP') then
                  ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcValorizzazioneGiornaliera)
                else if R180In(ElementoListaStorico.ColonnaDato,['VALORGIOR_ORE_PROPPT',
                                                                 'HMASSENZA_PROPPT',
                                                                 'SCARICOPAGHE_FRUIZ_GG',
                                                                 'SCARICOPAGHE_FRUIZ_ORE',
                                                                 'CHECK_SOLOCOMPETENZE',
                                                                 'ABBATTE_STRIND'
                                                                 ]) then
                  ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcSiNo)
                else if (ElementoListaStorico.ColonnaDato = 'STATO_COMPATIBILITA') then
                  ElementoListaStorico.DescValoreDato:=GetDescrizioneValoreCampo(selT230.Fields[I].AsString,tdvcStatoCompatibilita)
                else if (ElementoListaStorico.ColonnaDato = 'CAUSALI_COMPATIBILI') then
                begin
                  if (selT230.Fields[I].AsString <> '') then
                    ElementoListaStorico.DescValoreDato:=selT230.Fields[I].AsString
                  else
                    ElementoListaStorico.DescValoreDato:=A000MSG_A016_MSG_NO_CAUSALI_COMP;
                end
                else
                  ElementoListaStorico.DescValoreDato:=selT230.Fields[I].AsString;
              end
              else if (ElementoListaStorico.Decorrenza <> selT230.FieldByName('DECORRENZA').AsDateTime)
                       and
                      (ElementoListaStorico.FineDecorrenza <> (selT230.FieldByName('DECORRENZA').AsDateTime + 1)) then
              begin
                ElementoListaStorico.Decorrenza:=Min(selT230.FieldByName('DECORRENZA').AsDateTime,ElementoListaStorico.Decorrenza);
                ElementoListaStorico.FineDecorrenza:=Max(selT230.FieldByName('DECORRENZA_FINE').AsDateTime,ElementoListaStorico.FineDecorrenza);
              end;
              selT230.Next;
            end;
            Inc(IndiceDatoCorrente);
          end;
        end;
      except
        on E:Exception do
        begin
          // Disalloco la lista e automaticamente gli oggetti contenuti in essa
          FreeAndNil(FStoriaDati);
          // Molto improbabile: ho allocato l'ultimo elemento ma non sono riuscito ad aggiungerlo
          // alla lista. Nel dubbio, tento di liberarlo.
          try FreeAndNil(ElementoListaStorico); except end;
          raise Exception.Create(Format(A000MSG_A016_ERR_STORIA_GEN,[E.Message]));
        end;
      end;
    finally
      selT230.Filter:='';
      selT230.Filtered:=False;
      selT230.EnableControls;
      selT230.First;
    end;
  end;
end;

procedure TA016FCausAssenzeStoricoMW.CreaRecordVuoto(ID:Integer);
begin
  insT230Nuovo.ClearVariables;
  insT230Nuovo.SetVariable('ID',ID);
  insT230Nuovo.SetVariable('DECORRENZA',DATE_MIN);
  insT230Nuovo.SetVariable('DECORRENZA_FINE',DATE_MAX);
  insT230Nuovo.SetVariable('DESCRIZIONE',DescrizioneIniziale);
  insT230Nuovo.Execute;
  insT230Nuovo.Session.Commit;
end;

procedure TA016FCausAssenzeStoricoMW.CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
var Colonne:String;
    i:Integer;
begin
  Colonne:='';
  for i:=0 to selT230.FieldCount - 1 do
  begin
    if (selT230.Fields[i].FieldName <> 'ID') and (selT230.Fields[i].FieldKind = fkData) then
      Colonne:=Colonne + ifThen(Colonne <> '',',') + selT230.Fields[i].FieldName;
  end;

  try
    insT230NuovoCompleto.SetVariable('ID', IDNuovo);
    insT230NuovoCompleto.SetVariable('OLD_ID', IDEsistente);
    insT230NuovoCompleto.SetVariable('COLONNE', Colonne);
    insT230NuovoCompleto.Execute;
    insT230NuovoCompleto.Session.Commit;
  except
    on E:Exception do
    begin
      raise Exception.Create(Format(A000MSG_A016_ERR_COPIA_STORIA_GEN,[E.Message]));
    end;
  end;
  // Il selT230 sarà riaperto dalla successiva chiamata a Inizializza()
end;

procedure TA016FCausAssenzeStoricoMW.SvuotaCDSStoriaDati;
begin
  cdsStoriaParamStorizz.EmptyDataSet;
end;

procedure TA016FCausAssenzeStoricoMW.ValorizzaCDSStoriaDati;
var
  Elemento:TA016ElementoListaStorico;
begin
  cdsStoriaParamStorizz.EmptyDataSet;
  if (StoriaDati <> nil) then
  begin
    for Elemento in StoriaDati do
    begin
      cdsStoriaParamStorizz.Append;
      cdsStoriaParamStorizz.FieldByName('DATO').AsString:=Elemento.Descrizione;
      cdsStoriaParamStorizz.FieldByName('DECORRENZA').AsString:=FormatDateTime('dd/mm/yyyy',Elemento.Decorrenza);
      cdsStoriaParamStorizz.FieldByName('FINE_DECORRENZA').AsString:=FormatDateTime('dd/mm/yyyy',Elemento.FineDecorrenza);
      cdsStoriaParamStorizz.FieldByName('VALORE').AsString:=Elemento.DescValoreDato;
      cdsStoriaParamStorizz.Post;
    end;
  end;
end;

procedure TA016FCausAssenzeStoricoMW.ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
var
  I:Integer;
begin
  I:=0;
  selT230.First;
  SetLength(FDecorrenze,0);
  SetLength(FDecorrenze,selT230.RecordCount);
  while not selT230.EOF do
  begin
    FDecorrenze[I]:=selT230.FieldByName('DECORRENZA').AsDateTime;
    if (FDecorrenze[I] <= DataPeriodo) then
      FIndiceDecorrenzaCorrente:=I;
    selT230.Next;
    Inc(I);
  end;
end;

procedure TA016FCausAssenzeStoricoMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if (FStoriaDati <> nil) then
    FreeAndNil(FStoriaDati);
end;

end.
