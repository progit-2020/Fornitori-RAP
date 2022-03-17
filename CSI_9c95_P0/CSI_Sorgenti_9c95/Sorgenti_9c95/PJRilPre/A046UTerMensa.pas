unit A046UTerMensa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, Db, Menus, Buttons, ExtCtrls, ComCtrls,
  R001UGESTTAB,C180FunzioniGenerali,Mask, DBCtrls, ActnList, ImgList,
  ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants, C013UCheckList;

type
  TA046FTerMensa = class(TR001FGestTab)
    Panel3: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblCodice: TLabel;
    lblInterfaccia: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    dedtCenaDalle: TDBEdit;
    dedtCenaAlle: TDBEdit;
    dchkAlimentabp: TDBCheckBox;
    dcmbCodice: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    lblOreMinime: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    lblOrarioSpezzato: TLabel;
    Label17: TLabel;
    Label7: TLabel;
    lblOrarioNoPausaMensa: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    dchkMensaSuccessivaAnom: TDBCheckBox;
    dchkMensaAntecedenteAnom: TDBCheckBox;
    dchkMensaNonPresentiAnom: TDBCheckBox;
    dchkOrarioNoPausaMensaAnom: TDBCheckBox;
    dchkOreReseInferioriAnom: TDBCheckBox;
    dEdtIntervalloAnom: TDBEdit;
    dchkOrarioSpezzatoAnom: TDBCheckBox;
    dchkTimbrNonCausalizzataAnom: TDBCheckBox;
    dchkMensaStimbrataAnom: TDBCheckBox;
    dchkMensaNonStimbrataAnom: TDBCheckBox;
    dEdtOreMinimeAnom: TDBEdit;
    dChkIntervalloIntero: TDBCheckBox;
    dChkOreMinimeIntero: TDBCheckBox;
    dchkMensaNonStimbrataIntero: TDBCheckBox;
    dchkMensaAntecedenteIntero: TDBCheckBox;
    dchkMensaSuccessivaIntero: TDBCheckBox;
    dchkMensaNonPresentiIntero: TDBCheckBox;
    dchkOrarioSpezzatoIntero: TDBCheckBox;
    dchkOrarioNoPausaMensaIntero: TDBCheckBox;
    dchkOreReseInferioriIntero: TDBCheckBox;
    dchkMensaStimbrataIntero: TDBCheckBox;
    dchkMaturaBuonoAnom: TDBCheckBox;
    dchkMaturaBuonoIntero: TDBCheckBox;
    Label25: TLabel;
    dEdtIntMensaDa: TDBEdit;
    Label33: TLabel;
    dChkIntMensaIntero: TDBCheckBox;
    dEdtIntMensaA: TDBEdit;
    Label34: TLabel;
    procedure dcmbCodiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dchkMensaStimbrataAnomClick(Sender: TObject);
  private
    { Private declarations }
    C013FCheckList1: TC013FCheckList;
    C013FCheckList2: TC013FCheckList;
  public
    { Public declarations }
  end;

var
  A046FTerMensa: TA046FTerMensa;

procedure OpenA046TerMensa;

implementation

uses A046UTerMensaDTM1;
{$R *.DFM}

procedure OpenA046TerMensa;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA046TerMensa') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A046FTerMensa:=TA046FTerMensa.Create(nil);
  with A046FTerMensa do
    try
      A046FTerMensaDtM1:=TA046FTerMensaDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A046FTerMensaDtM1.Free;
      Free;
    end;
end;

procedure TA046FTerMensa.FormShow(Sender: TObject);
begin
  if Parametri.CampiRiferimento.C18_AccessiMensa <> '' then
    lblCodice.Caption:=Parametri.CampiRiferimento.C18_AccessiMensa
  else
    lblCodice.Caption:='Codice';
  DButton.DataSet:=A046FTerMensaDTM1.Q360TerMensa;
  DButton.DataSet.Open;
  dchkMensaStimbrataAnomClick(dchkMensaStimbrataAnom);
  dchkMensaStimbrataAnomClick(dchkMensaNonStimbrataAnom);
  dchkMensaStimbrataAnomClick(dchkMensaAntecedenteAnom);
  dchkMensaStimbrataAnomClick(dchkMensaSuccessivaAnom);
  dchkMensaStimbrataAnomClick(dchkMensaNonPresentiAnom);
  dchkMensaStimbrataAnomClick(dchkTimbrNonCausalizzataAnom);
  dchkMensaStimbrataAnomClick(dchkOrarioSpezzatoAnom);
  dchkMensaStimbrataAnomClick(dchkOrarioNoPausaMensaAnom);
  dchkMensaStimbrataAnomClick(dchkOreReseInferioriAnom);
  dchkMensaStimbrataAnomClick(dEdtIntervalloAnom);
  dchkMensaStimbrataAnomClick(dEdtOreMinimeAnom);
  NumRecords;
end;

