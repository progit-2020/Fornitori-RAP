unit A020UCausPresenzeStoricoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  System.Generics.Collections, A000UMessaggi, A000UCostanti, Oracle,
  StrUtils, C180FunzioniGenerali;

type
  TA020ElementoListaStorico = class
    ColonnaDato,Descrizione:String;
    Decorrenza,FineDecorrenza:TDateTime;
    ValoreDato,DescValoreDato:String;
    IndiceDato:Integer;
  end;

  TA020DescrizioneElementoStorico = record
    Nome,Descrizione:String;
  end;

  TA020TipoDescrValoreCampo = (tdvcSiNo);

  TA020FCausPresenzeStoricoMW = class(TR005FDataModuleMW)
    selT275: TOracleDataSet;
    selT235: TOracleDataSet;
    insT235Nuovo: TOracleQuery;
    insT235NuovoCompleto: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIdCausale:Integer;
    FDecorrenze:TArray<TDateTime>; // Array con tutte le decorrenze esistenti per questa causale
    FIndiceDecorrenzaCorrente:Integer; // Indice in FDecorrenze del periodo corrente
    FStoriaDati:TObjectList<TA020ElementoListaStorico>;
    function CampoInListaStorico(NomeCampo:String):Boolean;
    function GetDescrizioneCampo(Campo:String):String;
    function GetDescrizioneValoreCampo(Item:String;TipoDescr:TA020TipoDescrValoreCampo):String;
    const
       D_DatiStoricizzatiT235: array[0..2] of TA020DescrizioneElementoStorico = (
         (Nome:'DESCRIZIONE';                Descrizione:'Descrizione'),
         (Nome:'CAUSCOMP_DEBITOGG';          Descrizione:'Causale per compensazione debito gg.'),
         (Nome:'RENDICONTA_PROGETTI';        Descrizione:'Considera per rendicontazione progetti')
       );
       D_SiNo: array[0..1] of TItemsValues = (
        (Item:'S';     Value:'Sì'),
        (Item:'N';     Value:'No')
      );
      DescrizioneIniziale:String = 'parametri originali';
  public
    procedure Inizializza(IdCausale:Integer);
    procedure ApriT275;
    procedure ApriT235;
    procedure ChiudiT235;
    procedure ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
    procedure ElaboraStoriaDati(DataPeriodo:TDateTime);
    property IdCausale:Integer read FIdCausale write FIdCausale;
    property Decorrenze:TArray<TDateTime> read FDecorrenze;
    property IndiceDecorrenzaCorrente:Integer read FIndiceDecorrenzaCorrente;
    property StoriaDati:TObjectList<TA020ElementoListaStorico> read FStoriaDati;
    procedure CreaRecordVuoto(ID:Integer);
    procedure CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA020FCausPresenzeStoricoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
end;

procedure TA020FCausPresenzeStoricoMW.DataModuleDestroy(Sender: TObject);
begin
  if (FStoriaDati <> nil) then
    FreeAndNil(FStoriaDati);
  selT235.Close;
  inherited;
end;

procedure TA020FCausPresenzeStoricoMW.Inizializza(IdCausale:Integer);
begin
   // Reimposto il MW allo stato iniziale
  selT235.Close;
  selT235.ClearVariables;
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  SetLength(FDecorrenze,0);
  FIndiceDecorrenzaCorrente:=-1;
  // TODO: necessario per IrisCloud
  {cdsStoriaParamStorizz.EmptyDataSet;}
  // Imposto le variabili interne
  FIDCausale:=IDCausale;
  selT235.SetVariable('ID',FIDCausale);
end;

procedure TA020FCausPresenzeStoricoMW.ApriT275;
begin
  // Per ora ci basterebbe avere il record della causale corrente, ma in futuro
  // potrebbe servirci per popolare una lista di causali.
  if selT275.Active then
    selT275.Close;
  selT275.Open;
end;

procedure TA020FCausPresenzeStoricoMW.ApriT235;
begin
  if selT235.Active then
    selT235.Close;
  selT235.Open;
end;

procedure TA020FCausPresenzeStoricoMW.ChiudiT235;
begin
  if selT235.Active then
    selT235.Close;
end;

procedure TA020FCausPresenzeStoricoMW.ElaboraArrayDecorrenze(DataPeriodo:TDateTime);
var
  I:Integer;
begin
  I:=0;
  selT235.First;
  SetLength(FDecorrenze,0);
  SetLength(FDecorrenze,selT235.RecordCount);
  while not selT235.EOF do
  begin
    FDecorrenze[I]:=selT235.FieldByName('DECORRENZA').AsDateTime;
    if (FDecorrenze[I] <= DataPeriodo) then
      FIndiceDecorrenzaCorrente:=I;
    selT235.Next;
    Inc(I);
  end;
end;

function TA020FCausPresenzeStoricoMW.CampoInListaStorico(NomeCampo:String):Boolean;
var
  ElemListaCorrente:TA020DescrizioneElementoStorico;
