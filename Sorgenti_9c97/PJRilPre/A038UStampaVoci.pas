unit A038UStampaVoci;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, Qrctrls, quickrpt, ExtCtrls, QRExport, C700USelezioneAnagrafe,
  C180FunzioniGenerali, Variants, QRPDFFilt, QRWebFilt;

type
  TA038FStampaVoci = class(TR002FQRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qdedtMatricola: TQRDBText;
    qdedtDataRif: TQRDBText;
    qdedtVocePaghe: TQRDBText;
    qdedtValore: TQRDBText;
    QRGroup1: TQRGroup;
    QRMemo1: TQRMemo;
    Nominativo: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qdedtDal: TQRDBText;
    qdedtAl: TQRDBText;
    qdedtOperazione: TQRDBText;
    QRLabel8: TQRLabel;
    qdedtUM: TQRDBText;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A038FStampaVoci: TA038FStampaVoci;

implementation

uses A038UVociVariabiliDtM1, A038UDialogStampa;

{$R *.DFM}

procedure TA038FStampaVoci.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Nominativo.Caption:=Format('%s %s',[C700SelAnagrafe.FieldByName('COGNOME').AsString,C700SelAnagrafe.FieldByName('NOME').AsString]);
  qdedtOperazione.Enabled:=C700SelAnagrafe.FieldByName('OPERAZIONE').AsString = 'C';
end;

procedure TA038FStampaVoci.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
    S:String;
begin
  QRMemo1.Lines.Clear;
  with A038FDialogStampa do
    for i:=0 to CheckListBox1.Items.Count - 1 do
      if CheckListBox1.Checked[i] then
        begin
        if CheckListBox1.Items[i] = 'VOCE PAGHE' then
          S:='VOCE PAGHE:' + C700SelAnagrafe.FieldByName('VOCEPAGHE').AsString
        else if CheckListBox1.Items[i] = 'COD.PAGHE INTERNO' then
          S:='COD.PAGHE INTERNO:' + C700SelAnagrafe.FieldByName('COD_INTERNO').DisplayText
        else if CheckListBox1.Items[i] = 'DATA RIFERIMENTO' then
          S:='DATA RIFERIMENTO:' + C700SelAnagrafe.FieldByName('DATARIF').AsString
        else if CheckListBox1.Items[i] = 'DATA CASSA' then
          S:='DATA CASSA:' + C700SelAnagrafe.FieldByName('DATA_CASSA').AsString
        else if CheckListBox1.Items[i] = 'UNITA'' DI MISURA' then
          S:='UNITA'' DI MISURA:' + C700SelAnagrafe.FieldByName('UM').AsString
        else
          S:=CheckListBox1.Items[i] + ':' + C700SelAnagrafe.FieldByName(A038FVociVariabiliDtM1.selI010.Lookup('Nome_Logico',CheckListBox1.Items[i],'Nome_Campo')).AsString;
        QRMemo1.Lines.Add(S);
        end;
end;

end.
