unit A090UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Oracle, OracleData, DB, Math,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, R600,
  C700USelezioneAnagrafe, Variants, QRExport, QRWebFilt, QRPDFFilt, QRPrntr, StrUtils, A000UMessaggi;

type
  TA090FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLEnte: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRGroup1: TQRGroup;
    CBSit1: TQRBand;
    QRLTitolo: TQRLabel;
    qlblMese: TQRLabel;
    CBGiorni: TQRChildBand;
    CBSit2: TQRChildBand;
    CBSit3: TQRChildBand;
    CBSit4: TQRChildBand;
    qlblGiorno01: TQRLabel;
    qlblGiorno02: TQRLabel;
    qlblGiorno03: TQRLabel;
    qlblGiorno04: TQRLabel;
    qlblGiorno05: TQRLabel;
    qlblGiorno06: TQRLabel;
    qlblGiorno07: TQRLabel;
    qlblGiorno08: TQRLabel;
    qlblGiorno09: TQRLabel;
    qlblGiorno10: TQRLabel;
    qlblGiorno11: TQRLabel;
    qlblGiorno12: TQRLabel;
    qlblGiorno13: TQRLabel;
    qlblGiorno14: TQRLabel;
    qlblGiorno15: TQRLabel;
    qlblGiorno16: TQRLabel;
    qlblGiorno17: TQRLabel;
    qlblGiorno18: TQRLabel;
    qlblGiorno19: TQRLabel;
    qlblGiorno20: TQRLabel;
    qlblGiorno21: TQRLabel;
    qlblGiorno22: TQRLabel;
    qlblGiorno23: TQRLabel;
    qlblGiorno24: TQRLabel;
    qlblGiorno25: TQRLabel;
    qlblGiorno26: TQRLabel;
    qlblGiorno27: TQRLabel;
    qlblGiorno28: TQRLabel;
    qlblGiorno29: TQRLabel;
    qlblGiorno30: TQRLabel;
    qlblGiorno31: TQRLabel;
    QRLS101: TQRLabel;
    QRLS102: TQRLabel;
    QRLS103: TQRLabel;
    QRLS104: TQRLabel;
    QRLS105: TQRLabel;
    QRLS106: TQRLabel;
    QRLS107: TQRLabel;
    QRLS108: TQRLabel;
    QRLS109: TQRLabel;
    QRLS1010: TQRLabel;
    QRLS1011: TQRLabel;
    QRLS1012: TQRLabel;
    QRLS1013: TQRLabel;
    QRLS1014: TQRLabel;
    QRLS1015: TQRLabel;
    QRLS1016: TQRLabel;
    QRLS1017: TQRLabel;
    QRLS1018: TQRLabel;
    QRLS1019: TQRLabel;
    QRLS1020: TQRLabel;
    QRLS1021: TQRLabel;
    QRLS1022: TQRLabel;
    QRLS1023: TQRLabel;
    QRLS1024: TQRLabel;
    QRLS1025: TQRLabel;
    QRLS1026: TQRLabel;
    QRLS1027: TQRLabel;
    QRLS1028: TQRLabel;
    QRLS1029: TQRLabel;
    QRLS1030: TQRLabel;
    QRLS1031: TQRLabel;
    QRLS201: TQRLabel;
    QRLS202: TQRLabel;
    QRLS203: TQRLabel;
    QRLS204: TQRLabel;
    QRLS205: TQRLabel;
    QRLS206: TQRLabel;
    QRLS207: TQRLabel;
    QRLS208: TQRLabel;
    QRLS209: TQRLabel;
    QRLS2010: TQRLabel;
    QRLS2011: TQRLabel;
    QRLS2012: TQRLabel;
    QRLS2013: TQRLabel;
    QRLS2014: TQRLabel;
    QRLS2015: TQRLabel;
    QRLS2016: TQRLabel;
    QRLS2017: TQRLabel;
    QRLS2018: TQRLabel;
    QRLS2019: TQRLabel;
    QRLS2020: TQRLabel;
    QRLS2021: TQRLabel;
    QRLS2022: TQRLabel;
    QRLS2023: TQRLabel;
    QRLS2024: TQRLabel;
    QRLS2025: TQRLabel;
    QRLS2026: TQRLabel;
    QRLS2027: TQRLabel;
    QRLS2028: TQRLabel;
    QRLS2029: TQRLabel;
    QRLS2030: TQRLabel;
    QRLS2031: TQRLabel;
    QRLS301: TQRLabel;
    QRLS302: TQRLabel;
    QRLS303: TQRLabel;
    QRLS304: TQRLabel;
    QRLS305: TQRLabel;
    QRLS306: TQRLabel;
    QRLS307: TQRLabel;
    QRLS308: TQRLabel;
    QRLS309: TQRLabel;
    QRLS3010: TQRLabel;
    QRLS3011: TQRLabel;
    QRLS3012: TQRLabel;
    QRLS3013: TQRLabel;
    QRLS3014: TQRLabel;
    QRLS3015: TQRLabel;
    QRLS3016: TQRLabel;
    QRLS3017: TQRLabel;
    QRLS3018: TQRLabel;
    QRLS3019: TQRLabel;
    QRLS3020: TQRLabel;
    QRLS3021: TQRLabel;
    QRLS3022: TQRLabel;
    QRLS3023: TQRLabel;
    QRLS3024: TQRLabel;
    QRLS3025: TQRLabel;
    QRLS3026: TQRLabel;
    QRLS3027: TQRLabel;
    QRLS3028: TQRLabel;
    QRLS3029: TQRLabel;
    QRLS3030: TQRLabel;
    QRLS3031: TQRLabel;
    QRLS401: TQRLabel;
    QRLS402: TQRLabel;
    QRLS403: TQRLabel;
    QRLS404: TQRLabel;
    QRLS405: TQRLabel;
    QRLS406: TQRLabel;
    QRLS407: TQRLabel;
    QRLS408: TQRLabel;
    QRLS409: TQRLabel;
    QRLS4010: TQRLabel;
    QRLS4011: TQRLabel;
    QRLS4012: TQRLabel;
    QRLS4013: TQRLabel;
    QRLS4014: TQRLabel;
    QRLS4015: TQRLabel;
    QRLS4016: TQRLabel;
    QRLS4017: TQRLabel;
    QRLS4018: TQRLabel;
    QRLS4019: TQRLabel;
    QRLS4020: TQRLabel;
    QRLS4021: TQRLabel;
    QRLS4022: TQRLabel;
    QRLS4023: TQRLabel;
    QRLS4024: TQRLabel;
    QRLS4025: TQRLabel;
    QRLS4026: TQRLabel;
    QRLS4027: TQRLabel;
    QRLS4028: TQRLabel;
    QRLS4029: TQRLabel;
    QRLS4030: TQRLabel;
    QRLS4031: TQRLabel;
    QRBand2: TQRBand;
    QRMemo1: TQRMemo;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    qlblTitoloRiepilogo: TQRLabel;
    qimgLogo: TQRImage;
    CBRigaFinale: TQRChildBand;
    bndFinePagina: TQRChildBand;
    qlblFirma: TQRLabel;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRBTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure CBSit1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure CBSit2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure CBRigaFinaleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    AltezzaInizialeBandaTitolo:Integer;
    QRLista:TList;
    LAss:TStringList;
    R600DtM1:TR600DtM1;
    procedure CreaCompVariabili;
    procedure SvuotaQRLista;
  public
    { Public declarations }
    procedure CreaReport(PreView:Boolean);
  end;

