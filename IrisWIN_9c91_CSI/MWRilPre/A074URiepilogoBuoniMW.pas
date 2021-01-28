unit A074URiepilogoBuoniMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW,USelI010, DB,A000UCostanti, A000USessione,A000UInterfaccia,
  OracleData, Oracle, R350UCalcoloBuoniDtM;

type
  TA074FRiepilogoBuoniMW = class(TR005FDataModuleMW)
    dsrI010: TDataSource;
    selMaxAcquisto: TOracleDataSet;
    selCountAcquisto: TOracleDataSet;
    delT690: TOracleQuery;
    selT191: TOracleDataSet;
    dsrT191: TDataSource;
    selMaxAcquistoAuto: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT191AfterOpen(DataSet: TDataSet);
  private
    selI010: TselI010;
  public
    R350FCalcoloBuoniDtM:TR350FCalcoloBuoniDtM;
    function getUltimoAcquisto: TDateTime;
    procedure CountUltimoAcquisto(var DataUltimoAcquisto: TDateTime; var Count:Integer);
    procedure EliminaAcquisto(Data: TDateTime);
    function getUltimoAcquistoAuto: TDateTime;
    procedure CreaTabellaStampa;
    function GetRigaFile(Acquisto: Integer; SiglaTestata, CodCliente,
                         ValoreBuono, CampoRagg, FormatoMatricola: String;
                         var RaggruppamentoGemeaz, Intestazione: String; TipoFile: Integer): String;
    { Public declarations }
  end;

{$IFNDEF WEBPJ}
var
  A074FRiepilogoBuoniMW: TA074FRiepilogoBuoniMW;
{$ENDIF}

implementation

{$R *.dfm}

procedure TA074FRiepilogoBuoniMW.CountUltimoAcquisto(
  var DataUltimoAcquisto: TDateTime; var Count: Integer);
begin
  try
    with selCountAcquisto do
    begin
      Open;
      DataUltimoAcquisto:=FieldByName('DATA').AsDateTime;
      Count:=FieldByName('TOT').AsInteger;
    end;
  finally
    selCountAcquisto.Close;
  end;

end;

