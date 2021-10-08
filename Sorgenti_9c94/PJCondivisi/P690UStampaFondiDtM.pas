unit P690UStampaFondiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, DBClient;

type
  TP690FStampaFondiDtM = class(TR004FGestStoricoDtM)
    selP684: TOracleDataSet;
    selP688: TOracleDataSet;
    TabStampaRis: TClientDataSet;
    selP688Dett: TOracleDataSet;
    selP686: TOracleDataSet;
    TabStampaDest: TClientDataSet;
    procedure selP688AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P690FStampaFondiDtM: TP690FStampaFondiDtM;

implementation

uses P690UStampaFondi;

{$R *.dfm}

procedure TP690FStampaFondiDtM.selP688AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P690FStampaFondi.chkRaggruppa.Checked then
  begin
    TabStampaRis.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO_RAGGR').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaRis.Filtered:=True;
    TabStampaDest.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO_RAGGR').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaDest.Filtered:=True;
  end
  else
  begin
    TabStampaRis.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaRis.Filtered:=True;
    TabStampaDest.Filter:='(FONDO = ''' + selP688.FieldByName('COD_FONDO').AsString + ''') AND (DEC = ''' +
       selP688.FieldByName('DECORRENZA_DA').AsString + ''')';
    TabStampaDest.Filtered:=True;
  end;
end;

end.
