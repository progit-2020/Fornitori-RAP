unit A058UPianifTurni;

interface
                                                               
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, DBCtrls,C180FunzioniGenerali,Spin,
  C004UParamForm, OracleData, SelAnagrafe, Menus, UITypes,
  C005UDatiAnagrafici, A003UDataLavoroBis, Variants, DB, StrUtils, A174UParPianifTurni,
  Math, R500Lin, Printers, C001StampaLib, QuickRpt, QRPDFFilt;

type
  TSquadre = record
    Squadra,DSquadra,Oper,
    S1,S2:String;
  end;

  TA058FPianifTurni = class(TForm)
    BEsegui: TBitBtn;
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    BitBtn3: TBitBtn;
    btnAnteprima: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    RgpTipo: TRadioGroup;
    lblCopiaAss: TLabel;
    lblProfilo: TLabel;
    dCmbProfili: TDBLookupComboBox;
    dLblDescProfilo: TDBText;
    ppMnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    dCmbSquadra: TDBLookupComboBox;
    dLblSquadra: TDBText;
    lblSquadra: TLabel;
    edtDataDa: TMaskEdit;
    lblDataDa: TLabel;
    btnDataDa: TButton;
    lblDataA: TLabel;
    edtDataA: TMaskEdit;
    btnDataA: TButton;
    btnStampa: TSpeedButton;
    BitBtn1: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    MyCompRep: TQRCompositeReport;
    chkIniCorr: TCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BEseguiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure dCmbSquadraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Accedi1Click(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtDataDaExit(Sender: TObject);
    procedure edtDataADblClick(Sender: TObject);
    procedure MyOnAddReports(Sender: TObject);
    procedure dCmbProfiliCloseUp(Sender: TObject);
    procedure dCmbProfiliKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RgpTipoClick(Sender: TObject);
  private
    { Private declarations }
    QRepSetting:TQuickRep;
    procedure RiempiGriglia;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure SetPeriodoDate(Sender: TObject);
    procedure Abilitazioni;
   public
    { Public declarations }
    AbilCont:Boolean;
    //DataInizio,DataFine:TDateTime;
    TipoModulo, DocumentoPDF: String;
    bVisualizzaCoperura, bVisualizzaCompetenze, bVisualizzaTurni, bVisualizzaAssenze,
    bVisualizzaRiposiFestivi, bVisualizzaBadge, bVisualizzaSintetica:Boolean;
    procedure VisualizzaGriglia;
    procedure Anteprima_Stampa(SoloAnteprima:Boolean);
  end;

var A058FPianifTurni: TA058FPianifTurni;

procedure OpenA058PianifTurni(Prog:LongInt);
procedure OpenA058VisualizzaTabellone(Prog:String; Dal,Al:TDateTime);

implementation

uses A058UPianifTurniDtM1, A058UGrigliaPianif, A058UTabellone, A058UStampaRiepTimb;

{$R *.DFM}

procedure OpenA058PianifTurni(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA058PianifTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  with A058FPianifTurni do
    try
      C700Progressivo:=Prog;
      A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A058FPianifTurniDtM1.Free;
      Free;
    end;
end;

procedure OpenA058VisualizzaTabellone(Prog:String; Dal,Al:TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA058PianifTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  with A058FPianifTurni do
    try
      //C700Progressivo:=Prog;
      A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
      FormShow(A058FPianifTurni);
      A058FPianifTurniDtm1.DataInizio:=Dal;
      A058FPianifTurniDtm1.DataFine:=Al;
      dcmbSquadra.KeyValue:=null;
      try
        Screen.Cursor:=crHourGlass;
        if Prog = '' then
          frmSelAnagrafe.btnEreditaSelezioneClick(nil)
        else
        begin
          frmSelAnagrafe.OldSQLCreato.Text:='(T030.PROGRESSIVO IN (' + Prog + ')) ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA';
          C700Progressivo:=-1;
          C700FSelezioneAnagrafe.SQLCreato.Assign(frmSelAnagrafe.OldSQLCreato);
          C700FSelezioneAnagrafe.WhereSql:=C700FSelezioneAnagrafe.SQLCreato.Text;
          frmSelAnagrafe.SelezionePeriodica:=False;
          frmSelAnagrafe.SoloPersonaleInterno:=True;
          C700FSelezioneAnagrafe.PulisciVecchiaSelezione:=False;
          C700FSelezioneAnagrafe.actConfermaExecute(C700FSelezioneAnagrafe.actConferma);
        end;
        BEseguiClick(BitBtn3);
      finally
        Screen.Cursor:=crDefault;
      end;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A058FPianifTurniDtM1.Free;
      Free;
    end;
end;

procedure TA058FPianifTurni.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
  AbilCont:=False;
  BEsegui.Enabled:=Not SolaLettura and ((Parametri.A058_PianifOperativa = 'S') or (Parametri.A058_PianifNonOperativa = 'S'));
end;

procedure TA058FPianifTurni.SetPeriodoDate(Sender: TObject);
{Impostazione date di riferimento}
begin
  with A058FPianifTurniDtM1 do
    if (Sender = btnDataDa) or (Sender = edtDataDa) then
    begin
      try
        if Sender = btnDataDa then
          DataInizio:=DataOut(DataInizio,'Dalla data:','G')
        else
          TryStrToDate(TEdit(Sender).Text,DataInizio);
        edtDataDa.Text:=DateToStr(DataInizio);
      except
        edtDataDa.Text:='';
      end;
    end
    else if (Sender = btnDataA) or (Sender = edtDataA) then
    begin
      try
        if Sender = btnDataA then
          DataFine:=DataOut(DataFine,'Alla data:','G')
        else
          TryStrToDate(TEdit(Sender).Text,DataFine);
        edtDataA.Text:=DateToStr(DataFine);
      except
        edtDataA.Text:='';
      end;
    end;
end;

procedure TA058FPianifTurni.btnDataDaClick(Sender: TObject);
begin
  SetPeriodoDate(Sender);
end;

procedure TA058FPianifTurni.Abilitazioni;
begin
  with A058FPianifTurniDtm1 do
  begin
    //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
    AssenzeOperative:=selT082.FieldByName('ASSENZE_OPERATIVE').AsString = 'S';
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
    begin
      RgpTipo.Visible:=(selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and
                       ((selT082.FieldByName('INIZIALE').AsString = 'S') or (selT082.FieldByName('CORRENTE').AsString = 'S'));
      RgpTipo.Enabled:=(selT082.FieldByName('INIZIALE').AsString = 'S') and (selT082.FieldByName('CORRENTE').AsString = 'S');
      chkIniCorr.Visible:=selT082.FieldByName('MODALITA_LAVORO').AsString = 'O';
      if not RgpTipo.Enabled then
        if selT082.FieldByName('CORRENTE').AsString = 'S' then
          RgpTipo.ItemIndex:=1
        else if selT082.FieldByName('INIZIALE').AsString = 'S' then
          RgpTipo.ItemIndex:=0;
      if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'N') and (RgpTipo.ItemIndex = 0) then
        AssenzeOperative:=False
      else if (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O') then
        AssenzeOperative:=True;
    end;

    if not SolaLettura then
    begin
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      begin
        //PIANIFICAZIONE PROGRESSIVA
        BEsegui.Enabled:=(selT082.FieldByName('GENERAZIONE').AsString = 'S') and (Parametri.A058_PianifOperativa <> 'N') and
                         ((RgpTipo.ItemIndex = 0) or (selT082.FieldByName('MODALITA_LAVORO').AsString = 'O'));
        chkIniCorr.Enabled:=BEsegui.Enabled;
      end
      else
      begin
        //PIANIFICAZIONE STANDARD - NON PROGRESSIVA
        RgpTipo.Visible:=False;
        chkIniCorr.Visible:=False;
        if selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
          BEsegui.Enabled:=Parametri.A058_PianifOperativa <> 'N'
        else
          BEsegui.Enabled:=Parametri.A058_PianifNonOperativa <> 'N';
      end;
    end;

    //Gestione Visualizzazione assenze
    lblCopiaAss.Visible:=((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or AssenzeOperative) and
                         (selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');
    if A058FpianifTurniDtm1.AssenzeOperative then
      lblCopiaAss.Caption:='Gestione assenze: OPERATIVA'
    else
    begin
      lblCopiaAss.Caption:='Gestione assenze: NON OPERATIVA';
      //Specifico la copia assenze solo se la gestione è "NON OPERATIVA"
      if (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') and (lblCopiaAss.Caption <> '') then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + #13#10;
      if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Aggiungi assenze da modalità operativa'
      else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
        lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Sovrascrivi assenze da modalità operativa';
    end;
    if selT082.fieldByName('MODALITA_LAVORO').AsString = 'N' then
      lblProfilo.Caption:='Profilo pianificazione - NON operativo:'
    else
      lblProfilo.Caption:='Profilo pianificazione - operativo:';
  end;
end;

procedure TA058FPianifTurni.Accedi1Click(Sender: TObject);
var
  Cod:String;
begin
  with A058FPianifTurniDtM1 do
  begin
    OpenA174ParPianifTurni(selT082.FieldByName('CODICE').AsString);
    Cod:=selT082.FieldByName('CODICE').AsString;
    selT082.Refresh;
    selT082.searchRecord('CODICE',Cod,[srFromBeginning]);
    Abilitazioni;
  end;
end;

procedure TA058FPianifTurni.MyOnAddReports(Sender: TObject);
begin
  {Dalla versione 5.06 il componente TCompositeRecord è necessario settare
  manualmente la proprietà "ParentComposite" del singolo report}
  A058FTabellone.QRep.ParentComposite:=MyCompRep;
  TQRCompositeReport(Sender).Reports.Add(A058FTabellone.QRep);
  if A058FStampaRiepTimb <> nil then
  begin
    A058FStampaRiepTimb.QRRiepTimb.ParentComposite:=MyCompRep;
    TQRCompositeReport(Sender).Reports.Add(A058FStampaRiepTimb.QRRiepTimb);
  end;
end;

procedure TA058FPianifTurni.Anteprima_Stampa(SoloAnteprima:Boolean);
{Impostazioni di Stampa}
var
  i,j,xx,yy,SalvaInizio,SalvaFine,
  NumSquadre,PSquadra:Integer;
  Squadre:array[1..31] of TSquadre;
  SquadraOld:string;
  {Se sono state rilevate timbrature non causalizzate nei giorni in cui è presente una timbrature che esclude il turno, le stampo}
  StampaTimbrature:Boolean;

  procedure CreaTabellaStampa;
  var
    i, j:Integer;
  begin
    with A058FPianifTurniDtM1 do
    begin
      T058Stampa.Close;
      //Creo la tabella di appoggio T058Stampa
      with T058Stampa.FieldDefs do
      begin
        Clear;
        Add('Matricola',ftString,10,False);
        Add('DataInizio',ftDate);
        Add('DataFine',ftDate);
        Add('Squadra',ftString,5,False);
        Add('Operatore',ftString,5,False);
        Add('Nome',ftString,50,False);
        Add('Badge',ftInteger,0,False);
        Add('Progressivo',ftInteger,0,False);
        Add('DSquadra',ftString,40,False);
        Add('Partenza',ftInteger,0,False);
        //=================================
        //===Creazione campi giornalieri===
        //=================================
        for i:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,trunc(DataFine - DataInizio)) do
        begin
          Add('Orari' + IntToStr(i),ftString,5,False);
          Add('Turni' + IntToStr(i),ftString,10,False);
          Add('CodOrari' + IntToStr(i),ftString,5,False);
          Add('CodAssenze' + IntToStr(i),ftString,5,False);

          //Totali generali per squadra
          Add('TotGenTurno1_' + IntToStr(i),ftInteger,0,False);
          Add('TotGenTurno2_' + IntToStr(i),ftInteger,0,False);
          Add('TotGenTurno3_' + IntToStr(i),ftInteger,0,False);
          Add('TotGenTurno4_' + IntToStr(i),ftInteger,0,False);

          //Numero timbrature che non escludono il turno
          Add('NTimbTurno_' + IntToStr(i),ftInteger,0,False);

          //Creo Totali copertura squadra suddivisi per
          //tipo operatore per tipo operatore
          for j:=Low(aTotaleTurni[i].TotOpe1) to High(aTotaleTurni[i].TotOpe1) do
            Add('TotGenTurno1_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe1[j].Operatore,ftInteger,0,False);
          for j:=Low(aTotaleTurni[i].TotOpe2) to High(aTotaleTurni[i].TotOpe2) do
            Add('TotGenTurno2_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe2[j].Operatore,ftInteger,0,False);
          for j:=Low(aTotaleTurni[i].TotOpe3) to High(aTotaleTurni[i].TotOpe3) do
            Add('TotGenTurno3_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe3[j].Operatore,ftInteger,0,False);
          for j:=Low(aTotaleTurni[i].TotOpe4) to High(aTotaleTurni[i].TotOpe4) do
            Add('TotGenTurno4_' + IntToStr(i) + '_' + aTotaleTurni[i].TotOpe4[j].Operatore,ftInteger,0,False);
          {Aggiungere campi totali per operatore}
        end;
        //=================================
        if selV430.Active then
          Add('DatoAnag',ftString,selV430.FieldByName(selT082.FieldByName('DATO_ANAGRAFICO').AsString).DataSize,False);
        Add('Debito',ftInteger,0,False);
        Add('Assegnato',ftInteger,0,False);
        Add('TotaleTurno1',ftInteger,0,False);
        Add('TotaleTurno2',ftInteger,0,False);
        Add('TotaleTurno3',ftInteger,0,False);
        Add('TotaleTurno4',ftInteger,0,False);
      end;
      T058Stampa.IndexDefs.Clear;
      T058Stampa.IndexDefs.Clear;
      {--> SQUADRA;DATAINIZIO in 1° e 2° posizione è necessaria per il corretto sviluppo della stampa <--}
      T058Stampa.IndexDefs.Add('ORDK','Squadra;DataInizio;' + OrdinamentoStampa{function},[]);
      {with T058Stampa.IndexDefs do
      begin}
        {--> DATAINIZIO;SQUADRA in 1° e 2° posizione è necessaria per il corretto sviluppo della stampa <--}
        {Clear;
        Add('TK','Squadra;DataInizio;Nome;Badge',[]);
        Add('PK','Squadra;DataInizio;Operatore;Nome;Badge',[]);
        Add('SK','Squadra;DataInizio;Partenza;Nome;Badge',[]);
        Add('NK','Squadra;DataInizio;Turni0;Nome;Badge',[])
      end;}
      T058Stampa.CreateDataSet;
      T058Stampa.LogChanges:=False;
      T058Stampa.IndexName:='ORDK';
      {if selT082.FieldByName('ORD_STAMPA').AsString = 'C' then
        T058Stampa.IndexName:='TK'//DataInizio;Squadra;Nome;Badge
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'S' then
        T058Stampa.IndexName:='PK'//DataInizio;Squadra;Operatore;Nome
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'T' then
        T058Stampa.IndexName:='SK'//DataInizio;Squadra;Partenza;Nome
      else if selT082.FieldByName('ORD_STAMPA').AsString = 'P' then
        T058Stampa.IndexName:='NK';//DataInizio;Squadra;Partenza;Nome}
      T058Stampa.Open;
    end;
  end;

  function GetSquadra(S:String):Integer;
  var
    i:Integer;
  begin
    Result:=0;
    for i:=1 to NumSquadre do
      if Squadre[i].Squadra = S then
      begin
        Result:=i;
        Break;
      end;
  end;

  function Turni(GiornoIn:TGiorno):String;
  {Restituisco la stringa dei 2 turni}
  var
    Giorno:TGiorno;
    T1,T2:String;
  begin
    T1:=Trim(GiornoIn.T1);
    if GiornoIn.T1EU = 'U' then
      T1:= '-8';
    T2:=Trim(GiornoIn.T2);
    Result:=Copy('      ',1,A058FPianifTurniDtm1.LungCella);
    if T1 = '0' then
    begin
      Result:=Copy('Rp    ',1,A058FPianifTurniDtm1.LungCella);
      exit;
    end;
    if T1 = '-8' then
    //Smonto notte
    begin
      Result:=Copy('Sn    ',1,A058FPianifTurniDtm1.LungCella);
      exit;
    end;
    Giorno:=TGiorno.Create;
    Giorno.T1:=T1;
    Giorno.T2:=T2;
    Giorno.Ora:=Trim(GiornoIn.Ora);
    A058FPianifTurniDtm1.GetDatiTurno(Giorno);
    Result:=R180DimLung(Giorno.SiglaT1,3);
    if Giorno.T2 <> '' then
      Result:=Result + R180DimLung(Giorno.SiglaT2,3)
    else
      Result:=R180DimLung(Result,A058FPianifTurniDtm1.LungCella);
    Giorno.Free;
  end;

  procedure GetGiorni(Dip:Integer);
  var
    i,j,xx,NumTurno1,NumTurno2:Integer;
    T:String;
    DataCorr:TDateTime;
    A,M,G:Word;
    Giorno:TGiorno;
    Incrementa:Boolean;
  begin
    for xx:=Low(Squadre) to High(Squadre) do
    begin
      Squadre[xx].DSquadra:='';
      Squadre[xx].Oper:='';
      Squadre[xx].S1:='';
      Squadre[xx].S2:='';
      Squadre[xx].Squadra:='';
    end;
    NumSquadre:=0;
    SquadraOld:='';
    (*Al*)//DataCorr:=A058FPianifTurni.DataInizio;
    (*Al*)DataCorr:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
    with A058FPianifTurniDtm1.Vista[Dip] do
    begin
      //Alberto 29/12/2005: aggiorno i totali turni individuali
      TotaleTurniMese.Turno1:=0;
      TotaleTurniMese.Turno2:=0;
      TotaleTurniMese.Turno3:=0;
      TotaleTurniMese.Turno4:=0;
      (*Al*)//for i:=0 to Giorni.Count - 1 do
      (*Al*)for i:=SalvaInizio to Min(SalvaFine,Giorni.Count - 1) do
      begin
        if SquadraOld <> TGiorno(Giorni[i]).Squadra then
        begin
          SquadraOld:=TGiorno(Giorni[i]).Squadra;
          PSquadra:=GetSquadra(SquadraOld);
          if PSquadra = 0 then
          begin
            inc(NumSquadre);
            PSquadra:=NumSquadre;
            Squadre[PSquadra].S1:=R180DimLung('',(i - SalvaInizio) * A058FPianifTurniDtm1.LungCella);
            Squadre[PSquadra].S2:=R180DimLung('',(i - SalvaInizio) * A058FPianifTurniDtm1.LungCella);
          end;
          Squadre[PSquadra].Squadra:=TGiorno(Giorni[i]).Squadra;
          Squadre[PSquadra].DSquadra:=TGiorno(Giorni[i]).DSquadra;
          Squadre[PSquadra].Oper:=TGiorno(Giorni[i]).Oper;
        end;
        if NumSquadre = 0 then
        begin
          SquadraOld:=TGiorno(Giorni[i]).Squadra;
          inc(NumSquadre);
          PSquadra:=NumSquadre;
          Squadre[PSquadra].Squadra:=TGiorno(Giorni[i]).Squadra;
          Squadre[PSquadra].DSquadra:=TGiorno(Giorni[i]).DSquadra;
          Squadre[PSquadra].Oper:=TGiorno(Giorni[i]).Oper;
        end;
        if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
        //Utilizzo i dati ritornati dai conteggi anzichè quelli pianificati
        begin
          DecodeDate(DataCorr,A,M,G);
          (*Alberto (Pescara)*)
          A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Progressivo:=0;
          A058FPianifTurniDtM1.R502ProDtM.PianificazioneEsterna.Data:=0;
          A058FPianifTurniDtM1.R502ProDtM.Conteggi('Cartolina',Prog,DataCorr);
          {Aggiorno contatore totale liquidabile}
          inc(A058FPianifTurniDtM1.aTotaleTurni[i].TotOraLiquid,R180SommaArray(A058FPianifTurniDtM1.R502ProDtM.tminstrgio));
          {-- CALCOLO TOTALE TURNI DA CONTEGGI GIORNALIERI(Stampa consuntiva) --}
          with A058FPianifTurniDtM1 do
            if (R502ProDtM.blocca = 0) then
            begin
              NumTurno1:=-1;
              NumTurno2:=-1;
              if R502ProDtM.r_turno1 >= 0 then
                NumTurno1:=R502ProDtM.ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,R502ProDtM.r_turno1];
              if R502ProDtM.r_turno2 >= 0 then
                NumTurno2:=R502ProDtM.ValNumT021['NUMTURNO',TF_PUNTI_NOMINALI,R502ProDtM.r_turno2];

              {Verico la presenza di causali che escludono il turno}
              Incrementa:=True;
              if selT100.SearchRecord('DATA',DataCorr,[srFromBeginning]) then
                repeat
                  if selT100.FieldByName('CAUSALE').IsNull or
                     (pos(',' + selT100.FieldByName('CAUSALE').AsString + ',',',' + selT082.fieldByName('CAUS_ECLUDITURNO').AsString + ',') = 0) then
                    inc(TGiorno(Giorni[i]).NTimbTurno)
                  else
                  begin
                    Incrementa:=False;
                    StampaTimbrature:=True;
                  end;
                until not selT100.SearchRecord('DATA',DataCorr,[srForward]);
              if Incrementa then
                TGiorno(Giorni[i]).NTimbTurno:=0;

              if Incrementa then
              begin
                if (NumTurno1 = 1) or (NumTurno2 = 1) then
                  inc(aTotaleTurni[i].Rp502Turno1);
                if (NumTurno1 = 2) or (NumTurno2 = 2)  then
                  inc(aTotaleTurni[i].Rp502Turno2);
                if (NumTurno1 = 3) or (NumTurno2 = 3)  then
                  inc(aTotaleTurni[i].Rp502Turno3);
                if (NumTurno1 = 4) or (NumTurno2 = 4)  then
                  inc(aTotaleTurni[i].Rp502Turno4);
              end;
            end;

          TGiorno(GiorniOld[i]).T1:=TGiorno(Giorni[i]).T1;
          TGiorno(GiorniOld[i]).T2:=TGiorno(Giorni[i]).T2;
          TGiorno(GiorniOld[i]).T1EU:=TGiorno(Giorni[i]).T1EU;
          TGiorno(GiorniOld[i]).T2EU:=TGiorno(Giorni[i]).T2EU;
          TGiorno(GiorniOld[i]).Ora:=TGiorno(Giorni[i]).Ora;
          TGiorno(GiorniOld[i]).Ass1:=TGiorno(Giorni[i]).Ass1;
          TGiorno(GiorniOld[i]).SiglaT1:=TGiorno(Giorni[i]).SiglaT1;
          TGiorno(GiorniOld[i]).SiglaT2:=TGiorno(Giorni[i]).SiglaT2;

          if (A058FPianifTurniDtM1.R502ProDtM.Blocca <> 0) or (A058FPianifTurniDtM1.R502ProDtM.dipinser = 'no') then
          begin
            TGiorno(Giorni[i]).T1:='';
            TGiorno(Giorni[i]).T2:='';
            TGiorno(Giorni[i]).T1EU:='';
            TGiorno(Giorni[i]).T2EU:='';
            TGiorno(Giorni[i]).Ora:='';
            TGiorno(Giorni[i]).Ass1:='';
            TGiorno(Giorni[i]).SiglaT1:='';
            TGiorno(Giorni[i]).SiglaT2:='';
          end
          else
          begin
            //1° Turno
            TGiorno(Giorni[i]).T1:='';
            if A058FPianifTurniDtM1.R502ProDtM.r_turno1 > 0 then
              TGiorno(Giorni[i]).T1:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno1)
            else
              TGiorno(Giorni[i]).T1:='';
            //2° Turno
            TGiorno(Giorni[i]).T2:='';
            if A058FPianifTurniDtM1.R502ProDtM.r_turno2 > 0 then
              TGiorno(Giorni[i]).T2:=IntToStr(A058FPianifTurniDtM1.R502ProDtM.r_turno2)
            else
              if A058FPianifTurniDtM1.R502ProDtM.c_turni2 = 0 then
                TGiorno(Giorni[i]).T2:='';
            //Orario
            TGiorno(Giorni[i]).Ora:=A058FPianifTurniDtM1.R502ProDtM.c_orario;
            //Assenza
            TGiorno(Giorni[i]).Ass1:='';
            if A058FPianifTurniDtM1.R502ProDtM.n_giusgga > 0 then
              TGiorno(Giorni[i]).Ass1:=A058FPianifTurniDtM1.R502ProDtM.tgius_ggass[1].tcausggass;

            Giorno:=TGiorno(Giorni[i]);
            A058FPianifTurniDtm1.GetDatiTurno(Giorno);
            TGiorno(Giorni[i]).SiglaT1:=Giorno.SiglaT1;
            TGiorno(Giorni[i]).SiglaT2:=Giorno.SiglaT2;
          end;
          //Alberto (Pescara)
          TGiorno(Giorni[i]).Debito:=A058FPianifTurniDtM1.R502ProDtM.debitocl;
          TGiorno(Giorni[i]).Assegnato:=0;//A058FPianifTurniDtM1.R502ProDtM.debitogg;
          with A058FPianifTurniDtM1.R502ProDtM do
          begin
            if PianificazioneEsterna.l08_turno1 > 0 then
              inc(TGiorno(Giorni[i]).Assegnato,
                  ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,PianificazioneEsterna.l08_turno1]);
            if PianificazioneEsterna.l08_turno2 > 0 then
              inc(TGiorno(Giorni[i]).Assegnato,
                  ValNumT021['ORETEOTUR',TF_PUNTI_NOMINALI,PianificazioneEsterna.l08_turno2]);
            if TGiorno(Giorni[i]).Assegnato = 0 then
              TGiorno(Giorni[i]).Assegnato:=debitogg;
          end;
        end
        //Alberto (Pescara)
        else if (not A058FPianifTurniDtm1.ConteggiaDebito) and (A058FPianifTurniDtm1.selT082.FieldByName('SALDI_ORE').AsString = 'S') then
        begin
          A058FPianifTurniDtm1.ConteggiaDebito:=True;
          A058FPianifTurniDtM1.ConteggiGiornalieri(DataCorr,Dip,i);
          A058FPianifTurniDtm1.ConteggiaDebito:=False;
        end;
        //Leggo la sigla dei turni
        Giorno:=TGiorno(GiorniOld[i]);
        A058FPianifTurniDtm1.GetDatiTurno(Giorno);
        TGiorno(GiorniOld[i]).SiglaT1:=Giorno.SiglaT1;
        TGiorno(GiorniOld[i]).SiglaT2:=Giorno.SiglaT2;
        TGiorno(GiorniOld[i]).NumTurno1:=Giorno.NumTurno1;
        //Fine lettura sigla dei turni
        //Se assenza e stampa ridotta scrivo il codice assenza al posto del turno
        if (TGiorno(Giorni[i]).Ass1 <> '') and (A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S') then
          Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + R180DimLung(TGiorno(Giorni[i]).Ass1,A058FPianifTurniDtm1.LungCella)
        else
        begin
          //Leggo la descrizione turni dall'orario
          T:=Turni(TGiorno(Giorni[i]));
          if (Trim(T) = '') and (A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S') then
            T:=R180DimLung(TGiorno(Giorni[i]).Ora,A058FPianifTurniDtm1.LungCella);
          Squadre[PSquadra].S1:=Squadre[PSquadra].S1 + T;
        end;
        if TGiorno(Giorni[i]).Ass1 = '' then
        begin
          if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
            //Scrivo codice orario
            Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(TGiorno(Giorni[i]).Ora,A058FPianifTurniDtm1.LungCella)
          else
            Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
        end
        else
          //Scrivo codice assenza
        begin
          if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'D' then
            Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + R180DimLung(TGiorno(Giorni[i]).Ass1,A058FPianifTurniDtm1.LungCella)
          else
            Squadre[PSquadra].S2:=Squadre[PSquadra].S2 + '      ';
        end;
        for j:=1 to NumSquadre do
          if j <> PSquadra then
          begin
            Squadre[j].S1:=Squadre[j].S1 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
            Squadre[j].S2:=Squadre[j].S2 + R180DimLung('',A058FPianifTurniDtm1.LungCella);
          end;
        //Alberto 29/12/2005: aggiornamento totali turni individuali per il periodo in stampa
        A058FPianifTurniDtm1.TotaleTurniInd(Dip,i);
        DataCorr:=DataCorr + 1;
      end;
    end;
    A058FPianifTurniDtm1.DebitoDipendente(Dip,SalvaInizio,Min(SalvaFine,A058FPianifTurniDtm1.Vista[Dip].Giorni.Count - 1));
  end;

  procedure CaricaTabellaStampa;
  var
    i,j,y,x,ggfine,Count:Integer;
    SigleSint, Nominativo:String;
  begin
    with A058FPianifTurniDtM1 do
    begin
      //Scorrimento dipendenti selezionati
      for i:=0 to Vista.Count - 1 do
      begin
        OpenSelT100(Vista[i].Prog,DataInizio,DataFine);
        NumSquadre:=1;
        GetGiorni(i);
        for j:=1 to NumSquadre do
        begin
          T058Stampa.Append;
          (*Al*)T058Stampa.FieldByName('DataInizio').AsDateTime:=A058FPianifTurniDtm1.DataInizio + SalvaInizio;
          (*Al*)T058Stampa.FieldByName('DataFine').AsDateTime:=Min(A058FPianifTurniDtm1.DataInizio + SalvaFine,A058FPianifTurniDtm1.DataFine);

          if selV430.Active and selV430.searchRecord('T430PROGRESSIVO',Vista[i].Prog,[srFromBeginning]) then
            T058Stampa.FieldByName('DatoAnag').AsString:=selV430.FieldByName(selT082.FieldByName('DATO_ANAGRAFICO').AsString).AsString;

          T058Stampa.FieldByName('Matricola').AsString:=Vista[i].Matricola;
          T058Stampa.FieldByName('Squadra').AsString:=Squadre[j].Squadra;
          T058Stampa.FieldByName('DSquadra').AsString:=Squadre[j].DSquadra;
          T058Stampa.FieldByName('Operatore').AsString:=Squadre[j].Oper;
          T058Stampa.FieldByName('Badge').AsInteger:=Vista[i].Badge;
          //Conposizione nome
          Nominativo:=Vista[i].Cognome;
          if (selT082.FieldByName('RIGHE_DIP').AsString = '2') or (selT082.FieldByName('RIGHE_NOME').AsString = 'N') then
            Nominativo:=Nominativo + ' '
          else
            Nominativo:=Nominativo + #13#10;
          Nominativo:=Nominativo + Vista[i].Nome;
          T058Stampa.FieldByName('Nome').AsString:=Nominativo;
          T058Stampa.FieldByName('Progressivo').AsInteger:=Vista[i].Prog;
          T058Stampa.FieldByName('Debito').AsInteger:=Vista[i].Debito;
          T058Stampa.FieldByName('Assegnato').AsInteger:=Vista[i].Assegnato;
          T058Stampa.FieldByName('TotaleTurno1').AsInteger:=Vista[i].TotaleTurniMese.Turno1;
          T058Stampa.FieldByName('TotaleTurno2').AsInteger:=Vista[i].TotaleTurniMese.Turno2;
          T058Stampa.FieldByName('TotaleTurno3').AsInteger:=Vista[i].TotaleTurniMese.Turno3;
          T058Stampa.FieldByName('TotaleTurno4').AsInteger:=Vista[i].TotaleTurniMese.Turno4;
          T058Stampa.FieldByName('Partenza').AsInteger:=Vista[i].TurnoPartenza;
          with Vista[i] do
          begin
            Count:=0;
      (*Al*)//for y:=0 to Giorni.Count - 1 do
      (*Al*)ggfine:=Min(SalvaFine,Giorni.Count - 1);
      (*Al*)for y:=SalvaInizio to ggfine do
            begin
              T058Stampa.FieldByName('CodOrari' + IntToStr(Count)).AsString:=TGiorno(Giorni[y]).Ora;
              T058Stampa.FieldByName('CodAssenze' + IntToStr(Count)).AsString:=TGiorno(Giorni[y]).Ass1;
              //Numero timbrature che non escludono il turno
              T058Stampa.FieldByName('NTimbTurno_' + IntToStr(Count)).AsInteger:=TGiorno(Giorni[y]).NTimbTurno;
              if selT082.FieldByName('TIPO_STAMPA').AsString = 'P' then
              begin
                T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno1);
                T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno2);
                T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno3);
                T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(Count)).AsString:=IntToStr(aTotaleTurni[y].Turno4);
              end;

              //Carico Totali copertura squadra suddivisi per
              //tipo operatore per tipo operatore
              for x:=Low(aTotaleTurni[y].TotOpe1) to High(aTotaleTurni[y].TotOpe1) do
                T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(Count) + '_'
                                       + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                       IntToStr(aTotaleTurni[y].TotOpe1[x].Totale);
              for x:=Low(aTotaleTurni[y].TotOpe2) to High(aTotaleTurni[y].TotOpe2) do
                T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(Count) + '_'
                                       + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                       IntToStr(aTotaleTurni[y].TotOpe2[x].Totale);
              for x:=Low(aTotaleTurni[y].TotOpe3) to High(aTotaleTurni[y].TotOpe3) do
                T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(Count) + '_'
                                       + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                       IntToStr(aTotaleTurni[y].TotOpe3[x].Totale);
              for x:=Low(aTotaleTurni[y].TotOpe4) to High(aTotaleTurni[y].TotOpe4) do
                T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(Count) + '_'
                                       + aTotaleTurni[y].TotOpe1[x].Operatore).AsString:=
                                       IntToStr(aTotaleTurni[y].TotOpe4[x].Totale);

              {Valorizzazione dei campi totali operatore}
              T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ora;
              //TURNO #1
              if (selT082.FieldByName('ORARIO_SINTETICO').AsString = 'N') or (Vista[i].Giorni[y].T1 <> ' M') then
                SigleSint:=Vista[i].Giorni[y].SiglaT1
              else
                SigleSint:=Vista[i].Giorni[y].Ora;

              if (SigleSint = '') and R180In(Vista[i].Giorni[y].T1,[' A',' M']) then
                SigleSint:='[' + Trim(Vista[i].Giorni[y].T1) + ']';
              //Se la stampa è predisposta per due righe dipendente rimuovo le parentesi
              if R180In(selT082.FieldByName('RIGHE_DIP').AsString,['2','3']) then
              begin
                SigleSint:=StringReplace(SigleSint,']',')',[rfReplaceAll]);
                SigleSint:=StringReplace(SigleSint,'[','(',[rfReplaceAll]);
                SigleSint:=StringReplace(SigleSint,')',' ',[rfReplaceAll]);
                if Vista[i].Giorni[y].T1EU = '' then
                  SigleSint:=StringReplace(SigleSint,'(',' ',[rfReplaceAll])
                else
                  SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
              end;
              T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=SigleSint + Vista[i].Giorni[y].T1EU;

              //TURNO #2
              //Se la stampa è predisposta per due righe dipendente rimuovo le parentesi
              if Vista[i].Giorni[y].SiglaT2 <> '' then
              begin
                SigleSint:=Vista[i].Giorni[y].SiglaT2;
                if (SigleSint = '') and R180In(Trim(Vista[i].Giorni[y].T2),['A','M']) then
                  SigleSint:='[' + Trim(Vista[i].Giorni[y].T2) + ']';
                if R180In(selT082.FieldByName('RIGHE_DIP').AsString,['2','3']) then
                begin
                  SigleSint:=StringReplace(SigleSint,')',' ',[rfReplaceAll]);
                  if Vista[i].Giorni[y].T2EU = '' then
                    SigleSint:=StringReplace(SigleSint,'(',' ',[rfReplaceAll])
                  else
                    SigleSint:=StringReplace(SigleSint,'(','',[rfReplaceAll]);
                end;
                T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString + #13#10
                + SigleSint + Vista[i].Giorni[y].T2EU;
              end;

              if (selT082.FieldByName('ASSENZE').AsString = 'S') and (selT082.FieldByName('DETT_STAMPA').asString = 'D') and
                 ((Vista[i].Giorni[y].Ass1 + Vista[i].Giorni[y].Ass2) <> '') then
                T058Stampa.FieldByName('Orari' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ass1 +
                ' ' + Vista[i].Giorni[y].Ass2
              else if (selT082.FieldByName('ASSENZE').AsString = 'S') and (selT082.FieldByName('DETT_STAMPA').asString = 'S') and
                 ((Vista[i].Giorni[y].Ass1 + Vista[i].Giorni[y].Ass2) <> '') then
                T058Stampa.FieldByName('Turni' + IntToStr(Count)).AsString:=Vista[i].Giorni[y].Ass1 +
                ' ' + Vista[i].Giorni[y].Ass2;
              inc(Count);
            end;
          end;
          T058Stampa.Post;
        end;
      end;
    end;
  end;

begin
  A058FTabellone:=TA058FTabellone.Create(nil);
  C001SettaQuickReport(A058FTabellone.QRep);
  C001SettaCompositeReport(MyCompRep);
  AbilCont:=False;
  StampaTimbrature:=False;
  if A058FPianifTurniDtM1.selT082.FieldByName('DETT_STAMPA').AsString = 'S' then
    A058FPianifTurniDtM1.LungCella:=5
  else
    A058FPianifTurniDtM1.LungCella:=6;
  with A058FTabellone do
  begin
    LOrari.Clear;
    LAssenze.Clear;
    LTotTurni.Clear;
    for xx:=Low(TotaliTurni) to High(TotaliTurni) do
      for yy:=0 to 359 do
        TotaliTurni[xx,yy]:=0;
    QRMOrari.Lines.Clear;
    QRMAssenze.Lines.Clear;
    QRTitolo.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('TITOLO').AsString;
    QRNota.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('NOTE_STAMPA').AsString;
    QRDesc1.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('DESCRIZIONE1').AsString;
    QRDesc2.Caption:=A058FPianifTurniDtM1.selT082.FieldByName('DESCRIZIONE2').AsString;
    //Inizializzo Dataset dato angrafico
    if Not A058FPianifTurniDtM1.selT082.FieldByName('DATO_ANAGRAFICO').isNull then
      A058FPianifTurniDtM1.OpenSelV430('V430.T430PROGRESSIVO, ' + A058FPianifTurniDtM1.selT082.FieldByName('DATO_ANAGRAFICO').AsString);
    //InizializzaStampa;
    //Ciclo sul periodo in base agli x giorni da stampare  Lorena
    CreaTabellaStampa;
    A058FPianifTurniDtM1.OldInizio:=A058FPianifTurniDtm1.DataInizio;
    A058FPianifTurniDtM1.OldFine:=A058FPianifTurniDtm1.DataFine;
    Screen.Cursor:=crHourGlass;
    ProgressBar1.Position:=0;
    (*Al*)SalvaInizio:=0;
    (*Al*)SalvaFine:=A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger - 1;
    {Azzero la voce TotOraLiquid}
    with A058FPianifTurniDtM1 do
      for i:=Low(aTotaleTurni) to High(aTotaleTurni) do
      begin
        aTotaleTurni[i].TotOraLiquid:=0;
        aTotaleTurni[i].Rp502Turno1:=0;
        aTotaleTurni[i].Rp502Turno2:=0;
        aTotaleTurni[i].Rp502Turno3:=0;
        aTotaleTurni[i].Rp502Turno4:=0;
      end;
    ProgressBar1.Max:=Trunc((A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio) / A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger);
    repeat
      CaricaTabellaStampa;
      SalvaInizio:=SalvaInizio + A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger;
      //SalvaInizio:=SalvaFine + 1;
      SalvaFine:=SalvaFine + A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger;
      if R180Mese(A058FPianifTurniDtm1.DataInizio + SalvaInizio) <> R180Mese(A058FPianifTurniDtm1.DataInizio + SalvaFine) then
        SalvaFine:=Trunc(R180FineMese(A058FPianifTurniDtm1.DataInizio + SalvaInizio) - A058FPianifTurniDtm1.DataInizio);
      ProgressBar1.StepBy(1);
    until A058FPianifTurniDtm1.DataInizio + SalvaInizio > A058FPianifTurniDtm1.DataFine;
    A058FPianifTurniDtM1.selV430.Close;

    if (A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C') and
       (A058FPianifTurniDtM1.selT082.FieldByName('TOT_TURNO').AsString = 'S') then
    begin
      with A058FPianifTurniDtM1 do
        for i:=0 to Min(selT082.FieldByName('GG_PAGINA').AsInteger - 1,trunc(DataFine - DataInizio)) do
        begin
          T058Stampa.First;
          while Not T058Stampa.Eof do
          begin
            T058Stampa.Edit;
            T058Stampa.FieldByName('TotGenTurno1_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno1;
            T058Stampa.FieldByName('TotGenTurno2_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno2;
            T058Stampa.FieldByName('TotGenTurno3_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno3;
            T058Stampa.FieldByName('TotGenTurno4_' + IntToStr(i)).AsInteger:=aTotaleTurni[i].Rp502Turno4;
            T058Stampa.Post;
            T058Stampa.Next;
          end;
        end;
    end;

    A058FPianifTurniDtM1.T058Stampa.First;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;

    if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'A' then
      if A058FPianifTurniDtM1.selT082.FieldByName('GG_PAGINA').AsInteger >= 15 then //Lorena
        QRep.Page.Orientation:=poLandScape
      else
        QRep.Page.Orientation:=poPortrait
    else if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'V' then
      QRep.Page.Orientation:=poPortrait
    else if A058FPianifTurniDtM1.selT082.FieldByName('ORIENTAMENTO_PAG').asString = 'O' then
      QRep.Page.Orientation:=poLandScape;
    MyCompRep.PrinterSettings.PaperSize:=QRep.PrinterSettings.PaperSize;
    MyCompRep.PrinterSettings.Orientation:=QRep.Page.Orientation;

    A058FStampaRiepTimb:=nil;
    if StampaTimbrature then
    begin
      A058FStampaRiepTimb:=TA058FStampaRiepTimb.Create(Self);
      C001SettaQuickReport(A058FStampaRiepTimb.QRRiepTimb);
      A058FStampaRiepTimb.StampaRiepTimb(A058FPianifTurniDtM1.Vista);
    end;

    if (DocumentoPDF.Trim <> '') and (DocumentoPDF.Trim <> '<VUOTO>') and (TipoModulo.Trim = 'COM')then
    begin
      QRep.ShowProgress:=False;
      MyCompRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else if Not SoloAnteprima then
    begin
      MyCompRep.Prepare;
      MyCompRep.Print;
    end
    else
      MyCompRep.Preview;
    {distruggo gli oggetti della banda "piede5" con tag 99}
    if A058FStampaRiepTimb <> nil then
      FreeAndNil(A058FStampaRiepTimb);
    DistruggiOggetti99(Piede5);
  end;
  with A058FPianifTurniDtm1 do
    for i:=0 to Vista.Count - 1 do
    begin
      with Vista[i] do
      begin
        //Alberto 29/12/2005: aggiorno i totali turni individuali
        TotaleTurniMese.Turno1:=0;
        TotaleTurniMese.Turno2:=0;
        TotaleTurniMese.Turno3:=0;
        TotaleTurniMese.Turno4:=0;
        for j:=0 to Giorni.Count - 1 do
        begin
          if A058FPianifTurniDtM1.selT082.FieldByName('TIPO_STAMPA').AsString = 'C' then
          begin
            TGiorno(Giorni[j]).T1:=TGiorno(GiorniOld[j]).T1;
            TGiorno(Giorni[j]).T2:=TGiorno(GiorniOld[j]).T2;
            TGiorno(Giorni[j]).T1EU:=TGiorno(GiorniOld[j]).T1EU;
            TGiorno(Giorni[j]).T2EU:=TGiorno(GiorniOld[j]).T2EU;
            TGiorno(Giorni[j]).Ora:=TGiorno(GiorniOld[j]).Ora;
            TGiorno(Giorni[j]).Ass1:=TGiorno(GiorniOld[j]).Ass1;
            TGiorno(Giorni[j]).SiglaT1:=TGiorno(GiorniOld[j]).SiglaT1;
            TGiorno(Giorni[j]).SiglaT2:=TGiorno(GiorniOld[j]).SiglaT2;
          end;
          //Alberto 29/12/2005: aggiorno i totali turni individuali
          TotaleTurniInd(i,j);
        end;
      end;
      DebitoDipendente(i,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
    end;
  (*Al*)
  try
    A058FPianifTurniDtM1.T058Stampa.Close;
    MyCompRep.Reports.Clear;
  except
  end;
end;

procedure TA058FPianifTurni.BEseguiClick(Sender: TObject);
var
  S:String;
  x:Integer;
begin
  //RegistraMsg.IniziaMessaggio('A058');
  A058FPianifTurniDtm1.NuovaPianif:=Sender = BEsegui;
  A058FPianifTurniDtM1.TipoPianif:=RgpTipo.ItemIndex;

  if A058FPianifTurniDtm1.DataInizio > A058FPianifTurniDtm1.DataFine then
    raise Exception.Create('Il periodo specificato non è valido!');
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine) then
    C700SelAnagrafe.Close;

  A058FPianifTurniDtm1.ForzaOrdC700;
  C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  C700SelAnagrafe.SQL.Text:=A058FPianifTurniDtm1.SalvaSQLOriginale;
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create('Nessun dipendente selezionato!');
  with A058FPianifTurniDtM1 do
  begin
    selT620.Close;
    selT620.SetVariable('DATAA',DataFine);
    selT620.Open;
    Q600B.Close;
    Q600B.SetVariable('CODSQUADRA',dCmbSquadra.KeyValue);
    Q600B.Open;
    R502ProDtM.PeriodoConteggi(DataInizio,DataFine);
    R502ProDtM.Conteggi('APERTURA',0,DataInizio);
    ConteggiaDebito:=False;
    PulisciVista;
    selDistOperatori.Close;
    C700MergeSelAnagrafe(selDistOperatori,False);
    C700MergeSettaPeriodo(selDistOperatori,DataInizio,Parametri.DataLavoro);
    selDistOperatori.Open;
  end;
  with C700SelAnagrafe do
  begin
    if A058FPianifTurniDtM1.NuovaPianif then
    begin
      //Primo scorrimento per verificare se esiste già una pianificazione
      S:='';
      x:=0;
      First;
      while not Eof do
      begin
        A058FPianifTurniDtm1.LeggiPianificazione(FieldByName('Progressivo').AsInteger,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine,False);
        if ((A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') and (A058FPianifTurniDtM1.Q080Gest.RecordCount > 0)) or
           ((A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N') and (A058FPianifTurniDtM1.Q081Gest.RecordCount > 0)) then
        begin
          inc(x);
          if x > 20 then
          begin
            S:=S + 'ecc...' + #13#10;
            Break;
          end
          else
            S:=S + Format('%-8s %s %s',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString]) + #13#10;
        end;
        Next;
      end;
      if S <> '' then
        if MessageDlg('La pianificazione esiste già per i seguenti dipendenti:' + #13#10 + S + #13#10 +
                      'La creazione di una nuova pianificazione non eliminerà quella esistente.' + #13#10 +
                      'Continuare?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          exit;
    end;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=RecordCount;
    First;
    while not Eof do
    begin
      //=====================================================================
      //TRAVASO DELLE ASSENZE DALLA T040_GIUSTIFICATIVI ALLA T041_PROVVISORIO
      //=====================================================================
      if not A058FPianifTurniDtm1.AssenzeOperative then
        with A058FPianifTurniDtm1 do
        begin
          if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
          begin
            SovrascriviT041.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            SovrascriviT041.SetVariable('DATADA',DataInizio);
            SovrascriviT041.SetVariable('DATAA',DataFine);
            SovrascriviT041.Execute;
          end
          else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
          begin
            InserisciT041.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            InserisciT041.SetVariable('DATADA',DataInizio);
            InserisciT041.SetVariable('DATAA',DataFine);
            InserisciT041.Execute;
          end;
          InserisciT041.Session.Commit;
        end;

      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=ProgressBar1.Position + 1;
      if A058FPIanifTurniDtm1.NuovaPianif then
        A058FPianifTurniDtM1.PianificaDipendente(FieldByName('Progressivo').AsInteger)  //Nuova pianificazione
      else
        A058FPianifTurniDtM1.LeggiPianificazione(FieldByName('Progressivo').AsInteger,A058FPianifTurniDtm1.DataInizio,A058FPianifTurniDtm1.DataFine); //Leggo pianif.esist.
      if A058FPianifTurniDtM1.Vista.Count > 0 then
        A058FPianifTurniDtM1.DebitoDipendente(A058FPianifTurniDtM1.Vista.Count - 1,0,Trunc(A058FPianifTurniDtm1.DataFine - A058FPianifTurniDtm1.DataInizio));
      Next;
    end;
  end;
  ProgressBar1.Position:=0;
  if (Sender = BitBtn3) or (Sender = BEsegui) then
    VisualizzaGriglia
  else if Sender = btnAnteprima then {Lancio anteprima}
    Anteprima_Stampa(True)
  else if Sender = btnStampa then {Lancio stampa}
    Anteprima_Stampa(False);
end;

procedure TA058FPianifTurni.BitBtn1Click(Sender: TObject);
{Impostazione stampante}
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA058FPianifTurni.VisualizzaGriglia;
{Visualizzo la form con la griglia di pianificazione}
begin
  A058FGrigliaPianif:=TA058FGrigliaPianif.Create(nil);
  with A058FGrigliaPianif, A058FPianifTurniDtm1 do
    try
      DatoModificato:=NuovaPianif;
      if NuovaPianif then
        Caption:='<A058> Sviluppo pianificazione '
      else
        Caption:='<A058> Visualizzazione pianificazione ';
      if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        Caption:=Caption + 'progressiva '
      else
        Caption:=Caption + 'statica ';
      {if NuovaPianif then
        A058FGrigliaPianif.BtnVerificaTurni.Visible:=False
      else
        A058FGrigliaPianif.BtnVerificaTurni.Visible:=True;}
      if A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O' then
        Caption:=Caption + 'operativa '
      else
      begin
        Caption:=Caption + 'non operativa ';
        if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
        begin
          if TipoPianif = 0 then
            Caption:=Caption + 'iniziale'
          else
            Caption:=Caption + 'corrente'
        end;
      end;
      //GVista.RowCount:=Vista.Count + 2;
      GVista.RowCount:=Vista.Count + nRigheBloccate;
      //GVista.ColCount:=Trunc(DataFine - DataInizio) + 6;
      GVista.ColCount:=Trunc(DataFine - DataInizio) + 1 + nColonneBloccate;
      RiempiGriglia;
      BCancellazione.Visible:=not NuovaPianif;
      ShowModal;
    finally
      Release;
    end;
end;

procedure TA058FPianifTurni.RgpTipoClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.RiempiGriglia;
{Riempo le celle di GVista col contenuto di Vista}
var i,j,h:LongInt;
    DataCorr:TDateTime;
begin
  with A058FGrigliaPianif do
  begin
    //i:=5;
    i:=nColonneBloccate;
    DataCorr:=A058FPianifTurniDtm1.DataInizio;
    while DataCorr <= A058FPianifTurniDtm1.DataFine do
    begin
      GVista.Cells[i,0]:=FormatDateTime('dd/mm/yy',DataCorr);
      DataCorr:=DataCorr + 1;
      Inc(i);
    end;
    for i:=0 to A058FPianifTurniDtm1.Vista.Count - 1 do
      with A058FPianifTurniDtm1.Vista[i] do
      begin
        //Inserisco il badge
        //GVista.Cells[0,i + 2]:=IntToStr(Badge);
        GVista.Cells[0,i + nRigheBloccate]:=IntToStr(Badge);
        GVista.RowHeights[i + nRigheBloccate]:=GVista.DefaultRowHeight;
        for j:=0 to Giorni.Count - 1 do
        begin
          with TGiorno(Giorni[j]) do
          begin
            //GVista.Cells[j + 5,i+2]:=
            GVista.Cells[j + nColonneBloccate,i + nRigheBloccate]:=
            Format('%-2s%-3s%-1s%-2s%-3s%-1s%s',[T1, SiglaT1, T1EU,
                                                 T2, SiglaT2, T2EU,
                                                 R180DimLung(Ora,5)]);
            if AssOre <> '' then
            begin
              h:=Trunc(GVista.DefaultRowHeight*((3 + A058FPianifTurniDtm1.NumRighe(AssOre))/3));
              if h > GVista.RowHeights[i + nRigheBloccate] then
                GVista.RowHeights[i + nRigheBloccate]:=h;
            end;
          end;
        end;
      end;
    end;
end;

procedure TA058FPianifTurni.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(QRepSetting);
end;

procedure TA058FPianifTurni.FormShow(Sender: TObject);
begin
  A058FPianifTurniDtm1.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  A058FPianifTurniDtm1.DataFine:=R180FineMese(Parametri.DataLavoro);
  QRepSetting:=TQuickRep.Create(Self);
  QRepSetting.useQR5Justification:=True;
  CreaC004(SessioneOracle,'A058',Parametri.ProgOper);
  GetParametriFunzione;
  C004FParamForm.Free;
  A058FPianifTurniDtm1.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  A058FPianifTurniDtm1.DataFine:=R180FineMese(Parametri.DataLavoro);
  C700DatiVisualizzati:='MATRICOLA,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  C700SelAnagrafe.OnFilterRecord:=A058FPianifTurniDtM1.SelAnagrafeFilterRecord;
  C700SelAnagrafe.Filtered:=True;
  A058FPianifTurniDtM1.selAnagrafeA058:=C700SelAnagrafe;

  {lblCopiaAss.Visible:=((Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') or
                       A058FpianifTurniDtm1.AssenzeOperative) and
                       (A058FPianifTurniDtM1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'N');

  if A058FpianifTurniDtm1.AssenzeOperative then
    lblCopiaAss.Caption:='Gestione assenze: OPERATIVA'
  else
    lblCopiaAss.Caption:='Gestione assenze: NON OPERATIVA';
  //Specifico la copia assenze solo se la gestione è "NON OPERATIVA"
  if not A058FpianifTurniDtm1.AssenzeOperative then
  begin
    if (Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif <> 'NO') and
       (lblCopiaAss.Caption <> '') then
      lblCopiaAss.Caption:=lblCopiaAss.Caption + #13#10;
    if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'AGGIUNGI' then
      lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Aggiungi assenze da modalità operativa'
    else if Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif = 'SOVRASCRIVI' then
      lblCopiaAss.Caption:=lblCopiaAss.Caption + 'Sovrascrivi assenze da modalità operativa';
  end;}
end;

procedure TA058FPianifTurni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CreaC004(SessioneOracle,'A058',Parametri.ProgOper);
  PutParametriFunzione;
  C004FParamForm.Free;
  A058FPianifTurniDtm1.SalvaSQLOriginale:='';
end;

procedure TA058FPianifTurni.GetParametriFunzione;
{Leggo i parametri della form}
var
  nKey:Word;
begin
  with A058FPianifTurniDtm1 do
  begin
    DataInizio:=R180InizioMese(Parametri.DataLavoro);
    edtDataDa.Text:=DateToStr(DataInizio);
    DataFine:=R180FineMese(Parametri.DataLavoro);
    edtDataA.Text:=DateToStr(DataFine);
    dCmbSquadra.KeyValue:=C004FParamForm.GetParametro('SQUADRA','');
    nKey:=0;
    dCmbSquadraKeyDown(nil,nKey,[]);
    RgpTipo.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOPIANIFICAZIONE','0'));
    bVisualizzaSintetica:=C004FParamForm.GetParametro(UpperCase('VIS_SINTETICA'),'N') = 'S';
    bVisualizzaCoperura:=C004FParamForm.GetParametro('COPERTURA','N') = 'S';
    bVisualizzaCompetenze:=C004FParamForm.GetParametro('COMPETENZE','N') = 'S';
    bVisualizzaTurni:=C004FParamForm.GetParametro('TURNI','N') = 'S';
    bVisualizzaAssenze:=C004FParamForm.GetParametro('ASSENZE','N') = 'S';
    bVisualizzaRiposiFestivi:=C004FParamForm.GetParametro('RIPOSI_FESTIVI','N') = 'S';
    bVisualizzaBadge:=C004FParamForm.GetParametro('VIS_BADGE','S') = 'S';
    AusT058.Edit;
    AusT058.FieldByName('CODICE').AsString:=C004FParamForm.GetParametro('CODPROFILO','');
    AusT058.Post;
    selT082.SearchRecord('CODICE',AusT058.FieldByName('CODICE').AsString,[srFromBeginning]);
    Abilitazioni;
  end;
end;

procedure TA058FPianifTurni.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  with A058FPianifTurniDtm1 do
  begin
    C004FParamForm.PutParametro('SQUADRA',VarToStr(dCmbSquadra.KeyValue));
    C004FParamForm.PutParametro('TIPOPIANIFICAZIONE',IntToStr(RgpTipo.ItemIndex));
    if bVisualizzaCoperura then
      C004FParamForm.PutParametro('COPERTURA','S')
    else
      C004FParamForm.PutParametro('COPERTURA','N');
    if bVisualizzaCompetenze then
      C004FParamForm.PutParametro('COMPETENZE','S')
    else
      C004FParamForm.PutParametro('COMPETENZE','N');
    if bVisualizzaTurni then
      C004FParamForm.PutParametro('TURNI','S')
    else
      C004FParamForm.PutParametro('TURNI','N');
    if bVisualizzaAssenze then
      C004FParamForm.PutParametro('ASSENZE','S')
    else
      C004FParamForm.PutParametro('ASSENZE','N');
    if bVisualizzaRiposiFestivi then
      C004FParamForm.PutParametro('RIPOSI_FESTIVI','S')
    else
      C004FParamForm.PutParametro('RIPOSI_FESTIVI','N');
    if bVisualizzaBadge then
      C004FParamForm.PutParametro('VIS_BADGE','S')
    else
      C004FParamForm.PutParametro('VIS_BADGE','N');
    C004FParamForm.PutParametro('CODPROFILO',AusT058.FieldByName('CODICE').AsString);
    C004FParamForm.PutParametro('VIS_SINTETICA',ifThen(bVisualizzaSintetica,'S','N'));
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA058FPianifTurni.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=A058FPianifTurniDtm1.DataFine;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA058FPianifTurni.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataDal:=A058FPianifTurniDtm1.DataInizio;
  C700DataLavoro:=A058FPianifTurniDtm1.DataFine;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  with A058FPianifTurniDtM1 do
  begin
    //Se l'SQL della C700 è diverso, allora azzero la variabile di SalvaSQLOriginal
    if C700SelAnagrafe.SQL.Text <> SalvaSQLOriginale then
      SalvaSQLOriginale:='';
    dCmbSquadra.KeyValue:=GetListaSquadra;
  end;
end;

procedure TA058FPianifTurni.dCmbProfiliCloseUp(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.dCmbProfiliKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Abilitazioni;
end;

procedure TA058FPianifTurni.dCmbSquadraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 8) or (key = 46) then
    dCmbSquadra.KeyValue:='';
  if dCmbSquadra.KeyValue='' then
    dLblSquadra.Field.Clear;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA058FPianifTurni.edtDataADblClick(Sender: TObject);
begin
  edtDataA.Text:=DateToStr(R180FineMese(A058FPianifTurniDtM1.DataInizio));
end;

procedure TA058FPianifTurni.edtDataDaExit(Sender: TObject);
begin
  SetPeriodoDate(Sender);
end;

end.
