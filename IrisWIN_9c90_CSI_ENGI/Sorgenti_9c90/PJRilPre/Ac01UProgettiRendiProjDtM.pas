unit Ac01UProgettiRendiProjDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, Oracle, OracleData, C700USelezioneAnagrafe,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Math,
  Ac01UProgettiRendiProjMW;

type
  TAc01FProgettiRendiProjDtM = class(TR004FGestStoricoDtM)
    selT750: TOracleDataSet;
    selT750DECORRENZA: TDateTimeField;
    selT750DECORRENZA_FINE: TDateTimeField;
    selT750DESCRIZIONE: TStringField;
    selT750ID: TFloatField;
    selT750NOTE: TStringField;
    selT750ORE_MAX: TStringField;
    selT750TOT_ORE_FRUITO: TStringField;
    selT750TOT_ORE_MAX: TStringField;
    selT750CODICE: TStringField;
    selT750CHIUSURA_DAL: TDateTimeField;
    selT750CHIUSURA_AL: TDateTimeField;
    selT750CAUASSPRES_INCLUSE: TStringField;
    selT750PARTNER_NUMBER: TStringField;
    selT750NOMINATIVO_RESP: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT750AfterScroll(DataSet: TDataSet);
    procedure selT750CalcFields(DataSet: TDataSet);
    procedure selT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT750ORE_MAXValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    Ac01MW:TAc01FProgettiRendiProjMW;
  end;

var
  Ac01FProgettiRendiProjDtM: TAc01FProgettiRendiProjDtM;

implementation

uses Ac01UProgettiRendiProj;

{$R *.dfm}

procedure TAc01FProgettiRendiProjDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=Ac01FProgettiRendiProj.InterfacciaR004;
  //GestioneDecorrenzaFine = True, permette di sfruttare i comportamenti standard relativi al campo DECORRENZA_FINE
  //AllineaSoloDecorrenzeIntersecanti = True, permette di lasciare dei "buchi" tra i periodi storici e di forzare il 31/12/3999 sull'ultimo periodo
  //InterfacciaR004.GestioneDecorrenzaFine:=False;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;

  InizializzaDataSet(selT750,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage,
                              evOnNewRecord]);
  Ac01FProgettiRendiProj.DButton.Dataset:=selT750;
  Ac01MW:=TAc01FProgettiRendiProjMW.Create(Self);
  Ac01MW.selT750:=selT750;
  Ac01MW.AggiornaRiepilogo:=Ac01FProgettiRendiProj.AggiornaRiepilogo;
  Ac01MW.AggiornaColoreRiepilogo:=Ac01FProgettiRendiProj.AggiornaColoreRiepilogo;
  selT750.Filtered:=True;
  selT750.Open;
end;

procedure TAc01FProgettiRendiProjDtM.selT750AfterScroll(DataSet: TDataSet);
begin
  Ac01MW.selT750AfterScroll;
  Ac01FProgettiRendiProj.AbilitaComponenti;
end;

procedure TAc01FProgettiRendiProjDtM.selT750CalcFields(DataSet: TDataSet);
begin
  Ac01MW.selT750OnCalcFields;
end;

procedure TAc01FProgettiRendiProjDtM.selT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=Ac01MW.OnFilterRecord(DataSet);
end;

procedure TAc01FProgettiRendiProjDtM.OnNewRecord(DataSet: TDataSet);
begin
  Ac01MW.selT750OnNewRecord;
end;

procedure TAc01FProgettiRendiProjDtM.BeforePost(DataSet: TDataSet);
begin
  Ac01MW.selT750BeforePost1(InterfacciaR004.StoricizzazioneInCorso);
  inherited;
  Ac01MW.selT750BeforePost2(InterfacciaR004.StoricizzazioneInCorso);
end;

procedure TAc01FProgettiRendiProjDtM.AfterPost(DataSet: TDataSet);
begin
  Ac01MW.selT750AfterPost;
  inherited;
end;

procedure TAc01FProgettiRendiProjDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Ac01MW.selT750BeforeDelete;
end;

procedure TAc01FProgettiRendiProjDtM.selT750ORE_MAXValidate(Sender: TField);
begin
  inherited;
  Ac01MW.OreValidate(Sender.AsString);
  Ac01MW.AggiornaRiepilogo;
end;

end.
