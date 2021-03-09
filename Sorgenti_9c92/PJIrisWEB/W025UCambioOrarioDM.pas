unit W025UCambioOrarioDM;

interface

uses
  SysUtils, StrUtils, Classes, Oracle, DB, OracleData,
  A000UInterfaccia, C180FunzioniGenerali;

type
  TW025FCambioOrarioDM = class(TDataModule)
    selT085: TOracleDataSet;
    selT085DATA: TDateTimeField;
    selT085TIPOGIORNO: TStringField;
    selT085ORARIO: TStringField;
    selT085Desc_Orario: TStringField;
    selT085DATA_INVER: TDateTimeField;
    selT085TIPOGIORNO_INVER: TStringField;
    selT085ORARIO_INVER: TStringField;
    selT085Desc_Orario_Inver: TStringField;
    selT085SOLO_NOTE: TStringField;
    selT085Desc_Solo_Note: TStringField;
    selT085MESSAGGI: TStringField;
    selT085CF_Data: TStringField;
    selT085CF_Orario: TStringField;
    selT085CF_Data_Inver: TStringField;
    selT085CF_Orario_Inver: TStringField;
    selOrario: TOracleQuery;
    selOrario2: TOracleDataSet;
    selaT085: TOracleQuery;
    selaT020: TOracleDataSet;
    selT012: TOracleDataSet;
    selT085ID: TFloatField;
    selT085ID_REVOCA: TFloatField;
    selT085ID_REVOCATO: TFloatField;
    selT085PROGRESSIVO: TIntegerField;
    selT085NOMINATIVO: TStringField;
    selT085MATRICOLA: TStringField;
    selT085SESSO: TStringField;
    selT085COD_ITER: TStringField;
    selT085TIPO_RICHIESTA: TStringField;
    selT085AUTORIZZ_AUTOMATICA: TStringField;
    selT085REVOCABILE: TStringField;
    selT085DATA_RICHIESTA: TDateTimeField;
    selT085LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT085DATA_AUTORIZZAZIONE: TDateTimeField;
    selT085AUTORIZZAZIONE: TStringField;
    selT085NOMINATIVO_RESP: TStringField;
    selT085AUTORIZZ_AUTOM_PREV: TStringField;
    selT085AUTORIZZ_PREV: TStringField;
    selT085RESPONSABILE_PREV: TStringField;
    selT085AUTORIZZ_UTILE: TStringField;
    selT085AUTORIZZ_REVOCA: TStringField;
    selT085D_TIPO_RICHIESTA: TStringField;
    selT085D_RESPONSABILE: TStringField;
    selT085D_AUTORIZZAZIONE: TStringField;
    selV010: TOracleDataSet;
    selT080: TOracleDataSet;
    procedure selT085CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TW025FCambioOrarioDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
 except
 end;
end;

procedure TW025FCambioOrarioDM.selT085CalcFields(DataSet: TDataSet);
var S:String;
  function RicavaDescrizioneOrario(Orario: String;Data: TDateTime): String;
  begin
    Result:='';
    with selaT020 do
    begin
      SetVariable('ORARIO',Orario);
      SetVariable('DATA',Data);
      Open;
      if not Eof then
        Result:=FieldByName('DESCRIZIONE').AsString;
      Close;
    end;
  end;
begin
  with selT085 do
  begin
    FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';
    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;
    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);
    FieldByName('Desc_Orario').AsString:=RicavaDescrizioneOrario(FieldByName('ORARIO').AsString,FieldByName('DATA').AsDateTime);
    FieldByName('Desc_Orario_Inver').AsString:=RicavaDescrizioneOrario(FieldByName('ORARIO_INVER').AsString,FieldByName('DATA_INVER').AsDateTime);
    FieldByName('Desc_Solo_Note').AsString:=IfThen(FieldByName('SOLO_NOTE').AsString = 'S','Si',IfThen(FieldByName('SOLO_NOTE').AsString = 'N','No',''));
    FieldByName('CF_Data').AsString:=Copy(R180NomeGiorno(FieldByName('DATA').AsDateTime),1,3) + ' ' + FormatDateTime('dd/mm/yyyy',FieldByName('DATA').AsDateTime);
    FieldByName('CF_Orario').AsString:=IfThen(FieldByName('SOLO_NOTE').AsString = 'S','',Format('%-5s %s',[FieldByName('ORARIO').AsString,FieldByName('Desc_Orario').AsString]));
    FieldByName('CF_Data_Inver').AsString:=IfThen(FieldByName('SOLO_NOTE').AsString = 'S','',Copy(R180NomeGiorno(FieldByName('DATA_INVER').AsDateTime),1,3) + ' ' + FormatDateTime('dd/mm/yyyy',FieldByName('DATA_INVER').AsDateTime));
    FieldByName('CF_Orario_Inver').AsString:=IfThen(FieldByName('SOLO_NOTE').AsString = 'S','',Format('%-5s %s',[FieldByName('ORARIO_INVER').AsString,FieldByName('Desc_Orario_Inver').AsString]));
  end;
end;

end.
