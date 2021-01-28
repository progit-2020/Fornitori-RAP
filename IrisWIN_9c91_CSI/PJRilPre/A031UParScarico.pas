unit A031UParScarico;

interface

uses
  C012UVisualizzaTesto, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Math, R001UGESTTAB, C013UCheckList, DB, Menus,
  Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, DBCtrls, Grids, ActnList,
  ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants,
  C180FunzioniGenerali, System.Actions, System.ImageList;

type
  TA031FParScarico = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    Label4: TLabel;
    EIPAddress: TDBEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    Label3: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    Label6: TLabel;
    dedtAziende: TDBEdit;
    btnAziende: TButton;
    drgpTipologiaTimbrature: TDBRadioGroup;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    dchkTimbNonTollLog: TDBCheckBox;
    dchkTimbNonTollReg: TDBCheckBox;
    dedtTimbNonTollGgPrec: TDBEdit;
    dedtTimbNonTollGgSucc: TDBEdit;
    lblOffsetAnno: TLabel;
    dedtOffsetAnno: TDBEdit;
    lblExprChiave: TLabel;
    dedtExprChiave: TDBEdit;
    btnEditExprChiave: TButton;
    btnSrcTriggerBefore: TBitBtn;
    btnSrcTriggerAfter: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnAziendeClick(Sender: TObject);
    procedure dedtTimbNonTollGgPrecExit(Sender: TObject);
    procedure dedtTimbNonTollGgSuccExit(Sender: TObject);
    procedure DBCheckBox3Click(Sender: TObject);
    procedure btnEditExprChiaveClick(Sender: TObject);
    procedure btnSrcTriggerBeforeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A031FParScarico: TA031FParScarico;

procedure OpenA031ParScarico(Cod:String);

implementation

uses A031UParScaricoDtM1;

{$R *.DFM}

procedure OpenA031ParScarico(Cod:String);
{Parametrizzazione scarico rilevatori}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA031ParScarico') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A031FParScarico:=TA031FParScarico.Create(nil);
  with A031FParScarico do
  try
    A031FParScaricoDtM1:=TA031FParScaricoDtM1.Create(nil);
    A031FParScaricoDtM1.QI100.Locate('Scarico',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A031FParScaricoDtM1.Free;
    Release;
  end;
end;

procedure TA031FParScarico.FormCreate(Sender: TObject);
begin
  inherited;
  with StringGrid1 do
  begin
    ColWidths[0]:=40;
    ColWidths[1]:=40;
    ColWidths[3]:=40;
    ColWidths[4]:=40;
    ColWidths[5]:=40;
    ColWidths[6]:=40;
    ColWidths[7]:=40;
    ColWidths[9]:=40;
    ColWidths[8]:=55;
    ColWidths[10]:=55;
    ColWidths[11]:=55;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // Chiave: dato parametrico per associazione con dipendente
    ColWidths[12]:=55;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
    Cells[0,1]:='Pos.';
    Cells[0,2]:='Lung.';
    Cells[1,0]:='Badge';
    Cells[2,0]:='Ediz.Badge';
    Cells[3,0]:='Anno';
    Cells[4,0]:='Mese';
    Cells[5,0]:='Giorno';
    Cells[6,0]:='Ore';
    Cells[7,0]:='Minuti';
    Cells[8,0]:='Secondi';
    Cells[9,0]:='Verso';
    Cells[10,0]:='Rilevatore';
    Cells[11,0]:='Causale';
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // Chiave: dato parametrico per associazione con dipendente
    Cells[12,0]:='Chiave';
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
  end;
end;

procedure TA031FParScarico.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A031FParScaricoDtM1.QI100;
  inherited;
  DBCheckBox3Click(nil);
end;

procedure TA031FParScarico.DBCheckBox2Click(Sender: TObject);
{Abilito/Disabilito il campo IP Address}
begin
  if not DBCheckBox2.Checked then
    if DButton.State in [dsInsert,dsEdit] then
      A031FParScaricoDtM1.QI100.FieldByName('IPADDRESS').Clear;
  EIPAddress.Enabled:=DBCheckBox2.Checked;
end;

procedure TA031FParScarico.DBCheckBox3Click(Sender: TObject);
begin
  inherited;
  lblOffsetAnno.Enabled:=DBCheckBox3.Checked;
  dedtOffsetAnno.Enabled:=DBCheckBox3.Checked;
  if DButton.State in [dsInsert,dsEdit] then
    if DBCheckBox3.Checked then
      dedtOffsetAnno.Field.AsInteger:=IfThen(dedtOffsetAnno.Field.IsNull,1980,dedtOffsetAnno.Field.AsInteger)
    else
      dedtOffsetAnno.Field.Clear;
end;

procedure TA031FParScarico.DButtonDataChange(Sender: TObject;
  Field: TField);
{Carico nella Griglia i valori dei campi}
var i,P:Byte;
    S:String;
begin
  if Field = nil then
  begin
    for i:=5 to {15}16 do // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
    begin
      S:=DButton.DataSet.Fields[i].AsString;
      P:=Pos(',',S);
      StringGrid1.Cells[i - 4,1]:=Copy(S,1,P - 1);
      StringGrid1.Cells[i - 4,2]:=Copy(S,P + 1,Length(S));
    end;
  end;
end;

procedure TA031FParScarico.DButtonStateChange(Sender: TObject);
{Rendo la griglia modificabile solo se sono in Insert o Edit}
begin
  inherited;
  btnAziende.Enabled:=DButton.State in [dsInsert,dsEdit];
  Button1.Enabled:=DButton.State in [dsInsert,dsEdit];
  if DButton.State in [dsInsert,dsEdit] then
    StringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing]
  else
    StringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  btnEditExprChiave.Enabled:=DButton.State in [dsInsert,dsEdit];
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
end;

