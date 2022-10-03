unit P501UCudSetupDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, RegistrazioneLog, OracleData, Oracle,
  R004UGestStoricoDTM, Variants, DBClient, P501UCudSetupMW;

type
  TP501FCudSetupDtM = class(TR004FGestStoricoDtM)
    selP500: TOracleDataSet;
    dsrP030: TDataSource;
    selP500D_VALUTA: TStringField;
    selP500ANNO: TIntegerField;
    selP500COD_VALUTA: TStringField;
    selP500COD_FISCALE: TStringField;
    selP500DENOMINAZIONE: TStringField;
    selP500COMUNE: TStringField;
    selP500PROVINCIA: TStringField;
    selP500CAP: TStringField;
    selP500INDIRIZZO: TStringField;
    selP500E_MAIL: TStringField;
    selP500MATRICOLA_INPS: TStringField;
    selP500FIRMATARIO: TStringField;
    selP500TIPO_FORNITORE: TStringField;
    selP500CODICE_ATTIVITA: TStringField;
    selP500TELEFONO: TStringField;
    selP500FAX: TStringField;
    selP500STATO_ENTE: TStringField;
    selP500NATURA_GIURIDICA: TStringField;
    selP500SITUAZIONE_ENTE: TStringField;
    selP500COD_FISCALE_DICASTERO: TStringField;
    selP500COD_FISCALE_FIRMA: TStringField;
    selP500CODICE_CARICA_FIRMA: TStringField;
    selP500COGNOME_FIRMA: TStringField;
    selP500NOME_FIRMA: TStringField;
    selP500SESSO_FIRMA: TStringField;
    selP500DATA_NASCITA_FIRMA: TDateTimeField;
    selP500COMUNE_NASCITA_FIRMA: TStringField;
    selP500PROVINCIA_NASCITA_FIRMA: TStringField;
    selP500COMUNE_RESIDENZA_FIRMA: TStringField;
    selP500PROVINCIA_RESIDENZA_FIRMA: TStringField;
    selP500CAP_RESIDENZA_FIRMA: TStringField;
    selP500INDIRIZZO_FIRMA: TStringField;
    selP500TELEFONO_FIRMA: TStringField;
    selP500COD_SIA: TStringField;
    selP500COD_ABI: TStringField;
    selP500COD_CAB: TStringField;
    selP500COD_COMUNE: TStringField;
    selP500CONTO_CORRENTE: TStringField;
    selP500CODICE_FORNITURA_DMA: TStringField;
    selP500TIPO_FORNITORE_DMA: TStringField;
    selP500CODICE_INPDAP_DMA: TStringField;
    selP500CODICE_ATECO_DMA: TStringField;
    selP500CODICE_FORMA_GIUR_DMA: TStringField;
    selP500COD_FISCALE_SW_DMA: TStringField;
    selP500FIRMA_DENUNCIA_DMA: TStringField;
    selP500SEDE_INPS: TStringField;
    selP500COD_FISCALE_MITT_EMENS: TStringField;
    selP500CODICE_ISTAT_EMENS: TStringField;
    selP500ID_ABBONATO_POSTEL: TStringField;
    selP500TIPOLOGIA_INVIO_POSTEL: TStringField;
    selP500COLORE_POSTEL: TStringField;
    selP500TRATTAMENTO_POSTEL: TStringField;
    selP500CENTRO_COSTO_POSTEL: TStringField;
    selP500PROCEDURA_POSTEL: TStringField;
    selP500DECORRENZA_CARICA_FIRMA: TDateTimeField;
    selP500IND_DOM_POSTEL: TStringField;
    selP500CAP_DOM_POSTEL: TStringField;
    selP500COM_DOM_POSTEL: TStringField;
    selP500PRV_DOM_POSTEL: TStringField;
    selP500SEDE_SERVIZIO_CED: TStringField;
    selP500UNITA_OP_CED: TStringField;
    selP500QUALIFICA_CED: TStringField;
    selP500WEB_STAMPA: TStringField;
    selP500WEB_PATH_ISTRUZIONI: TStringField;
    selP500WEB_ANNOTAZIONI: TStringField;
    selP500WEB_DATA_STAMPA: TDateTimeField;
    selP500DATA_INIZIO_CED: TStringField;
    selP500FAM_STATO_CIVILE: TStringField;
    selP500FAM_PATH_ISTRUZIONI: TStringField;
    selP500FAM_NOTE: TStringField;
    selP500FAM_DATA_DA: TDateTimeField;
    selP500FAM_DATA_A: TDateTimeField;
    selP500CODICE_COMPARTO_DMA: TStringField;
    selP500CODICE_SOTTOCOMPARTO_DMA: TStringField;
    selP500PIVA_CED: TStringField;
    selP500CODICE_AZIENDA_INPGI: TStringField;
    selP500CODICE_FORMA_GIUR_DMA2: TStringField;
    selP500COD_CONTRATTO_DMA2: TStringField;
    selP500PATH_FILEPDF_CED: TStringField;
    selP500CODICE_AZIENDA_ENPAM: TStringField;
    selP500DATA_VERS_IRPEF01: TDateTimeField;
    selP500DATA_VERS_IRPEF02: TDateTimeField;
    selP500DATA_VERS_IRPEF03: TDateTimeField;
    selP500DATA_VERS_IRPEF04: TDateTimeField;
    selP500DATA_VERS_IRPEF05: TDateTimeField;
    selP500DATA_VERS_IRPEF06: TDateTimeField;
    selP500DATA_VERS_IRPEF07: TDateTimeField;
    selP500DATA_VERS_IRPEF08: TDateTimeField;
    selP500DATA_VERS_IRPEF09: TDateTimeField;
    selP500DATA_VERS_IRPEF10: TDateTimeField;
    selP500DATA_VERS_IRPEF11: TDateTimeField;
    selP500DATA_VERS_IRPEF12: TDateTimeField;
    selP500COD_IBAN: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selP500NewRecord(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP500ANNOChange(Sender: TField);
  private
    procedure VisualizzaTab (Nometab: String);
  public
    P501FCudSetupMW: TP501FCudSetupMW;
  end;

var
  P501FCudSetupDtM: TP501FCudSetupDtM;

implementation

uses P501UCudSetup;

{$R *.DFM}

procedure TP501FCudSetupDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP500,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);

  P501FCudSetupMW:=TP501FCudSetupMW.Create(Self);
  P501FCudSetupMW.selP500:=selP500;
  P501FCudSetupMW.VisualizzaTab:=VisualizzaTab;
  selP500D_VALUTA.LookupDataSet:=P501FCudSetupMW.selP030;
  dsrP030.DataSet:=P501FCudSetupMW.selP030;
end;

procedure TP501FCudSetupDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  P501FCudSetupMW.BeforePost;
end;

procedure TP501FCudSetupDtM.selP500ANNOChange(Sender: TField);
begin
  inherited;
  P501FCudSetupMW.CambiaAnno;
end;

procedure TP501FCudSetupDtM.selP500NewRecord(DataSet: TDataSet);
begin
  P501FCudSetupMW.ImpostaAnno;
end;

procedure TP501FCudSetupDtM.VisualizzaTab(Nometab: String);
begin
  if Nometab = P501FCudSetupMW.tabFamiliari then
    P501FCudSetup.pgcPrincipale.ActivePage:=P501FCudSetup.tshFamiliari
  else if Nometab = P501FCudSetupMW.tabCedolino then
    P501FCudSetup.pgcPrincipale.ActivePage:=P501FCudSetup.tshCedolino;
end;

end.
