unit DxPrint;

{ Direct Printer Component for Delphi 32 (C) 2000-2001, by Paul TOTH <tothpaul@free.fr>
  http://tothpaul.free.fr

 To install this component under Delphi 2 :
  - add new component DxPrintReg.

 To install this component under Delphi 6 PE :
  - create a new package
  - add DxPrint & DxPrintReg
  - add (...)\Delphi6\lib\designide.dcp as required package
  - compile
  - install
}

{
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Variants;

type
  TDxPrinter = class(TComponent)
  private
   fPrinter:string;
   fTitle  :string;
   fHandle :THandle;
   EOnOpen:TNotifyEvent;
   EOnClose:TNotifyEvent;
  protected
   procedure SetActive(Value:boolean);
   function GetActive:boolean;
  public
   Destructor Destroy; override;
   Function Open:boolean;
   Procedure Close;
   Function Write(s:string):boolean;
  published
   property Active:boolean read GetActive write SetActive;
   property Printer:string read fPrinter write fPrinter;
   property Title:string read fTitle write fTitle;
   property OnOpen:TNotifyEvent read EOnOpen write EOnOpen;
   property OnClose:TNotifyEvent read EOnClose write EOnClose;
  end;

function DefaultPrinter:string;

implementation

uses
 WinSpool;
 
function DefaultPrinter:string;
 var
  pDefaultPrinter: array[0..79] of Char;
  i:integer;
 begin
  GetProfileString('windows', 'device', '', pDefaultPrinter,SizeOf(pDefaultPrinter) - 1);
  Result:=pDefaultPrinter;
  i:=pos(',',Result);
  if i>0 then SetLength(Result,i-1);
 end;

Destructor TDxPrinter.Destroy;
begin
 Close;
 inherited;
end;

Procedure TDxPrinter.SetActive(Value:boolean);
begin
 if Value then Open else Close;
end;

Function TDxPrinter.GetActive:boolean;
begin
 Result:=(fHandle<>0);
end;

Function TDxPrinter.Open:boolean;
 var
  s:string;
  DocInfo:record
   DocName :PChar;
   OutFile :PChar;
   DataType:PChar;
  end;
begin
 if fPrinter='' then s:=DefaultPrinter else s:=fPrinter;
 if not WinSpool.OpenPrinter(PChar(s),fHandle,nil) then fHandle:=0;
 Result:=(fHandle<>0);
 if Result then begin
  with DocInfo do begin
   DocName :=PChar(fTitle);
   OutFile :=nil;
   DataType:=nil;
  end;
  Result:=(StartDocPrinter(fHandle,1,@DocInfo)<>0);
  if Result then begin
   if Assigned(EOnOpen) then EOnOpen(Self);
  end else begin
   ClosePrinter(fHandle);
   fHandle:=0;
  end;
 end;
end;

Procedure TDxPrinter.Close;
 begin
  if fHandle<>0 then begin
   ClosePrinter(fHandle);
   fHandle:=0;
  end;
 end;

Function TDxPrinter.Write(s:string):boolean;
 var
  Size:DWORD;
 begin
  Result:=WinSpool.WritePrinter(fHandle,pchar(s),Length(s),Size) and (Size=Length(s));
 end;

end.
