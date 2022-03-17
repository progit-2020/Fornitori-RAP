unit A151UAssenteismoDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UCostanti, A000USessione, A000UInterfaccia,
  DBClient, Oracle, C180FunzioniGenerali, xmldom, XMLIntf, msxmldom, A000UMessaggi,
  XMLDoc, A151UAssenteismoMW;

type
  TA151FAssenteismoDtM = class(TR004FGestStoricoDtM)
    selT151: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT151AfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A151MW: TA151FAssenteismoMW;
    procedure evtRichiesta(Msg,Chiave:String);
  end;

var
  A151FAssenteismoDtM: TA151FAssenteismoDtM;

implementation

uses A151UAssenteismo;

{$R *.dfm}

procedure TA151FAssenteismoDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT151,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A151MW:=TA151FAssenteismoMW.Create(Self);
  A151MW.selT151:=selT151;
  A151MW.evtRichiesta:=evtRichiesta;
end;

procedure TA151FAssenteismoDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A151FAssenteismo.CaricaListeColonne;
  A151MW.iEsportaXml:=A151FAssenteismo.cmbEsportaXml.ItemIndex;
  A151MW.BeforePostNoStorico;
end;

procedure TA151FAssenteismoDtM.selT151AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A151MW.AfterScroll;
  with A151FAssenteismo do
  begin
    dcmbTabellaCloseUp(nil);
    lstAssenzeClickCheck(nil);
    dchkAssenzaGGIntClick(nil);
    cmbEsportaXml.ItemIndex:=-1;
    if selT151.FieldByName('ESPORTA_XML').AsString = 'S' then
      cmbEsportaXml.ItemIndex:=0
    else if selT151.FieldByName('ESPORTA_XML').AsString = 'L' then
      cmbEsportaXml.ItemIndex:=1;
    cmbEsportaXmlCloseUp(nil);
  end;
end;

procedure TA151FAssenteismoDtM.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort;
end;

end.
