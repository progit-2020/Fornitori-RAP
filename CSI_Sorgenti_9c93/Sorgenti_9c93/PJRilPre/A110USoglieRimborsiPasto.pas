unit A110USoglieRimborsiPasto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, ExtCtrls, OracleData, C180FunzioniGenerali, A000UInterfaccia,
  StdCtrls, DBCtrls, Buttons, Mask, oracle;

type
  TA110FSoglieRimborsipasto = class(TR001FGestTab)
    dgridRimborsiPasto: TDBGrid;
    PanelMaster: TPanel;
    lblCodice: TLabel;
    lblTMissione: TLabel;
    dcmbDecorrenza: TDBLookupComboBox;
    lblDecorrenza: TLabel;
    edtDecorrenza: TMaskEdit;
    procedure TInserClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure TPrimoClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TCancClick(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Storicizzazione:Boolean;
    procedure CambioStato(Modifica:Boolean);
  end;

var
  A110FSoglieRimborsipasto: TA110FSoglieRimborsipasto;

procedure OpenA110SoglieRimborsiPasto;

implementation

uses A110UParametriConteggioDtM;

{$R *.dfm}

procedure OpenA110SoglieRimborsiPasto;
begin
  try
    A110FParametriConteggioDtm.A110FParametriConteggioMW.OpenSelDistM013;
    A110FSoglieRimborsipasto:=TA110FSoglieRimborsipasto.Create(nil);
    A110FSoglieRimborsipasto.ShowModal;
  finally
    FreeAndNil(A110FSoglieRimborsipasto);
  end;
end;

procedure TA110FSoglieRimborsipasto.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  CambioStato(True);
end;

procedure TA110FSoglieRimborsipasto.CambioStato(Modifica:Boolean);
begin
  actRicerca.Enabled:=Not Modifica;
  actPrimo.Enabled:=Not Modifica;
  actPrecedente.Enabled:=Not Modifica;
  actSuccessivo.Enabled:=Not Modifica;
  ActUltimo.Enabled:=Not Modifica;
  actRefresh.Enabled:=Not Modifica;
  actInserisci.Enabled:=Not Modifica;
  actModifica.Enabled:=Not Modifica;
  actCancella.Enabled:=Not Modifica;
  actAnnulla.Enabled:=Modifica;
  actConferma.Enabled:=Modifica;
  actGomma.Enabled:=Modifica;
  dcmbDecorrenza.Enabled:=Not Modifica;
  A110FParametriConteggioDtM.A110FParametriConteggioMW.selM013_2.ReadOnly:=Not Modifica;
  edtDecorrenza.Top:=dcmbDecorrenza.Top;
  edtDecorrenza.Left:=dcmbDecorrenza.Left;
  dcmbDecorrenza.Visible:=Not Modifica;
  dcmbDecorrenza.Enabled:=Not Modifica;
  edtDecorrenza.Visible:=Modifica;
end;

procedure TA110FSoglieRimborsipasto.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  NumRecords;
end;

procedure TA110FSoglieRimborsipasto.actRefreshExecute(Sender: TObject);
var M013_Chiave:String;
begin
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    M013_Chiave:=selDistM013.FieldByName('M013_CHIAVE').AsString;
    inherited;
    selDistM013.SearchRecord('M013_CHIAVE',M013_Chiave,[srFromBeginning]);
    selM013.Refresh;
  end;
end;

procedure TA110FSoglieRimborsipasto.FormCreate(Sender: TObject);
begin
  inherited;
  dgridRimborsiPasto.DataSource:=A110FParametriConteggioDtM.A110FParametriConteggioMW.dsrM013_2;
  DButton.DataSet:=A110FParametriConteggioDtM.A110FParametriConteggioMW.selDistM013;
end;

procedure TA110FSoglieRimborsipasto.FormShow(Sender: TObject);
begin
  inherited;
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    CambioStato(False);
    lblCodice.Caption:='Codice: ' + #13#10 + VarToStr(selM013.GetVariable('CODICE'));
    lblTMissione.Caption:='Tipo missione: ' + #13#10 + VarToStr(selM013.GetVariable('TIPO_MISSIONE'));
    dcmbDecorrenza.KeyValue:=selDistM013.FieldByName('M013_CHIAVE').AsString;
  end;
end;

procedure TA110FSoglieRimborsipasto.TAnnullaClick(Sender: TObject);
begin
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    edtDecorrenza.Text:='';
    selM013_2.Cancel;
    selM013_2.Filtered:=False;
    SessioneOracle.CancelUpdates([selM013_2]);
    CambioStato(False);
  end;
end;

procedure TA110FSoglieRimborsipasto.TCancClick(Sender: TObject);
begin
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    if (selM013_2.RecordCount > 0) and
       (R180MessageBox('Vuoi cancellare le soglie di rimborso pasto relative alla decorrenza ' +
                      selDistM013.FieldByName('DECORRENZA').AsString + ' ?',DOMANDA) = mrYes) then
    begin
      delM013.SetVariable('CODICE',selDistM013.FieldByName('CODICE').AsString);
      delM013.SetVariable('TIPO_MISSIONE',selDistM013.FieldByName('TIPO_MISSIONE').AsString);
      delM013.SetVariable('DECORRENZA',selDistM013.FieldByName('DECORRENZA').AsString);
      delM013.Execute;
      //Allineamento decorrenze
      UpdM013Decorrenza.Execute;
      SessioneOracle.Commit;
      selDistM013.Refresh;
      selM013_2.Refresh;
      selDistM013.Next;
      dcmbDecorrenza.KeyValue:=selDistM013.FieldByName('M013_CHIAVE').AsString;
    end;
  end;
end;

procedure TA110FSoglieRimborsipasto.TInserClick(Sender: TObject);
begin
  CambioStato(True);
  Storicizzazione:=True;
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    selM013_2.Filtered:=False;
    selM013_2.Filter:='1 <> 1';
    selM013_2.Filtered:=True;
    selM013_2.Insert;
  end;
end;

procedure TA110FSoglieRimborsipasto.TModifClick(Sender: TObject);
begin
  CambioStato(True);
  Storicizzazione:=False;
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    edtDecorrenza.Text:=selM013_2.FieldByName('DECORRENZA').AsString;
    selM013_2.Edit;
  end;
end;

procedure TA110FSoglieRimborsipasto.TPrimoClick(Sender: TObject);
begin
  inherited;
  //In sostituzione alla gestione R004 del datamodulo
  dcmbDecorrenza.KeyValue:=DButton.DataSet.FieldByName('M013_CHIAVE').AsString;
end;

procedure TA110FSoglieRimborsipasto.TRegisClick(Sender: TObject);
var DataDecorrenza:TDateTime;
  Msg: String;
begin
  with A110FParametriConteggioDtM.A110FParametriConteggioMW do
  begin
    if Not TryStrToDate(edtDecorrenza.Text,DataDecorrenza) then
      Raise Exception.Create('Data decorrenza non valida.');
    Msg:=A110FParametriConteggioDtM.A110FParametriConteggioMW.ControlloDecorrenze(edtDecorrenza.Text,Storicizzazione);
    if Msg <> '' then
      if R180MessageBox(Msg,DOMANDA) = mrNo then
        Abort;
    selM013_2.Filtered:=False;
    if selM013_2.State in [dsEdit,dsInsert] then
      selM013_2.Post;
    SessioneOracle.ApplyUpdates([selM013_2], True);
    AggiornaDecorrenze(DataDecorrenza,Storicizzazione);
    edtDecorrenza.Text:='';
    CambioStato(False);
    selDistM013.Refresh;
    selM013_2.Refresh;
    selDistM013.SearchRecord('DECORRENZA',DataDecorrenza,[srFromBeginning]);
    dcmbDecorrenza.KeyValue:=selDistM013.FieldByName('M013_CHIAVE').AsString;
  end;
end;

end.
