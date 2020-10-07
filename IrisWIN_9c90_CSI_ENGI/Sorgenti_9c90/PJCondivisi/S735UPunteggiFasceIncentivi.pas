unit S735UPunteggiFasceIncentivi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, C180FUNZIONIGENERALI,

  Variants, Grids, DBGrids, System.Actions;

type
  TS735FPunteggiFasceIncentivi = class(TR004FGestStorico)
    pnlSituazioneRiepilog: TPanel;
    dgrdSituazioneComplessiva: TDBGrid;
    pmnNuovaVoceAggiuntiva: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    {Private declarations}
  public
    { Public declarations }
  end;

var
  S735FPunteggiFasceIncentivi: TS735FPunteggiFasceIncentivi;

procedure OpenS735FPunteggiFasceIncentivi(Tipologia:String);

implementation

uses S735UPunteggiFasceIncentiviDtM, C016UElencoVoci;

{$R *.DFM}

procedure OpenS735FPunteggiFasceIncentivi(Tipologia:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS735FPunteggiFasceIncentivi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TS735FPunteggiFasceIncentivi, S735FPunteggiFasceIncentivi);
  Application.CreateForm(TS735FPunteggiFasceIncentiviDtM, S735FPunteggiFasceIncentiviDtM);
  try
    S735FPunteggiFasceIncentiviDtM.S735FPunteggiFasceIncentiviMW.Tipo:=Tipologia;
    S735FPunteggiFasceIncentivi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S735FPunteggiFasceIncentivi.Free;
    S735FPunteggiFasceIncentiviDtM.Free;
  end;
end;

procedure TS735FPunteggiFasceIncentivi.FormActivate(Sender: TObject);
begin
  inherited;
  VisioneCorrente1Click(nil);
end;

procedure TS735FPunteggiFasceIncentivi.FormShow(Sender: TObject);
begin
  DButton.DataSet:=S735FPunteggiFasceIncentiviDtM.Q735;
  inherited;
  if S735FPunteggiFasceIncentiviDtM.S735FPunteggiFasceIncentiviMW.Tipo = 'V' then //valutazioni
  begin
    S735FPunteggiFasceIncentivi.HelpContext:=2735000;
    S735FPunteggiFasceIncentivi.Caption:='<S735> Scaglioni valutazioni per incentivi';
    dgrdSituazioneComplessiva.Columns[2].Visible:=False;
    dgrdSituazioneComplessiva.Columns[5].Title.Caption:='Da punteggio';
    dgrdSituazioneComplessiva.Columns[6].Title.Caption:='A punteggio';
    dgrdSituazioneComplessiva.Columns[7].Title.Caption:='% valut.incentivo';
  end
  else if S735FPunteggiFasceIncentiviDtM.S735FPunteggiFasceIncentiviMW.Tipo = 'I' then //Incentivi part-time
  begin
    S735FPunteggiFasceIncentivi.HelpContext:=2735100;
    S735FPunteggiFasceIncentivi.Caption:='<S735> Scaglioni part-time incentivi';
    dgrdSituazioneComplessiva.Columns[2].Visible:=True;
    dgrdSituazioneComplessiva.Columns[5].Title.Caption:='Da % PT effettiva';
    dgrdSituazioneComplessiva.Columns[6].Title.Caption:='A % PT effettiva ';
    dgrdSituazioneComplessiva.Columns[7].Title.Caption:='% PT incentivo';
  end
  else //Incentivi gg. effettivi lavorati ('G')
  begin
    S735FPunteggiFasceIncentivi.HelpContext:=2735200;
    S735FPunteggiFasceIncentivi.Caption:='<S735> Scaglioni gg. effettivi incentivi';
    dgrdSituazioneComplessiva.Columns[2].Visible:=False;
    dgrdSituazioneComplessiva.Columns[5].Title.Caption:='Da % gg. effettivi';
    dgrdSituazioneComplessiva.Columns[6].Title.Caption:='A % gg. effettivi';
    dgrdSituazioneComplessiva.Columns[7].Title.Caption:='% gg. effettivi';
  end;
end;

end.
