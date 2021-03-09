unit A024URegoleIndennita;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  A000UCostanti, A000USessione,A000UInterfaccia, StdCtrls, Mask, DBCtrls, ActnList, ImgList, ToolWin,
  C180FunzioniGenerali, Variants, C012UVisualizzaTesto, C013UCheckList, C600USelAnagrafe,
  StrUtils, Math, A024ULimitiInd, System.Actions;


type
  TA024FRegoleIndennita = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    ETipo: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    PAssenze: TPanel;
    lblAssenze: TLabel;
    EAssenze: TDBEdit;
    BAssenze: TButton;
    PAltroCodice: TPanel;
    Label5: TLabel;
    dcmbCodice2: TDBLookupComboBox;
    gpbMaturazione: TGroupBox;
    GAssenze: TDBGrid;
    Splitter1: TSplitter;
    Label7: TLabel;
    DBEdit9: TDBEdit;
    Label8: TLabel;
    dedtIncompatibilita: TDBEdit;
    btnIncompatibilita: TButton;
    PCoefficiente: TPanel;
    gpbTurniDaConsiderare: TGroupBox;
    LblCoefficiente: TLabel;
    lblNumTurni: TLabel;
    dedtCoefficiente: TDBEdit;
    dedtNumTurni: TDBEdit;
    dedtCoeffNumTurni: TDBEdit;
    dcmbTurno: TDBComboBox;
    Label9: TLabel;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    PTurni: TPanel;
    LTurni: TLabel;
    ETurni: TDBEdit;
    GPTurni: TGroupBox;
    LblPercTurno1: TLabel;
    LblPercTurno2: TLabel;
    LblPercTurno3: TLabel;
    LblPercTurno4: TLabel;
    LblPrimoTurno: TLabel;
    LblSecondoTurno: TLabel;
    LblTerzoTurno: TLabel;
    LblQuartoTurno: TLabel;
    CB1: TCheckBox;
    CB2: TCheckBox;
    CB3: TCheckBox;
    CB4: TCheckBox;
    CB5: TCheckBox;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    lblCoeffNumTurniPerc: TLabel;
    lblCoeffNumTurni: TLabel;
    lblArrotondamento: TLabel;
    dcmbArrotondamento: TDBComboBox;
    PRiferimento: TPanel;
    dgpbGGRiferimento: TDBRadioGroup;
    lblAssenzeAbilitate: TLabel;
    dedtAssenzeAbilitate: TDBEdit;
    btnAssenzeAbilitate: TButton;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    PopupMenu1: TPopupMenu;
    Selezioneanagrafe1: TMenuItem;
    pnlIndSupp: TPanel;
    chkIndSupp: TDBCheckBox;
    pnlCausalePresenza: TPanel;
    Label10: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    dgpbnmesi_equiturni: TDBRadioGroup;
    PTMinIndOra: TPanel;
    dEdtOffSet_MetaDebito: TDBEdit;
    dCmbMaturaSabato: TDBComboBox;
    dChkPianifNOOP: TDBCheckBox;
    dEdtMinTPrioritari: TDBEdit;
    dEdtMinTurniSec: TDBEdit;
    dedtOffsetGGPrec: TDBEdit;
    lblOffSet_MetaDebito: TLabel;
    lblMaturaSabato: TLabel;
    lblMinTPrioritari: TLabel;
    lblMinTurniSec: TLabel;
    lblOffsetGGPrec: TLabel;
    ppMnuAccediSQL: TPopupMenu;
    Accedi1: TMenuItem;
    btnLimitiInd: TButton;
    DBCheckBox1: TDBCheckBox;
    pnlRiepRegole: TPanel;
    gpbAssociazione: TGroupBox;
    dGrdAssociazione: TDBGrid;
    btnVisioneCorrente: TSpeedButton;
    dchkMaturazPropDebitoGG: TDBCheckBox;
    procedure btnAssenzeAbilitateClick(Sender: TObject);
    procedure dcmbCodice2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure BAssenzeClick(Sender: TObject);
    procedure ETipoChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure CB5Click(Sender: TObject);
    procedure CB1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure ETipoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure dGrdAssociazioneEditButtonClick(Sender: TObject);
    procedure btnIncompatibilitaClick(Sender: TObject);
    procedure dcmbTurnoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Selezioneanagrafe1Click(Sender: TObject);
    procedure dCmbMaturaSabatoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure Accedi1Click(Sender: TObject);
    procedure btnLimitiIndClick(Sender: TObject);
    procedure btnVisioneCorrenteClick(Sender: TObject);
  private
    { Private declarations }
    ListaAssenze:TStringList;
    ListaPresenze:TStringList;  //LORENA 29/07/2004
    procedure CaricaAssenze;
    procedure CaricaPresenze;   //LORENA 29/07/2004
    procedure ImpostaCampi;
  public
    { Public declarations }
  end;