var
  A090FStampa: TA090FStampa;

implementation

uses A090UAssenzeAnno,A090UAssenzeAnnoDtM1;

{$R *.DFM}

procedure TA090FStampa.CreaReport(PreView:Boolean);
begin
  QRLista:=TList.Create;
  CreaCompVariabili;

  QRBTitolo.Enabled:=A090FAssenzeAnno.chkIntestazione.Checked;
  if AltezzaInizialeBandaTitolo = 0 then
    AltezzaInizialeBandaTitolo:=QRBTitolo.Height;
  QRSysData1.Enabled:=A090FAssenzeAnno.chkData.Checked;
  QRSysData2.Enabled:=A090FAssenzeAnno.chkNumPagina.Checked;
  QRLEnte.Enabled:=A090FAssenzeAnno.chkAzienda.Checked;
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption:=A090FAssenzeAnno.edtTitolo.Text;
  QRLTitolo.Caption:=StringReplace(QRLTitolo.Caption,'<DAL>',FormatDateTime('dd/mm/yyyy',A090FAssenzeAnno.DaData),[rfIgnoreCase]);
  QRLTitolo.Caption:=StringReplace(QRLTitolo.Caption,'<AL>',FormatDateTime('dd/mm/yyyy',A090FAssenzeAnno.AData),[rfIgnoreCase]);
  // banda dei totali
  if A090FAssenzeAnno.chkTotIndiv.Checked then
  begin
    LAss:=TStringList.Create;
    R600DtM1:=TR600DtM1.Create(Self);
    A090FAssenzeAnnoDtM1.A090MW.Q265.Open;
  end;
  QRBand2.Enabled:=A090FAssenzeAnno.chkTotIndiv.Checked;
  qlblFirma.Caption:=A090FAssenzeAnno.edtFirma.Text;
  bndFinePagina.Enabled:=Trim(qlblFirma.Caption) <> '';

  QRGroup1.ForceNewPage:=A090FAssenzeAnno.chkSaltoPag.Checked;
  A090FAssenzeAnno.FlagStatus:=True;

  if (Trim(A090FAssenzeAnno.DocumentoPDF) <> '') and (Trim(A090FAssenzeAnno.DocumentoPDF) <> '<VUOTO>') and (Trim(A090FAssenzeAnno.TipoModulo) = 'COM')then
  begin
    RepR.ShowProgress:=False;
    RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A090FAssenzeAnno.DocumentoPDF));
  end
  else if PreView then
    RepR.Preview
  else
    RepR.Print;

  if QRLista <> nil then
  begin
    SvuotaQRLista;
    QRLista.Free;;
  end;
  if A090FAssenzeAnno.chkTotIndiv.Checked then
  begin
    LAss.Free;
    FreeAndNil(R600DtM1);
    A090FAssenzeAnnoDtM1.A090MW.Q265.Close;
  end;
  C700SelAnagrafe.Filtered:=False;
  A090FAssenzeAnno.FlagStatus:=False;
