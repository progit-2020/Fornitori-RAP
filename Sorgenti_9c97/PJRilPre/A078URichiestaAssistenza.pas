unit A078URichiestaAssistenza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe,
  A003UDataLavoroBis, C180FunzioniGenerali, SelAnagrafe, ComCtrls, C004UParamForm,
  ImgList, ActnList, Menus, Shellapi, Variants, StrUtils, DB, OracleData,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.ImageList,
  System.Actions, System.Hash;

type
  TA078FRichiestaAssistenza = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    memoDescrizione: TMemo;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    edtMatricole: TEdit;
    frmSelAnagrafe: TfrmSelAnagrafe;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    edtContatto: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label11: TLabel;
    edtRiferimento: TEdit;
    edtRagioneSociale: TEdit;
    edtTelefono: TEdit;
    Panel2: TPanel;
    Label9: TLabel;
    edtCodiceErrore: TEdit;
    Label4: TLabel;
    edtMaschera: TEdit;
    Label10: TLabel;
    btnCrea: TBitBtn;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    Esporta1: TMenuItem;
    Crea1: TMenuItem;
    Close1: TMenuItem;
    ActionList1: TActionList;
    actEsporta: TAction;
    actCrea: TAction;
    actClose: TAction;
    ImageList1: TImageList;
    N1: TMenuItem;
    Label15: TLabel;
    edtMail: TEdit;
    Label16: TLabel;
    edtServer: TEdit;
    Label17: TLabel;
    edtUserID: TEdit;
    Label14: TLabel;
    edtAccessoRemoto: TEdit;
    Label12: TLabel;
    edtFax: TEdit;
    Label5: TLabel;
    edtPassword: TEdit;
    pgrBarAvanzamento: TProgressBar;
    btnEsporta: TBitBtn;
    DlgEsporta: TSaveDialog;
    Assistenzaremota1: TMenuItem;
    actTeamViewer: TAction;
    NTRSupport1: TMenuItem;
    N2: TMenuItem;
    actDownloadTeamViewer: TAction;
    DownloadTeamViewer1: TMenuItem;
    HTTPRequest: TNetHTTPRequest;
    HTTPClient: TNetHTTPClient;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actEsportaExecute(Sender: TObject);
    procedure actCreaExecute(Sender: TObject);
    procedure actTeamViewerExecute(Sender: TObject);
    procedure actDownloadTeamViewerExecute(Sender: TObject);
  private
    { Private declarations }
    FreeData:TStringList;
    DallaData,AllaData:TDateTime;
    VersioneApplicativo,VersioneDB,PrimaMatricola:String;
    Interrompi:Boolean;
    FTxt:TextFile;
    procedure CreaInsert(InFile, StrQry:string);
    procedure T360T760(var StrList:TStringList;sql:string);
    function Apici(Valore,TagValore :string;Tipo :TFieldType):string;
  public
    { Public declarations }
  end;

var
  A078FRichiestaAssistenza: TA078FRichiestaAssistenza;

const
  TEAM_VIEWER_EXE    = 'TMVW_medp.exe';
  TEAM_VIEWER_URL    = 'https://www.mondoedp.com/uploads/media/irisftp/download/' + TEAM_VIEWER_EXE;
  TEAM_VIEWER_SHA256 = 'a8f65004cb9179fd29e5c97fff213ddeb5daf50a356d10762ec6e22971c3ef42'; // certutil -hashfile TMVW_medp.exe SHA256

procedure OpenA078RichiestaAssistenza(Prog:LongInt);

implementation

uses A078UVisFile, A078UExpTabelle, A078URichiestaAssistenzaDtM1;

{$R *.DFM}

procedure OpenA078RichiestaAssistenza(Prog:LongInt);
{Esportazione dati del dipendente}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  A078FRichiestaAssistenzaDtM1:=TA078FRichiestaAssistenzaDtM1.Create(nil);
  with A078FRichiestaAssistenza do
    try
      A078FRichiestaAssistenza:=TA078FRichiestaAssistenza.Create(nil);
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A078FRichiestaAssistenzaDtM1.Free;
    end;
