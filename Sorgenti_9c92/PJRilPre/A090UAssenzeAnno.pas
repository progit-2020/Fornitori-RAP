unit A090UAssenzeAnno;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, StrUtils,
  C180FunzioniGenerali, C001StampaLib, A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, ExtCtrls,DB,ComCtrls, checklst, Menus,
  C004UParamForm, QueryStorico, SelAnagrafe, C005UDatiAnagrafici,
  C700USelezioneAnagrafe, Variants, Vcl.Mask;

type
  TA090FAssenzeAnno = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnPreView: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    BtnStampa: TBitBtn;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    GroupBox1: TGroupBox;
    ListaAnagra: TCheckListBox;
    GroupBox2: TGroupBox;
    chkSegnalazPresenza: TCheckBox;
    Label3: TLabel;
    edtCaratteri: TEdit;
    chkSecCausaleAss: TCheckBox;
    chkRigaValoriz: TCheckBox;
    chkTotIndiv: TCheckBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    ListaCausali: TCheckListBox;
    Label2: TLabel;
    edtDaAnno: TSpinEdit;
    chkSaltoPag: TCheckBox;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Label1: TLabel;
    edtDaMese: TSpinEdit;
    Label4: TLabel;
    edtAMese: TSpinEdit;
    chkIntestazione: TCheckBox;
    GroupBox5: TGroupBox;
    chkData: TCheckBox;
    lblTitolo: TLabel;
    edtTitolo: TEdit;
    chkAzienda: TCheckBox;
    chkNumPagina: TCheckBox;
    chkStampaAllDip: TCheckBox;
    chkGGSett: TCheckBox;
    gbxLogo: TGroupBox;
    lblLarghezza: TLabel;
    lblAltezza: TLabel;
    edtLogoLarghezza: TEdit;
    edtLogoAltezza: TEdit;
    Label5: TLabel;
    edtFirma: TEdit;
    chkRiepilogoCompetenze: TCheckBox;
    procedure chkIntestazioneClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnPreViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkSegnalazPresenzaClick(Sender: TObject);
    procedure ListaAnagraMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListaAnagraMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtDaMeseChange(Sender: TObject);
    procedure edtAMeseChange(Sender: TObject);
    procedure edtDaAnnoChange(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtLogoLarghezzaExit(Sender: TObject);
    procedure edtLogoAltezzaExit(Sender: TObject);
  private
    MeseCorr,Sit1,Sit2,Sit3,Sit4: String;
    ItemSort,Ordine:Integer;
    SCausali: TStringList;
    DipConAssenze:Boolean;
    procedure ScorriQueryAnagrafica;
    procedure InserisciAssenze;
    procedure InserisciPresenze;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScriviMese;
  public
    DaData,AData:TDateTime;
    DocumentoPDF,TipoModulo: string;
    FlagStatus: Boolean;
  end;

var
  A090FAssenzeAnno: TA090FAssenzeAnno;

procedure OpenA090AssenzeAnno(Prog:LongInt);

implementation

uses A090UStampa, UInputTime, A090UAssenzeAnnoDtM1;

{$R *.DFM}

procedure OpenA090AssenzeAnno(Prog:LongInt);
{Stampa tabellone assenze dell'anno}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA090AssenzeAnno') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
  end;
  A090FAssenzeAnno:=TA090FAssenzeAnno.Create(nil);
  with A090FAssenzeAnno do
    try
      C700Progressivo:=Prog;
      A090FAssenzeAnnoDtM1:=TA090FAssenzeAnnoDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A090FAssenzeAnnoDtM1.Free;
      Free;
    end;
end;

procedure TA090FAssenzeAnno.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  A090FStampa:=TA090FStampa.Create(nil);
  FlagStatus:=False;
end;

procedure TA090FAssenzeAnno.FormShow(Sender: TObject);
var
  Year, Month, Day:Word;
begin
  CreaC004(SessioneOracle,'A090',Parametri.ProgOper);
  DecodeDate(Parametri.DataLavoro, Year, Month, Day);
  edtDaAnno.Value:=Year;
  edtDaMese.Value:=Month;
  edtAMese.Value:=Month;
  DaData:=EncodeDate(Year, Month, 1);
  AData:=EncodeDate(Year, Month, R180GiorniMese(Parametri.DataLavoro));
  ItemSort:=-1;
  ListaAnagra.Items.Clear;
  with A090FAssenzeAnnoDtM1.A090MW.selI010 do
  begin
    First;
    while not Eof do
    begin
      ListaAnagra.Items.Add(FieldByName('Nome_Logico').AsString);
      Next;
    end;
  end;

  ListaCausali.Items.Clear;
  with A090FAssenzeAnnoDtM1.A090MW.Q265 do
    begin
    First;
    while not Eof do
      begin
      ListaCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
      end;
    end;
    GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

function GetTime(Time:TDateTime;Msg:String;ShowSeconds:Boolean):TDateTime;
begin
  FInputTime:=TFInputTime.Create(nil);
  FInputTime.TimeIn:=Time;
  FInputTime.ShowSeconds:=ShowSeconds;
  FInputTime.Caption:=Msg;
  FInputTime.ShowModal;
  Result:=FInputTime.TimeOut;
  FInputTime.Release;
end;

procedure TA090FAssenzeAnno.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A090FStampa.RepR);
end;

