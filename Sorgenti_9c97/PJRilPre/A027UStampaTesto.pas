unit A027UStampaTesto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, A000UCostanti, A000USessione, A000UInterfaccia,
  ComCtrls, ExtCtrls, C180FunzioniGenerali, Variants, DXPRINTER;

type
  TA027FStampaTesto = class(TForm)
    DxPrinter1: TDxPrinter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    Label4: TLabel;
    edtFileTesto: TEdit;
    BtnFileTesto: TButton;
    Label5: TLabel;
    edtInizioPagina: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    BtnStampa: TBitBtn;
    BtnChiudi: TBitBtn;
    Memo2: TMemo;
    spedtTotaleRighe: TSpinEdit;
    Label1: TLabel;
    spedtRigheHeader: TSpinEdit;
    Label3: TLabel;
    spedtRigheFooter: TSpinEdit;
    Label6: TLabel;
    edtSaltoPagina: TEdit;
    procedure BtnFileTestoClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure spedtTotaleRigheChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PutParametriFunzione;
  public
    { Public declarations }
    StampaSuFile:Boolean;
    InizioPagina:String;
    RotturaChiave:String;
    FileOut,FileSemaforo:String;
    carattereFOB:Integer;
  end;

var
  A027FStampaTesto: TA027FStampaTesto;

procedure OpenA027StampaTesto;

implementation

uses A027UCarMen;

{$R *.DFM}

procedure OpenA027StampaTesto;
{Stampa della cartolina mensile}
begin
  try
    if A027FStampaTesto = nil then
      A027FStampaTesto:=TA027FStampaTesto.Create(nil);
    A027FStampaTesto.ShowModal;
  finally
    A027FStampaTesto.Hide;
  end;
end;

procedure TA027FStampaTesto.FormCreate(Sender: TObject);
begin
  StampaSuFile:=False;
end;

procedure TA027FStampaTesto.FormShow(Sender: TObject);
begin
  with A027FCarMen do
  begin
    edtInizioPagina.Text:=sParametri.sCarCon;
    spedtTotaleRighe.Text:=sParametri.sNumRighe;
    spedtRigheHeader.Text:=sParametri.sNumRigheHeader;
    spedtRigheFooter.Text:=sParametri.sNumRigheFooter;
    edtSaltoPagina.Text:=sParametri.sSaltoPagina;
    edtFileTesto.Text:=sParametri.sFileTesto;
    spedtTotaleRigheChange(nil);
  end;
end;

procedure TA027FStampaTesto.PutParametriFunzione;
begin
  with A027FCarMen do
  begin
    sParametri.sCarCon:=edtInizioPagina.Text;
    sParametri.sNumRighe:=spedtTotaleRighe.Text;
    sParametri.sNumRigheHeader:=spedtRigheHeader.Text;
    sParametri.sNumRigheFooter:=spedtRigheFooter.Text;
    sParametri.sFileTesto:=edtFileTesto.Text;
    sParametri.sSaltoPagina:=edtSaltoPagina.Text;
  end;
end;

procedure TA027FStampaTesto.BtnFileTestoClick(Sender: TObject);
begin
  Opendialog1.FileName:=edtFileTesto.Text;
  if Opendialog1.Execute then
    edtFileTesto.Text:=Opendialog1.FileName;
end;

procedure TA027FStampaTesto.BtnStampaClick(Sender: TObject);
var
  bPrimaPagina, bNuovaPagina, NuovaPaginaSuFile:boolean;
  i,nNumRiga:integer;
  F,FOut: TextFile;
  sDep: string;
  RigaDXPrint:AnsiString;
  function CarCon(S:String):String;
  var i:Integer;
  begin
    Result:='';
    with TStringList.Create do
    try
      CommaText:=s;
    finally
      for i:=0 to Count - 1 do
        Result:=Result + chr(StrToInt(Strings[i]));
    end;
  end;
  function CarMemo(S:String):String;
  var i:Integer;
  begin
    Result:='';
    with TStringList.Create do
    try
      CommaText:=s;
    finally
      for i:=0 to Count - 1 do
        Result:=Result + '<CHR ' + Strings[i] + '>';
    end;
  end;
  procedure ScriviFile(S:String);
  var c:String;
  begin
    c:='';
    if InizioPagina <> '' then
      if NuovaPaginaSuFile then
      begin
        c:=InizioPagina;
        NuovaPaginaSuFile:=False;
        if Pos('<@>',S) > 0 then
        begin
          S:=StringReplace(S,'<@>','   ',[]);
          S[3]:=Chr(CarattereFOB);
        end;
      end
      else
        c:=' ';
    Writeln(FOut,c + S);
  end;
begin
  //Verifico che il file esista...
  if not FileExists(edtFileTesto.text) then
  begin
    edtFileTesto.SetFocus;
    raise exception.Create('Impossibile trovare il file ' + edtFileTesto.text);
  end;
  if not StampaSuFile then
    Screen.Cursor:=crHourglass;
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  //Apro il file in lettura...
  AssignFile(F, edtFileTesto.Text);
  AssignFile(FOut, FileOut);
  try
  Reset(F);
  if StampaSuFile then
    Rewrite(FOut);
  bNuovaPagina:=False;
  NuovaPaginaSuFile:=False;
  bPrimaPagina:=True;
  nNumRiga:=0;
  //Aggiungo eventuali righe in fondo all'ultima pagina
  for i:=1 to spedtRigheHeader.Value do
  begin
    inc(nNumRiga);