end;

procedure TA078FRichiestaAssistenza.T360T760(var StrList:TStringList;sql:string);
var i:integer;
begin
  with A078FRichiestaAssistenzaDtM1 do
  begin
    DtsT360T760.Close;
    DtsT360T760.SQL.Clear;
    DtsT360T760.SQL.Add(sql);
    DtsT360T760.Open;
    StrList.Add('----------' + R180EstraiNomeTabella(sql) + '----------');
    DtsT360T760.First;
    while Not(DtsT360T760.Eof) do
    begin
      for i:=0 to DtsT360T760.Fields.Count - 1 do
        StrList.Add(Format('%-30s: %s',[DtsT360T760.Fields[i].FieldName, DtsT360T760.Fields[i].AsString]));
      DtsT360T760.Next;
    end;
    DtsT360T760.Close;
  end;
end;

procedure TA078FRichiestaAssistenza.FormShow(Sender: TObject);
begin
  edtRagioneSociale.Text:=Parametri.RagioneSociale;
  edtContatto.Text:='<Assistenza>';
  try
    VersioneApplicativo:=Parametri.VersionePJ;
    A078FRichiestaAssistenzaDtM1.selVersion.Execute;
    VersioneDB:=A078FRichiestaAssistenzaDtM1.selVersion.FieldAsString('BANNER');
  except
    VersioneDB:='Non Disponibile';
  end;
  DallaData:=R180InizioMese(Parametri.DataLavoro);
  AllaData:=R180FineMese(Parametri.DataLavoro);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar1,0,True);
  CreaC004(SessioneOracle,'A078',Parametri.ProgOper);
  edtRiferimento.Text:=C004FParamForm.GetParametro('RIFERIMENTO',edtRiferimento.Text);
  edtTelefono.Text:=C004FParamForm.GetParametro('TELEFONO',edtTelefono.Text);
  edtFax.Text:=C004FParamForm.GetParametro('FAX',edtFax.Text);
  edtMail.Text:=C004FParamForm.GetParametro('MAIL',edtMail.Text);
  edtServer.Text:=C004FParamForm.GetParametro('SERVER',edtServer.Text);
  edtUserID.Text:=C004FParamForm.GetParametro('USERID',edtUserID.Text);
  edtPassword.Text:=C004FParamForm.GetParametro('PASSWORD',edtPassword.Text);
  edtAccessoRemoto.Text:=C004FParamForm.GetParametro('ACCESSOREMOTO',edtAccessoRemoto.Text);
  PrimaMatricola:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
end;

procedure TA078FRichiestaAssistenza.FormDestroy(Sender: TObject);
begin
  FreeData.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('RIFERIMENTO',edtRiferimento.Text);
  C004FParamForm.PutParametro('TELEFONO',edtTelefono.Text);
  C004FParamForm.PutParametro('FAX',edtFax.Text);
  C004FParamForm.PutParametro('MAIL',edtMail.Text);
  C004FParamForm.PutParametro('SERVER',edtServer.Text);
  C004FParamForm.PutParametro('USERID',edtUserID.Text);
  C004FParamForm.PutParametro('PASSWORD',edtPassword.Text);
  C004FParamForm.PutParametro('ACCESSOREMOTO',edtAccessoRemoto.Text);
  try SessioneOracle.Commit; except end;
  FreeAndNil(C004FParamForm);
  //Salvataggio dei dati SMTP anche per B005 Aggiornamento base dati
  CreaC004(SessioneOracle,'B005',-1);
  if C004FParamForm.GetParametro('SERVER','') = '' then
  begin
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('INDIRIZZO',edtMail.Text);
    C004FParamForm.PutParametro('SERVER',edtServer.Text);
    C004FParamForm.PutParametro('UTENTE',edtUserID.Text);
    C004FParamForm.PutParametro('PASSWORD',edtPassword.Text);
  end;
  try SessioneOracle.Commit; except end;
  FreeAndNil(C004FParamForm);
