unit A143UMedicineLegaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle,
  A000UInterfaccia, C180FunzioniGenerali, QueryPK;

type
  TA143FMedicineLegaliDtm = class(TR004FGestStoricoDtM)
    selT485: TOracleDataSet;
    selT480: TOracleDataSet;
    dscT480: TDataSource;
    selT485CODICE: TStringField;
    selT485DESCRIZIONE: TStringField;
    selT485COD_COMUNE: TStringField;
    selT485INDIRIZZO: TStringField;
    selT485CAP: TStringField;
    selT485TELEFONO: TStringField;
    selT485EMAIL: TStringField;
    selT485D_COMUNE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT485COD_COMUNEValidate(Sender: TField);
  private
    { Private declarations }
    function CheckEmail: Boolean;
  public
    { Public declarations }
  end;

var
  A143FMedicineLegaliDtm: TA143FMedicineLegaliDtm;

implementation

uses A143UMedicineLegali;

{$R *.dfm}

procedure TA143FMedicineLegaliDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT485,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT485.Open;
  selT480.Open;
end;

procedure TA143FMedicineLegaliDtm.DataModuleDestroy(Sender: TObject);
begin
  selT485.Close;
  selT480.Close;
  inherited;
end;

procedure TA143FMedicineLegaliDtm.selT485COD_COMUNEValidate(Sender: TField);
begin
  inherited;
  // propone il CAP per il comune selezionato
  if not selT485COD_COMUNE.IsNull then
    selT485CAP.AsString:=selT480.FieldByName('CAP').AsString;
end;

function TA143FMedicineLegaliDtm.CheckEmail: Boolean;
{ confronta l'email rispetto al modello [user] @ [dominio]
  il metodo è un po' artigianale, ma dovrebbe evitare gli errori più grossolani }
var
  PosAt, PosDot: Integer;
  Dominio, LastToken: String;
begin
  Result:=True;

  // email vuota -> ok
  if Trim(selT485EMAIL.AsString) = '' then
    Exit;

  // cerca il simbolo "@" nell'email
  PosAt:=Pos('@', selT485EMAIL.AsString);
  Result:=(PosAt > 0);
  if not Result then
    Exit;

  // considera la parte dopo la "@" (il dominio)
  Dominio:=Copy(selT485EMAIL.AsString, PosAt + 1, Length(selT485EMAIL.AsString) - PosAt + 1);

  // verifica la presenza di un altro simbolo "@"
  Result:=(Pos('@', Dominio) <= 0);
  if not Result then
    Exit;

  // cerca il simbolo "punto" (.) dopo la chiocciolina
  PosDot:=Pos('.', Dominio);
  Result:=(PosDot > 0);
  if not Result then
    Exit;

  // considera la parte dopo il punto
  LastToken:=Copy(Dominio, PosDot + 1, Length(Dominio) - PosDot + 1);

  // verifica la presenza di una stringa non vuota dopo il punto
  Result:=(Trim(LastToken) <> '');
end;

procedure TA143FMedicineLegaliDtm.BeforePostNoStorico(DataSet: TDataSet);
{ controlli generici oltre il validate di ogni singolo campo }
begin
  inherited;

  // codice obbligatorio
  if selT485CODICE.AsString = '' then
    raise Exception.Create('Indicare il codice della medicina legale!');

  // descrizione obbligatoria
  if selT485DESCRIZIONE.AsString = '' then
    raise Exception.Create('Indicare la descrizione della medicina legale!');

  // email valida  
  if not CheckEmail then
    if R180MessageBox('L''indirizzo e-mail indicato non è valido.' + #13#10 +
                      'Vuoi continuare?', DOMANDA) = mrNo then
      Abort

end;

end.
