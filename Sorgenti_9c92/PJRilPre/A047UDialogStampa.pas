unit A047UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, QueryStorico,
  Menus, StdCtrls, Mask, Buttons, ExtCtrls, R300UAccessiMensaDtM, OracleData, C180FunzioniGenerali,
  C004UParamForm, A000UCostanti, A000USessione,A000UInterfaccia, ComCtrls, CheckLst, C700USelezioneAnagrafe,
  Variants, DBCtrls, A047URaggrStampa , A047UTimbMensaMW, QRPDFFilt;


type
  TA047FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label1: TLabel;
    Label2: TLabel;
    BtnPrinterSetup: TBitBtn;
    BtnStampa: TBitBtn;
    EDaData: TMaskEdit;
    EAData: TMaskEdit;
    rgpTipoStampa: TRadioGroup;
    pnlDipendente: TPanel;
    chkTimbraturePresenza: TCheckBox;
    chkRilevatori: TCheckBox;
    chkTotaliIndividuali: TCheckBox;
    chkDatiIndividuali: TCheckBox;
    chkDettaglioGiornaliero: TCheckBox;
    chkSaltoPagina: TCheckBox;
    chkAnomalie: TCheckBox;
    chkCausale: TCheckBox;
    pnlGiornaliera: TPanel;
    chkDistinzioneCausale: TCheckBox;
    chkPranzoCena: TCheckBox;
    ProgressBar1: TProgressBar;
    chkGiustificativiAssenza: TCheckBox;
    chkSaltoPaginaIndividuale: TCheckBox;
    chkNominativi: TCheckBox;
    btnAnteprima: TBitBtn;
    chkSaltoPaginaRaggr: TCheckBox;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    Label3: TLabel;
    cbxOrologi: TCheckListBox;
    chkTuttiOrologi: TCheckBox;
    chkTimbraturePresenzaCausalizzate: TCheckBox;
    edtRaggr: TEdit;
    btnRaggr: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnPrinterSetupClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure EDaDataChange(Sender: TObject);
    procedure EADataChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure chkTuttiOrologiClick(Sender: TObject);
    procedure chkDatiIndividualiClick(Sender: TObject);
    procedure btnRaggrClick(Sender: TObject);
    procedure edtRaggrChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaDatiStampa;
    procedure CaricaQueryRilevatori;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function GetFiltro:String;
    procedure GetOrologi;
  public
    { Public declarations }
    DocumentoPDF,TipoModulo: string;
    MyCampiRaggr:T047ArrListaRaggr;
    SB,SN,CampoRagg,NomeCampo : String;
    DataI,DataF : TDateTime;
    procedure CreaStampaGiornaliera;
    function GetRaggrCampi(InStr: String; var InArrListaRaggr: T047ArrListaRaggr): String;
  end;

var
  A047FDialogStampa: TA047FDialogStampa;

implementation

uses C001StampaLib,A047UStampaTimbMensa,A047UTimbMensaDtM1,
     A047UTimbMensa, A047UStampaGiornaliera;

{$R *.DFM}

//------------------------------------------------------------------------------
procedure TA047FDialogStampa.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,Copy(name,1,4),Parametri.ProgOper);
  GetParametriFunzione;
  GetRaggrCampi(edtRaggr.Text,MyCampiRaggr);
  EDaData.Text:=FormatDateTime('dd/mm/yyyy',DataI);
  EAData.Text:=FormatDateTime('dd/mm/yyyy',DataF);
  GetOrologi;
  if rgpTipoStampa.ItemIndex = 0 then
    chkDatiIndividualiClick(nil);
  rgpTipoStampaClick(nil);
end;