procedure TA090FAssenzeAnno.InserisciAssenze;
var Giorno,i,x,Index:Integer;
    Mese,S,Tipo:String;
    Flag: Boolean;
    DataCorr:TDateTime;
begin
  MeseCorr:='';
  Flag:=False;
  with A090FAssenzeAnnoDtM1 do
  begin
    QGiustificativiAssenza.First;
    While not QGiustificativiAssenza.Eof do
      begin
      DataCorr:=QGiustificativiAssenza.FieldByName('Data').AsDateTime;
      Mese:=FormatDateTime('mm',DataCorr);
      Giorno:=StrToInt(FormatDateTime('dd',DataCorr));
      i:=((Giorno-1)*6) + 1;
      if Mese<>MeseCorr then
        begin
        if MeseCorr <> '' then
        // cambiato mese e non primo record scrivo o aggiorna i dati del mese precedente
        begin
          if Flag then
            begin
            TabellaStampa.Edit;
            TabellaStampa.FieldByName('Situazione1').AsString:=Sit1;
            TabellaStampa.FieldByName('Situazione2').AsString:=Sit2;
            TabellaStampa.FieldByName('Situazione3').AsString:=Sit3;
            TabellaStampa.FieldByName('Situazione4').AsString:=Sit4;
            TabellaStampa.Post;
            end
          else if Trim(Sit1) <> '' then
            ScriviMese;
        end;
        MeseCorr:=Mese;
        // cerco se già esistente mese corrente
        if TabellaStampa.Locate('Progressivo;Mese',VarArrayOf([C700SelAnagrafe.FieldByName('Progressivo').AsInteger,MeseCorr]),[]) then
          begin
          Flag:=True;
          Sit1:=Format('%-186s',[TabellaStampa.FieldByName('Situazione1').AsString]);
          end
        else
          begin
          Flag:=False;
          Sit1:=StringOfChar(' ',186);
          end;
        Sit2:=StringOfChar(' ',186);
        Sit3:=StringOfChar(' ',186);
        Sit4:=StringOfChar(' ',186);
        end;
      S:=QGiustificativiAssenza.FieldByName('Causale').AsString;
      if SCausali.Find(S, Index) then
        begin
        DipConAssenze:=True;
        Tipo:='';
        if A090FAssenzeAnno.chkRigaValoriz.Checked then
          begin
          // solo se abilitata stampa riga valorizzazioni
          if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'I' then
            Tipo:=Copy(A000TraduzioneStringhe('GG'),1,5);
          if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'M' then
            Tipo:=Copy(A000TraduzioneStringhe('1/2GG'),1,5);
          if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'N' then
            Tipo:=R180MinutiOre(R180OreMinuti(QGiustificativiAssenza.FieldByName('DaOre').AsDateTime));
          if QGiustificativiAssenza.FieldByName('TipoGiust').AsString = 'D' then
            Tipo:= R180MinutiOre(R180OreMinuti(QGiustificativiAssenza.FieldByName('AOre').AsDateTime) -
                                 R180OreMinuti(QGiustificativiAssenza.FieldByName('DaOre').AsDateTime));
          end;
        S:=Format('%-5s',[S]);
        Tipo:=Format('%-5s',[Tipo]);
        if (Copy(Sit1,i,5)='     ') or (Trim(Copy(Sit1,i,5))=Trim(edtCaratteri.Text)) then
          begin
          for x:=0 to 4 do
            begin
            Sit1[i+x]:=S[x+1];
            Sit2[i+x]:=Tipo[x+1];
            end;
          end
        else
          begin
          if A090FAssenzeAnno.chkSecCausaleAss.Checked then
            begin
            // solo se abilitata stampa seconda causale
            for x:=0 to 4 do
              begin
              Sit3[i+x]:=S[x+1];
              Sit4[i+x]:=Tipo[x+1];
              end;
            end;
          end;
        end;
      QGiustificativiAssenza.Next;
      end;
      // scrivi l'ultimo Mese
      if Flag then
      begin
        TabellaStampa.Edit;
        TabellaStampa.FieldByName('Situazione1').AsString:=Sit1;
        TabellaStampa.FieldByName('Situazione2').AsString:=Sit2;
        TabellaStampa.FieldByName('Situazione3').AsString:=Sit3;
        TabellaStampa.FieldByName('Situazione4').AsString:=Sit4;
        TabellaStampa.Post;
      end
      else if Trim(Sit1) <> '' then
        ScriviMese;
  end;
