unit A145UComunicazioneVisiteFiscaliDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, USelI010,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, DB, DBClient,
  OracleData, Oracle, A145UEsenzioni, A145UComVisiteFiscaliMW;

type
  TA145FComunicazioneVisiteFiscaliDtm = class(TR004FGestStoricoDtM)
    dscT485: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConfermaPostEsenzioni(Msg: String);
    procedure AfterPostEsenzioni;
  public
    A145FComVisiteFiscaliMW: TA145FComVisiteFiscaliMW;
  end;

var
  A145FComunicazioneVisiteFiscaliDtm: TA145FComunicazioneVisiteFiscaliDtm;

implementation

uses A145UComunicazioneVisiteFiscali;

{$R *.dfm}

procedure TA145FComunicazioneVisiteFiscaliDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A145FComVisiteFiscaliMW:=TA145FComVisiteFiscaliMW.Create(Self);
  A145FComVisiteFiscaliMW.ConfermaBeforePostEsenzioni:=ConfermaPostEsenzioni;
  A145FComVisiteFiscaliMW.AfterPostEsenzioni:=AfterPostEsenzioni;
  dscT485.Dataset:=A145FComVisiteFiscaliMW.selT485;
  {
  // popola check list delle causali
  A145FComunicazioneVisiteFiscali.chkLCausali.Items.Clear;
  selT265.First;
  while not selT265.Eof do
  begin
    i:=A145FComunicazioneVisiteFiscali.chkLCausali.Items.Add(
       Format('%-5s %s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]));
    A145FComunicazioneVisiteFiscali.chkLCausali.Checked[i]:=True;
    selT265.Next;
  end;
  }

end;

procedure TA145FComunicazioneVisiteFiscaliDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A145FComVisiteFiscaliMW);
end;

procedure TA145FComunicazioneVisiteFiscaliDtm.ConfermaPostEsenzioni(Msg: String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    Abort;
end;

procedure TA145FComunicazioneVisiteFiscaliDtm.AfterPostEsenzioni;
begin
  A145FEsenzioni.AggiornaElencoTipi;
end;

end.