procedure TA047FDialogStampa.GetParametriFunzione;
begin
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  chkDatiIndividuali.Checked:=C004FParamForm.GetParametro('DATIINDIVIDUALI','S') = 'S';
  chkDettaglioGiornaliero.Checked:=C004FParamForm.GetParametro('DETTAGLIOGIORNALIERO','S') = 'S';
  chkSaltoPaginaIndividuale.Checked:=C004FParamForm.GetParametro('SALTOPAGINAIND','N') = 'S';
  chkTimbraturePresenza.Checked:=C004FParamForm.GetParametro('TIMBRATUREPRESENZA','N') = 'S';
  chkTimbraturePresenzaCausalizzate.Checked:=C004FParamForm.GetParametro('TIMBRATUREPRESCAUS','N') = 'S';
  chkGiustificativiAssenza.Checked:=C004FParamForm.GetParametro('GIUSTIFICATIVI','N') = 'S';
  chkTotaliIndividuali.Checked:=C004FParamForm.GetParametro('TOTALIINDIVIDUALI','N') = 'S';
  chkNominativi.Checked:=C004FParamForm.GetParametro('NOMINATIVI','N') = 'S';
  chkRilevatori.Checked:=C004FParamForm.GetParametro('RILEVATORI','N') = 'S';
  chkCausale.Checked:=C004FParamForm.GetParametro('CAUSALE','N') = 'S';
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkAnomalie.Checked:=C004FParamForm.GetParametro('ANOMALIE','N') = 'S';
  chkPranzoCena.Checked:=C004FParamForm.GetParametro('PRANZOCENA','N') = 'S';
  chkDistinzioneCausale.Checked:=C004FParamForm.GetParametro('DISTINZIONECAUSALE','N') = 'S';
  chkSaltoPaginaRaggr.Checked:=C004FParamForm.GetParametro('SALTOPAGINAGRUPPO','N') = 'S';
  edtRaggr.Text:=C004FParamForm.GetParametro(UpperCase(edtRaggr.Name),'');
  rgpTipoStampaClick(nil);
  chkDatiIndividualiClick(nil);
end;

