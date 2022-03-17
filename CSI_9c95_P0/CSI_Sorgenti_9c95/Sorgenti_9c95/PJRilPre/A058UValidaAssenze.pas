unit A058UValidaAssenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, A058UPianifTurni, A058UPianifTurniDtM1;

type
  TA058FValidaAssenze = class(TForm)
    PnlBottom: TPanel;
    PnlTop: TPanel;
    EdtDataDa: TMaskEdit;
    EdtDataA: TMaskEdit;
    BtnConferma: TSpeedButton;
    BtnAnnulla: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    ChkCaus1: TCheckBox;
    ChkCaus2: TCheckBox;
    lblNominativo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnAnnullaClick(Sender: TObject);
    procedure BtnConfermaClick(Sender: TObject);
    procedure ChkCaus1Click(Sender: TObject);
    procedure ChkCaus2Click(Sender: TObject);
  private
    { Private declarations }
    DataDa,DataA:TDateTime;
    Caus1,Caus2:String;
    IndVista:Integer;
    procedure ValidaAssenza(Caus:String);
  public
    { Public declarations }
  end;

var

  A058FValidaAssenze: TA058FValidaAssenze;

procedure OpenA058ValidaAssenze(Prog:Integer;DaData,AData:TDateTime;Caus1,Caus2:String);

implementation

{$R *.dfm}

procedure OpenA058ValidaAssenze(Prog:Integer;DaData,AData:TDateTime;Caus1,Caus2:String);
begin
  A058FValidaAssenze:=TA058FValidaAssenze.Create(nil);
  try
    A058FValidaAssenze.DataDa:=DaData;
    A058FValidaAssenze.DataA:=AData;
    A058FValidaAssenze.Caus1:=Caus1;
    A058FValidaAssenze.Caus2:=Caus2;
    A058FValidaAssenze.IndVista:=Prog;
    A058FValidaAssenze.ShowModal;
  finally
    FreeAndNil(A058FValidaAssenze);
  end;
end;

procedure TA058FValidaAssenze.BtnAnnullaClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA058FValidaAssenze.ValidaAssenza(Caus:String);
var DataScorr:TDateTime;
begin
  with A058FPianifTurniDtM1 do
  begin
    DataScorr:=DataDa;
    While DataScorr <= StrToDate(EdtDataA.Text) do
    begin
      UpdT040.SetVariable('PROG',TDipendente(A058FPianifTurniDtm1.Vista[IndVista]).Prog);
      UpdT040.SetVariable('DATA',DataScorr);
      UpdT040.SetVariable('CAUS',Caus);
      UpdT040.Execute;
      DataScorr:=DataScorr + 1;
    end;
    UpdT040.Session.Commit;
  end;
end;

procedure TA058FValidaAssenze.BtnConfermaClick(Sender: TObject);
begin
  try
    if StrToDate(EdtDataDa.Text) > StrToDate(EdtDataA.Text) then
      Abort;
  except
    Raise Exception.Create('Le date inserite non sono corrette.');
  end;

  if ChkCaus1.Checked then
    ValidaAssenza(ChkCaus1.Caption);
  if ChkCaus2.Checked then
    ValidaAssenza(ChkCaus2.Caption);
  Self.Close;
end;

procedure TA058FValidaAssenze.ChkCaus1Click(Sender: TObject);
begin
  ChkCaus2.Checked:=Not ChkCaus1.Checked;
end;

procedure TA058FValidaAssenze.ChkCaus2Click(Sender: TObject);
begin
  ChkCaus1.Checked:=Not ChkCaus2.Checked;
end;

procedure TA058FValidaAssenze.FormShow(Sender: TObject);
begin
  EdtDataDa.Text:=DateToStr(DataDa);
  EdtDataA.Text:=DateToStr(DataA);

  if Caus1 = '' then
    ChkCaus1.Hide
  else
    ChkCaus1.Checked:=True;
    
  ChkCaus1.Caption:=Caus1;
  if Caus2 = '' then
    ChkCaus2.Hide;
  ChkCaus2.Caption:=Caus2;
  with A058FPianifTurniDtm1 do
    lblNominativo.Caption:=TDipendente(Vista[IndVista]).Cognome + ' ' + TDipendente(Vista[IndVista]).Nome;
end;

end.
