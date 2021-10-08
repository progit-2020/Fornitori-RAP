unit A058UModPianif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Db, Buttons, ExtCtrls, Variants, A000UCostanti, A000USessione, Oracle, OracleData,
  Mask, A000UInterfaccia, Rp502Pro, StrUtils;

type
  TA058FModPianif = class(TForm)
    D020: TDataSource;
    Label1: TLabel;
    DBText1: TDBText;
    Label6: TLabel;
    Label5: TLabel;
    lblPNT1: TLabel;
    lblPNT2: TLabel;
    lblSiglaT1: TLabel;
    lblSiglaT2: TLabel;
    EOrario: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmbTurno1: TComboBox;
    cmbTurno1EU: TComboBox;
    cmbTurno2: TComboBox;
    cmbTurno2EU: TComboBox;
    GroupBox1: TGroupBox;
    D265: TDataSource;
    D265B: TDataSource;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    EAssenza1: TDBLookupComboBox;
    EAssenza2: TDBLookupComboBox;
    edtDaData: TMaskEdit;
    edtAData: TMaskEdit;
    Label4: TLabel;
    Label7: TLabel;
    procedure EOrarioClick(Sender: TObject);
    procedure cmbTurno1Change(Sender: TObject);
    procedure D020DataChange(Sender: TObject; Field: TField);
    procedure EOrarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EAssenza1CloseUp(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EOrarioExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    T1,T2,
    T1EU,T2EU,
    Assenza1,Assenza2,
    SiglaT1, SiglaT2,
    NTurno1, NTurno2:String;
  end;

var
  A058FModPianif: TA058FModPianif;

implementation

uses A058UPianifTurniDtM1, A058UPianifTurni, A058UGrigliaPianif;

{$R *.DFM}

procedure TA058FModPianif.FormShow(Sender: TObject);
var
  i, j:integer;
begin
  DBText1.Visible:=EOrario.KeyValue <> '';
  DBText2.Visible:=EAssenza1.KeyValue <> '';
  DBText3.Visible:=EAssenza2.KeyValue <> '';
  with A058FPianifTurniDtM1 do
  begin
    Q020.SearchRecord('CODICE',EOrario.KeyValue,[srFromBeginning]);
    Q265.SearchRecord('CODICE',EAssenza1.KeyValue,[srFromBeginning]);
    Q265B.SearchRecord('CODICE',EAssenza2.KeyValue,[srFromBeginning]);
  end;

  if StrToIntDef(T1,-1) >= 0 then
    CmbTurno1.Text:=T1 + ' - ' + IfThen(SiglaT1 <> '', SiglaT1, '(' + NTurno1 + ')');
  if StrToIntDef(T2,-1) >= 0 then
    CmbTurno2.Text:=T2 + ' - ' + IfThen(SiglaT2 <> '', SiglaT2, '(' + NTurno2 + ')');
  CmbTurno1EU.Text:=T1EU;
  CmbTurno2EU.Text:=T2EU;
  if (A000GetInibizioni('Funzione','OpenA004GiustifAssPres') <> 'S') and
     (A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString <> 'N') then
  begin
    EAssenza1.Enabled:=False;
    EAssenza2.Enabled:=False;
  end
  else
  begin
    with A058FPianifTurniDtm1, A058FGrigliaPianif do
    begin
      i:=GVista.Row - nRigheBloccate;
      j:=GVista.Col - nColonneBloccate;
      EAssenza1.Enabled:=TGiorno(TDipendente(Vista[i]).Giorni[j]).Ass1Modif;
      EAssenza2.Enabled:=TGiorno(TDipendente(Vista[i]).Giorni[j]).Ass2Modif;
    end;
  end;
  cmbTurno1Change(cmbTurno1);
  cmbTurno1Change(cmbTurno2);
end;

procedure TA058FModPianif.D020DataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then
    if Sender = D020 then
      DBText1.Visible:=True
    else if Sender = D265 then
      DBText2.Visible:=True
    else if Sender = D265B then
      DBText3.Visible:=True;
end;

procedure TA058FModPianif.EOrarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not(Sender as TDBLookupComboBox).ListVisible) then
    if Sender = EOrario then
      DBText1.Visible:=False
    else
      if Sender = EAssenza1 then
        DBText2.Visible:=False
      else
        DBText3.Visible:=False;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA058FModPianif.EAssenza1CloseUp(Sender: TObject);
begin
  if (Sender as TDBLookupComboBox).KeyValue = Null then
    if Sender = EOrario then
      DBText1.Visible:=False
    else
      if Sender = EAssenza1 then
        DBText2.Visible:=False
      else
        DbText3.Visible:=False;
end;

