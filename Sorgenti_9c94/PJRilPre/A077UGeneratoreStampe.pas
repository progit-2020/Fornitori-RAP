unit A077UGeneratoreStampe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R003UGENERATORESTAMPE, Menus, ActnList, ImgList, Db, SelAnagrafe,
  StdCtrls, ComCtrls, Mask, ExtCtrls, CheckLst, Buttons, DBCtrls, ToolWin,
  A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe, L021Call, Oracle, C180FunzioniGenerali, Variants,
  System.Actions, System.ImageList, InputPeriodo;

type
  TA077FGeneratoreStampe = class(TR003FGeneratoreStampe)
    chklstRimborsi: TCheckListBox;
    chklstPresenza: TCheckListBox;
    chklstAssenze: TCheckListBox;
    chklstIndPresenza: TCheckListBox;
    chklstVociPaghe: TCheckListBox;
    pnlSindacati: TPanel;
    lblRecapitoSindacato: TLabel;
    cmbRecapitoSindacato_11: TComboBox;
    cmbRecapitoSindacato_12: TComboBox;
    cmbRecapitoSindacato_13: TComboBox;
    chklstIscrizioniSindacali: TCheckListBox;
    chklstPartecipazioniSindacali: TCheckListBox;
    chklstPermessiSindacali: TCheckListBox;
    chklstCorsiFormazione: TCheckListBox;
    N6: TMenuItem;
    Visioneannuale1: TMenuItem;
    procedure Visioneannuale1Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure chkPeriodoStoricoClick(Sender: TObject);
    procedure cmbSerbatoiChange(Sender: TObject); override;
    procedure DButtonStateChange(Sender: TObject);
  private
    { Private declarations }
  protected
    function getControlOpzioneAvanzata(Val: String): TControl; override;
    procedure CreaTabelle; override;
    procedure SetCdcPerc; override;
    procedure SetInizioPeriodoC700; override;
    procedure SetFinePeriodoC700;override;
  public
    function getCheckListBoxTabellaCollegata(M: Integer): TListaCodici; override;
  end;

var
  A077FGeneratoreStampe: TA077FGeneratoreStampe;

procedure OpenA077GeneratoreStampe(Prog:Integer);

implementation

uses A077UStampa, A077UGeneratoreStampeDtM;

{$R *.DFM}

procedure OpenA077GeneratoreStampe(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA077GeneratoreStampe') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;

  A077FGeneratoreStampe:=TA077FGeneratoreStampe.Create(nil);
  with A077FGeneratoreStampe do
    try
      C700Progressivo:=Prog;
      A077FGeneratoreStampeDtM:=TA077FGeneratoreStampeDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A077FGeneratoreStampeDtM.Free;
      Free;
    end;
end;

function TA077FGeneratoreStampe.getCheckListBoxTabellaCollegata(M:Integer): TListaCodici;
begin
  case M of
    1:  //Ind.Presenza
      begin
        Result.chklst:=chklstIndPresenza;
        Result.Lunghezza:=5;
      end;
    2:  //Causali di presenza
      begin
        Result.chklst:=chklstPresenza;
        Result.Lunghezza:=5;
      end;
    3:  //Causali di assenza
      begin
        Result.chklst:=chklstAssenze;
        Result.Lunghezza:=5;
      end;
    7:  //Missioni:Rimborsi
      begin
        Result.chklst:=chklstRimborsi;
        Result.Lunghezza:=5;
      end;
    8:  //Voci paghe scaricate
      begin
        Result.chklst:=chklstVociPaghe;
        Result.Lunghezza:=6;
      end;
    10: //Corsi di formazione
      begin
        Result.chklst:=chklstCorsiFormazione;
        Result.Lunghezza:=20;
      end;
    11: //Iscrizioni ai sindacati (organizzazioni sindacali)
      begin
        Result.chklst:=chklstIscrizioniSindacali;
        Result.Lunghezza:=10;
      end;
    12: //Organismi sindacali
      begin
        Result.chklst:=chklstPartecipazioniSindacali;
        Result.Lunghezza:=10;
      end;
    13: //Permessi sindacali
      begin
        Result.chklst:=chklstPermessiSindacali;
        Result.Lunghezza:=10;
      end;
    else
      Result.chklst:=nil;
  end;
end;

procedure TA077FGeneratoreStampe.FormShow(Sender: TObject);
begin
  A077FStampa:=TA077FStampa.Create(nil);
  inherited;
end;

function TA077FGeneratoreStampe.getControlOpzioneAvanzata(Val: String): TControl;
begin
  Result:=nil;
  if val = 'REC_SINDACATO_11' then
    Result:=cmbRecapitoSindacato_11
  else if val = 'REC_SINDACATO_12' then
    Result:=cmbRecapitoSindacato_12
  else if val = 'REC_SINDACATO_13' then
    Result:=cmbRecapitoSindacato_13;
end;

procedure TA077FGeneratoreStampe.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  (*chklstAssenze.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstPresenza.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstIndPresenza.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstRimborsi.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstVociPaghe.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstIscrizioniSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstPartecipazioniSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstPermessiSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);
  chklstCorsiFormazione.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe) or (SolaLettura);*)
