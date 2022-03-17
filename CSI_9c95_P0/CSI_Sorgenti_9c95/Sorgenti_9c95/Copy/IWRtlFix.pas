unit IWRtlFix;

interface

implementation

{$IFDEF VER230}
  {$DEFINE XE2_OR_ABOVE}
{$ENDIF}
{$IFDEF VER240}
  {$DEFINE XE2_OR_ABOVE}
{$ENDIF}
{.$DEFINE LOG_PATCH}

uses
  SysUtils, Classes, Windows, Messages;

{-------------------------------------------------------------------------------
Locking mechanism
-------------------------------------------------------------------------------}

// Critical section used for modified MakeObjectInstance
var
  InternalLock: TRTLCriticalSection;
  LockFlag: Integer = 0;

procedure InitLock;
begin
  InterlockedIncrement(LockFlag);
  InitializeCriticalSection(InternalLock);
end;

procedure ReleaseLock;
begin
  DeleteCriticalSection(InternalLock);
  InterlockedDecrement(LockFlag);
end;

procedure Lock; inline;
begin
  if LockFlag > 0 then begin
    EnterCriticalSection(InternalLock);
  end;
end;

procedure Unlock; inline;
begin
  if LockFlag > 0 then begin
    LeaveCriticalSection(InternalLock);
  end;
end;

{-------------------------------------------------------------------------------
Fix 1: Classes.MakeObjectInstance()
Reason: MakeObjectInstance is NOT thread safe. Under heavy load, it can cause an application crash
More info: http://qc.embarcadero.com/wc/qcmain.aspx?d=47559
-------------------------------------------------------------------------------}

//  The lines below are copied from Delphi XE2 Classes.pas
//  Most of the code had to be copied because MakeObjectInstance() uses a lot of things
//  not exposed by Classes.pas, like types and vars declared within Implementation section

type
  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code: Byte;
    Offset: Integer;
    case Integer of
      0: (Next: PObjectInstance);
      1: (FMethod: TWndMethod);
  end;

const
{$IFNDEF XE2_OR_ABOVE}
  {$DEFINE CPUX86}     // Define CPUX86 for D2009, D2010 and XE
{$ENDIF}

{$IF Defined(CPUX86)}
  CodeBytes = 2;
{$ELSEIF Defined(CPUX64)}
  CodeBytes = 8;
{$IFEND}
  InstanceCount = (4096 - SizeOf(Pointer) * 2 - CodeBytes) div SizeOf(TObjectInstance) - 1;

type
  PInstanceBlock = ^TInstanceBlock;
  TInstanceBlock = packed record
    Next: PInstanceBlock;
    Code: array[1..2] of Byte;
    WndProcPtr: Pointer;
    Instances: array[0..InstanceCount] of TObjectInstance;
  end;

var
  InstBlockList: PInstanceBlock;
  InstFreeList: PObjectInstance;

{ Standard window procedure }
function StdWndProc(Window: HWND; Message: UINT; WParam: WPARAM; LParam: WPARAM): LRESULT; stdcall;
{$IF Defined(CPUX86)}
{ In    ECX = Address of method pointer }
{ Out   EAX = Result }
asm
        XOR     EAX,EAX
        PUSH    EAX
        PUSH    LParam
        PUSH    WParam
        PUSH    Message
        MOV     EDX,ESP
        MOV     EAX,[ECX].Longint[4]
        CALL    [ECX].Pointer
        ADD     ESP,12
        POP     EAX
end;
{$ELSEIF Defined(CPUX64)}
{ In    R11 = Address of method pointer }
{ Out   RAX = Result }
var
  Msg: TMessage;
asm
        .PARAMS 2
        MOV     Msg.Msg,Message
        MOV     Msg.WParam,WParam
        MOV     Msg.LParam,LParam
        MOV     Msg.Result,0
        LEA     RDX,Msg
        MOV     RCX,[R11].TMethod.Data
        CALL    [R11].TMethod.Code
        MOV     RAX,Msg.Result
end;
{$IFEND}

{ Allocate an object instance }

function CalcJmpOffset(Src, Dest: Pointer): Longint;
begin
  {$IFDEF XE2_OR_ABOVE}
  Result := IntPtr(Dest) - (IntPtr(Src) + 5);
  {$ELSE}
  Result := Longint(Dest) - (Longint(Src) + 5);
  {$ENDIF}
end;

// This function was copied from Classes.pas and modified
// We are using a critical section to prevent concurrency issues
function IW_MakeObjectInstance(AMethod: TWndMethod): Pointer;
const
  BlockCode: array[1..CodeBytes] of Byte = (
{$IF Defined(CPUX86)}
    $59,                       { POP ECX }
    $E9);                      { JMP StdWndProc }
{$ELSEIF Defined(CPUX64)}
    $41,$5b,                   { POP R11 }
    $FF,$25,$00,$00,$00,$00);  { JMP [RIP+0] }
{$IFEND}
  PageSize = 4096;
var
  Block: PInstanceBlock;
  Instance: PObjectInstance;