procedure TA058FModPianif.BitBtn1Click(Sender: TObject);
begin
  if VarToStr(EOrario.KeyValue) <> '' then
  begin
    if CmbTurno1.Text <> '' then
      if (StrToIntDef(Trim(Copy(CmbTurno1.Text,1,2)),-1) < 0) or (StrToIntDef(Trim(Copy(CmbTurno1.Text,1,2)),-1) > CmbTurno1.Items.Count - 1) then
        raise Exception.Create('Il primo turno non è disponibile nell''orario specificato!');
    if CmbTurno2.Text <> '' then
      if (StrToIntDef(Trim(Copy(CmbTurno2.Text,1,2)),-1) < 0) or (StrToIntDef(Trim(Copy(CmbTurno2.Text,1,2)),-1) > CmbTurno2.Items.Count - 1) then
        raise Exception.Create('Il secondo turno non è disponibile nell''orario specificato!');
  end;
  if (cmbTurno1.Text <> '') and (cmbTurno1.Text = cmbTurno2.Text) and (CmbTurno1EU.Text = CmbTurno2EU.Text) then
    //Non permetto i due turni uguali
    raise Exception.Create('Non si può pianificare 2 volte lo stesso turno!');
  if (cmbTurno1.Text = '') and (cmbTurno2.Text <> '') then
    //Non permetto di pianificare il secondo turno senza aver pianificato il primo
    raise Exception.Create('Non si può pianificare il secondo turno senza aver pianificato il primo!');
  if ((Trim(CmbTurno1EU.Text) <> '') and (CmbTurno1EU.Text <> 'E') and (CmbTurno1EU.Text <> 'U') or
      (Trim(CmbTurno2EU.Text) <> '') and (CmbTurno2EU.Text <> 'E') and (CmbTurno2EU.Text <> 'U')) then
    //Il tipo di turno può essere solo E od U
    raise Exception.Create('I valori ammessi sono solo E ed U!');
  //Controllo sul tipo cumulo se le assenze vengono registrate sulla tabella T040
  if ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtm1.AssenzeOperative) and
     (Assenza1 <> EAssenza1.Text) and (A058FPianifTurniDtM1.R502ProDtM.ValStrT265[EAssenza1.Text,'TIPOCUMULO'] <> 'H') and
     (EAssenza1.Text <> '') then
    raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');
  if ((A058FPianifTurniDtm1.selT082.fieldByName('MODALITA_LAVORO').AsString = 'O') or A058FPianifTurniDtm1.AssenzeOperative) and
     (Assenza2 <> EAssenza2.Text) and (A058FPianifTurniDtM1.R502ProDtM.ValStrT265[EAssenza2.Text,'TIPOCUMULO'] <> 'H') and
     (EAssenza2.Text <> '') then
    raise Exception.Create('Non è consentito specificare una causale che prevede delle regole di cumulo!');

  CmbTurno1EU.Text:=Trim(CmbTurno1EU.Text);
  CmbTurno2EU.Text:=Trim(CmbTurno2EU.Text);
  if cmbTurno1.Text <> '' then
    cmbTurno1.Text:=IntToStr(StrToInt(Trim(Copy(CmbTurno1.Text,1,2))));
  if cmbTurno2.Text <> '' then
    cmbTurno2.Text:=IntToStr(StrToInt(Trim(Copy(CmbTurno2.Text,1,2))));
  ModalResult:=mrOK;
end;

procedure TA058FModPianif.cmbTurno1Change(Sender: TObject);
var
  bTrovato:boolean;
  nFascia:integer;
  sSigla, sPuntiNominali, MyTurno:string;
begin
  sSigla:='';
  sPuntiNominali:='';
  if VarToStr(EOrario.KeyValue) <> '' then
  begin
    with A058FPianifTurniDtM1 do
    begin
      MyTurno:=(Sender as TComboBox).Text;
      MyTurno:=Trim(Copy(MyTurno,1,pos('-',MyTurno) - 1));
      //valorizzo i dati calcolati relativi al primo turno
      if MyTurno = '0' then
      begin
        sSigla:='(0)';
        sPuntiNominali:='Riposo';
      end
      else if (MyTurno <> '') then
      begin
        bTrovato:=Q021.SearchRecord('CODICE', EOrario.KeyValue, [srFromBeginning]);
        if bTrovato then
        begin
          nFascia:=1;
          while (nFascia < StrToInt(MyTurno)) and (not Q021.Eof) do
          begin
            Q021.Next;
            nFascia:=nFascia + 1;
          end;
        end;
        bTrovato:=Q021.FieldByName('CODICE').AsString=EOrario.KeyValue;
        if bTrovato then
        begin
          sSigla:='(' + Q021.FieldByName('siglaturni').AsString + ')';
          sPuntiNominali:='E' + Q021.FieldByName('entrata').AsString + ' - U' + Q021.FieldByName('uscita').AsString;
        end;
      end;
    end;
  end;
  if Sender = cmbTurno1 then
  begin
    lblSiglaT1.Caption:=sSigla;
    lblPNT1.Caption:=sPuntiNominali;
  end
  else if Sender = cmbTurno2 then
  begin
    lblSiglaT2.Caption:=sSigla;
    lblPNT2.Caption:=sPuntiNominali;
  end;
end;

procedure TA058FModPianif.EOrarioClick(Sender: TObject);
begin
  cmbTurno1Change(cmbTurno1);
  cmbTurno1Change(cmbTurno2);
end;

procedure TA058FModPianif.EOrarioExit(Sender: TObject);
var
  i:Integer;
  MyTLabel:String;
begin
  if VarToStr(EOrario.KeyValue) = '' then
    exit;
  cmbTurno1.Items.Clear;
  cmbTurno1.Items.Add('0 - Riposo');
  i:=0;
  with A058FPianifTurniDtM1.Q021 do
    if SearchRecord('CODICE',VarToStr(EOrario.KeyValue),[srFromBeginning]) then
    repeat
      inc(i);
      if Not FieldByName('SIGLATURNI').IsNull then
        MyTLabel:='(' + FieldByName('SIGLATURNI').AsString + ')'
      else
        MyTLabel:='(' + FieldByName('NUMTURNO').AsString + ')';
      cmbTurno1.Items.Add(i.ToString + ' - ' + MyTLabel);
    until not SearchRecord('CODICE',VarToStr(EOrario.KeyValue),[]);
  cmbTurno2.Items.Assign(cmbTurno1.Items);
end;

end.
