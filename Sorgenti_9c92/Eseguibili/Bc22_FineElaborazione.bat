c:\programmi\7-zip\7z.exe a -ttar cartellini.tar *.pdf fileMetadati.txt
c:\programmi\7-zip\7z.exe a -tgzip <NOME_FILE>.tar.gz cartellini.tar
c:\windows\system32\cmd.exe /C "del cartellini.tar"
c:\windows\system32\cmd.exe /C "del *.pdf"
c:\windows\system32\cmd.exe /C "del fileMetadati.txt"
c:\windows\system32\cmd.exe /C "echo. 2><NOME_FILE>.ok"
c:\windows\system32\cmd.exe /C "call C:\SVN\CSI\CSI_Sviluppo\Eseguibili\Bc22_FtpUpload.bat <NOME_FILE>.tar.gz"
c:\windows\system32\cmd.exe /C "call C:\SVN\CSI\CSI_Sviluppo\Eseguibili\Bc22_FtpUpload.bat <NOME_FILE>.ok"
c:\windows\system32\cmd.exe /C "del <NOME_FILE>.tar.gz"
c:\windows\system32\cmd.exe /C "del <NOME_FILE>.ok"