unit A016UCausAssenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  A000USessione, Vcl.ExtCtrls, C013UCheckList, OracleData, System.ImageList;

type
  TA016FCausAssenzeStorico = class(TR004FGestStorico)
    dedtCodice: TDBEdit;
    lblDescrizione: TLabel;
    dedtDescrizione: TDBEdit;
    lblCodice: TLabel;
    drgpValorGior: TDBRadioGroup;
    dedtValorGiorOre: TDBEdit;
    lblValorGiorOre: TLabel;
    drgpValorGiorComp: TDBRadioGroup;
    lblValorGiorOreComp: TLabel;
    dedtValorGiorOreComp: TDBEdit;
    dchkValorGiorOrePropPT: TDBCheckBox;
    lblHMAssenza: TLabel;
    dedtHMAssenza: TDBEdit;
    dchkHMAssenzaPropPT: TDBCheckBox;
    lblCausaliCompatibili: TLabel;
    dedtCausaliCompatibili: TDBEdit;
    btnCausaliCompatibili: TButton;
    drgpStatoCompatibilta: TDBRadioGroup;
    lblDescCausale: TLabel;
    dedtDescCausale: TDBEdit;
    lblCausaliCheckComp: TLabel;
    dedtCausaliCheckComp: TDBEdit;
    btnCausaliCheckComp: TButton;
    lblVisualComp: TLabel;
    dcmbVisualCompetenze: TDBComboBox;
    grpFruizAbilSP: TGroupBox;
    dchkFruizAbilSPGiorni: TDBCheckBox;
    dchkFruizAbilSPOre: TDBCheckBox;
    lblCausaleFruizOre: TLabel;
    dcmbCausaleFruizOre: TDBLookupComboBox;
    lblCausaleHMAssenza: TLabel;
    dcmbCausaleHMAssenza: TDBLookupComboBox;
    dchkCheckSoloCompetenze: TDBCheckBox;
    dchkAbbatteStrInd: TDBCheckBox;
    dchkSceltaOrario: TDBCheckBox;
    dchkRendicontaProgetti: TDBCheckBox;
    procedure TCancClick(Sender: TObject);
    procedure SelezioneCausali(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure drgpValorGiorChange(Sender: TObject);
    procedure drgpValorGiorCompChange(Sender: TObject);
    procedure OnDBEditOraChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
  private
    procedure ImpostaEnabledCampi;
  public
    // Periodo attuale, viene prevalorizzato prima dello show
    // e utilizzato prima del destroy per sincronizzare con il form chiamante
    A016StoricoDataLavoro:TDateTime;
    procedure PopolaComboVisualCompetenze;
  end;

var
  A016FCausAssenzeStorico: TA016FCausAssenzeStorico;

implementation

uses A000UMessaggi ,A016UCausAssenzeStoricoDM, C180FunzioniGenerali;

{$R *.dfm}

procedure TA016FCausAssenzeStorico.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  ImpostaEnabledCampi;
  if (Field <> nil) and ((Field.FieldName = 'CAUSALI_CHECKCOMPETENZE') or (Field.FieldName = 'CAUSALI_VISUALCOMPETENZE')) then
    PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.OnDBEditOraChange(Sender: TObject);
var
  DBEditSender:TDBEdit;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
    DBEditSender:=(Sender as TDBEdit);
    if (Trim(DBEditSender.Text) = '.') then
      DBEditSender.Field.Clear;
  end;
end;

procedure TA016FCausAssenzeStorico.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbVisualCompetenze.Enabled:=DButton.DataSet.State in [dsEdit, dsInsert];
  PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.drgpValorGiorChange(Sender: TObject);
begin
  ImpostaEnabledCampi;
end;

procedure TA016FCausAssenzeStorico.drgpValorGiorCompChange(
  Sender: TObject);
begin
  ImpostaEnabledCampi;
end;

procedure TA016FCausAssenzeStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A016StoricoDataLavoro:=StrToDate(cmbDateDecorrenza.Text);
  inherited;
end;

procedure TA016FCausAssenzeStorico.FormShow(Sender: TObject);
var
  DataLavoroInizialeStr:String;
begin
  inherited;
  dcmbCausaleFruizOre.ListSource:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.dsrT265;
  dcmbCausaleFruizOre.KeyField:='CODICE';
  dcmbCausaleFruizOre.ListField:='CODICE;DESCRIZIONE';
  dcmbCausaleFruizOre.DropDownWidth:=300;
  dcmbCausaleHMAssenza.ListSource:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.dsrT265;
  dcmbCausaleHMAssenza.KeyField:='CODICE';
  dcmbCausaleHMAssenza.ListField:='CODICE;DESCRIZIONE';
  dcmbCausaleHMAssenza.DropDownWidth:=300;
  DataLavoroInizialeStr:=DateToStr(A016StoricoDataLavoro);
  cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
  cmbDateDecorrenzaChange(nil);
end;

procedure TA016FCausAssenzeStorico.ImpostaEnabledCampi;
begin
  dedtValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  lblValorGiorOre.Enabled:=(drgpValorGior.ItemIndex = 5);
  {if not dedtValorGiorOre.Enabled then
    dedtValorGiorOre.Text:='00.00';}
  dedtValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  lblValorGiorOreComp.Enabled:=(drgpValorGiorComp.ItemIndex = 6);
  {if not dedtValorGiorOreComp.Enabled then
    dedtValorGiorOreComp.Text:='00.00';}
  dchkValorGiorOrePropPT.Enabled:=(drgpValorGior.ItemIndex = 5) or (drgpValorGiorComp.ItemIndex = 6);
end;

procedure TA016FCausAssenzeStorico.SelezioneCausali(Sender: TObject);
var
  IdCausaleCorrente:Integer;
  TestoCausale,VecchioValore,NuovoValore:String;
  selT230,selT265:TOracleDataSet;
begin
  if not(DButton.State in [dsEdit,dsInsert]) then
    Exit;
  if (Sender <> btnCausaliCompatibili) and (Sender <> btnCausaliCheckComp) then
    Exit;
  selT265:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265;
  selT230:=A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT230;
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    IdCausaleCorrente:=selT230.FieldByName('ID').AsInteger;
    selT265.Filtered:=False;
    selT265.Filter:='(ID <> ' + IntToStr(IdCausaleCorrente) + ')';
    if Sender = btnCausaliCheckComp then
      selT265.Filter:=selT265.Filter + ' and (TIPOCUMULO <> ''H'')';
    selT265.Filtered:=True;
    selT265.First;
    while not selT265.Eof do
    begin
      TestoCausale:=Format('%-5s - %s',[
                                      A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265.FieldByName('CODICE').AsString,
                                      A016FCausAssenzeStoricoDM.A016FCausAssenzeStoricoMW.selT265.FieldByName('DESCRIZIONE').AsString
                                     ]);
      C013FCheckList.clbListaDati.Items.Add(TestoCausale);
      selT265.Next;
    end;

    if Sender = btnCausaliCompatibili then
      VecchioValore:=selT230.FieldByName('CAUSALI_COMPATIBILI').AsString
    else
      VecchioValore:=selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString;
    R180PutCheckList(VecchioValore,5,C013FCheckList.clbListaDati);

    if C013FCheckList.ShowModal = mrOK then
    begin
      NuovoValore:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      if Sender = btnCausaliCompatibili then
      begin
        selT230.FieldByName('CAUSALI_COMPATIBILI').AsString:=NuovoValore
      end
      else
      begin
        selT230.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString:=NuovoValore;
        PopolaComboVisualCompetenze;
        if dcmbVisualCompetenze.ItemIndex = -1 then
          DButton.DataSet.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString:='';
      end;
    end;
  finally
    selT265.Filter:='';
    selT265.Filtered:=False;
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA016FCausAssenzeStorico.TAnnullaClick(Sender: TObject);
begin
  inherited;
  PopolaComboVisualCompetenze;
end;

procedure TA016FCausAssenzeStorico.TCancClick(Sender: TObject);
begin
  if DButton.DataSet.RecordCount < 2 then
  begin
    R180MessageBox(A000MSG_A016_MSG_NO_ELIMINA_STOR,ESCLAMA,Self.Caption);
    Exit;
  end;
  inherited;
end;

procedure TA016FCausAssenzeStorico.PopolaComboVisualCompetenze;
var
  CausaliCheckComp:String;
  CausaliCheckCompSplit:TArray<String>;
  CausaleCorr:String;
begin
  dcmbVisualCompetenze.Items.Clear;
  dcmbVisualCompetenze.Items.Add('');
  CausaliCheckComp:=DButton.DataSet.FieldByName('CAUSALI_CHECKCOMPETENZE').AsString;
  if (Trim(CausaliCheckComp) <> '') then
  begin
    CausaliCheckCompSplit:=CausaliCheckComp.Split([',']);
    for CausaleCorr in CausaliCheckCompSplit do
    begin
      dcmbVisualCompetenze.Items.Add(CausaleCorr);
    end;
    CausaleCorr:=DButton.DataSet.FieldByName('CAUSALE_VISUALCOMPETENZE').AsString;
    dcmbVisualCompetenze.ItemIndex:=dcmbVisualCompetenze.Items.IndexOf(CausaleCorr);
  end;
end;

end.
