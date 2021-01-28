unit USelI010;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants;

type
  TselI010 = class(TOracleDataSet)
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Apri(Sessione:TOracleSession; Layout,Applicazione,Campi,Where,Sort:String);
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TselI010]);
end;

constructor TselI010.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
end;

procedure TselI010.Apri(Sessione:TOracleSession; Layout,Applicazione,Campi,Where,Sort:String);
begin
  // NOTA: se nella query viene estratto un campo long (ad es. DATA_DEFAULT)
  //       la proprietà ReadBuffer viene ignorata,
  //       e viene eseguita la fetch di un record per volta
  ReadBuffer:=220;
  if Campi = '' then
  begin
    //Campi:='*';  //Alberto 29/02/2012: elimino DATA_DEFAULT per ottimizzare lettura nel TOracleDataSet
    Campi:='NOME_CAMPO,DATA_TYPE,DATA_LENGTH,TABLE_NAME,COLUMN_ID, NOME_LOGICO,RICERCA,POSIZIONE,VAL_DEFAULT,PROVVEDIMENTO,CAMPO_DESCRIZIONE';
    if Layout <> '' then
      Campi:=Campi + ',ACCESSO,CAPTION_LAYOUT';
  end;
  if Sort = '' then
    Sort:='NOME_LOGICO,POSIZIONE';
  SQL.Clear;
  SQL.Add('SELECT ' + Campi + ' FROM (');
  SQL.Add('  SELECT COLUMN_NAME NOME_CAMPO,DATA_TYPE,DATA_LENGTH,TABLE_NAME,COLUMN_ID,NVL(LTRIM(RTRIM(NOME_LOGICO)),COLUMN_NAME) NOME_LOGICO,RICERCA,POSIZIONE,VAL_DEFAULT,DATA_DEFAULT,PROVVEDIMENTO');
  SQL.Add('  ,INSTR(COLUMN_NAME,''T430D_'') + INSTR(COLUMN_NAME,''P430D_'') CAMPO_DESCRIZIONE');
  if Layout <> '' then
  begin
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
    // aggiunta dati di T033 finalizzati all'ordinamento della scheda anagrafe
    //SQL.Add('  ,T033.ACCESSO,T033.CAPTION CAPTION_LAYOUT');
    SQL.Add('  ,T033.ACCESSO,T033.CAPTION CAPTION_LAYOUT,T033.NOMEPAGINA,T033.TOP,T033.LFT');
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
  end;
  SQL.Add('  FROM');
  SQL.Add('  (SELECT COLUMN_NAME,DATA_TYPE,DATA_LENGTH,TABLE_NAME,COLUMN_ID,DATA_DEFAULT FROM COLS WHERE TABLE_NAME IN (''T030_ANAGRAFICO'',''V430_STORICO'')');
  SQL.Add('   UNION ALL');
  SQL.Add('   SELECT COLUMN_NAME,DATA_TYPE,DATA_LENGTH,TABLE_NAME,COLUMN_ID,DATA_DEFAULT FROM COLS WHERE TABLE_NAME = ''T480_COMUNI'' AND COLUMN_NAME IN (''CITTA'',''PROVINCIA''))');
  SQL.Add('  ,I010_CAMPIANAGRAFICI I010');
  if Layout <> '' then
    SQL.Add('  ,T033_LAYOUT T033');
  SQL.Add('  WHERE');
  SQL.Add('  COLUMN_NAME = NOME_CAMPO(+) AND');
  SQL.Add('  APPLICAZIONE(+) = DECODE(:APPLICAZIONE,''PAGHE'',''PAGHE'',''*'')');
  if Layout <> '' then
  begin
    SQL.Add('  AND');
    SQL.Add('  T033.NOME(+) = ''' + Layout + ''' AND');
    // daniloc.ini: decodifica diciture fisse campi T033 - 22.02.2010
    //SQL.Add('  T033.CAMPODB(+) = REPLACE(REPLACE(REPLACE(REPLACE(I010.NOME_CAMPO,''T430D_'',''''),''P430D_'',''''),''T430'',''''),''P430'','''')');
    SQL.Add('  T033.CAMPODB(+) = REPLACE(REPLACE(REPLACE(REPLACE(');
    SQL.Add('   DECODE(I010.NOME_CAMPO,');
    SQL.Add('          ''COMUNENAS'',''DescComune'',');
    SQL.Add('          ''CITTA'',''DescComune'',');
    SQL.Add('          ''PROVINCIA'',''D_ProvinciaNas'',');
    SQL.Add('          ''T430COMUNE'',''D_Comune'',');
    SQL.Add('          ''T430D_COMUNE'',''D_Comune'',');
    SQL.Add('          ''T430D_PROVINCIA'',''D_Provincia'',');
    SQL.Add('          ''T430COMUNE_DOM_BASE'',''D_COMUNE_DOM_BASE'',');
    SQL.Add('          ''T430D_COMUNE_DOM_BASE'',''D_COMUNE_DOM_BASE'',');
    SQL.Add('          ''T430D_PROVINCIA_DOM_BASE'',''D_PROVINCIA_DOM_BASE'',');
    SQL.Add('          I010.NOME_CAMPO),');
    SQL.Add('  ''T430D_'',''''),''P430D_'',''''),''T430'',''''),''P430'','''')');
    // daniloc.fine
  end;
  SQL.Add(')');
  if Where <> '' then
    SQL.Add('WHERE ' + Where);
  SQL.Add('ORDER BY ' + Sort);
  DeclareVariable('APPLICAZIONE',otString);
  SetVariable('APPLICAZIONE',Applicazione);
  Session:=Sessione;
  Open;
end;

destructor TselI010.Destroy;
begin
  Close;
  inherited Destroy;
end;

end.
