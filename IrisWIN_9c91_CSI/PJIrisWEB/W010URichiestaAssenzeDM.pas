unit W010URichiestaAssenzeDM;

interface

uses
  A000USessione, A000UInterfaccia, C018UIterAutDM,
  SysUtils, Classes, DB, Oracle, OracleData, Variants, StrUtils;

type
  TW010FRichiestaAssenzeDM = class(TDataModule)
    selT050: TOracleDataSet;
    selT050ID: TFloatField;
    selT050ID_REVOCA: TFloatField;
    selT050ID_REVOCATO: TFloatField;
    selT050PROGRESSIVO: TIntegerField;
    selT050DAL: TDateTimeField;
    selT050AL: TDateTimeField;
    selT050CAUSALE: TStringField;
    selT050TIPOGIUST: TStringField;
    selT050NUMEROORE: TStringField;
    selT050AORE: TStringField;
    selT050AUTORIZZAZIONE: TStringField;
    selT050DATANAS: TDateTimeField;
    selT050MATRICOLA: TStringField;
    selT050SESSO: TStringField;
    selT050DATA_RICHIESTA: TDateTimeField;
    selT050DATA_AUTORIZZAZIONE: TDateTimeField;
    selT050ELABORATO: TStringField;
    selT050NOMINATIVO: TStringField;
    selT050TIPO_RICHIESTA: TStringField;
    selT050AUTORIZZ_PREV: TStringField;
    selT050NUMEROORE_PREV: TStringField;
    selT050AORE_PREV: TStringField;
    selT050AUTORIZZ_UTILE: TStringField;
    selT050NOMINATIVO_RESP: TStringField;
    selT050AUTORIZZ_REVOCA: TStringField;
    selT050D_CAUSALE: TStringField;
    selT050D_CAUSALE_2: TStringField;
    selT050D_TIPOGIUST: TStringField;
    selT050D_DAORE_AORE: TStringField;
    selT050D_RESPONSABILE: TStringField;
    selT050D_TIPO_RICHIESTA: TStringField;
    selT050D_ELABORATO: TStringField;
    selT050D_DAORE_AORE_PREV: TStringField;
    selT050AUTORIZZ_AUTOMATICA: TStringField;
    selT050COD_ITER: TStringField;
    selT050AUTORIZZ_AUTOM_PREV: TStringField;
    selT050RESPONSABILE_PREV: TStringField;
    selT050LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT050REVOCABILE: TStringField;
    selT050D_AUTORIZZAZIONE: TStringField;
    selT050D_VISTI_PREC: TStringField;
    selT050D_AVVERTIMENTI: TStringField;
    selCancInt: TOracleDataSet;
    selT050D_CARTELLINO: TStringField;
    selT050CSI_TIPO_MG: TStringField;
    selT050D_CSI_TIPO_MG: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT050CalcFields(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
  public
  end;

implementation

{$R *.dfm}

uses W010URichiestaAssenze;

procedure TW010FRichiestaAssenzeDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
 try
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
 except
 end;
end;

procedure TW010FRichiestaAssenzeDM.selT050CalcFields(DataSet: TDataSet);
var
  DescCaus,TipoGius,Orario,Aut,DescResp,TipoRichiesta,DescTipoRichiesta,LTipoMG,LDTipoMG: String;
begin
  with selT050 do
  begin
    // D_TIPO_RICHIESTA: descrizione tipo richiesta
    TipoRichiesta:=FieldByName('TIPO_RICHIESTA').AsString;
    if TipoRichiesta = 'P' then
      DescTipoRichiesta:='Preventiva'
    else if TipoRichiesta = 'D' then
      DescTipoRichiesta:='Definitiva'
    else if TipoRichiesta = 'R' then
      DescTipoRichiesta:='Revoca'
    // empoli - commessa 2012/102.ini
    else if TipoRichiesta = 'C' then
      DescTipoRichiesta:='Cancellazione';
    // empoli - commessa 2012/102.fine
    // diciture per legenda
    if not FieldByName('ID_REVOCA').IsNull then
    begin
      if FieldByName('ID_REVOCA').AsInteger > 0 then
        DescTipoRichiesta:=DescTipoRichiesta + '(1)'
      else
        DescTipoRichiesta:=DescTipoRichiesta + '(3)'
    end;
    if (TipoRichiesta = 'P') and (FieldByName('AUTORIZZ_UTILE').AsString = 'N') then
      DescTipoRichiesta:=DescTipoRichiesta + '(2)';
    FieldByName('D_TIPO_RICHIESTA').AsString:=DescTipoRichiesta;

    // D_CAUSALE: descrizione causale
    // D_CAUSALE_2: codice + descrizione causale
    DescCaus:=VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'DESCRIZIONE'));
    if DescCaus = '' then
      DescCaus:=VarToStr(WR000DM.selT275.Lookup('CODICE',FieldByName('CAUSALE').AsString,'DESCRIZIONE'));
    FieldByName('D_CAUSALE').AsString:=DescCaus;
    FieldByName('D_CAUSALE_2').AsString:=FieldByName('CAUSALE').AsString;
    if DescCaus <> '' then
      FieldByName('D_CAUSALE_2').AsString:=FieldByName('D_CAUSALE_2').AsString + ' - ' + DescCaus;

    // D_TIPOGIUST: descrizione tipo giustificativo
    TipoGius:=FieldByName('TIPOGIUST').AsString;
    if TipoGius = 'I' then
      FieldByName('D_TIPOGIUST').AsString:='Giornate'
    else if TipoGius = 'M' then
      FieldByName('D_TIPOGIUST').AsString:='Mezze giorn.'
    else if TipoGius = 'N' then
      FieldByName('D_TIPOGIUST').AsString:='Numero Ore'
    else if TipoGius = 'D' then
      FieldByName('D_TIPOGIUST').AsString:='Da ore/A ore';

    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    LTipoMG:=FieldByName('CSI_TIPO_MG').AsString;
    if LTipoMG = 'M' then
      LDTipoMG:='Mattino'
    else if LTipoMG = 'P' then
      LDTipoMG:='Pomeriggio'
    else
      LDTipoMG:=LTipoMG;
    FieldByName('D_CSI_TIPO_MG').AsString:=LDTipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine

    // D_DAORE_AORE: descrizione daore - a ore
    Orario:=FieldByName('NUMEROORE').AsString;
    if FieldByName('AORE').AsString <> '' then
      Orario:=Orario + ' - ' + FieldByName('AORE').AsString;
    FieldByName('D_DAORE_AORE').AsString:=Orario;

    // D_DAORE_AORE_PREV: descrizione daore - a ore rif. richiesta preventiva
    //                    visualizzato solo se differente da rich. definitiva
    if (TipoRichiesta = 'R') or
       ((FieldByName('NUMEROORE').Value = FieldByName('NUMEROORE_PREV').Value) and
        (FieldByName('AORE').Value =  FieldByName('AORE_PREV').Value)) then
      Orario:=''
    else
    begin
      Orario:=FieldByName('NUMEROORE_PREV').AsString;
      if FieldByName('AORE_PREV').AsString <> '' then
        Orario:=Orario + ' - ' + FieldByName('AORE_PREV').AsString;
    end;
    FieldByName('D_DAORE_AORE_PREV').AsString:=Orario;

    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      Aut:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      Aut:='No'
    else
      Aut:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=Aut;

    // D_ELABORATO: stato elaborazione
    if FieldByName('ELABORATO').AsString = 'S' then
      FieldByName('D_ELABORATO').AsString:='OK'
    else if FieldByName('ELABORATO').AsString = 'E' then
      FieldByName('D_ELABORATO').AsString:='Err'
    else
      FieldByName('D_ELABORATO').AsString:='';

    // D_RESPONSABILE: nominativo reale del responsabile oppure nome utente
    // visualizza responsabile solo se c'è un'autorizzazione utile
    if Aut = '' then
      DescResp:=''
    else
      DescResp:=FieldByName('NOMINATIVO_RESP').AsString;
    FieldByName('D_RESPONSABILE').AsString:=DescResp;
  end;