const D_Tipo:array[0..11] of String =
  ('Turni minimi',                      //A
   'Turni minimi in percentuale',       //P
   'Turni minimi con ind.oraria',       //I  ALBERTO 08/10/2010
   'Proporzione minima',                //B
   'Assenze',                           //C
   'Ore causalizzate',                  //G  LORENA 29/07/2004
   'Proporzione fissa',                 //D
   'Turni per coeff. di calcolo',       //E
   'Con domeniche del mese',            //F
   'Unitaria mensile',                  //V
   'GG retribuiti mensili',             //H  LORENA 01/04/2005
   'Nessun equilibrio');                //Z

const D_Turno:array[0..4] of String =
  ('Primo turno',
   'Secondo turno',
   'Terzo turno',
   'Quarto turno',
   'Turno in minoranza');

const D_Arrotondamento:array[0..3] of String =
  ('Nessuno',
   'Puro',
   'Difetto',
   'Eccesso');

var
  A024FRegoleIndennita: TA024FRegoleIndennita;

implementation

uses A024UIndPresenzaDtM1;

{$R *.DFM}

procedure TA024FRegoleIndennita.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA024FRegoleIndennita.FormCreate(Sender: TObject);
begin
  inherited;
  Height:=600;
  ListaAssenze:=TStringList.Create;
  ListaPresenze:=TStringList.Create;  //LORENA 29/07/2004
end;

procedure TA024FRegoleIndennita.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A024FIndPresenzaDtM1.Q162;
  CaricaAssenze;
  CaricaPresenze;  //LORENA 29/07/2004
  inherited;
end;

procedure TA024FRegoleIndennita.CaricaAssenze;
begin
  with A024FIndPresenzaDtM1.Q265 do
  begin
    Open;
    while not Eof do
    begin
      ListaAssenze.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TA024FRegoleIndennita.CaricaPresenze;  //LORENA 29/07/2004
begin
  with A024FIndPresenzaDtM1.selT275 do
  begin
    Open;
    while not Eof do
    begin
      ListaPresenze.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TA024FRegoleIndennita.Accedi1Click(Sender: TObject);
var StrListTemp:TStringList;
    Bottoni:TMsgDlgButtons;
begin
  inherited;
  Bottoni:=[mbCancel];
  if (ppMnuAccediSQL.PopupComponent as TDBEdit).DataSource.DataSet.State in [dsInsert,dsEdit] then
    Bottoni:=[mbOK, mbCancel];
  StrListTemp:=TStringList.Create;
  try
    StrListTemp.Add((ppMnuAccediSQL.PopupComponent as TDBEdit).Field.AsString);
    if ppMnuAccediSQL.PopupComponent = dEdtMinTPrioritari then
      OpenC012VisualizzaTesto('Turni prioritari minimi:','',StrListTemp,'',Bottoni);
    if ppMnuAccediSQL.PopupComponent = dEdtMinTurniSec then
      OpenC012VisualizzaTesto('Turni secondari minimi:','',StrListTemp,'',Bottoni);
    //if ppMnuAccediSQL.PopupComponent = dEdtChkGGValido then
    //  OpenC012VisualizzaTesto('Turni prioritari minimi:','',StrListTemp,'',Bottoni);
    if (ppMnuAccediSQL.PopupComponent as TDBEdit).DataSource.DataSet.State in [dsInsert,dsEdit] then
      (ppMnuAccediSQL.PopupComponent as TDBEdit).Field.AsString:=StrListTemp.Text;
  finally
    FreeAndNil(StrListTemp);
  end;
end;

procedure TA024FRegoleIndennita.BAssenzeClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
    try
      if ETipo.Text = 'G' then //LORENA 29/07/2004
      begin
        clbListaDati.Items.Clear;
        clbListaDati.Items.Add('*** Presenza');
        clbListaDati.Items.AddStrings(ListaPresenze);
        clbListaDati.Items.Add('*** Assenza');
        clbListaDati.Items.AddStrings(ListaAssenze);
      end
      else
        clbListaDati.Items.Assign(ListaAssenze);
      R180PutCheckList(EAssenze.Field.AsString,5,clbListaDati);
      if ShowModal = mrOK then
        EAssenze.Field.AsString:=StringReplace(StringReplace(R180GetCheckList(5,clbListaDati),'*** A','',[]),'*** P','',[]);
    finally
      Free;
    end;
