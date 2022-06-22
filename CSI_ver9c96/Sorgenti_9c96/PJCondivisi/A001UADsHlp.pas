(************************************************************
Author: Deepak Shenoy
        shenoy@agnisoft.com
Copyright (C) 2000 Agni Software Pvt. Ltd.
All Rights Reserved.
http://www.agnisoft.com

Description:
Helper class for ADSI functions
********************************************************)
unit A001UADsHlp;

interface
uses Windows, ActiveX, Classes, OleServer, A000UCostanti, A001UActiveDs_TLB, SysUTILS, variants;

const
// constant returned by IDirectorySearch.GetNextRow - adsErr.h
S_ADS_NOMORE_ROWS   = $00005012;
MAX_ADS_ENUM_COUNT = 100;

type
  TADsEnumCallBack = procedure ( disp : IADs ) of object;

(*
function GetObject( Path : string ) : IDispatch;
procedure ADsEnumerateObjects(const Path : string; Func : TADsEnumCallback); overload;
procedure ADsEnumerateObjects(Container : IADsContainer; Func : TADsEnumCallback); overload;
procedure ADsEnumerateMembers(Members : IADsMembers; Func : TADsEnumCallback);


function ADsGetObject(lpszPathName:WideString; const riid:TGUID;
                      out ppObject):HRESULT; safecall;

function ADsBuildEnumerator(const pADsContainer:IADsContainer;
                            out ppEnumVariant:IEnumVARIANT):HRESULT; safecall;

function ADsFreeEnumerator(pEnumVariant:IEnumVARIANT):HRESULT; safecall;
function ADsEnumerateNext(pEnumVariant:IEnumVARIANT;
                          cElements:ULONG;
                          var pvar:OleVARIANT;
                          var pcElementsFetched:ULONG):HRESULT; safecall;

function ADsBuildVarArrayStr(lppPathNames:PWideChar;
                             dwPathNames:DWORD;
                             var pVar:VARIANT):HRESULT; safecall;

function ADsBuildVarArrayInt(lpdwObjectTypes:LPDWORD;
                             dwObjectTypes:DWORD;
                             var pVar:VARIANT):HRESULT; safecall;
*)

function ADsOpenObject(lpszPathName:WideString;
                       lpszUserName:WideString;
                       lpszPassword:WideString;
                       dwReserved:DWORD;
                       const riid:TGUID;
                       out ppObject):HRESULT; safecall;

function ADsGetUserInfo(const PDomain: string; const PUserAccountName: string; out RADUserInfo: TActiveDirectoryUserInfo): TResCtrl;
(*
function ADsGetLastError(var pError:DWORD;
                         lpErrorBuf:PWideChar;
                         dwErrorBufLen:DWORD;
                         lpNameBuf:PWideChar;
                         dwNameBufLen:DWORD):HRESULT; stdcall;

procedure ADsSetLastError(dwErr:DWORD;pszErro,pszProvider:LPWSTR); stdcall;

procedure AllocADsMem(cb:DWORD);stdcall;

function FreeADsMem(pMem:Pointer):BOOL;stdcall;

function ReallocADsMem(pOldMem:Pointer;cbOld,cbNew:DWORD):Pointer;stdcall;

function AllocADsStr(pStr:LPWSTR):LPWSTR;stdcall;

function FreeADsStr(pStr:LPWSTR):BOOL;stdcall;

function ReallocADsStr(ppStr:LPWSTR;pStr:LPWSTR):BOOL;stdcall;

function ADsEncodeBinaryData (pbSrcData:PBYTE;dwSrcLen:DWORD;
   ppszDestData:LPWSTR):HRESULT;stdcall;


function PropVariantToAdsType(pVariant:VARIANT;
    dwNumVariant:DWORD;
    ppAdsValues:Pointer;
    pdwNumValues:PDWORD
    ):HRESULT;stdcall;

function AdsTypeToPropVariant(
    pAdsValues:Pointer;
    dwNumValues:DWORD;
    pVariant:VARIANT
    ):HRESULT;stdcall;

procedure AdsFreeAdsValues(pAdsValues:Pointer;
                           dwNumValues:DWORD);stdcall;
*)