end;

procedure TA090FAssenzeAnno.InserisciPresenze;
var Giorno,i,x:Integer;
    Mese:String;
    DataCorr:TDateTime;
begin
  Sit1:=StringOfChar(' ',186);
  Sit2:=StringOfChar(' ',186);
  Sit3:=StringOfChar(' ',186);
  Sit4:=StringOfChar(' ',186);
  with A090FAssenzeAnnoDtM1 do
  begin
    QPresenze.First;
    MeseCorr:=FormatDateTime('mm',QPresenze.FieldByName('Data').AsDateTime);
    While not QPresenze.Eof do
    begin
      DataCorr:=QPresenze.FieldByName('Data').AsDateTime;
      Mese:=FormatDateTime('mm',DataCorr);
      Giorno:=StrToInt(FormatDateTime('dd',DataCorr));
      i:=((Giorno-1)*6)+1;
      if Mese <> MeseCorr then
      begin
        // cambiato mese scrivi i dati del mese
        if Trim(Sit1) <> '' then
          ScriviMese;
        MeseCorr:=Mese;
      end;
      for x:=0 to Length(edtCaratteri.Text)-1 do
         Sit1[i+x]:=edtCaratteri.Text[x+1];
      QPresenze.Next;
    end;
    // scrivi l'ultimo Mese
    if Trim(Sit1) <> '' then
      ScriviMese;
  end;
end;

procedure TA090FAssenzeAnno.ScorriQueryAnagrafica;
var Mese:Integer;
    QSServizio:TQueryStorico;
begin
  with A090FAssenzeAnnoDtM1 do
  begin
    QSServizio:=TQueryStorico.Create(nil);
    QSServizio.Session:=C700SelAnagrafe.Session;
    Ordine:=0;
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
      begin
        DipConAssenze:=False;
        frmSelAnagrafe.VisualizzaDipendente;
        QSServizio.GetDatiStorici('T430INIZIO,T430FINE',C700Progressivo,DaData,AData);
        if not QSServizio.DipendenteInServizio(DaData,AData) then
        begin
          ProgressBar.StepBy(1);
          C700SelAnagrafe.Next;
          Continue;
        end;
        if chkSegnalazPresenza.Checked then
        begin
          with QPresenze do
          begin
            Close;
            SetVariable('Progressivo',C700Progressivo);
            Open;
            if not Eof then
              InserisciPresenze;
          end;
        end;
        with QGiustificativiAssenza do
        begin
          Close;
          SetVariable('Progressivo',C700Progressivo);
          Open;
          if not eof then
            InserisciAssenze;
        end;
        // inserisci i record dei mesi inesistenti
        TabellaStampa.Filter:='Progressivo='+IntToStr(C700Progressivo);
        TabellaStampa.Filtered:=False;
        TabellaStampa.Filtered:=True;
        TabellaStampa.First;

        if DipConAssenze or chkStampaAllDip.Checked then
        begin
          //scorro i mesi dal-al e inserisco vuoti solo quelli che mancano
          Sit1:=StringOfChar(' ',186);
          Sit2:=StringOfChar(' ',186);
          Sit3:=StringOfChar(' ',186);
          Sit4:=StringOfChar(' ',186);
          Mese:=edtDaMese.Value;
          while Mese <= edtAMese.Value do
          begin
            MeseCorr:=Format('%2.2d',[Mese]);
            if VarToStr(TabellaStampa.Lookup('Mese',MeseCorr,'Mese')) = '' then
              ScriviMese;
            Inc(Mese);
          end;
        end
        else
          //cancello tutti i mesi eventualmente inseriti da InserisciPresenze
          while not TabellaStampa.Eof do
            TabellaStampa.Delete;

        TabellaStampa.Filtered:=False;
        ProgressBar.StepBy(1);
        C700SelAnagrafe.Next;
        inc(Ordine);
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
    end;
  end;
