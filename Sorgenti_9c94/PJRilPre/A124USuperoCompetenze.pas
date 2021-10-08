unit A124USuperoCompetenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, C180FunzioniGenerali, A000UMessaggi;

type
  TA124FSuperoCompetenze = class(TForm)
    GroupBox1: TGroupBox;
    edtOre: TMaskEdit;
    lblOre: TLabel;
    edtDalle: TMaskEdit;
    edtAlle: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    btnConferma: TBitBtn;
    btnAnnullaDip: TBitBtn;
    btnAnnullaOp: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    lblNominativo: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    lblResiduo: TLabel;
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaDipClick(Sender: TObject);
    procedure btnAnnullaOpClick(Sender: TObject);
    procedure edtDalleChange(Sender: TObject);
    procedure edtDalleExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A124FSuperoCompetenze: TA124FSuperoCompetenze;

  procedure OpenA124SuperoCompetenze(Nominativo,Residuo:String);

implementation

uses A124UPermessiSindacali;

{$R *.dfm}
procedure OpenA124SuperoCompetenze(Nominativo,Residuo:String);
begin
  A124FSuperoCompetenze:=TA124FSuperoCompetenze.Create(nil);
  try
    A124FSuperoCompetenze.lblNominativo.Caption:=Nominativo;
    A124FSuperoCompetenze.lblResiduo.Caption:=Residuo;
    A124FSuperoCompetenze.ShowModal;
  finally
    FreeAndNil(A124FSuperoCompetenze);
  end;
end;

procedure TA124FSuperoCompetenze.btnConfermaClick(Sender: TObject);
begin
  if Trim(edtOre.Text) = '.' then
    raise exception.Create(A000MSG_A124_ERR_NO_ORE);
  A124FPermessiSindacali.SuperoCompetOre:=edtOre.Text;
  A124FPermessiSindacali.SuperoCompetDalle:=edtDalle.Text;
  A124FPermessiSindacali.SuperoCompetAlle:=edtAlle.Text;
  Close;
end;

procedure TA124FSuperoCompetenze.btnAnnullaDipClick(Sender: TObject);
begin
  A124FPermessiSindacali.SuperoCompetOre:='AnnullaDip';
  Close;
end;

procedure TA124FSuperoCompetenze.btnAnnullaOpClick(Sender: TObject);
begin
  A124FPermessiSindacali.SuperoCompetOre:='AnnullaOp';
  Close;
end;

procedure TA124FSuperoCompetenze.edtDalleChange(Sender: TObject);
begin
  edtOre.Enabled:=(Trim(edtDalle.Text) = '.') and (Trim(edtAlle.Text) = '.');
  lblOre.Enabled:=edtOre.Enabled;
end;

procedure TA124FSuperoCompetenze.edtDalleExit(Sender: TObject);
var n:Integer;
begin
  if Trim(TMaskEdit(Sender).Text) <> '.' then
    R180OraValidate(TMaskEdit(Sender).Text);
  if (Trim(edtDalle.Text) <> '.') and
     (Trim(edtAlle.Text) <> '.') then
  begin
    n:=R180OreMinutiExt(edtAlle.Text) - R180OreMinutiExt(edtDalle.Text);
    if n < 0 then
      raise exception.Create(A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE)
    else
      edtOre.Text:=R180MinutiOre(n);
  end;
end;

end.