procedure TA074FRiepilogoBuoniMW.CreaTabellaStampa;
begin
  with R350FCalcoloBuoniDtM do
  begin
    TabellaStampa.Close;
    TabellaStampa.FieldDefs.Clear;
    TabellaStampa.FieldDefs.Add('Raggruppamento',ftString,60,False);
    TabellaStampa.FieldDefs.Add('Nome',ftString,60,False);
    TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
    TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
    TabellaStampa.FieldDefs.Add('Manuale',ftString,1,False);
    TabellaStampa.FieldDefs.Add('Buoni',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('Ticket',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('Tipo',ftstring,1,False);
    TabellaStampa.FieldDefs.Add('RecuperoPrec',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('RecuperoAtt',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('ResiduoPrec',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('ResiduoAtt',ftInteger,0,False);
    TabellaStampa.FieldDefs.Add('ObblSuppl',ftString,1,False);
    TabellaStampa.FieldDefs.Add('Anomalia',ftString,8,False);
    TabellaStampa.FieldDefs.Add('Stampa',ftBoolean,0,False);
    TabellaStampa.IndexDefs.Clear;
    TabellaStampa.IndexDefs.Add('Primario',('Raggruppamento;Nome;Matricola;Data;Manuale'),[ixUnique]);
    TabellaStampa.IndexName:='Primario';
    TabellaStampa.CreateDataSet;
    TabellaStampa.LogChanges:=False;
  end;
end;

procedure TA074FRiepilogoBuoniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  dsrI010.DataSet:=selI010;
  selT191.Open;
  R350FCalcoloBuoniDtM:=TR350FCalcoloBuoniDtM.Create(nil);
end;

procedure TA074FRiepilogoBuoniMW.EliminaAcquisto(Data: TDateTime);
begin
  delT690.SetVariable('DATA',Data);
  delT690.Execute;
  RegistraLog.SettaProprieta('C','T690_ACQUISTOBUONI',NomeOwner,nil,True);
  RegistraLog.InserisciDato('DATA ACQUISTO',DateToStr(Data),'');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

function TA074FRiepilogoBuoniMW.getUltimoAcquisto: TDateTime;
begin
  selMaxAcquisto.Open;
  Result:=selMaxAcquisto.FieldByName('ULTIMOACQUISTO').AsDateTime;

  selMaxAcquisto.Close;
end;

function TA074FRiepilogoBuoniMW.getUltimoAcquistoAuto: TDateTime;
begin
  selMaxAcquistoAuto.Open;
  Result:=selMaxAcquistoAuto.FieldByName('ULTIMOACQUISTO').AsDateTime;

  selMaxAcquistoAuto.Close;
end;

procedure TA074FRiepilogoBuoniMW.selT191AfterOpen(DataSet: TDataSet);
begin
  inherited;
  selT191.FieldByName('CODICE').DisplayWidth:=7;
end;

function TA074FRiepilogoBuoniMW.GetRigaFile(Acquisto:Integer;SiglaTestata,CodCliente,ValoreBuono,CampoRagg,FormatoMatricola:String; var RaggruppamentoGemeaz:String;var Intestazione: String; TipoFile:Integer):String;
{Generazione file sequenziale:
 tracciato x ASL Varese (GEMEAZ CUSIN)
 tracciato x ASL Monza}
var
  Nome,Q,Matricola,Campo:String;
  iLunMatr,
  iLungMatrAnag,
  iPosiMatrFile,
  iLungMatrFile,
  i: Integer;
  LFormatoMatricola: TStringList;
  function GetIntestazione:String;
  begin
    //Result:=Format('TR1%5s%-5s00%5s00000            TR1',[Copy(A074FGemeaz.edtCodCliente.Text,1,5),Copy(Campo,1,5),Copy(A074FGemeaz.edtValoreBuono.Text,1,5)]);
    Result:=Format('%s1%5s%-5s00%5s00000            %s1',[SiglaTestata,CodCliente,Copy(Campo,1,5),Copy(ValoreBuono,1,5),SiglaTestata]);
  end;
begin
  iLungMatrAnag:=5;
  iPosiMatrFile:=1;
  iLungMatrFile:=5;
  LFormatoMatricola:=TStringList.Create;
  try
    LFormatoMatricola.CommaText:=FormatoMatricola;
    for i:=0 to LFormatoMatricola.Count - 1 do
    begin
      if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'LA' then
        iLungMatrAnag:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),5)
      else if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'PS' then
        iPosiMatrFile:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),1)
      else if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'LF' then
        iLungMatrFile:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),5)
    end;
  finally
    LFormatoMatricola.Free;
  end;

  with selAnagrafe do
  begin
    Nome:=Copy(FieldByName('COGNOME').AsString + ' ' + FieldByName('NOME').AsString,1,30);
    iLunMatr:=iLungMatrAnag - Length(Trim(FieldByName('MATRICOLA').AsString));
    if iLunMatr > 0 then
      Matricola:=Format('%.*d',[iLunMatr,0]) + FieldByName('MATRICOLA').AsString
    else
      Matricola:=FieldByName('MATRICOLA').AsString;
    Matricola:=Copy(Matricola,iPosiMatrFile,iLungMatrFile);
    Campo:='';
    if CampoRagg <> '' then
    try
      Campo:=Copy(FieldByName(CampoRagg).AsString,1,6);
    except
      Campo:='';
    end;
  end;
  Q:=Copy(Format('%.2d',[Acquisto]),1,2);
  if TipoFile = 0 then
    Result:=Format('%s2%-30s%s%5s',[SiglaTestata,Nome,Q,Matricola])
  else
    Result:=Format('%s2%-30s%s%5s%-6s',[SiglaTestata,Nome,Q,Matricola,Campo]);
  Intestazione:='';
  if (TipoFile = 0) and
     (Campo <> RaggruppamentoGemeaz) then
  begin
    Intestazione:=GetIntestazione;
    RaggruppamentoGemeaz:=Campo;
  end;
end;
procedure TA074FRiepilogoBuoniMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  R350FCalcoloBuoniDtM.TabellaStampa.Close;
  FreeAndNil(R350FCalcoloBuoniDtM);
  inherited;
end;

end.
