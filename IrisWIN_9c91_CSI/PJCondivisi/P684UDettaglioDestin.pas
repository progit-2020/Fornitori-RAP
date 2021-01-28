unit P684UDettaglioDestin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, C600USelAnagrafe, DBCtrls, Buttons, Mask,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C180FunzioniGenerali,
  Oracle, OracleData, C013UCheckList;

type
  TP684FDettaglioDestin = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    Panel2: TPanel;
    lblCodVoceDett: TLabel;
    Label1: TLabel;
    dedtCodVoceGen: TDBEdit;
    dcmbCodVoceGen: TDBLookupComboBox;
    lblCodVoceGen: TLabel;
    dtxtCodVoceGen: TDBText;
    lblCodAccorpamento: TLabel;
    lblFiltroDipendenti: TLabel;
    dedtCodAccorpamento: TDBEdit;
    btnCodAccorpamento: TBitBtn;
    dmemFiltroDipendenti: TDBMemo;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    Label2: TLabel;
    Label3: TLabel;
    dedtImportoSpeso: TDBEdit;
    dcmbArrotSpeso: TDBLookupComboBox;
    btnVisDettaglio: TBitBtn;
    dmemDescrizione: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dcmbCodVoceGenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbCodVoceGenCloseUp(Sender: TObject);
    procedure dcmbCodVoceGenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCodAccorpamentoClick(Sender: TObject);
    procedure dcmbArrotSpesoCloseUp(Sender: TObject);
    procedure dcmbArrotSpesoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnVisDettaglioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FondoElab:String;
    DataElab:TDateTime;
  end;

var
  P684FDettaglioDestin: TP684FDettaglioDestin;

  procedure OpenP684DettaglioDestin(Fondo:String;Dec:TDateTime);

implementation

uses P684UDefinizioneFondiDtM, P684UGrigliaDett;

{$R *.dfm}

procedure OpenP684DettaglioDestin(Fondo:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FDettaglioDestin,P684FDettaglioDestin);
  with P684FDettaglioDestin do
  try
    DataElab:=Dec;
    FondoElab:=Fondo;
    ShowModal;
  finally
    FreeAndNil(P684FDettaglioDestin);
  end;
end;

procedure TP684FDettaglioDestin.btnCodAccorpamentoClick(Sender: TObject);
var S:String;
  i:Integer;
begin
  inherited;
  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco accorpamenti';
  with C013FCheckList do
    try
      with P684FDefinizioneFondiDtM.selP215 do
      begin
        Open;
        clbListaDati.Items.Clear;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-21s',[FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
        Close;
      end;
      S:=dedtCodAccorpamento.Text;
      S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
      R180PutCheckList(S,21,clbListaDati);
      for i:=0 to clbListaDati.Count - 1 do
        if clbListaDati.Checked[i] then
        begin
          clbListaDati.ItemIndex:=i;
          Break;
        end;
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(21,clbListaDati);
        if Trim(S) <> '' then
          S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';
        dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:=S;
        dedtCodAccorpamento.Hint:=dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString;
      end;
    finally
      Free;
    end;
end;

procedure TP684FDettaglioDestin.btnVisDettaglioClick(Sender: TObject);
var Imp:Real;
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP690A.Close;
    selP690A.SetVariable('COD',selP688D.FieldByName('COD_FONDO').AsString);
    selP690A.SetVariable('DEC',selP688D.FieldByName('DECORRENZA_DA').AsDateTime);
    selP690A.SetVariable('CODGEN','and P690.cod_voce_gen = ''' + selP688D.FieldByName('COD_VOCE_GEN').AsString + '''');
    selP690A.SetVariable('CODDET','and P690.cod_voce_det = ''' + selP688D.FieldByName('COD_VOCE_DET').AsString + '''');
    selP690A.SetVariable('DATI',''' ''');
    selP690A.Open;
    Imp:=0;
    if selP690A.RecordCount > 0 then  //Arrotondo la somma
    begin
      Imp:=selP690A.FieldByName('Importo').AsFloat;
      if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
      begin
        if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
          (Imp <> 0) then
          Imp:=R180Arrotonda(Imp,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
      end;
    end;
    if R180AzzeraPrecisione(Imp - selP688D.FieldByName('IMPORTO').AsFloat,2) <> 0 then
      R180MessageBox('Attenzione: l''importo speso non coincide con il dettaglio dei consumi mensili','INFORMA');
    OpenP684GrigliaDett(selP688D.FieldByName('COD_FONDO').AsString,selP688D.FieldByName('COD_VOCE_GEN').AsString,
      selP688D.FieldByName('COD_VOCE_DET').AsString,selP688D.FieldByName('DECORRENZA_DA').AsDateTime);
  end;
end;

procedure TP684FDettaglioDestin.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
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
    Result:=X;
  end;
begin
  inherited;
  if P684FDefinizioneFondiDtm.selP688D.FieldByName('DECORRENZA_DA').IsNull then
    C600frmSelAnagrafe.C600DataLavoro:=Date
  else
    C600frmSelAnagrafe.C600DataLavoro:=P684FDefinizioneFondiDtm.selP688D.FieldByName('DECORRENZA_DA').AsDateTime;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    P684FDefinizioneFondiDtM.selP688D.FieldByName('FILTRO_DIPENDENTI').AsString:=TrasformaV430(S);
  end;
end;

procedure TP684FDettaglioDestin.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnCodAccorpamento.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnVisDettaglio.Enabled:=DButton.State = dsBrowse;
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TP684FDettaglioDestin.dcmbArrotSpesoCloseUp(Sender: TObject);
begin
  inherited;
  if (DButton.State <> dsEdit) and (DButton.State <> dsInsert) then
    Exit;
  with P684FDefinizioneFondiDtM do
  begin
    if selP688D.FieldByName('COD_ARROTONDAMENTO').AsString <> '' then
    begin
      if selP050.SearchRecord('Cod_Arrotondamento',selP688D.FieldByName('COD_ARROTONDAMENTO').AsString,[srFromBeginning]) and
        (selP688D.FieldByName('IMPORTO').AsFloat <> 0) then
        selP688D.FieldByName('IMPORTO').AsFloat:=
          R180Arrotonda(selP688D.FieldByName('IMPORTO').AsFloat,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
    end;
  end;
end;

procedure TP684FDettaglioDestin.dcmbArrotSpesoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbArrotSpesoCloseUp(nil);
end;

procedure TP684FDettaglioDestin.dcmbCodVoceGenCloseUp(Sender: TObject);
begin
  inherited;
  dtxtCodVoceGen.Visible:=Trim(dcmbCodVoceGen.Text) <> '';
end;

procedure TP684FDettaglioDestin.dcmbCodVoceGenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TP684FDettaglioDestin.dcmbCodVoceGenKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbCodVoceGenCloseUp(nil);
end;

procedure TP684FDettaglioDestin.FormDestroy(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TP684FDettaglioDestin.FormShow(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with P684FDefinizioneFondiDtM do
  begin
    DButton.DataSet:=selP688D;
    edtDecorrenza.Text:=DateToStr(DataElab);
    edtFondo.Text:=FondoElab;
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElab,FondoElab]),'DESCRIZIONE'));
  end;
end;

end.
