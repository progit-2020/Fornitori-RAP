unit A044UAllineaStoriciMW;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, A000UInterfaccia, A000UMessaggi, A000UCostanti, A000USessione,
  Oracle, DB, OracleData;

type
  TA044FAllineaStoriciMW = class(TR005FDataModuleMW)
    selT430: TOracleDataSet;
    updT430: TOracleQuery;
    updT430B: TOracleQuery;
    scrT430: TOracleQuery;
    scrP430: TOracleQuery;
    updJob: TOracleQuery;
    scrJob: TOracleQuery;
    selUser_Job: TOracleDataSet;
    selT001: TOracleDataSet;
    updOra: TOracleQuery;
    scrJobCtrl: TOracleQuery;
    scrT430_P430: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure AggiornaFine(Prog: Integer; Decorrenza, Fine: TDateTime);
    procedure AggiornaInizio(Prog: Integer; NewInizio, OldInizio: TDateTime);
    { Private declarations }
  public
    procedure RicreaJob;
    procedure ImpostaOraJob(Ora: String);
    function getDatiJob(var idJob:String; var OraJob: String; var ProssimaEsecuzione :TDateTime): Boolean;
    procedure AllineamentoPeriodi(Progressivo: Integer);
    procedure AllineamentoPrimaDecorrenza(Progressivo:LongInt);
    function OttimizzazionePeriodi(Progressivo: Integer; Presenze,AssLiberaPresenze, Stipendi, AssLiberaStipendi: Boolean): String;
  end;

implementation

{$R *.dfm}

procedure TA044FAllineaStoriciMW.DataModuleCreate(Sender: TObject);
var
  i : Integer;
begin
  //Creazione del Dtm da P300
  if Self.Owner is TOracleSession then
  begin
    for i:=0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        (Components[i] as TOracleQuery).Session:=(Self.Owner as TOracleSession);
      if Components[i] is TOracleDataSet then
        (Components[i] as TOracleDataSet).Session:=(Self.Owner as TOracleSession);
    end
  end
  else
    inherited;

  selT001.Open;
end;

function TA044FAllineaStoriciMW.getDatiJob(var idJob:String; var OraJob: String; var ProssimaEsecuzione :TDateTime): Boolean;
begin
  if selT001.RecordCount = 0 then
  begin
    Result:=False;
    Exit;
  end;
  selUser_Job.Close;
  selUser_Job.SetVariable('ID_JOB',selT001.FieldByName('VALORE').AsInteger);

  idJob:=selT001.FieldByName('VALORE').AsString;
  try
    selUser_Job.Open;
    OraJob:=StringReplace(Copy(selUser_Job.FieldByName('NEXT_SEC').AsString,1,5),':','.',[rfReplaceAll]);
    ProssimaEsecuzione:=selUser_Job.FieldByName('NEXT_DATE').AsDateTime;
  except
    OraJob:='';
  end;
  Result:=True;
end;

procedure TA044FAllineaStoriciMW.ImpostaOraJob(Ora: String);
begin
  updJob.SetVariable('Next_date',Ora);
  updJob.Execute;
  updOra.SetVariable('Next_date',Ora);
  updOra.Execute;
  SessioneOracle.Commit;
  selT001.Refresh;
end;

procedure TA044FAllineaStoriciMW.RicreaJob;
begin
  scrJob.Execute;
  scrJobCtrl.Execute;
  updOra.SetVariable('Next_date','00.00');
  updOra.Execute;
  SessioneOracle.Commit;
  selT001.Refresh;
end;

procedure TA044FAllineaStoriciMW.AllineamentoPeriodi(Progressivo:LongInt);
var Primo,CambioInizio,CambioFine:Boolean;
    DataInizio,DataFine:TDateTime;
begin
  //Allineamento movimenti storici: non si possono avere più movimenti
  //storici con data fine 31/12/3999
  DataInizio:=0;
  DataFine:=0;
  with selT430 do
  begin
    Close;
    SetVariable('Progressivo',Progressivo);
    Open;
    Primo:=True;
    //Scorrimento movimenti storici
    while not Eof do
    begin
      CambioInizio:=False;
      CambioFine:=False;
      if Primo then
        Primo:=False
      else
      begin
        if FieldByName('DataDecorrenza').AsDateTime < (DataFine + 1) then
        begin
          if DataInizio <= FieldByName('DataDecorrenza').AsDateTime - 1 then
            AggiornaFine(Progressivo,DataInizio,FieldByName('DataDecorrenza').AsDateTime - 1);
        end
        else if FieldByName('DataDecorrenza').AsDateTime > (DataFine + 1) then
        begin
          AggiornaInizio(Progressivo,DataFine + 1,FieldByName('DataDecorrenza').AsDateTime);
          if (DataFine + 1) > FieldByName('DataFine').AsDateTime then
          begin
            AggiornaFine(Progressivo,DataFine + 1,DataFine + 1);
            CambioFine:=True;
            DataFine:=DataFine + 1;
          end;
          CambioInizio:=True;
          DataInizio:=DataFine + 1;
        end;
      end;
      //Salvo i dati per gestire l'allineamento successivamente
      if not CambioInizio then
        DataInizio:=FieldByName('DataDecorrenza').AsDateTime;
      if not CambioFine then
        DataFine:=FieldByName('DataFine').AsDateTime;
      Next;
    end;
  end;
end;


procedure TA044FAllineaStoriciMW.AllineamentoPrimaDecorrenza(Progressivo:LongInt);
begin
  with scrT430_P430 do
  begin
    SetVariable('Progressivo',Progressivo);
    Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA044FAllineaStoriciMW.AggiornaInizio(Prog:LongInt; NewInizio,OldInizio:TDateTime);
begin
  with updT430B do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('Data',NewInizio);
    SetVariable('DataDecorrenza',OldInizio);
    Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TA044FAllineaStoriciMW.AggiornaFine(Prog:LongInt; Decorrenza,Fine:TDateTime);
begin
  with updT430 do
  begin
    SetVariable('Progressivo',Prog);
    SetVariable('DataDecorrenza',Decorrenza);
    SetVariable('DataFine',Fine);
    Execute;
    SessioneOracle.Commit;
  end;
end;

function TA044FAllineaStoriciMW.OttimizzazionePeriodi(Progressivo:LongInt;Presenze,AssLiberaPresenze,Stipendi,AssLiberaStipendi: Boolean) : String;
//Esecuzione dell'allineamento dei periodi storici per compattare quelli uguali ed inserire i
//periodi derivanti dalla storicizzazione dei dati liberi.
begin
  Result:='';
  if Presenze then
  begin
    scrT430.SetVariable('Progressivo',Progressivo);
    scrT430.SetVariable('AssLibera',IfThen(AssLiberaPresenze,'S','N'));
    scrT430.Execute;
    //Segnalazione errore di dipendente occupato
    if VarToStr(scrT430.GetVariable('Errore')) = 'OC' then
    begin
      Result:=A000MSG_A044_ERR_DIP_IN_USO;
      Exit;
    end;
  end;
  if Stipendi then
  begin
    scrP430.SetVariable('Progressivo',Progressivo);
    scrP430.SetVariable('AssLibera',IfThen(AssLiberaStipendi,'S','N'));
    scrP430.Execute;
    //Segnalazione errore di dipendente occupato
    if VarToStr(scrP430.GetVariable('Errore')) = 'OC' then
      Result:=A000MSG_A044_ERR_DIP_IN_USO;
  end;
end;
end.