begin
  Result:=False;
  for ElemListaCorrente in D_DatiStoricizzatiT235 do
  begin
    if Lowercase(ElemListaCorrente.Nome) = Lowercase(NomeCampo) then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TA020FCausPresenzeStoricoMW.GetDescrizioneCampo(Campo:String):String;
var
  I:Integer;
begin
  Result:='';
  for I:=0 to (Length(D_DatiStoricizzatiT235) - 1) do
  begin
    if Lowercase(Campo) = Lowercase(D_DatiStoricizzatiT235[I].Nome) then
    begin
      Result:=D_DatiStoricizzatiT235[I].Descrizione;
      Break;
    end;
  end;
end;

function TA020FCausPresenzeStoricoMW.GetDescrizioneValoreCampo(Item:String;TipoDescr:TA020TipoDescrValoreCampo):String;
var
  I:Integer;
begin
  Result:='';
  case TipoDescr of
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
  end;
end;

procedure TA020FCausPresenzeStoricoMW.ElaboraStoriaDati(DataPeriodo:TDateTime);
var
  I:Integer;
  ElementoListaStorico:TA020ElementoListaStorico;
  IndiceDatoCorrente:Integer;
  DataPeriodoFilterStr:String;
begin
  if FStoriaDati <> nil then
    FreeAndNil(FStoriaDati);
  if selT235.State <> dsBrowse then
    raise Exception.Create(A000MSG_A020_ERR_STORIA_T235);

  DataPeriodoFilterStr:=FloatToStr(Trunc(DataPeriodo));
  selT235.Filter:='(DECORRENZA <= ' + DataPeriodoFilterStr + ') AND (DECORRENZA_FINE >= ' + DataPeriodoFilterStr + ')';
  selT235.Filtered:=True;
  try
    if selT235.RecordCount = 0 then
      Exit
    else if selT235.RecordCount > 1 then
      raise Exception.Create(A000MSG_A020_ERR_T235_INCOERENTE)
    else
    begin
      FStoriaDati:=TObjectList<TA020ElementoListaStorico>.Create(True);
      ElementoListaStorico:=nil;
      IndiceDatoCorrente:=0;
      DataPeriodoFilterStr:=FloatToStr(Trunc(DataPeriodo));
      try
        for I:=0 to (selT235.FieldCount - 1) do
        begin
          if CampoInListaStorico(selT235.Fields[I].FieldName) then
          begin
            ElementoListaStorico:=TA020ElementoListaStorico.Create;
            StoriaDati.Add(ElementoListaStorico);
            ElementoListaStorico.Decorrenza:=selT235.FieldByName('DECORRENZA').AsDateTime;
            ElementoListaStorico.FineDecorrenza:=selT235.FieldByName('DECORRENZA_FINE').AsDateTime;
            ElementoListaStorico.ColonnaDato:=selT235.Fields[I].FieldName;
            ElementoListaStorico.Descrizione:=GetDescrizioneCampo(selT235.Fields[I].FieldName);
            ElementoListaStorico.ValoreDato:=selT235.Fields[I].AsString;
            ElementoListaStorico.DescValoreDato:=selT235.Fields[I].AsString;
            ElementoListaStorico.IndiceDato:=IndiceDatoCorrente;
            inc(IndiceDatoCorrente);
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
          raise Exception.Create(Format(A000MSG_A020_ERR_STORIA_GEN,[E.Message]));
        end;
      end;
    end;
  finally
    selT235.Filter:='';
    selT235.Filtered:=False;
    selT235.First;
  end;
end;

procedure TA020FCausPresenzeStoricoMW.CreaRecordVuoto(ID:Integer);
begin
  insT235Nuovo.ClearVariables;
  insT235Nuovo.SetVariable('ID',ID);
  insT235Nuovo.SetVariable('DECORRENZA',DATE_MIN);
  insT235Nuovo.SetVariable('DECORRENZA_FINE',DATE_MAX);
  insT235Nuovo.SetVariable('DESCRIZIONE',DescrizioneIniziale);
  insT235Nuovo.Execute;
  insT235Nuovo.Session.Commit;
end;

procedure TA020FCausPresenzeStoricoMW.CreaCopiaParametriStorici(IDEsistente,IDNuovo:Integer);
var Colonne:String;
    i:Integer;
begin
  Colonne:='';
  for i:=0 to selT235.FieldCount - 1 do
  begin
    if (selT235.Fields[i].FieldName <> 'ID') and (selT235.Fields[i].FieldKind = fkData) then
      Colonne:=Colonne + IfThen(Colonne <> '',',') + selT235.Fields[i].FieldName;
  end;

  try
    insT235NuovoCompleto.SetVariable('ID', IDNuovo);
    insT235NuovoCompleto.SetVariable('OLD_ID', IDEsistente);
    insT235NuovoCompleto.SetVariable('COLONNE', Colonne);
    insT235NuovoCompleto.Execute;
    insT235NuovoCompleto.Session.Commit;
  except
    on E:Exception do
    begin
      raise Exception.Create(Format(A000MSG_A020_ERR_COPIA_STORIA_GEN,[E.Message]));
    end;
  end;
  // Il dataset sarà riaperto da AfterScroll sul dataset dei dati non storicizzati (selT275)
end;

end.
