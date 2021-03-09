unit A128UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin , C180FunzioniGenerali,A000UCostanti, A000USessione,A000UInterfaccia,
  Grids, DBGrids, QueryStorico, C001StampaLib, C700USelezioneAnagrafe, DB,
  A003UDataLavoroBis, Variants;

const NumLet = '0123456789ABCDEFGHILMNOPQRSTUVZ';

type
  TA128FDialogStampa = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    DBLookUpCampo: TDBLookupComboBox;
    Label3: TLabel;
    BtnData: TBitBtn;
    LblData: TLabel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure DBLookUpCampoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnDataClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    CampoGruppo,NomeLogicoCampoGruppo,TabellaCampoGruppo:String;
    procedure GeneraQueryMese;
    procedure GeneraQueryMista;
  public
    DataSt:TDateTime;
    function CreaDataCorrente(Data:TDateTime):String;
    { Public declarations }
  end;

var
  A128FDialogStampa: TA128FDialogStampa;

implementation

uses A128UPianPrestazioniAggiuntiveDtm,A128UStampa,A002UInterfacciaSt;

{$R *.DFM}

procedure TA128FDialogStampa.FormShow(Sender: TObject);
begin
  LblData.Caption:=CreaDataCorrente(DataSt);
  CampoGruppo:='';
  NomeLogicoCampoGruppo:='';
  TabellaCampoGruppo:='';
end;

procedure TA128FDialogStampa.GeneraQueryMese;
var Alias,Tabella,SQLSelect:String;
    i:ShortInt;
    SQLJoin,JoinOra:Array[1..31] of String;
    A,M,G,NG:Word;
begin
  with A128FPianPrestazioniAggiuntiveDtm do
  begin
    Q332St.DisableControls;
    Q332St.Close;
    DecodeDate(DataSt,A,M,G);
    SQLSelect:='';
    NG:=R180GiorniMese(DataSt);
    //Leggo le fasce dai dati in fasce
    for i:=1 to NG do
    begin
      Alias:='T332' + NumLet[i];
      Tabella:='T332_PIAN_ATT_AGGIUNTIVE ' + Alias;
      //SQLSelect:=SQLSelect + ',' + Alias + '.Data';
      SQLSelect:=SQLSelect + ',' + Alias + '.Turno1';
      SQLSelect:=SQLSelect + ',' + Alias + '.Turno2';
      case DataBaseDrv of
         //Sintassi ORACLE
         dbOracle:begin
                  if i <> 1 then
                    SQLJoin[i]:=','
                  else
                    SQLJoin[i]:='';
                  SQLJoin[i]:=SQLJoin[i] + Tabella;
                  JoinOra[i]:='T332_.Progressivo = ' + Alias +
                              '.Progressivo(+) AND ' + Alias + '.Data(+) = ' + '''' + FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,i)) + ''' AND';
                  end;
      end;
    end;
    with Q332St.Sql do
    begin
      Clear;
      Add('SELECT ' + Copy(SQLSelect,2,Length(SQLSelect)));
      Add('FROM ');
      for i:=1 to NG do
        Add(SQLJoin[i]);
      Add('WHERE');
      if DataBaseDrv = dbOracle then
        for i:=1 to NG do
          Add(JoinOra[i]);
        Add(Format(' T332_.Data BETWEEN ''%s'' AND ''%s''',[FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,1)),FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,NG))]));
    end;
    Q332St.EnableControls;
  end;
end;

procedure TA128FDialogStampa.GeneraQueryMista;
var App,S:String;
    TestoQVista,TestoQuery2:String;
    P:Integer;
    procedure CambiaT332T030;
    begin
      P:=Pos('T332_.',App);
      while P > 0 do
      begin
        Delete(App,P,5);
        Insert('T030',App,P);
        P:=Pos('T332_.',App);
      end;
    end;