end;

procedure TA077FGeneratoreStampe.DButtonStateChange(Sender: TObject);
begin
  inherited;
  chklstAssenze.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstPresenza.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstIndPresenza.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstRimborsi.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstVociPaghe.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstIscrizioniSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstPartecipazioniSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstPermessiSindacali.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
  chklstCorsiFormazione.Enabled:=(DButton.State in [dsEdit,dsInsert]) or (not GeneratoreDiStampe)(* or (SolaLettura)*);
end;

procedure TA077FGeneratoreStampe.chkPeriodoStoricoClick(Sender: TObject);
begin
  if dchkPeriodoStorico.Checked and (not (cmbSerbatoi.ItemIndex in [0,4])) then
  begin
    cmbSerbatoi.ItemIndex:=0;
    cmbSerbatoiChange(nil);
  end
  else if (not dchkPeriodoStorico.Checked) and (cmbSerbatoi.ItemIndex = 4) then
  begin
    cmbSerbatoi.ItemIndex:=0;
    cmbSerbatoiChange(nil);
  end;
end;

procedure TA077FGeneratoreStampe.SetCdcPerc;
begin
  exit; //Serve per il P077
end;

procedure TA077FGeneratoreStampe.SetInizioPeriodoC700;
begin
  exit; //Serve per il P077
end;

procedure TA077FGeneratoreStampe.SetFinePeriodoC700;
begin
  exit; //Serve per il P077
end;

