unit P656UElaborazioneFLUPERDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICODTM, Db, OracleData,  C700USelezioneAnagrafe, A000UCostanti, A000USessione, A000UInterfaccia, Variants,
  Oracle, P656UElaborazioneFluperMW;

type
  TP656FElaborazioneFLUPERDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    P656FElaborazioneFluperMW: TP656FElaborazioneFluperMW;
  end;

var
  P656FElaborazioneFLUPERDtM: TP656FElaborazioneFLUPERDtM;

implementation

{$R *.DFM}

procedure TP656FElaborazioneFLUPERDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  P656FElaborazioneFluperMW:=TP656FElaborazioneFluperMW.Create(Self);
end;

procedure TP656FElaborazioneFLUPERDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(P656FElaborazioneFluperMW);
  inherited;
end;

end.
