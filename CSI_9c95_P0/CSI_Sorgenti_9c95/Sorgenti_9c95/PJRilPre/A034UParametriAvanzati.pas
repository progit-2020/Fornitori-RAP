unit A034UParametriAvanzati;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Mask, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls, C180FunzioniGenerali,
  A003UDataLavoroBis, A000UInterfaccia, A000UCostanti, A000USessione, Oracle,
  System.Actions, System.ImageList;

type
  TA034FParametriAvanzati = class(TR004FGestStorico)
    Panel1: TPanel;
    dgrdVoci: TDBGrid;
    dCmbInterfaccia: TDBLookupComboBox;
    lblInterfaccia: TLabel;
    dEdtDescrizione: TDBEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dChkAutoIncDal: TDBCheckBox;
    dChkAutoIncAl: TDBCheckBox;
    btnDal: TBitBtn;
    btnAl: TBitBtn;
    dLblInterfaccia: TDBText;
    dedtAttivaDal: TDBEdit;
    dedtAttivaAl: TDBEdit;
    GroupBox1: TGroupBox;
    dEdtVPagheCedolino: TDBEdit;
    dEdtVocePaghe: TDBEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    dEdtVPagheNegativa: TDBEdit;
    dLblVPagheNegativa: TDBText;
    BtnCodVoceCed: TButton;
    BtnCodVoceNeg: TButton;
    DLblVocePagheCed: TDBText;
    lblArrotondamento: TLabel;
    dedtArrotondamento: TDBEdit;
    Label3: TLabel;
    dedtFormula: TDBEdit;
    btnVerificaFormula: TSpeedButton;
    dChkSpostaValImp: TDBCheckBox;
    procedure BtnCodVoceNegClick(Sender: TObject);
    procedure BtnCodVoceCedClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure dCmbVPagheCedolinoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dCmbVPagheCedolinoCloseUp(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dCmbInterfacciaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnAlClick(Sender: TObject);
    procedure btnDalClick(Sender: TObject);
    procedure btnVerificaFormulaClick(Sender: TObject);
    procedure dedtFormulaChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A034FParametriAvanzati: TA034FParametriAvanzati;

procedure OpenA034ParametriAvanzati(Interfaccia:String);

implementation

uses A034UParametriAvanzatiDtM, C016UElencoVoci;

{$R *.dfm}

procedure OpenA034ParametriAvanzati(Interfaccia:String);
begin
begin
  Application.CreateForm(TA034FParametriAvanzati, A034FParametriAvanzati);
  Application.CreateForm(TA034FParametriAvanzatiDtM, A034FParametriAvanzatiDtM);
  try
    if Trim(Interfaccia) <> '' then
    begin
      A034FParametriAvanzatiDtM.selT193.Filter:='COD_INTERFACCIA = ''' + Interfaccia + '''';
      A034FParametriAvanzatiDtM.selT193.Filtered:=True;
    end;
    A034FParametriAvanzati.ShowModal;
    A034FParametriAvanzatiDtM.selT193.Filter:='';
    A034FParametriAvanzatiDtM.selT193.Filtered:=False;
  finally
    A034FParametriAvanzati.Free;
    A034FParametriAvanzatiDtm.Free;
  end;
end;

(*
  A034FParametriAvanzati:=TA034FParametriAvanzati.Create(nil);
  A034FParametriAvanzatiDtM:=TA034FParametriAvanzatiDtM.Create(nil);
  try
    if Trim(Interfaccia) <> '' then
    begin
      A034FParametriAvanzatiDtM.selT193.Filter:='COD_INTERFACCIA = ''' + Interfaccia + '''';
      A034FParametriAvanzatiDtM.selT193.Filtered:=True;
    end;
    A034FParametriAvanzati.ShowModal;
  finally
    A034FParametriAvanzatiDtM.selT193.Filter:='';
    A034FParametriAvanzatiDtM.selT193.Filtered:=False;
    A034FParametriAvanzati.Free;
    A034FParametriAvanzatiDtm.Free;
  end;
*)
end;

procedure TA034FParametriAvanzati.btnDalClick(Sender: TObject);
begin
  inherited;
  with A034FParametriAvanzatiDtM do
    selT193.FieldByName('DAL').AsDateTime:=R180InizioMese(DataOut(selT193.FieldByName('DAL').AsDateTime,'Mese inizio voce attiva','M'));
end;

procedure TA034FParametriAvanzati.btnAlClick(Sender: TObject);
begin
  inherited;
  with A034FParametriAvanzatiDtM do
    selT193.FieldByName('AL').AsDateTime:=R180InizioMese(DataOut(selT193.FieldByName('AL').AsDateTime,'Mese fine voce attiva','M'));

end;

procedure TA034FParametriAvanzati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dgrdVoci.Enabled:=DButton.State = dsBrowse;
  btnDal.Enabled:=DButton.State <> dsBrowse;
  btnAl.Enabled:=DButton.State <> dsBrowse;
  BtnCodVoceCed.Enabled:=(DButton.State in [dsInsert,dsEdit])
  and (A034FParametriAvanzatiDtM.A034FParametriAvanzatiMW.selP200.RecordCount > 0);
  BtnCodVoceNeg.Enabled:=(DButton.State in [dsInsert,dsEdit])
  and (A034FParametriAvanzatiDtM.A034FParametriAvanzatiMW.selP200.RecordCount > 0);
end;

procedure TA034FParametriAvanzati.dCmbInterfacciaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA034FParametriAvanzati.btnStoricizzaClick(Sender: TObject);
begin
  A034FParametriAvanzatiDtM.A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=True;
  dEdtDecorrenza.SetFocus;
  inherited;
end;

procedure TA034FParametriAvanzati.btnVerificaFormulaClick(Sender: TObject);
var
  Msg: String;
begin
  Msg:='';
  if A034FParametriAvanzatiDtM.A034FParametriAvanzatiMW.VerificaFormula(dEdtFormula.Text,Msg) then
    R180MessageBox(Msg,INFORMA)
  else
    R180MessageBox(Msg,ESCLAMA);
end;

procedure TA034FParametriAvanzati.dCmbVPagheCedolinoCloseUp(Sender: TObject);
begin
  inherited;
  if (DButton.State = dsEdit) and (A034FParametriAvanzatiDtM.selT193.FieldByName('DESCRIZIONE').medpOldValue = null) then
    A034FParametriAvanzatiDtM.selT193.FieldByName('DESCRIZIONE').AsString:=A034FParametriAvanzatiDtM.selT193.FieldByName('DESC_VPAGHE_CEDOLINO').AsString;
end;

procedure TA034FParametriAvanzati.dCmbVPagheCedolinoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dCmbVPagheCedolinoCloseUp(nil);
end;

procedure TA034FParametriAvanzati.dedtFormulaChange(Sender: TObject);
begin
  inherited;
  btnVerificaFormula.Enabled:=Trim(dedtFormula.Text) <> '';
end;

procedure TA034FParametriAvanzati.TAnnullaClick(Sender: TObject);
begin
  //Caratto 28/02/2013. se ho premuto storicizza e poi annullo. rimaneva erroneamente storicizzazione impostata
  A034FParametriAvanzatiDtM.A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=True;
  inherited;
end;

procedure TA034FParametriAvanzati.TRegisClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA034FParametriAvanzati.BtnCodVoceCedClick(Sender: TObject);
begin
  inherited;
  C016FElencoVoci:=TC016FElencoVoci.Create(nil);
  C016FElencoVoci.DecorrenzaElencoVoci:=StrToDateTime('01/01/1900');
  C016FElencoVoci.TestoFiltroSql:=' AND COD_CONTRATTO = ''' + Parametri.CodContrattoVoci + '''' +
                                  ' AND COD_VOCE_SPECIALE = ''BASE''' +
                                  ' AND TIPO NOT IN (''IM'',''RI'',''RA'')';
  try
    C016FElencoVoci.ShowModal;
  except
    FreeAndNil(C016FElencoVoci);
    Exit;
  end;
  A034FParametriAvanzatiDtM.selT193.Edit;
  A034FParametriAvanzatiDtM.selT193.FieldByName('VOCE_PAGHE_CEDOLINO').AsString:=C016FElencoVoci.CodVoceElencoVoci;
  FreeAndNil(C016FElencoVoci);
end;

procedure TA034FParametriAvanzati.BtnCodVoceNegClick(Sender: TObject);
begin
  inherited;
  C016FElencoVoci:=TC016FElencoVoci.Create(nil);
  C016FElencoVoci.DecorrenzaElencoVoci:=StrToDateTime('01/01/1900');
  C016FElencoVoci.TestoFiltroSql:=' AND COD_CONTRATTO = ''' + Parametri.CodContrattoVoci + '''' +
                                  ' AND COD_VOCE_SPECIALE = ''BASE''' +
                                  ' AND TIPO NOT IN (''IM'',''RI'',''RA'')';
  try
    C016FElencoVoci.ShowModal;
  except
    FreeAndNil(C016FElencoVoci);
    Exit;
  end;
  A034FParametriAvanzatiDtM.selT193.Edit;
  A034FParametriAvanzatiDtM.selT193.FieldByName('VOCE_PAGHE_NEGATIVA').AsString:=C016FElencoVoci.CodVoceElencoVoci;
  FreeAndNil(C016FElencoVoci);
end;

end.
