unit A026UDatiLiberi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, Buttons, DBCtrls, Mask, DB, Menus, ExtCtrls,
  ComCtrls, Grids, CheckLst, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia,A003UDataLavoroBis, Variants,
  System.Actions, System.ImageList;

type
  TA026FDatiLIberi = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBEdit4: TDBEdit;
    drgpFORMATO: TDBRadioGroup;
    dchkStorico: TDBCheckBox;
    lblDecorrenza: TLabel;
    edtDecorrenza: TMaskEdit;
    sbtDecorrenza: TSpeedButton;
    lblLungDesc: TLabel;
    dedtLungDesc: TDBEdit;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    cbxNOMEPAGINA: TComboBox;
    BitBtn2: TBitBtn;
    dchkScadenza: TDBCheckBox;
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure drgpFORMATOClick(Sender: TObject);
    procedure sbtDecorrenzaClick(Sender: TObject);
    procedure dchkStoricoClick(Sender: TObject);
    procedure ImpostaFormSuTabellare;
  private
    procedure ListaPagine;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A026FDatiLiberi: TA026FDatiLIberi;

function OpenA026DatiLiberi:Boolean;
  
implementation

uses A026UDatiLIberiDtM1;

{$R *.DFM}

function OpenA026DatiLiberi:Boolean;
begin
  SolaLettura:=False;
  Result:=False;
  case A000GetInibizioni('Funzione','OpenA026DatiLiberi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A026FDatiLiberi:=TA026FDatiLiberi.Create(nil);
  with A026FDatiLiberi do
  try
    A026FDatiLiberiDtM1:=TA026FDatiLiberiDtM1.Create(nil);
    DButton.DataSet:=A026FDatiLiberiDtM1.I500;
    ShowModal;
  finally
    Result:=A026FDatiLiberiDtM1.Ricostruzione;
    A026FDatiLiberiDtM1.Free;
    Release;
  end;
end;

procedure TA026FDatiLIberi.DBEdit4KeyPress(Sender: TObject; var Key: Char);
{Inibisco l'immissione di numeri decimali}
begin
  if (Key = ',') or (Key = '.') then
    Key:=#0;
end;

procedure TA026FDatiLIberi.DBCheckBox1Click(Sender: TObject);
{Abilito/disabilito i dati di Link a seconda se uso un dato tabellare o meno}
begin
  ImpostaFormSuTabellare;
end;

procedure TA026FDatiLIberi.DButtonDataChange(Sender: TObject;
  Field: TField);
{Seleziono gli items di List Box1 in base ai campi di link scelti}
begin
  // Imposto il NomePagina per il dato libero leggendolo dalla configurazione
  // di DEFAULT
  if DButton.State = dsBrowse then
    cbxNOMEPAGINA.text:=A026FDatiLiberiDtM1.A026FDatiLiberiMW.GetNomePagina;
  //Rieleggo i campi disponibili nella list Box
  if Field = nil then
    with A026FDatiLiberiDtM1 do
      begin
      Q500.Close;
      if I500NomeCampo.IsNull then
        Q500.SetVariable('NomeCampo',' ')
      else
        Q500.SetVariable('NomeCampo',I500NomeCampo.AsString);
      Q500.Open;
      end;
  //Abilito e disabilito dato tabellare
  DBCheckBox1.Enabled:=A026FDatiLiberiDtM1.I500Formato.AsString = 'S';

  ImpostaFormSuTabellare;
end;

procedure TA026FDatiLIberi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  cbxNOMEPAGINA.Enabled:=(DButton.State <> dsBrowse);
  with A026FDatiLIberiDtM1 do
    begin
    DBCheckBox1.OnClick:=nil;
    DBEdit1.ReadOnly:=DButton.State = dsEdit;
    drgpFORMATO.ReadOnly:=DButton.State = dsEdit;
    I500Progressivo.ReadOnly:=DButton.State = dsEdit;
    DBCheckBox1.OnClick:=DBCheckBox1Click;
    end;
end;

procedure TA026FDatiLIberi.ImpostaFormSuTabellare;
begin
  if DButton.State in [dsInsert,dsEdit] then
  begin
    lblLungDesc.Enabled:=DbCheckBox1.Checked;
    dedtLungDesc.Enabled:=DbCheckBox1.Checked;

    // abilitazione storico
    dchkStorico.Enabled:=DbCheckBox1.Checked;
    if not DbCheckBox1.Checked then
      dchkStorico.Checked:=False;

    // abilitazione scadenza
    dchkScadenza.Enabled:=dchkStorico.Checked;
    if not dchkStorico.Checked then
      dchkScadenza.Checked:=False;
  end;
end;

procedure TA026FDatiLIberi.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A026FDatiLiberiDtM1.I500;
  inherited;
  ListaPagine;
end;

procedure TA026FDatiLIberi.ListaPagine;
begin
  with A026FDatiLiberiDtm1 do
  begin
    selT033.Open;
    cbxNOMEPAGINA.Items.Clear;
    while not selT033.Eof do
    begin
      cbxNOMEPAGINA.Items.Add(selT033.FieldByName('NOMEPAGINA').AsString);
      selT033.Next;
    end;
    selT033.Close;
  end;
end;

procedure TA026FDatiLIberi.TRegisClick(Sender: TObject);
begin
  inherited;
  ListaPagine;
end;

procedure TA026FDatiLIberi.drgpFORMATOClick(Sender: TObject);
begin
  if not (drgpFORMATO.Values[drgpFORMATO.ItemIndex] = 'S') then
  begin
    if A026FDatiLiberi.DButton.State in [dsInsert,dsEdit] then
      A026FDatiLiberiDtM1.I500Tabella.AsString:='N';
    DBCheckBox1.Enabled:=False;
  end
  else
    DBCheckBox1.Enabled:=True;
end;

procedure TA026FDatiLIberi.sbtDecorrenzaClick(Sender: TObject);
begin
  edtDecorrenza.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDecorrenza.Text),'Data decorrenza','G'));
end;

procedure TA026FDatiLIberi.dchkStoricoClick(Sender: TObject);
begin
  if (DButton.State = dsEdit) and
     (dchkStorico.Checked) and
     (A026FDatiLiberiDtM1.I500Storico.medpOldValue = 'N') then
  begin
    lblDecorrenza.Visible:=True;
    edtDecorrenza.Visible:=True;
    sbtDecorrenza.Visible:=True;
    edtDecorrenza.Text:='01/01/1900';
  end
  else
  begin
    lblDecorrenza.Visible:=False;
    edtDecorrenza.Visible:=False;
    sbtDecorrenza.Visible:=False;
  end;

  if DButton.State in [dsInsert,dsEdit] then
  begin
    // abilitazione scadenza
    dchkScadenza.Enabled:=dchkStorico.Checked;
    if not dchkStorico.Checked then
      dchkScadenza.Checked:=False;
  end;
end;

end.
