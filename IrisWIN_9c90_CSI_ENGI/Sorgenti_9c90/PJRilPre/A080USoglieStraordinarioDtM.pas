unit A080USoglieStraordinarioDtM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData,
  A000UInterfaccia, C180FunzioniGenerali;

type
  TA080FSoglieStraordinarioDtM = class(TR004FGestStoricoDtM)
    selT027: TOracleDataSet;
    selT028: TOracleDataSet;
    selT028SOGLIA: TStringField;
    selT028CAUSALE_GGLAV: TStringField;
    selT028CAUSALE_GGNONLAV: TStringField;
    selT275: TOracleDataSet;
    selT028D_CAUSALE_GGLAV: TStringField;
    selT028D_CAUSALE_GGNONLAV: TStringField;
    selT028ID: TFloatField;
    selT027ID: TFloatField;
    selT027TIPOCARTELLINO: TStringField;
    selT027DECORRENZA: TDateTimeField;
    selT027DECORRENZA_FINE: TDateTimeField;
    selT027SELEZIONE_ANAGRAFE: TStringField;
    selT027CAUSALI_GGLAV: TStringField;
    selT027CAUSALI_GGNONLAV: TStringField;
    selT028ESPRESSIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT027AfterScroll(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT028NewRecord(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selT028BeforePost(DataSet: TDataSet);
    procedure selT027BeforeEdit(DataSet: TDataSet);
    procedure AfterCancel(DataSet: TDataSet);
  private
    { Private declarations }
    FTipoCartellino:String;
    procedure PutTipoCartellino(Valore:String);
    procedure VerificaOreNormali(Campo:String);
  public
    { Public declarations }
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

var
  A080FSoglieStraordinarioDtM: TA080FSoglieStraordinarioDtM;

implementation

{$R *.dfm}

uses A080USoglieStraordinario;

procedure TA080FSoglieStraordinarioDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=TA080FSoglieStraordinario(Owner).InterfacciaR004;
  InizializzaDataSet(selT027,[evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  selT275.Open;
end;

procedure TA080FSoglieStraordinarioDtM.PutTipoCartellino(Valore:String);
begin
  FTipoCartellino:=Valore;
  R180SetVariable(selT027,'TIPOCARTELLINO',FTipoCartellino);
  selT027.Open;
end;

procedure TA080FSoglieStraordinarioDtM.BeforePost(DataSet: TDataSet);
var i:Integer;
begin
  if not selT027.FieldByName('CAUSALI_GGNONLAV').IsNull then
    with TStringList.Create do
    try
      CommaText:=selT027.FieldByName('CAUSALI_GGNONLAV').AsString;
      for i:=0 to Count - 1 do
        if R180CercaParolaIntera(Strings[i],selT027.FieldByName('CAUSALI_GGLAV').AsString,',') > 0 then
          raise Exception.Create(Format('Causale %s già utilizzata per i giorni lavorativi!',[Strings[i]]));
    finally
      Free;
    end;
  if selT028.State in [dsEdit,dsInsert] then
    selT028.Post;
  VerificaOreNormali('CAUSALI_GGLAV');
  VerificaOreNormali('CAUSALI_GGNONLAV');
  inherited;
end;

procedure TA080FSoglieStraordinarioDtM.VerificaOreNormali(Campo:String);
var OreNormali1,OreNormali2,Errore:Boolean;
    i:Integer;
    CampoT028,CaptionCampo:String;
begin
  if selT027.FieldByName(CAMPO).IsNull then
    exit;
  Errore:=False;
  CaptionCampo:='Eccedenze gg.' + IfThen(Campo = 'CAUSALI_GGNONLAV','non') + ' lavorativi';
  with TStringList.Create do
  try
    CommaText:=selT027.FieldByName(CAMPO).AsString;
    for i:=0 to Count - 1 do
    begin
      if i = 0 then
      begin
        if Strings[i] = '<*L>' then
          OreNormali1:=True
        else
          OreNormali1:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
        OreNormali2:=OreNormali1;
      end
      else
      begin
        if Strings[i] = '<*L>' then
          OreNormali2:=True
        else
          OreNormali2:=VarToStr(selT275.Lookup('CODICE',Strings[i],'ORENORMALI')) <> 'A';
      end;
      if OreNormali1 <> OreNormali2 then
        raise Exception.Create('In "'+ CaptionCampo + '" sono state specificate causali sia incluse che escluse dalle ore normali.' + #13#10 +
                               'E'' consentito usare causali solo della stessa tipologia.');
    end;
  finally
    Free;
  end;
  if Campo = 'CAUSALI_GGLAV' then
    CampoT028:='CAUSALE_GGLAV'
  else
    CampoT028:='CAUSALE_GGNONLAV';
  with selT028 do
  begin
    First;
    while not Eof do
    begin
      OreNormali2:=VarToStr(selT275.Lookup('CODICE',FieldByName(CampoT028).AsString,'ORENORMALI')) <> 'A';
      if OreNormali1 <> OreNormali2 then
        raise Exception.Create('La causale ' + FieldByName(CampoT028).AsString + ' non è della stessa tipologia delle causali indicate in "' + CaptionCampo + '"');
      Next;
    end;
  end;
end;

procedure TA080FSoglieStraordinarioDtM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  if selT028.UpdatesPending then
    selT028.CancelUpdates;
end;

procedure TA080FSoglieStraordinarioDtM.AfterPost(DataSet: TDataSet);
begin
  if selT028.Active and selT028.UpdatesPending then
  begin
    SessioneOracle.ApplyUpdates([selT028],False);
    selT028.Refresh;
  end;
  inherited;
end;

procedure TA080FSoglieStraordinarioDtM.selT027AfterScroll(DataSet: TDataSet);
begin
  inherited;
  R180SetVariable(selT028,'ID',selT027.FieldByName('ID').AsInteger);
  selT028.Open;
  selT028.ReadOnly:=True;
end;

procedure TA080FSoglieStraordinarioDtM.selT027BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if selT028.UpdatesPending then
    selT028.CancelUpdates;
  selT028.Refresh;
end;

procedure TA080FSoglieStraordinarioDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selT027.FieldByName('TIPOCARTELLINO').AsString:=TipoCartellino;
end;

procedure TA080FSoglieStraordinarioDtM.selT028BeforePost(DataSet: TDataSet);
var S:String;
    N:Extended;
begin
  inherited;
  if (not selT028.FieldByName('CAUSALE_GGLAV').IsNull) and
     (selT028.FieldByName('CAUSALE_GGLAV').AsString = selT028.FieldByName('CAUSALE_GGNONLAV').AsString) then
    raise Exception.Create('Le causali devono dei gg. lav e gg. non lav. essere diverse!');

  if selT028.FieldByName('SOGLIA').IsNull then
    selT028.FieldByName('SOGLIA').AsString:='*';
  S:=selT028.FieldByName('SOGLIA').AsString;
  if S <> '*' then
    if Pos('%',S) > 0 then
    begin
      if not TryStrToFloat(StringReplace(S,'%','',[]),N) then
        raise Exception.Create('La Soglia non è indicata correttamente!');
    end
    else
    try
      selT028.FieldByName('SOGLIA').AsString:=R180MinutiOre(R180OreMinutiExt(S));
    except
      raise Exception.Create('La Soglia non è indicata correttamente!');
    end;
end;

procedure TA080FSoglieStraordinarioDtM.selT028NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT028.FieldByName('ID').AsInteger:=selT027.FieldByName('ID').AsInteger;
end;

end.
