unit A012UCalendari;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DB, DBCtrls, ExtCtrls, OracleData,
  Menus, ComCtrls, R001UGESTTAB, A000UCostanti, A000USessione,A000UInterfaccia, ActnList,
  ImgList, ToolWin, Variants, Grids, DBGrids,A000UMessaggi, System.Actions,
  System.ImageList;

type
  TA012FCalendari = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    ECodice: TDBEdit;
    EDescrizione: TDBEdit;
    GroupBox1: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    DaData: TMaskEdit;
    AData: TMaskEdit;
    Genera: TBitBtn;
    Calendario1: TMenuItem;
    Visualizza1: TMenuItem;
    Visualizza: TBitBtn;
    grpFestivitaAggiuntive: TGroupBox;
    grdFestivitaAggiuntive: TDBGrid;
    Timer1: TTimer;
    dchkIgnoraFestivita: TDBCheckBox;
    dedtNGGLav: TDBEdit;
    Label3: TLabel;
    procedure Visualizza1Click(Sender: TObject);
    procedure GeneraClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function ConvData(Text:string; var Data:TDateTime):boolean;
  public
    { Public declarations }
  end;

var
  A012FCalendari: TA012FCalendari;

procedure OpenA012Calendari(Cod:String);

implementation

uses A012USviluppo, A012UCalendariDtM1;

{$R *.DFM}

procedure OpenA012Calendari(Cod:String);
{Gestione calendario}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA012Calendari') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
A012FCalendari:=TA012FCalendari.Create(nil);
A012FCalendariDtM1:=TA012FCalendariDtM1.Create(nil);
with A012FCalendari do
  try
    //DButton.DataSet:=A012FCalendariDtM1.T010;
    A012FCalendariDtM1.Q010.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A012FCalendariDtM1.Free;
    Release;
  end;
end;

procedure TA012FCalendari.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A012FCalendariDtM1.Q010;
  inherited;
end;

function TA012FCalendari.ConvData(Text:string; var Data:TDateTime):boolean;
begin
  result:=True;
  try
    Data:=StrToDate(Text);
  except
    result:=false;
  end;
end;

procedure TA012FCalendari.Visualizza1Click(Sender: TObject);
{Visualizza il calendario nel periodo richiesto}
var Anno,Mese,Giorno,AnnoL,MeseL,GiornoL,DiffAnni:Word;
    Range:boolean;
    DaGiorno,AGiorno:TDateTime;
begin
  with A012FCalendariDtM1 do
  begin
  Range:=True;
  {Controllo se e' impostato un range valido}
  if not ConvData(DaData.Text,DaGiorno) then
    begin
    DaGiorno:=EncodeDate(1900,1,1);
    Range:=False;
    end;
  if not ConvData(AData.Text,AGiorno) then
    begin
    AGiorno:=EncodeDate(3999,12,31);
    Range:=False;
    end;
  if (Range) and (DaGiorno > AGiorno) then
    begin
    ShowMessage('Le date devono essere in successione cronologica!');
    exit;
    end;
  Q011.Close;
  Q011.SetVariable('Codice',Q010.FieldByName('Codice').AsString);
  Q011.SetVariable('Dal',DaGiorno);
  Q011.SetVariable('Al',AGiorno);
  Q011.Open;
  if Q011.RecordCount = 0 then
    begin
    ShowMessage(A000MSG_A012_ERR_NO_PERIODO);
    exit;
    end;
  {Se le date sono errate parto dal primo record del calendario}
  // if not Range then
    begin
    Q011.First;
    DecodeDate(Q011['Data'],Anno,Mese,Giorno);
    Q011.Last;
    DecodeDate(Q011['Data'],AnnoL,MeseL,GiornoL);
    end;
  (*else
    begin
    DecodeDate(DaGiorno,Anno,Mese,Giorno);
    DecodeDate(AGiorno,AnnoL,MeseL,GiornoL);
    end;*)
  end;
  A012FSviluppo:=TA012FSviluppo.Create(Self);
  try
    A012FSviluppo.Caption:='Calendario ' + EDescrizione.Text;
    DiffAnni:=AnnoL-Anno;
    if DiffAnni = 0 then
      A012FSviluppo.NumMesi:=MeseL-Mese+1
    else
      A012FSviluppo.NumMesi:=12*(DiffAnni - 1) + MeseL + 13-Mese;
    A012FSviluppo.Calendario.RowCount:=A012FSviluppo.NumMesi+1;
    A012FSviluppo.Anno:=Anno;
    A012FSviluppo.Mese:=Mese;
    A012FSviluppo.ShowModal;
  finally
    A012FSviluppo.Release;
  end;
end;

procedure TA012FCalendari.GeneraClick(Sender: TObject);
{Genera il calendario nel periodo richiesto}
var DaGiorno,AGiorno:TDateTime;
begin
  if not ConvData(DaData.Text,DaGiorno) then
  begin
    ShowMessage('La data e'' errata!');
    exit;
  end;
  if not ConvData(AData.Text,AGiorno) then
  begin
    ShowMessage('La data e'' errata!');
    exit;
  end;
  if DaGiorno > AGiorno then
  begin
    ShowMessage('Le date devono essere in successione cronologica!');
    exit;
  end;
  Screen.Cursor:=crHourGlass;
  A012FCalendariDtM1.GeneraCalendario(DaGiorno,AGiorno);
  Screen.Cursor:=crDefault;
end;

procedure TA012FCalendari.DButtonStateChange(Sender: TObject);
{Abilita/Disabilita la funzione genera a seconda dello stato del dataset}
begin
  inherited;
  Genera.Enabled:=TPrimo.Enabled and not(SolaLettura);
  TOracleDataSet(grdFestivitaAggiuntive.DataSource.DataSet).ReadOnly:=not(DButton.State in [dsEdit,dsInsert]);
end;

end.