end;

procedure TA090FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA090FStampa.CreaCompVariabili;
var Etichetta:TQRLabel;
    Dato:TQRDBText;
    i,l,t:integer;
    NomeFisico:string;
begin
  l:=0;
  t:=2;
  for i:=0 to A090FAssenzeAnno.ListaAnagra.Items.Count-1 do
  begin
    if A090FAssenzeAnno.ListaAnagra.Checked[i] then
    begin
      Etichetta:=TQRLabel.Create(A090FStampa);
      Etichetta.Parent:=QRGroup1;
      Etichetta.Caption:=A090FAssenzeAnno.ListaAnagra.Items[i]+':';
      Etichetta.Autosize:=True;
      Etichetta.Left:=l;
      Etichetta.Top:=t;
      Etichetta.Height:=15;
      Etichetta.Font.Name:='Courier New';
      Etichetta.Font.Size:=8;
      QRLista.Add(Etichetta);

      Dato:=TQRDBText.Create(A090FStampa);
      Dato.Parent:=QRGroup1;
      Dato.Autosize:=False;
      Dato.Left:=l+Etichetta.Width+2;
      Dato.Top:=t;
      Dato.Width:=190;
      Dato.Height:=15;
      Dato.Font.Name:='Courier New';
      Dato.Font.Size:=8;
      Dato.Font.Style:=[FsBold];
      NomeFisico:=A090FAssenzeAnnoDtM1.A090MW.selI010.Lookup('Nome_Logico',A090FAssenzeAnno.ListaAnagra.Items[i],'Nome_Campo');
      Dato.DataField:=NomeFisico;
      Dato.DataSet:=C700SelAnagrafe;
      QRLista.Add(Dato);
      l:=l+350;
      if l>850 then
      begin
        l:=0;
        t:=t+17;
      end;
    end;
  end;
  if l=0 then
    t:=t-17;
  QRGroup1.Height:=t+17;
