unit A102UParScaricoGiustDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A000UInterfaccia;

type
  TA102FParScaricoGiustDtM = class(TR004FGestStoricoDtM)
    selI150: TOracleDataSet;
    selI150CODICE: TStringField;
    selI150NOMEFILE: TStringField;
    selI150CORRENTE: TStringField;
    selI150MATRICOLA: TStringField;
    selI150BADGE: TStringField;
    selI150ANNODA: TStringField;
    selI150MESEDA: TStringField;
    selI150GIORNODA: TStringField;
    selI150ANNOA: TStringField;
    selI150MESEA: TStringField;
    selI150GIORNOA: TStringField;
    selI150ORADA: TStringField;
    selI150MINDA: TStringField;
    selI150ORAA: TStringField;
    selI150MINA: TStringField;
    selI150CAUSALE: TStringField;
    selI150TIPO: TStringField;
    selI150DATADA: TStringField;
    selI150NUMGIORNI: TStringField;
    selI150CODICE_TIPOI: TStringField;
    selI150CODICE_TIPOM: TStringField;
    selI150CODICE_TIPOD: TStringField;
    selI150CODICE_TIPON: TStringField;
    selI150SEPARATORE: TStringField;
    selI150FORMATODATA: TStringField;
    selI150DESCCAUSALE: TStringField;
    selI150AZIENDA: TStringField;
    selI090: TOracleDataSet;
    dsrI090: TDataSource;
    selI150MATRICOLA_NUMERICA: TStringField;
    selI150TIPOFILE: TStringField;
    selI150ID: TStringField;
    selI150TIPO_OPERAZIONE: TStringField;
    selI150FAMILIARE: TStringField;
    selI150MESSAGGIO: TStringField;
    selI150ELABORATO: TStringField;
    selI150DATA_ELABORAZIONE: TStringField;
    selI150DATAA: TStringField;
    selI150HHMMDA: TStringField;
    selI150HHMMA: TStringField;
    selI150ANOMALIE_BLOCCANTI: TStringField;
    procedure selI150AfterScroll(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI150NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetNomeCampo(idx:Integer):String;
  end;

var
  A102FParScaricoGiustDtM: TA102FParScaricoGiustDtM;

implementation

uses A102UParScaricoGiust;

{$R *.dfm}

procedure TA102FParScaricoGiustDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selI150,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI150.Filter:='AZIENDA = ''' +   Parametri.Azienda + '''';
    selI150.Filtered:=True;
  end;
  selI150.Open;
  selI090.Open;
  if Parametri.Azienda <> 'AZIN' then
  begin
    selI090.Filtered:=False;
    selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selI090.Filtered:=True;
  end;
end;

function TA102FParScaricoGiustDtM.GetNomeCampo(idx:Integer):String;
{idx = indice della cella}
begin
  Result:='';
  case idx of
    1:Result:='MATRICOLA';
    2:Result:='BADGE';
    3:Result:='ANNODA';
    4:Result:='MESEDA';
    5:Result:='GIORNODA';
    6:Result:='ANNOA';
    7:Result:='MESEA';
    8:Result:='GIORNOA';
    9:Result:='ORADA';
    10:Result:='MINDA';
    11:Result:='ORAA';
    12:Result:='MINA';
    13:Result:='CAUSALE';
    14:Result:='TIPO';
    15:Result:='DATADA';  //Lorena 11/08/2005
    16:Result:='DATAA';    //Norman 20/02/2007
    17:Result:='NUMGIORNI';  //Lorena 11/08/2005
    18:Result:='ID';        //Norman 20/02/2007
    19:Result:='TIPO_OPERAZIONE';  //Norman 20/02/2007
    20:Result:='FAMILIARE';        //Norman 20/02/2007
    21:Result:='MESSAGGIO';        //Norman 20/02/2007
    22:Result:='ELABORATO';        //Norman 20/02/2007
    23:Result:='DATA_ELABORAZIONE';  //Norman 20/02/2007
    24:Result:='HHMMDA';  //Norman 05/03/2007
    25:Result:='HHMMA';  //Norman 05/03/2007
  end;
end;


procedure TA102FParScaricoGiustDtM.selI150NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('CODICE_TIPOI').AsString:='I';
  DataSet.FieldByName('CODICE_TIPOM').AsString:='M';
  DataSet.FieldByName('CODICE_TIPOD').AsString:='D';
  DataSet.FieldByName('CODICE_TIPON').AsString:='N';
  DataSet.FieldByName('CORRENTE').AsString:='N';
  if selI150.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    DataSet.FieldByName('MATRICOLA').AsString:='0,0';
    DataSet.FieldByName('BADGE').AsString:='0,0';
    DataSet.FieldByName('ANNODA').AsString:='0,0';
    DataSet.FieldByName('MESEDA').AsString:='0,0';
    DataSet.FieldByName('GIORNODA').AsString:='0,0';
    DataSet.FieldByName('ANNOA').AsString:='0,0';
    DataSet.FieldByName('MESEA').AsString:='0,0';
    DataSet.FieldByName('GIORNOA').AsString:='0,0';
    DataSet.FieldByName('ORADA').AsString:='0,0';
    DataSet.FieldByName('MINDA').AsString:='0,0';
    DataSet.FieldByName('ORAA').AsString:='0,0';
    DataSet.FieldByName('MINA').AsString:='0,0';
    DataSet.FieldByName('CAUSALE').AsString:='0,0';
    DataSet.FieldByName('TIPO').AsString:='0,0';
    DataSet.FieldByName('DATADA').AsString:='0,0';  //Lorena 12/08/2005
    DataSet.FieldByName('DATAA').AsString:='0,0';
    DataSet.FieldByName('NUMGIORNI').AsString:='0,0'; //Lorena 12/08/2005
  end;
end;

procedure TA102FParScaricoGiustDtM.BeforePostNoStorico(DataSet: TDataSet);
{Copio i dati della griglia nei campi corrispondenti prima di confermare le modifiche}
var i:Byte;
    P,L:Word;
begin
  inherited;
  with A102FParScaricoGiust do
  begin
    for i:=1 to StringGrid1.ColCount - 1 do
    begin
      if selI150.FieldByName('TIPOFILE').AsString = 'F' then
      begin
        P:=StrToIntDef(StringGrid1.Cells[i,1],0);
        L:=StrToIntDef(StringGrid1.Cells[i,2],0);
        selI150.FieldByName(GetNomeCampo(i)).AsString:=IntToStr(P) + ',' + IntToStr(L);
      end
      else
        selI150.FieldByName(GetNomeCampo(i)).AsString:=StringGrid1.Cells[i,1];
    end;
  end;
end;

procedure TA102FParScaricoGiustDtM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=selI150Codice.AsString;
  inherited;
  selI150.Locate('Codice',S,[]);
end;

procedure TA102FParScaricoGiustDtM.selI150AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if selI150.FieldByName('TIPOFILE').AsString = 'F' then
  begin
    with A102FParScaricoGiust.StringGrid1 do
    begin
      RowCount:=3;
      ColWidths[0]:=40;
      Cells[0,1]:='Pos.';
      Cells[0,2]:='Lung.';
    end;
  end
  else
  begin
    with A102FParScaricoGiust.StringGrid1 do
    begin
      RowCount:=2;
      ColWidths[0]:=60;
      Cells[0,1]:='Campo';
    end;
  end;
end;

end.