procedure TA047FDialogStampa.GetOrologi;
begin
  cbxOrologi.Items.Clear;
  with A047FTimbMensaDtM1.A047FTimbMensaMW.QOrologi do
  begin
    First;
    while not Eof do
    begin
      if A000FiltroDizionario('OROLOGI DI TIMBRATURA',FieldByName('CODICE').AsString) then
        cbxOrologi.Items.Add(Format('%-2s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TA047FDialogStampa.BtnPrinterSetupClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A047FStampaTimbMensa.RepR);
end;

procedure TA047FDialogStampa.CaricaDatiStampa;
var DataCorr:TDateTime;
    Anom,Giustificativi:String;
    i:integer;
begin
  with A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM do
  begin
    SettaPeriodo(DataI,DataF);
    FiltroRilevatori:=GetFiltro;
    FiltroRilevT370:=True;
  end;
  with A047FTimbMensaDtM1 do
  begin
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    ProgressBar1.Position:=0;
    C700SelAnagrafe.First;
    selT040Stampa.SetVariable('DATAINIZIO',DataI);
    selT040Stampa.SetVariable('DATAFINE',DataF);
    //A047FTimbMensa.frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    //Self.Enabled:=False;
    //StatusBar1.SimpleText:='Premere ESC per interrompere...';
    try
      while not C700SelAnagrafe.EOF do
      begin
        ProgressBar1.StepBy(1);
        selT040Stampa.SetVariable('PROGRESSIVO',C700Progressivo);
        selT040Stampa.Close;
        selT040Stampa.Open;
        DataCorr:=DataI;
        while (DataCorr <= DataF) do
        begin
          Anom:='';
          A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.ConteggiaPasti(C700Progressivo,DataCorr);
          if A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.TimbratureMensa <> '' then
          begin
            if A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.Anomalie.Count > 0 then
              //Anom:=R300DtM1.Anomalie[0];
              Anom:=Trim(A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.Anomalie.Text);
            Giustificativi:='';
            if selT040Stampa.SearchRecord('DATA',DataCorr,[srFromBeginning]) then
              repeat
                if Giustificativi <> '' then
                  Giustificativi:=Giustificativi + ' - ';
                Giustificativi:=Giustificativi + selT040Stampa.FieldByName('CAUSALE').AsString;
              until not selT040Stampa.SearchRecord('DATA',DataCorr,[]);
            if (not chkAnomalie.Checked) or (Anom <> '') then
            begin
              TabellaStampa.Insert;
              TabellaStampa.FieldByName('Rilevatore').AsString:='*';
              TabellaStampa.FieldByName('Progressivo').AsInteger:=C700Progressivo;
              TabellaStampa.FieldByName('Data').Value:=DataCorr;
              TabellaStampa.FieldByName('Nome').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString + ' ' + C700SelAnagrafe.FieldByName('Nome').AsString;
              TabellaStampa.FieldByName('Matricola').AsString:=C700SelAnagrafe.FieldByName('Matricola').AsString;
              TabellaStampa.FieldByName('Badge').AsString:=C700SelAnagrafe.FieldByName('T430Badge').AsString;
              for i:=Low(MyCampiRaggr) to High(MyCampiRaggr) do
                TabellaStampa.FieldByName('Gruppo' + IntToStr(i)).AsString:=C700SelAnagrafe.FieldByName(MyCampiRaggr[i].NomeCampo).AsString;
              TabellaStampa.FieldByName('PastiCon').AsInteger:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiCon;
              TabellaStampa.FieldByName('PastiInt').AsInteger:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiInt;
              TabellaStampa.FieldByName('Accessi').AsInteger:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.NumTimbratureMensa;
              TabellaStampa.FieldByName('TimbMensa').AsString:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.TimbratureMensa;
              TabellaStampa.FieldByName('AnomMensa').AsString:=Anom;
              TabellaStampa.FieldByName('TimbPresenza').AsString:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.TimbraturePresenza[chkTimbraturePresenzaCausalizzate.Checked];
              TabellaStampa.FieldByName('Giustificativi').AsString:=Giustificativi;
              TabellaStampa.FieldByName('AnomPresenza').AsString:='';
              TabellaStampa.Post;
            end;
          end;
          DataCorr:=DataCorr + 1;
        end;
        C700SelAnagrafe.Next;
      end;
    finally
      ProgressBar1.Position:=0;
      A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.FiltroRilevatori:='';
      A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.FiltroRilevT370:=False;
    end;
  end;
end;

procedure TA047FDialogStampa.CaricaQueryRilevatori;
const selT370SQL = 'SELECT T370.*,T361.DESCRIZIONE FROM T370_TIMBMENSA T370,T361_OROLOGI T361 WHERE T370.DATA BETWEEN :DATA1 AND :DATA2 AND T370.FLAG IN (''O'',''I'') AND T361.CODICE(+) = T370.RILEVATORE';
var
  ProgCorr,NTimbMensa,i:Integer;
  DataCorr:TDateTime;
  RaggrCorr,Raggr,TimbMensa,SSort,FiltroOrologi:String;
begin
  A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.SettaPeriodo(DataI,DataF);
  with A047FTimbMensaDtM1 do
  begin
    SSort:='T370.DATA,T370.ORA';
    if not chkNominativi.Checked then
      SSort:='T370.PROGRESSIVO,' + SSort;
    if chkCausale.Checked then
      SSort:='T370.CAUSALE,' + SSort;
    if chkRilevatori.Checked then
      SSort:='T370.RILEVATORE,' + SSort;
    if chkNominativi.Checked then
      SSort:='T370.PROGRESSIVO,' + SSort;
    sel370Stampa.SQL.Clear;
    sel370Stampa.SQL.Add(selT370SQL);
    sel370Stampa.SQL.Add('ORDER BY ' + SSort);
    sel370Stampa.SetVariable('Data1',DataI);
    sel370Stampa.SetVariable('Data2',DataF);
    sel370Stampa.CloseAll;
    sel370Stampa.Open;
    while not(sel370Stampa.EOF) do
    begin
      ProgCorr:=sel370Stampa.FieldByName('Progressivo').AsInteger;
      DataCorr:=sel370Stampa.FieldByName('Data').AsDateTime;
      RaggrCorr:='';
      if chkNominativi.Checked then
        RaggrCorr:=sel370Stampa.FieldByName('Progressivo').AsString;
      if chkRilevatori.Checked then
        RaggrCorr:=RaggrCorr + '_' + sel370Stampa.FieldByName('Rilevatore').AsString;
      if chkCausale.Checked then
        RaggrCorr:=RaggrCorr + '_' + sel370Stampa.FieldByName('Causale').AsString;
      if not C700SelAnagrafe.SearchRecord('PROGRESSIVO',ProgCorr,[srFromBeginning]) then
      begin
        sel370Stampa.Next;
        Continue;
      end;
      //Alberto 05/10/2010: Applicazione filtro orologi
      FiltroOrologi:=GetFiltro;
      if FiltroOrologi <> '' then
         FiltroOrologi:=',' + FiltroOrologi + ',';
      if not chkTuttiOrologi.Checked and (Pos(',' + sel370Stampa.FieldByName('Rilevatore').AsString + ',',FiltroOrologi) = 0) then
      begin
        sel370Stampa.Next;
        Continue;
      end;
      TabellaStampa.Insert;
      if chkRilevatori.Checked then
      begin
        TabellaStampa.FieldByName('Rilevatore').AsString:=sel370Stampa.FieldByName('Rilevatore').AsString;
        TabellaStampa.FieldByName('Descrizione').AsString:=sel370Stampa.FieldByName('Descrizione').AsString;
      end;
      if chkCausale.Checked then
        TabellaStampa.FieldByName('Causale').AsString:=sel370Stampa.FieldByName('Causale').AsString;
      TabellaStampa.FieldByName('Progressivo').AsInteger:=ProgCorr;
      TabellaStampa.FieldByName('Data').Value:=DataCorr;
      TabellaStampa.FieldByName('Nome').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString+' '+C700SelAnagrafe.FieldByName('Nome').AsString;
      TabellaStampa.FieldByName('Badge').AsString:=C700SelAnagrafe.FieldByName('T430Badge').AsString;
      for i:=Low(MyCampiRaggr) to High(MyCampiRaggr) do
        TabellaStampa.FieldByName('Gruppo' + IntToStr(i)).AsString:=C700SelAnagrafe.FieldByName(MyCampiRaggr[i].NomeCampo).AsString;
      TabellaStampa.FieldByName('PastiCon').AsInteger:=0;
      TabellaStampa.FieldByName('PastiInt').AsInteger:=0;
      TabellaStampa.FieldByName('AnomMensa').AsString:='';
      TabellaStampa.FieldByName('TimbPresenza').AsString:='';
      TabellaStampa.FieldByName('AnomPresenza').AsString:='';
      NTimbMensa:=0;
      TimbMensa:='';
      while True do
      begin
        inc(NTimbMensa);
        if TimbMensa <> '' then
          TimbMensa:=TimbMensa + ' ';
        TimbMensa:=TimbMensa + FormatDateTime('hh.nn',sel370Stampa.FieldByName('Ora').AsDateTime);
        sel370Stampa.Next;
        if sel370Stampa.EOF then
          Break;
        Raggr:='';
        if chkNominativi.Checked then
          Raggr:=sel370Stampa.FieldByName('Progressivo').AsString;
        if chkRilevatori.Checked then
          Raggr:=Raggr + '_' + sel370Stampa.FieldByName('Rilevatore').AsString;
        if chkCausale.Checked then
          Raggr:=Raggr + '_' + sel370Stampa.FieldByName('Causale').AsString;
        if (ProgCorr <> sel370Stampa.FieldByName('Progressivo').AsInteger) or
           (DataCorr <> sel370Stampa.FieldByName('Data').AsDateTime) or
           (RaggrCorr <> Raggr) then
          Break;
      end;
      TabellaStampa.FieldByName('Accessi').AsInteger:=NTimbMensa;
      TabellaStampa.FieldByName('TimbMensa').AsString:=TimbMensa;
      TabellaStampa.Post;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TA047FDialogStampa.btnRaggrClick(Sender: TObject);
var
  Temp:String;
begin
  Temp:=edtRaggr.Text;
  OpenA047RaggrStampa(Temp);
  edtRaggr.Text:=Temp;
  GetRaggrCampi(edtRaggr.Text,MyCampiRaggr);
  chkDatiIndividualiClick(nil);
end;

procedure TA047FDialogStampa.BtnStampaClick(Sender: TObject);
var
  S, STemp:String;
  i:Integer;
begin
  A047FStampaGiornaliera.QRep.DataSet:=A047FTimbMensaDtM1.TabellaStampa;
  A047FStampaTimbMensa.RepR.DataSet:=A047FTimbMensaDtM1.TabellaStampa;
  GetRaggrCampi(edtRaggr.Text,MyCampiRaggr);
  A047FTimbMensaDtM1.CreaTabellaStampa;
  if rgpTipoStampa.ItemIndex = 1 then
  begin
    CreaStampaGiornaliera;
    exit;
  end;
  if DataI <= DataF then
  begin
    with A047FTimbMensaDtM1 do
    begin
      if A047FTimbMensa.frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
        C700SelAnagrafe.Close;
      if High(MyCampiRaggr) >= 0 then
      begin
        S:=C700SelAnagrafe.SQL.Text;
        STemp:='';
        for i:=Low(MyCampiRaggr) to High(MyCampiRaggr) do
        begin
          if Trim(STemp) <> '' then
            STemp:=STemp + ', ';
          STemp:=STemp + AliasTabella(MyCampiRaggr[i].NomeCampo) + '.' + MyCampiRaggr[i].NomeCampo;
        end;
        if R180InserisciColonna(S,STemp) then
        begin
          C700SelAnagrafe.Close;
          C700SelAnagrafe.SQL.Text:=S;
        end;
      end;
    end;
    C700SelAnagrafe.Open;
    if (chkRilevatori.Checked) or (chkCausale.Checked) or (chkNominativi.Checked) then
      CaricaQueryRilevatori
    else
      CaricaDatiStampa;
    S:='';   //Lorena 28/07/2005
    if chkNominativi.Checked then
      S:='PROGRESSIVO';
    if chkRilevatori.Checked then
    begin
      if S <> '' then
        S:=S + ' + ';
      S:=S + 'RILEVATORE';
    end;
    if chkCausale.Checked then
    begin
      if S <> '' then
        S:=S + ' + ';
      S:=S + 'CAUSALE';
    end;
    for i:=Low(MyCampiRaggr) to High(MyCampiRaggr) do
    begin
      if S <> '' then
        S:=S + ' + ';
      S:=S + 'GRUPPO' + IntToStr(i);
    end;
    A047FStampaTimbMensa.qbndRilevatoreI.Expression:='PROGRESSIVO';
    if High(MyCampiRaggr) >= 0 then
      A047FStampaTimbMensa.qbndRilevatoreI.Expression:=A047FStampaTimbMensa.qbndRilevatoreI.Expression + '+' + Copy(S,Pos('GRUPPO',S),Length(S));

    A047FStampaTimbMensa.qbndRilevatoreI.Expression:=S;
    A047FStampaTimbMensa.qbndRilevatoreI.Enabled:=Trim(S) <> '';
    A047FStampaTimbMensa.qbndRilevatoreP.Enabled:=Trim(S) <> '';
    A047FStampaTimbMensa.qbndRilevatoreI.ForceNewPage:=(chkSaltoPagina.Checked) or (chkSaltoPaginaRaggr.Checked);
    if (not chkDatiIndividuali.Checked) and (High(MyCampiRaggr) < 0) then
      A047FStampaTimbMensa.qbndRilevatoreI.Height:=0
    else
      A047FStampaTimbMensa.qbndRilevatoreI.Height:=40;

    A047FStampaTimbMensa.DataI:=DataI;
    A047FStampaTimbMensa.DataF:=DataF;
    A047FStampaTimbMensa.QRGroup1.Height:=0;
    A047FStampaTimbMensa.QRGroup1.ForceNewPage:=(chkSaltoPaginaIndividuale.Checked and (not chkSaltoPagina.Checked));
    A047FStampaTimbMensa.QRBTotali.Enabled:=chkDatiIndividuali.Checked and chkTotaliIndividuali.Checked;
    A047FStampaTimbMensa.QRLabel1.Enabled:=chkDatiIndividuali.Checked and chkDettaglioGiornaliero.Checked;
    A047FStampaTimbMensa.QRLabel2.Enabled:=chkDatiIndividuali.Checked;
    A047FStampaTimbMensa.QRLabel3.Enabled:=chkDatiIndividuali.Checked;
    A047FStampaTimbMensa.QRLabel4.Enabled:=chkDatiIndividuali.Checked;
    A047FStampaTimbMensa.QRLabel6.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.QRLabel7.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.QRDBText6.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.QRDBText9.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.QRLTotPasti.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.QRLTotPasti2.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.qlblRilPasti.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.qlblRilPasti2.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.qlblSumPasti.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.qlblSumPasti2.Enabled:=(not chkRilevatori.Checked) and (not chkCausale.Checked) and (not chkNominativi.Checked);
    A047FStampaTimbMensa.qlblBadge2.Enabled:=chkDatiIndividuali.Checked and chkTotaliIndividuali.Checked and (not chkDettaglioGiornaliero.Checked);
    A047FStampaTimbMensa.qlblNome2.Enabled:=chkDatiIndividuali.Checked and chkTotaliIndividuali.Checked and (not chkDettaglioGiornaliero.Checked);
    A047FStampaTimbMensa.CreaReport(Sender);
  end
  else
    MessageDlg('La data iniziale deve essere precedente a quella finale',mtError,[mbOK],0);
end;

procedure TA047FDialogStampa.CreaStampaGiornaliera;
var DataCorr:TDateTime;
    i:Integer;
    S:String;
begin
  Screen.Cursor:=crHourGlass;
  A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.SettaPeriodo(DataI,DataF);
  A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.FiltroRilevatori:=GetFiltro;
  if A047FTimbMensa.frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;  
  with A047FTimbMensaDtM1 do
  begin
    TabellaStampa.IndexName:='A047_Causale';
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    //A047FTimbMensa.frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    //Self.Enabled:=False;
    try
    while not C700SelAnagrafe.EOF do
    begin
      ProgressBar1.StepBy(1);
      DataCorr:=DataI;
      while DataCorr <= DataF do
      begin
        SetLength(A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot,0);
        A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.ConteggiaPasti(C700SelAnagrafe.FieldByName('Progressivo').AsInteger,DataCorr);
        for i:=0 to High(A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot) do
          if (A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Conv + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Interi) > 0 then
          begin
            if TabellaStampa.Locate('Data;Causale',VarArrayOf([DateToStr(DataCorr),A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Causale]),[]) then
            begin
              TabellaStampa.Edit;
              TabellaStampa.FieldByName('Pasti').AsInteger:=TabellaStampa.FieldByName('Pasti').AsInteger + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Conv + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Interi;
              TabellaStampa.FieldByName('PastiCena').AsInteger:=TabellaStampa.FieldByName('PastiCena').AsInteger + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].CenaConv + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].CenaInteri;
            end
            else
            begin
              TabellaStampa.Append;
              TabellaStampa.FieldByName('Data').AsDateTime:=DataCorr;
              TabellaStampa.FieldByName('Causale').AsString:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Causale;
              TabellaStampa.FieldByName('Pasti').AsInteger:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Conv + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].Interi;
              TabellaStampa.FieldByName('PastiCena').AsInteger:=A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].CenaConv + A047FTimbMensaDtM1.A047FTimbMensaMW.R300FAccessiMensaDtM.PastiTot[i].CenaInteri;
            end;
            TabellaStampa.Post;
          end;
        DataCorr:=DataCorr + 1;
      end;
      C700SelAnagrafe.Next;
    end;
    finally
      ProgressBar1.Position:=0;
      //A047FTimbMensa.frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      //Self.Enabled:=True;
    end;
  end;
  A047FStampaGiornaliera.LEnte.Caption:=Parametri.DAzienda;
  A047FStampaGiornaliera.LTitolo.Caption:='Accessi mensa giornalieri';
  S:='';
  for i:=0 to cbxOrologi.Items.Count - 1 do
    if cbxOrologi.Checked[i] then
    begin
      if S <> '' then
        S:=S + ',';
      S:=S + Copy(cbxOrologi.Items[i],4,40);
    end;
  if S = '' then
    A047FStampaGiornaliera.LTitolo.Caption:='Accessi mensa giornalieri (tutti i rilevatori)'
  else
    A047FStampaGiornaliera.LTitolo.Caption:=Format('Accessi mensa giornalieri (rilevatori: %s)',[S]);
  A047FStampaGiornaliera.QRGroup1.Height:=0;
  A047FStampaGiornaliera.ChildBand1.Enabled:=chkDistinzioneCausale.Checked;
  A047FStampaGiornaliera.ChildBand2.Enabled:=chkDistinzioneCausale.Checked;
  A047FStampaGiornaliera.qbndCenaGG.Enabled:=chkDistinzioneCausale.Checked and chkPranzoCena.Checked;
  A047FStampaGiornaliera.qbndCenaTot.Enabled:=chkDistinzioneCausale.Checked and chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblIntPranzo.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblIntCena.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblPranzoGG.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblCenaGG.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblPranzoTot.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblCenaTot.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblTotPranziGG.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblTotCeneGG.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblTotPranzi.Enabled:=chkPranzoCena.Checked;
  A047FStampaGiornaliera.qlblTotCene.Enabled:=chkPranzoCena.Checked;
  Screen.Cursor:=crDefault;

  if (Trim(A047FDialogStampa.DocumentoPDF) <> '') and (Trim(A047FDialogStampa.DocumentoPDF) <> '<VUOTO>') and (Trim(A047FDialogStampa.TipoModulo) = 'COM')then
  begin
    A047FStampaGiornaliera.QRep.ShowProgress:=False;
    A047FStampaGiornaliera.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A047FDialogStampa.DocumentoPDF));
  end
  else
    A047FStampaGiornaliera.QRep.Preview;
