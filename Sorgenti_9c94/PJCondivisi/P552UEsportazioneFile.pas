unit P552UEsportazioneFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, DBCtrls, Mask, Spin, Oracle, OracleData, Buttons,
  C180FunzioniGenerali, C013UCheckList;

type
  TP552FEsportazioneFile = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblTabella: TLabel;
    lblCodTabella: TLabel;
    edtTabella: TEdit;
    edtAnno: TEdit;
    Panel2: TPanel;
    edtNumCampo: TSpinEdit;
    Label1: TLabel;
    dedtDescrizione: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dedtLunghezza: TDBEdit;
    Label6: TLabel;
    dedtFormula: TDBEdit;
    cmbFormato: TComboBox;
    cmbTipoCampo: TComboBox;
    btnFormula: TBitBtn;
    dtxtLungProg: TDBText;
    lblLungProg: TLabel;
    procedure TAnnullaClick(Sender: TObject);
    procedure cmbTipoCampoChange(Sender: TObject);
    procedure btnFormulaClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TabElab,AnnoElab:String;
    NumCampo:Integer;
  end;

var
  P552FEsportazioneFile: TP552FEsportazioneFile;

  procedure OpenP522EsportazioneFile(Anno,Num:Integer;Tabella:String);

implementation

uses P552URegoleContoAnnualeDtM;

{$R *.dfm}

procedure OpenP522EsportazioneFile(Anno,Num:Integer;Tabella:String);
begin
  Application.CreateForm(TP552FEsportazioneFile,P552FEsportazioneFile);
  with P552FEsportazioneFile do
  try
    AnnoElab:=IntToStr(Anno);
    TabElab:=Tabella;
    NumCampo:=Num;
    ShowModal;
  finally
    P552FRegoleContoAnnualeDtM.selP551.Refresh;
    P552FRegoleContoAnnualeDtM.selP551.SearchRecord('NUM_CAMPO',NumCampo,[srFromBeginning]);
    FreeAndNil(P552FEsportazioneFile);
  end;
end;

