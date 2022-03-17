unit A141URegoleRiposiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali,A000UMessaggi;

type
  TA141FRegoleRiposiDtM = class(TR004FGestStoricoDtM)
    selT267: TOracleDataSet;
    selT265: TOracleDataSet;
    selT275: TOracleDataSet;
    selT275CODICE: TStringField;
    selT275DESCRIZIONE: TStringField;
    selT275ORENORMALI: TStringField;
    DCausale1: TDataSource;
    DCausale2: TDataSource;
    QCausale1: TOracleDataSet;
    QCausale1T265CODICE: TStringField;
    QCausale1T265DESCRIZIONE: TStringField;
    QCausale1T265CODRAGGR: TStringField;
    QCausale2: TOracleDataSet;
    QCausale2T265CODICE: TStringField;
    QCausale2T265DESCRIZIONE: TStringField;
    QCausale2T265CODRAGGR: TStringField;
    QCausale3: TOracleDataSet;
    QCausale3T265CODICE: TStringField;
    QCausale3T265DESCRIZIONE: TStringField;
    QCausale3T265CODRAGGR: TStringField;
    DCausale3: TDataSource;
    selInterfaccia: TOracleDataSet;
    dsrInterfaccia: TDataSource;
    DCausale4: TDataSource;
    QCausale4: TOracleDataSet;
    QCausale4T265CODICE: TStringField;
    QCausale4T265DESCRIZIONE: TStringField;
    procedure selT275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QCausale1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT267AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A141FRegoleRiposiDtM: TA141FRegoleRiposiDtM;

implementation

uses A141URegoleRiposi, CheckLst;

{$R *.dfm}

procedure TA141FRegoleRiposiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT267,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT265.Open;
  selT275.Open;
  QCausale1.Open;
  QCausale2.Open;
  QCausale3.Open;
  QCausale4.Open;
  selInterfaccia.SQL.Clear;
  if A000LookupTabella(Parametri.CampiRiferimento.C16_INSRIPOSI,selInterfaccia) then
  begin
    if selInterfaccia.VariableIndex('DECORRENZA') >= 0 then
      selInterfaccia.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selInterfaccia.Open;
  end
  else
    A141FRegoleRiposi.lblInterfaccia.Caption:='<INTERFACCIA UNICA>';
//    raise Exception.Create('Dato PROVVEDIMENTI/INCARICHI:SEDE non specificato in AZIENDE/Gestione moduli!');
end;

procedure TA141FRegoleRiposiDtM.BeforePostNoStorico(DataSet: TDataSet);
var i:Integer;
  S:String;
begin
  inherited;
  with A141FRegoleRiposi do
  begin
    if dCmbCausale1.KeyValue = null then
      raise Exception.Create('Selezionare la causale di Riposo!');
    // Controllo 'tipo giustificativo' con 'unità di misura inserimento' della causale
    if VarToStr(selT265.Lookup('CODICE',dCmbCausale1.Text,'UM_INSERIMENTO')) = 'N' then
      raise Exception.Create(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[dCmbCausale1.Text]));
    if VarToStr(selT265.Lookup('CODICE',dCmbCausale2.Text,'UM_INSERIMENTO')) = 'N' then
      raise Exception.Create(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[dCmbCausale2.Text]));
    if VarToStr(selT265.Lookup('CODICE',dCmbCausale3.Text,'UM_INSERIMENTO')) = 'N' then
      raise Exception.Create(Format(A000MSG_A141_ERR_FMT_GIUST_NO_GIORN,[dCmbCausale3.Text]));
    if (selT267.FieldByName('TIPO_CAUSALE').AsString = 'R') and (VarToStr(selT265.Lookup('CODICE',dCmbCausale1.Text,'CODINTERNO')) <> 'H') then
      if R180MessageBox(A000MSG_A141_DLG_NO_RIPOSO,'DOMANDA') <> mrYes then
        Abort;
    if (selT267.FieldByName('TIPO_CAUSALE').AsString = 'R') and (Trim(dCmbCausale2.Text) <> '') and
       (VarToStr(selT265.Lookup('CODICE',dCmbCausale2.Text,'CODINTERNO')) <> 'H') and
       (VarToStr(selT265.Lookup('CODICE',dCmbCausale2.Text,'CODINTERNO')) <> 'E') then
      if R180MessageBox(A000MSG_A141_DLG_NO_RIPOSO_COMP,'DOMANDA') <> mrYes then
        Abort;
    if lblInterfaccia.Caption = '<INTERFACCIA UNICA>' then
      selT267.FieldByName('CODICE').AsString:='<UNICA>';
    S:='';
    for i:=0 to lstPresenze.Count - 1 do
    begin
      if lstPresenze.Checked[i] then
      begin
        if Trim(S) <> '' then
          S:=S + ',';
        S:=S + Trim(Copy(lstPresenze.Items[i],1,5));
      end;
    end;
    selT267.FieldByName('CAUS_PRESENZA_TOLLERATE').AsString:=S;
    S:='';
    for i:=0 to lstAssenze.Count - 1 do
    begin
      if lstAssenze.Checked[i] then
      begin
        if Trim(S) <> '' then
          S:=S + ',';
        S:=S + Trim(Copy(lstAssenze.Items[i],1,5));
      end;
    end;
    selT267.FieldByName('CAUS_ASSENZA_NONTOLLERATE').AsString:=S;
  end;
end;

procedure TA141FRegoleRiposiDtM.selT267AfterScroll(DataSet: TDataSet);
var i:Integer;
  lstAppoggio:TStringList;
begin
  inherited;
  lstAppoggio:=TStringList.Create;
  with A141FRegoleRiposi do
  begin
    lstAppoggio.Clear;
    lstAppoggio.CommaText:=selT267.FieldByName('CAUS_PRESENZA_TOLLERATE').AsString;
    for i:=0 to lstPresenze.Count - 1 do
      lstPresenze.Checked[i]:=False;
    for i:=0 to lstPresenze.Count - 1 do
    begin
      if lstAppoggio.IndexOf(Trim(Copy(lstPresenze.Items[i],1,5))) >= 0 then
        lstPresenze.Checked[i]:=True;
    end;
    lstAppoggio.Clear;
    lstAppoggio.CommaText:=selT267.FieldByName('CAUS_ASSENZA_NONTOLLERATE').AsString;
    for i:=0 to lstAssenze.Count - 1 do
      lstAssenze.Checked[i]:=False;
    for i:=0 to lstAssenze.Count - 1 do
    begin
      if lstAppoggio.IndexOf(Trim(Copy(lstAssenze.Items[i],1,5))) >= 0 then
        lstAssenze.Checked[i]:=True;
    end;
    dCmbCodiceCloseUp(nil);
    dCmbCausale1CloseUp(nil);
    dCmbCausale2CloseUp(nil);
    dCmbCausale3CloseUp(nil);
    dcmbRiposoLavoratoCloseUp(nil);
    drdgTipoClick(nil);
  end;
  FreeAndNil(lstAppoggio);
end;

procedure TA141FRegoleRiposiDtM.QCausale1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  //Filtro dizionario
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('T265CODICE').AsString);
end;

procedure TA141FRegoleRiposiDtM.selT265FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  //Filtro dizionario
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA141FRegoleRiposiDtM.selT275FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  //Filtro dizionario
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

end.