end;

function TA047FDialogStampa.GetFiltro:String;
var
  i:integer;
  SelezionaTutto:Boolean;
begin
  Result:='';
  SelezionaTutto:=True;
  if Not chkTuttiOrologi.Checked then
    for i:=0 to cbxOrologi.Items.Count - 1 do
      if cbxOrologi.Checked[i] then
      begin
        SelezionaTutto:=False;
        Break;
      end;

  for i:=0 to cbxOrologi.Items.Count - 1 do
    if cbxOrologi.Checked[i] or SelezionaTutto then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + Trim(Copy(cbxOrologi.Items[i],1,2));
    end;
  //Aggiungo rilevatore nullo se previsto
  if chkTuttiOrologi.Checked then
    Result:=Result + ',,';
end;

procedure TA047FDialogStampa.EDaDataChange(Sender: TObject);
begin
  try
    DataI:=StrToDate(EDaData.Text);
  except
  end;
end;

procedure TA047FDialogStampa.edtRaggrChange(Sender: TObject);
begin
  chkDatiIndividualiClick(nil);
end;

procedure TA047FDialogStampa.EADataChange(Sender: TObject);
begin
  try
    DataF:=StrToDate(EAData.Text);
  except
  end;
end;

procedure TA047FDialogStampa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  try SessioneOracle.Commit; except end;
  C004FParamForm.Free;
