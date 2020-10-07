unit A071URegoleBuoni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls,
  DBCtrls, Mask, ActnList, ImgList, ToolWin, CheckLst, A000UCostanti, A000USessione, Spin, Variants,
  C180FunzioniGenerali, C013UCheckList, System.Actions, System.ImageList;

type
  TA071FRegoleBuoni = class(TR001FGestTab)
    lblCodice: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBText1: TDBText;
    DBRadioGroup1: TDBRadioGroup;
    PageControl1: TPageControl;
    tabMaturazione: TTabSheet;
    tabAcquisto: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Button1: TButton;
    DBEdit2: TDBEdit;
    Button2: TButton;
    dchkGiornoNonLav: TDBCheckBox;
    dchkOrarioSpezzato: TDBCheckBox;
    lblMesiPrecedenti: TLabel;
    lblConguaglioMax: TLabel;
    dedtMesiPrecedenti: TDBEdit;
    dedtConguaglioMax: TDBEdit;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    grpFascia1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    DA1: TDBEdit;
    A1: TDBEdit;
    grpFascia2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    DA2: TDBEdit;
    A2: TDBEdit;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    ECausTicket: TDBEdit;
    EForzaMaturaz: TDBEdit;
    EInibizMaturaz: TDBEdit;
    Button5: TButton;
    Button4: TButton;
    Button3: TButton;
    chklstMesiAcq: TCheckListBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    DBRadioGroup2: TDBRadioGroup;
    Label14: TLabel;
    DBEdit6: TDBEdit;
    dckAccessiMensa: TDBCheckBox;
    dchkPausaMensa: TDBCheckBox;
    Label15: TLabel;
    dedtRestituzionMax: TDBEdit;
    Label16: TLabel;
    dedtAcquistoMinimo: TDBEdit;
    dchkMissioni: TDBCheckBox;
    Label17: TLabel;
    Label18: TLabel;
    edtNumMaxBuoni: TSpinEdit;
    dEdtDebitoGiornMin: TDBEdit;
    dEdtEccedenzaMin: TDBEdit;
    Label19: TLabel;
    Label20: TLabel;
    clbGiorniFissi: TCheckListBox;
    Label21: TLabel;
    DBEdit7: TDBEdit;
    Label22: TLabel;
    edtResiduoPrecedente: TDateTimePicker;
    dchkOreMinNettoPM: TDBCheckBox;
    GroupBox2: TGroupBox;
    dedtOreMinime: TDBEdit;
    dedtOreMattina: TDBEdit;
    dedtOrePomeriggio: TDBEdit;
    LblRientroPom: TLabel;
    dEdtIniPom: TDBEdit;
    Label23: TLabel;
    Label24: TLabel;
    dchkPausaMensaGestita: TDBCheckBox;
    dCmbPeriodoCompl: TDBComboBox;
    chkIntervalloEffettivo: TDBCheckBox;
    chkFascia1Esclusiva: TDBCheckBox;
    dcmbRegolaSuccessiva: TDBLookupComboBox;
    DBText2: TDBText;
    Label25: TLabel;
    dchkFasceMatPomPMT: TDBCheckBox;
    Label26: TLabel;
    dchkRegolaRientroPomeridiano: TDBCheckBox;
    Label27: TLabel;
    DBEdit8: TDBEdit;
    lblAssenzeTollPerc: TLabel;
    dedtAssenzeTollPerc: TDBEdit;
    btnAssenzeTollPerc: TButton;
    dedtPercTollAssenze: TDBEdit;
    dedtOreMinimeSecondoBuono: TDBEdit;
    Label29: TLabel;
    lblOreMinimeSecondoBuono: TLabel;
    grpFascia3: TGroupBox;
    lblDA3: TLabel;
    lblA3: TLabel;
    dedtDA3: TDBEdit;
    dedtA3: TDBEdit;
    lblOreMinimeFascia3: TLabel;
    dedtOreMinimeFascia3: TDBEdit;
    Label30: TLabel;
    dchkGGLavSempreCalendario: TDBCheckBox;
    dchkGGLavNoPianifCalendario: TDBCheckBox;
    lblAssenzeDiminuzioneIncluse: TLabel;
    dedtAssenzeDiminuzioneIncluse: TDBEdit;
    btnAssenzeDiminuzioneIncluse: TButton;
    dchlEstendiIntervalloPMT: TDBCheckBox;
    dchkIntervalloInternoPMT: TDBCheckBox;
    dchkConsideraGGSucc: TDBCheckBox;
    lblOrariInibiti: TLabel;
    dedtOrariInibiti: TDBEdit;
    btnOrariInibiti: TButton;
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dedtOreMinimeChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure clbGiorniFissiClick(Sender: TObject);
    procedure dEdtDebitoGiornMinChange(Sender: TObject);
    procedure TGommaClick(Sender: TObject);
    procedure edtResiduoPrecedenteCloseUp(Sender: TObject);
    procedure dCmbPeriodoComplDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnAssenzeDiminuzioneIncluseClick(Sender: TObject);
    procedure btnOrariInibitiClick(Sender: TObject);
  private
    { Private declarations }
    Lista020,Lista265,Lista265DimIncluse,Lista275,Lista305:TStringList;
    procedure SettaCausali(S:String);
    function GetCausali:String;
  public
    { Public declarations }
  end;