end;

procedure TA090FAssenzeAnno.BtnPreViewClick(Sender: TObject);
var i: integer;
    ok: boolean;
    s,campo: string;
begin
  if FlagStatus then
    raise exception.Create('Stampa o Anteprima di stampa in corso.');
  if DaData > AData then
    raise Exception.Create('Periodo selezionato errato.');
  with A090FAssenzeAnnoDtM1 do
  begin
    S:=C700SelAnagrafe.SQL.Text;
    ok:=False;
    for i:=0 to ListaAnagra.Items.Count-1 do
      begin
      if ListaAnagra.Checked[i] then
        begin
        ok:=True;
        A090MW.selI010.Locate('NOME_LOGICO',ListaAnagra.Items[i],[]);
        Campo:=AliasTabella(A090MW.selI010.FieldByName('Nome_Campo').AsString)+'.'+A090MW.selI010.FieldByName('Nome_Campo').AsString;
        if R180InserisciColonna(S,Campo) then
          C700SelAnagrafe.Close;
        end;
      end;
    C700SelAnagrafe.SQL.Text:=S;
  end;
  if not ok then
    raise Exception.Create('Nessun dato anagrafico da stampare.');
  ok:=False;
  SCausali:=TStringList.Create;
  for i:=0 to ListaCausali.Items.Count-1 do
  begin
    if ListaCausali.Checked[i] then
    begin
      ok:=True;
      SCausali.Add(Trim(Copy(ListaCausali.Items[i],1,5)));
    end;
  end;
  if not ok then
    raise Exception.Create('Nessuna causale selezionata.');
  SCausali.Sort;
  with C700SelAnagrafe do
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DaData,AData) then
      Close;
    Open;
    StatusBar.SimpleText:=IntToStr(RecordCount) + ' Records';
    if RecordCount < 1 then
      raise Exception.Create('Nessun dipendente selezionato.');
  end;
  A090FAssenzeAnnoDtM1.CreaTabellaStampa;
  with A090FAssenzeAnnoDtM1.QGiustificativiAssenza do
  begin
    SetVariable('DaData',DaData);
    SetVariable('AData',AData);
  end;
  with A090FAssenzeAnnoDtM1.QPresenze do
  begin
    SetVariable('DaData',DaData);
    SetVariable('AData',AData);
  end;
  ScorriQueryAnagrafica;
  SCausali.Free;
  A090FStampa.CreaReport(Sender = BtnPreView);
  A090FAssenzeAnnoDtM1.TabellaStampa.Close;
end;

procedure TA090FAssenzeAnno.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
    TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=True;
end;

procedure TA090FAssenzeAnno.Annullatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
    TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=False;
end;

procedure TA090FAssenzeAnno.GetParametriFunzione;
{Leggo i parametri della form}
var x,y,i,r,posiz,k:integer;
    e:boolean;
    svalore,snome,selemento:string;
