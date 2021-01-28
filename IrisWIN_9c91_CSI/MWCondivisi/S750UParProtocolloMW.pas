unit S750UParProtocolloMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Db, Oracle, A000UInterfaccia,
  Dialogs, Variants, C180FunzioniGenerali, USelI010;

type
  TDati = record
    Ord:Integer;
    Tipo,Desc,Dato:String;
  end;

  TS750FParProtocolloMW = class(TR005FDataModuleMW)
    selTipoXML: TOracleDataSet;
    selTipoXMLCODICE: TStringField;
    selTipoXMLDESCRIZIONE: TStringField;
    dTipoXML: TDataSource;
    insSG751: TOracleQuery;
    updSG751: TOracleQuery;
    delSG751: TOracleQuery;
    D010: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    D751: TDataSource;
    SG750: TOracleDataSet;
    SG751: TOracleDataSet;
    selI010:TselI010;
    procedure BeforePostNoStorico;
    procedure AfterPost;
    function  formatDato(DatoOld: String; S: String):String;
    procedure SG750CalcFields(DataSet: TDataSet);
    procedure SG750AfterEdit(DataSet: TDataSet);
    procedure SG750AfterInsert(DataSet: TDataSet);
  end;

const
  DatiTipoA:array [1..26] of TDati = (
    (Ord: 1;  Tipo:'USER.CODE';                         Desc:'user.code';                         Dato:'VALUTA-WS'),
    (Ord: 2;  Tipo:'USER.PASSWORD';                     Desc:'user.password';                     Dato:'**********'),
    (Ord: 3;  Tipo:'OPERATINGOFFICECODE';               Desc:'operatingOfficeCode';               Dato:'VALUTA-UFF'),
    (Ord: 4;  Tipo:'OFFICECODE';                        Desc:'officeCode';                        Dato:'14.00.00'),
    (Ord: 5;  Tipo:'REGISTERCODE';                      Desc:'registerCode';                      Dato:'AOO'),
    (Ord: 6;  Tipo:'DIRECTION';                         Desc:'direction';                         Dato:'A'),
    (Ord: 7;  Tipo:'SEQUENCECODE';                      Desc:'sequenceCode';                      Dato:'BASE'),
    (Ord: 8;  Tipo:'SUBJECTDOCUMENT';                   Desc:'subjectDocument';                   Dato:'Trasmissione scheda di <#>TIPO<#> di <#>COGNOME<#> <#>NOME<#>'),
                                                                                           //Categorie:'Attribuzione del salario di risultato - Scheda di <#>TIPO<#> di <#>COGNOME<#> <#>NOME<#>'
    (Ord: 9;  Tipo:'RECEPTIONSENDINGDATE';              Desc:'receptionSendingDate';              Dato:'NOW'),
    (Ord:10;  Tipo:'DOCUMENTDETAILS.DATE';              Desc:'documentDetails.date';              Dato:'NOW'),
    (Ord:11;  Tipo:'DOCUMENTDETAILS.DOCUMENTTYPECODE';  Desc:'documentDetails.documentTypeCode';  Dato:'MOD'),
    (Ord:12;  Tipo:'SENDERLIST[0].CODE';                Desc:'senderList.code (1°)';              Dato:'D<#>MATRICOLA<#>'),
    //02/07/2013 (Ord:13;  Tipo:'SENDERLIST[0].TYPECODE';            Desc:'senderList.typeCode (1°)';          Dato:'MITT'),
    //08/11/2013 (Ord:13;  Tipo:'SENDERLIST[0].TYPECODE';            Desc:'senderList.type_ (1°)';             Dato:'MITT'),//02/07/2013
    (Ord:13;  Tipo:'SENDERLIST[0].TYPECODE';            Desc:'senderList.typeCode (1°)';          Dato:'MITT'),//08/11/2013
    (Ord:14;  Tipo:'SENDERLIST[0].REFERENCENUMBER';     Desc:'senderList.referenceNumber (1°)';   Dato:''),
    (Ord:15;  Tipo:'SENDERLIST[1].CODE';                Desc:'senderList.code (2°)';              Dato:'<#>T430DIR_FATTO_PROT<#>'),
    //02/07/2013 (Ord:16;  Tipo:'SENDERLIST[1].TYPECODE';            Desc:'senderList.typeCode (2°)';          Dato:'MITT'),
    //08/11/2013 (Ord:16;  Tipo:'SENDERLIST[1].TYPECODE';            Desc:'senderList.type_ (2°)';             Dato:'MITT'),//02/07/2013
    (Ord:16;  Tipo:'SENDERLIST[1].TYPECODE';            Desc:'senderList.typeCode (2°)';          Dato:'MITT'),//08/11/2013
    (Ord:17;  Tipo:'SENDERLIST[1].REFERENCENUMBER';     Desc:'senderList.referenceNumber (2°)';   Dato:''),
    (Ord:18;  Tipo:'RECIPIENTLIST.CODE';                Desc:'recipientList.code';                Dato:'14.00.17'),
                                                                                           //Categorie:'14.02.12'
    (Ord:19;  Tipo:'RECIPIENTLIST.REFERENCEDATE';       Desc:'recipientList.referenceDate';       Dato:'NOW'),
    (Ord:20;  Tipo:'RECIPIENTLIST.TRANSMISSIONMODE';    Desc:'recipientList.transmissionMode';    Dato:'LETT'),
    //02/07/2013 (Ord:21;  Tipo:'RECIPIENTLIST.TYPECODE';            Desc:'recipientList.typeCode';            Dato:'DEST'),
    //08/11/2013 (Ord:21;  Tipo:'RECIPIENTLIST.TYPECODE';            Desc:'recipientList.type_';               Dato:'DEST'),//02/07/2013
    (Ord:21;  Tipo:'RECIPIENTLIST.TYPECODE';            Desc:'recipientList.typeCode';            Dato:'DEST'),//08/11/2013
    (Ord:22;  Tipo:'OFFICELIST.CODE';                   Desc:'officeList.code';                   Dato:'14.00.17'),
                                                                                           //Categorie:'14.02.12'
    (Ord:23;  Tipo:'DOCUMENTLIST.PRIMARY';              Desc:'documentList.primary';              Dato:'TRUE'),
    (Ord:24;  Tipo:'FILINGLIST.CODE';                   Desc:'filingList.code';                   Dato:'   5   6       8   3'),
    (Ord:25;  Tipo:'MNEMONICLIST.CODE';                 Desc:'mnemonicList.code';                 Dato:'CVALU'),
                                                                                           //Categorie:'OBI'
    (Ord:26;  Tipo:'MNEMONICLIST.TYPECODE';             Desc:'mnemonicList.typeCode';             Dato:'GED'));

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS750FParProtocolloMW.BeforePostNoStorico;
begin
  if (SG750.FieldByName('TIPOXML').AsString = 'A') and
     (Trim(SG750.FieldByName('WS_URL').AsString) = '') then
    SG750.FieldByName('WS_URL').AsString:='http://10.1.0.37/ProtocolloInsielWS/wsdl_protocollo/protocolloService';
