unit B007UManipolazioneDatiDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000Versione, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData,
  (*Midaslib,*) Crtl, DBClient, C180FunzioniGenerali, Variants, USelI010, C700USelezioneAnagrafe,
  B007UManipolazioneDatiMW, B022UUtilityGestDocumentaleMW;

type
  TB007FManipolazioneDatiDtM1 = class(TDataModule)
    updI070: TOracleQuery;
    selI010_: TOracleDataSet;
    dsrI010: TDataSource;
    dsrValori: TDataSource;
    selI010_NOME_CAMPO: TStringField;
    selI010_NOME_LOGICO: TStringField;
    selI500: TOracleDataSet;
    updT430Domicilio: TOracleQuery;
    selT430COMUNE_DOM: TOracleDataSet;
    procedure B007FCancellaDtM1Create(Sender: TObject);
    procedure B007FCancellaDtM1Destroy(Sender: TObject);
    procedure selT430COMUNE_DOMFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  public
    B007FManipolazioneDatiMW: TB007FManipolazioneDatiMW;
    B022FUtilityGestDocumentaleMW: TB022FUtilityGestDocumentaleMW;
    selI010MigrDom: TselI010;
end;

var
  B007FManipolazioneDatiDtM1: TB007FManipolazioneDatiDtM1;

implementation

uses B007UManipolazioneDati;

{$R *.DFM}

procedure TB007FManipolazioneDatiDtM1.B007FCancellaDtM1Create(Sender: TObject);
var i:integer;
begin
  if not SessioneOracle.Connected then
  begin
    // in debug consente l'accesso
    (*
    if DebugHook = 0 then
    begin
      while True do
      begin
        if Password(Application.Title) = -1 then
        begin
          Parametri.Azienda:='';
          Break;
        end;
        ShowMessage('L''utente non è abilitato a questa funzione');
      end;
      if Parametri.Azienda = '' then
        exit;
    end;
    *)
    Password(Application.Title);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  B007FManipolazioneDatiMW:=TB007FManipolazioneDatiMW.Create(Self);
  B022FUtilityGestDocumentaleMW:=TB022FUtilityGestDocumentaleMW.Create(Self);
  B022FUtilityGestDocumentaleMW.selT960_Funzioni:=B007FManipolazioneDatiMW.selT960;

  dsrI010.DataSet:=B007FManipolazioneDatiMW.selI010;
  dsrValori.DataSet:=B007FManipolazioneDatiMW.cdsValori;
  //A000GetLayout(A000SessioneIrisWIN); //Alberto: Già letto su A001UPasswordDtM1
  // MONDOEDP - commessa MAN/02 SVILUPPO#108.ini
  // il dataset contiene i soli dati liberi della T430
  // + i dati fissi legati alla residenza (indirizzo, cap, comune)
  // + i dati fissi legati al domicilio (indirizzo, cap, comune)
  // escludendo tutti i dati decodificati (T430D_*)
  selI010MigrDom:=TselI010.Create(Self);
  selI010MigrDom.Apri(SessioneOracle,
                      Parametri.Layout,
                      Parametri.Applicazione,
                      'REPLACE(REPLACE(NOME_CAMPO,''T430'',''''),''P430'','''') NOME_CAMPO,NOME_LOGICO,POSIZIONE,DATA_TYPE,DATA_LENGTH',
                      '(TABLE_NAME = ''V430_STORICO'')  ' +
                      'and (NOME_CAMPO in (''T430INDIRIZZO'', ''T430CAP'', ''T430COMUNE'', ''T430INDIRIZZO_DOM_BASE'', ''T430CAP_DOM_BASE'', ''T430COMUNE_DOM_BASE'') ' +
                      '     or ' +
                      '     exists (select ''X'' from I500_DATILIBERI I500 where ''T430'' || I500.NOMECAMPO = NOME_CAMPO) ' +
                      '     ) ',
                      'NOME_LOGICO');
  // MONDOEDP - commessa MAN/02 SVILUPPO#108.fine
  selI500.Open;
end;

procedure TB007FManipolazioneDatiDtM1.B007FCancellaDtM1Destroy(Sender: TObject);
begin
  selI500.Close;
  // MONDOEDP - commessa MAN/02 SVILUPPO#108.ini
  selI010MigrDom.CloseAll;
  FreeAndNil(selI010MigrDom);
  // MONDOEDP - commessa MAN/02 SVILUPPO#108.fine
  FreeAndNil(B022FUtilityGestDocumentaleMW);
  FreeAndNil(B007FManipolazioneDatiMW);
  inherited;
end;

procedure TB007FManipolazioneDatiDtM1.selT430COMUNE_DOMFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=C700SelAnagrafe.Lookup('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO') = DataSet.FieldByName('PROGRESSIVO').AsInteger;
end;

end.
