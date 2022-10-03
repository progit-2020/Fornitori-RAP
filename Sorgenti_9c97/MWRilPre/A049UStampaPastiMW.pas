unit A049UStampaPastiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData,USelI010,A000UInterfaccia, R300UAccessiMensaDtM,
  DBClient, A000UCostanti, A000USessione;

type
  TA049FStampaPastiMW = class(TR005FDataModuleMW)
    selT361: TOracleDataSet;
    selT361CODICE: TStringField;
    selT361DESCRIZIONE: TStringField;
    dsr010: TDataSource;
    TabellaStampa: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selI010: TselI010;
  public
    R300FAccessiMensaDtM:TR300FAccessiMensaDtM;
    procedure CreaTabellaStampa;
    procedure InserisciDipendente(selAnag: TOracleDataSet; Raggr: String);
  end;

implementation

{$R *.dfm}

procedure TA049FStampaPastiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  Dsr010.DataSet:=selI010;

  selT361.Open;
  R300FAccessiMensaDtM:=TR300FAccessiMensaDtM.Create(Self);
  CreaTabellaStampa;
end;

procedure TA049FStampaPastiMW.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Raggruppamento',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Causale',ftString,5,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('PastiCon',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('PastiInt',ftInteger,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Raggruppamento;Cognome;Nome;Badge;Progressivo;Causale'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA049FStampaPastiMW.InserisciDipendente(selAnag: TOracleDataSet; Raggr:String);
var
  i: Integer;
begin
  for i:=0 to High(R300FAccessiMensaDtM.PastiTot) do
  begin
    if (R300FAccessiMensaDtM.PastiTot[i].Conv > 0) or (R300FAccessiMensaDtM.PastiTot[i].Interi > 0) then
    begin
      TabellaStampa.Insert;
      if (Raggr <> null) and (Raggr <> '') then
        TabellaStampa.FieldByName('Raggruppamento').AsString:=selAnag.FieldByName(raggr).AsString
      else
        TabellaStampa.FieldByName('Raggruppamento').AsString:='';
      TabellaStampa.FieldByName('Progressivo').AsInteger:=selAnag.FieldByName('Progressivo').AsInteger;
      TabellaStampa.FieldByName('Badge').Value:=selAnag.FieldByName('T430Badge').AsInteger;
      TabellaStampa.FieldByName('Matricola').Value:=selAnag.FieldByName('Matricola').AsString;
      TabellaStampa.FieldByName('Cognome').AsString:=selAnag.FieldByName('Cognome').AsString;
      TabellaStampa.FieldByName('Nome').AsString:=selAnag.FieldByName('Nome').AsString;
      TabellaStampa.FieldByName('Causale').AsString:=R300FAccessiMensaDtM.PastiTot[i].Causale;
      TabellaStampa.FieldByName('PastiCon').AsInteger:=R300FAccessiMensaDtM.PastiTot[i].Conv;
      TabellaStampa.FieldByName('PastiInt').AsInteger:=R300FAccessiMensaDtM.PastiTot[i].Interi;
      TabellaStampa.Post;
    end;
  end;
end;

procedure TA049FStampaPastiMW.DataModuleDestroy(Sender: TObject);
begin
  selT361.Close;
  FreeAndNil(selI010);
  FreeAndNil(R300FAccessiMensaDtM);
  TabellaStampa.Close;
  inherited;
end;

end.