end;

procedure TS750FParProtocolloMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO,NOME_CAMPO');
  selTipoXML.Open;
end;

procedure TS750FParProtocolloMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

procedure TS750FParProtocolloMW.AfterPost;
var i:Integer;
    Trovato:Boolean;
begin
  if SG750.FieldByName('TIPOXML').AsString = 'A' then
  begin
    SG751.Last;
    while not SG751.Bof do
    begin
      Trovato:=False;
      for i:=1 to High(DatiTipoA) do
        if DatiTipoA[i].Tipo = SG751.FieldByName('TIPO').AsString then
        begin
          Trovato:=True;
          Break;
        end;
      if Trovato then
      begin
        updSG751.SetVariable('ORDINE',DatiTipoA[i].Ord);
        updSG751.SetVariable('CODICE',SG751.FieldByName('CODICE').AsString);
        updSG751.SetVariable('TIPO',SG751.FieldByName('CODICE').AsString);
        updSG751.Execute;
      end
      else
      begin
        delSG751.SetVariable('CODICE',SG751.FieldByName('CODICE').AsString);
        delSG751.SetVariable('TIPO',SG751.FieldByName('CODICE').AsString);
        delSG751.Execute;
      end;
      SG751.Prior;
    end;
    if Trim(SG750.FieldByName('CODICE').AsString) <> '' then
      for i:=1 to High(DatiTipoA) do
        if VarToStr(SG751.Lookup('TIPO',DatiTipoA[i].Tipo,'TIPO')) = '' then
        begin
          insSG751.SetVariable('CODICE',SG750.FieldByName('CODICE').AsString);
          insSG751.SetVariable('ORDINE',DatiTipoA[i].Ord);
          insSG751.SetVariable('TIPO',DatiTipoA[i].Tipo);
          insSG751.SetVariable('DESCRIZIONE',DatiTipoA[i].Desc);
          insSG751.SetVariable('DATO',DatiTipoA[i].Dato);
          insSG751.Execute;
        end;
  end;
  SessioneOracle.Commit;
end;

function TS750FParProtocolloMW.formatDato(DatoOld: String; S: String):String;
var S1,S2: String;
begin
  begin
    if Pos('<#>',DatoOld) > 0 then
    begin
      S1:=Copy(DatoOld,1,Pos('<#>',DatoOld) - 1);
      DatoOld:=Copy(DatoOld,Pos('<#>',DatoOld) + 3);
      if Pos('<#>',DatoOld) > 0 then
        S2:=Copy(DatoOld,Pos('<#>',DatoOld) + 3)
      else
        S2:=DatoOld;
      S1:=StringReplace(S1,'<#>','',[rfReplaceAll]);
      S2:=StringReplace(S2,'<#>','',[rfReplaceAll]);
    end
    else
    begin
      S1:=DatoOld;
      S2:='';
    end;
  end;
  Result:=S1 + '<#>' + S + '<#>' + S2;
end;

procedure TS750FParProtocolloMW.SG750AfterEdit(DataSet: TDataSet);
begin
  SG750.FieldByName('CODICE').ReadOnly:=True;
  SG750.FieldByName('TIPOXML').ReadOnly:=True;
end;

procedure TS750FParProtocolloMW.SG750AfterInsert(DataSet: TDataSet);
begin
  SG750.FieldByName('CODICE').ReadOnly:=False;
  SG750.FieldByName('TIPOXML').ReadOnly:=False;
end;

procedure TS750FParProtocolloMW.SG750CalcFields(DataSet: TDataSet);
begin
  SG750.FieldByName('D_TIPOXML').AsString:=VarToStr(selTipoXML.Lookup('CODICE',SG750.FieldByName('TIPOXML').AsString,'DESCRIZIONE'));
end;

end.