end;

procedure TA047FDialogStampa.FormCreate(Sender: TObject);
begin
  TipoModulo:='CS';
end;

procedure TA047FDialogStampa.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  if chkDatiIndividuali.Checked then
    C004FParamForm.PutParametro('DATIINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('DATIINDIVIDUALI','N');
  if chkDettaglioGiornaliero.Checked then
    C004FParamForm.PutParametro('DETTAGLIOGIORNALIERO','S')
  else
    C004FParamForm.PutParametro('DETTAGLIOGIORNALIERO','N');
  if chkSaltoPaginaIndividuale.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAIND','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAIND','N');
  C004FParamForm.PutParametro('TIMBRATUREPRESENZA',IfThen(chkTimbraturePresenza.Checked,'S','N'));
  C004FParamForm.PutParametro('TIMBRATUREPRESCAUS',IfThen(chkTimbraturePresenzaCausalizzate.Checked,'S','N'));
  if chkGiustificativiAssenza.Checked then
    C004FParamForm.PutParametro('GIUSTIFICATIVI','S')
  else
    C004FParamForm.PutParametro('GIUSTIFICATIVI','N');
  if chkTotaliIndividuali.Checked then
    C004FParamForm.PutParametro('TOTALIINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('TOTALIINDIVIDUALI','N');
  if chkNominativi.Checked then
    C004FParamForm.PutParametro('NOMINATIVI','S')
  else
    C004FParamForm.PutParametro('NOMINATIVI','N');
  if chkRilevatori.Checked then
    C004FParamForm.PutParametro('RILEVATORI','S')
  else
    C004FParamForm.PutParametro('RILEVATORI','N');
  if chkCausale.Checked then
    C004FParamForm.PutParametro('CAUSALE','S')
  else
    C004FParamForm.PutParametro('CAUSALE','N');
  if chkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if chkAnomalie.Checked then
    C004FParamForm.PutParametro('ANOMALIE','S')
  else
    C004FParamForm.PutParametro('ANOMALIE','N');
  if chkPranzoCena.Checked then
    C004FParamForm.PutParametro('PRANZOCENA','S')
  else
    C004FParamForm.PutParametro('PRANZOCENA','N');
  if chkDistinzioneCausale.Checked then
    C004FParamForm.PutParametro('DISTINZIONECAUSALE','S')
  else
    C004FParamForm.PutParametro('DISTINZIONECAUSALE','N');
  if chkSaltoPaginaRaggr.Checked then
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINAGRUPPO','N');
  C004FParamForm.PutParametro(UpperCase(edtRaggr.Name),edtRaggr.Text);
end;

procedure TA047FDialogStampa.rgpTipoStampaClick(Sender: TObject);
var i:Integer;
begin
  pnlDipendente.Enabled:=rgpTipoStampa.ItemIndex = 0;
  pnlGiornaliera.Enabled:=rgpTipoStampa.ItemIndex = 1;
  for i:=0 to pnlDipendente.ControlCount -1 do
    pnlDipendente.Controls[i].Enabled:=pnlDipendente.Enabled;
  for i:=0 to pnlGiornaliera.ControlCount -1 do
    pnlGiornaliera.Controls[i].Enabled:=pnlGiornaliera.Enabled;
  if rgpTipoStampa.ItemIndex = 0 then
    chkDatiIndividualiClick(nil);
end;

procedure TA047FDialogStampa.chkTuttiOrologiClick(Sender: TObject);
begin
  cbxOrologi.Enabled:=not chkTuttiOrologi.Checked;
end;

procedure TA047FDialogStampa.chkDatiIndividualiClick(Sender: TObject);
begin
  chkDatiIndividuali.Enabled:=not chkNominativi.Checked;
  if not chkDatiIndividuali.Enabled then
    chkDatiIndividuali.Checked:=False;
  chkDettaglioGiornaliero.Enabled:=chkDatiIndividuali.Enabled;
  chkDettaglioGiornaliero.Checked:=chkDatiIndividuali.Checked;
  chkTotaliIndividuali.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkTotaliIndividuali.Enabled then
    chkTotaliIndividuali.Checked:=False;
  chkSaltoPaginaIndividuale.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked)
                                     and (High(MyCampiRaggr) < 0);
  if not chkSaltoPaginaIndividuale.Enabled then
    chkSaltoPaginaIndividuale.Checked:=False;
  chkTimbraturePresenza.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkTimbraturePresenza.Enabled then
    chkTimbraturePresenza.Checked:=False;
  chkTimbraturePresenzaCausalizzate.Enabled:=chkTimbraturePresenza.Checked;
  chkGiustificativiAssenza.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkGiustificativiAssenza.Enabled then
    chkGiustificativiAssenza.Checked:=False;
  chkAnomalie.Enabled:=(chkDatiIndividuali.Checked) and not (chkRilevatori.Checked or chkCausale.Checked);
  if not chkAnomalie.Enabled then
    chkAnomalie.Checked:=False;

  (*
  chkRilevatori.Enabled:=High(MyCampiRaggr) < 0;
  if not chkRilevatori.Enabled then
    chkRilevatori.Checked:=False;
  chkCausale.Enabled:=High(MyCampiRaggr) < 0;
  if not chkCausale.Enabled then
    chkCausale.Checked:=False;
  *)
  chkNominativi.Enabled:=(not chkDatiIndividuali.Checked)(* and (High(MyCampiRaggr) < 0)*);
  if not chkNominativi.Enabled then
    chkNominativi.Checked:=False;
  chkSaltoPagina.Enabled:=chkNominativi.Checked or chkRilevatori.Checked or chkCausale.Checked;
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  //edtRaggr.Enabled:=(not chkNominativi.Checked) and (not chkRilevatori.Checked) and (not chkCausale.Checked);
  btnRaggr.Enabled:=edtRaggr.Enabled;
  chkSaltoPaginaRaggr.Enabled:=edtRaggr.Enabled and (High(MyCampiRaggr) >= 0);
  if not chkSaltoPaginaRaggr.Enabled then
    chkSaltoPaginaRaggr.Checked:=False;
end;

function TA047FDialogStampa.GetRaggrCampi(InStr:String;var InArrListaRaggr:T047ArrListaRaggr):String;
var
  TempStr, NomeLog:String;
  i:Integer;
begin
  SetLength(InArrListaRaggr,0);
  Result:='';
  for i:=1 to Length(InStr) do
  begin
    TempStr:=TempStr + Copy(InStr,i,1);
    if (Copy(InStr,i + 1,1) = ',') or (i = Length(InStr)) then
    begin
      TempStr:=Trim(StringReplace(TempStr,',','',[rfReplaceAll]));
      NomeLog:=VarToStr(A047FTimbMensaDtM1.A047FTimbMensaMW.selI010.LookUp('NOME_LOGICO',TempStr,'NOME_CAMPO'));
      if (NomeLog <> '') then
      begin
        SetLength(InArrListaRaggr,Length(InArrListaRaggr) + 1);
        InArrListaRaggr[High(InArrListaRaggr)].NomeLogico:=TempStr;
        InArrListaRaggr[High(InArrListaRaggr)].NomeCampo:=NomeLog;
      end
      else
      begin
        if Result <> '' then
          Result:=Result + ', ';
        Result:=Result + TempStr;
      end;
      TempStr:='';
    end;
  end;
end;
end.