end;

procedure TA078FRichiestaAssistenza.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(nil);
  with C700SelAnagrafe do
  begin
    First;
    PrimaMatricola:='';
    PrimaMatricola:=FieldByName('MATRICOLA').AsString;
    edtMatricole.Text:='';
    while not Eof do
    begin
     if edtMatricole.Text <> '' then
       edtMatricole.Text:=edtMatricole.Text + ',';
     edtMatricole.Text:=edtMatricole.Text + FieldByName('MATRICOLA').AsString;
     Next;
    end;
  end;
end;

procedure TA078FRichiestaAssistenza.actCloseExecute(Sender: TObject);
begin
  Close;
end;

function TA078FRichiestaAssistenza.Apici(Valore,TagValore:string;Tipo :TFieldType):string;
begin
  if (Tipo = ftDateTime) then
    Valore:='TO_DATE('''+ TagValore + FormatDateTime('DD/MM/YYYY hh.mm',StrToDateTime(Valore)) + TagValore + ''',''DD/MM/YYYY HH24.MI'')';

  if (Tipo = ftString) then
  begin
    Valore:='''' + TagValore + C180FunzioniGenerali.AggiungiApice(Valore) + TagValore + '''';
    Valore:=StringReplace(Valore,#13#10,'''||CHR(13)||CHR(10)||''',[rfReplaceAll]);
  end;

  if (Tipo <> ftString) and (Tipo <> ftDateTime) then
    Valore:=TagValore + StringReplace(Valore,',','.',[rfReplaceAll]) + TagValore;

 Result:=Valore;
end;

procedure TA078FRichiestaAssistenza.CreaInsert(InFile, StrQry:string);
var FInsert, FValues, Tabella, TagKey, TagValue, ValoreRic, Virg:string;
    i, j, CountTag:integer;
    Taggamento:Boolean;
begin
  with A078FRichiestaAssistenzaDtm1 do
  begin

    DtsI500.Open;

    SelTab.SQL.Clear;
    SelTab.SQL.Add(StrQry);
    SelTab.Close;
    SelTab.Open;
    //Eseguire query per la chiave primaria
    Tabella:=UpperCase(C180FunzioniGenerali.R180EstraiNomeTabella(StrQry));
    SelPrimaryKey.SetVariable('NomeTab', Tabella);
    SelPrimaryKey.Open;

    SelTab.First;
    while not(SelTab.Eof) and (Not(Interrompi)) do
    begin
      Application.ProcessMessages;
      FInsert:='';
      FInsert:='INSERT INTO ' + Tabella + ' (';
      FValues:='';
      FValues:=' VALUES (';
      CountTag:=1;
      for i:=0 to SelTab.Fields.Count - 1 do
      begin
        Taggamento:=False;
        j:=Low(A078UExpTabelle.A078Relazioni);
        while ((j <= High(A078UExpTabelle.A078Relazioni)) and (Taggamento <> True)) do
        begin
          ValoreRic:=Tabella + '.' + SelTab.Fields[i].FieldName;
          if ((ValoreRic = A078UExpTabelle.A078Relazioni[j].Padre) or (ValoreRic = A078UExpTabelle.A078Relazioni[j].Figlio)) then
            Taggamento:=True;
          inc(j);
        end;
        //verificare se
        //Tabella + '.' + SelTab.Fields[i].FieldName
        //esiste in A078Relazioni.Figlio o A078Relazioni.Padre
        //Se esiste, trattarlo esattamente come si fa già per i campi chiave
        //VERIFICARE SE IL CAMPO FA PARTE DELLA CHIAVE PRIMARIA E TAGGARLO OPPORTUNAMENTE CON @x@ e #x#
        {SelPrimaryKey.First;
        while not(SelPrimaryKey.Eof) and (Taggamento <> True) do
        begin
          if (LowerCase(SelPrimaryKey.FieldByName('NameKey').AsString) = LowerCase(SelTab.Fields[i].FieldName)) or ((SelTab.Fields[i].FieldName = 'MATRICOLA') and
          (Tabella = 'T030_ANAGRAFICO')) then
            Taggamento:=True;
          SelPrimaryKey.Next;
        end;}

        TagKey:='';
        TagValue:='';
        if Taggamento = True then
        begin
          TagKey:='@' + IntToStr(CountTag) + '@';
          TagValue:='#' + IntToStr(CountTag) + '#';
          CountTag:=CountTag + 1;
        end;

        if ((Tabella = 'T430_STORICO') and (DtsI500.SearchRecord('NOMECAMPO',SelTab.Fields[i].FieldName,[srFromBeginning]))) then
        begin
          //MEMORIZZAZIONE IN UNA STRINGLIST DEI DATI STORICI PRESENTI NELLA I500_DATILIBERI
          FreeData.Add(Format('%-30s: %s',[SelTab.Fields[i].FieldName, SelTab.Fields[i].AsString]));
        end
        else
        begin
          if ((SelTab.Fields[i].FieldName = 'DATADECORRENZA') or (SelTab.Fields[i].FieldName = 'DATAFINE')) and (Tabella='T430_storico') then
            FreeData.Add(Format('%-30s: %s',[SelTab.Fields[i].FieldName, SelTab.Fields[i].AsString]));
          //CONTROLLO PER NON IMPORTARE NOME, COGNOME, CODFISCALE
          if not((Tabella = 'T030_ANAGRAFICO') and ((SelTab.Fields[i].FieldName = 'COGNOME') or
             (SelTab.Fields[i].FieldName = 'NOME') or (SelTab.Fields[i].FieldName = 'CODFISCALE'))) then
          begin
            virg:='';
            if (i > 0) then
              virg:=', ';
            FInsert:=FInsert + virg + TagKey + SelTab.Fields[i].FieldName + TagKey;
            if not (SelTab.Fields[i].IsNull) then
              FValues:=FValues + virg + Apici(SelTab.Fields[i].AsString, TagValue, SelTab.Fields[i].DataType)
            else
              FValues:=FValues + virg + TagValue + 'NULL' + TagValue;
          end;
        end;
        if i >= SelTab.Fields.Count -1 then
        begin
          FInsert:=FInsert + ')';
          FValues:=FValues + ');';
        end;
      end;
      if (FreeData.Count > 0) and (Tabella = 'T430_STORICO') then
        FreeData.Strings[FreeData.Count - 1]:=FreeData.Strings[FreeData.Count - 1] + #13#10;
      Writeln(FTxt,FInsert + FValues);
      SelTab.next;
    end;
    SelPrimaryKey.Close;
    DtsI500.Close;
  end;
end;

procedure TA078FRichiestaAssistenza.actEsportaExecute(Sender: TObject);
var FilePath, StrSql, progressivo, Msg:String;
    i:integer;

function ReplaceDatiLiberi(Sql:String):String;
begin
//===========================================================
//APRO LA QUERY CONTENENTE I DATI LIBERI RELATIVI ALL'AZIENDA
//===========================================================
  with A078FRichiestaAssistenzaDtm1 do
  begin
    if (selI091.GetVariable('AZIENDA') <> Parametri.Azienda)
       or Not(selI091.Active) then
    begin
      selI091.Close;
      selI091.ClearVariables;
      selI091.SetVariable('AZIENDA',Parametri.Azienda);
      selI091.Open;
    end;

    selI091.First;
    while Not(selI091.Eof) do
    begin
      If (pos('<' + selI091.FieldByName('TIPO').AsString + '>',Sql) > 0) then
        if selI091.FieldByName('DATO').AsString <> '' then
          Sql:=StringReplace(Sql,'<' + selI091.FieldByName('TIPO').AsString + '>',selI091.FieldByName('DATO').AsString,[rfReplaceAll])
        else
          Sql:='';
      selI091.Next;
    end;
  end;

  Result:=Sql;
end;

begin
  pgrBarAvanzamento.Min:=Low(A078ElencoQuery);
  pgrBarAvanzamento.Max:=High(A078ElencoQuery);
  if DallaData > AllaData then
    raise Exception.Create('Il periodo indicato non è valido!');
  if PrimaMatricola = '' then
    raise Exception.Create('Selezionare almeno una matricola!');
  if R180MessageBox('Verrà esportata solo la matricola ' + PrimaMatricola + ' Confermi esportazione?','DOMANDA') = mrYes then
  begin
    DlgEsporta.InitialDir:='Archivi\Temp\';
    DlgEsporta.FileName:='EsportaMatricola' + PrimaMatricola + '.txt';
    if Not(DlgEsporta.Execute) then
      Exit;

    FilePath:=DlgEsporta.FileName;

    Msg:='';
    if(FileExists(FilePath)) then
      deletefile(FilePath);

    AssignFile(FTxt,FilePath);
    try
      Screen.Cursor:=CrHourGlass;
      Rewrite(FTxt);
      Writeln(FTxt,'----------' + VersioneDB + '----------');

      T360T760(FreeData,'SELECT * FROM T360_TERMENSA');
      T360T760(FreeData,'SELECT * FROM T760_REGOLEINCENTIVI');

      StrSql:='SELECT PROGRESSIVO FROM T030_ANAGRAFICO WHERE MATRICOLA=''' + PrimaMatricola + '''';
      with A078FRichiestaAssistenzaDtM1 do
      begin
        SelTab.Close;
        SelTab.SQL.Clear;
        SelTab.SQL.Add(StrSql);
        SelTab.Open;
        progressivo:=SelTab.FieldByName('PROGRESSIVO').AsString;
        i:=Low(A078ElencoQuery);
        Self.Enabled:=False;
        Self.KeyPreview:=True;
        Self.OnKeyPress:=FormKeyPress;

        FreeData.Add('----------DATI_LIBERI----------');
        Interrompi:=False;
        while (i <= High(A078ElencoQuery)) and (not Interrompi) do
        begin
          Application.ProcessMessages;
          StrSql:=StringReplace(A078ElencoQuery[i],'<PROGRESSIVO>',progressivo,[rfReplaceAll]);
          StrSql:=ReplaceDatiLiberi(StrSql);

          StatusBar1.Panels[1].Text:='Premere ESC per interrompere - ' + R180EstraiNomeTabella(StrSql);
          StatusBar1.Refresh;
          try
            if StrSql <> '' then
              CreaInsert(FilePath, StrSql);
          except
            on E:Exception do
              Msg:=Msg + #13#10 + R180EstraiNomeTabella(StrSql) + ' : ' + E.Message;
          end;
          pgrBarAvanzamento.Position:=i;
          inc(i);
        end;
      end;
      Self.Enabled:=True;
      Self.KeyPreview:=False;
      Self.OnKeyPress:=nil;

      Writeln(FTxt,'/*----------DATI_AZIENDA----------');
      with A078FRichiestaAssistenzaDtM1 do
      begin
        SelTab.Close;
        SelTab.SQL.Clear;
        SelTab.SQL.Add('SELECT (I090.AZIENDA || '' ''  || I090.VERSIONEDB || ''('' || I090.PATCHDB || '')'') AS AZINVERS');
        SelTab.SQL.Add('FROM I090_ENTI I090');
        SelTab.SQL.Add('WHERE I090.AZIENDA=''' + Parametri.Azienda + '''');
        SelTab.Open;
        SelTab.First;
        Writeln(FTxt,SelTab.Fields[0].AsString);

        SelTab.Close;
        SelTab.SQL.Clear;
        SelTab.SQL.Add('select TIPO,DATO from i091_datiente t where azienda = ''' +  Parametri.Azienda + ''' AND DATO IS NOT NULL');
        SelTab.Open;
        SelTab.First;
        while not(SelTab.Eof) do
        begin
          Writeln(FTxt,Format('%-30s: %s',[SelTab.FieldByName('TIPO').AsString,SelTab.FieldByName('DATO').AsString]));
          SelTab.Next;
        end;
        SelTab.SQL.Clear;
      end;

      i:=0;
      while (i <= FreeData.Count - 1) do
      begin
        Writeln(FTxt,FreeData.Strings[i]);
        inc(i);
      end;
      Writeln(FTxt,'*/');
    finally
      CloseFile(FTxt);
      Screen.Cursor:=CrDefault;
      if Msg = '' then
        ShowMessage('Esportazione terminata correttamente nel file ''' + FilePath + '''')
      else
        ShowMessage('Esportazione terminata con errori nel file ''' + FilePath + '''' + Msg);
      pgrBarAvanzamento.Position:=0;
    end;
  end;
end;

procedure TA078FRichiestaAssistenza.actTeamViewerExecute(Sender: TObject);
begin
  if not FileExists(TEAM_VIEWER_EXE) then
  begin
    if MessageDlg('Il file ' + TEAM_VIEWER_EXE + ' necessario per la teleassistenza non è disponibile.' + CRLF + 'Eseguire il download automatico?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      Exit;
    actDownloadTeamViewerExecute(Sender);
  end;
  if FileExists(TEAM_VIEWER_EXE) then
    ShellExecute(self.WindowHandle,'open',PChar(TEAM_VIEWER_EXE),nil,nil, SW_SHOWNORMAL);
end;

procedure TA078FRichiestaAssistenza.actCreaExecute(Sender: TObject);
var S:TStringList;
begin
  if DallaData > AllaData then
    raise Exception.Create('Il periodo indicato non è valido!');
  S:=TStringList.Create;
  S.Add('                                   Spett.le Ditta MONDOEDP');
  S.Add('                                   via Barbaresco, 11');
  S.Add('                                   12100 - CUNEO - ');
  S.Add(' ');
  S.Add('                                   All''attenzione di: ' + edtContatto.Text);
  S.Add(' ');
  S.Add(' ');
  S.Add('Mittente: ' + edtRagioneSociale.Text);
  S.Add('  Persona di riferimento: ' + edtRiferimento.Text);
  S.Add('  Telefono: ' + edtTelefono.Text + '  Fax: ' + edtFax.Text);
  S.Add('  E-mail: ' + edtMail.Text);
  S.Add('  Accesso remoto: ' + edtAccessoRemoto.Text);
  S.Add(' ');
  S.Add('  Versione applicativo: ' + VersioneApplicativo);
  S.Add('  Versione DB: ' + VersioneDB);
  S.Add(' ');
  S.Add(' ');
  S.Add(' ');
  S.Add('ESEMPI:');
  S.Add('  Matricole: ' + edtMatricole.Text);
  S.Add('  Periodo: ' + DateToStr(DallaData) + ' - ' + DateToStr(AllaData));
  S.Add(' ');
  S.Add('ERRORE/PROBLEMA:');
  S.Add('  Sigla maschera: ' + edtMaschera.Text);
  S.Add('  Codice errore: ' + edtCodiceErrore.Text);
  S.Add('  Descrizione: ' + EliminaRitornoACapo(memoDescrizione.Text));
  S.Add(' ');
  S.Add(' ');
  S.Add(' ');
  S.Add('                                   Cordiali Saluti');
  Application.CreateForm(TA078FVisFile,A078FVisFile);
  A078FVisFile.memoComunicazione.Lines.AddStrings(S);
  A078FVisFile.Contatto:=edtContatto.Text;
  A078FVisFile.EMail:='Mittente: ' + edtRagioneSociale.Text + '%0D%0A' +
                      '  Persona di riferimento: ' + edtRiferimento.Text + '%0D%0A' +
                      '  Telefono: ' + edtTelefono.Text + '  Fax: ' + edtFax.Text + '%0D%0A' +
                      '  E-mail: ' + edtMail.Text + '%0D%0A' +
                      '  Accesso remoto: ' + edtAccessoRemoto.Text + '%0D%0A' +
                      '%0D%0A' +
                      '  Versione applicativo: ' + VersioneApplicativo + '%0D%0A' +
                      '  Versione DB: ' + VersioneDB + '%0D%0A' +
                      '%0D%0A' +
                      '%0D%0A' +
                      '%0D%0A' +
                      'ESEMPI:' + '%0D%0A' +
                      '  Matricole: ' + edtMatricole.Text + '%0D%0A' +
                      '  Periodo: ' + DateToStr(DallaData) + ' - ' + DateToStr(AllaData) + '%0D%0A' +
                      '%0D%0A' +
                      'ERRORE/PROBLEMA:' + '%0D%0A' +
                      '  Sigla maschera: ' + edtMaschera.Text + '%0D%0A' +
                      '  Codice errore: ' + edtCodiceErrore.Text + '%0D%0A' +
                      '  Descrizione: ' + EliminaRitornoACapo(memoDescrizione.Text) + '%0D%0A' +
                      '%0D%0A' +
                      '%0D%0A' +
                      '%0D%0A' +
                      '                                   Cordiali Saluti';
  A078FVisFile.ShowModal;
  FreeAndNil(A078FVisFile);
  FreeAndNil(S);
end;

procedure TA078FRichiestaAssistenza.actDownloadTeamViewerExecute(Sender: TObject);
var
  HTTPResponse: IHTTPResponse;
  FileStream: TFileStream;
begin
  if FileExists(TEAM_VIEWER_EXE) then
  begin
    if MessageDlg('Il file ' + TEAM_VIEWER_EXE + ' è già disponibile.' + CRLF + 'Si vuole rifare il download?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
      Exit;
  end;
  HTTPResponse:=HTTPRequest.Get(TEAM_VIEWER_URL);
  if (HTTPResponse.StatusCode = 200) then
  begin
    try
      FileStream:=TFileStream.Create(TEAM_VIEWER_EXE, fmCreate);
      FileStream.CopyFrom(HTTPResponse.ContentStream, 0);
    finally
      FreeAndNil(FileStream);
    end;
    if FileExists(TEAM_VIEWER_EXE) then
    begin
      if not (THashSHA2.GetHashStringFromFile(TEAM_VIEWER_EXE, SHA256) = TEAM_VIEWER_SHA256) then
      begin
        DeleteFile(TEAM_VIEWER_EXE);
        raise Exception.Create('Impossibile avviare il file, potrebbe essere danneggiato o incompleto!');
      end
      else
      begin
        if (FileExists(TEAM_VIEWER_EXE))
          and (Sender = actDownloadTeamViewer)
          and (MessageDlg('Desideri avviare il file ' + TEAM_VIEWER_EXE +
          ' appena scaricato?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
            actTeamViewerExecute(Sender);
      end;
    end
    else
      raise Exception.Create('Impossibile salvare il file');
  end
  else
    raise Exception.Create('Errore nella comunicazione con il server');
end;

procedure TA078FRichiestaAssistenza.FormCreate(Sender: TObject);
begin
  FreeData:=TStringList.Create;
  Self.OnKeyPress:=nil;
end;

procedure TA078FRichiestaAssistenza.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
    if MessageDlg('Interrompere l''elaborazione?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      Interrompi:=True;
end;

end.
