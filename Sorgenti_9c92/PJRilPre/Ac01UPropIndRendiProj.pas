unit Ac01UPropIndRendiProj;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, OracleData;

type
  TAc01FPropIndRendiProj = class(TForm)
    dlblDipendente: TDBText;
    lblDipendente: TLabel;
    lblProgetto: TLabel;
    lblServizio: TLabel;
    lblFunzione: TLabel;
    dlblProgetto: TDBText;
    dedtServizio: TDBEdit;
    dedtFunzione: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ac01FPropIndRendiProj: TAc01FPropIndRendiProj;

implementation

{$R *.dfm}

uses Ac01UProgettiRendiProjDtM;

procedure TAc01FPropIndRendiProj.FormCreate(Sender: TObject);
begin
  dlblProgetto.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT754;
  dlblDipendente.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT754;
  dedtServizio.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT754;
  dedtFunzione.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT754;
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if not selT754.SearchRecord('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
    begin
      selT754.Append;
      selT754.FieldByName('ID_T750').AsInteger:=selT750.FieldByName('ID').AsInteger;
      selT754.FieldByName('PROGRESSIVO').AsInteger:=selT753.FieldByName('PROGRESSIVO').AsInteger;
    end
    else
      selT754.Edit;
end;

procedure TAc01FPropIndRendiProj.BitBtn1Click(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.selT754.Post;
end;

procedure TAc01FPropIndRendiProj.BitBtn2Click(Sender: TObject);
begin
  Ac01FProgettiRendiProjDtM.Ac01MW.selT754.Cancel;
end;

end.