const PeriodoCompl:array[0..2] of string = ({N}'Giornata intera',
                                            {S}'1°+2° fascia',
                                            {E}'estremi 1° e 2° fascia');

var
  A071FRegoleBuoni: TA071FRegoleBuoni;

procedure OpenA071RegoleBuoni;

implementation

uses A071URegoleBuoniDtM1;

{$R *.DFM}

procedure OpenA071RegoleBuoni;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA071RegoleBuoni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A071FRegoleBuoni:=TA071FRegoleBuoni.Create(nil);
  with A071FRegoleBuoni do
  try
    A071FRegoleBuoniDtM1:=TA071FRegoleBuoniDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A071FRegoleBuoniDtM1.Free;
    Free;
  end;
end;

procedure TA071FRegoleBuoni.FormCreate(Sender: TObject);
begin
  inherited;
  Lista020:=TStringList.Create;
  Lista265:=TStringList.Create;
  Lista265DimIncluse:=TStringList.Create;
  Lista275:=TStringList.Create;
  Lista305:=TStringList.Create;
end;

procedure TA071FRegoleBuoni.FormShow(Sender: TObject);
begin
  inherited;
  with A071FRegoleBuoniDtM1 do
  begin
    selT020.First;
    Lista020.Clear;
    while not selT020.Eof do
    begin
      Lista020.Add(Format('%-5s %s',[selT020.FieldByName('CODICE').AsString,selT020.FieldByName('DESCRIZIONE').AsString]));
      selT020.Next;
    end;
    Q265.First;
    Lista265.Clear;
    Lista265DimIncluse.Clear;
    while not Q265.Eof do
    begin
      Lista265.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
      if R180In(Q265.FieldByName('INFLUCONT').AsString,['B','D']) then
        Lista265DimIncluse.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
      Q265.Next;
    end;
    Q275.First;
    Lista275.Clear;
    while not Q275.Eof do
    begin
      Lista275.Add(Format('%-5s %s',[Q275.FieldByName('CODICE').AsString,Q275.FieldByName('DESCRIZIONE').AsString]));
      Q275.Next;
    end;
    Q305.First;
    Lista305.Clear;
    while not Q305.Eof do
    begin
      Lista305.Add(Format('%-5s %s',[Q305.FieldByName('CODICE').AsString,Q305.FieldByName('DESCRIZIONE').AsString]));
      Q305.Next;
    end;
  end;
  edtNumMaxBuoni.Enabled:=False;
  clbGiorniFissi.Enabled:=False;
end;

