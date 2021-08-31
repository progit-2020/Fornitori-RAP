unit A129UIndennitaKm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, DBCtrls, ExtCtrls, ActnList, ImgList, DB,
  Menus, ComCtrls, ToolWin, StdCtrls, Mask, Buttons, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, OracleData, P050UArrotondamenti, System.Actions;

type
  TA129FIndennitaKm = class(TR004FGestStorico)
    Panel1: TPanel;
    lblDescrizione: TLabel;
    LblIndennitaKmNelComune: TLabel;
    dLblValuta1: TDBText;
    LblArrImportiKmNelComune: TLabel;
    dLblArrImportiKmNelComune: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    dEdtDescrizione: TDBEdit;
    dedtImporto: TDBEdit;
    dcmbArrotondamento: TDBLookupComboBox;
    dEdtCodice: TDBEdit;
    dEdtCodicePaghe: TDBEdit;
    PopupMenu1: TPopupMenu;
    NuovoElemento1: TMenuItem;
    procedure dcmbArrotondamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A129FIndennitaKm: TA129FIndennitaKm;

procedure OpenA129IndennitaKm(sCodice:string='';dDecorrenza:TDateTime=0);

implementation

uses A129UIndennitaKmDtm;

{$R *.dfm}

procedure OpenA129IndennitaKm(sCodice:string='';dDecorrenza:TDateTime=0);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA129IndennitaKm') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  Application.CreateForm(TA129FIndennitaKm,A129FIndennitaKm);
  Application.CreateForm(TA129FIndennitaKmDtm,A129FIndennitaKmDtm);
  try
    Screen.Cursor:=crDefault;
    if (sCodice <> '') and (dDecorrenza <> 0) then
      A129FIndennitaKmDtm.SelM021.SearchRecord('CODICE;DECORRENZA',VarArrayOf([sCodice, dDecorrenza]), [srFromBeginning]);
    A129FIndennitaKm.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A129FIndennitaKmDtM.Free;
    A129FIndennitaKm.Free;
  end;
end;

procedure TA129FIndennitaKm.FormShow(Sender: TObject);
begin
  inherited;
  with A129FIndennitaKmDtm.A129FIndennitaKmMW do
  begin
    dLblValuta1.DataSource:=dsrP050;
    dcmbArrotondamento.ListSource:=dsrP050;
  end;
end;

procedure TA129FIndennitaKm.NuovoElemento1Click(Sender: TObject);
begin
  OpenP050FArrotondamenti(TDBLookupComboBox(PopupMenu1.PopupComponent).Field.AsString);
  A129FIndennitaKmDtm.A129FIndennitaKmMW.selP050.Refresh;
end;

procedure TA129FIndennitaKm.dcmbArrotondamentoKeyDown(Sender: TObject;
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
