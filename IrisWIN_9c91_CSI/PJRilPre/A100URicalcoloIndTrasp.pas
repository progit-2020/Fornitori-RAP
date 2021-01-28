unit A100URicalcoloIndTrasp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, C700USelezioneAnagrafe, C180FunzioniGenerali,
  Menus, A110UParametriConteggio, Variants, Mask,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, Oracle;

type
  TA100FRicalcoloIndTrasp = class(TForm)
    BtnRicalcola: TBitBtn;
    BtnChiudi: TBitBtn;
    mskDataDa: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    mskDataA: TMaskEdit;
    procedure BtnRicalcolaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A100FRicalcoloIndTrasp: TA100FRicalcoloIndTrasp;
  procedure OpenA100RicalcoloIndTrasp;

implementation

uses A100UMISSIONIDTM, A100UMISSIONI;

{$R *.DFM}

procedure OpenA100RicalcoloIndTrasp;
begin
  try
    Application.CreateForm(TA100FRicalcoloIndTrasp, A100FRicalcoloIndTrasp);
    if C700SelAnagrafe.RecordCount = 0 then
    begin
      R180MessageBox('Selezionare uno o più dipendenti cliccando sulla lente.',esclama);
      exit;
    end;
    A100FRicalcoloIndTrasp.ShowModal;
  finally
    A100FRicalcoloIndTrasp.Free;
  end;
end;

procedure TA100FRicalcoloIndTrasp.BtnRicalcolaClick(Sender: TObject);
var
  dDataInizio, dDataFine: TDateTime;

begin
  inherited;

  try
    dDataInizio:=strtodate('01/' + mskDataDa.text);
  except
    mskDataDa.SetFocus;
    raise exception.Create('Indicare il ''mese di scarico da.''');
  end;

  try
    dDataFine:=R180FineMese(strtodate('01/' + mskDataA.text));
  except
    mskDataA.SetFocus;
    raise exception.Create('Indicare il ''mese di scarico a.''');
  end;

  if R180MessageBox(Format(A000MSG_A100_MSG_FMT_RICALCOLO,[FormatDateTime('mm/yyyy',dDataInizio),FormatDateTime('mm/yyyy',dDataFine)]), domanda) = mrNO then
    exit;

  screen.Cursor:=crHourglass;
  with A100FMISSIONIDtM do
  begin
    //Ricerco tutte le indennità chilometriche che cadono nel periodo indicato...
    A100FMissioniMW.SelM052.Close;
    //if SelM052.VariableIndex('DATALAVORO') >= 0 then
    //  SelM052.DeleteVariable('DATALAVORO');
    A100FMissioniMW.SelM052.SetVariable('datada', dDataInizio);
    A100FMissioniMW.SelM052.SetVariable('dataa', dDataFine);
    //sDep:='AND M052.PROGRESSIVO in ' + R180EstraiProgressivoC700(C700SelAnagrafe.SQL.Text,C700Progressivo);
    //SelM052.SetVariable('progressivo', sDep);
    //if SelM052.VariableIndex('DATALAVORO') >= 0 then
    //begin
    //  SelM052.DeclareVariable('DATALAVORO',otDate);
    //  SelM052.SetVariable('DATALAVORO',Parametri.DataLavoro);
    //end;
    C700MergeSelAnagrafe(A100FMissioniMW.SelM052);
    C700mergesettaPeriodo(A100FMissioniMW.SelM052,Parametri.DataLavoro,Parametri.DataLavoro);
    A100FMissioniMW.RicalcolaIndennitaKM;
  end;
  screen.Cursor:=crDefault;

  A100FMISSIONI.actRefreshExecute(nil);
  R180MessageBox('Ricalcolo eseguito.',informa);
end;

procedure TA100FRicalcoloIndTrasp.FormActivate(Sender: TObject);
begin
  with A100FMISSIONIDtM do
  begin
    if M040MESECOMPETENZA.AsString <> '' then
    begin
      mskDataDa.Text:=FormatDateTime('mm/yyyy', M040MESESCARICO.AsDateTime);
      mskDataA.Text:=FormatDateTime('mm/yyyy',M040MESESCARICO.AsDateTime);
    end
  end;
end;

end.
