@echo off
@echo.

rem compressione_file_web.bat
rem   effettua la compressione dei file js e css utilizzando lo strumento YUICompressor di Yahoo
rem   parametri
rem     par1 = path di wwwroot oppure vuoto se è lanciato direttamente dalla cartella wwwroot

@set BASE_ROOT=%~1
if "%BASE_ROOT%"=="" (
  @set BASE_ROOT=.
)
if not exist %BASE_ROOT% goto fail_folder

@set JS_ROOT=%BASE_ROOT%\js
@set JQUERY_ROOT=%JS_ROOT%\jquery-plugins
@set CSS_ROOT=%BASE_ROOT%\css
@set JQUERY_UI_VER=1.10.3
@set JQUERY_UI_THEME=cupertino
@set YUI_VER=2.4.7

@echo compressione file web con YUI Compressor
if "%BASE_ROOT%"=="." (
  @echo   in questa cartella...
) else (
  @echo   in %BASE_ROOT%... 
)

java -version 2> nul
if %ERRORLEVEL%==9009 goto fail_java

@echo   File JavaScript

rem file comuni
copy /b /y ^
 "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\FunzioniGenerali.js" + ^
 "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\medpIWMultiColumnComboBox.js" + ^
 "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\common.js" + ^
 "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\clockscript.js" + ^
 "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\date-it-IT.js" ^
 "%JS_ROOT%\temp_js01.js" > nul

java -jar "%BASE_ROOT%\yuicompressor-%YUI_VER%.jar" ^
  "%JS_ROOT%\temp_js01.js" ^
  -o "%JS_ROOT%\temp_js01.min.js" > nul

rem plugin jQuery
copy /b /y ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\autoNumeric-1.7.4-B.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.capitalize.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.contextMenu.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.cookie.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.gritter.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.metadata.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.mousewheel.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.tools.min.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.ui.combobox.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.validator.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JQUERY_ROOT%\jquery.watermarkinput.js" ^
  "%JS_ROOT%\temp_js02.js" > nul

java -jar "%BASE_ROOT%\yuicompressor-%YUI_VER%.jar" ^
  "%JS_ROOT%\temp_js02.js" ^
  -o "%JS_ROOT%\temp_js02.min.js" > nul

copy /b /y ^
  "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\jquery-migrate-1.4.1.min.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\jquery-ui-%JQUERY_UI_VER%.custom.min.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\temp_js01.min.js" + ^
  "%BASE_ROOT%\sep.txt" + "%JS_ROOT%\temp_js02.min.js" ^
  "%JS_ROOT%\web_nc.min.js" > nul

rem rimuove file js temporanei
del "%JS_ROOT%\temp_*.js" 2> nul

@echo   File CSS

rem file per IrisWeb

copy /b /y ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\IrisWeb01.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\IrisWeb_jquery-ui.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\jquery.gritter.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\jquery.watermarkinput.css" ^
  "%CSS_ROOT%\temp_webbase.css" > nul

java -jar "%BASE_ROOT%\yuicompressor-%YUI_VER%.jar" ^
  "%CSS_ROOT%\temp_webbase.css" ^
  -o "%CSS_ROOT%\webbase_nc.min.css" > nul

rem file per IrisCloud

copy /b /y ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\IrisWeb01.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\IrisWeb02.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\IrisWeb_jquery-ui.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\jquery.gritter.css" + ^
  "%BASE_ROOT%\sep.txt" + "%CSS_ROOT%\jquery.watermarkinput.css" ^
  "%CSS_ROOT%\temp_webplus.css" > nul

java -jar "%BASE_ROOT%\yuicompressor-%YUI_VER%.jar" ^
  "%CSS_ROOT%\temp_webplus.css" ^
  -o "%CSS_ROOT%\webplus_nc.min.css" > nul

rem rimuove file css temporanei
del "%CSS_ROOT%\temp_*.css" 2> nul

rem file jQuery UI
java -jar "%BASE_ROOT%\yuicompressor-%YUI_VER%.jar" ^
  "%CSS_ROOT%\%JQUERY_UI_THEME%\jquery-ui-%JQUERY_UI_VER%.custom.css" ^
  -o "%CSS_ROOT%\%JQUERY_UI_THEME%\jquery-ui-%JQUERY_UI_VER%.custom.min.css"

:end
exit /b 0

:fail_folder
@echo     ERRORE: BASE_ROOT non valido: %BASE_ROOT%
pause
exit /b 1

:fail_java
@echo     ERRORE: runtime java non presente
pause
exit /b 1