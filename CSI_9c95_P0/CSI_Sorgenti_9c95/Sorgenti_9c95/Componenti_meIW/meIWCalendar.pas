unit meIWCalendar;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, {$IFDEF TMSIW121}IWCompGrids{$ELSE}IWGrids{$ENDIF}, IWCompCalendar;

type
  TmeIWCalendar = class(TIWCalendar)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;


implementation


end.