begin
  with A128FPianPrestazioniAggiuntiveDtm do
  begin
    TestoQVista:=C700SelAnagrafe.Sql.Text;
    TestoQuery2:=UpperCase(Q332St.Sql.Text);
    TestoQVista:=EliminaRitornoACapo(TestoQVista);
    TestoQuery2:=EliminaRitornoACapo(TestoQuery2);
    Q332St.SQL.Clear;
    // Parte SELECT
    App:='SELECT ' + GetSelect(TestoQVista) +','+ GetSelect(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    Q332St.SQL.Add(App);
    // Parte FROM
    App:='FROM ' + GetFrom(TestoQVista)+','+GetFrom(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    Delete(App,Pos(',T332_PIAN_ATT_AGGIUNTIVE T332_',UpperCase(App)),Length(',T332_PIAN_ATT_AGGIUNTIVE T332_'));
    Q332St.SQL.Add(App);
    // Parte WHERE
    App:='WHERE ' + GetWhere(TestoQVista);
    App:=App + ' AND ' + GetWhere(TestoQuery2);
    App:=TogliParametro(App,DataSt);
    P:=Pos('T332_.DATA BETWEEN',UpperCase(App));
    S:=Copy(App,P + 19,30);
    Delete(App,P,49);
    Insert('0 < (SELECT COUNT(*) FROM T332_PIAN_ATT_AGGIUNTIVE WHERE PROGRESSIVO = T030.PROGRESSIVO AND DATA BETWEEN ' + S + ') ',App,P);
    CambiaT332T030;
    Q332St.SQL.Add(App);
    App:=GetOrderBy(TestoQVista);
    if (CampoGruppo <> '') and (Pos(UpperCase(CampoGruppo),StringReplace(StringReplace(UpperCase(Trim(App)),'V430.','',[rfReplaceAll]),'T030.','',[rfReplaceAll])) <> 1) then
      if App <> '' then
        App:=CampoGruppo + ',' + App
      else
        App:=CampoGruppo;
    App:='ORDER BY ' + App;
    App:=TogliParametro(App,DataSt);
    if App <> 'ORDER BY ' then
      Q332St.SQL.Add(App);
    //App:=TogliParametro(App,DataSt);
    Q332St.Close;
    Q332St.Open;
  end;
end;

function TA128FDialogStampa.CreaDataCorrente(Data:TDateTime):String;
var AA,MM,GG:Word;
    Mese:String;
begin
  DecodeDate(Data,AA,MM,GG);
  case MM of
     1: Mese:='Gennaio';
     2: Mese:='Febbraio';
     3: Mese:='Marzo';
     4: Mese:='Aprile';
     5: Mese:='Maggio';
     6: Mese:='Giugno';
     7: Mese:='Luglio';
     8: Mese:='Agosto';
     9: Mese:='Settembre';
     10: Mese:='Ottobre';
     11: Mese:='Novembre';
     12: Mese:='Dicembre';
  end;
  Result:=Mese + ' ' +inttostr(AA);
end;

procedure TA128FDialogStampa.BtnDataClick(Sender: TObject);
var A,M,G:Word;
begin
  DataSt:=DataOut(DataSt,'Data','M');
  DecodeDate(DataSt,A,M,G);
  DataSt:=EncodeDate(A,M,R180GiorniMese(DataSt));
  LblData.Caption:=CreaDataCorrente(DataSt);
end;

procedure TA128FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A128FStampa.RepR);
end;

procedure TA128FDialogStampa.BtnStampaClick(Sender: TObject);
var S:String;
begin
  with A128FPianPrestazioniAggiuntiveDtm do
    if DBLookUpCampo.KeyValue <> Null then
    begin
      NomeLogicoCampoGruppo:=DBLookUpCampo.Text;
      CampoGruppo:=selI010.FieldByName('Nome_Campo').AsString;
      TabellaCampoGruppo:=AliasTabella(selI010.FieldByName('Nome_Campo').AsString);
      S:=C700SelAnagrafe.SQL.Text;
      if R180InserisciColonna(S,TabellaCampoGruppo + '.' + CampoGruppo) then
      begin
        C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.SQL.Text:=S;
      end;
    end
    else
    begin
      NomeLogicoCampoGruppo:='';
      CampoGruppo:='';
      TabellaCampoGruppo:='';
    end;
  if DataSt <> C700SelAnagrafe.GetVariable('DataLavoro') then
  begin
    C700SelAnagrafe.CloseAll;
    C700SelAnagrafe.SetVariable('DataLavoro',DataSt);
  end;
  C700SelAnagrafe.Open;
  GeneraQueryMese;
  GeneraQueryMista;
  C001SettaQuickReport(A128FStampa.RepR);
  A128FStampa.DataStampa:=DataSt;
  A128FStampa.CampoGruppo:=CampoGruppo;
  A128FStampa.NomeLogicoCampoGruppo:=NomeLogicoCampoGruppo;
  A128FStampa.CreaReport;
end;

procedure TA128FDialogStampa.DBLookUpCampoKeyDown(Sender: TObject;
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
