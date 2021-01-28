unit A054UCicliTurniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, Variants, A000UInterfaccia;

type
  TA054FCicliTurniMW = class(TR005FDataModuleMW)
    Q611CancellaCiclo: TOracleQuery;
    Q611AggiornaCiclo: TOracleQuery;
    Q265: TOracleDataSet;
    Q021: TOracleDataSet;
    Q020: TOracleDataSet;
    Q611: TOracleDataSet;
    Q611CICLO: TStringField;
    Q611GIORNO: TFloatField;
    Q611TURNO1: TStringField;
    Q611numturno1: TStringField;
    Q611siglaturno1: TStringField;
    Q611entrata1: TStringField;
    Q611uscita1: TStringField;
    Q611TURNO1EU: TStringField;
    Q611TURNO2: TStringField;
    Q611numturno2: TStringField;
    Q611siglaturno2: TStringField;
    Q611entrata2: TStringField;
    Q611uscita2: TStringField;
    Q611TURNO2EU: TStringField;
    Q611ORARIO: TStringField;
    Q611CAUSALE: TStringField;
    D611: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure Q611BeforePost(DataSet: TDataSet);
    procedure Q611CalcFields(DataSet: TDataSet);
    procedure Q611NewRecord(DataSet: TDataSet);
    procedure Q611ORARIOValidate(Sender: TField);
    procedure Q611CAUSALEValidate(Sender: TField);
    procedure Q611TURNO1Validate(Sender: TField);
    procedure Q611TURNO2Validate(Sender: TField);
    procedure D611DataChange(Sender: TObject; Field: TField);
    procedure Q611TURNO1SetText(Sender: TField; const Text: string);
    procedure Q611BeforeEdit(DataSet: TDataSet);
  private
    procedure ValidaOrario(Codice: String);
    procedure ValidaCausaleAssenza(Causale: String);
    procedure SettaCampiReadOnlyQ611;
  public
    Q610: TOracleDataSet;
    procedure BeforePost;
    procedure BeforeDelete;
    procedure BeforeInsert;
    procedure SettaGiornoProgressivo(Inizio:Word);
  end;

implementation

{$R *.dfm}

procedure TA054FCicliTurniMW.DataModuleCreate(Sender: TObject);
begin
  Q611.SetVariable('ORDERBY','ORDER BY GIORNO');
  inherited;
  Q020.Open;
  Q021.Open;
  Q265.Open;
end;

procedure TA054FCicliTurniMW.D611DataChange(Sender: TObject; Field: TField);
begin
  if (Field = nil) then
    SettaCampiReadOnlyQ611;
end;

procedure TA054FCicliTurniMW.Q611BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  SettaCampiReadOnlyQ611;
end;

procedure TA054FCicliTurniMW.SettaCampiReadOnlyQ611;
begin
  Q611TURNO2.ReadOnly:=(Q611TURNO1.AsString = '') or (Q611TURNO1.AsString = 'M') or (Q611TURNO1.AsString = 'A');
  Q611TURNO2EU.ReadOnly:=Q611TURNO2.ReadOnly;
  Q611TURNO1EU.ReadOnly:=Q611TURNO1.AsString = 'M';
end;

