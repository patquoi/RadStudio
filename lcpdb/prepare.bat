@echo off

del dcu\*.dcu
rd /S /Q src\__history
rd /S /Q src\__recovery
rd /S /Q impcfgcpt\src\__history
rd /S /Q impcfgcpt\src\__recovery




del /S *.~*
del /S *.dproj.local
del /S *.identcache
del /S *.dcu
del /S *.rsm
del /S *.dsk

del ..\lcpdb.zip
del ins\Output\ins*.exe
del bin\lcpdb.ini
del bin\*.html

del bin\*.log
del bin\*.rsm
cls
del ..\lcpdbsrc.zip
"C:\Program Files\7-Zip\7z.exe" a ..\lcpdbsrc.zip bin\licen?e.txt bin\lisezmoi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\lcpdbsrc.zip ins\*.* impcfgcpt\src\*.* src\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\lcpdb\ins\lcpdb.iss"
del ..\lcpdbsrc.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\lcpdb.zip
cls
echo Renommer ../lcpdb.zip en lccpdbNNN.zip selon la version courante...
pause

