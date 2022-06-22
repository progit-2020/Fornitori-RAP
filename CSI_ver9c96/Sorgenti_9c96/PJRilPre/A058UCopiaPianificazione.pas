unit A058UCopiaPianificazione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, DB, DBCtrls, C700USelezioneAnagrafe,
  DBClient, A058UPianifTurniDtM1;

type
  TA058FCopiaPianificazione = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDaData: TMaskEdit;
    Label4: TLabel;
    edtAData: TMaskEdit;
    btnOK: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    dsrC700: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    dsrAnagrafiche: TDataSource;
    cdsAnagrafiche: TClientDataSet;
    cdsAnagraficheProgressivo1: TIntegerField;
    cdsAnagraficheProgressivo2: TIntegerField;
    cdsAnagraficheNominativo1: TStringField;
    cdsAnagraficheNominativo2: TStringField;
    DBText1: TDBText;
    DBText2: TDBText;
    chkRendiDefinitive: TCheckBox;
    rdbSingoloDip: TRadioButton;
    rdbTuttiDip: TRadioButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsAnagraficheCalcFields(DataSet: TDataSet);
    procedure OnRadioBtnDipClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A058FCopiaPianificazione: TA058FCopiaPianificazione;

implementation

{$R *.dfm}

procedure TA058FCopiaPianificazione.btnOKClick(Sender: TObject);
begin
  try
    if StrToDate(edtDaData.Text) > StrToDate(edtAData.Text) then
      Abort;
  except
    raise Exception.Create('Il periodo indicato non è valido!');
  end;
  if chkRendiDefinitive.Checked then
  begin
    if A058FPianifTurniDtM1.PckTurno.SeEsisteDatoT620(cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,StrToDate(edtDaData.Text)) > 0 then
      raise Exception.Create(Format('E''già stata assegnata una turnazione in data %s!',[edtDaData.Text]));
    if A058FPianifTurniDtM1.PckTurno.SeEsisteDatoT620(cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,StrToDate(edtAData.Text)) > 0 then
      raise Exception.Create(Format('E''già stata assegnata una turnazione in data %s!',[edtAData.Text]));
  end;
  ModalResult:=mrOK;
end;

procedure TA058FCopiaPianificazione.cdsAnagraficheCalcFields(DataSet: TDataSet);
begin
  cdsAnagrafiche.FieldByName('Nominativo1').AsString:=
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo1').AsInteger,'COGNOME')) + ' ' +
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo1').AsInteger,'NOME'));
  cdsAnagrafiche.FieldByName('Nominativo2').AsString:=
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,'COGNOME')) + ' ' +
    VarToStr(C700SelAnagrafe.Lookup('PROGRESSIVO',cdsAnagrafiche.FieldByName('Progressivo2').AsInteger,'NOME'));
end;

procedure TA058FCopiaPianificazione.FormCreate(Sender: TObject);
begin
  cdsAnagrafiche.CreateDataSet;
  dsrC700.DataSet:=C700SelAnagrafe;
  OnRadioBtnDipClick(nil);
end;

procedure TA058FCopiaPianificazione.OnRadioBtnDipClick(Sender: TObject);
var
  SingoloDip:Boolean;
begin
  SingoloDip:=rdbSingoloDip.Checked;
  DBLookupComboBox2.Enabled:=SingoloDip;
  DBText2.Enabled:=SingoloDip;
  chkRendiDefinitive.Enabled:=SingoloDip;
  if not SingoloDip then
    chkRendiDefinitive.Checked:=False;
end;

end.
