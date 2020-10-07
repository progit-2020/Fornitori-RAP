unit S730UPunteggiValutazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Oracle, OracleData,
  A000UCostanti, A000USessione, System.Actions, System.ImageList;

type
  TS730FPunteggiValutazioni = class(TR004FGestStorico)
    lblScadenza: TLabel;
    dedtScadenza: TDBEdit;
    dedtPunteggio: TDBEdit;
    dedtDescrizione: TDBEdit;
    lblPunteggio: TLabel;
    lblDescrizione: TLabel;
    lblDato1: TLabel;
    dcmbDato1: TDBLookupComboBox;
    dtxtDescDato1: TDBText;
    dchkCalcoloPFP: TDBCheckBox;
    lblCodice: TLabel;
    dedtCodice: TDBEdit;
    dchkGiustifica: TDBCheckBox;
    dchkItemGiudicabile: TDBCheckBox;
    procedure dcmbDato1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dchkCalcoloPFPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  S730FPunteggiValutazioni: TS730FPunteggiValutazioni;

procedure OpenS730FPunteggiValutazioni(Dato1,Codice:String;Data:TDateTime);

implementation

{$R *.dfm}

uses
  S730UPunteggiValutazioniDtM;

procedure OpenS730FPunteggiValutazioni(Dato1,Codice:String;Data:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS730FPunteggiValutazioni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S730FPunteggiValutazioni:=TS730FPunteggiValutazioni.Create(nil);
  with S730FPunteggiValutazioni do
  try
    S730FPunteggiValutazioniDtM:=TS730FPunteggiValutazioniDtM.Create(nil);
    with S730FPunteggiValutazioniDtM.selSG730 do
    begin
      if RecordCount > 0 then
        SearchRecord('DATO1;CODICE',VarArrayOf([Dato1,Codice]),[srFromBeginning]);
      while (FieldByName('DATO1').AsString = Dato1)
      and (FieldByName('CODICE').AsString = Codice)
      and not Eof do
      begin
        if  (Data >= FieldByName('DECORRENZA').AsDateTime)
        and (Data <= FieldByName('DECORRENZA_FINE').AsDateTime) then
          Break;
        Next;
      end;
    end;
    Screen.Cursor:=crDefault;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S730FPunteggiValutazioniDtM.Free;
    Release;
  end;
end;

procedure TS730FPunteggiValutazioni.dchkCalcoloPFPClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS730FPunteggiValutazioni.dcmbDato1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      begin
        (Sender as TDBLookupComboBox).Field.DataSet.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
        (Sender as TDBLookupComboBox).Field.FocusControl;
      end
      else
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS730FPunteggiValutazioni.FormShow(Sender: TObject);
begin
  inherited;
  lblDato1.Caption:=S730FPunteggiValutazioniDtM.selSG730.FieldByName('DATO1').DisplayLabel;
end;

procedure TS730FPunteggiValutazioni.AbilitaComponenti;
begin
  lblPunteggio.Visible:=dchkCalcoloPFP.Checked;
  dedtPunteggio.Visible:=dchkCalcoloPFP.Checked;
end;

end.
