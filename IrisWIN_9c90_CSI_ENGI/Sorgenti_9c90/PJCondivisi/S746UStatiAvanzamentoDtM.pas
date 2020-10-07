unit S746UStatiAvanzamentoDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, USelI010, A000UCostanti, A000USessione, Math,
  A000UInterfaccia, C180FunzioniGenerali, S746UStatiAvanzamentoMW;

type
  TS746FStatiAvanzamentoDtM = class(TR004FGestStoricoDtM)
    SG746: TOracleDataSet;
    SG746DECORRENZA: TDateTimeField;
    SG746DECORRENZA_FINE: TDateTimeField;
    SG746DESCRIZIONE: TStringField;
    SG746CODREGOLA: TStringField;
    SG746MODIFICABILE: TStringField;
    SG746CODSTAMPA: TIntegerField;
    SG746CODICE: TIntegerField;
    SG746DATA_DA: TDateTimeField;
    SG746DATA_A: TDateTimeField;
    SG746DATA_DA_RICHIESTA_VISIONE: TDateTimeField;
    SG746DATA_A_RICHIESTA_VISIONE: TDateTimeField;
    SG746VAL_INTERM_MODIFICABILE: TStringField;
    SG746VAL_INTERM_OBBLIGATORIA: TStringField;
    SG746CREA_AUTOVALUTAZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure SG746CODICEValidate(Sender: TField);
    procedure SG746AfterScroll(DataSet: TDataSet);
    procedure SG746DECORRENZAValidate(Sender: TField);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure SG746NewRecord(DataSet: TDataSet);
    procedure SG746AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    S746FStatiAvanzamentoMW: TS746FStatiAvanzamentoMW;
  end;

var
  S746FStatiAvanzamentoDtM: TS746FStatiAvanzamentoDtM;

implementation
{$R *.dfm}
uses
  S746UStatiAvanzamento;

procedure TS746FStatiAvanzamentoDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S746FStatiAvanzamento.InterfacciaR004;
  InizializzaDataSet(SG746,[evBeforeEdit,
                            evBeforeInsert,
                            evBeforePost,
                            evBeforeDelete,
                            evAfterDelete,
                            evAfterPost,
                            evOnNewRecord,
                            evOnTranslateMessage]);
  S746FStatiAvanzamentoMW:=TS746FStatiAvanzamentoMW.Create(Self);
  S746FStatiAvanzamentoMW.SG746:=SG746;
  S746FStatiAvanzamentoMW.SG746OldValues.SetDataSet(SG746);
  S746FStatiAvanzamento.DButton.DataSet:=SG746;
  SG746.Open;
end;

procedure TS746FStatiAvanzamentoDtM.SG746AfterOpen(DataSet: TDataSet);
begin
  S746FStatiAvanzamentoMW.SG746OldValues.CreaStruttura;
end;

procedure TS746FStatiAvanzamentoDtM.SG746AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S746FStatiAvanzamentoMW.RecuperaListaRegole;
  S746FStatiAvanzamentoMW.RecuperaListaStampa;
  S746FStatiAvanzamentoMW.SG746OldValues.Aggiorna;
  S746FStatiAvanzamento.AbilitaComponenti;
end;

procedure TS746FStatiAvanzamentoDtM.BeforePost(DataSet: TDataSet);
var msg:String;
begin
  msg:=S746FStatiAvanzamentoMW.BeforePost(DataSet);
  if msg <> '' then
    ShowMessage(msg);
end;

procedure TS746FStatiAvanzamentoDtM.SG746CODICEValidate(Sender: TField);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746CODICEValidate;
end;

procedure TS746FStatiAvanzamentoDtM.SG746DECORRENZAValidate(Sender: TField);
begin
  inherited;
  S746FStatiAvanzamentoMW.SG746DECORRENZAValidate;
end;

procedure TS746FStatiAvanzamentoDtM.SG746NewRecord(DataSet: TDataSet);
begin
  inherited;
  S746FStatiAvanzamentoMW.ResetPeriodoRichiestaPresaVisione;
end;

end.
