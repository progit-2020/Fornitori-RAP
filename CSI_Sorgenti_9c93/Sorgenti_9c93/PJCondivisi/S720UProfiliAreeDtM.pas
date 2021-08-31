unit S720UProfiliAreeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData,
  C180FunzioniGenerali, A000UCostanti, A000USessione, A000UInterfaccia, Oracle;

type
  TS720FProfiliAreeDtM = class(TR004FGestStoricoDtM)
    selSG720: TOracleDataSet;
    selSG720DECORRENZA: TDateTimeField;
    selSG720DECORRENZA_FINE: TDateTimeField;
    selSG720DATO1: TStringField;
    selSG720DATO2: TStringField;
    selSG720DATO3: TStringField;
    selSG720COD_AREA: TStringField;
    selSG720DESC_DATO1: TStringField;
    selSG720DESC_DATO2: TStringField;
    selSG720DESC_DATO3: TStringField;
    selSG720DESCRIZIONE: TStringField;
    selDato1: TOracleDataSet;
    dsrDato1: TDataSource;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    dsrDato2: TDataSource;
    dsrDato3: TDataSource;
    selArea: TOracleDataSet;
    dsrArea: TDataSource;
    selSG720a: TOracleQuery;
    selDato4: TOracleDataSet;
    dsrDato4: TDataSource;
    selSG720DATO4: TStringField;
    selSG720DESC_DATO4: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S720FProfiliAreeDtM: TS720FProfiliAreeDtM;

implementation

{$R *.dfm}

uses
  S720UProfiliAree;

