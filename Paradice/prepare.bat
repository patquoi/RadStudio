@echo off
del /S *.~*
del /S *.dproj.local
del /S *.groupproj.local
del /S *.identcache
del /S *.dcu
del /S *.rsm
del /S *.dsk
del /S *.bak
rd /S /Q src\__history
rd /S /Q src\__recovery
attrib -S -H Thumbs.db /S
del /S Thumbs.db


del ..\paradice.zip
del ins\Output\ins*.exe

del bin\*.log
del bin\*.rsm
cls
del ..\paradice-win64-src.zip
"C:\Program Files\7-Zip\7z.exe" a ..\paradice-win64-src.zip bin\licen?e.txt bin\lisezmoi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\paradice-win64-src.zip ins\*.* src\*.* doc\*.* res\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\Paradice\ins\paradice.iss"
del ..\paradice-win64-src.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\paradice.zip
cls
echo Renommer ../paradice.zip en paradiceNNN.zip selon la version courante...
pause

