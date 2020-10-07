unit S715UStampaValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, OracleData, DB, DBClient, StrUtils,
  QueryStorico, Oracle, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C700USelezioneAnagrafe, USelI010,
  S715UStampaValutazioniMW;

type
  TS715FStampaValutazioniDtM = class(TR004FGestStoricoDtM)
    cdsStampaAnagrafico: TClientDataSet;
    cdsStampaElementi: TClientDataSet;
    selSG710: TOracleDataSet;
    selSG705: TOracleDataSet;
    selSG706: TOracleDataSet;
    selSQL: TOracleDataSet;
    selSG711: TOracleDataSet;
    selSG700: TOracleDataSet;
    updSG710: TOracleQuery;
    D010: TDataSource;
    selSG741: TOracleDataSet;
    selSG730: TOracleDataSet;
    selT775: TOracleDataSet;
    insT775: TOracleQuery;
    insT775a: TOracleQuery;
    selCols: TOracleDataSet;
    selSG735: TOracleQuery;
    selSG710a: TOracleQuery;
    selFormaz: TOracleDataSet;
    selFormazCODICE: TStringField;
    selFormazDESCRIZIONE: TStringField;
    selFormazORDINE: TFloatField;
    selT430a: TOracleDataSet;
    selV430: TOracleDataSet;
    selV430MATRICOLA: TStringField;
    selV430COGNOME: TStringField;
    selV430NOME: TStringField;
    cdsRegole: TClientDataSet;
    selSG701: TOracleDataSet;
    selSG711c: TOracleDataSet;
    selSchedeCollegateAperte: TOracleDataSet;
    selSchedeCollegateChiuse: TOracleDataSet;
    insSG710: TOracleQuery;
    insaSG711: TOracleQuery;
    selSG711a: TOracleDataSet;
    selSG711b: TOracleDataSet;
    updSG711a: TOracleQuery;
    selSG745: TOracleDataSet;
    delSG711: TOracleQuery;
    selSG742: TOracleDataSet;
    selT030: TOracleDataSet;
    selSG710b: TOracleQuery;
    selT770: TOracleDataSet;
    selSG710c: TOracleDataSet;
    selStoriaValInterm: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsStampaAnagraficoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    selI010:TselI010;
    QSGruppoValutatore:TQueryStorico;
    S715FStampaValutazioniMW:TS715FStampaValutazioniMW;
    CampiT775:String;
    CambioScheda:Boolean;
    function RecuperaEtichetta(NomeCampo:String;Formato:String = ''):String;
    procedure RecuperaRegole(Data:TDateTime; Progressivo:Integer; Codice:String);
    procedure EliminaValidazioni;
  end;

var
  S715FStampaValutazioniDtM: TS715FStampaValutazioniDtM;

const
  OpzioneFirma6: String = '#FIRMA_6#';

implementation

{$R *.dfm}
uses
  S715UDialogStampa;

