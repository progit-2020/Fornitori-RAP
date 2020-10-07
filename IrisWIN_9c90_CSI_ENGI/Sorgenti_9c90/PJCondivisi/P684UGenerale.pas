unit P684UGenerale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, StdCtrls, ExtCtrls, ActnList, ImgList, DB, Menus,
  ComCtrls, ToolWin, DBCtrls, Mask;

type
  TP684FGenerale = class(TR001FGestTab)
    Panel3: TPanel;
    lblAnno: TLabel;
    lblFondo: TLabel;
    lblCodTabella: TLabel;
    edtFondo: TEdit;
    edtDecorrenza: TEdit;
    Panel2: TPanel;
    lblCodVoce: TLabel;
    Label1: TLabel;
    dedtCodVoceGen: TDBEdit;
    dedtOrdineStampa: TDBEdit;
    Label2: TLabel;
    dcmbTipoVoce: TDBComboBox;
    lblTipoVoce: TLabel;
    dmemDescrizione: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TipoElab,FondoElab:String;
    DataElab:TDateTime;
  end;

var
  P684FGenerale: TP684FGenerale;

  procedure OpenP684Generale(Tipo,Fondo:String;Dec:TDateTime);


implementation

uses P684UDefinizioneFondiDtM;

{$R *.dfm}

procedure OpenP684Generale(Tipo,Fondo:String;Dec:TDateTime);
begin
  Application.CreateForm(TP684FGenerale,P684FGenerale);
  with P684FGenerale do
  try
    TipoElab:=Tipo;
    DataElab:=Dec;
    FondoElab:=Fondo;
    ShowModal;
  finally
    FreeAndNil(P684FGenerale);
  end;
end;

procedure TP684FGenerale.FormShow(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    DButton.DataSet:=selP686;
    edtDecorrenza.Text:=DateToStr(DataElab);
    edtFondo.Text:=FondoElab;
    lblFondo.Caption:=VarToStr(selP684.Lookup('DECORRENZA_DA;COD_FONDO',VarArrayOf([DataElab,FondoElab]),'DESCRIZIONE'));
    selP686Tipo.Close;
    if TipoElab = 'R' then
    begin
      P684FGenerale.Caption:='<P684> Risorse generali';
      P684FGenerale.lblTipoVoce.Caption:='Tipo risorsa';
      selP686Tipo.SetVariable('CLASS','R');
      P684FGenerale.HelpContext:=3684100;
    end
    else
    begin
      P684FGenerale.Caption:='<P684> Destinazioni generali';
      P684FGenerale.lblTipoVoce.Caption:='Tipo destinazione';
      selP686Tipo.SetVariable('CLASS','D');
      P684FGenerale.HelpContext:=3684300;
    end;
    selP686Tipo.Open;
    dcmbTipoVoce.Items.Clear;
    while not selP686Tipo.Eof do
    begin
      dcmbTipoVoce.Items.Add(selP686Tipo.FieldByName('TIPO_VOCE').AsString);
      selP686Tipo.Next;
    end;
  end;
end;

procedure TP684FGenerale.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodVoceGen.SetFocus;
end;

procedure TP684FGenerale.TRegisClick(Sender: TObject);
begin
  inherited;
  with P684FDefinizioneFondiDtM do
  begin
    selP686Tipo.Refresh;
    selP686Tipo.First;
    dcmbTipoVoce.Items.Clear;
    while not selP686Tipo.Eof do
    begin
      dcmbTipoVoce.Items.Add(selP686Tipo.FieldByName('TIPO_VOCE').AsString);
      selP686Tipo.Next;
    end;
  end;
end;

end.