procedure TP552FEsportazioneFile.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=P552FRegoleContoAnnualeDtM.selP551;
  edtAnno.Text:=AnnoElab;
  edtTabella.Text:=TabElab;
  lblTabella.Caption:=VarToStr(P552FRegoleContoAnnualeDtM.selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'DESCRIZIONE'));
  //Carica combo Tipo campo
  cmbTipoCampo.Items.Clear;
  cmbTipoCampo.Items.Add('ANNO      ' + ' - Anno di riferimento');
  cmbTipoCampo.Items.Add('AZIENDA   ' + ' - Codice azienda sanitaria');
  cmbTipoCampo.Items.Add('FILLER    ' + ' - Campo Filler');
  cmbTipoCampo.Items.Add('FORMULA   ' + ' - Campo Formula');
  cmbTipoCampo.Items.Add('IDCATEG   ' + ' - Codice identificativo della categoria');
  cmbTipoCampo.Items.Add('IDCOMPARTO' + ' - Codice identificativo del comparto di contr.collettiva');
  cmbTipoCampo.Items.Add('IDDSM     ' + ' - Codice identificativo del dipartimento di salute mentale');
  cmbTipoCampo.Items.Add('IDFIGURA  ' + ' - Codice identificativo della figura');
  cmbTipoCampo.Items.Add('IDISTITUTO' + ' - Codice identificativo dell''istituto di ricovero');
  cmbTipoCampo.Items.Add('REGIONE   ' + ' - Codice regione');
  cmbTipoCampo.Items.Add('TIPOOPERAZ' + ' - Indicatore del tipo operazione effettuata');
  with P552FRegoleContoAnnualeDtM.selP552Colonne do
  begin
    Close;
    SetVariable('CODTABELLA',TabElab);
    SetVariable('ANNO',AnnoElab);
    Open;
    First;
    while not Eof do
    begin
      cmbTipoCampo.Items.Add('C' + Format('%3.3d',[FieldByName('COLONNA').AsInteger]) + '       - ' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  P552FRegoleContoAnnualeDtM.selP551.SearchRecord('NUM_CAMPO',NumCampo,[srFromBeginning]);
end;

procedure TP552FEsportazioneFile.DButtonStateChange(Sender: TObject);
begin
  inherited;
  edtNumCampo.Enabled:=DButton.State in [dsInsert];
  cmbTipoCampo.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbFormato.Enabled:=DButton.State in [dsEdit,dsInsert];
  dedtFormula.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Trim(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA');
  btnFormula.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Trim(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA');
end;

procedure TP552FEsportazioneFile.TInserClick(Sender: TObject);
begin
  inherited;
  with P552FRegoleContoAnnualeDtM do
  begin
    QSQL.Close;
    QSQL.SQL.Clear;
    QSQL.SQL.Text:='SELECT MAX(NUM_CAMPO) NUM FROM P551_CONTOANNFILE WHERE ANNO = ' + AnnoElab + ' AND COD_TABELLA = ''' + TabElab + '''';
    QSQL.Open;
    edtNumCampo.Value:=QSQL.FieldByName('NUM').AsInteger + 1;
    cmbTipoCampo.SetFocus;
  end;
end;

procedure TP552FEsportazioneFile.btnFormulaClick(Sender: TObject);
var i:Integer;
  S,SOld:String;
begin
  inherited;
    // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco colonne';
  with C013FCheckList do
    try
      with P552FRegoleContoAnnualeDtM.selP552Colonne do
      begin
        First;
        clbListaDati.Items.Clear;
        while not Eof do
        begin
          clbListaDati.Items.Add('C' + Format('%3.3d',[FieldByName('COLONNA').AsInteger]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
      SOld:=dedtFormula.Text;
      R180PutCheckList(StringReplace(StringReplace(dedtFormula.Text,'+',',',[rfReplaceAll]),'-',',',[rfReplaceAll]),4,clbListaDati);
      for i:=0 to clbListaDati.Count - 1 do
        if clbListaDati.Checked[i] then
        begin
          clbListaDati.ItemIndex:=i;
          Break;
        end;
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(4,clbListaDati);
        //Gestione del segno
        if Trim(S) <> '' then
        begin
          S:=StringReplace(S,',','+',[rfReplaceAll]);
          for i:=0 to clbListaDati.Items.Count - 1 do
            if clbListaDati.Checked[i] then
              if (Pos(Trim(Copy(clbListaDati.Items[i],1,4)),SOld) > 1)
              and (Trim(Copy(SOld,Pos(Trim(Copy(clbListaDati.Items[i],1,4)),SOld) - 1,1)) = '-') then
                if Pos(Trim(Copy(clbListaDati.Items[i],1,4)),S) = 1 then
                  S:='-' + S
                else
                  S:=StringReplace(S,'+' + Trim(Copy(clbListaDati.Items[i],1,4)),'-' + Trim(Copy(clbListaDati.Items[i],1,4)),[rfReplaceAll]);
        end;
        dButton.Dataset.FieldByName('FORMULA').AsString:=S;
      end;
    finally
      Free;
    end;
end;

procedure TP552FEsportazioneFile.cmbTipoCampoChange(Sender: TObject);
begin
  inherited;
  if Trim(dedtDescrizione.Text) = '' then
    DButton.Dataset.FieldByName('DESCRIZIONE').AsString:=Copy(cmbTipoCampo.Text,14,Length(cmbTipoCampo.Text)-13);
  dedtFormula.Enabled:=Trim(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA';
  btnFormula.Enabled:=Trim(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA';
  if not dedtFormula.Enabled then
    DButton.Dataset.FieldByName('FORMULA').AsString:='';
end;

procedure TP552FEsportazioneFile.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

end.
