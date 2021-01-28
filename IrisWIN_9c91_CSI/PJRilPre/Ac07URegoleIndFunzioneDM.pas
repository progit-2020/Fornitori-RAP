unit Ac07URegoleIndFunzioneDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Math,
  Ac07URegoleIndFunzioneMW;

type
  TAc07FRegoleIndFunzioneDM = class(TR004FGestStoricoDtM)
    selCSI004: TOracleDataSet;
    selCSI004DECORRENZA: TDateTimeField;
    selCSI004DECORRENZA_FINE: TDateTimeField;
    selCSI004ID: TFloatField;
    selCSI004CODICE: TStringField;
    selCSI004CONTRATTO: TStringField;
    selCSI004D_CODICE: TStringField;
    selCSI004D_CONTRATTO: TStringField;
    dsrCodice: TDataSource;
    dsrT200: TDataSource;
    selCSI004ASSENZE_TOLLERATE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selCSI004AfterScroll(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    Ac07MW:TAc07FRegoleIndFunzioneMW;
  end;

var
  Ac07FRegoleIndFunzioneDM: TAc07FRegoleIndFunzioneDM;

implementation

uses Ac07URegoleIndFunzione;

{$R *.dfm}

procedure TAc07FRegoleIndFunzioneDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=Ac07FRegoleIndFunzione.InterfacciaR004;
  InizializzaDataSet(selCSI004,[evBeforeEdit,
                                evBeforeInsert,
                                evBeforePost,
                                evBeforeDelete,
                                evAfterDelete,
                                evAfterPost,
                                evOnTranslateMessage,
                                evOnNewRecord]);
  Ac07FRegoleIndFunzione.DButton.Dataset:=selCSI004;
  Ac07MW:=TAc07FRegoleIndFunzioneMW.Create(Self);
  Ac07MW.selCSI004:=selCSI004;
  if Parametri.CampiRiferimento.C3_Indennita_Funzione <> '' then
  begin
    selCSI004.FieldByName('D_CODICE').FieldKind:=fkLookup;
    selCSI004.FieldByName('D_CODICE').LookupDataset:=Ac07MW.selCodice;
    selCSI004.FieldByName('D_CODICE').KeyFields:='CODICE';
    selCSI004.FieldByName('D_CODICE').LookupKeyFields:='CODICE';
    selCSI004.FieldByName('D_CODICE').LookupResultField:='DESCRIZIONE';
    Ac07MW.CaricamentoDati(Ac07MW.selCodice,Parametri.CampiRiferimento.C3_Indennita_Funzione,InterfacciaR004.DataLavoro);
    dsrCodice.DataSet:=Ac07MW.selCodice;
  end
  else
  begin
    selCSI004.FieldByName('D_CODICE').Free;
    Ac07FRegoleIndFunzione.dlblCodice.DataSource:=nil;
  end;
  selCSI004.FieldByName('D_CONTRATTO').FieldKind:=fkLookup;
  selCSI004.FieldByName('D_CONTRATTO').LookupDataSet:=Ac07MW.selT200;
  selCSI004.FieldByName('D_CONTRATTO').KeyFields:='CONTRATTO';
  selCSI004.FieldByName('D_CONTRATTO').LookupKeyFields:='CODICE';
  selCSI004.FieldByName('D_CONTRATTO').LookupResultField:='DESCRIZIONE';
  dsrT200.DataSet:=Ac07MW.selT200;
  selCSI004.Open;
end;

procedure TAc07FRegoleIndFunzioneDM.selCSI004AfterScroll(DataSet: TDataSet);
begin
  Ac07MW.selCSI004AfterScroll;
  Ac07FRegoleIndFunzione.AbilitaComponenti;
end;

procedure TAc07FRegoleIndFunzioneDM.BeforePost(DataSet: TDataSet);
begin
  Ac07MW.selCSI004BeforePost(InterfacciaR004.StoricizzazioneInCorso);
  inherited;
end;

procedure TAc07FRegoleIndFunzioneDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  Ac07MW.selCSI004AfterPost;
end;

end.
