unit A150UCodiciAccorpamentoCausali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, StdCtrls, DBCtrls, ExtCtrls, ActnList, ImgList, DB,
  Menus, ComCtrls, ToolWin, Mask, Buttons, C015UElencoValori, C013UCheckList,
  C016UElencoVoci, C180FunzioniGenerali, OracleData, Oracle, A000UCostanti, A000USessione, A000UInterfaccia,
  A000UMessaggi;

type
  TA150FCodiciAccorpamentoCausali = class(TR004FGestStorico)
    pnlPrincipale: TPanel;
    lblDTipoAccorpCausali: TLabel;
    lblTipoAccorpCausali: TLabel;
    lblCodiciAccorpCausali: TLabel;
    lblDCodiciAccorpCausali: TLabel;
    edtCodTipoAccorpCausali: TEdit;
    edtCodCodiciAccorpCausali: TEdit;
    gpbAccorpamentoVoci: TGroupBox;
    Label2: TLabel;
    dlblDCausale: TDBText;
    dedtCodiceCausale: TDBEdit;
    btnFind1: TButton;
    btnFiltroVoci: TBitBtn;
    btnElimina: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnFind1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnFiltroVociClick(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
  private
    { Private declarations }
    AssSelezionate:String;
    procedure InserisciAssSelezionate;
  public
    { Public declarations }
  end;

var
  A150FCodiciAccorpamentoCausali: TA150FCodiciAccorpamentoCausali;

  procedure OpenA150FCodiciAccorpamentoCausali(CodTipoAccorpCausali, DTipoAccorpCausali, CodCodiciAccorpCausali, DCodiciAccorpCausali, Causale: String);

implementation

uses A150UCodiciAccorpamentoCausaliDtM;

{$R *.dfm}

procedure OpenA150FCodiciAccorpamentoCausali(CodTipoAccorpCausali, DTipoAccorpCausali, CodCodiciAccorpCausali, DCodiciAccorpCausali, Causale: String);
begin
  A150FCodiciAccorpamentoCausali:=TA150FCodiciAccorpamentoCausali.Create(nil);
  A150FCodiciAccorpamentoCausaliDtM:=TA150FCodiciAccorpamentoCausaliDtM.Create(nil);
  A150FCodiciAccorpamentoCausaliDtM.selT257.Close;
  A150FCodiciAccorpamentoCausaliDtM.selT257.SetVariable('CodTipoAccorpCausali',CodTipoAccorpCausali);
  A150FCodiciAccorpamentoCausaliDtM.selT257.SetVariable('CodCodiciAccorpCausali',CodCodiciAccorpCausali);
  A150FCodiciAccorpamentoCausaliDtM.selT257.Open;
  A150FCodiciAccorpamentoCausaliDtM.selT257.SearchRecord('Cod_TipoAccorpCausali;Cod_CodiciAccorpCausali;Cod_Causale',VarArrayOf([CodTipoAccorpCausali,CodCodiciAccorpCausali,Causale]),[srFromBeginning]);
  try
    A150FCodiciAccorpamentoCausali.edtCodTipoAccorpCausali.Text:=CodTipoAccorpCausali;
    A150FCodiciAccorpamentoCausali.lblDTipoAccorpCausali.Caption:=DTipoAccorpCausali;
    A150FCodiciAccorpamentoCausali.edtCodCodiciAccorpCausali.Text:=CodCodiciAccorpCausali;
    A150FCodiciAccorpamentoCausali.lblDCodiciAccorpCausali.Caption:=DCodiciAccorpCausali;
    A150FCodiciAccorpamentoCausali.ShowModal;
  finally
    A150FCodiciAccorpamentoCausali.Free;
    A150FCodiciAccorpamentoCausaliDtM.Free;
  end;
end;

procedure TA150FCodiciAccorpamentoCausali.btnEliminaClick(Sender: TObject);
begin
  inherited;
  if R180MessageBox(A000MSG_A150_DLG_CANCELLAZIONE,'DOMANDA') <> mrYes then
    Exit;
  with A150FCodiciAccorpamentoCausaliDtM do
  begin
    selT257.First;
    while not selT257.Eof do
      selT257.Delete;
    SessioneOracle.Commit;
  end;
end;

procedure TA150FCodiciAccorpamentoCausali.btnFiltroVociClick(Sender: TObject);
var j: integer;
  Cod:String;
  lstAssenze:TStringList;
begin
  inherited;
  with A150FCodiciAccorpamentoCausaliDtM do
  begin
    lstAssenze:=TStringList.Create;
    A150MW.selT265.Close;
    A150MW.selT265.Open;
    lstAssenze.Clear;
    while not A150MW.selT265.Eof do
    begin
      if not selT257.SearchRecord('COD_CAUSALE',A150MW.selT265.FieldByName('CODICE').AsString,[srFromBeginning]) then
      begin
        Cod:=Format('%-5s',[A150MW.selT265.FieldByName('CODICE').AsString]);
        lstAssenze.Add(Cod + ' ' + Format('%s',[A150MW.selT265.FieldByName('DESCRIZIONE').AsString]));
      end;
      A150MW.selT265.Next;
    end;
  end;
  try
    C013FCheckList:=TC013FCheckList.Create(nil);
    C013FCheckList.clbListaDati.Items.Assign(lstAssenze);
    C013FCheckList.Caption:='<A150> Filtro Assenze';
    for j:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
      if Pos(Trim(Copy(C013FCheckList.clbListaDati.Items[j],1,11)),AssSelezionate) > 0 then
        C013FCheckList.clbListaDati.Checked[j]:=True;
    if C013FCheckList.ShowModal = mrOK then
    begin
      AssSelezionate:=R180GetCheckList(11,C013FCheckList.clbListaDati);
      //Se ci sono assenze selezionate chiedo conferma prima dell'inserimento
      if AssSelezionate <> '' then
        if (R180MessageBox(A000MSG_A150_DLG_INSERISCI,DOMANDA) = mrYes) then
          InserisciAssSelezionate;
    end;
  finally
    C013FCheckList.Free;
    FreeAndNil(lstAssenze);
  end;
end;

procedure TA150FCodiciAccorpamentoCausali.InserisciAssSelezionate;
var i:Integer;
begin
  with A150FCodiciAccorpamentoCausaliDtM do
  begin
    for i:=0 to C013FCheckList.clbListaDati.Items.Count - 1 do
      if C013FCheckList.clbListaDati.Checked[i] then
      begin
        selT257.Insert;
        selT257.FieldByName('COD_CAUSALE').AsString:=Trim(Copy(C013FCheckList.clbListaDati.Items[i],1,5));
        selT257.FieldByName('DECORRENZA').AsDateTime:=StrToDate('01/01/1900');
        selT257.FieldByName('DECORRENZA_FINE').AsDateTime:=StrToDate('31/12/3999');
        selT257.Post;
        SessioneOracle.Commit;
      end;
  end;
end;

procedure TA150FCodiciAccorpamentoCausali.Stampa1Click(Sender: TObject);
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT T1.COD_TIPOACCORPCAUSALI, T1.COD_CODICIACCORPCAUSALI, T3.DESCRIZIONE,');
  QueryStampa.Add('  T1.COD_CAUSALE,T2.DESCRIZIONE DESC_CAUSALE, T1.DECORRENZA, T1.DECORRENZA_FINE');
  QueryStampa.Add(' FROM T257_ACCORPCAUSALI T1, T265_CAUASSENZE T2, T256_CODICIACCORPCAUSALI T3');
  QueryStampa.Add('WHERE T1.COD_CAUSALE = T2.Codice');
  QueryStampa.Add('  AND T1.COD_TIPOACCORPCAUSALI = T3.COD_TIPOACCORPCAUSALI');
  QueryStampa.Add('  AND T1.COD_CODICIACCORPCAUSALI = T3.COD_CODICIACCORPCAUSALI');
  NomiCampiR001.Clear;
  NomiCampiR001.Add('T1.COD_TIPOACCORPCAUSALI');
  NomiCampiR001.Add('T1.COD_CODICIACCORPCAUSALI');
  NomiCampiR001.Add('T3.DESCRIZIONE');
  NomiCampiR001.Add('T1.COD_CAUSALE');
  NomiCampiR001.Add('T2.DESCRIZIONE');
  NomiCampiR001.Add('T1.DECORRENZA');
  NomiCampiR001.Add('T1.DECORRENZA_FINE');
  inherited;
end;

procedure TA150FCodiciAccorpamentoCausali.btnFind1Click(Sender: TObject);
var vCodice:Variant;
begin
  inherited;
  with A150FCodiciAccorpamentoCausaliDtM do
  begin
    OpenC015FElencoValori('T265_CAUASSENZE','<A150> Selezione causale di assenza',A150MW.selT265.Sql.Text,'CODICE',vCodice,A150MW.selT265);
    if not VarIsClear(vCodice) then
      selT257.FieldByName('COD_CAUSALE').AsString:=VarToStr(vCodice[0]);
  end;
end;

procedure TA150FCodiciAccorpamentoCausali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnFind1.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA150FCodiciAccorpamentoCausali.FormShow(Sender: TObject);
begin
  inherited;
  VisioneCorrente1Click(nil);
end;

end.
