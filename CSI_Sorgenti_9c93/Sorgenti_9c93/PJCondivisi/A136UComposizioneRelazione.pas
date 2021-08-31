unit A136UComposizioneRelazione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, Grids, DBGrids, ExtCtrls, Buttons, StdCtrls, Oracle, OracleData, ComCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, C015UElencoValori, C180FunzioniGenerali,
  Menus, ActnList, StrUtils,A000UMessaggi;

type
  TA136FComposizioneRelazione = class(TForm)
    pnlCampiRelazioni: TPanel;
    dgrdValoriColonne: TDBGrid;
    edtColonnaPilotata: TEdit;
    edtColonnaPilota: TEdit;
    sbtnColonnaPilota: TSpeedButton;
    lblColonnaPilotata: TLabel;
    lblColonnaPilota: TLabel;
    lblTabellaPilotata: TLabel;
    edtTabellaPilotata: TEdit;
    pnlAzioni: TPanel;
    StatusBar1: TStatusBar;
    lblTabellaPilota: TLabel;
    edtTabellaPilota: TEdit;
    pnlTitoloAbbinamenti: TPanel;
    btnConferma: TBitBtn;
    btnAnnulla: TBitBtn;
    PopupMenu3: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N2: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    ActionList1: TActionList;
    actRicercaTestoContenuto: TAction;
    actSuccessivo: TAction;
    N1: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo1: TMenuItem;
    lblDecorrenza: TLabel;
    edtDecorrenza: TEdit;
    lblTipo: TLabel;
    edtTipo: TEdit;
    lblDTipo: TLabel;
    procedure sbtnColonnaPilotaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure actRicercaTestoContenutoExecute(Sender: TObject);
  private
    { Private declarations }
    SqlRelazione:String;
    TestoContenuto: String;
    //procedure ComponiRelazione;
//  procedure RecuperaValoriPilota;
//  procedure CaricaValoriPilotati(ValoriAbbinati:String);
    procedure CaricaPickListPilota;
    procedure CaricaPickListPilotata;
  public
    { Public declarations }
    Apri,Confermato:Boolean;
    procedure AggiornaStatusBar(DataSet: TDataSet);
  end;

var
  A136FComposizioneRelazione: TA136FComposizioneRelazione;

implementation

uses
  A136URelazioniAnagrafe, A136URelazioniAnagrafeDtm;

{$R *.dfm}