end;

procedure TA090FStampa.SvuotaQRLista;
var Oggetto:TObject;
begin
  while QRLista.Count > 0 do
  begin
    Oggetto:=QRLista.Items[QRLista.Count-1];
    if Oggetto is TQRDBText then
      (Oggetto as TQRDBText).free
    else if Oggetto is TQRLabel then
      (Oggetto as TQRLabel).free;
    QRLista.Delete(QRLista.Count-1);
  end;
end;

procedure TA090FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var i:Integer;
begin
  C700SelAnagrafe.Filtered:=True;
  for i:=0 to ComponentCount - 1 do
  begin
    if (Copy(Components[i].Name,1,10) = 'qlblGiorno')
    or (Components[i].Name = 'qlblMese')
    or (Copy(Components[i].Name,1,4) = 'QRLS') then
    begin
      //TQRLabel(Components[i]).Font.Size:=IfThen((RepR.qrprinter.destination = qrdPrinter) or RepR.Exporting,6,7);
      TQRLabel(Components[i]).Font.Size:=IfThen(RepR.Exporting,6,7);
      if (Components[i].Name <> 'qlblMese')
      and (Copy(Components[i].Name,Length(Components[i].Name)-1) <> '31') then
        //TQRLabel(Components[i]).Width:=IfThen((RepR.qrprinter.destination = qrdPrinter) or RepR.Exporting,30,32);
        TQRLabel(Components[i]).Width:=IfThen(RepR.Exporting,30,32);
    end;
  end;
end;

procedure TA090FStampa.QRBTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var OS8:TOracleSession;
    ODS:TOracleDataSet;
begin
  try
    begin
      OS8:=TOracleSession.Create(nil);
      ODS:=TOracleDataSet.Create(nil);
      qimgLogo.Width:=0;
      qimgLogo.Height:=0;
      try
        OS8.Preferences.UseOCI7:=False;
        OS8.LogonDatabase:=SessioneOracle.LogonDatabase;
        OS8.LogonUsername:=SessioneOracle.LogonUsername;
        OS8.LogonPassword:=SessioneOracle.LogonPassword;
        OS8.Logon;
        ODS.Session:=OS8;
        ODS.SQL.Add('SELECT IMMAGINE FROM T004_IMMAGINI WHERE TIPO = ''CARTELLINO''');
        ODS.Open;
        if ODS.RecordCount = 1 then
          with A090FAssenzeAnno do
          begin
            qimgLogo.Width:=StrToIntDef(edtLogoLarghezza.Text,0);
            qimgLogo.Height:=StrToIntDef(edtLogoAltezza.Text,0);
            qimgLogo.Picture.BitMap.Assign(TBlobField(ODS.FieldByName('IMMAGINE')));
          end;
        ODS.Close;
        OS8.Logoff;
      finally
        FreeAndNil(ODS);
        FreeAndNil(OS8);
      end;
      TQRBand(qimgLogo.Parent).Height:=max(AltezzaInizialeBandaTitolo,qimgLogo.Top + qimgLogo.Height + 3);
    end;
  except
    qimgLogo.Enabled:=False;
  end;
end;

procedure TA090FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  with A090FAssenzeAnnoDtM1 do
  begin
    C700SelAnagrafe.Filtered:=False;
    C700SelAnagrafe.Filter:='Progressivo=' + TabellaStampa.FieldByName('Progressivo').AsString;
    C700SelAnagrafe.Filtered:=True;
    C700SelAnagrafe.First;
  end;
  if A090FAssenzeAnno.chkTotIndiv.Checked then
    LAss.Clear;
