unit A074UGemeaz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Variants, DBCtrls;

type
  TA074FGemeaz = class(TForm)
    Label1: TLabel;
    edtCodCliente: TEdit;
    Label2: TLabel;
    edtValoreBuono: TEdit;
    rgpTipoFile: TRadioGroup;
    BitBtn1: TBitBtn;
    lblFormatoMatricola: TLabel;
    cmbFormatoMatricola: TComboBox;
    GroupBox1: TGroupBox;
    chkTicket: TCheckBox;
    chkBuoniPasto: TCheckBox;
    Label4: TLabel;
    EdtNomeFile: TEdit;
    Label3: TLabel;
    edtSiglaTestata: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A074FGemeaz: TA074FGemeaz;

implementation

uses A074URiepilogoBuoniDtM1;

{$R *.DFM}

end.
