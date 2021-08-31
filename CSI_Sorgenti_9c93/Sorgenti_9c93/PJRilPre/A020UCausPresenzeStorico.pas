unit A020UCausPresenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStorico, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, A000UMessaggi,
  C180FunzioniGenerali, A020UCausPresenzeDtM1, System.ImageList;

type
  TA020FCausPresStorico = class(TR004FGestStorico)
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    dedtDescCausale: TDBEdit;
    lblDescCausale: TLabel;
    dedtDescrizione: TDBEdit;
    lblDescrizione: TLabel;
    lblCausCompDebitoGG: TLabel;
    dcmbCausCompDebitoGG: TDBLookupComboBox;
    lblCausTimb: TLabel;
    lblInclEsclOreNorm: TLabel;
    edtCausTimb: TEdit;
    edtInclEsclOreNorm: TEdit;
    dchkRendicontaProgetti: TDBCheckBox;
    procedure TCancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    // Periodo attuale, viene prevalorizzato prima dello show
    // e utilizzato prima del destroy per sincronizzare con il form chiamante
    A020StoricoDataLavoro:TDateTime;
  end;

var
  A020FCausPresStorico: TA020FCausPresStorico;

implementation

uses A020UCausPresenze;

{$R *.dfm}

procedure TA020FCausPresStorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A020StoricoDataLavoro:=DButton.DataSet.FieldByName('DECORRENZA').AsDateTime;
  inherited;
end;

procedure TA020FCausPresStorico.FormCreate(Sender: TObject);
begin
  inherited;
  dcmbCausCompDebitoGG.ListSource:=A020FCausPresenzeDtM1.A020MW.dsrT275lkpOreNorm;
  // Le descrizioni di questi campi sono definite nella form principale.
  // A questo punto il dataset è posizionato sul record di nostro interesse.
  edtCausTimb.Text:=A020FCausPresenze.DBRadioGroup1.Items[A020FCausPresenze.DBRadioGroup1.ItemIndex];
  edtInclEsclOreNorm.Text:=A020FCausPresenze.EOreNormali.Items[A020FCausPresenze.EOreNormali.ItemIndex];
  lblCausCompDebitoGG.Enabled:=(A020FCausPresenze.EOreNormali.Value = 'A');
  dcmbCausCompDebitoGG.Enabled:=(A020FCausPresenze.EOreNormali.Value = 'A');
end;

procedure TA020FCausPresStorico.FormShow(Sender: TObject);
var
  DataLavoroInizialeStr:String;
begin
  inherited;
  DataLavoroInizialeStr:=DateToStr(A020StoricoDataLavoro);
  cmbDateDecorrenza.ItemIndex:=cmbDateDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
  cmbDateDecorrenzaChange(nil);
end;

procedure TA020FCausPresStorico.TCancClick(Sender: TObject);
begin
  if DButton.DataSet.RecordCount < 2 then
  begin
    R180MessageBox(A000MSG_A020_MSG_NO_ELIMINA_STOR,ESCLAMA,Self.Caption);
    Exit;
  end;
  inherited;
end;

end.
