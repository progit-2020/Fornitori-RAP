unit A023UValidaAssenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, CheckLst, Oracle, A000UInterfaccia,
  A000UMessaggi, OracleData;

type
  TA023FValidaAssenze = class(TForm)
    PnlBottom: TPanel;
    PnlTop: TPanel;
    EdtDataDa: TMaskEdit;
    EdtDataA: TMaskEdit;
    BtnConferma: TSpeedButton;
    BtnAnnulla: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    lblNominativo: TLabel;
    ChkLst: TCheckListBox;
    procedure FormShow(Sender: TObject);
    procedure BtnAnnullaClick(Sender: TObject);
    procedure BtnConfermaClick(Sender: TObject);
  private
    DataDa,DataA:TDateTime;
    Caus:String;
    Prog:Integer;
  public
    { Public declarations }
  end;

var A023FValidaAssenze: TA023FValidaAssenze;

procedure OpenA023ValidaAssenze(Prog:Integer;DaData,AData:TDateTime;Caus:String);

implementation

uses A023UTimbratureDtM1;

{$R *.dfm}

procedure OpenA023ValidaAssenze(Prog:Integer;DaData,AData:TDateTime;Caus:String);
begin
  A023FValidaAssenze:=TA023FValidaAssenze.Create(nil);
  try
    A023FValidaAssenze.DataDa:=DaData;
    A023FValidaAssenze.DataA:=AData;
    A023FValidaAssenze.Caus:=Caus;
    A023FValidaAssenze.Prog:=Prog;
    A023FValidaAssenze.ShowModal;
  finally
    FreeAndNil(A023FValidaAssenze);
  end;
end;

procedure TA023FValidaAssenze.BtnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA023FValidaAssenze.BtnConfermaClick(Sender: TObject);
var i:integer;
begin
  try
    if StrToDate(EdtDataDa.Text) > StrToDate(EdtDataA.Text) then
      Abort;
  except
    Raise Exception.Create(A000MSG_ERR_DATE_INSERITE);
  end;
  for i:=0 to ChkLst.Items.Count - 1 do
    if ChkLst.Checked[i] then
      A023FTimbratureDtM1.A023FTimbratureMW.ValidaAssenza(StrToDate(EdtDataDa.Text),StrToDate(EdtDataA.Text),Prog,ChkLst.Items[i]);
  Self.Close;
end;

procedure TA023FValidaAssenze.FormShow(Sender: TObject);
begin
  A023FTimbratureDtM1.A023FTimbratureMW.OpenSelT030(Prog);
  lblNominativo.Caption:=A023FTimbratureDtM1.A023FTimbratureMW.selT030.FieldByName('NOMINATIVO').AsString;

  EdtDataDa.Text:=DateToStr(DataDa);
  EdtDataA.Text:=DateToStr(DataA);
  ChkLst.Items.CommaText:=Caus;
  if ChkLst.Items.Count = 1 then
    ChkLst.Checked[0]:=True;
end;

end.
