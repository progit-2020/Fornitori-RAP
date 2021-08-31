unit A118UPubblicazioneDocumentiDtM;

interface

uses
  A118UPubblicazioneDocumentiMW, StrUtils, A000UCostanti, C180FunzioniGenerali, A000UInterfaccia,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData, Oracle;

type
  TA118FPubblicazioneDocumentiDtM = class(TR004FGestStoricoDtM)
    selI200: TOracleDataSet;
    selI201: TOracleDataSet;
    selI202: TOracleDataSet;
    dsrI201: TDataSource;
    dsrI202: TDataSource;
    selI202CAMPO: TStringField;
    selI202DAL: TIntegerField;
    selI202LUNG: TIntegerField;
    selI202CODICE: TStringField;
    selI202LIVELLO: TIntegerField;
    selI202VISIBILE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI200AfterScroll(DataSet: TDataSet);
    procedure selI201AfterScroll(DataSet: TDataSet);
    procedure selI201BeforePost(DataSet: TDataSet);
    procedure selI201AfterPost(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI201NewRecord(DataSet: TDataSet);
    procedure selI201BeforeDelete(DataSet: TDataSet);
    procedure selI201AfterDelete(DataSet: TDataSet);
    procedure selI202NewRecord(DataSet: TDataSet);
    procedure selI200AfterCancel(DataSet: TDataSet);
    procedure selI202BeforePost(DataSet: TDataSet);
    procedure selI201BeforeInsert(DataSet: TDataSet);
    procedure selI201BeforeEdit(DataSet: TDataSet);
    procedure selI202BeforeInsert(DataSet: TDataSet);
    procedure selI202BeforeEdit(DataSet: TDataSet);
    procedure selI202BeforeDelete(DataSet: TDataSet);
    procedure selI201BeforeScroll(DataSet: TDataSet);
    procedure selI202VISIBILEValidate(Sender: TField);
  private
    Op, OpI201: String;
    function  CheckFiltroLivello(const PFiltro: String; var ErrMsg: String): Boolean;
  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    MaxLiv,MaxPos: Integer;
  end;

var
  A118FPubblicazioneDocumentiDtM: TA118FPubblicazioneDocumentiDtM;

implementation

uses A118UPubblicazioneDocumenti;

{$R *.dfm}

procedure TA118FPubblicazioneDocumentiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  MaxLiv:=-1;
  MaxPos:=0;
  InizializzaDataSet(selI200,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selI200.Open;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI200AfterScroll(DataSet: TDataSet);
begin
  // apre il dataset dei campi
  selI202.Close;
  selI202.SetVariable('CODICE',selI200.FieldByName('CODICE').AsString);
  selI202.Open;

  // apre dataset dei livelli
  selI201.DisableControls;
  selI201.AfterScroll:=nil;
  selI201.Close;
  selI201.SetVariable('CODICE',selI200.FieldByName('CODICE').AsString);
  selI201.Open;
  if selI201.RecordCount > 0 then
  begin
    selI201.Last;
    MaxLiv:=selI201.FieldByName('LIVELLO').AsInteger;
    selI201.AfterScroll:=selI201AfterScroll;
    selI201.First;
  end
  else
  begin
    MaxLiv:=-1;
  end;
  selI201.EnableControls;

  A118FPubblicazioneDocumenti.btnCheckFiltro.Enabled:=selI200.FieldByName('FILTRO').AsString <> '';
end;

procedure TA118FPubblicazioneDocumentiDtM.selI200AfterCancel(DataSet: TDataSet);
begin
  Op:='';
  SessioneOracle.CancelUpdates([selI201,selI202]);
end;

procedure TA118FPubblicazioneDocumentiDtM.BeforePostNoStorico(DataSet: TDataSet);
var
  Filtro, Err: String;
begin
  inherited;

  // correttezza filtro visualizzazione
  Filtro:=Trim(selI200.FieldByName('FILTRO').AsString);
  selI200.FieldByName('FILTRO').AsString:=Filtro;
  if (Filtro <> '') and (not A118MW.CheckFiltroDoc(Filtro,Err)) then
  begin
    if Err <> '' then
      raise Exception.Create('Il filtro di visualizzazione documento è errato:' + CRLF + Err);
  end;

  // verifica esistenza directory base per documenti se specificata
  // prima del controllo effettua trim
  selI200.FieldByName('ROOT').AsString:=Trim(selI200.FieldByName('ROOT').AsString);
  if not selI200.FieldByName('ROOT').IsNull then
  begin
    if not DirectoryExists(selI200.FieldByName('ROOT').AsString) then
    begin
      if R180MessageBox('La directory base per i documenti è inesistente oppure non accessibile.'#13#10'Vuoi continuare?',DOMANDA) = mrNo then
        Abort;
    end;
  end;

  // conferma eventuali modifiche non salvate sui campi
  if selI202.State <> dsBrowse then
    selI202.Post;

  // conferma eventuali modifiche non salvate sul livello
  if selI201.State <> dsBrowse then
    selI201.Post;

  // verifica le impostazioni dei livelli
  selI201.DisableControls;
  try
    selI201.First;
    while not selI201.Eof do
    begin
      // estensione valida solo su ultimo livello
      if (selI201.FieldByName('EXT').AsString <> '') and
         (selI201.FieldByName('LIVELLO').AsInteger < MaxLiv) then
        raise Exception.Create('E'' possibile indicare l''estensione solo sull''ultimo livello!');

      // correttezza filtro
      Filtro:=Trim(selI201.FieldByName('FILTRO').AsString);
      if (Filtro <> '') and (not CheckFiltroLivello(Filtro,Err)) then
        raise Exception.Create('Il filtro indicato per il livello ' + selI201.FieldByName('LIVELLO').AsString +
                               ' non è corretto:' + CRLF +
                               Err);
      selI201.Next;
    end;
    selI201.First;
  finally
    selI201.EnableControls;
  end;

  // rimuove il filtro dal dataset selI202 per il post
  selI202.Filtered:=False;

  case DataSet.State of
    dsInsert: Op:='I';
    dsEdit:   Op:='M';
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.AfterPost(DataSet: TDataSet);
begin
  // dopo l'inserimento di un nuovo tipo di documento
  // inserisce automaticamente un livello
  if Op = 'I' then
  begin
    selI201.Append;
    selI201.FieldByName('NOME').AsString:='nome cartella';
    selI201.Post;
  end;
  if selI201.UpdatesPending or selI202.UpdatesPending then
    SessioneOracle.ApplyUpdates([selI201,selI202],True);

  inherited;

  // porta in edit il dataset dei livelli
  if Op = 'I' then
    selI201.Edit;
  Op:='';
end;

// ############# Dataset dei livelli  #############

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeScroll(DataSet: TDataSet);
begin
  if selI202.State <> dsBrowse then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterScroll(DataSet: TDataSet);
var
  L: Integer;
begin
  L:=selI201.FieldByName('LIVELLO').AsInteger;

  // intestazione groupbox
  A118FPubblicazioneDocumenti.grpCampi.Caption:=Format('Definizione campi - livello %d',[L]);

  // nasconde il campo lunghezza se è indicato un separatore
  A118FPubblicazioneDocumenti.dgrdCampi.Columns.Items[2].Visible:=selI201.FieldByName('SEPARATORE').IsNull;

  //selI202.DisableControls;

  // filtra il dataset dei campi
  selI202.Filtered:=False;
  selI202.Filter:=Format('LIVELLO = %d',[L]);
  selI202.Filtered:=True;

  // se il nome contiene separatori estrae la posizione massima
  if selI201.FieldByName('SEPARATORE').IsNull then
    MaxPos:=-1
  else
  begin
    if selI202.RecordCount = 0 then
      MaxPos:=0
    else
    begin
      selI202.Last;
      MaxPos:=selI202.FieldByName('DAL').AsInteger;
      selI202.First;
    end;
  end;
  //selI202.EnableControls;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeInsert(DataSet: TDataSet);
begin
  if (Op <> 'I') and (selI200.State <> dsEdit) then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201NewRecord(DataSet: TDataSet);
begin
  selI201.FieldByName('CODICE').AsString:=selI200.FieldByName('CODICE').AsString;
  selI201.FieldByName('LIVELLO').AsInteger:=MaxLiv + 1;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeEdit(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforeDelete(DataSet: TDataSet);
var
  L: Integer;
begin
  if selI200.State <> dsEdit then
    Abort;

  // controllo livello
  L:=selI201.FieldByName('LIVELLO').AsInteger;
  if L <> MaxLiv then
    raise Exception.Create('E'' possibile eliminare solo l''ultimo livello!')
  else if L = 0 then
    raise Exception.Create('Non è possibile eliminare l''unico livello definito!');

  // conferma se sono presenti dettagli
  if selI202.RecordCount > 0 then
    if R180MessageBox('Il livello ' + IntToStr(L) + ' contiene delle righe di dettaglio.' + CRLF +
                      'Confermi la cancellazione?',DOMANDA) = mrNo then
      Abort;
end;

function TA118FPubblicazioneDocumentiDtM.CheckFiltroLivello(const PFiltro: String; var ErrMsg: String): Boolean;
var
  FiltroSrc,Campo,Valore: String;
  i,TipoVar: Integer;
begin
  Result:=PFiltro = '';
  ErrMsg:='';
  if not Result then
  begin
    try
      A118MW.selFiltro.ClearVariables;
      A118MW.selFiltro.DeleteVariables;
      A118MW.selFiltro.SQL.Text:=Format('select count(*) TOT from dual where %s',[PFiltro]);

      FiltroSrc:=UpperCase(PFiltro);

      selI202.DisableControls;
      selI202.First;
      while not selI202.Eof do
      begin
        Campo:=UpperCase(selI202.FieldByName('CAMPO').AsString);
        if LeftStr(Campo,1) = ':' then
        begin
          // se la variabile è presente nel filtro, la dichiara
          if R180CercaParolaIntera(Campo,FiltroSrc,',;()=<>|!/+-*') > 0 then
          begin
            Campo:=Copy(Campo,2);
            TipoVar:=-1;
            Valore:='''X''';

            // cerca il tipo della variabile nell'array
            for i:=0 to High(VARIABILI) do
            begin
              if Campo = VARIABILI[i].Nome then
              begin
                TipoVar:=VARIABILI[i].Tipo;
                Break;
              end;
            end;
            if TipoVar = -1 then
              TipoVar:=otString
            else
            begin
              case TipoVar of
                otString:  Valore:='''X''';
                otInteger: Valore:='1';
              end;
            end;
            A118MW.selFiltro.DeclareVariable(Campo,TipoVar);
            A118MW.selFiltro.SetVariable(Campo,Valore);
          end;

          FiltroSrc:=StringReplace(FiltroSrc,':' + Campo,'',[rfReplaceAll,rfIgnoreCase]);
          if Pos(':',FiltroSrc) = 0 then
            Break;
        end;
        selI202.Next;
      end;
      selI202.First;
      selI202.EnableControls;

      // ricerca variabili speciali
      // :PROGRESSIVO = progressivo del dipendente
      if R180CercaParolaIntera(':PROGRESSIVO',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        A118MW.selFiltro.DeclareVariable('PROGRESSIVO',otInteger);
        A118MW.selFiltro.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
        FiltroSrc:=StringReplace(FiltroSrc,':PROGRESSIVO','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // :MATRICOLA = matricola del dipendente
      if R180CercaParolaIntera(':MATRICOLA',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        A118MW.selFiltro.DeclareVariable('MATRICOLA',otString);
        A118MW.selFiltro.SetVariable('MATRICOLA',Parametri.MatricolaOper);
        FiltroSrc:=StringReplace(FiltroSrc,':MATRICOLA','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // :NOME_UTENTE = nome utente del dipendente
      if R180CercaParolaIntera(':NOME_UTENTE',FiltroSrc,',;()=<>|!/+-*') > 0 then
      begin
        A118MW.selFiltro.DeclareVariable('NOME_UTENTE',otString);
        A118MW.selFiltro.SetVariable('NOME_UTENTE',Parametri.Operatore);
        FiltroSrc:=StringReplace(FiltroSrc,':NOME_UTENTE','',[rfReplaceAll,rfIgnoreCase]);
      end;

      // verifica se sono presenti altre variabili
      if Pos(':',FiltroSrc) > 0 then
        ErrMsg:='una o più variabili utilizzate nel filtro non sono state definite nella struttura!'
      else
      begin
        A118MW.selFiltro.Execute;
        Result:=True;
      end;
    except
      on E: Exception do
        ErrMsg:=E.Message;
    end;
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201BeforePost(DataSet: TDataSet);
var
  L: Integer;
  //Filtro,Err: String;
begin
  L:=selI201.FieldByName('LIVELLO').AsInteger;

  // nome
  if Trim(selI201.FieldByName('NOME').AsString) = '' then
    raise Exception.Create(Format('Indicare un nome descrittivo per il file del livello %d',[L]));

  // estensione: rimuove punto iniziale
  if LeftStr(selI201.FieldByName('EXT').AsString,1) = '.' then
    selI201.FieldByName('EXT').AsString:=Copy(selI201.FieldByName('EXT').AsString,2);

  // separatore
  if Pos(' ',selI201.FieldByName('SEPARATORE').AsString) > 0 then
    if R180MessageBox('Attenzione! Nel campo separatore' + CRLF +
                      'è stato inserito il carattere SPAZIO.' + CRLF +
                      'Se possibile si raccomanda di sostituirlo' + CRLF +
                      'con un altro carattere maggiormente visibile,' + CRLF +
                      'quale l''underscore "_".' + CRLF +
                      'Vuoi continuare?',DOMANDA) = mrNo then
      Abort;

  // correttezza filtro
  {
  Filtro:=Trim(selI201.FieldByName('FILTRO').AsString);
  if (Filtro <> '') and (not CheckFiltroLivello(Filtro,Err)) then
    raise Exception.Create(Format('Il filtro indicato per il livello %d contiene errori:%s%s',[L,CRLF,Err]));
  }

  // imposta tipo operazione
  case DataSet.State of
    dsInsert: OpI201:='I';
    dsEdit:   OpI201:='M';
  end;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterPost(DataSet: TDataSet);
begin
  if OpI201 = 'I' then
  begin
    if selI201.FieldByName('LIVELLO').AsInteger > MaxLiv then
      MaxLiv:=selI201.FieldByName('LIVELLO').AsInteger;
  end;
  OpI201:='';
end;

procedure TA118FPubblicazioneDocumentiDtM.selI201AfterDelete(DataSet: TDataSet);
begin
  // esegue cancellazione del dettaglio del livello
  selI202.DisableControls;
  selI202.First;
  while not selI202.Eof do
    selI202.Delete;
  selI202.EnableControls;

  dec(MaxLiv);
end;


// ############# Dataset del dettaglio di livello  #############

procedure TA118FPubblicazioneDocumentiDtM.selI202NewRecord(DataSet: TDataSet);
begin
  selI202.FieldByName('CODICE').AsString:=selI201.FieldByName('CODICE').AsString;
  selI202.FieldByName('LIVELLO').AsInteger:=selI201.FieldByName('LIVELLO').AsInteger;
  if MaxPos <> -1 then
    selI202.FieldByName('DAL').AsInteger:=MaxPos + 1;
  selI202.FieldByName('VISIBILE').AsString:='N';
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202VISIBILEValidate(Sender: TField);
begin
  if not ((Sender.AsString = 'S') or (Sender.AsString = 'N')) then
    raise Exception.Create('Introdurre S oppure N');
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeInsert(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeEdit(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforeDelete(DataSet: TDataSet);
begin
  if selI200.State <> dsEdit then
    Abort;
end;

procedure TA118FPubblicazioneDocumentiDtM.selI202BeforePost(DataSet: TDataSet);
var
  Tipo: String;
begin
  // trim degli spazi nel nome del campo
  selI202.FieldByName('CAMPO').AsString:=Trim(selI202.FieldByName('CAMPO').AsString);

  // posizione obbligatoria
  if selI202.FieldByName('DAL').IsNull then
  begin
    Tipo:=IfThen(LeftStr(selI202.FieldByName('CAMPO').AsString,1) = ':','variabile','costante');
    raise Exception.Create(Format('Indicare la posizione del campo %s "%s"',
                                  [Tipo,selI202.FieldByName('CAMPO').AsString]));
  end;
end;

end.
