unit S730UPunteggiValutazioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, S730UPunteggiValutazioniMW;

type
  TS730FPunteggiValutazioniDtM = class(TR004FGestStoricoDtM)
    selSG730: TOracleDataSet;
    selSG730DESCRIZIONE: TStringField;
    selSG730PUNTEGGIO: TFloatField;
    selSG730DECORRENZA: TDateTimeField;
    selSG730DECORRENZA_FINE: TDateTimeField;
    selSG730DATO1: TStringField;
    selSG730DESC_DATO1: TStringField;
    selSG730CALCOLO_PFP: TStringField;
    selSG730CODICE: TStringField;
    selSG730GIUSTIFICA: TStringField;
    selSG730ITEM_GIUDICABILE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selSG730AfterScroll(DataSet: TDataSet);
    procedure selSG730AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    S730FPunteggiValutazioniMW: TS730FPunteggiValutazioniMW;
  end;

var
  S730FPunteggiValutazioniDtM: TS730FPunteggiValutazioniDtM;

implementation

{$R *.dfm}

uses
  S730UPunteggiValutazioni;

procedure TS730FPunteggiValutazioniDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.AfterPost;
end;

procedure TS730FPunteggiValutazioniDtM.BeforePost(DataSet: TDataSet);
var Msg:String;
begin
  Msg:=S730FPunteggiValutazioniMW.BeforePost;
  if Msg <> '' then
  begin
    Msg:=Msg + 'Deselezionando il campo ' + S730FPunteggiValutazioni.dchkCalcoloPFP.Caption +
    ' saranno svuotati tutti i valori indicati in ' + S730FPunteggiValutazioni.lblPunteggio.Caption + ' per tutti i Codici assegnati al valore ' +
    selSG730.FieldByName('DATO1').AsString + ' del dato ' + S730FPunteggiValutazioni.lblDato1.Caption + ' su tutte le decorrenze. Proseguire?';
    if R180MessageBox(Msg,'DOMANDA') = mrNo then
      Abort
  end;
  S730FPunteggiValutazioniMW.ControlloDate;
  inherited;
end;

procedure TS730FPunteggiValutazioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S730FPunteggiValutazioni.InterfacciaR004;
  InterfacciaR004.OttimizzaDecorrenzaFine:=False;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selSG730,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);

  S730FPunteggiValutazioniMW:=TS730FPunteggiValutazioniMW.Create(Self);
  S730FPunteggiValutazioniMW.selSG730:=selSG730;
  S730FPunteggiValutazioniMW.selSG730OldValues.SetDataSet(selSG730);

  S730FPunteggiValutazioni.DButton.DataSet:=selSG730;
  selSG730PUNTEGGIO.EditMask:='!990,00;1;_';

  S730FPunteggiValutazioniMW.SetCampiLookup;
end;

procedure TS730FPunteggiValutazioniDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.OnNewRecord;
end;

procedure TS730FPunteggiValutazioniDtM.selSG730AfterOpen(DataSet: TDataSet);
begin
  S730FPunteggiValutazioniMW.selSG730OldValues.CreaStruttura;
end;

procedure TS730FPunteggiValutazioniDtM.selSG730AfterScroll(DataSet: TDataSet);
begin
  inherited;
  S730FPunteggiValutazioniMW.selSG730OldValues.Aggiorna;
  S730FPunteggiValutazioni.AbilitaComponenti;
end;

end.

