unit A076UIndGruppoMW;

interface

uses
  Windows, Messages, SysUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, OracleData, A000UMessaggi, A000USessione, A000UInterfaccia,
  OracleMonitor;

type
  TA076FIndGRuppoMW = class(TR005FDataModuleMW)
    Q163: TOracleDataSet;
    selCodice2: TOracleDataSet;
    selCodice1: TOracleDataSet;
    selT161: TOracleDataSet;
    procedure selCodice2AfterOpen(DataSet: TDataSet);
  private
    {private}
  public
    Q161:TOracleDataSet;
    procedure InizializzaTabella;
    procedure Q161CODICEValidate(Sender: TField);
    procedure BDEQ161INDENNITAValidate(Sender: TField);
  end;

implementation

{$R *.dfm}

procedure TA076FIndGRuppoMW.InizializzaTabella;
  function FormattaNome(InNome:String):String;
  var
    i:Integer;
  begin
    InNome:=Trim(InNome);
    Result:='';
    for i:=1 to Length(InNome) do
      if (i = 1) or (copy(InNome,i - 1,1) = ' ') then
        Result:=Result + UpperCase(copy(InNome,i,1))
      else
        Result:=Result + LowerCase(copy(InNome,i,1));
  end;
begin
  inherited;
  SelCodice1.SQL.Clear;
  SelCodice2.SQL.Clear;
  //Primo livello
  if A000LookupTabella(Parametri.CampiRiferimento.C3_IndPres,SelCodice1) then
  begin
    if SelCodice1.VariableIndex('DECORRENZA') >= 0 then
      SelCodice1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
  end
  else
    SelCodice1.SQL.Add('SELECT NULL CODICE, NULL DESCRIZIONE FROM DUAL');
  //Secondo livello
  if (Parametri.CampiRiferimento.C3_IndPres2 <> '') and
     (Parametri.CampiRiferimento.C3_IndPres2 <> Parametri.CampiRiferimento.C3_IndPres) then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C3_IndPres2,SelCodice2) then
    begin
      if SelCodice2.VariableIndex('DECORRENZA') >= 0 then
        SelCodice2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    end
    else
      SelCodice2.SQL.Add('SELECT ''*'' CODICE, NULL DESCRIZIONE FROM DUAL');
  end
  else
    SelCodice2.SQL.Add('SELECT ''*'' CODICE, NULL DESCRIZIONE FROM DUAL');
  SelCodice1.Open;
  SelCodice2.Open;
  Q163.Open;
  Q161.Open;
  Q161.FieldByName('CODICE').DisplayLabel:=FormattaNome(Parametri.CampiRiferimento.C3_IndPres);
  Q161.FieldByName('CODICE2').DisplayLabel:=FormattaNome(Parametri.CampiRiferimento.C3_IndPres2);
  Q161.FieldByName('INDENNITA').DisplayLabel:='Indennità';
  selT161.Open;
end;

procedure TA076FIndGRuppoMW.BDEQ161INDENNITAValidate(Sender: TField);
begin
  if not Q163.Locate('Codice',Sender.AsString,[]) then
    raise Exception.Create('Indennità non valida!');
end;

procedure TA076FIndGRuppoMW.Q161CODICEValidate(Sender: TField);
var DS:TDataSet;
begin
  inherited;
  if (Sender.AsString <> '') and (Sender.AsString <> '*') then
  begin
    if UpperCase(Sender.FieldName) = 'CODICE' then
      DS:=selCodice1
    else
      DS:=selCodice2;
    if VarToStr(DS.Lookup('CODICE',Sender.AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_ERR_FMT_NON_ESISTENTE,[Sender.DisplayLabel]));
  end;
end;

procedure TA076FIndGRuppoMW.selCodice2AfterOpen(DataSet: TDataSet);
var LC,LD:Integer;
begin
  inherited;
  LC:=2;
  LD:=2;
  while not DataSet.Eof do
  begin
    LC:=Max(LC,Length(Trim(DataSet.FieldByName('CODICE').AsString)));
    LD:=Max(LD,Length(Trim(DataSet.FieldByName('DESCRIZIONE').AsString)));
    DataSet.Next;
  end;
  LC:=Round(LC * 1.4) + 2;
  LD:=Min(100,Round(LD * 1.4) + 2);
  if DataSet = selCodice1 then
  begin
    Q161.FieldByName('CODICE').DisplayWidth:=LC;
    Q161.FieldByName('D_DESCCODICE').DisplayWidth:=LD;
  end
  else
  begin
    Q161.FieldByName('CODICE2').DisplayWidth:=LC;
    Q161.FieldByName('D_DESCCODICE2').DisplayWidth:=LD;
  end;
end;

end.
