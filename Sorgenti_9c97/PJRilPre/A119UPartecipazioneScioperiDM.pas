unit A119UPartecipazioneScioperiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali, QueryPK,
  A119UPartecipazioneScioperiMW;

type
  TA119FPartecipazioneScioperiDM = class(TR004FGestStoricoDtM)
    selT250: TOracleDataSet;
    selT250ID: TFloatField;
    selT250DATA: TDateTimeField;
    selT250CAUSALE: TStringField;
    selT250TIPOGIUST: TStringField;
    selT250DAORE: TStringField;
    selT250AORE: TStringField;
    selT250SELEZIONE_ANAGRAFICA: TStringField;
    selT250GG_NOTIFICA: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure selT250AfterScroll(DataSet: TDataSet);
  private
  public
    A119MW: TA119FPartecipazioneScioperiMW;
  end;

var
  A119FPartecipazioneScioperiDM: TA119FPartecipazioneScioperiDM;

implementation

uses A119UPartecipazioneScioperi;

{$R *.dfm}

procedure TA119FPartecipazioneScioperiDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT250,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evBeforePost,
                              evOnNewRecord,
                              evAfterDelete,
                              evAfterPost]);
  // spostato dopo creazione mw per gestione afterscroll...
  //selT250.Open;

  selT250.FieldByName('ID').Visible:=DebugHook <> 0;

  A119MW:=TA119FPartecipazioneScioperiMW.Create(Self);
  A119MW.selT250_Funzioni:=selT250;

  selT250.Open;
end;

procedure TA119FPartecipazioneScioperiDM.DataModuleDestroy(Sender: TObject);
begin
  selT250.Close;
  FreeAndNil(A119MW);
  inherited;
end;

procedure TA119FPartecipazioneScioperiDM.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA119FPartecipazioneScioperiDM.OnNewRecord(DataSet: TDataSet);
begin
  A119MW.selT250NewRecord(DataSet);
  A119FPartecipazioneScioperi.OnInserimento;
end;

procedure TA119FPartecipazioneScioperiDM.selT250AfterScroll(DataSet: TDataSet);
begin
  A119MW.selT250AfterScroll(DataSet);
  inherited;
  A119MW.CaricaDettaglioRichiesta(selT250.FieldByName('ID').AsInteger);
end;

procedure TA119FPartecipazioneScioperiDM.BeforeDelete(DataSet: TDataSet);
begin
  A119MW.selT250BeforeDelete(DataSet);
  inherited;
end;

procedure TA119FPartecipazioneScioperiDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A119MW.selT250BeforeEdit(DataSet);
end;

procedure TA119FPartecipazioneScioperiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A119MW.selT250BeforePost(DataSet);
end;

end.