end;

procedure TA090FStampa.CBSit1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  S,x,c,Sit1,Sit2,Sit3,Sit4:string;
  i,j:integer;
  MyQrLbl:TQRLabel;
begin
  with A090FAssenzeAnnoDtM1.TabellaStampa do
  begin
    qlblMese.Caption:=Copy(R180Capitalize(R180NomeMese(FieldByName('Mese').AsInteger)),1,3);
    // abilita le bande in base al contenuto dei dati
    CBSit2.Enabled:=Trim(FieldByName('Situazione2').AsString) <> '';
    CBSit3.Enabled:=Trim(FieldByName('Situazione3').AsString) <> '';
    CBSit4.Enabled:=Trim(FieldByName('Situazione4').AsString) <> '';
  end;

  // Carica i dati
  Sit1:=A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Situazione1').AsString;
  Sit2:=A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Situazione2').AsString;
  Sit3:=A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Situazione3').AsString;
  Sit4:=A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Situazione4').AsString;

  //Elimino i componenti creati ad hoc contenenti il nome del giorno
  for i:=CBSit1.ComponentCount - 1 downto 0 do
    if CBSit1.Components[i].Tag = 99 then
      CBSit1.Components[i].Free;

  CBSit1.Height:=CBSit2.Height;//Altezza del codice della causale
  if A090FAssenzeAnno.chkGGSett.Checked then
    CBSit1.Height:=CBSit1.Height + CBGiorni.Height;//Aggiunta altezza del nome del giorno (= altezza del numero del giorno)
  CBRigaFinale.Height:=1;//Serve solo per il Frame.DrawTop

  j:=1;
  for i:=0 to ComponentCount - 1 do
  begin
    S:=Copy(Components[i].Name,1,5);
    X:=Copy(Components[i].Name,7,2);
    if S = 'QRLS1' then
    begin
      //Posizione iniziale dei componenti delle causali
      TQRLabel(Components[i]).Top:=QRLS201.Top;
      if A090FAssenzeAnno.chkGGSett.Checked then
      begin
        MyQrLbl:=TQRLabel.Create(CBSit1);
        try
          MyQrLbl.Parent:=CBSit1;
          MyQrLbl.Tag:=99;
          MyQrLbl.Alignment:=qlblGiorno01.Alignment;
          MyQrLbl.Caption:=Copy(R180NomeGiorno(A090FAssenzeAnno.edtDaAnno.Value,A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Mese').AsInteger,j),1,2);
          MyQrLbl.Top:=qlblGiorno01.Top;
          MyQrLbl.Height:=qlblGiorno01.Height;
          MyQrLbl.Font.Size:=qlblGiorno01.Font.Size;
          MyQrLbl.Font.Style:=qlblGiorno01.Font.Style;
          MyQrLbl.AutoSize:=qlblGiorno01.AutoSize;
          MyQrLbl.Width:=TQRLabel(Components[i]).Width;//L'ultima cella non dev'essere rimpicciolita
          MyQrLbl.Left:=TQRLabel(Components[i]).Left;
          MyQrLbl.Frame.DrawBottom:=True;
          MyQrLbl.Frame.DrawLeft:=qlblGiorno01.Frame.DrawLeft;
          MyQrLbl.Frame.DrawRight:=qlblGiorno01.Frame.DrawRight;
          //Sposto i componenti delle causali
          TQRLabel(Components[i]).Top:=TQRLabel(Components[i]).Top + (MyQrLbl.Top + MyQrLbl.Height);
        except
          MyQrLbl.Free;
        end;
      end;

      C:=Trim(Copy(Sit1,((StrToInt(x)-1)*6)+1,5));
      TQRLabel(Components[i]).Caption:=C;
      inc(j);
      if A090FAssenzeAnno.chkTotIndiv.Checked then
        if (trim(C) <> '') and (trim(C) <> trim(A090FAssenzeAnno.edtCaratteri.Text)) then
          if LAss.IndexOf(C) = -1 then
            LAss.Add(C);
    end;
    if S='QRLS2' then
      TQRLabel(Components[i]).Caption:=Copy(Sit2,((StrToInt(x)-1)*6)+1,5);
    if S='QRLS3' then
    begin
      C:=Trim(Copy(Sit3,((StrToInt(x)-1)*6)+1,5));
      TQRLabel(Components[i]).Caption:=C;
      if A090FAssenzeAnno.chkTotIndiv.Checked then
        if (trim(C) <> '') then
          if LAss.IndexOf(C) = -1 then
            LAss.Add(C);
    end;
    if S='QRLS4' then
      TQRLabel(Components[i]).Caption:=Copy(Sit4,((StrToInt(x)-1)*6)+1,5);
  end;
end;

procedure TA090FStampa.CBSit2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=Trim(A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Situazione2').AsString) <> '';
end;

procedure TA090FStampa.CBRigaFinaleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=A090FAssenzeAnnoDtM1.TabellaStampa.FieldByName('Mese').AsInteger = R180Mese(A090FAssenzeAnno.AData);
end;

procedure TA090FStampa.QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
    UM,S,TitoloRiepilogo:String;
    Q,HRese:Real;
    G:TGiustificativo;
    Prog:LongInt;
  procedure StampaQuantitaAssenze(GesDataNas:Boolean; DataNas:TDateTime);
  var RiepAData:TDateTime;
  begin
    with A090FAssenzeAnnoDtM1 do
    begin
      if C700SelAnagrafe.FieldByName('T430FINE').IsNull then
        RiepAData:=A090FAssenzeAnno.AData
      else
        RiepAData:=min(A090FAssenzeAnno.AData,C700SelAnagrafe.FieldByName('T430FINE').AsDateTime);
      R600DtM1.GetQuantitaAssenze(Prog,A090FAssenzeAnno.DaData,RiepAData,DataNas,G,UM,Q,HRese);
      SetLength(R600DtM1.RiepilogoAssenze,0);
      R600DtM1.RiepilogaAssenze(Prog,RiepAData,G,GesDataNas,R600DtM1.RiferimentoDataNascita{.Data}); // csi
      S:=Format('%-7s',[LAss.Strings[i] + IfThen(GesDataNas,'*' + R600DtM1.RiferimentoDataNascita.IDFamiliare)]);
      S:=S + ' ' + Format('%-40s',[A090MW.Q265.Lookup('Codice',LAss.Strings[i],'Descrizione')]);
      (*
      S:=S + ' ' + Format('%-7s %7s',[A000TraduzioneStringhe(IfThen(UM = 'O',A000MSG_MSG_ORE,A000MSG_MSG_GIORNI)+':'),IfThen(UM = 'O',R180MinutiOre(Trunc(Q)),FloatToStr(Q))]);
      R600DtM1.GetAssenze(Prog,A090FAssenzeAnno.AData,A090FAssenzeAnno.AData,DataNas,G);
      S:=S + ' ' + Format('%-35s %12s %7s %7s',['',R600DtM1.GetCompTot,R600DtM1.GetFruitoTot,R600DtM1.GetResiduo]);
      *)
      (*Alberto 20/12/2013: gestione competenze ad Ore da trasformare in Giorni (TORINO_ITC)*)
      if Length(R600DtM1.RiepilogoAssenze) >= 1 then
      begin
        if (R600DtM1.RiepilogoAssenze[0].UM <> '') and A090FAssenzeAnno.chkRiepilogoCompetenze.Checked then
        begin
          S:=S + ' ' + Format('%-7s ',[A000TraduzioneStringhe(IfThen(R600DtM1.RiepilogoAssenze[0].ArrotOre2Giorni,'Giorni',R600DtM1.RiepilogoAssenze[0].UM)) + ':']);
          if R600DtM1.RiepilogoAssenze[0].ArrotOre2Giorni then
            S:=S + Format('%7s',[StringReplace(Format('%3.2f',[R600DtM1.TrasformaOre2Giorni(Q)]),',00','',[])])
          else
            S:=S + Format('%7s',[IfThen(UM = 'O',R180MinutiOre(Trunc(Q)),FloatToStr(Q))]);
          with R600DtM1.RiepilogoAssenze[0] do
            S:=S + ' ' + Format('%-35s %12s %7s %7s',['',IfThen(ArrotOre2Giorni,H_CT,CT),IfThen(ArrotOre2Giorni,H_FT,FT),IfThen(ArrotOre2Giorni,H_R,R)]);
        end
        else
        begin
          S:=S + ' ' + Format('%-7s %7s',[A000TraduzioneStringhe(IfThen(UM = 'O',A000MSG_MSG_ORE,A000MSG_MSG_GIORNI)) + ':',IfThen(UM = 'O',R180MinutiOre(Trunc(Q)),FloatToStr(Q))]);
        end;
      end;
      (**)
      QRMemo1.Lines.Add(S)
    end;
    QRMemo1.Height:=(QRMemo1.Lines.Count*15)+3;
    QRBand2.Height:=QRMemo1.Height + QRMemo1.Top;
  end;
begin
  QRMemo1.Lines.Clear;

  if A090FAssenzeAnno.chkRiepilogoCompetenze.Checked then
    TitoloRiepilogo:=Format('%-7s %-40s %-7s %7s %-35s %12s %7s %7s %s',
                           [A000TraduzioneStringhe(A000MSG_MSG_CAUSALE),
                            A000TraduzioneStringhe(A000MSG_MSG_DESCRIZIONE),
                            A000TraduzioneStringhe(A000MSG_MSG_UM),
                            A000TraduzioneStringhe(A000MSG_MSG_FRUITO),
                            A000TraduzioneStringhe(A000MSG_MSG_PERIODO_STAMPA),
                            A000TraduzioneStringhe(A000MSG_MSG_COMPETENZE),
                            A000TraduzioneStringhe(A000MSG_MSG_FRUITO),
                            A000TraduzioneStringhe(A000MSG_MSG_RESIDUO),
                            A000TraduzioneStringhe(A000MSG_MSG_AL) + ' ' + DateToStr(A090FAssenzeAnno.AData)])
  else
    TitoloRiepilogo:=Format('%-7s %-40s %-7s %7s %-35s',
                           [A000TraduzioneStringhe(A000MSG_MSG_CAUSALE),
                            A000TraduzioneStringhe(A000MSG_MSG_DESCRIZIONE),
                            A000TraduzioneStringhe(A000MSG_MSG_UM),
                            A000TraduzioneStringhe(A000MSG_MSG_FRUITO),
                            A000TraduzioneStringhe(A000MSG_MSG_PERIODO_STAMPA)]);
  qlblTitoloRiepilogo.Caption:=IfThen(LAss.Count = 0,'',TitoloRiepilogo);

  LAss.Sort;
  for i:=0 to LAss.Count - 1 do
    with A090FAssenzeAnnoDtM1 do
    begin
      Prog:=TabellaStampa.FieldByName('Progressivo').AsInteger;
      G.Inserimento:=False;
      G.Modo:='I';
      G.Causale:=LAss.Strings[i];
      if R180CarattereDef(VarToStr(A090MW.Q265.Lookup('Codice',G.Causale,'Cumulo_Familiari')),1,'N') in ['S','D'] then
        with R600DtM1.selT040DataNas do
        begin
          Close;
          SetVariable('Progressivo',Prog);
          SetVariable('Causale',G.Causale);
          SetVariable('Data1',A090FAssenzeAnno.DaData);
          SetVariable('Data2',A090FAssenzeAnno.AData);
          Open;
          while not Eof do
          begin
            StampaQuantitaAssenze(True,FieldByName('DataNas').AsDateTime);
            Next;
          end
        end
      else
        StampaQuantitaAssenze(False,Date);
    end;
end;

end.

