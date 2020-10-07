unit Bc28UTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, MConnect, StdCtrls, A000UCostanti, ActiveX;

const
  MAXPRINTERBUFFER = 8000;
  MAXPRINTERNAME = 500;
  MAXPRINTERINFO = 50;

type
  TPrinterBuffer = array[0..MAXPRINTERBUFFER - 1] of char;

  TBc28FTest = class(TForm)
    Button1: TButton;
    DCOMConnection1: TDCOMConnection;
    btnPrinters: TButton;
    ListBox1: TListBox;
    btnSetPrinter: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnPrintersClick(Sender: TObject);
    procedure btnSetPrinterClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
  private
    { Private declarations }
    printerNames: TStringList;
    defaultPrinter: integer;
    function  SetPrinter(const PrinterName: String): boolean;
    procedure GetPrinterNames;
    function  ParseNames(const namebuffer: TPrinterBuffer; var startPos: integer): string;
  public
    { Public declarations }
  end;

var
  Bc28FTest: TBc28FTest;

implementation

uses C180FunzioniGenerali;

{$R *.dfm}

procedure TBc28FTest.Button1Click(Sender: TObject);
begin
  //Set TQuickRep.PrinterSettings.PrinterIndex to set the printer number. Then, TQuickRep.Print to print the report.

  //You can solve this problem by creating a new dword UserSelectedDefault with the value: 1 in HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows\SessionDefaultDevices\Session_ID
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.ProvaStampa('c:\temp\Bc28.pdf');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button20Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA145('SELECT /*+ ordered */ T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.PROGRESSIVO = 0' + #$D#$A,
                                        '',
                                         'SYSMAN',
                                         'CN1',
                                         'IRIS',
                                         '{"edtDataElaborazione":"28/01/2015","cmbMedicineLegali":"","chkIns":"N","chkProl":"N","chkSoloCont":"N","chkCanc":"N","chkAggiorna":"N",' +
                                         '"chkAnnulla":"S","chkEsenzioneAutomatica":"N","edtNumeroMinimoEventi":"","edtMaxGiorniContinuativi":"","edtMesiVerificaEventi":"","rgpTipoStampa":"0",' +
                                         '"chkPeriodiComunicati":"N","chkFiltroDataComun":"N","edtDataDa":"","edtDataA":"","chkStampaAssMal":"N","chkNote":"N","chkLogo":"N","edtLogoLarg":"","chkNumProt":"N",' +
                                         '"edtNumProt":"","chkLuogo":"N","edtLuogo":"","memDato1":"","memDato2":"","memFirma":"","lstElementiDettaglio":""}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button21Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try

    DCOMConnection1.AppServer.Prints715('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND'#$D#$A'((T030.COGNOME BETWEEN ''A%'' AND ''D%''))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                         'c:\temp\TestS715.pdf',
                                        'SYSMAN',
                                        'AO2',
                                        'DBCLIENTI',
                                        '{"edtDataDa":"01/01/2012","edtDataA":"31/12/2012","rgpTipoValutazione":"2","rgpTipoChiusura":"3","rgpStatoAvanzamento":"0",' +
                                        '"edtStatoAvanzamento":"","rgpDipValutabile":"2","rgpPresaVisione":"3","rgpSchedeProtocollo":"2","chkControllaRegola":"N","chkAggiornaPunteggi":"N",' +
                                        '"chkAvanzaStato":"N","chkChiudiScheda":"N","chkRiapriScheda":"N","chkRetrocediStato":"N","chkAggiornaIncentivi":"N","chkStampa":"S","chkFilePDF":"N",'+
                                        '"chkProtocolla":"N","chkSostituisciRegola":"N","chkAssegnaValutatore":"N","chkLegendaPunteggi":"N","chkPresaVisione":"N"}',
                                         '',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button22Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintAc04('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM' + #$D#$A +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + #$D#$A +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + #$D#$A +
                                        'T030.ComuneNas = T480.Codice(+) AND' + #$D#$A +
                                        ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + #$D#$A +
                                        'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(T430FINE,:DATALAVORO)' + #$D#$A +
                                        'AND T030.TIPO_PERSONALE = ''I''' + #$D#$A +
                                        'AND'#$D#$A'((T030.MATRICOLA = ''71614''))' + #$D#$A +
                                        'ORDER BY T030.COGNOME, T030.NOME',
                                        'c:\temp\TestAc04.pdf',
                                        'SYSMAN',
                                        'CSI',
                                        'IRIS9',
                                        '{"seAnno":"2015","seMese":"1","clbProgetti":"1"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button2Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA045('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) --AND (T030.COGNOME = ''ROSSI'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA045.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/01/2012","edtCausali":"0001,001","edtAData":"31/12/2012","rgpArrotondamentoQualifica":"1","rgpTipoArrotondamentoQualifica":"2",'+
                                         '"rgpArrotondamentoAssenza":"0","rgpTipoArrotondamentoAssenza":"2","rgpArrotondamentoTotale":"0","rgpTipoArrotondamentoTotale":"2","chkGGLavorativi":"S",'+
                                         '"ChkAssTutte":"S","ChkPartOr":"N","ChkAssTutte":"S","chkSantoPatrono":"S","LstListaCausali":"000001,A11030,S16020,T11008,T13660","LstListaTipiRapporto":'+
                                         '"ALTRO,CD0R,CD0TI,CD101,CD1TI,CD2TI,CD3TI,CD4TI,CG0TI,CG1TI,CG2TI,EE0TI,GP0TI,GP1TI,GP2TI,GP3TI,I,PA0P,PA0R,PA10T,PA11T,PA1P,PA1R,PA2P,PA2R,PA3P,PA3R,PA4P,'+
                                         'PA4R,PA9TI,PB0I,PB0TI,R,SI,TD"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button3Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA061('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) --AND (T030.COGNOME = ''ROSSI'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA061.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"dcmbTipoAcc":"","dcmbCampo":"T430D_CALENDARIO","edtDaData":"09/10/2012","edtAData":"31/07/2013","edtDaRegStamp":"02/07/2013","edtARegStamp":"01/07/2013","edtGGMinCont":"","rgpAssenzeConsiderate":"0","rgpValidate":"2"'+
                                         ',"rgpOrdinamento":"0","chkSoloAssRegSucc":"N","chkSalvaUltRegStamp":"N","chkDatiIndividuali":"S","chkStampaNominativo":"S","chkStampaMatricola":"S","chkStampaBadge":"S",'+
                                         '"chkDettGiorn":"N","chkDettPer":"S","chkSaltoPagRaggrup":"N","chkSaltoPagIndividuale":"N","chkConiuge":"N","chkRiduzioni":"N","chkSoloRiduzioni":"N","chkConteggiGG":"N",'+
                                         '"chkGiorniSignificativi":"N","chkCausaliCumulate":"N","chkPeriodoServizio":"N","chkTotIndividuali":"S","chkTotRaggrup":"N","chkTotFam":"N","chkTotGenerali":"S","LstCausali":'+
                                         '"00FER,00M10,00RIP,018,034,09999,0CGA,0FERI,0M100,0M10B,0REF,0RIP,1028,1028A,1029,1029A,10FER,10M10,10RIP,11,14,15,150,16,16P,17,18,19,1CGA,1FERI,1M100,1REF,20,20FER,23,2FERI,'+
                                         '49,4AFAC,4_AGG,50,51,52,54,55,A11,ALL,AMF,APP01,BV010,BV051,BV0RD,BV0RE,BV104,BVFSF,BVRSC,C000,C000P,C030,C1,C100,C1050,C1090,C1100,C15,C2,C2050,C2090,C2100,CD0M0,CDFM3,CDM1,CDM1B,' +
                                         'CDM5,CDM5B,CDM9,CDM9B,CPDR,EE0*P,EE0*R,EE0A0,EE0E0,EE0F0,EE0F8,EE0M0,EE0MA,EE0OS,EE0P0,EE0P1,EE0P2,EE0P3,EE0R0,EE1*P,EE1A0,EE1F0,EE1P0,EE2*P,EE2F0,EE2P0,EE3P0,F30,FERI2,FERI3,' +
                                         'FERIE,FFF,FSV1,FSV2,FSV3,FSV4,GP010,GP020,GP021,GP031,GP039,GP040,GP041,GP042,GP043,GP055,GP110,GP121,GP140,GP141,GP155,GP1OR,GP210,GP221,GP241,GREP,H42,ITCAL,L104,LICM,LS01,LS02,'+
                                         'M0,M000,M050,M090,M100,M100B,M50,M50B,M90,M90B,MAL,MALAT,MALF3,MAR,MN010,MOI,MR100,MR50,MR90,MRNR,OSP,PA0*P,PA0*R,PA0A0,PA0AF,PA0AG,PA0AR,PA0CN,PA0CO,PA0E0,PA0F0,PA0F1,PA0F4,PA0F5,'+
                                         'PA0F6,PA0F7,PA0F8,PA0F9,PA0FE,PA0FS,PA0LU,PA0M0,PA0M1,PA0M2,PA0MA,PA0OS,PA0P0,PA0P1,PA0PE,PA0R0,PA0RE,PA0RI,PA0RP,PA0V0,PA0X0,PA1*P,PA1A0,PA1AG,PA1E0,PA1F0,PA1F1,PA1F6,PA1FE,PA1M1,PA1P0,'+
                                         'PA1RE,PA1RI,PA1RP,PA2*P,PA2F0,PA2P0,PA2RE,PA2RI,PA3P0,PA4P0,PB0*P,PB0*R,PB002,PB010,PB051,PB070,PB091,PB092,PB0A0,PB0CS,PB0E0,PB0F0,PB0F7,PB0F8,PB0F9,PB0FS,PB0M1,PB0M2,PB0MA,PB0P0,PB0R,'+
                                         'PB0R0,PB0RI,PB0SA,PB1*P,PB1*R,PB101,PB109,PB110,PB111,PB170,PB191,PB193,PB1E0,PB1F0,PB1F7,PB1F8,PB1MA,PB1P0,PB1R0,PB210,PB270,PB293,PB2A0,PB2E0,PB2F0,PB2P0,PB310,PB370,PB390,PB3E0,PB410,PB470,'+
                                         'PB510,PB570,PB610,PB690,PB710,PB810,PB910,PRET,PRMF,PRO,PROVA,PT,PTV,R,R01,RANN,RASTI,RCH,RED,REF,RIP,RIPF,RIPFS,RIPOS,ROS,RPA,RPA_,RPP,T,X-001,X-002,X-003,X-004,X-005,X-006,X-007,X-008,X-009,ZZFER",'+
                                         '"LstCodAcc":"1,2,2,60GG,TEST,p1"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button4Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA043('SELECT /*+ ordered */ T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM ' + CRLF +
                                        'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                        'WHERE T030.Progressivo = V430.T430Progressivo AND' + CRLF +
                                        'T030.ComuneNas = T480.Codice(+) AND' + CRLF + ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                        'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)' + CRLF +
                                        'AND T030.TIPO_PERSONALE = ''I''' + CRLF + 'AND' + CRLF + '((T030.MATRICOLA LIKE ''12304''))' + CRLF + 'ORDER BY T030.COGNOME, T030.NOME',

                                         'c:\temp\TestA043.pdf',
                                         'NANDO',
                                         'CN1',
                                         'DBCLIENTI',

                                         '{"edtAnno":"2013","cmbMese":"5","edtDa":"1","edtA":"30","chkSalva":"N","chkIgnoraAnomalie":"N","chkSpezzoniMese":"N","chkCumula":"N","chkSoloAnomalie":"N","chkSaltoPagina":"S","rgpTipoStampa":"0","dcmbCampo":"","SoloAgg":"N"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button5Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA074('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'' and COGNOME like ''DIPENDENTE%'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA074.pdf',
                                         'SYSMAN',
                                         'CORSO',
                                         'MEDP_ORCL',

                                         '{"ActiveTab":"0","edtDa":"01/08/2013","edtA":"31/08/2013","ChkDettaglio":"S","ChkAcquisto":"N","ChkInizioAnno":"N","ChkSaltoPagina":"N","ChkAggiorna":"N",' +
                                         '"ChkIgnoraAnomalie":"N","edtDataAcquisto":"10/2013","edtUltimoAcquisto":"ottobre 2013","chkAcqDatiIndividuali":"S","chkAcqSaltoPagina":"N",' +
                                         '"chkAcqAggiornamento":"N","chkFileSequenziale":"N","chkScaricoPaghe":"N","edtFileSequenziale":"","edtPwdFileSequenziale":"","dcmbParametrizzazione":"","dcmbRaggrAnagrafico":"T430ABCAUSALE1"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;

end;

procedure TBc28FTest.Button6Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA042('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA042.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/10/2010","edtAData":"31/10/2013","edtDaOra":"15.00","edtAOra":"18.00","rgpTipoStampa":"3","LstIntestazione":"BADGE,CAP,CITTA",'+
                                         '"LstDettaglio":"CODICE FISCALE,COMUNE","chkGiornoCorrente":"N","chkDescrizioneAssenze":"N","chkTurnista":"N","chkTabellare":"N","chkRaggData":"N",'+
                                         '"chkTotaliData":"N","chkSaltoPaginaData":"N","chkTotali":"N","chkTotaliGruppo":"N","chkSaltoPagina":"N","edtTitoloGrafico":"test","chkVisLineeV":"N","chkVisLineeH":"N"}'
                                         ,

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button7Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA092('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA092.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"02/10/2013","edtAData":"02/10/2013","rgpOrdinamento":"0","CgpAnagra":"BADGE,CAP,CELLULARE AZIENDALE","chkVariazioni":"N","chkSaltoPagina":"S"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button8Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA081('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA081.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDaData":"01/10/2013","edtAData":"31/10/2013","chkTotGenerale":"S","chkTotRaggr":"S","chkTotCaus":"N","chkTotData":"N","chkStampaDett":"S","chkSaltoRaggr":"N","chkSaltoCaus":"N","CgpListaCausali":"0ASS+,1S,1SC","dcmbCampoRaggr":"CAPNAS"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button9Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA090('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO FROM'#$D#$A'T030_Anagrafico '+
                                        'T030, V430_Storico V430, T480_Comuni T480'#$D#$A'WHERE T030.Progressivo = V430.T430Progressivo AND'#$D#$A'T030.ComuneNas = T480.Codice(+) '+
                                        'AND'#$D#$A':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine'#$D#$A'AND T030.TIPO_PERSONALE = ''I'''#$D#$A'ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA090.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtDaAnno":"2009","edtDaMese":"9","edtAMese":"9","edtTitolo":"Stampa situazione assenze dal <DAL> al <AL>","edtFirma":"Il Responsabile","edtCaratteri":"***","edtLogoLarghezza":"271","edtLogoAltezza":"86","chkSegnalazPresenza":"S",'+
                                         '"chkSecCausaleAss":"S","chkRigaValoriz":"S","chkTotIndiv":"S","chkRiepilogoCompetenze":"N","chkSaltoPag":"S","chkStampaAllDip":"S","chkGGSett":"N","chkIntestazione":"S","chkData":"S",'+
                                         '"chkNumPagina":"S","chkAzienda":"S","CgpListaAnagr":"BADGE,CALEN,CAP,CAP N,CELLU,CELLU,CELLU,CENTR,CENTR,CENTR,CITTA,COD P,COD P,COD P,COD P,COD Q,COD Q,COD Q,'+
                                         'COD R,COD R,COD S,COD S,COD S,COD S,COD S,COD S,COD S,COD T,COD T,CODIC,COGNO,COMUN,COMUN,CONTR,CREDI,DATA,DATA,DATA,DATO,DIPAR,DISCI,DISTR,DOCEN,DOMIC,D_PAS,'+
                                         'D_PRO,INIZI,INIZI,MATRI,NOME,PART,POSIZ,PRESI,PROFE,PROGR,PROVI,QUAL,QUALI,QUALI,QUAL_,RAPPO,SCAD.,SESSO,SQUAD,STRUT,T430A,T430A,T430A,T430A,T430B,T430C,T430C,'+
                                         'T430C,T430C,T430C,T430C,T430C,T430C,T430C,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,'+
                                         'T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,T430D,'+
                                         'T430D,T430E,T430E,T430E,T430E,T430E,T430E,T430F,T430F,T430F,T430H,T430I,T430I,T430I,T430I,T430I,T430L,T430M,T430M,T430M,T430M,T430N,T430O,T430P,T430P,T430P,T430P,'+
                                         'T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430P,T430Q,T430R,T430R,T430S,T430S,T430S,T430S,T430S,T430T,T430T,T430T,T430T,T430T,T430T,T430T,T430U,'+
                                         'T430U,T430U,TELEF","CgpListaCausali":"00FER,00M10,00RIP,018,034,09999,0CGA,0FERI,0M100,0M10B,0REF,0RIP,1028,1028A,1029,1029A,10FER,10M10,10RIP,11,14,15,150,16,16P,'+
                                         '17,18,19,1CGA,1FERI,1M100,1REF,20,20FER,23,2FERI,49,4AFAC,4_AGG,50,51,52,54,55,A11,ALL,AMF,APP01,BV010,BV051,BV0RD,BV0RE,BV104,BVFSF,BVRSC,C000,C000P,C030,C1,C100,'+
                                         'C1050,C1090,C1100,C15,C2,C2050,C2090,C2100,CD0M0,CDFM3,CDM1,CDM1B,CDM5,CDM5B,CDM9,CDM9B,CPDR,EE0*P,EE0*R,EE0A0,EE0E0,EE0F0,EE0F8,EE0M0,EE0MA,EE0OS,EE0P0,EE0P1,EE0P2,'+
                                         'EE0P3,EE0R0,EE1*P,EE1A0,EE1F0,EE1P0,EE2*P,EE2F0,EE2P0,EE3P0,F30,FERI2,FERI3,FERIE,FFF,FSV1,FSV2,FSV3,FSV4,GP010,GP020,GP021,GP031,GP039,GP040,GP041,GP042,GP043,GP055,'+
                                         'GP110,GP121,GP140,GP141,GP155,GP1OR,GP210,GP221,GP241,GREP,H42,ITCAL,L104,LICM,LS01,LS02,M0,M000,M050,M090,M100,M100B,M50,M50B,M90,M90B,MAL,MALAT,MALF3,MAR,MN010,MOI,'+
                                         'MR100,MR50,MR90,MRNR,OSP,PA0*P,PA0*R,PA0A0,PA0AF,PA0AG,PA0AR,PA0CN,PA0CO,PA0E0,PA0F0,PA0F1,PA0F4,PA0F5,PA0F6,PA0F7,PA0F8,PA0F9,PA0FE,PA0FS,PA0LU,PA0M0,PA0M1,PA0M2,'+
                                         'PA0MA,PA0OS,PA0P0,PA0P1,PA0PE,PA0R0,PA0RE,PA0RI,PA0RP,PA0V0,PA0X0,PA1*P,PA1A0,PA1AG,PA1E0,PA1F0,PA1F1,PA1F6,PA1FE,PA1M1,PA1P0,PA1RE,PA1RI,PA1RP,PA2*P,PA2F0,PA2P0,'+
                                         'PA2RE,PA2RI,PA3P0,PA4P0,PB0*P,PB0*R,PB002,PB010,PB051,PB070,PB091,PB092,PB0A0,PB0CS,PB0E0,PB0F0,PB0F7,PB0F8,PB0F9,PB0FS,PB0M1,PB0M2,PB0MA,PB0P0,PB0R,PB0R0,PB0RI,'+
                                         'PB0SA,PB1*P,PB1*R,PB101,PB109,PB110,PB111,PB170,PB191,PB193,PB1E0,PB1F0,PB1F7,PB1F8,PB1MA,PB1P0,PB1R0,PB210,PB270,PB293,PB2A0,PB2E0,PB2F0,PB2P0,PB310,PB370,PB390,'+
                                         'PB3E0,PB410,PB470,PB510,PB570,PB610,PB690,PB710,PB810,PB910,PRET,PRMF,PRO,PROVA,PT,PTV,R,R01,RANN,RASTI,RCH,RED,REF,RIP,RIPF,RIPFS,RIPOS,ROS,RPA,RPA_,RPP,T,X-001,X-002,X-003,X-004,X-005,X-006,X-007,X-008,X-009,ZZFER"}'
                                         ,

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button10Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA116('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND (T030.COGNOME LIKE ''CASA%'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA116.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtAnno":"2012","edtData":"10/2013","edtMaxLiq":"00.00","edtArrotLiq":"0","chkAbbattimentoOre":"S","chkSaltoPag":"S","chkTotaliRaggr":"S","chkTotaliGen":"S","chkCessati":"S",' +
                                         '"cgpIntestazione":"CAP,CELLULARE AZIENDALE,CELLULARE PERSONALE3","cgpDettaglio":"CALENDARIO,CAP NASCITA,CELLULARE PERSONALE 2","SoloAgg":"N"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button11Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA077((*'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.TIPO_PERSONALE = ''I'' AND ((T030.MATRICOLA LIKE ''4444'')) ORDER BY T030.COGNOME,'+
                                         ' T030.NOME'*)
                                         'SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.PROGRESSIVO IN (   SELECT /*+  UNNEST */ PROGRESSIVO FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 '+
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) '+
                                         'AND :DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE AND :DATALAVORO >= T430INIZIO AND :C700DATADAL <= NVL(T430FINE,:DATALAVORO) '+
                                         'AND T030.TIPO_PERSONALE = ''I'' AND (T030.COGNOME IN (''ABD EL KRIEM'')) ) ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA077.pdf',
                                         'MONDOEDP',
                                         'SGIULIANO_MI',
                                         'SGIULIANO_MI.WORLD',

                                         '{"edtDal":"01/04/2015","edtAl":"30/04/2015","CodiceStampa":"_ASSPRES"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button12Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA059( 'c:\temp\TestA059.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"cmbDaSquadra":"21203","cmbASquadra":"60005","edtDaData":"14/11/2013","edtAData":"15/11/2013","rgpModalita":"0","rgpTipo":"0"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button13Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA068('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO,T430SQUADRA,'+
                                        'T430D_SQUADRA FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE T030.Progressivo = V430.T430Progressivo '+
                                        'AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine AND T030.TIPO_PERSONALE '+
                                        '= ''I'' ORDER BY T030.COGNOME, T030.NOME'
                                         ,

                                         'c:\temp\TestA068.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtData":"11/11/2013","edtIntestazione":"Settore test","rgpTPianif":"1"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button14Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA058(  'SELECT  T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE '+
                                          ' FROM   T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'+
                                          ' WHERE T030.Progressivo = V430.T430Progressivo AND   T030.ComuneNas = T480.Codice(+) AND   :DataLavoro BETWEEN V430.T430DataDecorrenza AND'+
                                          ' V430.T430DataFine   AND T030.PROGRESSIVO IN (     SELECT /*+ UNNEST */ PROGRESSIVO FROM   T030_Anagrafico T030, V430_Storico V430,'+
                                          ' T480_Comuni T480   WHERE T030.Progressivo = V430.T430Progressivo AND   T030.ComuneNas = T480.Codice(+) AND   :DATALAVORO >='+
                                          ' T430DATADECORRENZA AND :DATADAL <= T430DATAFINE   AND :DATALAVORO >= T430INIZIO AND :DATADAL <= NVL(LAST_DAY(T430FINE),:DATADAL) AND'+
                                          ' (T030.COGNOME = ''ANDRONICO''))   ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA'
                                         ,

                                         'c:\temp\TestA058.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtDataDa":"01/11/2013","edtDataA":"30/11/2013","rgpTipo":"1","dcmbsquadra":"26001","dcmbProfili":"02"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button15Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA105('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA105.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS9',

                                         '{"edtDaData":"01/11/2010","edtAData":"30/11/2013","dcmbCampo":"","StatoPaghe":"",'+
                                         '"chkRecordFisici":"S","chkAssenzeInserite":"S","chkAssenzeCancellate":"S","chkDettaglioGiornaliero":"N","chkDettaglioPeriodico":"S","chkDatiIndividuali":"S",'+
                                         '"chkSaltoPaginaIndividuale":"S","chkSaltoPaginaRaggr":"N","chkTotaliIndividuali":"S","chkTotaliRaggr":"N","chkTotaliGenerali":"S",'+
                                         '"clbCausali":"14,16P,APP01,MAL,CDM5"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button16Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA051('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA051.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',

                                         '{"edtAnno":"2014","cmbMese":"1","edtDa":"01","edtA":"28","chkSaltoPagina":"S","rgpTimbrature":"0","dcmbCampoRaggr":"CITTA"}',

                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;


procedure TBc28FTest.Button17Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA104('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) AND ((T030.MATRICOLA IN (''2'',''1968'')))' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA051.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"edtMeseScaricoDa":"02/2014","edtMeseScaricoA":"02/2014","edtStato":"D,S","ChkSaltoPagina":"S","EdtTitolo":"RIEPILOGO LIQUIDAZIONI MENSILI"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button18Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA047('SELECT T030.*,T480.CITTA,T480.PROVINCIA,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE' + CRLF +
                                         'FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480' + CRLF +
                                         'WHERE T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine' + CRLF +
                                         'AND :DATALAVORO BETWEEN T430INIZIO AND NVL(LAST_DAY(T430FINE),:DATALAVORO) --AND (T030.COGNOME = ''ROSSI'')' + CRLF +
                                         'ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA',

                                         'c:\temp\TestA047.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"eDaData":"01/01/2010","eAData":"30/04/2014","rgpTipoStampa":"0","chkDatiIndividuali":"S","chkDettaglioGiornaliero":"S","chkTotaliIndividuali":"N",'+
                                         '"chkSaltoPaginaIndividuale":"N","chkTimbraturePresenza":"N","chkTimbraturePresenzaCausalizzate":"N","chkGiustificativiAssenza":"N","chkAnomalie":"N",'+
                                         '"chkNominativi":"N","chkRilevatori":"N","chkCausale":"N","chkSaltoPagina":"N","chkDistinzioneCausale":"N","chkPranzoCena":"N","edtRaggr":"COD POSIZIONE FUNZIONALE,COD PROFESSIONE","chkSaltoPaginaRaggr":"N","LstOrologi":"12,17"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.Button19Click(Sender: TObject);
begin
  if (not IsLibrary) then
    CoInitialize(nil);
  if not DCOMConnection1.Connected then
    DCOMConnection1.Connected:=True;
  try
    DCOMConnection1.AppServer.PrintA167('SELECT  T030.MATRICOLA,T030.COGNOME,T030.NOME,T430BADGE,T430INIZIO,T430FINE,T030.PROGRESSIVO ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,'+
                                         'V430.T430DATADECORRENZA,V430.T430DATAFINE FROM T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480 WHERE '+
                                         'T030.Progressivo = V430.T430Progressivo AND T030.ComuneNas = T480.Codice(+) AND :DataLavoro BETWEEN V430.T430DataDecorrenza '+
                                         'AND V430.T430DataFine AND T030.TIPO_PERSONALE = ''I'' AND ((T030.MATRICOLA LIKE ''4444'')) ORDER BY T030.COGNOME,'+
                                         ' T030.NOME',
                                         'c:\temp\TestA167.pdf',
                                         'SYSMAN',
                                         'AZIN',
                                         'IRIS',
                                         '{"edtDaData":"01/2014","edtAData":"12/2014","cmbTipoCalcolo":"A",' +
                                         '"edtQuote":"1,3,5,6","cmbCampoAnag":"","chkSaltoPagina":"N","chkDettaglio":"S","rgpTipoDati":"0","cgpColonne":"Quota intera [1],Quota netta + Risp. [4]","chkAggiorna":"N","chkAnnulla":"N","SoloAgg":"N"}',
                                         '');
  finally
    DCOMConnection1.Connected:=False;
  end;
end;

procedure TBc28FTest.btnSetPrinterClick(Sender: TObject);
var
  x : integer;
begin
  try
  for x := 0 to printerNames.Count -1 do begin
    If ListBox1.Selected[x] then begin
      if (SetPrinter(ListBox1.Items.Strings[x]))
      then label1.Caption := 'Printer set to ' + ListBox1.Items.Strings[x]
      else label1.Caption := 'Printer not set';
    end;
  end;
  except
    label1.Caption := 'An error occured while setting the printer';
  end;
end;

procedure TBc28FTest.GetPrinterNames;
var
  buffer: TPrinterBuffer;
  currPos: integer;
  printerName: string;
begin
  printerNames.Free;
  printerNames := TStringList.Create;
  if GetProfileString(PChar('PrinterPorts'), nil, '', buffer, MAXPRINTERBUFFER) > 0 then
  begin
    currPos := 0;
    while (true) do
      begin
        printerName := ParseNames(buffer, currPos);
        if printerName <> '' then
        printerNames.Add(printerName)
    else
      break;
    end;
  end;
end;

function TBc28FTest.ParseNames(const namebuffer: TPrinterBuffer; var startPos: integer): string;
var
  i, j, NameLength: integer;
  str: string;
begin
  result := '';
  if (startPos > High(namebuffer)) or (namebuffer[startPos] = Chr(0))

  then
    exit;
  for i := startPos to High(namebuffer) do begin
    if namebuffer[i] = Chr(0)

    then begin
      nameLength := i - startPos;
      SetLength(str, nameLength);
      for j := 0 to nameLength - 1 do
      str[j+1] := namebuffer[startPos + j];
      result := str;
      startPos := i + 1;
      break;
    end;
  end;
end;

function TBc28FTest.SetPrinter(const PrinterName: String): boolean;
var
  s2 : string;
  dum1 : Pchar;
  xx, qq : integer;
const
  cs1 : pchar = 'Windows';
  cs2 : pchar = 'Device';
  cs3 : pchar = 'Devices';
  cs4 : pchar = #0;

begin
  xx := 254;
  GetMem( dum1, xx);
  Result := False;
  try
    qq := GetProfileString( cs3, pchar( printerName ), #0, dum1, xx);
    if (qq > 0) and (trim( strpas( dum1 )) <> '')

   then begin
      s2 := PrinterName + ',' + strpas( dum1 );
      while GetProfileString( cs1, cs2, cs4, dum1, xx) > 0 do
        WriteProfileString( cs1, cs2, #0);
      WriteProfileString( cs1, cs2, pchar( s2 ));
      case Win32Platform of
       VER_PLATFORM_WIN32_NT :
        // SendMessage( HWND_BROADCAST, WM_WININICHANGE, 0, LongInt(cs1));
        // VER_PLATFORM_WIN32_WINDOWS :
        // SendMessage( HWND_BROADCAST, WM_SETTINGCHANGE, 0, LongInt(cs1));
     end;
  Result := True;
end;
finally
  FreeMem( dum1 );
end;
end;

procedure TBc28FTest.btnPrintersClick(Sender: TObject);
begin
  GetPrinterNames;
  Listbox1.Items.AddStrings(PrinterNames);
end;
end.