procedure TS715FStampaValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  S715FStampaValutazioniMW:=TS715FStampaValutazioniMW.Create(Self);
  QSGruppoValutatore:=TQueryStorico.Create(nil);             
  QSGruppoValutatore.Session:=SessioneOracle;
  cdsStampaAnagrafico.CreateDataSet;
  cdsStampaAnagrafico.LogChanges:=False;
  cdsStampaElementi.CreateDataSet;
  cdsStampaElementi.LogChanges:=False;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');
  selI010.Close;
  selI010.SQL.Insert(0,'SELECT ''' + OpzioneFirma6 + ''' NOME_CAMPO, ''' + OpzioneFirma6 + ''' NOME_LOGICO, 9999 POSIZIONE FROM DUAL UNION ');
  selI010.Open;
  D010.DataSet:=selI010;
  selCols.SetVariable('TABELLA','T775_QUOTEINDIVIDUALI');
  selCols.Open;
  while not selCols.Eof do
  begin
    CampiT775:=CampiT775 + IfThen(CampiT775 <> '',',','') + selCols.FieldByName('COLUMN_NAME').AsString;
    selCols.Next;
  end;
  selCols.Close;
  selFormaz.Open;
  cdsRegole.CreateDataSet;
end;

procedure TS715FStampaValutazioniDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(S715FStampaValutazioniMW);
  inherited;
  FreeAndNil(QSGruppoValutatore);
  FreeAndNil(selI010);
end;

procedure TS715FStampaValutazioniDtM.cdsStampaAnagraficoAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  cdsStampaElementi.Filter:='(PROG_VALUTATO = ' + IntToStr(cdsStampaAnagrafico.FieldByName('PROG_VALUTATO').AsInteger) + ')' +
                            ' AND (DATA_VALUTAZIONE = ' + FloatToStr(cdsStampaAnagrafico.FieldByName('DATA_VALUTAZIONE').AsDateTime) + ')' +
                            ' AND (TIPO_VALUTAZIONE = ''' + cdsStampaAnagrafico.FieldByName('TIPO_VALUTAZIONE').AsString + ''')' +
                            ' AND (STATO_AVANZAMENTO = ' + IntToStr(cdsStampaAnagrafico.FieldByName('STATO_AVANZAMENTO').AsInteger) + ')';
  CambioScheda:=True;
end;

function TS715FStampaValutazioniDtM.RecuperaEtichetta(NomeCampo:String;Formato:String = ''):String;
begin
  Result:='';
  if not selSG742.Active then
    exit;
  Result:=Trim(VarToStr(selSG742.Lookup('NOME_CAMPO',NomeCampo,'ETICHETTA')));
  Result:=IfThen(Formato = 'U',UpperCase(Result),IfThen(Formato = 'L',LowerCase(Result),Result));
end;

procedure TS715FStampaValutazioniDtM.RecuperaRegole(Data:TDateTime; Progressivo:Integer; Codice:String);
begin
  if Codice = '' then
    Codice:=VarToStr(cdsRegole.Lookup('DATA;PROGRESSIVO',VarArrayOf([Data,Progressivo]),'CODICE'));
  if Codice = '' then
  begin
    Codice:='#NONE#';
    if (Data <> 0) and (Progressivo <> 0) then
    begin
      selSG741.Close;
      selSG741.SetVariable('CODICE','');
      selSG741.SetVariable('DATA',Data);
      selSG741.Open;
      while not selSG741.Eof do
      begin
        R180SetVariable(selV430,'QVISTAORACLE',QVistaOracle);
        R180SetVariable(selV430,'DATALAVORO',Data);
        R180SetVariable(selV430,'FILTRO',selSG741.FieldByName('FILTRO_ANAGRAFE').AsString);
        R180SetVariable(selV430,'PROGRESSIVO',Progressivo);
        selV430.Open;
        if selV430.RecordCount > 0 then
        begin
          Codice:=selSG741.FieldByName('CODICE').AsString;
          Break;
        end;
        selSG741.Next;
      end;
    end;
    cdsRegole.Append;
    cdsRegole.FieldByName('DATA').AsDateTime:=Data;
    cdsRegole.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
    cdsRegole.FieldByName('CODICE').AsString:=Codice;
    cdsRegole.Post;
  end;
  selSG741.Close;
  selSG741.SetVariable('CODICE',Codice);
  selSG741.SetVariable('DATA',Data);
  selSG741.Open;
  //Recupero anche le etichette dei campi
  R180SetVariable(selSG742,'DECORRENZA',selSG741.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selSG742,'CODREGOLA',Codice);
  selSG742.Open;
  //Recupero la parametrizzazione per il protocollo
  R180SetVariable(S715FStampaValutazioniMW.selSG750,'CODICE',IfThen(selSG741.FieldByName('COD_PARPROTOCOLLO').AsString = '','#VALORE#FITTIZIO#',selSG741.FieldByName('COD_PARPROTOCOLLO').AsString));
  S715FStampaValutazioniMW.selSG750.Open;
  R180SetVariable(S715FStampaValutazioniMW.selSG751,'CODICE',S715FStampaValutazioniMW.selSG750.FieldByName('CODICE').AsString);
  S715FStampaValutazioniMW.selSG751.Open;
end;

procedure TS715FStampaValutazioniDtM.EliminaValidazioni;
begin
  //Cancello i rifiuti del validatore
  while selSG745.SearchRecord('TIPO_CONSEGNA;DATA;PROGRESSIVO;TIPO_VALUTAZIONE;STATO_AVANZAMENTO',
                              VarArrayOf(['VS',
                                          selSG710.FieldByName('DATA').AsDateTime,
                                          selSG710.FieldByName('PROGRESSIVO').AsInteger,
                                          selSG710.FieldByName('TIPO_VALUTAZIONE').AsString,
                                          selSG710.FieldByName('STATO_AVANZAMENTO').AsInteger]),[srFromBeginning]) do
    selSG745.Delete;
end;

end.
