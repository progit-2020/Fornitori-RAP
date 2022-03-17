unit A160URegoleIncentivi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, C013UCheckList, System.Actions;

type
  TA160FRegoleIncentivi = class(TR004FGestStorico)
    Panel1: TPanel;
    lblLivelli: TLabel;
    lblAbbattimento: TLabel;
    dedtLivelli: TDBEdit;
    btnLivelli: TButton;
    drdgTipoCalcolo: TDBRadioGroup;
    dedtAbbMax: TDBEdit;
    drgpPropInc: TDBRadioGroup;
    lblCodice: TLabel;
    dCmbCodice: TDBLookupComboBox;
    lblInterfaccia: TLabel;
    dchkPartTime: TDBCheckBox;
    drdgQuoteQuant: TDBRadioGroup;
    dedtFileIstruzioni: TDBEdit;
    lblFileIstruzioni: TLabel;
    dchkScaglioniGgEff: TDBCheckBox;
    procedure btnLivelliClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure drdgTipoCalcoloChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dCmbCodiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure drdgQuoteQuantChange(Sender: TObject);
    procedure drgpPropIncChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A160FRegoleIncentivi: TA160FRegoleIncentivi;

procedure OpenA160RegoleIncentivi;

implementation

uses A160URegoleIncentiviDtM;

{$R *.dfm}

procedure OpenA160RegoleIncentivi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA160RegoleIncentivi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A160FRegoleIncentivi:=TA160FRegoleIncentivi.Create(nil);
  A160FRegoleIncentiviDtM:=TA160FRegoleIncentiviDtM.Create(nil);
  with A160FRegoleIncentivi do
  try
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A160FRegoleIncentiviDtM.Free;
    Free;
  end;
end;

procedure TA160FRegoleIncentivi.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A160FRegoleIncentiviDtM.selT760;
  A160FRegoleIncentiviDtM.selT760.Open;
  actVisioneCorrente.Execute;
  lblCodice.Caption:='Codice ' + Parametri.CampiRiferimento.C7_Dato1;
  lblAbbattimento.Caption:='Penalizzazione max (' + A160FRegoleIncentiviDtM.A160FRegoleIncentiviMW.selP030.FieldByName('ABBREVIAZIONE').AsString + ')';
end;

procedure TA160FRegoleIncentivi.drdgQuoteQuantChange(Sender: TObject);
begin
  inherited;
  lblFileIstruzioni.Visible:=drdgQuoteQuant.ItemIndex = 1;
  dedtFileIstruzioni.Visible:=drdgQuoteQuant.ItemIndex = 1;
end;

procedure TA160FRegoleIncentivi.drdgTipoCalcoloChange(Sender: TObject);
begin
  inherited;
  lblLivelli.Visible:=(drdgTipoCalcolo.ItemIndex = 1);
  dedtLivelli.Visible:=(drdgTipoCalcolo.ItemIndex = 1);
  btnLivelli.Visible:=(drdgTipoCalcolo.ItemIndex = 1);
  lblAbbattimento.Visible:=(drdgTipoCalcolo.ItemIndex = 0);
  dedtAbbMax.Visible:=(drdgTipoCalcolo.ItemIndex = 0);
  drdgQuoteQuant.Visible:=(drdgTipoCalcolo.ItemIndex = 0);
end;

procedure TA160FRegoleIncentivi.drgpPropIncChange(Sender: TObject);
begin
  inherited;
  dchkScaglioniGgEff.Visible:=drgpPropInc.ItemIndex = 1;
end;

procedure TA160FRegoleIncentivi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnLivelli.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA160FRegoleIncentivi.btnLivelliClick(Sender: TObject);
begin
  inherited;
  if Trim(Parametri.CampiRiferimento.C7_Dato3) = '' then
    raise exception.Create('Specificare il valore corrispondente a <INCENTIVI: DATO 3> nella Gestione aziende!');

  with A160FRegoleIncentiviDtM do
  begin
    A160FRegoleIncentiviMW.QLiv.SQL.Clear;
    if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato3,A160FRegoleIncentiviMW.QLiv) then
    begin
      if A160FRegoleIncentiviMW.QLiv.VariableIndex('DECORRENZA') >= 0 then
        A160FRegoleIncentiviMW.QLiv.Setvariable('DECORRENZA',EncodeDate(3999,12,31));
      A160FRegoleIncentiviMW.QLiv.Open;

      C013FCheckList:=TC013FCheckList.Create(nil);
      C013FCheckList.Caption:='<C013> Elenco ' + UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato3,1,1)) +
                                                 LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato3,2,length(Parametri.CampiRiferimento.C7_Dato3)));
      try
        with A160FRegoleIncentiviMW.QLiv do
        begin
          while not Eof do
          begin
            if Trim(FieldByName('CODICE').AsString) <> '' then
              C013FCheckList.clbListaDati.Items.Add(FieldByName('CODICE').AsString);
            Next;
          end;
          Close;
        end;
        R180PutCheckList(dedtLivelli.Text,256,C013FCheckList.clbListaDati);
        C013FCheckList.ShowModal;
        dedtLivelli.Field.AsString:=R180GetCheckList(256,C013FCheckList.clbListaDati);
      finally
        C013FCheckList.Release;
      end;
    end;
  end;
end;

procedure TA160FRegoleIncentivi.dCmbCodiceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

end.
