unit A003UDataLavoroBis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Calendar, StdCtrls, Spin, Buttons, ExtCtrls, C180FunzioniGenerali,
  ComCtrls, Variants;

type
  TA003FDataLavoroBis = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    procedure DateTimePicker1CloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A003FDataLavoroBis: TA003FDataLavoroBis;

function DataOut(DataIn:TDateTime; Titolo:String; FLAG:Char; bSvuotaData:boolean=False):TDateTime;

implementation

{$R *.DFM}

type tMesi = Array[1..12] of String;
const Mesi:tMesi = ('Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto',
'Settembre','Ottobre','Novembre','Dicembre');

function DataOut(DataIn:TDateTime; Titolo:String; FLAG:Char; bSvuotaData:boolean=False):TDateTime;
{Restituisce la data}
begin
  A003FDataLavoroBis:=TA003FDataLavoroBis.Create(Application);
  with A003FDataLavoroBis do
    try
      Caption:=Titolo;
      if DataIn = 0 then
        DateTimePicker1.Date:=Date
      else
        DateTimePicker1.Date:=DataIn;
      Result:=DataIn;
      case FLAG of
        'A':DateTimePicker1.Format:='yyyy';
        'M':DateTimePicker1.Format:='MM/yyyy';
      else
        DateTimePicker1.Format:='dd/MM/yyyy';
      end;
      if ShowModal = mrOk then
        Result:=Trunc(DateTimePicker1.Date)
      else
        if bSvuotaData then
          Result:=0;
    finally
      Release;
    end;
end;

procedure TA003FDataLavoroBis.DateTimePicker1CloseUp(Sender: TObject);
begin
  if (DateTimePicker1.Format <> 'dd/MM/yyyy') and (R180Giorno(DateTimePicker1.Date) <> 1) then
    DateTimePicker1.Date:=R180InizioMese(DateTimePicker1.Date);
end;

end.