begin
  posiz:=0;
  with A090FAssenzeAnno do
  begin
    chkTotIndiv.Checked:=C004FParamForm.GetParametro('TOTINDIVIDUALI','N') = 'S';
    chkRiepilogoCompetenze.Checked:=C004FParamForm.GetParametro('RIEPCOMPETENZE','N') = 'S';
    chkSegnalazPresenza.Checked:=C004FParamForm.GetParametro('PRESENZE','N') = 'S';
    chkRigaValoriz.Checked:=C004FParamForm.GetParametro('VALORIZZA','N') = 'S';
    chkSecCausaleAss.Checked:=C004FParamForm.GetParametro('CAUSALE2','N') = 'S';
    chkSaltoPag.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
    chkGGSett.Checked:=C004FParamForm.GetParametro(UpperCase(chkGGSett.Name),'N') = 'S';
    chkStampaAllDip.Checked:=C004FParamForm.GetParametro(UpperCase(chkStampaAllDip.Name),'S') = 'S';
    edtCaratteri.Text:=C004FParamForm.GetParametro('CARATTERI','***');
    chkIntestazione.Checked:=C004FParamForm.GetParametro('INTESTAZIONE','S') = 'S';
    chkData.Checked:=C004FParamForm.GetParametro('DATASTAMPA','S') = 'S';
    chkNumPagina.Checked:=C004FParamForm.GetParametro('NUMPAGINA','S') = 'S';
    chkAzienda.Checked:=C004FParamForm.GetParametro('AZIENDA','S') = 'S';
    edtTitolo.Text:=C004FParamForm.GetParametro('TITOLO','Stampa situazione assenze dal <DAL> al <AL>');
    edtFirma.Text:=C004FParamForm.GetParametro('FIRMA','');
    if edtTitolo.Text = '' then
      edtTitolo.Text:='Stampa situazione assenze dal <DAL> al <AL>';
    edtLogoLarghezza.Text:=C004FParamForm.GetParametro('edtLogoLarghezza','0');
    edtLogoAltezza.Text:=C004FParamForm.GetParametro('edtLogoAltezza','0');
    // lettura campi selezionati
    x:=0; //contatore di paramento
    snome:='LISTAANAGRA';
    repeat
    // ciclo sui parametri LISTAANAGRA0,LISTAANAGRA1,ecc.
      svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
      y:=0; // contatore di elementi nel parametro
      if svalore<>'' then
        begin
        repeat
        // ciclo sugli elementi nel parametro max 4 per parametro
          selemento:=Trim(Copy(svalore,(y*20)+1,20));
          if selemento<>'' then
            begin
            i:=0;
            e:=true;
            r:=ListaAnagra.Items.Count;
            while (i<r) and (e) do
              begin
              if ListaAnagra.Items[i]=selemento then
                 begin
                 // ricostruisce l'ordinamento corretto
                 if posiz<>i then
                   ListaAnagra.Items.Move(i,posiz);
                 ListaAnagra.Checked[posiz]:=true;
                 e:=false;
                 inc(posiz);
                 end;
              inc(i);
              end;
            inc(y);
            end;
        until selemento ='';
        inc(x);
      end;
    until svalore ='';

    // lettura causali selezionate
    x:=0; //contatore di paramento
    snome:='LISTACAUSALI';
    repeat
    // ciclo sui parametri LISTACAUSALI0,LISTACAUSALI1,ecc.
      svalore:=C004FParamForm.GetParametro(snome+IntToStr(x),'');
      y:=0; // contatore di elementi nel parametro
      if svalore <> '' then
      begin
        repeat
        // ciclo sugli elementi nel parametro max 16 per parametro
          selemento:=Trim(Copy(svalore,(y*5)+1,5));
          k:=R180IndexOf(ListaCausali.Items,selemento,5);
          if k >= 0 then
            ListaCausali.Checked[k]:=True;
          inc(y);
        until selemento = '';
        inc(x);
      end;
    until Trim(svalore) = '';
  end;
end;

procedure TA090FAssenzeAnno.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA090FAssenzeAnno.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y,r:integer;
    svalore,snome:string;
