unit A172USchedeQuantIndividualiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, A000UCostanti, A000USessione, StrUtils, DBClient,
  C700USelezioneAnagrafe, A172USchedeQuantIndividualiMW, A000UMessaggi;

type
  TA172FSchedeQuantIndividualiDtM = class(TR004FGestStoricoDtM)
    selT767: TOracleDataSet;
    selT767ANNO: TFloatField;
    selT767CODGRUPPO: TStringField;
    selT767DESCRIZIONE: TStringField;
    selT767FILTRO_ANAGRAFE: TStringField;
    selT767CODTIPOQUOTA: TStringField;
    selT767NUMORE_TOTALE: TStringField;
    selT767IMPORTO_TOTALE: TFloatField;
    selT767DATARIF: TDateTimeField;
    selT767PAG1_PERC: TFloatField;
    selT767PAG1_MAX: TStringField;
    selT767PAG2_PERC: TFloatField;
    selT767PAG2_MAX: TStringField;
    selT767PAG3_PERC: TFloatField;
    selT767PAG3_MAX: TStringField;
    selT767PAG4_PERC: TFloatField;
    selT767PAG4_MAX: TStringField;
    selT767PAG5_PERC: TFloatField;
    selT767PAG5_MAX: TStringField;
    selT767PAG6_PERC: TFloatField;
    selT767PAG6_MAX: TStringField;
    selT767PAG7_PERC: TFloatField;
    selT767PAG7_MAX: TStringField;
    selT767PAG8_PERC: TFloatField;
    selT767PAG8_MAX: TStringField;
    selT767PAG9_PERC: TFloatField;
    selT767PAG9_MAX: TStringField;
    selT767PAG10_PERC: TFloatField;
    selT767PAG10_MAX: TStringField;
    selT767PAG11_PERC: TFloatField;
    selT767PAG11_MAX: TStringField;
    selT767PAG12_PERC: TFloatField;
    selT767PAG12_MAX: TStringField;
    dsrT765: TDataSource;
    selT767TOLLERANZA: TFloatField;
    selT767STATO: TStringField;
    selT767SUPERVISIONE: TStringField;
    selT767PROG_SUPERVISORE: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT767AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT767NewRecord(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT767FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT767ANNOValidate(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    AggT768,InsT768:Boolean;
    procedure RecuperaListaValutatori;
    procedure cdsT768AfterScroll(DataSet: TDataSet);
  public
    A172FSchedeQuantIndividualiMW: TA172FSchedeQuantIndividualiMW;
  end;

var
  A172FSchedeQuantIndividualiDtM: TA172FSchedeQuantIndividualiDtM;

implementation

uses A172USchedeQuantIndividuali;

{$R *.dfm}

procedure TA172FSchedeQuantIndividualiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT767,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A172FSchedeQuantIndividualiMW:=TA172FSchedeQuantIndividualiMW.Create(Self);
  A172FSchedeQuantIndividualiMW.SelT767_Funzioni:=selT767;
  A172FSchedeQuantIndividualiMW.cdsT768.AfterScroll:=cdsT768AfterScroll;

  dsrT765.dataset:=A172FSchedeQuantIndividualiMW.selT765;

  if Parametri.CampiRiferimento.C7_Dato1 = '' then
    raise exception.Create('Dato aziendale <INCENTIVI DATO1> non specificato!');
  A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[15].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato1,1,1)) +
                                         LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato1,2,length(Parametri.CampiRiferimento.C7_Dato1)));
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[16].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato2,1,1)) +
                                         LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato2,2,length(Parametri.CampiRiferimento.C7_Dato2)))
  else
    A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[16].Visible:=False;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[17].Title.Caption:=UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato3,1,1)) +
                                         LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato3,2,length(Parametri.CampiRiferimento.C7_Dato3)))
  else
    A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[17].Visible:=False;
  A172FSchedeQuantIndividuali.DButton.DataSet:=selT767;
  selT767.Open;
end;

procedure TA172FSchedeQuantIndividualiDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A172FSchedeQuantIndividualiMW);
end;

procedure TA172FSchedeQuantIndividualiDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A172FSchedeQuantIndividualiMW.selT767BeforePost(InsT768, AggT768);

  with A172FSchedeQuantIndividuali do
  begin
    selT767.FieldByName('PAG1_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[1,1]) = '.','',grdPagamenti.Cells[1,1]);
    selT767.FieldByName('PAG1_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[1,2]),-1);
    selT767.FieldByName('PAG2_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[2,1]) = '.','',grdPagamenti.Cells[2,1]);
    selT767.FieldByName('PAG2_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[2,2]),-1);
    selT767.FieldByName('PAG3_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[3,1]) = '.','',grdPagamenti.Cells[3,1]);
    selT767.FieldByName('PAG3_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[3,2]),-1);
    selT767.FieldByName('PAG4_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[4,1]) = '.','',grdPagamenti.Cells[4,1]);
    selT767.FieldByName('PAG4_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[4,2]),-1);
    selT767.FieldByName('PAG5_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[5,1]) = '.','',grdPagamenti.Cells[5,1]);
    selT767.FieldByName('PAG5_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[5,2]),-1);
    selT767.FieldByName('PAG6_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[6,1]) = '.','',grdPagamenti.Cells[6,1]);
    selT767.FieldByName('PAG6_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[6,2]),-1);
    selT767.FieldByName('PAG7_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[7,1]) = '.','',grdPagamenti.Cells[7,1]);
    selT767.FieldByName('PAG7_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[7,2]),-1);
    selT767.FieldByName('PAG8_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[8,1]) = '.','',grdPagamenti.Cells[8,1]);
    selT767.FieldByName('PAG8_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[8,2]),-1);
    selT767.FieldByName('PAG9_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[9,1]) = '.','',grdPagamenti.Cells[9,1]);
    selT767.FieldByName('PAG9_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[9,2]),-1);
    selT767.FieldByName('PAG10_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[10,1]) = '.','',grdPagamenti.Cells[10,1]);
    selT767.FieldByName('PAG10_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[10,2]),-1);
    selT767.FieldByName('PAG11_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[11,1]) = '.','',grdPagamenti.Cells[11,1]);
    selT767.FieldByName('PAG11_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[11,2]),-1);
    selT767.FieldByName('PAG12_MAX').AsString:=IfThen(Trim(grdPagamenti.Cells[12,1]) = '.','',grdPagamenti.Cells[12,1]);
    selT767.FieldByName('PAG12_PERC').AsFloat:=StrToFloatDef(Trim(grdPagamenti.Cells[12,2]),-1);
  end;
end;

procedure TA172FSchedeQuantIndividualiDtM.AfterPost(DataSet: TDataSet);
var
  Tot: Real;
  TotOre:Integer;
begin
  inherited;
  if selT767.RecordCount <= 0 then
    Exit;

  A172FSchedeQuantIndividualiMW.selT767AfterPost;

  if AggT768 then
    R180MessageBox(A000MSG_A172_MSG_DIPENDENTI_CAMBIATI,'INFORMA');

  if InsT768 then
  begin
    Screen.Cursor:=crHourGlass;
    A172FSchedeQuantIndividuali.btnAnomalie.Enabled:=False;
    InsT768:=False;
    A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Inizio(Tot,TotOre);

    A172FSchedeQuantIndividuali.ProgressBar1.Max:=A172FSchedeQuantIndividualiMW.selV430.RecordCount;
    A172FSchedeQuantIndividuali.ProgressBar1.Position:=0;
    A172FSchedeQuantIndividualiMW.selV430.First;
    while not A172FSchedeQuantIndividualiMW.selV430.Eof do
    begin
      A172FSchedeQuantIndividuali.ProgressBar1.StepBy(1);
      A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768ElaboraElemento(Tot,TotOre);
      A172FSchedeQuantIndividualiMW.selV430.Next;
    end;
    A172FSchedeQuantIndividualiMW.selT767AfterPostInsT768Fine(Tot,TotOre);

    Screen.Cursor:=crDefault;
    A172FSchedeQuantIndividuali.ProgressBar1.Position:=0;
    A172FSchedeQuantIndividuali.btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if RegistraMsg.ContieneTipoA then
      if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
        A172FSchedeQuantIndividuali.btnAnomalieClick(nil);
  end;
end;

procedure TA172FSchedeQuantIndividualiDtM.selT767AfterScroll(DataSet: TDataSet);
begin
  inherited;
  RecuperaListaValutatori;
  with A172FSchedeQuantIndividuali do
  begin
    dcmbTipoQuotaCloseUp(nil);
    dchkSupervisioneClick(nil);

    lblStato.Caption:=A172FSchedeQuantIndividualiMW.DescrizioneStato;
    Abilitazioni;
    grdPagamenti.Cells[1,1]:=selT767.FieldByName('PAG1_MAX').AsString;
    grdPagamenti.Cells[1,2]:=IfThen(selT767.FieldByName('PAG1_PERC').AsFloat = -1,'',selT767.FieldByName('PAG1_PERC').AsString);
    grdPagamenti.Cells[2,1]:=selT767.FieldByName('PAG2_MAX').AsString;
    grdPagamenti.Cells[2,2]:=IfThen(selT767.FieldByName('PAG2_PERC').AsFloat = -1,'',selT767.FieldByName('PAG2_PERC').AsString);
    grdPagamenti.Cells[3,1]:=selT767.FieldByName('PAG3_MAX').AsString;
    grdPagamenti.Cells[3,2]:=IfThen(selT767.FieldByName('PAG3_PERC').AsFloat = -1,'',selT767.FieldByName('PAG3_PERC').AsString);
    grdPagamenti.Cells[4,1]:=selT767.FieldByName('PAG4_MAX').AsString;
    grdPagamenti.Cells[4,2]:=IfThen(selT767.FieldByName('PAG4_PERC').AsFloat = -1,'',selT767.FieldByName('PAG4_PERC').AsString);
    grdPagamenti.Cells[5,1]:=selT767.FieldByName('PAG5_MAX').AsString;
    grdPagamenti.Cells[5,2]:=IfThen(selT767.FieldByName('PAG5_PERC').AsFloat = -1,'',selT767.FieldByName('PAG5_PERC').AsString);
    grdPagamenti.Cells[6,1]:=selT767.FieldByName('PAG6_MAX').AsString;
    grdPagamenti.Cells[6,2]:=IfThen(selT767.FieldByName('PAG6_PERC').AsFloat = -1,'',selT767.FieldByName('PAG6_PERC').AsString);
    grdPagamenti.Cells[7,1]:=selT767.FieldByName('PAG7_MAX').AsString;
    grdPagamenti.Cells[7,2]:=IfThen(selT767.FieldByName('PAG7_PERC').AsFloat = -1,'',selT767.FieldByName('PAG7_PERC').AsString);
    grdPagamenti.Cells[8,1]:=selT767.FieldByName('PAG8_MAX').AsString;
    grdPagamenti.Cells[8,2]:=IfThen(selT767.FieldByName('PAG8_PERC').AsFloat = -1,'',selT767.FieldByName('PAG8_PERC').AsString);
    grdPagamenti.Cells[9,1]:=selT767.FieldByName('PAG9_MAX').AsString;
    grdPagamenti.Cells[9,2]:=IfThen(selT767.FieldByName('PAG9_PERC').AsFloat = -1,'',selT767.FieldByName('PAG9_PERC').AsString);
    grdPagamenti.Cells[10,1]:=selT767.FieldByName('PAG10_MAX').AsString;
    grdPagamenti.Cells[10,2]:=IfThen(selT767.FieldByName('PAG10_PERC').AsFloat = -1,'',selT767.FieldByName('PAG10_PERC').AsString);
    grdPagamenti.Cells[11,1]:=selT767.FieldByName('PAG11_MAX').AsString;
    grdPagamenti.Cells[11,2]:=IfThen(selT767.FieldByName('PAG11_PERC').AsFloat = -1,'',selT767.FieldByName('PAG11_PERC').AsString);
    grdPagamenti.Cells[12,1]:=selT767.FieldByName('PAG12_MAX').AsString;
    grdPagamenti.Cells[12,2]:=IfThen(selT767.FieldByName('PAG12_PERC').AsFloat = -1,'',selT767.FieldByName('PAG12_PERC').AsString);
  end;
  A172FSchedeQuantIndividualiMW.CaricaCdsT768;
  A172FSchedeQuantIndividuali.AggiornaTotali;
end;

procedure TA172FSchedeQuantIndividualiDtM.selT767ANNOValidate(Sender: TField);
begin
  inherited;
  RecuperaListaValutatori;
end;

procedure TA172FSchedeQuantIndividualiDtM.selT767FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A172FSchedeQuantIndividualiMW.selT767FilterRecord;
end;


procedure TA172FSchedeQuantIndividualiDtM.selT767NewRecord(DataSet: TDataSet);
begin
  inherited;
  A172FSchedeQuantIndividualiMW.selT767NewRecord
end;

procedure TA172FSchedeQuantIndividualiDtM.BeforeDelete(DataSet: TDataSet);
begin
 A172FSchedeQuantIndividualiMW.selT767BeforeDelete;
end;

procedure TA172FSchedeQuantIndividualiDtM.RecuperaListaValutatori;
begin
  A172FSchedeQuantIndividualiMW.SettaDatasetValutatori;
  A172FSchedeQuantIndividualiMW.selValutatori.First;
  A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[13].PickList.Clear;
  while not A172FSchedeQuantIndividualiMW.selValutatori.Eof do
  begin
    A172FSchedeQuantIndividuali.dgrdSchedeInd.Columns[13].PickList.Add(A172FSchedeQuantIndividualiMW.selValutatori.FieldByName('VALUTATORE').AsString);
    A172FSchedeQuantIndividualiMW.selValutatori.Next;
  end;
end;

procedure TA172FSchedeQuantIndividualiDtM.cdsT768AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A172FSchedeQuantIndividuali.PopupMenu1Popup(nil);
end;

end.
