unit A092UStampaStoricoMW;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData;

type
  TA092FStampaStoricoMW = class(TR005FDataModuleMW)
    Q010S: TOracleDataSet;
  private
    { Private declarations }
  public
    procedure Inizializza(IsApplicazionePaghe: Boolean);
  end;

implementation

{$R *.dfm}

procedure TA092FStampaStoricoMW.Inizializza(IsApplicazionePaghe: Boolean);
begin
  Q010S.SetVariable('TABELLE',IfThen(IsApplicazionePaghe,'''T430_STORICO'',''P430_ANAGRAFICO''','''T430_STORICO'''));
  Q010S.SetVariable('APPLICAZIONE',IfThen(IsApplicazionePaghe,'PAGHE','*'));
  Q010S.Open;
end;

end.
