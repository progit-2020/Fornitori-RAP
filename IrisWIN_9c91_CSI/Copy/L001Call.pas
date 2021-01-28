unit L001Call;

interface

uses Forms, Dialogs, SysUtils, Db, Variants, A000UInterfaccia;

type
  TInserisciDLL = record
    NomeTabella:String;
    Titolo:string;
    Display:array [0..8] of String;
    Size:array [0..8] of integer;
    FiltroDizAllinea: String;
  end;

procedure Inserisci(var Griglia:TInserisciDLL;Cod:String;Filter:string='');
procedure RidefAnag(DefCampi:TFieldDefs);

implementation

uses
  L001UTabelle,
  L001UCampiAnagrafe;

procedure Inserisci(var Griglia:TInserisciDLL;Cod:String;Filter:string='');
{Generica griglia per tabelle}
var i:integer;
begin
  L001FTabelle:=TL001FTabelle.create(nil);
  try
    with L001FTabelle do
    begin
      NomeTabella:=Griglia.NomeTabella;
      FiltroDizAllinea:=Griglia.FiltroDizAllinea;
      Caption:=Griglia.Titolo;
      Table1.Close;
      Table1.SQL.Clear;
      Table1.Filtered:=False;
      if Griglia.NomeTabella = 'T480_COMUNI' then
        Table1.SQL.Add(Format('SELECT T1.*,T1.ROWID FROM %s T1 ORDER BY CITTA',[Griglia.NomeTabella]))
      else if Griglia.NomeTabella = 'SG111_ESPERIENZE' then
        Table1.SQL.Add(Format('SELECT T1.*,T1.ROWID FROM %s T1 ORDER BY POSIZIONE,CODICE',[Griglia.NomeTabella]))
      else if Griglia.NomeTabella = 'P447_CEDOLINOPARK' then
        Table1.SQL.Add(Format('SELECT T1.COD_CEDOLINOPARK,T1.DESCRIZIONE FROM %s T1 WHERE SUBSTR(COD_CEDOLINOPARK,1,4) <> ''COAN'' ORDER BY 1',[Griglia.NomeTabella]))
      else
        Table1.SQL.Add(Format('SELECT T1.*,T1.ROWID FROM %s T1 ORDER BY 1',[Griglia.NomeTabella]));
      Table1.Open;
      Table1.Filter:=Filter;
      if Trim(Filter) <> '' then
        Table1.Filtered:=True;
      for i:=0 to Table1.FieldCount -1 do
        begin
        Table1.Fields[i].DisplayLabel:=Griglia.Display[i];
        Table1.Fields[i].DisplayWidth:=Griglia.Size[i];
      end;
      Table1.Locate(Table1.Fields[0].DisplayLabel,Cod,[]);
      ShowModal;
    end;
  finally
    FreeAndNil(L001FTabelle);
  end;
end;

procedure RidefAnag(DefCampi:TFieldDefs);
{Ridefinizione campi anagrafe}
begin
  L001FCampiAnagrafe:=TL001FCampiAnagrafe.Create(nil);
  with L001FCampiAnagrafe do
    try
      DefAnagrafe:=DefCampi;
      I010.SetVariable('APPLICAZIONE',Parametri.Applicazione);
      // daniloc 05.10.2009 modifica ordinamento
      //I010.SetVariable('ORDINAMENTO','RICERCA,POSIZIONE,NOME_CAMPO');
      I010.SetVariable('ORDINAMENTO','nvl(RICERCA,99999999), nvl(POSIZIONE,99999999), NOME_LOGICO');
      I010.Open;
      ShowModal;
    finally
      Free;
    end;
end;

end.