procedure TA031FParScarico.dedtTimbNonTollGgPrecExit(Sender: TObject);
begin
  inherited;
  if (A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGPREC').AsInteger < -1)
    or (A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGPREC').IsNull) then
    A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGPREC').AsInteger:=-1;
end;

procedure TA031FParScarico.dedtTimbNonTollGgSuccExit(Sender: TObject);
begin
  inherited;
  if (A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGSUCC').AsInteger < -1)
    or (A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGSUCC').IsNull) then
    A031FParScaricoDtM1.QI100.FieldByName('TIMB_NONTOLL_GGSUCC').AsInteger:=-1;
end;

procedure TA031FParScarico.btnEditExprChiaveClick(Sender: TObject);
var
  LstExpr: TStringList;
begin
  LstExpr:=TStringList.Create;
  try
    LstExpr.Text:=dedtExprChiave.Field.AsString;
    OpenC012VisualizzaTesto(lblExprChiave.Caption,'',LstExpr,'',[mbOK,mbCancel]);
    if DButton.State in [dsInsert,dsEdit] then
      dedtExprChiave.Field.AsString:=LstExpr.Text;
  finally
    FreeAndNil(LstExpr);
  end;
end;

procedure TA031FParScarico.btnSrcTriggerBeforeClick(Sender: TObject);
var
  LLst: TStringList;
  LObjName: string;
  LTitolo: string;
begin
  if Sender = btnSrcTriggerBefore then
  begin
    LObjName:='TIMB_TRIGGER_BEFORE';
    LTitolo:='Sorgente procedura Oracle eseguita prima dell''acquisizione';
  end
  else if Sender = btnSrcTriggerAfter then
  begin
    LObjName:='TIMB_TRIGGER_AFTER';
    LTitolo:='Sorgente procedura Oracle eseguita dopo l''acquisizione';
  end;

  Screen.Cursor:=crHourGlass;
  LLst:=TStringList.Create;
  try
    R180OracleObjectSource(LObjName,SessioneOracle,LLst);
    OpenC012VisualizzaTesto(LTitolo,'',LLst);
  finally
    FreeAndNil(LLst);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA031FParScarico.Button1Click(Sender: TObject);
begin
  if OpenDialog1 .Execute then
    A031FParScaricoDtM1.QI100NomeFile.AsString:=OpenDialog1.FileName;
end;

procedure TA031FParScarico.btnAziendeClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
    try
      if Parametri.Azienda <> 'AZIN' then
      begin
        A031FParScaricoDtM1.selI090.Filtered:=False;
        A031FParScaricoDtM1.selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
        A031FParScaricoDtM1.selI090.Filtered:=True;
      end;    
      A031FParScaricoDtM1.selI090.First;
      while not A031FParScaricoDtM1.selI090.Eof do
      begin
        clbListaDati.Items.Add(A031FParScaricoDtM1.selI090.FieldByName('AZIENDA').AsString);
        A031FParScaricoDtM1.selI090.Next;
      end;
      R180PutCheckList(dedtAziende.Field.AsString,30,clbListaDati);
      if ShowModal = mrOK then
        dedtAziende.Field.AsString:=R180GetCheckList(30,clbListaDati);
    finally
      Free;
    end;
end;

end.