end;

procedure TW010FRichiestaAssenzeDM.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
var
  Tipo: String;
begin
  // VARESE_PROVINCIA - chiamata <76068>.ini
  // correzione controllo filtro dizionario
  //Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CAUSALE').AsString) or
  //        A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CAUSALE').AsString);
  Tipo:=IfThen(VarIsNull(WR000DM.selT275.Lookup('CODICE',DataSet.FieldByName('CAUSALE').AsString,'CODICE')),'CAUSALI ASSENZA','CAUSALI PRESENZA');
  Accept:=A000FiltroDizionario(Tipo,DataSet.FieldByName('CAUSALE').AsString);
  // VARESE_PROVINCIA - chiamata <76068>.fine

  if WR000DM.Responsabile then
  begin
    //empoli
    if (Self.Owner is TW010FRichiestaAssenze) and
       ((Self.Owner as TW010FRichiestaAssenze).C018.TipoRichiesteSel = [trDaAutorizzare]) then
    begin
      Accept:=Accept and (Dataset.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
    end;

    // SGIULIANOMILANESE_COMUNE - chiamata <80446>.ini
    // esclude le richieste (preventive / definitive) che sarebbero da autorizzare al proprio livello,
    // ma per cui esiste già una revoca pendente
    // in questo modo si tenta di escludere dalla visualizzazione delle richieste da autorizzare
    // quelle che non sono state autorizzate al proprio livello, ma già revocate dal dipendente
    // perché autorizzate a livelli precedenti dal proprio
    // es.
    //   Proprio livello = 2
    //   DIP:    richiesta effettuata
    //   AUT L1: autorizzazione concessa al livello 1
    //   DIP:    richiesta revocata
    //   AUT L2:
    if Dataset.FieldByName('TIPO_RICHIESTA').AsString <> 'R' then
    begin
      // *esclude* le richieste non ancora considerate al proprio livello
      // ma che hanno una revoca in corso (autorizzata o in fase di autorizzazione)
      Accept:=Accept and
              not ((Dataset.FieldByName('DATA_AUTORIZZAZIONE').IsNull) and        // richieste non considerate al proprio livello di autorizzazione
                   (not Dataset.FieldByName('ID_REVOCA').IsNull) and              // revoca pendente...
                   (Dataset.FieldByName('AUTORIZZ_REVOCA').AsString <> C018NO));  // .... autorizzata o in fase di autorizzazione
    end;
    // SGIULIANOMILANESE_COMUNE - chiamata <80446>.fine
  end;
end;

end.