implementation
const ADSI = 'activeds.dll';
const ADSLDPC = 'adsldpc.dll';

(*
function GetObject( Path : string ) : IDispatch;
begin
  ADsGetObject(Path, IDispatch, Result);
end;

procedure ADsEnumerateObjects(Container : IADsContainer; Func : TADsEnumCallback);
var
    e : IEnumVARIANT;
    varArr : OleVariant;
    lNumElements : ULong;
    obj : IADs;
    hr : integer;
begin
  hr := ADsBuildEnumerator(Container,e);
  while(Succeeded(Hr)) do
  begin
    hr := ADsEnumerateNext(e,1,
                    varArr ,lNumElements);

    if (lNumElements=0) then
      break;

    IDispatch(varArr).QueryInterface(IADs, obj);
    if obj<>nil then
    begin
      Func(obj);
    end;
    varArr := NULL;
 end;
 // do not call ADsFreeEnumerator(e); since e will be released by Delphi
end;

procedure ADsEnumerateObjects(const Path : string; Func : TADsEnumCallback);
var
    x : IADsContainer;
begin
 try
   ADsGetObject( Path, IADsContainer, x);
 except
   raise Exception.Create('IADsContainer not supported');
 end;
 ADsEnumerateObjects(x, Func);
end;

procedure ADsEnumerateMembers(Members : IADsMembers; Func : TADsEnumCallback);
var
    e : IEnumVARIANT;
    varArr : OleVariant;
    lNumElements : ULong;
    obj : IADs;
    hr : integer;
begin
  hr := S_OK;
  e := Members._NewEnum as IEnumVariant;
  while (Succeeded(hr)) do
  begin
    hr := ADsEnumerateNext(e,1,
                    varArr ,lNumElements);

    if (lNumElements=0) then
      break;

    IDispatch(varArr).QueryInterface(IADs, obj);
    if obj<>nil then
    begin
      Func(obj);
    end;
    varArr := NULL;
  end;
end;
*)

(*function ADsGetObject;       external ADSI;
function ADsBuildEnumerator; external ADSI;
function ADsEnumerateNext;   external ADSI;
function ADsFreeEnumerator;  external ADSI;
function ADsBuildVarArrayStr;external ADSI;
function ADsBuildVarArrayInt;external ADSI;*)

//function ADsOpenObject      ;external ADSI;
function ADsOpenObject(lpszPathName:WideString;
                       lpszUserName:WideString;
                       lpszPassword:WideString;
                       dwReserved:DWORD;
                       const riid:TGUID;
                       out ppObject):HRESULT;
{Incapsulamento della chiamata alla dll:
 tutte le altre funzioni sono state remmate in quanto al momento sono inutili}
var
  //wDomainName: WideString;
  //Controller: PWideChar;
  //NetGetDCName: function (servername: LPCWSTR; domainname: LPCWSTR; bufptr: Pointer):DWORD; stdcall;
  //NetApiBufferFree: function(Buffer: Pointer):DWORD; stdcall;
  R:HRESULT;
  HBar:Thandle;
  _ADsOpenObject: function(_lpszPathName:WideString;
                         _lpszUserName:WideString;
                         _lpszPassword:WideString;
                         _dwReserved:DWORD;
                         const _riid:TGUID;
                         out _ppObject):HRESULT; stdcall;
begin
  HBar:=LoadLibrary(ADSI);
  if HBar >= 32 then { success }
  begin
    _ADsOpenObject:=GetProcAddress(HBar, 'ADsOpenObject');
    R:=_ADsOpenObject(lpszPathName,lpszUserName,lpszPassword,dwReserved,IADs,ppObject);
    Result:=R;
    FreeLibrary(HBar);
  end;
end;
function ADsGetUserInfo(const PDomain: string; const PUserAccountName: string; out RADUserInfo: TActiveDirectoryUserInfo): TResCtrl;
type
  TADsOpenObject   = function (lpszPathName: PWideChar; lpszUserName: PWideChar;
    lpszPassword: PWideChar; dwReserved: DWORD; const riid: TGUID;
    out pObject): HRESULT; stdcall;
  TADsGetObject    = function(PathName: PWideChar; const IID: TGUID; out Void):
    HRESULT; stdcall;