procedure TA046FTerMensa.dchkMensaStimbrataAnomClick(Sender: TObject);
begin
  inherited;
  if A046FTerMensaDTM1 <> nil then
  begin
    if A046FTerMensaDTM1.Q360TerMensa.Active then
    begin
      if sender = dchkMensaStimbrataAnom then
      begin
        dchkMensaNonStimbrataAnom.Enabled:=not dchkMensaStimbrataAnom.Checked;
        if dchkMensaStimbrataAnom.Checked and (DButton.State in [dsInsert,dsEdit]) then
          dchkMensaNonStimbrataAnom.Field.AsString:='N';

        dchkMensaStimbrataIntero.Enabled:=dchkMensaStimbrataAnom.Checked;
        if (not dchkMensaStimbrataAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkMensaStimbrataIntero.Field.AsString:='N';
      end
      else if sender = dchkMensaNonStimbrataAnom then
      begin
        dchkMensaNonStimbrataIntero.Enabled:=dchkMensaNonStimbrataAnom.Checked;
        if (not dchkMensaNonStimbrataAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
           dchkMensaNonStimbrataIntero.Field.AsString:='N';
      end
      else if sender = dchkMensaAntecedenteAnom then
      begin
        dchkMensaAntecedenteIntero.Enabled:=dchkMensaAntecedenteAnom.Checked;
        if (not dchkMensaAntecedenteAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkMensaAntecedenteIntero.Field.AsString:='N';
      end
      else if sender = dchkMensaSuccessivaAnom then
      begin
        dchkMensaSuccessivaIntero.Enabled:=dchkMensaSuccessivaAnom.Checked;
        if (not dchkMensaSuccessivaAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkMensaSuccessivaIntero.Field.AsString:='N';
      end
      else if sender = dchkMensaNonPresentiAnom then
      begin
        dchkMensaNonPresentiIntero.Enabled:=dchkMensaNonPresentiAnom.Checked;
        if (not dchkMensaNonPresentiAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkMensaNonPresentiIntero.Field.AsString:='N';
      end
      else if sender = dchkOrarioSpezzatoAnom then
      begin
        dchkOrarioSpezzatoIntero.Enabled:=dchkOrarioSpezzatoAnom.Checked;
        if (not dchkOrarioSpezzatoAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkOrarioSpezzatoIntero.Field.AsString:='N';
      end
      else if sender = dchkOrarioNoPausaMensaAnom then
      begin
        dchkOrarioNoPausaMensaIntero.Enabled:=dchkOrarioNoPausaMensaAnom.Checked;
        if (not dchkOrarioNoPausaMensaAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkOrarioNoPausaMensaIntero.Field.AsString:='N';
      end
      else if sender = dchkOreReseInferioriAnom then
      begin
        dchkOreReseInferioriIntero.Enabled:= dchkOreReseInferioriAnom.Checked;
        if (not dchkOreReseInferioriAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkOreReseInferioriIntero.Field.AsString:='N';
      end
      else if sender = dEdtIntervalloAnom then
      begin
        dchkIntervalloIntero.Enabled:=(dEdtIntervalloAnom.Text<>'00.00') and (trim(dEdtIntervalloAnom.text)<>'.');
        if ((dEdtIntervalloAnom.Text='00.00') or (trim(dEdtIntervalloAnom.text)='.')) and (DButton.State in [dsInsert,dsEdit]) then
          dchkIntervalloIntero.Field.AsString:='N';
      end
      else if sender = dEdtOreMinimeAnom then
      begin
        dchkOreMinimeIntero.Enabled:=(dEdtOreMinimeAnom.Text<>'00.00') and (trim(dEdtOreMinimeAnom.text)<>'.');
        if ((dEdtOreMinimeAnom.Text='00.00') or (trim(dEdtOreMinimeAnom.text)='.')) and (DButton.State in [dsInsert,dsEdit]) then
          dchkOreMinimeIntero.Field.AsString:='N';
      end
      else if sender = dchkMaturaBuonoAnom then
      begin
        dchkMaturaBuonoIntero.Enabled:=dchkMaturaBuonoAnom.Checked;
        if (not dchkMaturaBuonoAnom.Checked) and (DButton.State in [dsInsert,dsEdit]) then
          dchkMaturaBuonoIntero.Field.AsString:='N';
        //Alberto: l'attivazione delle regole buoni pasto disattiva le regole che sono già presenti sui buoni pasto 
        lblOrarioSpezzato.Enabled:=not dchkMaturaBuonoAnom.Checked;
        dchkOrarioSpezzatoAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
        lblOrarioNoPausaMensa.Enabled:=not dchkMaturaBuonoAnom.Checked;
        dchkOrarioNoPausaMensaAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
        lblOreMinime.Enabled:=not dchkMaturaBuonoAnom.Checked;
        dedtOreMinimeAnom.Enabled:=not dchkMaturaBuonoAnom.Checked;
        if dchkMaturaBuonoAnom.Checked and (DButton.State in [dsInsert,dsEdit]) then
        begin
          dchkOrarioSpezzatoAnom.Field.AsString:='N';
          dchkOrarioNoPausaMensaAnom.Field.AsString:='N';
          dedtOreMinimeAnom.Field.AsString:='00.00';
        end;
      end;
    end;
  end;
end;

procedure TA046FTerMensa.dcmbCodiceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA046FTerMensa.FormDestroy(Sender: TObject);
begin
  try
    C013FCheckList1.Free;
    C013FCheckList2.Free;
  except
  end;
end;

end.
