unit A076UIndGruppo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGestStorico, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis, ActnList, ImgList,
  ToolWin, DBCtrls, StdCtrls, Mask, Variants, C180FunzioniGenerali,
  C012UVisualizzaTesto, System.Actions;

type
  TA076FIndGruppo = class(TR004FGestStorico)
    DBGrid1: TDBGrid;
    actVisualizzazioneGlobale: TAction;
    actCambiaData: TAction;
    BitBtn1: TBitBtn;
    procedure actVisualizzazioneGlobaleExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A076FIndGruppo: TA076FIndGruppo;

procedure OpenA076IndGruppo;

implementation

uses A076UIndGruppoDtM1;

{$R *.DFM}

procedure OpenA076IndGruppo;
{Gestione indennità per raggruppamento}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA076IndGruppo') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A076FIndGruppo:=TA076FIndGruppo.Create(nil);
  with A076FIndGruppo do
  try
    A076FIndGruppoDtM1:=TA076FIndGruppoDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A076FIndGruppoDtM1.Free;
    Release;
  end;
end;

procedure TA076FIndGruppo.FormShow(Sender: TObject);
begin
  inherited;
  with A076FIndGruppoDtM1.A076MW.selCodice1 do
  begin
    First;
    while not Eof do
    begin
      DBGrid1.Columns[R180GetColonnaDBGrid(DBGrid1,'CODICE')].PickList.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
  with A076FIndGruppoDtM1.A076MW.selCodice2 do
  begin
    First;
    while not Eof do
    begin
      DBGrid1.Columns[R180GetColonnaDBGrid(DBGrid1,'CODICE2')].PickList.Add(FieldByName('CODICE').AsString);
      Next;
    end;
  end;
end;

procedure TA076FIndGruppo.actVisualizzazioneGlobaleExecute(
  Sender: TObject);
var
  MyStrList:TStringList;
begin
  MyStrList:=TStringList.Create;
  with A076FIndGruppoDtM1 do
    try
      selaT161.Close;
      selaT161.SetVariable('Decorrenza',Q161.FieldByName('DECORRENZA').AsDateTime);
      selaT161.Open;
      while not selaT161.Eof do
      begin
        MyStrList.Add('| ' + FormatDateTime('dd/mm/yyyy',selaT161.FieldByName('DECORRENZA').AsDateTime) + ' | ' +
                                     Format('%-20.20s', [selaT161.FieldByName('CODICE').AsString]) + ' | ' +
                                     Format('%-20.20s', [selaT161.FieldByName('CODICE2').AsString]) + ' | ' +
                                     Format('%-5.5s',   [selaT161.FieldByName('INDENNITA').AsString]) + ' | ' +
                                     Format('%-40.40s', [selaT161.FieldByName('DESCRIZIONE').AsString]) + ' | ');
        selaT161.Next;
      end;
      OpenC012VisualizzaTesto('<A076> Visione globale indennità','',MyStrList);
    finally
      FreeAndNil(MyStrList);
    end;
end;

end.
