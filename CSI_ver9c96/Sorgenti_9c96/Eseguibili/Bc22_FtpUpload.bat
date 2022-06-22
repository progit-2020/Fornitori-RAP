@ECHO OFF
ECHO Upload to FTP

REM Usage:
REM UploadToFTP [/L] FileToUpload
REM
REM Required Parameters:
REM  FileToUpload
REM      The file or file containing the list of files to be uploaded.
REM
REM Optional Parameters:
REM  /L  When supplied, the FileToUpload is read as a list of files to be uploaded.
REM      A list of files should be a plain text file which has a single file on each line.
REM      Files listed in this file must specify the full path and be quoted where appropriate.

SETLOCAL EnableExtensions

REM Connection information:
SET Server=www.mondoedp.com
SET UserName=fc4_irisftp
SET Password=mndedp2012

SET Commands="%TEMP%SendToFTP_commands.txt"

REM FTP user name and password. No spaces after either.
ECHO %UserName%> %Commands%
ECHO %Password%>> %Commands%

REM FTP transfer settings.
ECHO binary >> %Commands%

IF /I {%1}=={/L} (
   REM Add file(s) to the list to be FTP'ed.
   FOR /F "usebackq tokens=*" %%I IN ("%~dpnx2") DO ECHO put %%I >> %Commands%
) ELSE (
   ECHO put "%~dpnx1" >> %Commands%
)

REM Close the FTP connection.
ECHO close  >> %Commands%
ECHO bye    >> %Commands%

REM Perform the FTP.
FTP -d -i -s:%Commands% %Server%

ECHO.
ECHO.

REM Clean up.
IF EXIST %Commands% DEL %Commands%

ENDLOCAL