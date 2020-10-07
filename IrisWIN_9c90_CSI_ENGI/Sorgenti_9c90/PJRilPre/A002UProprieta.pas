unit A002UProprieta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, StdCtrls, Buttons, Mask, ExtCtrls, Variants;

type
  TA002FProprieta = class(TForm)
    lblCaption: TLabel;
    lblCoordY: TLabel;
    edtCoordX: TMaskEdit;
    Label3: TLabel;
    edtCoordY: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actRicerca: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actInserisci: TAction;
    actModifica: TAction;
    actCancella: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    actStampa: TAction;
    actStoricizza: TAction;
    actDataLavoro: TAction;
    actEsci: TAction;
    actStoricoPrecedente: TAction;
    actStoricoSuccessivo: TAction;
    actCarica: TAction;
    actSalva: TAction;
    actSposta: TAction;
    actCaption: TAction;
    actRipristina: TAction;
    actElimina: TAction;
    actPulisci: TAction;
    actPosizioni: TAction;
    actProprieta: TAction;
    edtCaption: TEdit;
    chkReadOnly: TCheckBox;
    lblNome: TLabel;
    edtNome: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FProprieta: TA002FProprieta;

implementation

{$R *.DFM}

procedure TA002FProprieta.FormShow(Sender: TObject);
begin
  chkReadOnly.Enabled:=edtNome.Text <> 'I060EMAIL';
end;

end.
