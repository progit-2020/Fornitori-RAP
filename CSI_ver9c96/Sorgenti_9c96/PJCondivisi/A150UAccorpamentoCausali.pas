unit A150UAccorpamentoCausali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ExtCtrls, ActnList, ImgList, DB, Menus, ComCtrls,
  ToolWin, Oracle, OracleData, A000UCostanti, A000USessione, A000UInterfaccia, DBCtrls,
  StdCtrls, Mask, Grids, DBGrids;

type
  TA150FAccorpamentoCausali = class(TR001FGestTab)
    pnlDatiGenerali: TPanel;
    lblCodCodiciAccorpCausali: TLabel;
    lblDescrizione: TLabel;
    lblCodTipoAccorpCausali: TLabel;
    dtxtD_CodTipoAccorpCausali: TDBText;
    dedtCodCodiciAccorpCausali: TDBEdit;
    dedtDescrizione: TDBEdit;
    dbcbxCodTipoAccorpCausali: TDBLookupComboBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dgrdAccorpamentoVoci: TDBGrid;
    PopupMenu2: TPopupMenu;
    Accedi1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A150FAccorpamentoCausali: TA150FAccorpamentoCausali;

  procedure OpenA150AccorpamentoCausali(Cod,Cod1:String);

implementation

uses A150UAccorpamentoCausaliDtM, A150UTipoAccorpamentoCausali,
  A150UCodiciAccorpamentoCausali;

{$R *.dfm}

procedure OpenA150AccorpamentoCausali(Cod,Cod1:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA150AccorpamentoCausali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA150FAccorpamentoCausali, A150FAccorpamentoCausali);
  Application.CreateForm(TA150FAccorpamentoCausaliDtM, A150FAccorpamentoCausaliDtM);
  if Trim(Cod1) = '' then
    A150FAccorpamentoCausaliDtM.selT256.SearchRecord('COD_TIPOACCORPCAUSALI',Cod,[srFromBeginning])
  else
    A150FAccorpamentoCausaliDtM.selT256.SearchRecord('COD_TIPOACCORPCAUSALI; COD_CODICIACCORPCAUSALI',VarArrayOf([Cod, Cod1]),[srFromBeginning]);
  try
    A150FAccorpamentoCausali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A150FAccorpamentoCausali.Free;
    A150FAccorpamentoCausaliDtM.Free;
  end;
end;
procedure TA150FAccorpamentoCausali.Accedi1Click(Sender: TObject);
begin
  inherited;
  OpenA150FCodiciAccorpamentoCausali(A150FAccorpamentoCausaliDtM.selT256.FieldByName('COD_TIPOACCORPCAUSALI').AsString,
                                     A150FAccorpamentoCausaliDtM.selT256.FieldByName('D_TIPOACCORPCAUSALI').AsString,
                                     A150FAccorpamentoCausaliDtM.selT256.FieldByName('COD_CODICIACCORPCAUSALI').AsString,
                                     A150FAccorpamentoCausaliDtM.selT256.FieldByName('DESCRIZIONE').AsString,
                                     A150FAccorpamentoCausaliDtM.A150MW.Q257.FieldByName('COD_CAUSALE').AsString);
  A150FAccorpamentoCausaliDtM.A150MW.Q257.Refresh;;
end;

procedure TA150FAccorpamentoCausali.FormShow(Sender: TObject);
begin
  inherited;
  dgrdAccorpamentoVoci.DataSource:=A150FAccorpamentoCausaliDtM.A150MW.dsrQ257;
  DButton.DataSet:=A150FAccorpamentoCausaliDtM.selT256;
end;

procedure TA150FAccorpamentoCausali.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA150TipoAccorpamentoCausali(dbcbxCodTipoAccorpCausali.Text);
  A150FAccorpamentoCausaliDtm.selT255.Close;
  A150FAccorpamentoCausaliDtm.selT255.Open;
end;

end.
