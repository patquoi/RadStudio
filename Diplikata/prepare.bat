@echo off
move bin\Diplikata.ini ..
move bin\*.html ..
del bin\listemots.txt
del dcu\*.dcu
rd /S /Q src\__history
del /S .\*.~dsk
del /S .\*.dsk
del /S .\*.local
del /S .\*.identcache
attrib -S -H Thumbs.db /S
del /S .\Thumbs.db
del ..\Diplikata.zip
del install\Output\ins*.exe
del bin\Trace.txt
del bin\*.log
cls
"c:\program files\Winzip\Winzip32.exe" -a -p ..\Diplikata.zip bin\licen?e.txt bin\lisez-moi.txt 
"c:\program files\Winzip\Winzip32.exe" -a -p ..\Diplikata.zip install\*.* rechdiko\src\*.* gwodiko\*.* gwodiko\src\*.* src\*.*
echo Compiler et tester l'installation...
"C:\Program Files\Inno Setup 5\Compil32.exe" C:\Borland\Delphi2005\Diplikata\install\Diplikata.iss
del ..\Diplikata.zip
move ..\Diplikata.ini bin
move ..\*.html bin
"c:\program files\Winzip\Winzip32.exe" -a -p -r ..\Diplikata.zip
cls
echo Renommer ../Diplikata.zip en DiplikataNNN.zip selon la version courante...
pause