procedure TA077FGeneratoreStampe.CreaTabelle;
{Per creare il codice che gestisce le colonne usate dalla vista del serbatoio, usare la seguente query:
SELECT
'if D = '''||COLUMN_NAME ||
''' then AddDatoTabCollegata(Ins920x,CreateTable,InsertList,InsertVal,D,'''||
data_type||
decode(data_type,'VARCHAR2','('||data_length||')',null)
||''','||decode(data_type,'DATE','otDate','VARCHAR2','otString','NUMBER',decode(data_scale,null,'otInteger',0,'otInteger','otStrin'))||
') else'
 FROM COLS WHERE TABLE_NAME = 'nomevista'
}
var i:Integer;
begin
  with A077FGeneratoreStampeDtM do
  begin
    DropT920(0);
    for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
      DropT920(R003FGeneratoreStampeMW.TabelleCollegate[i].M);
    if Molteplice(1) >= 0 then
      CreateT920_1;
    if Molteplice(2) >= 0 then
      CreateT920_2;
    if Molteplice(3) >= 0 then
      CreateT920_Assenze(A077FGeneratoreStampeMW.Ins920_3);
    if Molteplice(4) >= 0 then
      CreateT920_4;
    if Molteplice(5) >= 0 then
      CreateT920_5;
    if Molteplice(6) >= 0 then
      CreateT920_6;
    if Molteplice(7) >= 0 then
      CreateT920_7;
    if Molteplice(8) >= 0 then
      CreateT920_8;
    if Molteplice(9) >= 0 then
      CreateT920_9;
    if Molteplice(10) >= 0 then
      CreateT920_10;
    if Molteplice(11) >= 0 then
      //A077FGeneratoreStampeDtM.CreateT920_11;
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_11,'VT246_ISCRIZIONISINDACATI');
    if Molteplice(12) >= 0 then
      //A077FGeneratoreStampeDtM.CreateT920_12;
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_12,'VT247_PARTECIPAZIONISINDACALI');
    if Molteplice(13) >= 0 then
      //A077FGeneratoreStampeDtM.CreateT920_13;
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_13,'VT248_PERMESSISINDACALI');
    if Molteplice(14) >= 0 then
      CreateT920_14;
    if Molteplice(15) >= 0 then
      CreateT920_15;
    if Molteplice(16) >= 0 then
      CreateT920_16;
    if Molteplice(17) >= 0 then
      //A077FGeneratoreStampeDtM.CreateT920_17;
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_17,'VSG402_RISCHIPRESCRIZIONI');
    if Molteplice(18) >= 0 then
      //A077FGeneratoreStampeDtM.CreateT920_18;
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_18,'VSG303_INCARICHI');
    if Molteplice(19) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_19,'VT280_MESSAGGIWEB');
    if Molteplice(20) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_20,'VT050_T105_RICHIESTEWEB');
    if Molteplice(21) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_21,'VT500_CARTASERVIZI');
    if Molteplice(22) >= 0 then
      CreateT920_22;
    if Molteplice(23) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_23,'VSG308_INCVERIFICHE');
    if Molteplice(24) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_24,'VT134_ORELIQUIDATEANNIPREC');
    if Molteplice(25) >= 0 then
      CreateT920_xx(A077FGeneratoreStampeMW.Ins920_25,'VT850_T851_A077');
    if Molteplice(26) >= 0 then
      CreateT920_26;
    CreateT920;
  end;
end;

procedure TA077FGeneratoreStampe.FormDestroy(Sender: TObject);
begin
  inherited;
  A077FStampa.Free;
end;

procedure TA077FGeneratoreStampe.cmbSerbatoiChange(Sender: TObject);
begin
  inherited;
  pnlSindacati.Visible:=cmbSerbatoi.ItemIndex in [14..16];
  cmbRecapitoSindacato_11.Visible:=cmbSerbatoi.ItemIndex = 14;
  cmbRecapitoSindacato_12.Visible:=cmbSerbatoi.ItemIndex = 15;
  cmbRecapitoSindacato_13.Visible:=cmbSerbatoi.ItemIndex = 16;
  cmbRecapitoSindacato_11.Top:=20;
  cmbRecapitoSindacato_12.Top:=20;
  cmbRecapitoSindacato_13.Top:=20;
end;

procedure TA077FGeneratoreStampe.PopupMenu3Popup(Sender: TObject);
begin
  inherited;
  Visioneannuale1.Visible:=PopupMenu3.PopupComponent = chklstCorsiFormazione;
  N6.Visible:=PopupMenu3.PopupComponent = chklstCorsiFormazione;
  if DataF > 0 then
    Visioneannuale1.Caption:='Visualizza solo i corsi dell''anno ' + FormatDateTime('yyyy', DataF)
  else
    Visioneannuale1.Caption:='Visualizza solo i corsi dell''anno ' + FormatDateTime('yyyy',Parametri.DataLavoro);
end;

procedure TA077FGeneratoreStampe.Visioneannuale1Click(Sender: TObject);
begin
  inherited;
  Visioneannuale1.Checked:=not Visioneannuale1.Checked;
  A077FGeneratoreStampeDtM.Carica_chklstCorsiFormazione(not Visioneannuale1.Checked);
end;

end.

