unit A132UMagazzinoBuoniPastoMW;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData;

type
  TA132FMagazzinoBuoniPastoMW = class(TR005FDataModuleMW)
    selT691_ID: TOracleDataSet;
    selaT691: TOracleDataSet;
    selT690: TOracleDataSet;
  private
    { Private declarations }
  public
    selT691: TOracleDataSet;
    BuoniAcquistati,BuoniResidui,BuoniAssegnati,BuoniScaduti,TicketAcquistati,TicketResidui,TicketAssegnati,TicketScaduti: Integer;
    CalcolaRiepilogoComplessivo:boolean;
    DataDa,DataA,DataAcquisto:TDateTime;
    procedure selT691BeforePost;
    procedure CalcolaRiepilogo;
  end;

implementation

{$R *.dfm}

procedure TA132FMagazzinoBuoniPastoMW.selT691BeforePost;
begin
  if selT691.FieldByName('DATA_SCADENZA').AsDateTime <= selT691.FieldByName('DATA_ACQUISTO').AsDateTime then
    raise Exception.Create('La data di scadenza deve essere maggiore della data acquisto!');
  if (not selT691.FieldByName('ID_DAL').IsNull) and (not selT691.FieldByName('ID_AL').IsNull) then
  try
    selT691_ID.Close;
    selT691_ID.SetVariable('IDRIGA',IfThen(selT691.State = dsEdit,selT691.RowID,''));
    selT691_ID.SetVariable('ID_DAL',selT691.FieldByName('ID_DAL').AsInteger);
    selT691_ID.SetVariable('ID_AL',selT691.FieldByName('ID_AL').AsInteger);
    selT691_ID.Open;
    if selT691_ID.RecordCount > 0 then
      raise Exception.Create(Format('I blocchetti indicati sono già usati nella fornitura acquistata il %s',[selT691_ID.FieldByName('DATA_ACQUISTO').AsString]));
    if selT691.FieldByName('ID_DAL').AsInteger > selT691.FieldByName('ID_AL').AsInteger then
      raise Exception.Create('I numeri dei blocchetti indicati non sono corretti');
    if selT691.FieldByName('BUONIPASTO').IsNull and selT691.FieldByName('TICKET').IsNull and (selT691.FieldByName('DIM_BLOCCHETTO').AsInteger > 0) then
      selT691.FieldByName('BUONIPASTO').AsInteger:=(selT691.FieldByName('ID_AL').AsInteger - selT691.FieldByName('ID_DAL').AsInteger + 1) * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger;
  finally
    selT691_ID.Close;
  end;
end;

procedure TA132FMagazzinoBuoniPastoMW.CalcolaRiepilogo;
begin
  selaT691.Close;
  if CalcolaRiepilogoComplessivo then
  begin
    selaT691.SetVariable('DATA_ACQUISTO1',DataDa);
    selaT691.SetVariable('DATA_ACQUISTO2',DataA);
  end
  else
  begin
    selaT691.SetVariable('DATA_ACQUISTO1',DataAcquisto);
    selaT691.SetVariable('DATA_ACQUISTO2',DataAcquisto);
  end;
  selaT691.Open;
  while not selaT691.Eof do
  begin
    BuoniAcquistati:=BuoniAcquistati + selaT691.FieldByName('TOT_BUONIPASTO').AsInteger;
    TicketAcquistati:=TicketAcquistati + selaT691.FieldByName('TOT_TICKET').AsInteger;
    selT690.Close;
    if CalcolaRiepilogoComplessivo then
    begin
      selT690.SetVariable('DATA_SCADENZA',selaT691.FieldByName('DATA_SCADENZA').AsDateTime);
      selT690.SetVariable('DAL',DataDa);
      selT690.SetVariable('DATA_ACQUISTO',DataA);
      selT690.SetVariable('DATA_FORNITURA',null);
    end
    else
    begin
      selT690.SetVariable('DATA_SCADENZA',selaT691.FieldByName('DATA_SCADENZA').AsDateTime);
      selT690.SetVariable('DAL',null);
      selT690.SetVariable('DATA_ACQUISTO',DataAcquisto);
      selT690.SetVariable('DATA_FORNITURA',DataAcquisto);
    end;
    selT690.Open;
    while not selT690.Eof  do
    begin
      BuoniAssegnati:=BuoniAssegnati+selT690.FieldByName('TOT_BUONIPASTO').AsInteger;
      TicketAssegnati:=TicketAssegnati+selT690.FieldByName('TOT_TICKET').AsInteger;
      if selaT691.FieldByName('DATA_SCADENZA').AsDateTime < DataA then
      begin
        BuoniScaduti:=BuoniScaduti+(selaT691.FieldByName('TOT_BUONIPASTO').AsInteger-selT690.FieldByName('TOT_BUONIPASTO').AsInteger);
        TicketScaduti:=TicketScaduti+(selaT691.FieldByName('TOT_TICKET').AsInteger-selT690.FieldByName('TOT_TICKET').AsInteger);
      end;
      selT690.Next;
    end;
    selaT691.Next;
  end;
  BuoniResidui:=BuoniAcquistati-BuoniAssegnati-BuoniScaduti;
  TicketResidui:=TicketAcquistati-TicketAssegnati-TicketScaduti;
end;

end.