//    Memo2.Lines.Add(inttostr(nNumRiga) + ' - PAGE HEADER');
//    Memo1.Lines.Add(inttostr(nNumRiga) + ' - PAGE HEADER');
    if not StampaSuFile then
    begin
      Memo2.Lines.Add('');
      Memo1.Lines.Add('');
    end
    else
      ScriviFile('');
  end;
  while not eof(F) do
  begin
    //Leggo una riga
    Readln(F, sDep);
    //Se trovo i caratteri di SaltoPagina ed ho già stampato qualche riga,
    //devo forzare una nuova pagina
    if Pos(edtSaltoPagina.Text, sDep) > 0 then
      if bPrimaPagina then
      begin
        bPrimaPagina:=False;
        NuovaPaginaSuFile:=True;
      end
      else
        bNuovaPagina:=True;
    //Se sono su una nuova pagina e se gestisco il numero di righe
    //inserisco le righe di intestazione
    if bNuovaPagina and (spedtTotaleRighe.Value > 0) then
    begin
      bNuovaPagina:=False;
      //Aggiungo le righe che mancano ad arrivare alla fine della pagina
      for i:=nNumRiga + 1 to spedtTotaleRighe.value do
      begin
        //nNumRiga:=nNumRiga+1;
        //Memo2.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
        //Memo1.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
        if not StampaSuFile then
        begin
          Memo2.Lines.Add('');
          Memo1.Lines.Add('');
        end
        else
          ScriviFile('');
      end;
      nNumRiga:=0;
      NuovaPaginaSuFile:=True;
      //aggiungo le righe di intestazione della pagina successiva
      for i:=1 to spedtRigheHeader.value do
      begin
        inc(nNumRiga);
        //Memo2.Lines.Add(inttostr(nNumRiga) + ' - PAGE HEADER');
        //Memo1.Lines.Add(inttostr(nNumRiga) + ' - PAGE HEADER');
        if not StampaSuFile then
        begin
          Memo2.Lines.Add('');
          Memo1.Lines.Add('');
        end
        else
          ScriviFile('');
      end;
    end;

    //Scrivo la riga nel file ed incremento il contatore delle righe
    inc(nNumRiga);
    //Memo2.Lines.Add(inttostr(nNumRiga) + ' ' + sDep);
    //Memo1.Lines.Add(inttostr(nNumRiga) + ' ' + sDep);
    if not StampaSuFile then
    begin
      Memo2.Lines.Add(sDep);
      Memo1.Lines.Add(sDep);
    end
    else
      ScriviFile(sDep);
    //Se sono alla fine di una pagina gestisco il numero di righe
    //ed inserisco le righe di fine pagina.
    if (nNumRiga = spedtTotaleRighe.Value - spedtRigheFooter.value) and (spedtTotaleRighe.Value > 0) then
    begin
      bNuovaPagina:=true;
      for i:=1 to spedtRigheFooter.value do
      begin
        inc(nNumRiga);
        //Memo2.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
        //Memo1.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
        if not StampaSuFile then
        begin
          Memo2.Lines.Add('');
          Memo1.Lines.Add('');
        end
        else
          ScriviFile('');
      end;
    end;
  end;
  //Aggiungo eventuali righe in fondo all'ultima pagina
  for i:=nNumRiga + 1 to spedtTotaleRighe.value do
  begin
    //nNumRiga:=nNumRiga + 1;
    //Memo2.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
    //Memo1.Lines.Add(inttostr(nNumRiga) + ' - PAGE FOOTER');
    if not StampaSuFile then
    begin
      Memo2.Lines.Add('');
      Memo1.Lines.Add('');
    end
    else
      ScriviFile('');
  end;
  finally
    //Chiudo il file
    CloseFile(F);
    if StampaSuFile then
      CloseFile(FOut);
  end;
  try
    R180AppendFile(FileSemaforo,'');
  except
  end;
  if not StampaSuFile then
  begin
    Screen.Cursor:=crDefault;
    //Stampo il contenuto di Memo2
    if DxPrinter1.Open then
    begin
      Memo1.Lines.Text:=CarMemo(edtInizioPagina.Text) + Memo1.Lines.Text;
      //DxPrinter1.Write(CarCon(edtInizioPagina.Text) + Memo2.Lines.Text);
      RigaDXPrint:=CarCon(edtInizioPagina.Text) + Memo2.Lines.Text;
      DxPrinter1.Write(RigaDXPrint);
      DxPrinter1.Close;
      R180MessageBox('La stampa è stata inviata con successo alla stampante selezionata.',INFORMA);
    end
    else
    begin
      R180MessageBox('Impossibile inviare la stampa alla stampante selezionata!',ERRORE);
    end;
  end;
end;

procedure TA027FStampaTesto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
end;

procedure TA027FStampaTesto.spedtTotaleRigheChange(Sender: TObject);
begin
  if spedtTotaleRighe.Value=0 then
  begin
    spedtRigheHeader.Value:=0;
    Label1.Enabled:=False;
    spedtRigheHeader.Enabled:=False;
    spedtRigheFooter.Value:=0;
    Label3.Enabled:=False;
    spedtRigheFooter.Enabled:=False;
  end
  else
  begin
    Label1.Enabled:=True;
    spedtRigheHeader.Enabled:=True;
    Label3.Enabled:=True;
    spedtRigheFooter.Enabled:=True;
  end;
end;

end.