var
  LPathName: string;
  LAdsLibHandle: THandle;
  _LADsOpenObject: TADsOpenObject;
  _LADsGetObject: TADsGetObject;
  // strutture per cercare l'account utente attraverso lo username
  LDirSearch: IDirectorySearch;
  LSearchPrefs: array[0..1] of ADS_SEARCHPREF_INFO;
  LColumns: array[0..0] of PWideChar;
  LSearchRes: NativeUInt;
  LStatus: HRESULT;
  LColumnRes: ads_search_column;
  // numero di utenti trovati
  LRecordCount: Integer;
  i: Integer;
  LUser: IADSUser;
  LFilter: string;
const
  ACTIVEDSDLL = 'activeds.dll';

  // ADSI success codes
  S_ADS_ERRORSOCCURRED = $00005011;
  S_ADS_NOMORE_ROWS    = $00005012;
  S_ADS_NOMORE_COLUMNS = $00005013;

  // ADSI error codes
  E_ADS_BAD_PATHNAME            = $80005000;
  E_ADS_INVALID_DOMAIN_OBJECT   = $80005001;
  E_ADS_INVALID_USER_OBJECT     = $80005002;
  E_ADS_INVALID_COMPUTER_OBJECT = $80005003;
  E_ADS_UNKNOWN_OBJECT          = $80005004;
  E_ADS_PROPERTY_NOT_SET        = $80005005;
  E_ADS_PROPERTY_NOT_SUPPORTED  = $80005006;
  E_ADS_PROPERTY_INVALID        = $80005007;
  E_ADS_BAD_PARAMETER           = $80005008;
  E_ADS_OBJECT_UNBOUND          = $80005009;
  E_ADS_PROPERTY_NOT_MODIFIED   = $8000500A;
  E_ADS_PROPERTY_MODIFIED       = $8000500B;
  E_ADS_CANT_CONVERT_DATATYPE   = $8000500C;
  E_ADS_PROPERTY_NOT_FOUND      = $8000500D;
  E_ADS_OBJECT_EXISTS           = $8000500E;
  E_ADS_SCHEMA_VIOLATION        = $8000500F;
  E_ADS_COLUMN_NOT_SET          = $80005010;
  E_ADS_INVALID_FILTER          = $80005014;