end;

procedure TA024FRegoleIndennita.ImpostaCampi;
begin
  lblAssenzeAbilitate.Enabled:=(ETipo.Text <> 'C') and (ETipo.Text <> 'G') and (ETipo.Text <> 'V') and (ETipo.Text <> 'H');
  dedtAssenzeAbilitate.Enabled:=lblAssenzeAbilitate.Enabled;
  btnAssenzeAbilitate.Enabled:=lblAssenzeAbilitate.Enabled;
  if ETipo.Text = 'I' then
    lblAssenzeAbilitate.Caption:='Assenze tollerate:'
  else
    lblAssenzeAbilitate.Caption:='Assenze che maturano:';
  //Panel PAssenze
  PAssenze.Visible:=(ETipo.Text = 'C') or (ETipo.Text = 'F') or (ETipo.Text = 'G') or (ETipo.Text = 'H') or (ETipo.Text = 'I'); //LORENA 01/04/2005
  if ETipo.Text = 'C' then
    lblAssenze.Caption:='Assenze escluse:'
  else if (ETipo.Text = 'F') or (ETipo.Text = 'H') then  //LORENA 01/04/2005
    lblAssenze.Caption:='Assenze che non abbattono:'
  else if ETipo.Text = 'G' then  //LORENA 29/07/2004
    lblAssenze.Caption:='Causali da considerare:'
  else if ETipo.Text = 'I' then
    lblAssenze.Caption:='Assenze da conteggiare:';
  //Panel PCoefficiente
  PCoefficiente.Visible:=(ETipo.Text = 'E') or (ETipo.Text = 'F');
  PCoefficiente.Visible:=(ETipo.Text = 'E') or (ETipo.Text = 'F');
  dedtCoeffNumTurni.Visible:=(ETipo.Text = 'E');
  lblCoeffNumTurni.Visible:=(ETipo.Text = 'E');
  lblCoeffNumTurniPerc.Visible:=(ETipo.Text = 'E');
  lblNumTurni.Visible:=(ETipo.Text = 'E');
  dedtNumTurni.Visible:=(ETipo.Text = 'E');
  gpbTurniDaConsiderare.Visible:=(ETipo.Text = 'E');
  //Panel pnlCausalePresenza
  pnlCausalePresenza.Visible:=(ETipo.Text = 'I');  //Alberto 08/10/2010
  //Panel PRiferimento
  PRiferimento.Visible:=(ETipo.Text = 'H');  //LORENA 01/04/2005
  //Panel PTurni
  PTurni.Visible:=(ETipo.Text = 'A') or (ETipo.Text = 'B') or (ETipo.Text = 'D') or (ETipo.Text = 'V') or (ETipo.Text = 'P');
  dgpbnmesi_equiturni.Visible:=((ETipo.Text = 'A') or (ETipo.Text = 'B') or (ETipo.Text = 'P')) and (dcmbCodice2.Field.IsNull);
  dchkMaturazPropDebitoGG.Visible:=ETipo.Text = 'Z';
  GPTurni.Visible:=(ETipo.Text = 'A') or (ETipo.Text = 'B') or (ETipo.Text = 'D') or (ETipo.Text = 'P');
  LTurni.visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  ETurni.visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  CB1.Visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  CB2.Visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  CB3.Visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  CB4.Visible:=(ETipo.Text <> 'P') and (ETipo.Text <> 'F');
  CB5.Visible:=(ETipo.Text <> 'D') and (ETipo.Text <> 'F') and (ETipo.Text <> 'P') ;
  LblPercTurno1.Visible:=ETipo.Text = 'P';
  LblPercTurno2.Visible:=ETipo.Text = 'P';
  LblPercTurno3.Visible:=ETipo.Text = 'P';
  LblPercTurno4.Visible:=ETipo.Text = 'P';