procedure TA071FRegoleBuoni.DButtonStateChange(Sender: TObject);
begin
  inherited;
  Button1.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnAssenzeTollPerc.Enabled:=DButton.State in [dsEdit,dsInsert];
  Button2.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnAssenzeDiminuzioneIncluse.Enabled:=DButton.State in [dsEdit,dsInsert];
  Button3.Enabled:=DButton.State in [dsEdit,dsInsert];
  Button4.Enabled:=DButton.State in [dsEdit,dsInsert];
  Button5.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnOrariInibiti.Enabled:=DButton.State in [dsEdit,dsInsert];
  chklstMesiAcq.Enabled:=DButton.State in [dsEdit,dsInsert];
  edtNumMaxBuoni.Enabled:=DButton.State in [dsEdit,dsInsert];
  clbGiorniFissi.Enabled:=DButton.State in [dsEdit,dsInsert];
  edtResiduoPrecedente.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA071FRegoleBuoni.dedtOreMinimeChange(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
    if (Trim(TDbEdit(Sender).Text) = '.') or (Trim(TDbEdit(Sender).Text) = ':') then
      TDbEdit(Sender).Field.Clear;
end;

procedure TA071FRegoleBuoni.btnAssenzeDiminuzioneIncluseClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.clbListaDati.Items.Clear;
    C013FCheckList.clbListaDati.Items.Assign(Lista265DimIncluse);
    SettaCausali(dedtAssenzeDiminuzioneIncluse.Text);
    if C013FCheckList.ShowModal = mrOK then
      dedtAssenzeDiminuzioneIncluse.Field.AsString:=GetCausali;
  finally
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA071FRegoleBuoni.btnOrariInibitiClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(Lista020);
    SettaCausali(dedtOrariInibiti.Text);
    if ShowModal = mrOK then
      dedtOrariInibiti.Field.AsString:=GetCausali;
  finally
    Release;
  end;
end;

procedure TA071FRegoleBuoni.Button1Click(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(Lista265);
    if Sender = Button1 then
      SettaCausali(DbEdit1.Text)
    else
      SettaCausali(dedtAssenzeTollPerc.Text);
    if ShowModal = mrOK then
      if Sender = Button1 then
        DbEdit1.Field.AsString:=GetCausali
      else
        dedtAssenzeTollPerc.Field.AsString:=GetCausali
  finally
    Release;
  end;
end;

procedure TA071FRegoleBuoni.Button2Click(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    clbListaDati.Items.Clear;
    clbListaDati.Items.Assign(Lista275);
    SettaCausali(DbEdit2.Text);
    if ShowModal = mrOK then
      DbEdit2.Field.AsString:=GetCausali;
  finally
    Release;
  end;
end;

procedure TA071FRegoleBuoni.Button3Click(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    clbListaDati.Items.Clear;
    clbListaDati.Items.Add('*** Presenza');
    clbListaDati.Header[clbListaDati.Count - 1]:=True;
    clbListaDati.Items.AddStrings(Lista275);
    clbListaDati.Items.Add('*** Giustificazione');
    clbListaDati.Header[clbListaDati.Count - 1]:=True;
    clbListaDati.Items.AddStrings(Lista305);
    clbListaDati.Items.Add('*** Assenza');
    clbListaDati.Header[clbListaDati.Count - 1]:=True;
    clbListaDati.Items.AddStrings(Lista265);
    if Sender = Button3 then
      SettaCausali(ECausTicket.Text)
    else if Sender = Button4 then
      SettaCausali(EForzaMaturaz.Text)
    else
      SettaCausali(EInibizMaturaz.Text);
    if ShowModal = mrOK then
      if Sender = Button3 then
        ECausTicket.Field.AsString:=GetCausali
      else if Sender = Button4 then
        EForzaMaturaz.Field.AsString:=GetCausali
      else
        EInibizMaturaz.Field.AsString:=GetCausali
  finally
    Release;
  end;
end;

procedure TA071FRegoleBuoni.SettaCausali(S:String);
begin
  R180PutCheckList(S,5,C013FCheckList.clbListaDati);
end;

function TA071FRegoleBuoni.GetCausali:String;
begin
  Result:=R180GetCheckList(5,C013FCheckList.clbListaDati);
end;

procedure TA071FRegoleBuoni.FormDestroy(Sender: TObject);
begin
  inherited;
  Lista020.Free;
  Lista265.Free;
  Lista265DimIncluse.Free;
  Lista275.Free;
  Lista305.Free;
end;

procedure TA071FRegoleBuoni.clbGiorniFissiClick(Sender: TObject);
begin
  inherited;
  dEdtDebitoGiornMin.Field.AsString:='00.00';
end;

procedure TA071FRegoleBuoni.dCmbPeriodoComplDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,PeriodoCompl[Index]);
end;

procedure TA071FRegoleBuoni.dEdtDebitoGiornMinChange(Sender: TObject);
var i:integer;
begin
  inherited;
  if DButton.State = dsBrowse then
    Exit;
  if dEdtDebitoGiornMin.Text <> '00.00' then
    for i:=0 to clbGiorniFissi.Items.Count - 1 do
      clbGiorniFissi.Checked[i]:=False;
end;

procedure TA071FRegoleBuoni.TGommaClick(Sender: TObject);
begin
  if ActiveControl = edtResiduoPrecedente then
    edtResiduoPrecedente.DateTime:=0
  else
    inherited;
end;

procedure TA071FRegoleBuoni.edtResiduoPrecedenteCloseUp(Sender: TObject);
begin
  if R180Giorno(edtResiduoPrecedente.Date) <> 1 then
    edtResiduoPrecedente.DateTime:=R180InizioMese(edtResiduoPrecedente.DateTime);
end;

procedure TA071FRegoleBuoni.DBLookupComboBox1KeyDown(Sender: TObject;
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

end.