procedure TA054FCicliTurniMW.Q611BeforePost(DataSet: TDataSet);
{Prevengo l'inserimento di un record nullo}
begin
  if (Q611TURNO1.AsString = '') and (Q611TURNO2.AsString = '') and
     (Q611ORARIO.AsString = '') and (Q611CAUSALE.AsString = '') then
    Abort;
  if (Q611TURNO1.AsString = 'A') and (not Q611ORARIO.ReadOnly) then
    Q611ORARIO.Clear;
  if (Q611Turno1EU.AsString <> '') and ((Q611TURNO1.AsString <= '0') or (Q611TURNO1.AsString > '99')) then
    Q611Turno1EU.Clear;
  if (Q611Turno2EU.AsString <> '') and ((Q611TURNO2.AsString <= '0') or (Q611TURNO2.AsString > '99')) then
    Q611Turno2EU.Clear;
  if (Q611TURNO1.AsString <> '') and (Q611TURNO1.AsString <> 'M') and (Q611TURNO1.AsString <> 'A') then
    Q611TURNO1.AsString:=IntToStr(StrToInt(Q611TURNO1.AsString));
  if (Q611TURNO2.AsString <> '') and (Q611TURNO2.AsString <> 'M') and (Q611TURNO2.AsString <> 'A') then
    Q611TURNO2.AsString:=IntToStr(StrToInt(Q611TURNO2.AsString));
  if (Q611.FieldByName('TURNO1').AsString = Q611.FieldByName('TURNO2').AsString) and
     (Not Q611.FieldByName('TURNO1').IsNull) then
    if ((Not Q611.FieldByName('TURNO1EU').IsNull) xor (Not Q611.FieldByName('TURNO2EU').IsNull)) or
       (Q611.FieldByName('TURNO1EU').AsString = Q611.FieldByName('TURNO2EU').AsString) then
      Raise Exception.Create('Errore!Due turni in un giorno non possono avere lo stesso verso d''entrata.');
end;

procedure TA054FCicliTurniMW.Q611CalcFields(DataSet: TDataSet);
var
  bTrovato: boolean;
  nFascia: integer;
begin
  DataSet.FieldByName('numturno1').Clear;
  DataSet.FieldByName('siglaturno1').Clear;
  DataSet.FieldByName('entrata1').Clear;
  DataSet.FieldByName('uscita1').Clear;
  DataSet.FieldByName('numturno2').Clear;
  DataSet.FieldByName('siglaturno2').Clear;
  DataSet.FieldByName('entrata2').Clear;
  DataSet.FieldByName('uscita2').Clear;
  if DataSet.FieldByName('orario').AsString <> '' then
  begin
    //valorizzo i dati calcolati relativi al primo turno
    if (DataSet.FieldByName('turno1').AsString <> '') and
       (DataSet.FieldByName('turno1').AsString <> 'M') and
       (DataSet.FieldByName('turno1').AsString <> '0') and
       (DataSet.FieldByName('turno1').AsString <> 'A') then
    begin
      bTrovato:=Q021.SearchRecord('CODICE', DataSet.FieldByName('orario').AsString, [srFromBeginning]);
      if bTrovato then
      begin
        nFascia:=1;
        while (nFascia < DataSet.FieldByName('turno1').asInteger) and (not Q021.Eof) do
        begin
          Q021.Next;
          nFascia:=nFascia+1;
        end;
      end;
      bTrovato:=Q021.FieldByName('CODICE').AsString=DataSet.FieldByName('orario').AsString;
      if bTrovato then
      begin
        DataSet.FieldByName('numturno1').AsString:=Q021.FieldByName('numturno').AsString;
        DataSet.FieldByName('siglaturno1').AsString:=Q021.FieldByName('siglaturni').AsString;
        DataSet.FieldByName('entrata1').AsString:=Q021.FieldByName('entrata').AsString;
        DataSet.FieldByName('uscita1').AsString:=Q021.FieldByName('uscita').AsString;
      end;
    end;
    //valorizzo i dati calcolati relativi al secondo turno
    if (DataSet.FieldByName('turno2').AsString <> '') and
       (DataSet.FieldByName('turno2').AsString <> 'M') and
       (DataSet.FieldByName('turno2').AsString <> '0') and
       (DataSet.FieldByName('turno2').AsString <> 'A') then
    begin
      bTrovato:=Q021.SearchRecord('CODICE', DataSet.FieldByName('orario').AsString, [srFromBeginning]);
      if bTrovato then
      begin
        nFascia:=1;
        while (nFascia < DataSet.FieldByName('turno2').asInteger) and (not Q021.Eof) do
        begin
          Q021.Next;
          nFascia:=nFascia+1;
        end;
      end;
      bTrovato:=Q021.FieldByName('CODICE').AsString=DataSet.FieldByName('orario').AsString;
      if bTrovato then
      begin
        DataSet.FieldByName('numturno2').AsString:=Q021.FieldByName('numturno').AsString;
        DataSet.FieldByName('siglaturno2').AsString:=Q021.FieldByName('siglaturni').AsString;
        DataSet.FieldByName('entrata2').AsString:=Q021.FieldByName('entrata').AsString;
        DataSet.FieldByName('uscita2').AsString:=Q021.FieldByName('uscita').AsString;
      end;
    end;
  end;
end;

procedure TA054FCicliTurniMW.Q611CAUSALEValidate(Sender: TField);
begin
  ValidaCausaleAssenza(Sender.AsString);
end;

procedure TA054FCicliTurniMW.Q611NewRecord(DataSet: TDataSet);
begin
  Q611Ciclo.AsString:=Q610.FieldByName('Codice').AsString;
end;

procedure TA054FCicliTurniMW.Q611ORARIOValidate(Sender: TField);
begin
  ValidaOrario(Sender.AsString);
  if Q611TURNO1.AsString = '' then
    Q611TURNO1.AsString:='M';
end;

procedure TA054FCicliTurniMW.Q611TURNO1SetText(Sender: TField; const Text: string);
begin
  Sender.AsString:=Trim(Copy(Text,1,2));
end;

procedure TA054FCicliTurniMW.Q611TURNO1Validate(Sender: TField);
begin
  Q611ORARIO.ReadOnly:=False;
  if Sender.AsString = '' then
  begin
    if not Q611TURNO2.ReadOnly then
      Q611TURNO2.Clear;
    Q611TURNO2.ReadOnly:=True;
    Q611TURNO2EU.ReadOnly:=True;
    exit;
  end;
  if Sender.AsString = 'M' then
  //Solo modello orario
  begin
    if not Q611TURNO2.ReadOnly then
      Q611TURNO2.Clear;
    Q611TURNO2.ReadOnly:=True;
    Q611TURNO2EU.ReadOnly:=True;
    exit;
  end;
  if Sender.AsString = 'A' then
  //Assenza
  begin
    if not Q611TURNO2.ReadOnly then
      Q611TURNO2.Clear;
    if not Q611ORARIO.ReadOnly then
      Q611ORARIO.Clear;
    Q611TURNO2.ReadOnly:=True;
    Q611TURNO2EU.ReadOnly:=True;
    Q611ORARIO.ReadOnly:=True;
    exit;
  end;
  if Sender.AsString = '0' then
  //Riposo
  begin
    if not Q611TURNO2.ReadOnly then
      Q611TURNO2.Clear;
    Q611TURNO2.ReadOnly:=True;
    Q611TURNO2EU.ReadOnly:=True;
    exit;
  end;

  if (StrToIntDef(Sender.AsString,-1) < 1) or (StrToIntDef(Sender.AsString,-1) > 99) then
    //Escludendo i turni speciali '0', 'M' ed 'A', i turni devono essere compresi tra 1 e 99
    raise Exception.Create('Il turno può solo assumere i seguenti valori: M, A, 0 ed i valori compresi tra 1 e 99!')
  else
  begin
    Q611TURNO2.ReadOnly:=False;
    Q611TURNO2EU.ReadOnly:=False;
  end;
end;

procedure TA054FCicliTurniMW.Q611TURNO2Validate(Sender: TField);
begin
  if Sender.AsString = '' then exit;
  if (StrToIntDef(Sender.AsString,-1) < 0) or (StrToIntDef(Sender.AsString,-1) > 99) then
    //Escludendo i turni speciali '0', 'M' ed 'A', i turni devono essere compresi tra 1 e 99
    raise Exception.Create('Il turno può solo assumere i seguenti valori: 0 ed i valori compresi tra 1 e 99!')
end;

procedure TA054FCicliTurniMW.ValidaCausaleAssenza(Causale: String);
begin
  if Causale = '' then exit;
  if Q265.Lookup('Codice',Causale,'Codice') = Null then
    raise Exception.Create('Assenza non valida!');
end;

procedure TA054FCicliTurniMW.ValidaOrario(Codice: String);
begin
  if Codice = '' then
    exit;
  if Q020.Lookup('Codice',Codice,'Codice') = Null then
    raise Exception.Create('Orario non valido!');
end;

procedure TA054FCicliTurniMW.SettaGiornoProgressivo(Inizio:Word);
{Assegno il progressivo al Giorno in modo da avere i cicli ordinati come sono stati inseriti}
var i:Word;
begin
  with Q611 do
  begin
    DisableControls;
    First;
    i:=Inizio;
    while not Eof do
    begin
      inc(i);
      Edit;
      FieldByName('Giorno').AsInteger:=i;
      Post;
      Next;
    end;
    First;
    EnableControls;
  end;
end;

procedure TA054FCicliTurniMW.BeforeDelete;
begin
  with Q611CancellaCiclo do
  begin
    SetVariable('Ciclo',Q610.FieldByName('Codice').AsString);
    Execute;
  end;
end;

procedure TA054FCicliTurniMW.BeforePost;
begin
  if QueryPK1.EsisteChiave('T610_CICLI',Q610.RowId,Q610.State,['CODICE'],[Q610.FieldByName('Codice').AsString]) then
    raise Exception.Create('Codice già esistente!');
  if Q610.State = dsEdit then
    if Q610.FieldByName('Codice').Value <> Q610.FieldByName('Codice').medpOldValue then
      with Q611AggiornaCiclo do
      begin
        SetVariable('Ciclo',Q610.FieldByName('Codice').Value);
        SetVariable('Ciclo_Old',Q610.FieldByName('Codice').medpOldValue);
        try
          Execute;
        except
          SessioneOracle.Rollback;
          raise;
        end;
      end;
end;

procedure TA054FCicliTurniMW.BeforeInsert;
begin
  Q611.Close;
end;

end.