begin
  C004FParamForm.Cancella001;
  with A090FAssenzeAnno do
    begin
    if chkTotIndiv.Checked then
      C004FParamForm.PutParametro('TOTINDIVIDUALI','S')
    else
      C004FParamForm.PutParametro('TOTINDIVIDUALI','N');
    C004FParamForm.PutParametro('RIEPCOMPETENZE',IfThen(chkRiepilogoCompetenze.Checked,'S','N'));
    if chkSegnalazPresenza.Checked then
      C004FParamForm.PutParametro('PRESENZE','S')
    else
      C004FParamForm.PutParametro('PRESENZE','N');
    if chkRigaValoriz.Checked then
      C004FParamForm.PutParametro('VALORIZZA','S')
    else
      C004FParamForm.PutParametro('VALORIZZA','N');
    if chkSecCausaleAss.Checked then
      C004FParamForm.PutParametro('CAUSALE2','S')
    else
      C004FParamForm.PutParametro('CAUSALE2','N');
    if chkSaltoPag.Checked then
      C004FParamForm.PutParametro('SALTOPAGINA','S')
    else
      C004FParamForm.PutParametro('SALTOPAGINA','N');
    if chkStampaAllDip.Checked then
      C004FParamForm.PutParametro(UpperCase(chkStampaAllDip.Name),'S')
    else
      C004FParamForm.PutParametro(UpperCase(chkStampaAllDip.Name),'N');
    if chkGGSett.Checked then
      C004FParamForm.PutParametro(UpperCase(chkGGSett.Name),'S')
    else
      C004FParamForm.PutParametro(UpperCase(chkGGSett.Name),'N');

    C004FParamForm.PutParametro('CARATTERI',edtCaratteri.Text);
    if chkIntestazione.Checked then
      C004FParamForm.PutParametro('INTESTAZIONE','S')
    else
      C004FParamForm.PutParametro('INTESTAZIONE','N');
    if chkData.Checked then
      C004FParamForm.PutParametro('DATASTAMPA','S')
    else
      C004FParamForm.PutParametro('DATASTAMPA','N');
    if chkNumPagina.Checked then
      C004FParamForm.PutParametro('NUMPAGINA','S')
    else
      C004FParamForm.PutParametro('NUMPAGINA','N');
    if chkAzienda.Checked then
      C004FParamForm.PutParametro('AZIENDA','S')
    else
      C004FParamForm.PutParametro('AZIENDA','N');
    C004FParamForm.PutParametro('TITOLO',edtTitolo.Text);
    C004FParamForm.PutParametro('FIRMA',edtFirma.Text);
    C004FParamForm.PutParametro('edtLogoLarghezza',edtLogoLarghezza.Text);
    C004FParamForm.PutParametro('edtLogoAltezza',edtLogoAltezza.Text);

    // salvo l'elenco dei campi di anagrafe selezionate
    x:=0; //contatore parametri causali
    y:=0; //contatore elementi per parametro
    svalore:='';
    snome:='LISTAANAGRA';
    r:=ListaAnagra.Items.Count;
    For i:=1 to r do
      begin
      if ListaAnagra.Checked[i-1] then
         begin
         svalore:=svalore+Format('%-20s',[ListaAnagra.Items[i-1]]);
         inc(y);
         if y=4 then
            begin
            C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
            inc(x);
            y:=0;
            svalore:='';
            end;
         end;
      end;
    C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
        // salvo l'elenco delle causali selezionate
    x:=0; //contatore parametri causali
    y:=0; //contatore elementi per parametro
    svalore:='';
    snome:='LISTACAUSALI';
    r:=ListaCausali.Items.Count;
    For i:=1 to r do
      begin
      if ListaCausali.Checked[i-1] then
         begin
         svalore:=svalore+Copy(ListaCausali.Items[i-1],1,5);
         inc(y);
         if y=16 then
            begin
            C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
            inc(x);
            y:=0;
            svalore:='';
            end;
         end;
      end;
    C004FParamForm.PutParametro(snome+IntToStr(x),svalore);
    end;
  try SessioneOracle.Commit; except end;
end;