procedure TA136FComposizioneRelazione.FormCreate(Sender: TObject);
var
ValorePilota,ValorePilotato,S,CampoPilota,sAbbinaValori:String;
bUnion:Boolean;
begin
  with A136FRelazioniAnagrafeDtm do
  begin
    //Inizializzazione
    A136FRelazioniAnagrafeMW.A136CdsRelazioniScroll:=AggiornaStatusBar;
    dgrdValoriColonne.DataSource:=A136FRelazioniAnagrafeMW.DCampiRelazioni;
    Apri:=True;
    Confermato:=False;
    sbtnColonnaPilota.Enabled:=not SolaLettura;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EmptyDataSet;
    (*
    cdsCampiRelazioni.FieldByName('VALOREPILOTA').DisplayLabel:='Valore pilota';
    cdsCampiRelazioni.FieldByName('VALOREPILOTATO').DisplayLabel:='Valore pilotato';
    *)
    //Recupero valori da I030/I035
    edtTabellaPilotata.Text:=selI030.FieldByName('TABELLA').AsString;
    edtColonnaPilotata.Text:=selI030.FieldByName('COLONNA').AsString;
    edtDecorrenza.Text:=selI030.FieldByName('DECORRENZA').AsString;
    edtTipo.Text:=selI030.FieldByName('TIPO').AsString;
    lblDTipo.Caption:=selI030.FieldByName('D_TIPO').AsString;

    edtTabellaPilota.Text:=selI030.FieldByName('TAB_ORIGINE').AsString;
    dgrdValoriColonne.Columns[0].Title.Caption:=edtColonnaPilotata.Text;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').DisplayLabel:=edtColonnaPilotata.Text;
    SQLRelazione:=A136FRelazioniAnagrafe.memRelazione.Text;
    //Estraggo i dati dalla tabella di riferimento della colonna pilotata
    Apri:=A136FRelazioniAnagrafeMW.ImpostaQuerySelezione(edtTabellaPilotata.Text,edtColonnaPilotata.Text,A136FRelazioniAnagrafeMW.selPilotato);
    if Apri then
    begin
      dgrdValoriColonne.Columns[0].PickList.Clear;
      //Imposto la colonna Descrizione in base alla tabella di provenienza
      try
        A136FRelazioniAnagrafeMW.selPilotato.Open;
        sAbbinaValori:='';
        //Se la relazione è di tipo Filtro...
        if selI030.FieldByName('TIPO').AsString = 'F' then
        begin
          //Controllo se l'inizio della relazione è standard
          if Copy(SQLRelazione,1,15) = 'SELECT DISTINCT' then
          begin
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Clear;

            if not A136FRelazioniAnagrafeMW.EstraiCampoPilota(SQLRelazione,CampoPilota) then
            begin
              if (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
                Apri:=False
              else   //Provo a caricare i valori pilotati senza abbinare i valori pilota
                A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
              Exit;
            end;

            edtColonnaPilota.Text:=CampoPilota;
            dgrdValoriColonne.Columns[2].Title.Caption:=edtColonnaPilota.Text;
            if not A136FRelazioniAnagrafeMW.RecuperaValoriPilota(edtTabellaPilota.Text,edtColonnaPilota.Text) then
            begin
              if R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_PILOTA,DOMANDA) <> mrYes then
              begin
                Apri:=False;
                Exit;
              end;
            end;
            CaricaPickListPilota;

            S:=SQLRelazione;
            S:=Copy(S,Pos('FROM',S));
            //Cerco tutti i valori pilotati specificati nella relazione
            while (Pos('(',S) > 0) or (Pos('NULL',S) > 0) do
            begin
              if not A136FRelazioniAnagrafeMW.EstraiValoriDaSQLRelazione(S,ValorePilota, ValorePilotato) then
              begin
                //...Non ho trovato né l'apice né il null
                if (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
                  Apri:=False
                else //Provo a caricare i valori pilotati senza abbinare i valori pilota
                  A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
                Exit;
              end;

              //Gestisco il caricamento dei valori pilota/pilotato nella lista
              A136FRelazioniAnagrafeMW.CaricaAbbinaValori(sAbbinaValori,ValorePilota,ValorePilotato);

              //Cerco l'eventuale Union
              bUnion:=Pos('UNION',S) > 0;
              //Mi posiziono sulla FROM per evitare l'eventuale NULL della Descrizione
              S:=Copy(S,Pos('FROM',S));
              //Se trovo altri valori pilotati ma non la Union o viceversa...
              if (((Pos('(',S) > 0) or  (Pos('NULL',S) > 0)) and not bUnion) or
                 (((Pos('(',S) = 0) and (Pos('NULL',S) = 0)) and bUnion) then
              begin
                if (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
                  Apri:=False
                else //Provo a caricare i valori pilotati senza abbinare i valori pilota
                  A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
                Exit;
              end;
            end;
          end
          else if (Trim(SQLRelazione) <> '') and
                  (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
          begin
            Apri:=False;
            Exit;
          end
          else
          begin
            //Provo a caricare i valori pilotati senza abbinare i valori pilota
            A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
            Exit;
          end;
          //Carico la lista degli abbinamenti
          if (A136FRelazioniAnagrafeMW.AbbinaValoriDuplicati(sAbbinaValori)) and
             (R180MessageBox(A000MSG_A136_DLG_VALORI_DUPLICATI,DOMANDA) <> mrYes) then
          begin
            Apri:=False;
            Exit;
          end
          else //Provo a caricare i valori pilotati abbinando i valori pilota
            A136FRelazioniAnagrafeMW.CaricaValoriPilotati(sAbbinaValori);
        end
        //Se la relazione è di tipo Vincolato o Libero...
        else if (selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L') then
        begin
          CaricaPickListPilotata;
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.IndexName:='IND_PILOTA';
          //Controllo se l'SQL contiene gli elementi standard
          if (Copy(SQLRelazione,1,10) = 'DECODE(<#>') and
             (Pos('<#>D<#>',SQLRelazione) > 0) and
             (Pos('<#>;<#>',SQLRelazione) > 0) then
          begin
            sAbbinaValori:=A136FRelazioniAnagrafeMW.EstraiAbbinaValori(SQLRelazione);
            //Carico la lista degli abbinamenti
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Clear;
            A136FRelazioniAnagrafeMW.ListaValoriSQL.QuoteChar:='''';
            A136FRelazioniAnagrafeMW.ListaValoriSQL.Delimiter:=',';
            A136FRelazioniAnagrafeMW.ListaValoriSQL.StrictDelimiter:=True;
            A136FRelazioniAnagrafeMW.ListaValoriSQL.DelimitedText:=sAbbinaValori;
            //Recupero la colonna pilota
            if not A136FRelazioniAnagrafeMW.EstraiCampoPilota(SQLRelazione,CampoPilota) then
            begin
              if (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
                Apri:=False
              else   //Provo a caricare i valori pilotati senza abbinare i valori pilota
                A136FRelazioniAnagrafeMW.CaricaValoriPilotati('');
              Exit;
            end;
            edtColonnaPilota.Text:=CampoPilota;
            //
            if edtColonnaPilota.Text <> '' then
            begin
              //Recupero i valori pilota provando ad abbinare i valori pilotati
              dgrdValoriColonne.Columns[2].Title.Caption:=edtColonnaPilota.Text;
              if not A136FRelazioniAnagrafeMW.RecuperaValoriPilota(edtTabellaPilota.Text,edtColonnaPilota.Text) then
              begin
                if R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_PILOTA,DOMANDA) <> mrYes then
                begin
                  Apri:=False;
                  Exit;
                end;
              end;
              CaricaPickListPilota;
            end;
          end
          else if (Trim(SQLRelazione) <> '') and
                  (R180MessageBox(A000MSG_A136_DLG_RELAZ_NO_STANDARD,DOMANDA) <> mrYes) then
            Apri:=False;
        end;
      except
        Apri:=False;
      end;
    end;
  end;
end;
(* Caratto 30/11/2012 spostato su MW
procedure TA136FComposizioneRelazione.CaricaValoriPilotati(ValoriAbbinati: String);
var
  I:Integer;
begin
  with A136FRelazioniAnagrafeDtm do
  begin
    //Carico la lista degli abbinamenti
    ListaValoriSQL.QuoteChar:='''';
    ListaValoriSQL.Delimiter:=',';
    ListaValoriSQL.StrictDelimiter:=True;
    ValoriAbbinati:=Copy(ValoriAbbinati,1,Length(ValoriAbbinati) - 1);
    ListaValoriSQL.DelimitedText:=ValoriAbbinati;
    //Carico i valori nel ClientDataSet
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.IndexName:='IND_PILOTATO';
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.BeforeInsert:=nil;
    //Scorro i valori pilotati
    while not A136FRelazioniAnagrafeMW.selPilotato.Eof do
    begin
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.Append;
      //I valori pilotati ce li ho sul DataSet
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=A136FRelazioniAnagrafeMW.selPilotato.FieldByName('CODICE').AsString;
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTATO').AsString:=A136FRelazioniAnagrafeMW.selPilotato.FieldByName('DESCRIZIONE').AsString;
      //I valori pilota li cerco sulla lista degli abbinamenti
      for i := 0 to ListaValoriSQL.Count - 1 do
        if (i mod 2 = 0)
        and
           ((ListaValoriSQL[i] = A136FRelazioniAnagrafeMW.selPilotato.FieldByName('CODICE').AsString) or
            ((ListaValoriSQL[i] = 'NULL') and
             (A136FRelazioniAnagrafeMW.selPilotato.FieldByName('CODICE').AsString = ''))) then
        begin
          //Se il valore pilota abbinato è null...
          if ListaValoriSQL[i+1] = 'NULL' then
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=''
          else
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=ListaValoriSQL[i+1];
          Break;
        end;
      A136FRelazioniAnagrafeMW.cdsCampiRelazioni.Post;
      A136FRelazioniAnagrafeMW.selPilotato.Next;
    end;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.BeforeInsert:=A136FRelazioniAnagrafeMW.cdsCampiRelazioniBeforeInsert;
    dgrdValoriColonne.Columns[0].ReadOnly:=True;
    dgrdValoriColonne.Columns[2].ReadOnly:=False;
  end;
end;

procedure TA136FComposizioneRelazione.RecuperaValoriPilota;
var
  T,C,D,Storico:String;
  I:Integer;
begin
  Screen.Cursor:=crHourGlass;
  dgrdValoriColonne.Columns[2].Title.Caption:=edtColonnaPilota.Text;
  A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').DisplayLabel:=edtColonnaPilota.Text;

  with A136FRelazioniAnagrafeDtm do
  begin
    if A136FRelazioniAnagrafeMW.ImpostaQuerySelezione(edtTabellaPilota.Text,edtColonnaPilota.Text,A136FRelazioniAnagrafeMW.selPilota) then
    begin

      A136FRelazioniAnagrafeMW.selPilota.Close;
      dgrdValoriColonne.Columns[2].PickList.Clear;
      try
        A136FRelazioniAnagrafeMW.selPilota.Open;
        //Se la relazione è di tipo Filtro...
        if selI030.FieldByName('TIPO').AsString = 'F' then
          while not A136FRelazioniAnagrafeMW.selPilota.Eof do
          begin
            //Carico i valori pilota nella PickList della colonna pilota
            dgrdValoriColonne.Columns[2].PickList.Add(A136FRelazioniAnagrafeMW.selPilota.FieldByName('CODICE').AsString);
            A136FRelazioniAnagrafeMW.selPilota.Next;
          end
        //Se la relazione è di tipo Vincolato o Libero...
        else if (selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L') then
        begin
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.DisableControls;
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EmptyDataSet;
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.BeforeInsert:=nil;
          while not A136FRelazioniAnagrafeMW.selPilota.Eof do
          begin
            //I valori pilota ce li ho sul DataSet
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.Append;
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTA').AsString:=A136FRelazioniAnagrafeMW.selPilota.FieldByName('CODICE').AsString;
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('DESCRIZIONEPILOTA').AsString:=A136FRelazioniAnagrafeMW.selPilota.FieldByName('DESCRIZIONE').AsString;
            //I valori pilotati li cerco sulla lista degli abbinamenti
            for i := 0 to A136FRelazioniAnagrafeMW.ListaValoriSQL.Count - 1 do
              if (i mod 2 = 0)
              and
                 ((A136FRelazioniAnagrafeMW.ListaValoriSQL[i] = A136FRelazioniAnagrafeMW.selPilota.FieldByName('CODICE').AsString) or
                  ((A136FRelazioniAnagrafeMW.ListaValoriSQL[i] = 'NULL') and
                   (A136FRelazioniAnagrafeMW.selPilota.FieldByName('CODICE').AsString = ''))) then
              begin
                //Se il valore pilotato abbinato è null...
                if A136FRelazioniAnagrafeMW.ListaValoriSQL[i+1] = 'NULL' then
                  A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=''
                else
                  A136FRelazioniAnagrafeMW.cdsCampiRelazioni.FieldByName('VALOREPILOTATO').AsString:=A136FRelazioniAnagrafeMW.ListaValoriSQL[i+1];
                Break;
              end;
            A136FRelazioniAnagrafeMW.cdsCampiRelazioni.Post;
            A136FRelazioniAnagrafeMW.selPilota.Next;
          end;
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.BeforeInsert:=A136FRelazioniAnagrafeMW.cdsCampiRelazioniBeforeInsert;
          A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EnableControls;
        end;
      except
        A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EmptyDataSet;
        if R180MessageBox('Attenzione! Impossibile caricare i dati dalla colonna pilota specificata; non è quindi possibile procedere con l''abbinamento automatico. Continuare?',DOMANDA) <> mrYes then
          Apri:=False;
      end;
    end
    else
    begin
      //Se la relazione è di tipo Vincolato o Libero ma non posso caricare i valori pilota, allora svuoto tutto
      if (selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L') then
        A136FRelazioniAnagrafeMW.cdsCampiRelazioni.EmptyDataSet;
    end;
    A136FRelazioniAnagrafeMW.cdsCampiRelazioni.First;
  end;
  Screen.Cursor:=crDefault;
end;
*)
procedure TA136FComposizioneRelazione.FormShow(Sender: TObject);
begin
  StatusBar1.SimpleText:='Record ' + IntToStr(A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni.RecNo) + '/' + IntToStr(A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni.RecordCount);
  A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni.First;
  if A136FRelazioniAnagrafe.ValoreDato <> '' then
    A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni.Locate('VALOREPILOTATO',A136FRelazioniAnagrafe.ValoreDato,[]);
  btnConferma.Enabled:=A136FRelazioniAnagrafeDtM.selI030.State <> dsBrowse;
  sbtnColonnaPilota.Enabled:=A136FRelazioniAnagrafeDtM.selI030.State <> dsBrowse;
end;

procedure TA136FComposizioneRelazione.FormDestroy(Sender: TObject);
begin
  A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.A136CdsRelazioniScroll:=nil;
end;

procedure TA136FComposizioneRelazione.sbtnColonnaPilotaClick(Sender: TObject);
var
  vCodice:Variant;
  SqlSceltaColonna: String;
  Abilitato,SolaLetturaApp: Boolean;
begin
  inherited;
  SqlSceltaColonna:='SELECT COLUMN_NAME FROM COLS WHERE TABLE_NAME = ''' + edtTabellaPilota.Text + ''' AND COLUMN_NAME NOT IN (''PROGRESSIVO'',''DATADECORRENZA'',''DATAFINE'',''DECORRENZA'',''DECORRENZA_FINE'') ORDER BY COLUMN_NAME';
  Abilitato:=False;
  while not Abilitato do
  begin
    OpenC015FElencoValori('COLS','<A136> Selezione della colonna pilota',SqlSceltaColonna,'COLUMN_NAME',vCodice,nil,350);
    if not VarIsClear(vCodice) and not VarIsNull(vCodice) then
    begin
      if edtTabellaPilota.Text = 'T430_STORICO' then
      begin
        Abilitato:=A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.selT033.SearchRecord('CAMPODB',VarToStr(vCodice[0]),[srFromBeginning]);
        if not Abilitato then
          ShowMessage(A000MSG_A136_ERR_UTENTE_NO_CAMPO);
      end
      else if edtTabellaPilota.Text = 'P430_ANAGRAFICO' then
      begin
        SolaLetturaApp:=SolaLettura;
        Abilitato:=A000GetInibizioni('Funzione','OpenP430FAnagrafico') = 'S';
        SolaLettura:=SolaLetturaApp;
        if not Abilitato then
        begin
          ShowMessage(A000MSG_A136_ERR_UTENTE_NO_TABELLA);
          Abort;
        end;
      end;
    end
    else
      Break;
  end;
  if not VarIsClear(vCodice) and not VarIsNull(vCodice) then
  begin
    edtColonnaPilota.Text:=VarToStr(vCodice[0]);
    dgrdValoriColonne.Columns[2].Title.Caption:=edtColonnaPilota.Text;
    A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.RecuperaValoriPilota(edtTabellaPilota.Text,edtColonnaPilota.Text);
    CaricaPickListPilota;
  end;
end;

procedure TA136FComposizioneRelazione.btnConfermaClick(Sender: TObject);
begin
  if edtColonnaPilota.Text = '' then
  begin
    ShowMessage('Selezionare la colonna pilota!');
    Exit;                            
  end;
  if R180MessageBox(A000MSG_A136_DLG_MODIFICHE,DOMANDA) <> mrYes then
    exit;
  Screen.Cursor:=crHourGlass;
  A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.ComponiSQLRelazione(SqlRelazione,edtColonnaPilota.Text);
  A136FRelazioniAnagrafe.memRelazione.Lines.Assign(A136FRelazioniAnagrafeDtM.A136FRelazioniAnagrafeMW.ListaSQLRelazione);
  Screen.Cursor:=crDefault;
  Confermato:=True;
  A136FComposizioneRelazione.Close;
end;

procedure TA136FComposizioneRelazione.AggiornaStatusBar(DataSet: TDataSet);
begin
  with A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW do
    StatusBar1.SimpleText:='Record ' + IntToStr(cdsCampiRelazioni.RecNo) + '/' + IntToStr(cdsCampiRelazioni.RecordCount);
end;

procedure TA136FComposizioneRelazione.btnAnnullaClick(Sender: TObject);
begin
  Confermato:=False;
  A136FComposizioneRelazione.Close;
end;

procedure TA136FComposizioneRelazione.CaricaPickListPilota;
var
  i: Integer;
begin
dgrdValoriColonne.Columns[2].PickList.Clear;

with A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW do
begin
   //Carico i valori pilota nella PickList della colonna pilota
  for i:=0 to ListaPilota.Count - 1 do
    dgrdValoriColonne.Columns[2].PickList.Add(ListaPilota[i]);
end;
end;

procedure TA136FComposizioneRelazione.CaricaPickListPilotata;
begin
  //Carico la picklist della colonna pilotata
  dgrdValoriColonne.Columns[0].PickList.Clear;
  with A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW do
  begin
    while not selPilotato.Eof do
    begin
      dgrdValoriColonne.Columns[0].PickList.Add(selPilotato.FieldByName('CODICE').AsString);
      selPilotato.Next;
    end;
  end;
  dgrdValoriColonne.Columns[0].ReadOnly:=False;
  dgrdValoriColonne.Columns[2].ReadOnly:=True;
end;

procedure TA136FComposizioneRelazione.Copia2Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdValoriColonne,Sender = CopiaInExcel);
end;

procedure TA136FComposizioneRelazione.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdValoriColonne,'S');
end;

procedure TA136FComposizioneRelazione.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdValoriColonne,'N');
end;

procedure TA136FComposizioneRelazione.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdValoriColonne,'C');
end;

procedure TA136FComposizioneRelazione.actRicercaTestoContenutoExecute(Sender: TObject);
var
  Trovato: Integer;
begin
  with A136FRelazioniAnagrafeDtm.A136FRelazioniAnagrafeMW.cdsCampiRelazioni do
    if Sender = actRicercaTestoContenuto then
    begin
      TestoContenuto:=UpperCase(FieldByName(dgrdValoriColonne.SelectedField.FieldName).AsString);
      if InputQuery('Ricerca per testo contenuto',dgrdValoriColonne.SelectedField.DisplayLabel,TestoContenuto) then
      begin
        Trovato:=0;
        DisableControls;
        while (not Eof) and (Trovato = 0) do
        begin
          Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(FieldByName(dgrdValoriColonne.SelectedField.FieldName).AsString));
          if Trovato = 0 then
            Next;
        end;
        if Trovato = 0 then
        begin
          ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun elemento della colonna "' +
            dgrdValoriColonne.SelectedField.DisplayLabel +'"');
          First;
        end;
        EnableControls;
      end;
    end
    else
    begin
      Trovato:=0;
      DisableControls;
      while (not Eof) and (Trovato = 0) do
      begin
        if Trovato = 0 then
          Next;
        Trovato:=Pos(UpperCase(TestoContenuto),UpperCase(FieldByName(dgrdValoriColonne.SelectedField.FieldName).AsString));
      end;
      if Trovato = 0 then
      begin
        ShowMessage('Il testo "' + UpperCase(TestoContenuto) + '" non è contenuto in nessun altro elemento della colonna "' +
          dgrdValoriColonne.SelectedField.DisplayLabel +'"');
        First;
      end;
      EnableControls;
    end;
end;

(* Procedura sostituita per centralizzazione della ComponiRelazione sul nuovo DataModule
procedure TA136FComposizioneRelazione.btnConfermaClick(Sender: TObject);
begin
  if edtColonnaPilota.Text = '' then
  begin
    ShowMessage('Selezionare la colonna pilota!');
    Exit;
  end;
  if R180MessageBox('Attenzione! Confermare le modifiche effettuate alla relazione?',DOMANDA) <> mrYes then
    exit;
  ComponiRelazione;
  Confermato:=True;
  A136FComposizioneRelazione.Close;
end;*)

(* Procedura sostituita per centralizzazione della ComponiRelazione sul nuovo DataModule
procedure TA136FComposizioneRelazione.ComponiRelazione;
var
  Abbinamenti,ValorePilota,ValorePilotato,CondizionePilota,CondizionePilotato:String;
  T,C,D,Storico:String;
  i:Integer;
begin
  //Inizializzazioni
  SqlRelazione:='';
  A136FRelazioniAnagrafe.memRelazione.Clear;
  with A136FRelazioniAnagrafeDtm do
  begin
    //Se la relazione è di tipo Filtro...
    if selI030.FieldByName('TIPO').AsString = 'F' then
    begin
      with cdsCampiRelazioni do
      begin
        DisableControls;
        IndexName:='IND_PILOTA';
        First;
        ValorePilota:=FieldByName('VALOREPILOTA').AsString;
        if edtTabellaPilotata.Text = 'T430_STORICO' then
          A000GetTabella(edtColonnaPilotata.Text,T,C,Storico)
        else if edtTabellaPilotata.Text = 'P430_ANAGRAFICO' then
          A000GetTabellaP430(edtColonnaPilotata.Text,T,C,Storico);
        if T = 'T480_COMUNI' then
          D:='CITTA DESCRIZIONE'
        else if (T = 'T430_STORICO') or (T = 'P430_ANAGRAFICO') then
          D:='NULL DESCRIZIONE'
        else
          D:='DESCRIZIONE';
        //Ciclo sui valori impostati
        for i := 1 to RecordCount + 1 do
        begin
          //Aggiungo i valori pilotati finché non cambia il valore pilota, non sono finiti i record o non trovo il valore pilotato Null
          if (Trim(ValorePilotato) <> ''''',') and (ValorePilota = FieldByName('VALOREPILOTA').AsString) and (not Eof) and (Length(ValorePilotato) < 750) then
            ValorePilotato:=ValorePilotato + '''' + FieldByName('VALOREPILOTATO').AsString + ''','
          else
          begin
            //Se il valore pilotato non è vuoto...
            if Trim(ValorePilotato) <> ''''',' then
              CondizionePilotato:='IN (' + Copy(ValorePilotato,1,Length(ValorePilotato)-1) + ')'
            else
              CondizionePilotato:='IS NULL';
            //Se il valore pilota è vuoto...
            if ValorePilota = '' then
            begin
              ValorePilota:='NULL';
              CondizionePilota:='IS ' + ValorePilota;
            end
            else
            begin
              ValorePilota:='''' + ValorePilota + '''';
              CondizionePilota:='= ' + ValorePilota;
            end;
            //Vado a capo quando inserisco la UNION
            if SqlRelazione <> '' then
            begin
              SqlRelazione:=SqlRelazione + #13 + ' UNION ';
              Abbinamenti:='UNION ';
            end;
            //Imposto la singola relazione
            SqlRelazione:=SqlRelazione + Format('SELECT DISTINCT %s, %s FROM %s WHERE %s %s AND %s %s',[C,D,T,C,CondizionePilotato,'<#>' + edtColonnaPilota.Text + '<#>',CondizionePilota]);
            A136FRelazioniAnagrafe.memRelazione.Lines.Add(Abbinamenti + Format('SELECT DISTINCT %s, %s FROM %s WHERE %s %s AND %s %s',[C,D,T,C,CondizionePilotato,'<#>' + edtColonnaPilota.Text + '<#>',CondizionePilota]));
            //Ridefinisco il valore pilota e il primo valore pilotato
            if not Eof then
            begin
              ValorePilota:=FieldByName('VALOREPILOTA').AsString;
              ValorePilotato:='''' + FieldByName('VALOREPILOTATO').AsString + ''',';
            end;
          end;
          Next;
        end;
        //Aggiungo l'Order By
        if SqlRelazione <> '' then
        begin
          SqlRelazione:=SqlRelazione + Format(' ORDER BY %s',[C]);
          A136FRelazioniAnagrafe.memRelazione.Lines.Add(Format('ORDER BY %s',[C]));
        end;
        IndexName:='IND_PILOTATO';
        EnableControls;
      end;
    end
    //Se la relazione è di tipo Vincolato o Libero...
    else if (selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L') then
    begin
      with cdsCampiRelazioni do
      begin
        DisableControls;
        IndexName:='IND_PILOTATO';
        First;
        I:=0;
        //Ciclo su tutti i valori impostati
        while not Eof do
        begin
          //Imposto il valore pilota
          if FieldByName('VALOREPILOTA').AsString = '' then
            ValorePilota:='NULL,'
          else
            ValorePilota:='''' + FieldByName('VALOREPILOTA').AsString + ''',';
          //Imposto il valore pilotato
          if FieldByName('VALOREPILOTATO').AsString = '' then
            ValorePilotato:='NULL,'
          else
            ValorePilotato:='''' + FieldByName('VALOREPILOTATO').AsString + ''',';
          //Abbino i valori nell'SQL della relazione
          Abbinamenti:=Abbinamenti + ValorePilota + ValorePilotato;
          I:=I+1;
          //Verifico di spezzare la riga quando supero i 750 caratteri o le 100 coppie
          if (I = 100) or (Length(Abbinamenti) >= 750) then
          begin
            if SqlRelazione <> '' then
              SqlRelazione:=SqlRelazione + #13;
            SqlRelazione:=SqlRelazione + 'DECODE(<#>' + edtColonnaPilota.Text + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#> ';
            A136FRelazioniAnagrafe.memRelazione.Lines.Add('DECODE(<#>' + edtColonnaPilota.Text + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#>');
            I:=0;
            Abbinamenti:='';
          end;
          Next;
        end;
        //Se ci sono stati degli abbinamenti, imposto la Decode
        if Abbinamenti <> '' then
        begin
          if SqlRelazione <> '' then
            SqlRelazione:=SqlRelazione + #13;
          SqlRelazione:=SqlRelazione + 'DECODE(<#>' + edtColonnaPilota.Text + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#> ';
          A136FRelazioniAnagrafe.memRelazione.Lines.Add('DECODE(<#>' + edtColonnaPilota.Text + '<#>,' + Copy(Abbinamenti,1,Length(Abbinamenti)-1) + ') <#>D<#> <#>;<#>');
        end;
        IndexName:='IND_PILOTA';
        EnableControls;
      end;
    end;
  end;
end;*)

end.