//  dcmbArrotondamento.Visible:=(ETipo.Text = 'P')
//  lblArrotondamento.Visible:=ETipo.Text = 'P';
  dcmbArrotondamento.Visible:=(ETipo.Text = 'P') or (ETipo.Text = 'B');
  lblArrotondamento.Visible:=(ETipo.Text = 'P') or (ETipo.Text = 'B');
  if (ETipo.Text = 'P') or (ETipo.Text = 'F') then
  begin
    A024FIndPresenzaDtM1.Q162TURNO1.MaxValue:=100;
    A024FIndPresenzaDtM1.Q162TURNO2.MaxValue:=100;
    A024FIndPresenzaDtM1.Q162TURNO3.MaxValue:=100;
    A024FIndPresenzaDtM1.Q162TURNO4.MaxValue:=100;
  end
  else
  begin
    A024FIndPresenzaDtM1.Q162TURNO1.MaxValue:=30;
    A024FIndPresenzaDtM1.Q162TURNO2.MaxValue:=30;
    A024FIndPresenzaDtM1.Q162TURNO3.MaxValue:=30;
    A024FIndPresenzaDtM1.Q162TURNO4.MaxValue:=30;
  end;
  if ETipo.Text = 'A' then
    LTurni.Caption:='Turni minimi:'
  else if ETipo.Text = 'B' then
    LTurni.Caption:='Turni minimi(%):'
  else if ETipo.Text = 'D' then
    LTurni.Caption:='Proporzione:'
  else if ETipo.Text = 'V' then
    LTurni.Caption:='Giorni minimi di presenza:';
  //Panel PAltroCodice
  PAltroCodice.Visible:=(ETipo.Text = 'A') or (ETipo.Text = 'B') or (ETipo.Text = 'C') or (ETipo.Text = 'D') or (ETipo.Text = 'P') or (ETipo.Text = 'E');
  //Panel Regole di maturazione
  gpbMaturazione.Visible:=ETipo.Text = 'C';
  //Panel PTMinIndOra
  PTMinIndOra.Visible:=ETipo.Text = 'I';
  //Impostazione Top pannelli
  PTurni.Top:=Panel2.Top + Panel2.Height + 1;
  PAssenze.Top:=PTurni.Top + PTurni.Height + 1;
  pnlCausalePresenza.Top:=PTurni.Top + PTurni.Height + 1;
  pnlIndSupp.Top:=pnlCausalePresenza.Top + pnlCausalePresenza.Height + 1;
  PAltroCodice.Top:=pnlIndSupp.Top + pnlIndSupp.Height + 1;
  gpbMaturazione.Top:=PAltroCodice.Top + PAltroCodice.Height + 1;
  Splitter1.Enabled:=gpbMaturazione.Visible;
  Splitter1.Top:=gpbAssociazione.Top;
end;

procedure TA024FRegoleIndennita.Selezioneanagrafe1Click(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=Trim(X);
  end;
begin
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if (DButton.State in [dsEdit,dsInsert]) and (C600frmSelAnagrafe.C600ModalResult = mrOK) then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    if A024FIndPresenzaDtM1.selT164.State in [dsEdit,dsBrowse] then
      A024FIndPresenzaDtM1.selT164.Edit;
    A024FIndPresenzaDtM1.selT164.FieldByName('ESPRESSIONE').AsString:=TrasformaV430(S);
  end;
end;

procedure TA024FRegoleIndennita.ETipoChange(Sender: TObject);
begin
  ImpostaCampi;
end;

procedure TA024FRegoleIndennita.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
    ImpostaCampi;
end;

procedure TA024FRegoleIndennita.CB5Click(Sender: TObject);
begin
  inherited;
  if CB5.Checked then
  begin
    CB1.Checked:=False;
    CB2.Checked:=False;
    CB3.Checked:=False;
    CB4.Checked:=False;
  end;
end;

procedure TA024FRegoleIndennita.CB1Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    CB5.Checked:=False;
end;

procedure TA024FRegoleIndennita.FormDestroy(Sender: TObject);
begin
  inherited;
  ListaAssenze.Free;
  ListaPresenze.Free;  //LORENA 29/07/2004
end;

procedure TA024FRegoleIndennita.FormShow(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure TA024FRegoleIndennita.DButtonStateChange(Sender: TObject);
begin
  inherited;
  BAssenze.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnAssenzeAbilitate.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnIncompatibilita.Enabled:=DButton.State in [dsInsert,dsEdit];
  A024FIndPresenzaDtM1.selT164.ReadOnly:=DButton.State in [dsInsert,dsBrowse];
  A024FIndPresenzaDtM1.Q171.ReadOnly:=DButton.State in [dsInsert,dsBrowse];
end;

procedure TA024FRegoleIndennita.ETipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Control = ETipo then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Tipo[Index])
  else if Control = dcmbTurno then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Turno[Index])
  else if Control = dcmbArrotondamento then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_Arrotondamento[Index]);
