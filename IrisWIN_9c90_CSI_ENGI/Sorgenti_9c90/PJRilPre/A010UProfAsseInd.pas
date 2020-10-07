unit A010UProfAsseInd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, DBCtrls, ExtCtrls, Mask, DB, Menus, Buttons,
  ComCtrls, A000UCostanti, A000USessione,A000UInterfaccia, C001UFiltroTabelleDtM,C700USelezioneAnagrafe,
  C001UFiltroTabelle, C001UScegliCampi, A002UInterfacciaSt, C005UDatiAnagrafici,
  ActnList, ImgList, ToolWin, SelAnagrafe, A017URaggrAsse, Variants, A003UDataLavoroBis,
  System.Actions;

type
  TA010FProfAsseInd = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    DBText2: TDBText;
    lblCompetenze: TLabel;
    lblPercentuale: TLabel;
    lblFascia1: TLabel;
    lblFascia2: TLabel;
    lblFascia3: TLabel;
    lblFascia4: TLabel;
    lblFascia5: TLabel;
    lblFascia6: TLabel;
    ERaggruppamento: TDBLookupComboBox;
    drdgUMisura: TDBRadioGroup;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    lblDataRes: TLabel;
    dedtDataRes: TDBEdit;
    Label14: TLabel;
    DBEdit15: TDBEdit;
    frmSelAnagrafe: TfrmSelAnagrafe;
    drdgRapportiUniti: TDBRadioGroup;
    dedtDataDal: TDBEdit;
    dedtDataAl: TDBEdit;
    lblDataDal: TLabel;
    lblDataAl: TLabel;
    btnDalCal: TButton;
    btnAlCal: TButton;
    lblNote: TLabel;
    DBMemo1: TDBMemo;
    procedure ERaggruppamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure drdgUMisuraChange(Sender: TObject);
    procedure drdgUMisuraClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure btnDalCalClick(Sender: TObject);
  private
    { Private declarations }
    procedure CambiaProgressivo;
  public
    { Public declarations }
  end;

var
  A010FProfAsseInd: TA010FProfAsseInd;

procedure OpenA010ProfAsseInd(Prog:LongInt);

implementation

uses A010UProfAsseIndDtM1;

{$R *.DFM}

procedure OpenA010ProfAsseInd(Prog:LongInt);
{Profili assenze individuali}
begin
  if Prog <= 0 then
  begin
    ShowMessage('Nessun dipendente selezionato!');
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA010ProfAsseInd') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A010FProfAsseInd:=TA010FProfAsseInd.Create(nil);
  with A010FProfAsseInd do
  try
    C700Progressivo:=Prog;
    A010FProfAsseIndDtM1:=TA010FProfAsseIndDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A010FProfAsseIndDtM1.Free;
    Free;
  end;
end;

procedure TA010FProfAsseInd.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A010FProfAsseIndDtm1.T263;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
end;

procedure TA010FProfAsseInd.btnDalCalClick(Sender: TObject);
begin
  inherited;
  with A010FProfAsseIndDtm1 do
    if Sender = btnAlCal then
      T263.FieldByName('AL').AsDateTime:=DataOut(T263.FieldByName('AL').AsDateTime,'Data a','T')
    else if Sender = btnDalCal then
      T263.FieldByName('DAL').AsDateTime:=DataOut(T263.FieldByName('DAL').AsDateTime,'Data da','T');
end;

procedure TA010FProfAsseInd.CambiaProgressivo;
begin
  with A010FProfAsseIndDtM1 do
  begin
    T263.SetVariable('Progressivo',C700Progressivo);
    T263.Close;
    T263.Open;
    NumRecords;
  end;
end;

procedure TA010FProfAsseInd.Nuovoelemento1Click(Sender: TObject);
{Richiamo le Dll per aggiungere i Profili e i Raggruppamenti}
begin
  OpenA017RaggrAsse(ERaggruppamento.Text);
  A010FProfAsseIndDtM1.Q260.Refresh;
end;

procedure TA010FProfAsseInd.Stampa1Click(Sender: TObject);
begin
  Querystampa.Clear;
  QueryStampa.Add('SELECT T1.PROGRESSIVO,T1.DAL,T1.AL,T1.CODRAGGR,T2.DESCRIZIONE,T1.UMISURA,T1.AGGIORNABILE,T1.DATARES,T1.DECURTAZIONE,');
  QueryStampa.Add('T1.COMPETENZA1,T1.RETRIBUZIONE1,T1.COMPETENZA2,T1.RETRIBUZIONE2,T1.COMPETENZA3,T1.RETRIBUZIONE3,T1.COMPETENZA4,T1.RETRIBUZIONE4,T1.COMPETENZA5,T1.RETRIBUZIONE5,T1.COMPETENZA6,T1.RETRIBUZIONE6');
  QueryStampa.Add('FROM T263_PROFASSIND T1, T260_RAGGRASSENZE T2');
  QueryStampa.Add('WHERE T1.CODRAGGR = T2.CODICE(+)');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.PROGRESSIVO');
  NomiCampiR001.Add('T1.DAL');
  NomiCampiR001.Add('T1.AL');
  NomiCampiR001.Add('T1.CODRAGGR');
  NomiCampiR001.Add('T2.DESCRIZIONE');
  NomiCampiR001.Add('T1.UMISURA');
  NomiCampiR001.Add('T1.AGGIORNABILE');
  NomiCampiR001.Add('T1.DATARES');
  NomiCampiR001.Add('T1.DECURTAZIONE');
  NomiCampiR001.Add('T1.COMPETENZA1');
  NomiCampiR001.Add('T1.RETRIBUZIONE1');
  NomiCampiR001.Add('T1.COMPETENZA2');
  NomiCampiR001.Add('T1.RETRIBUZIONE2');
  NomiCampiR001.Add('T1.COMPETENZA3');
  NomiCampiR001.Add('T1.RETRIBUZIONE3');
  NomiCampiR001.Add('T1.COMPETENZA4');
  NomiCampiR001.Add('T1.RETRIBUZIONE4');
  NomiCampiR001.Add('T1.COMPETENZA5');
  NomiCampiR001.Add('T1.RETRIBUZIONE5');
  NomiCampiR001.Add('T1.COMPETENZA6');
  NomiCampiR001.Add('T1.RETRIBUZIONE6');
  inherited;
end;

procedure TA010FProfAsseInd.drdgUMisuraChange(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si
lavori in Ore o in Giorni}
begin
  if DButton.State = dsBrowse then
    drdgUMisuraClick(Sender);
end;

procedure TA010FProfAsseInd.drdgUMisuraClick(Sender: TObject);
{Cambio la picture dei campi Competenze a seconda che si
lavori in Ore o in Giorni}
var i:Byte;
    RadioValue:Byte;
begin
  if drdgUMisura.ItemIndex < 0 then
    Exit;
  with A010FProfAsseIndDtM1.T263 do
  begin
    RadioValue:=drdgUMisura.ItemIndex;
    i:=4;
    while i <= 14 do
    begin
      if RadioValue = 1 then
        Fields[i].EditMask:='!9990.00;1;_'
      else
        Fields[i].EditMask:='!990,9;1;_';
      i:=i + 2;
      end;
    if RadioValue = 1 then
      FieldByName('Decurtazione').EditMask:='!#990.00;1;_'
    else
      FieldByName('Decurtazione').EditMask:='!#990,9;1;_';
  end;
end;

procedure TA010FProfAsseInd.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  btnDalCal.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnAlCal.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA010FProfAsseInd.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA010FProfAsseInd.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Date;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA010FProfAsseInd.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA010FProfAsseInd.ERaggruppamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