procedure TS720FProfiliAreeDtM.BeforePost(DataSet: TDataSet); 
begin
  if selSG720.FieldByName('COD_AREA').IsNull then
    raise Exception.Create('Selezionare l''area di valutazione!');
  if selSG720.FieldByName('DATO1').IsNull
     and (   not selSG720.FieldByName('DATO2').IsNull
          or not selSG720.FieldByName('DATO3').IsNull
          or not selSG720.FieldByName('DATO4').IsNull) then
    raise Exception.Create('Specificare il primo livello anagrafico!');
  if selSG720.FieldByName('DATO2').IsNull
     and (   not selSG720.FieldByName('DATO3').IsNull
          or not selSG720.FieldByName('DATO4').IsNull) then
    raise Exception.Create('Specificare il secondo livello anagrafico!');
  if selSG720.FieldByName('DECORRENZA').AsDateTime > selSG720.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise Exception.Create('La decorrenza non può essere successiva alla scadenza!');
  with selSG720a do
  begin
    SetVariable('DATO1',selSG720.FieldByName('DATO1').AsString);
    SetVariable('DATO2',selSG720.FieldByName('DATO2').AsString);
    SetVariable('DATO3',selSG720.FieldByName('DATO3').AsString);
    SetVariable('DATO4',selSG720.FieldByName('DATO4').AsString);
    SetVariable('COD_AREA',selSG720.FieldByName('COD_AREA').AsString);
    if selSG720.State in [dsEdit] then
      SetVariable('COND_ROWID',' and rowid <> ''' + selSG720.RowId + ''' ')
    else
      SetVariable('COND_ROWID','');
    SetVariable('DECORRENZA',selSG720.FieldByName('DECORRENZA').AsDateTime);
    SetVariable('SCADENZA',selSG720.FieldByName('DECORRENZA_FINE').AsDateTime);
    Execute;
    if Field(0) > 0 then
      raise Exception.Create('Impossibile effettuare l''inserimento! Le date specificate intersecano periodi già esistenti!');
  end;
  if selSG720.State in [dsInsert] then
  begin
    if selSG720.FieldByName('DATO1').AsString = '' then
      selSG720.FieldByName('DATO1').AsString:=' ';
    if selSG720.FieldByName('DATO2').AsString = '' then
      selSG720.FieldByName('DATO2').AsString:=' ';
    if selSG720.FieldByName('DATO3').AsString = '' then
      selSG720.FieldByName('DATO3').AsString:=' ';
    if selSG720.FieldByName('DATO4').AsString = '' then
      selSG720.FieldByName('DATO4').AsString:=' ';
  end;
  inherited;
end;

procedure TS720FProfiliAreeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=S720FProfiliAree.InterfacciaR004;
  InterfacciaR004.OttimizzaDecorrenzaFine:=False;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  InizializzaDataSet(selSG720,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  //Inserisco i campi lookup della tabella
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv1,selDato1) then
  begin
    if selDato1.VariableIndex('DECORRENZA') >= 0 then
      selDato1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selDato1.Open;
    selSG720DESC_DATO1.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv1)));
    S720FProfiliAree.lblDato1.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv1,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv1)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO1.Visible:=FALSE;
    selSG720DESC_DATO1.Visible:=FALSE;

    selSG720DESC_DATO1.FieldKind:=fkCalculated;
    selSG720DESC_DATO1.LookupDataSet:=nil;
    selSG720DESC_DATO1.KeyFields:='';
    selSG720DESC_DATO1.LookupResultField:='';

    S720FProfiliAree.dgrdProfiliAree.Columns[2].Visible:=FALSE;
    S720FProfiliAree.dgrdProfiliAree.Columns[3].Visible:=FALSE;
    S720FProfiliAree.lblDato1.Caption:='Dato 1 non definito';
    S720FProfiliAree.lblDato1.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv2,selDato2) then
  begin
    if selDato2.VariableIndex('DECORRENZA') >= 0 then
      selDato2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selDato2.Open;
    selSG720DESC_DATO2.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv2)));
    S720FProfiliAree.lblDato2.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv2,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv2)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO2.Visible:=FALSE;
    selSG720DESC_DATO2.Visible:=FALSE;

    selSG720DESC_DATO2.FieldKind:=fkCalculated;
    selSG720DESC_DATO2.LookupDataSet:=nil;
    selSG720DESC_DATO2.KeyFields:='';
    selSG720DESC_DATO2.LookupResultField:='';

    S720FProfiliAree.dgrdProfiliAree.Columns[4].Visible:=FALSE;
    S720FProfiliAree.dgrdProfiliAree.Columns[5].Visible:=FALSE;
    S720FProfiliAree.lblDato2.Caption:='Dato 2 non definito';
    S720FProfiliAree.lblDato2.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv3,selDato3) then
  begin
    if selDato3.VariableIndex('DECORRENZA') >= 0 then
      selDato3.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selDato3.Open;
    selSG720DESC_DATO3.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv3)));
    S720FProfiliAree.lblDato3.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv3,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv3)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO3.Visible:=FALSE;
    selSG720DESC_DATO3.Visible:=FALSE;

    selSG720DESC_DATO3.FieldKind:=fkCalculated;
    selSG720DESC_DATO3.LookupDataSet:=nil;
    selSG720DESC_DATO3.KeyFields:='';
    selSG720DESC_DATO3.LookupResultField:='';

    S720FProfiliAree.dgrdProfiliAree.Columns[6].Visible:=FALSE;
    S720FProfiliAree.dgrdProfiliAree.Columns[7].Visible:=FALSE;
    S720FProfiliAree.lblDato3.Caption:='Dato 3 non definito';
    S720FProfiliAree.lblDato3.Enabled:=False;
  end;
  //////
  if A000LookupTabella(Parametri.CampiRiferimento.C21_ValutazioniLiv4,selDato4) then
  begin
    if selDato4.VariableIndex('DECORRENZA') >= 0 then
      selDato4.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selDato4.Open;
    selSG720DESC_DATO4.DisplayLabel:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,1,1)) +
                                     LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv4)));
    S720FProfiliAree.lblDato4.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,1,1)) +
                                       LowerCase(Copy(Parametri.CampiRiferimento.C21_ValutazioniLiv4,2,length(Parametri.CampiRiferimento.C21_ValutazioniLiv4)));
  end
  else
  begin
    //Nascondo le colonne e imposto di tipo fkData il campo CODICE per non eseguire la select di lookup
    selSG720DATO4.Visible:=FALSE;
    selSG720DESC_DATO4.Visible:=FALSE;

    selSG720DESC_DATO4.FieldKind:=fkCalculated;
    selSG720DESC_DATO4.LookupDataSet:=nil;
    selSG720DESC_DATO4.KeyFields:='';
    selSG720DESC_DATO4.LookupResultField:='';

    S720FProfiliAree.dgrdProfiliAree.Columns[8].Visible:=FALSE;
    S720FProfiliAree.dgrdProfiliAree.Columns[9].Visible:=FALSE;
    S720FProfiliAree.lblDato4.Caption:='Dato 4 non definito';
    S720FProfiliAree.lblDato4.Enabled:=False;
  end;
  selSG720.Open;
  S720FProfiliAree.DButton.DataSet:=selSG720;
  selArea.Open;
end;

procedure TS720FProfiliAreeDtM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  selSG720.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
end;

end.
