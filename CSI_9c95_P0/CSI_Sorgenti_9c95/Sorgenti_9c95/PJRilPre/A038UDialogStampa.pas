unit A038UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, checklst, C180FunzioniGenerali, DB, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, C001StampaLib, Variants;

type
  TA038FDialogStampa = class(TForm)
    CheckListBox1: TCheckListBox;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ItemCB:Integer;
  public
    { Public declarations }
  end;

var
  A038FDialogStampa: TA038FDialogStampa;

implementation

uses A038UVociVariabiliDtM1, A038UStampaVoci, A038UVociVariabili;

{$R *.DFM}

procedure TA038FDialogStampa.FormShow(Sender: TObject);
begin
  CheckListBox1.Items.Add('VOCE PAGHE');
  CheckListBox1.Items.Add('COD.PAGHE INTERNO');
  CheckListBox1.Items.Add('DATA RIFERIMENTO');
  CheckListBox1.Items.Add('DATA CASSA');
  CheckListBox1.Items.Add('UNITA'' DI MISURA');
  with A038FVociVariabiliDtM1.selI010 do
    begin
    First;
    while not Eof do
      begin
      CheckListBox1.Items.Add(FieldByName('Nome_Logico').AsString);
      Next;
      end;
    end;
end;

procedure TA038FDialogStampa.BitBtn1Click(Sender: TObject);
var i:Integer;
    S,C,O,R,O2:String;
begin
  C700SelAnagrafe.Close;
//  S:=UpperCase(EliminaRitornoACapo(C700SelAnagrafe.SQL.Text));
  S:=EliminaRitornoACapo(C700SelAnagrafe.SQL.Text);
  O:='';
  R:='';
  for i:=0 to CheckListBox1.Items.Count - 1 do
    if CheckListBox1.Checked[i] then
    begin
      O2:='';
      if CheckListBox1.Items[i] = 'VOCE PAGHE' then
      begin
        C:='VOCEPAGHE';
        O2:='T195.' + C;
      end
      else if CheckListBox1.Items[i] = 'COD.PAGHE INTERNO' then
      begin
        C:='COD_INTERNO';
        O2:='T195.' + C;
      end
      else if CheckListBox1.Items[i] = 'DATA RIFERIMENTO' then
      begin
        C:='DATARIF';
        O2:='T195.' + C;
      end
      else if CheckListBox1.Items[i] = 'DATA CASSA' then
      begin
        C:='DATA_CASSA';
        O2:='T195.' + C;
      end
      else if CheckListBox1.Items[i] = 'UNITA'' DI MISURA' then
      begin
        C:='UM';
        O2:='T195.' + C;
      end
      else
      begin
        C:=A038FVociVariabiliDtM1.selI010.Lookup('Nome_Logico',CheckListBox1.Items[i],'Nome_Campo');
        if Copy(C,1,4) = 'T430' then
          R180InserisciColonna(S,C)
        else
          R180InserisciColonna(S,'T030.' + C);
        if Copy(C,1,4) <> 'T430' then
          O2:='T030.' + C
        else
          O2:=C;
      end;
      if O <> '' then
        O:=O + ',';
      O:=O + O2;
      if R <> '' then
        R:=R + '+';
      R:=R + C;
    end;
  i:=Pos('ORDER BY',S);
  if i > 0 then
    S:=Copy(S,1,i - 1);
  if O <> '' then
    O:=O + ',';
  S:=S + 'ORDER BY ' + O + 'COGNOME,NOME,DATARIF,VOCEPAGHE';
  C700SelAnagrafe.SQL.Text:=S;
  C700SelAnagrafe.SetVariable('DATALAVORO',A038FVociVariabili.Data2);
  C700SelAnagrafe.SetVariable('DATA1',A038FVociVariabili.Data1);
  C700SelAnagrafe.SetVariable('DATA2',A038FVociVariabili.Data2);
  C700SelAnagrafe.Open;
  C700SelAnagrafe.FieldByName('Valore').OnGetText:=A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195VALOREGetText;
  C700SelAnagrafe.FieldByName('Cod_Interno').OnGetText:=A038FVociVariabiliDtM1.A038FVociVariabiliMW.CodInternoGetText;
  TDateTimeField(C700SelAnagrafe.FieldByName('DataRif')).DisplayFormat:='mm-yyyy';
  with A038FStampaVoci do
    begin
    QRep.DataSet:=C700SelAnagrafe;
    qdedtMatricola.DataSet:=C700SelAnagrafe;
    qdedtDataRif.DataSet:=C700SelAnagrafe;
    qdedtVocePaghe.DataSet:=C700SelAnagrafe;
    qdedtValore.DataSet:=C700SelAnagrafe;
    qdedtUM.DataSet:=C700SelAnagrafe;
    qdedtDal.DataSet:=C700SelAnagrafe;
    qdedtAl.DataSet:=C700SelAnagrafe;
    qdedtOperazione.DataSet:=C700SelAnagrafe;
    LEnte.Caption:=Parametri.RagioneSociale;
    LTitolo.Caption:=Format('Voci variabili scaricate da %s a %s',[FormatDateTime('mmmm yyyy',A038FVociVariabili.Data1),FormatDateTime('mmmm yyyy',A038FVociVariabili.Data2)]);
    QRGroup1.Enabled:=R <> '';
    QRGroup1.Expression:=R;
    QRGroup1.ForceNewPage:=CheckBox1.Checked;
    if Sender = BitBtn2 then
      QRep.Preview
    else
      QRep.Print;
    end;
  C700SelAnagrafe.FieldByName('Valore').OnGetText:=nil;
end;

procedure TA038FDialogStampa.CheckListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemCB:=CheckListBox1.ItemIndex;
end;

procedure TA038FDialogStampa.CheckListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (ItemCB <> -1) and (ItemCB <> CheckListBox1.ItemIndex) then
    CheckListBox1.Items.Exchange(ItemCB,CheckListBox1.ItemIndex);
  ItemCB:= - 1;
end;

procedure TA038FDialogStampa.BitBtn4Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A038FStampaVoci.QRep);
end;

procedure TA038FDialogStampa.FormCreate(Sender: TObject);
begin
  A038FStampaVoci:=TA038FStampaVoci.Create(nil);
  try
    C001SettaQuickReport(A038FStampaVoci.QRep);
  except
  end;
end;

procedure TA038FDialogStampa.FormDestroy(Sender: TObject);
begin
  A038FStampaVoci.Free;
end;

end.