begin
  Result.Clear;

  // se il dominio non è specificato esce subito
  if (PDomain = '') then
  begin
    Result.Messaggio:='il dominio non è stato specificato!';
    Exit;
  end;

  // se il nome dell'account non è specificato esce subito
  if (PUserAccountName = '') then
  begin
    Result.Messaggio:='il nome dell''account utente non è stato specificato!';
    Exit;
  end;

  // path per la ricerca nel dominio
  LPathName:=Format('LDAP://%s',[PDomain]);

  // prepara i puntatori ai metodi esposti dalla dll
  LAdsLibHandle:=LoadLibrary(ACTIVEDSDLL);
  try
    if LAdsLibHandle <> 0 then
    begin
      @_LADsOpenObject:=GetProcAddress(LAdsLibHandle, 'ADsOpenObject');
      @_LADsGetObject:=GetProcAddress(LAdsLibHandle, 'ADsGetObject');
    end
    else
    begin
      Result.Messaggio:=Format('errore durante il caricamento dei metodi della libreria %s:'#13#10'%s'#13#10'%s',[ACTIVEDSDLL,'ADsOpenObject','ADsGetObject']);
      Exit;
    end;

    try
      // prepara array di proprietà da leggere
      LColumns[0]:=StringToOleStr('AdsPath');
  //    LColumns[1]:=StringToOleStr('displayName');
  //    LColumns[2]:=StringToOleStr('mail');
  //    LColumns[3]:=StringToOleStr('sAMAccountName');
  //    LColumns[4]:=StringToOleStr('userPrincipalName');

      // prepara l'oggetto "DirectorySearch"
      _LADsGetObject(PWideChar(WideString(LPathName)), IDirectorySearch, LDirSearch);

      // verifica che l'oggetto per la ricerca esista
      if LDirSearch = nil then
      begin
        Result.Messaggio:=Format('ricerca dell''utente in Active Directory impossibile: verificare il dominio e i permessi di accesso',[]);
        Exit;
      end;

      try
        // imposta le preferenze di ricerca
        LSearchPrefs[0].dwSearchPref:=ADS_SEARCHPREF_SEARCH_SCOPE;
        LSearchPrefs[0].vValue.dwType:=ADSTYPE_INTEGER;
        LSearchPrefs[0].vValue.Integer:=ADS_SCOPE_SUBTREE;
        LDirSearch.SetSearchPreference(@LSearchPrefs[0], 1);

        // effettua la ricerca utilizzando il SAM account name
        //'(&(CN=*)(|(sAMAccountName=%0:s))'
        LFilter:= Format('(&(sAMAccountName=%s))',[PUserAccountName]);
        LDirSearch.ExecuteSearch(PWideChar(WideString(LFilter)), nil, $FFFFFFFF, LSearchRes);

        // estrae i record corrispondenti
        LRecordCount:=0;

        LStatus:=LDirSearch.GetNextRow(LSearchRes);
        if (LStatus <> S_ADS_NOMORE_ROWS) then
        begin
          // trovato (almeno) un record
          Inc(LRecordCount);

          // estrae le informazioni per la riga (appartenenti alle colonne definite)
          for i:=Low(LColumns) to High(LColumns) do
          begin
            LStatus:=LDirSearch.GetColumn(LSearchRes, LColumns[i], LColumnRes);
            if Succeeded(LStatus) then
            begin
              // utilizza il valore di AdsPath per estrarre le info dell'utente
              if SameText(LColumnRes.pszAttrName,'AdsPath') then
              begin
                // estrae le informazioni dell'utente
                LStatus:=_LADsGetObject(LColumnRes.pADsValues.CaseExactString, IADsUser, LUser);
                if Succeeded(LStatus) then
                begin
                  RADUserInfo.User:=LUser.Name;
                  RADUserInfo.FullName:=LUser.FullName;
                  RADUserInfo.Email:=LUser.EmailAddress;
                end;
              end;

              // distrugge il result
              LDirSearch.FreeColumn(LColumnRes);
            end;
          end;

          // l'account trovato deve essere univoco
          // se LRecordCount risulta <> 1 --> errore
          LStatus:=LDirSearch.GetNextRow(LSearchRes);
          if (LStatus <> S_ADS_NOMORE_ROWS) then
            Inc(LRecordCount);
        end;

        // chiude la ricerca
        //LDirSearch.CloseSearchHandle(LSearchRes); // NO! Access violation!

        // verifica il numero di record trovati
        case LRecordCount of
          0: Result.Messaggio:=Format('nessun account presente per l''utente "%s" in Active Directory',[PUserAccountName]);
          1: Result.Ok:=True;
        else
          Result.Messaggio:=Format('sono stati trovati più account per l''utente "%s" in Active Directory',[PUserAccountName]);
        end;
      finally
        LDirSearch:=nil;
      end;
    except
      on E: Exception do
      begin
        // errore di esecuzione
        Result.Messaggio:=Format('lettura dei dati dell''account "%s" fallita: %s (%s)',
                                 [PUserAccountName,E.Message,E.ClassName]);
      end;
    end;
  finally
    FreeLibrary(LAdsLibHandle);
  end;
end;


(*function ADsGetLastError    ;external ADSLDPC name 'ADsGetLastError';
procedure ADsSetLastError   ;external ADSLDPC name 'ADsSetLastError';
procedure AllocADsMem       ;external ADSLDPC name 'AllocADsMem';
function FreeADsMem         ;external ADSLDPC name 'FreeADsMem';
function ReallocADsMem      ;external ADSLDPC name 'ReallocADsMem';
function AllocADsStr        ;external ADSLDPC name 'AllocADsStr';
function FreeADsStr         ;external ADSLDPC name 'FreeADsStr';
function ReallocADsStr      ;external ADSLDPC name 'ReallocADsStr';
function ADsEncodeBinaryData;external ADSLDPC name 'ADsEncodeBinaryData';

function PropVariantToAdsType;external ADSI;
function AdsTypeToPropVariant;external ADSI;
procedure AdsFreeAdsValues;external ADSI;*)


end.
