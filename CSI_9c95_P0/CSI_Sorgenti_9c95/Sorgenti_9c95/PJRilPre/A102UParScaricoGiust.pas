unit A102UParScaricoGiust;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls, Grids, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants, System.Actions;

type
  TA102FParScaricoGiust = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    dedtSeparatore: TDBEdit;
    Label8: TLabel;
    dcmbFormatoData: TDBComboBox;
    dchkDescCausale: TDBCheckBox;
    Label9: TLabel;
    dCmbAzienda: TDBLookupComboBox;
    dchkMatricolaNumerica: TDBCheckBox;
    dbrgpTipoFile: TDBRadioGroup;
    dchkAnnulPer: TDBCheckBox;
    procedure dbrgpTipoFileClick(Sender: TObject);
    procedure dCmbAziendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure DButtonStateChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CostruisciGriglia;
  public
    { Public declarations }
  end;

var
  A102FParScaricoGiust: TA102FParScaricoGiust;

procedure OpenA102ParScaricoGiust(Cod:String);

implementation

uses A102UParScaricoGiustDtM;

{$R *.DFM}

procedure OpenA102ParScaricoGiust(Cod:String);
{Parametrizzazione scarico rilevatori}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA102ParScaricoGiust') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A102FParScaricoGiust:=TA102FParScaricoGiust.Create(nil);
  with A102FParScaricoGiust do
    try
      A102FParScaricoGiustDtM:=TA102FParScaricoGiustDtM.Create(nil);
      A102FParScaricoGiustDtM.selI150.Locate('CODICE',Cod,[]);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A102FParScaricoGiustDtM.Free;
      Release;
    end;
end;

procedure TA102FParScaricoGiust.FormShow(Sender: TObject);
var i:Integer;
begin
  inherited;
  DButton.DataSet:=A102FParScaricoGiustDtM.selI150;
  with StringGrid1 do
  begin
    FixedRows:=1;
    ColWidths[0]:=40;
  end;
  with A102FParScaricoGiustDtM do
    for i:=1 to StringGrid1.ColCount - 1 do
      StringGrid1.Cells[i,0]:=selI150.FieldByName(GetNomeCampo(i)).DisplayLabel;
  CostruisciGriglia;
end;

procedure TA102FParScaricoGiust.CostruisciGriglia;
var i:Integer;
begin
  if dbrgpTipoFile.ItemIndex = 1 then
  begin
    with A102FParScaricoGiustDtM do
    begin
      StringGrid1.ColCount:=26;
      for i:=1 to StringGrid1.ColCount - 1 do
        StringGrid1.Cells[i,1]:=selI150.FieldByName(GetNomeCampo(i)).AsString;
    end;
  end
  else
    StringGrid1.ColCount:=18;
end;


procedure TA102FParScaricoGiust.DButtonDataChange(Sender: TObject;Field: TField);
{Carico nella Griglia i valori dei campi}
var i,P:Byte;
    S:String;
begin
  if Field = nil then
  begin
    CostruisciGriglia;
    Label7.Enabled:=DButton.DataSet.FieldByName('TIPOFILE').AsString = 'F';
    dedtSeparatore.Enabled:=DButton.DataSet.FieldByName('TIPOFILE').AsString = 'F';
    with A102FParScaricoGiustDtM do
    begin
      for i:=1 to StringGrid1.ColCount - 1 do
      begin
        S:=selI150.FieldByName(GetNomeCampo(i)).AsString;
        if selI150.FieldByName('TIPOFILE').AsString = 'T' then
          StringGrid1.Cells[i,1]:=S
        else
        begin
          P:=Pos(',',S);
          StringGrid1.Cells[i,1]:=Copy(S,1,P - 1);
          StringGrid1.Cells[i,2]:=Copy(S,P + 1,Length(S));
        end;
      end;
    end;
  end;
end;

procedure TA102FParScaricoGiust.DButtonStateChange(Sender: TObject);
{Rendo la griglia modificabile solo se sono in Insert o Edit}
begin
  inherited;
  Button1.Enabled:=DButton.State in [dsInsert,dsEdit];
  if DButton.State in [dsInsert,dsEdit] then
    StringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing]
  else
    StringGrid1.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
end;

procedure TA102FParScaricoGiust.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    A102FParScaricoGiustDtM.selI150NOMEFILE.AsString:=OpenDialog1.FileName;
end;

procedure TA102FParScaricoGiust.TRegisClick(Sender: TObject);
begin
  begin
    if StringGrid1.Cells[StringGrid1.ColCount - 1,StringGrid1.RowCount - 1] <> '0' then
    begin

      if trim(dbedit3.Text)='' then
      begin
        Application.MessageBox(Pchar('Indicare il codice del tipo di giustificativo a giornata intera.'), PChar('Informazione'), MB_Ok + MB_ICONINFORMATION);
        dbedit3.SetFocus;
        exit;
      end;

      if trim(dbedit4.Text)='' then
      begin
        Application.MessageBox(Pchar('Indicare il codice del tipo di giustificativo a mezza giornata.'), PChar('Informazione'), MB_Ok + MB_ICONINFORMATION);
        dbedit4.SetFocus;
        exit;
      end;

      if trim(dbedit5.Text)='' then
      begin
        Application.MessageBox(Pchar('Indicare il codice del tipo di giustificativo da ore a ore.'), PChar('Informazione'), MB_Ok + MB_ICONINFORMATION);
        dbedit5.SetFocus;
        exit;
      end;

      if trim(dbedit6.Text)='' then
      begin
        Application.MessageBox(Pchar('Indicare il codice del tipo di giustificativo a numero ore.'), PChar('Informazione'), MB_Ok + MB_ICONINFORMATION);
        dbedit6.SetFocus;
        exit;
      end;

    end;
  end;
  inherited;
end;

procedure TA102FParScaricoGiust.dCmbAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA102FParScaricoGiust.dbrgpTipoFileClick(Sender: TObject);
var i:Integer;
begin
  if dbrgpTipoFile.ItemIndex = 0 then
  begin
    GroupBox1.Caption:='Parametri file sequenziale';
    Label2.Caption:='Path e nome file';
    GroupBox2.Caption:='Mappatura dei dati sul file di input';
    Button1.Enabled:=True;
    Label7.Enabled:=True;
    dedtSeparatore.Enabled:=True;
    CostruisciGriglia;
    StringGrid1.RowCount:=3;
    StringGrid1.Cells[0,1]:='Pos.';
    StringGrid1.Cells[0,2]:='Lung.';
    for i:=3 to 18 do
    begin
      StringGrid1.Cells[i - 2,1]:='0';
      StringGrid1.Cells[i - 2,2]:='0';
    end;
  end
  else
  begin
    GroupBox1.Caption:='Parametri tabella Oracle';
    Label2.Caption:='Nome tabella Oracle';
    GroupBox2.Caption:='Mappatura dei dati nella tabella Oracle';
    Button1.Enabled:=False;
    Label7.Enabled:=False;
    dedtSeparatore.Enabled:=False;
    CostruisciGriglia;
    StringGrid1.RowCount:=2;
    StringGrid1.Cells[0,1]:='Campo';
    for i:=3 to 25 do
      StringGrid1.Cells[i - 2,1]:='';
  end;
end;

end.
