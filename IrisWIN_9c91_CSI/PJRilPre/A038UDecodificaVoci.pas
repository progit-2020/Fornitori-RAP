unit A038UDecodificaVoci;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Variants, C700USelezioneAnagrafe, Oracle, OracleData;

type
  TA038FDecodificaVoci = class(TForm)
    grdVoci: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    cmbMeseCassaDa: TComboBox;
    Label2: TLabel;
    cmbMeseCassaA: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A038FDecodificaVoci: TA038FDecodificaVoci;

implementation

uses A038UVociVariabiliDtM1;

{$R *.DFM}

procedure TA038FDecodificaVoci.FormShow(Sender: TObject);
var i:Integer;
begin
  grdVoci.Cells[0,0]:='Codice attuale';
  grdVoci.Cells[1,0]:='Nuovo codice';
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.VociPaghe do
  begin
    Open;
    i:=1;
    while not Eof do
    begin
      grdVoci.RowCount:=i + 1;
      grdVoci.Cells[0,i]:=FieldByName('VocePaghe').AsString;
      grdVoci.Cells[1,i]:='';
      inc(i);
      Next;
    end;
    Close;
  end;
  with A038FVociVariabiliDtM1.A038FVociVariabiliMW.selT195Cassa do
    begin
    Open;
    Last;
    while not Bof do
      begin
      cmbMeseCassaDa.Items.Add(FieldByName('Data_Cassa').AsString);
      cmbMeseCassaA.Items.Add(FieldByName('Data_Cassa').AsString);
      Prior;
      end;
    Close;
    end;
  if cmbMeseCassaDa.Items.Count > 0 then
  begin
    cmbMeseCassaDa.ItemIndex:=0;
    cmbMeseCassaA.ItemIndex:=cmbMeseCassaA.Items.Count - 1;
  end;
end;

procedure TA038FDecodificaVoci.BitBtn1Click(Sender: TObject);
var S,S1:String;
    i:Integer;
begin
  if MessageDlg('ATTENZIONE!' + #13 +
                'Verranno decodificate le voci paghe specificate per i dipendenti selezionati!' + #13 +
                'Eseguire la conversione?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  S:='';
  S1:='';
  for i:=1 to grdVoci.RowCount - 1 do
    if Trim(grdVoci.Cells[1,i]) <> '' then
    begin
      if S <> '' then
      begin
        S:=S + ',';
        S1:=S1 + ',';
      end;
      S:=S + '''' + grdVoci.Cells[0,i] + '''';
      S1:=S1 + Format('''%s'',''%s''',[grdVoci.Cells[0,i],grdVoci.Cells[1,i]]);
    end;
  if S <> '' then
    with A038FVociVariabiliDtM1.scrDecodeVoci do
    begin
      SetVariable('DAL',StrToDate(cmbMeseCassaDa.Text));
      SetVariable('AL',StrToDate(cmbMeseCassaA.Text));
      SetVariable('VOCIPAGHE',S);
      SetVariable('DECODEVOCI',S1);
      if VariableIndex('DataLavoro') >= 0 then
        DeleteVariable('DataLavoro');
      if VariableIndex('C700DataDal') >= 0 then
        DeleteVariable('C700DataDal');
      C700MergeSelAnagrafe(A038FVociVariabiliDtM1.scrDecodeVoci,False);
      C700MergeSettaPeriodo(A038FVociVariabiliDtM1.scrDecodeVoci,StrToDate(cmbMeseCassaDa.Text),StrToDate(cmbMeseCassaA.Text));
      Screen.Cursor:=crHourGlass;
      try
        Execute;
        ShowMessage('Elaborazione terminata!');
      finally
        Screen.Cursor:=crDefault;
      end;
    end;
end;

end.
