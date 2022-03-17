unit R003UFormato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, R003USerbatoi, R003UGeneratoreStampe, Variants,
  R003UGeneratoreStampeMW;

type
  TR003FFormato = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Dato:TRiep;
    UsaDato:Boolean;
  end;

var
  R003FFormato: TR003FFormato;

implementation

uses R003UGeneratoreStampeDtM;

{$R *.DFM}

procedure TR003FFormato.FormCreate(Sender: TObject);
begin
  UsaDato:=True;
end;

procedure TR003FFormato.FormShow(Sender: TObject);
var
  lstTmp: TStringList;
  val, s:String;
begin
  try
    val:='';
    with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
    begin
      if not UsaDato then
      begin
        ComboBox1.Style:=csDropDownList;
        lstTmp:=getListFormato;
      end
      else if IsDatoGiustificativi(Dato) then
      begin
        lstTmp:=getListFormatoGiust;
      end
      else if IsDatoTimbr(Dato) then
      begin
        lstTmp:=getListFormatoTimb;
      end
      else if IsDatoPresCaus(Dato) then
      begin
        lstTmp:=getListPresCaus;
      end
      else if IsDatoAssCaus(Dato) then
      begin
        lstTmp:=getListAssCaus;
      end
      else if IsDatoOre(Dato) then
      begin
        val:=ComboBox1.Text;
        ComboBox1.Style:=csDropDownList;
        lstTmp:=getListOre;
      end
      else if IsDatoF0(Dato) then
      begin
        lstTmp:=getListF0;
      end
      else if IsDatoF1(Dato) then
      begin
        lstTmp:=getListF1;
      end
      else if IsDatoF2(Dato) then
      begin
        lstTmp:=getListF2;
      end
      else if IsDatoF3(Dato) then
      begin
        lstTmp:=getListF3;
      end;
    end;

    for s in lstTmp do
      ComboBox1.Items.add(s);

    if val <> '' then
      ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(val);
  finally
    FreeAndNil(lstTmp);
  end;
end;

procedure TR003FFormato.BitBtn1Click(Sender: TObject);
var S,Msg:String;
begin
  ComboBox1.Text:=UpperCase(Trim(ComboBox1.Text));
  S:=ComboBox1.Text;
  if (S = '') or (not UsaDato) then
  begin
    ModalResult:=mrOk;
    exit;
  end;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    if IsDatoGiustificativi(Dato) then
    begin
      Msg:=VerificaFormatoGiust(S);
      if Msg <> '' then
        raise Exception.Create(msg);
      ComboBox1.Text:=s;
    end
    else if IsDatoTimbr(Dato) then
    begin
      Msg:=VerificaFormatoTimbr(S);
      if Msg <> '' then
        raise Exception.Create(msg);
    end
    else if IsDatoPresCaus(Dato) or
            IsDatoAssCaus(Dato) then
    begin
      VerificaFormatoCaus(S);
      ComboBox1.Text:=S;
    end;
    ModalResult:=mrOk;
  end;
end;

end.