begin
  {$IFDEF LOG_PATCH}
  OutputDebugString('IW_MakeObjectInstance called');
  {$ENDIF}
  Lock;      // added
  try
    if InstFreeList = nil then
    begin
      Block := VirtualAlloc(nil, PageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
      Block^.Next := InstBlockList;
      Move(BlockCode, Block^.Code, SizeOf(BlockCode));
  {$IF Defined(CPUX86)}
      Block^.WndProcPtr := Pointer(CalcJmpOffset(@Block^.Code[2], @StdWndProc));
  {$ELSEIF Defined(CPUX64)}
      Block^.WndProcPtr := @StdWndProc;
  {$IFEND}
      Instance := @Block^.Instances;
      repeat
        Instance^.Code := $E8;  { CALL NEAR PTR Offset }
        Instance^.Offset := CalcJmpOffset(Instance, @Block^.Code);
        Instance^.Next := InstFreeList;
        InstFreeList := Instance;
        Inc(PByte(Instance), SizeOf(TObjectInstance));
      {$IFDEF XE2_OR_ABOVE}
      until IntPtr(Instance) - IntPtr(Block) >= SizeOf(TInstanceBlock);
      {$ELSE}
      until Longint(Instance) - Longint(Block) >= SizeOf(TInstanceBlock);
      {$ENDIF}
      InstBlockList := Block;
    end;
    Result := InstFreeList;
    Instance := InstFreeList;
    InstFreeList := Instance^.Next;
    Instance^.FMethod := AMethod;
  finally                                  // added
    Unlock;
  end;
end;

{ Free an object instance }

procedure IW_FreeObjectInstance(ObjectInstance: Pointer);
begin
  {$IFDEF LOG_PATCH}
  OutputDebugString('IW_FreeObjectInstance called');
  {$ENDIF}
  Lock;      // added
  try
    if ObjectInstance <> nil then
    begin
      PObjectInstance(ObjectInstance)^.Next := InstFreeList;
      InstFreeList := ObjectInstance;
    end;
  finally
    UnLock;  // added
  end;
end;

procedure CleanupInstFreeList(BlockStart, BlockEnd: PByte);
var
  Prev, Next, Item: PObjectInstance;
begin
  Prev := nil;
  Item := InstFreeList;
  while Item <> nil do
  begin
    Next := Item.Next;
    if (PByte(Item) >= BlockStart) and (PByte(Item) <= BlockEnd) then
    begin
      Item := Prev;
      if Prev = nil then
        InstFreeList := Next
      else
        Prev.Next := Next;
    end;
    Prev := Item;
    Item := Next;
  end;
end;

function GetFreeInstBlockItemCount(Item: PObjectInstance; Block: PInstanceBlock): Integer;
var
  I: Integer;
begin
  Result := 0;
  while Item <> nil do
  begin
    for I := High(Block.Instances) downto 0 do
    begin
      if @Block.Instances[I] = Item then
      begin
        Inc(Result);
        Break;
      end;
    end;
    Item := Item.Next;
  end;
end;

procedure ReleaseObjectInstanceBlocks;
var
  NextBlock, Block, PrevBlock: PInstanceBlock;
  UnusedCount: Integer;
begin
  {$IFDEF LOG_PATCH}
  OutputDebugString('ReleaseObjectInstanceBlocks called');
  {$ENDIF}
  Lock;   // added
  try
    Block := InstBlockList;
    PrevBlock := nil;
    while Block <> nil do
    begin
      NextBlock := Block.Next;

      { Obtain the number of free items in the InstanceBlock }
      UnusedCount := GetFreeInstBlockItemCount(InstFreeList, Block);

      { Release memory if the InstanceBlock contains only "free" items }
      if UnusedCount = Length(Block.Instances) then
      begin
        { Remove all InstFreeList items that refer to the InstanceBlock }
        CleanupInstFreeList(PByte(Block), PByte(Block) + SizeOf(TInstanceBlock) - 1);

        VirtualFree(Block, 0, MEM_RELEASE);

        Block := PrevBlock;
        if PrevBlock = nil then
          InstBlockList := NextBlock
        else
          PrevBlock.Next := NextBlock;
      end;

      { Next InstanceBlock }
      PrevBlock := Block;
      Block := NextBlock;
    end;
  finally
    UnLock;  // added
  end;
end;

{-------------------------------------------------------------------------------
General code to do runtime patching
-------------------------------------------------------------------------------}
procedure PatchCode(Address: Pointer; const NewCode; Size: Integer);
var
  OldProtect: DWORD;
begin
  if VirtualProtect(Address, Size, PAGE_EXECUTE_READWRITE, OldProtect) then begin
    Move(NewCode, Address^, Size);
    FlushInstructionCache(GetCurrentProcess, Address, Size);
    VirtualProtect(Address, Size, OldProtect, @OldProtect);
  end;
end;

type
  PInstruction = ^TInstruction;
  TInstruction = packed record
    Opcode: Byte;
    Offset: Integer;
  end;

procedure CodeRedirect(OldAddress, NewAddress: Pointer);
var
  NewCode: TInstruction;
begin
  NewCode.Opcode := $E9; //jump relative
  NewCode.Offset := NativeInt(NewAddress) - NativeInt(OldAddress) - SizeOf(NewCode);
  PatchCode(OldAddress, NewCode, SizeOf(NewCode));
end;

{-------------------------------------------------------------------------------
MakeObjectInstance() patch implementation
-------------------------------------------------------------------------------}
var
  PatchApplied: boolean;

// Main patch function
procedure IW_ApplyRTLPatch;
begin
  if not PatchApplied and not ModuleIsPackage then begin    // don't patch IntraWeb design and runtime packages
    CodeRedirect(@Classes.MakeObjectInstance, @IW_MakeObjectInstance);
    CodeRedirect(@Classes.FreeObjectInstance, @IW_FreeObjectInstance);
    PatchApplied := True;
  end;
end;

procedure IW_Cleanup;
begin
  if PatchApplied then begin
    ReleaseObjectInstanceBlocks;
  end;
  PatchApplied := False;
end;

initialization
  PatchApplied := False;
  InitLock;
  IW_ApplyRTLPatch();

finalization
  IW_Cleanup;
  ReleaseLock;

end.