procedure TA090FAssenzeAnno.ScriviMese;
begin
  with A090FAssenzeAnnoDtM1 do
  begin
    TabellaStampa.Insert;
    TabellaStampa.FieldByName('Ordine').AsInteger:=Ordine;
    TabellaStampa.FieldByName('Progressivo').Value:=C700SelAnagrafe.FieldByName('PROGRESSIVO').Value;
    TabellaStampa.FieldByName('Cognome').Value:=C700SelAnagrafe.FieldByName('Cognome').AsString;
    TabellaStampa.FieldByName('Mese').Value:=MeseCorr;
    TabellaStampa.FieldByName('Situazione1').AsString:=Sit1;
    TabellaStampa.FieldByName('Situazione2').AsString:=Sit2;
    TabellaStampa.FieldByName('Situazione3').AsString:=Sit3;
    TabellaStampa.FieldByName('Situazione4').AsString:=Sit4;
    TabellaStampa.Post;
  end;
  Sit1:=StringOfChar(' ',186);
  Sit2:=StringOfChar(' ',186);
  Sit3:=StringOfChar(' ',186);
  Sit4:=StringOfChar(' ',186);
end;

procedure TA090FAssenzeAnno.chkSegnalazPresenzaClick(Sender: TObject);
begin
  edtCaratteri.Enabled:=chkSegnalazPresenza.Checked;
  Label3.Enabled:=chkSegnalazPresenza.Checked;
end;

procedure TA090FAssenzeAnno.ListaAnagraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ItemSort:=ListaAnagra.ItemIndex;
end;

procedure TA090FAssenzeAnno.ListaAnagraMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (ItemSort <> -1) and (ItemSort <> ListaAnagra.ItemIndex) then
    begin
    C1:=ListaAnagra.Checked[ItemSort];
    C2:=ListaAnagra.Checked[ListaAnagra.ItemIndex];
    ListaAnagra.Items.Exchange(ItemSort,ListaAnagra.ItemIndex);
    ListaAnagra.Checked[ItemSort]:=C2;
    ListaAnagra.Checked[ListaAnagra.ItemIndex]:=C1;
    end;
  ItemSort:= - 1;
end;

procedure TA090FAssenzeAnno.edtDaMeseChange(Sender: TObject);
begin
  DaData:=EncodeDate(edtDaAnno.Value, edtDaMese.Value, 1);
end;

procedure TA090FAssenzeAnno.edtLogoAltezzaExit(Sender: TObject);
begin
  try
    edtLogoAltezza.Text:=IntToStr(StrToInt(edtLogoAltezza.Text));
  except
    edtLogoAltezza.Text:=C004FParamForm.GetParametro('edtLogoAltezza','0');
  end;
end;

procedure TA090FAssenzeAnno.edtLogoLarghezzaExit(Sender: TObject);
begin
  try
    edtLogoLarghezza.Text:=IntToStr(StrToInt(edtLogoLarghezza.Text));
  except
    edtLogoLarghezza.Text:=C004FParamForm.GetParametro('edtLogoLarghezza','0');
  end;
end;

procedure TA090FAssenzeAnno.edtAMeseChange(Sender: TObject);
begin
  AData:=EncodeDate(edtDaAnno.Value, edtAMese.Value, 1);
  AData:=EncodeDate(edtDaAnno.Value, edtAMese.Value, R180GiorniMese(AData));
end;
procedure TA090FAssenzeAnno.edtDaAnnoChange(Sender: TObject);
begin
  DaData:=EncodeDate(edtDaAnno.Value, edtDaMese.Value, 1);
  AData:=EncodeDate(edtDaAnno.Value, edtAMese.Value, 1);
  AData:=EncodeDate(edtDaAnno.Value, edtAMese.Value, R180GiorniMese(AData));
end;

procedure TA090FAssenzeAnno.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA090FAssenzeAnno.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=DaData;
  C700DataLavoro:=AData;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA090FAssenzeAnno.FormDestroy(Sender: TObject);
begin
  A090FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA090FAssenzeAnno.chkIntestazioneClick(Sender: TObject);
begin
  chkData.Enabled:=chkIntestazione.Checked;
  chkAzienda.Enabled:=chkIntestazione.Checked;
  chkNumPagina.Enabled:=chkIntestazione.Checked;
  lblTitolo.Enabled:=chkIntestazione.Checked;
  edtTitolo.Enabled:=chkIntestazione.Checked;
  lblLarghezza.Enabled:=chkIntestazione.Checked;
  edtLogoLarghezza.Enabled:=chkIntestazione.Checked;
  lblAltezza.Enabled:=chkIntestazione.Checked;
  edtLogoAltezza.Enabled:=chkIntestazione.Checked;
end;

end.
