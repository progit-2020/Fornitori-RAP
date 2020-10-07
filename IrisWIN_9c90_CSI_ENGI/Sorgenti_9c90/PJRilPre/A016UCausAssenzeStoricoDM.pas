unit A016UCausAssenzeStoricoDM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, A016UCausAssenzeStoricoMW,
  Data.DB;

type
  TA016FCausAssenzeStoricoDM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
  private
    procedure selT230AfterScroll(DataSet: TDataSet);
  public
    A016FCausAssenzeStoricoMW:TA016FCausAssenzeStoricoMW;
    constructor Create(AOwner: TComponent; IDCausale:Integer); overload;
  end;

var
  A016FCausAssenzeStoricoDM: TA016FCausAssenzeStoricoDM;

implementation

uses A000UMessaggi, A016UCausAssenzeStorico;

{$R *.dfm}

constructor TA016FCausAssenzeStoricoDM.Create(AOwner: TComponent; IDCausale:Integer);
begin
  A016FCausAssenzeStoricoMW:=TA016FCausAssenzeStoricoMW.Create(Self);
  A016FCausAssenzeStoricoMW.Inizializza(IDCausale);
  inherited Create(AOwner);
end;

procedure TA016FCausAssenzeStoricoDM.selT230AfterScroll(DataSet: TDataSet);
begin
  if A016FCausAssenzeStorico <> nil then
    A016FCausAssenzeStorico.PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStoricoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A016FCausAssenzeStorico.InterfacciaR004;
  InizializzaDataSet(A016FCausAssenzeStoricoMW.selT230,[evBeforeEdit,
                                                        evBeforeInsert,
                                                        evBeforePost,
                                                        evBeforeDelete,
                                                        evAfterDelete,
                                                        evAfterPost,
                                                        evOnNewRecord,
                                                        evOnTranslateMessage]);
  A016FCausAssenzeStoricoMW.selT230.AfterScroll:=selT230AfterScroll;
  A016FCausAssenzeStorico.DButton.DataSet:=A016FCausAssenzeStoricoMW.selT230;
  InterfacciaR004.OttimizzaStorico:=False;
  A016FCausAssenzeStoricoMW.selT230.Open;
end;

procedure TA016FCausAssenzeStoricoDM.BeforePost(DataSet: TDataSet);
var
  CampoControllo:String;
begin
  CampoControllo:=TA016FCausAssenzeStoricoMW.ControllaCampiObbligatori(DataSet);
  if (CampoControllo <> '') then
  begin
    DataSet.FieldByName(CampoControllo).FocusControl;
    raise Exception.Create(A000MSG_A016_ERR_VALORGIOR_ORE_FISSE);
  end;
  inherited;
end;

end.
