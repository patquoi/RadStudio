@echo off

del dcu\*.dcu
rd /S /Q src\__history
rd /S /Q src\__recovery
rd /S /Q rechdico\src\__history
rd /S /Q rechdico\src\__recovery
rd /S /Q impcfgdup\src\__history
rd /S /Q impcfgdup\src\__recovery
rd /S /Q ods8\src\__history
rd /S /Q ods8\src\__recovery
del /S *.~*
del /S *.dproj.local
del /S *.identcache
del /S *.dcu
del /S *.rsm
del /S *.dsk

del ..\Duplicata.zip
del install\Output\ins*.exe
del bin\Duplicata.ini
del bin\*.html
del bin\Trace.txt
del bin\*.log
del bin\*.rsm
cls
"C:\Program Files\7-Zip\7z.exe" a ..\Duplicata.zip bin\licen?e.txt bin\lisez-moi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\Duplicata.zip install\*.* rechdico\src\*.* impcfgdup\src\*.* ods8\src\*.* src\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\Duplicata\install\insduplicata.iss"
del ..\Duplicata.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\Duplicata.zip
cls
echo Renommer ../Duplicata.zip en DuplicataNNN.zip selon la version courante...
pause

