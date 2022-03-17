unit S750UParProtocollo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask, StrUtils,
  DBCtrls, Grids, DBGrids, ActnList, ImgList, ToolWin, A000UCostanti,
  A000USessione,A000UInterfaccia, Variants, System.Actions;

type
  TS750FParProtocollo = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    gpbDati: TGroupBox;
    OpenDialog1: TOpenDialog;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    SaveDialog1: TSaveDialog;
    dgrdDati: TDBGrid;
    dcmbTipoXML: TDBLookupComboBox;
    lblTipoXML: TLabel;
    lblWsUrl: TLabel;
    dedtWsUrl: TDBEdit;
    dlblTipoXML: TDBText;
    procedure dcmbTipoXMLExit(Sender: TObject);
    procedure dgrdDatiEditButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  S750FParProtocollo: TS750FParProtocollo;

procedure OpenS750FParProtocollo(Cod:String);

implementation

uses S750UParProtocolloDtM, A008UListaGriglia;

{$R *.DFM}

procedure OpenS750FParProtocollo(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  case A000GetInibizioni('Funzione','OpenS750FParProtocollo') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S750FParProtocollo:=TS750FParProtocollo.Create(nil);
  with S750FParProtocollo do
  try
    S750FParProtocolloDtM:=TS750FParProtocolloDtM.Create(nil);
    S750FParProtocolloDtM.SG750.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S750FParProtocolloDtM.Free;
    Release;
  end;
end;

procedure TS750FParProtocollo.dcmbTipoXMLExit(Sender: TObject);
begin
  inherited;
  with S750FParProtocolloDtM do
    if (SG750.State in [dsInsert])
    and (SG750.FieldByName('TIPOXML').AsString = 'A')
    and (Trim(SG750.FieldByName('WS_URL').AsString) = '') then
      SG750.FieldByName('WS_URL').AsString:='http://10.1.0.37/ProtocolloInsielWS/wsdl_protocollo/protocolloService';
end;

procedure TS750FParProtocollo.dgrdDatiEditButtonClick(Sender: TObject);
var S1,S2,S,DatoOld:String;
begin
  inherited;
  if dgrdDati.SelectedField.FieldName = 'DATO' then
  //Richiesta password tramite gestione sicurezza
  begin
    if not (DButton.State in [dsEdit,dsInsert]) then
      exit;
    with S750FParProtocolloDtM do
    begin
      if not (D751.State in [dsEdit,dsInsert]) then
        D751.DataSet.Edit;
      if (UpperCase(SG751.FieldByName('TIPO').AsString) = 'SENDERLIST[0].CODE')
      or (UpperCase(SG751.FieldByName('TIPO').AsString) = 'SENDERLIST[1].CODE') then
      begin
        A008FListaGriglia:=TA008FListaGriglia.Create(nil);
        A008FListaGriglia.Lista.Items.BeginUpdate;
        A008FListaGriglia.Lista.Items.Clear;
        with S750FParProtocolloMW.selI010 do
        begin
          First;
          while not Eof do
          begin
            A008FListaGriglia.Lista.Items.Add(FieldByName('NOME_LOGICO').AsString);
            Next;
          end;
        end;
        A008FListaGriglia.Lista.ExtendedSelect:=A008FListaGriglia.Lista.MultiSelect;
        A008FListaGriglia.Lista.Items.EndUpdate;
        with A008FListaGriglia do
          try
            Caption:=SG751.FieldByName('DESCRIZIONE').AsString;
            if ShowModal = mrOk then
            begin
              S:='';
              if Lista.ItemIndex >= 0 then
                S:=VarToStr(S750FParProtocolloMW.selI010.Lookup('NOME_LOGICO',Lista.Items[Lista.ItemIndex],'NOME_CAMPO'));
              if S <> '' then
              begin
                DatoOld:=SG751.FieldByName('DATO').AsString;
                SG751.FieldByName('DATO').AsString:=S750FParProtocolloMW.formatDato(DatoOld,S);
              end;
            end;
          finally
            Release;
          end;
      end;
    end;
  end;
end;

end.
