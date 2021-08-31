unit P554UImpostazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TP554FImpostazioni = class(TForm)
    Panel1: TPanel;
    btnOK: TBitBtn;
    BitBtn2: TBitBtn;
    edtNomeFile: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtAzienda: TEdit;
    rdgComparto: TRadioGroup;
    rdgTipoOperazione: TRadioGroup;
    edtIstituto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtDSM: TEdit;
    btnNomeFile: TBitBtn;
    SaveDialog1: TSaveDialog;
    edtRegione: TEdit;
    procedure btnNomeFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P554FImpostazioni: TP554FImpostazioni;
  procedure OpenP554Impostazioni;

implementation

uses P554UElaborazioneContoAnnuale;

{$R *.dfm}

procedure OpenP554Impostazioni;
begin
  Application.CreateForm(TP554FImpostazioni,P554FImpostazioni);
  try
    P554FImpostazioni.ShowModal;
  finally
    P554FImpostazioni.Free;
  end;
end;

procedure TP554FImpostazioni.btnOKClick(Sender: TObject);
begin
  with P554FElaborazioneContoAnnuale do
  begin
    NomeFile:=edtNomeFile.Text;
    Azienda:=edtAzienda.Text;
    if rdgComparto.ItemIndex = 0 then
      Comparto:='01'
    else
      Comparto:='04';
    DSM:=edtDSM.Text;
    Istituto:=edtIstituto.Text;
    Regione:=edtRegione.Text;
    if rdgTipoOperazione.ItemIndex = 0 then
      TipoOper:='0'
    else if rdgTipoOperazione.ItemIndex = 1 then
      TipoOper:='1'
    else
      TipoOper:='9';
  end;
end;

procedure TP554FImpostazioni.FormShow(Sender: TObject);
begin
  with P554FElaborazioneContoAnnuale do
  begin
    edtNomeFile.Text:=NomeFile;
    edtAzienda.Text:=Azienda;
    if Comparto = '01' then
      rdgComparto.ItemIndex:=0
    else
      rdgComparto.ItemIndex:=1;
    edtDSM.Text:=DSM;
    edtIstituto.Text:=Istituto;
    edtRegione.Text:=Regione;
    if TipoOper = '0' then
      rdgTipoOperazione.ItemIndex:=0
    else if TipoOper = '1' then
      rdgTipoOperazione.ItemIndex:=1
    else
      rdgTipoOperazione.ItemIndex:=2;
  end;
end;

procedure TP554FImpostazioni.btnNomeFileClick(Sender: TObject);
begin
  SaveDialog1.Title:='Scelta nome file';
  SaveDialog1.FileName:='CONTOANNUALE.TXT';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if SaveDialog1.Execute then
    edtNomeFile.Text:=SaveDialog1.FileName;
end;

end.