end;

procedure TA024FRegoleIndennita.dGrdAssociazioneEditButtonClick(
  Sender: TObject);
var lst:TStringList;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
(*  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A024FIndPresenzaDtM1.selT164.FieldByName('ESPRESSIONE').AsString:=TrasformaV430(S);
  end;*)
  lst:=TStringList.Create;
  try
    lst.Text:=A024FIndPresenzaDtM1.selT164.FieldByName('ESPRESSIONE').AsString;
    if True then
    
    if DButton.State in [dsEdit,dsInsert] then
    begin
      OpenC012VisualizzaTesto('','',lst,'',[mbOK,mbCancel]);
      if A024FIndPresenzaDtM1.selT164.State = dsBrowse then
        A024FIndPresenzaDtM1.selT164.Edit;
      A024FIndPresenzaDtM1.selT164.FieldByName('ESPRESSIONE').AsString:=Trim(lst.Text);
    end
    else
      OpenC012VisualizzaTesto('','',lst,'',[mbCancel]);
  finally
    lst.Free;
  end;
end;

procedure TA024FRegoleIndennita.btnIncompatibilitaClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
    try
      A024FIndPresenzaDtM1.selT162Incomp.Close;
      A024FIndPresenzaDtM1.selT162Incomp.SetVariable('CODICE',A024FIndPresenzaDtM1.Q162.FieldByName('CODICE').AsString);
      A024FIndPresenzaDtM1.selT162Incomp.Open;
      while not A024FIndPresenzaDtM1.selT162Incomp.Eof do
      begin
        clbListaDati.Items.Add(Format('%-5s %s',[A024FIndPresenzaDtM1.selT162Incomp.FieldByName('CODICE').AsString,A024FIndPresenzaDtM1.selT162Incomp.FieldByName('DESCRIZIONE').AsString]));
        A024FIndPresenzaDtM1.selT162Incomp.Next;
      end;
      R180PutCheckList(dedtIncompatibilita.Field.AsString,5,clbListaDati);
      if ShowModal = mrOK then
        dedtIncompatibilita.Field.AsString:=R180GetCheckList(5,clbListaDati);
    finally
      Free;
    end;
end;

procedure TA024FRegoleIndennita.btnLimitiIndClick(Sender: TObject);
begin
  inherited;
  A024FLimitiInd:=TA024FLimitiInd.Create(nil);
  try
    A024FLimitiInd.LimitiInd:=A024FIndPresenzaDtM1.Q162.FieldByName('CODICE').AsString;
    A024FLimitiInd.ShowModal;
  finally
    FreeAndNil(A024FLimitiInd);
  end;
end;

procedure TA024FRegoleIndennita.btnVisioneCorrenteClick(Sender: TObject);
begin
  inherited;
  with A024FIndPresenzaDtM1 do
  begin
    if Not selT164.Filtered then
    begin
      selT164.Filter:='(' + FloatToStr(Parametri.DataLavoro) + ' >= DECORRENZA) and (' + FloatToStr(Parametri.DataLavoro) + ' <= SCADENZA)';
      selT164.Filtered:=True;
    end
    else
      selT164.Filtered:=False;
    btnVisioneCorrente.Down:=selT164.Filtered;
  end;
end;

procedure TA024FRegoleIndennita.dcmbTurnoChange(Sender: TObject);
begin
  inherited;
  ImpostaCampi;
end;

procedure TA024FRegoleIndennita.dcmbCodice2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA024FRegoleIndennita.dCmbMaturaSabatoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var OutText:String;
begin
  inherited;
  case Index of
    0:OutText:='Si';
    1:OutText:='No';
    2:OutText:='Aggiungi fuori equilibrio';
  end;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top, OutText);
end;

procedure TA024FRegoleIndennita.btnAssenzeAbilitateClick(Sender: TObject);
var SF:TStringField;
begin
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C013FCheckList:=TC013FCheckList.Create(nil);
  SF:=(dedtAssenzeAbilitate.Field as TStringField);
  with C013FCheckList do
    try
      clbListaDati.Items.Assign(ListaAssenze);
      R180PutCheckList(SF.AsString,5,clbListaDati);
      if ShowModal = mrOK then
        SF.AsString:=StringReplace(StringReplace(R180GetCheckList(5,clbListaDati),'*** A','',[]),'*** P','',[]);
    finally
      Free;
    end;
end;

end.
