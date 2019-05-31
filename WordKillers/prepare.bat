@echo off

del dcu\*.dcu
rd /S /Q src\__history
rd /S /Q src\__recovery
del /S *.~*
del /S *.dproj.local
del /S *.identcache
del /S *.dcu
del /S *.rsm
del /S *.dsk

del ..\WordKillers.zip
del install\Output\ins*.exe
del bin\WordKillers.ini
del bin\*.html
del bin\Trace.txt
del bin\*.log
del bin\*.rsm
cls
"C:\Program Files\7-Zip\7z.exe" a ..\WordKillers.zip bin\licen?e.txt bin\lisez-moi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\WordKillers.zip install\*.* src\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\WordKillers\install\inswordkillers.iss"
del ..\WordKillers.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\WordKillers.zip
cls
echo Renommer ../WordKillers.zip en WordKillersNNN.zip selon la version courante...
pause

