@echo off

del dcu\*.dcu
rd /S /Q src\__history
rd /S /Q src\__recovery
rd /S /Q rechdiko\src\__history
rd /S /Q rechdiko\src\__recovery
rd /S /Q impcfgdip\src\__history
rd /S /Q impcfgdip\src\__recovery
rd /S /Q gwodiko\src\__history
rd /S /Q gwodiko\src\__recovery
del /S *.~*
del /S *.dproj.local
del /S *.identcache
del /S *.dcu
del /S *.rsm
del /S *.dsk

del ..\Diplikata.zip
del install\Output\ins*.exe
del bin\Diplikata.ini
del bin\*.html
del bin\Trace.txt
del bin\*.log
del bin\*.rsm
cls
"C:\Program Files\7-Zip\7z.exe" a ..\Diplikata.zip bin\licen?e.txt bin\lisez-moi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\Diplikata.zip install\*.* rechdiko\src\*.* gwodiko\*.* gwodiko\src\*.* src\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\Diplikata\install\insdiplikata.iss"
del ..\Diplikata.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\Diplikata.zip
cls
echo Renommer ../Diplikata.zip en DiplikataNNN.zip selon la version courante...
pause

