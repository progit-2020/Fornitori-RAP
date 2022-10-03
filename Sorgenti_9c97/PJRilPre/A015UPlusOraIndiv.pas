unit A015UPlusOraIndiv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, C700USelezioneAnagrafe, A000UCostanti, A000USessione,A000UInterfaccia, ActnList, ImgList, ToolWin,
  SelAnagrafe, C005UDatiAnagrafici, Variants, System.Actions;

type
  TA015FPlusOraIndiv = class(TR001FGestTab)
    Panel3: TPanel;
    Label1: TLabel;
    dedtAnno: TDBEdit;
    DBRadioGroup2: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    Panel4: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Label2: TLabel;
    dedtDescrizione: TDBEdit;
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A015FPlusOraIndiv: TA015FPlusOraIndiv;

procedure OpenA015PlusOraIndiv(Prog:LongInt);

implementation

uses A015UPlusOraIndivDtM1;

{$R *.DFM}

procedure OpenA015PlusOraIndiv(Prog:LongInt);
{Gestione Plus Orario individuale}
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA015PlusOraIndiv') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A015FPlusOraIndiv:=TA015FPlusOraIndiv.Create(nil);
  with A015FPlusOraIndiv do
  try
    C700Progressivo:=Prog;
    A015FPlusOraIndivDtM1:=TA015FPlusOraIndivDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A015FPlusOraIndivDtM1.Free;
    Free;
  end;
end;

procedure TA015FPlusOraIndiv.CambiaProgressivo;
begin
  with A015FPlusOraIndivDtM1 do
  begin
    T090.SetVariable('Progressivo',C700Progressivo);
    T090.Close;
    T090.Open;
    NumRecords;
  end;
end;

procedure TA015FPlusOraIndiv.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

procedure TA015FPlusOraIndiv.FormShow(Sender: TObject);
begin
  inherited;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
end;

procedure TA015FPlusOraIndiv.TfrmSelAnagrafe1btnSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA015FPlusOraIndiv.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA015FPlusOraIndiv.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

end.
