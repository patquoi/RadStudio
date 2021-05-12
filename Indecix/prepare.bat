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


del ..\indecix.zip
del ins\Output\ins*.exe

del bin\*.log
del bin\*.rsm
cls
del ..\indecix-win64-src.zip
"C:\Program Files\7-Zip\7z.exe" a ..\indecix-win64-src.zip bin\licen?e.txt bin\lisezmoi.txt 
"C:\Program Files\7-Zip\7z.exe" a -r ..\indecix-win64-src.zip ins\*.* src\*.* res\*.*
echo Compiler et tester l'installation...
"C:\Program Files (x86)\Inno Setup 5\Compil32.exe" "C:\Users\Patrice Fouquet\Documents\Embarcadero\Studio\Projets\indecix\ins\indecix.iss"
del ..\indecix-win64-src.zip
"C:\Program Files\7-Zip\7z.exe" a -r ..\indecix.zip
cls
echo Renommer ../indecix.zip en indecixNNN.zip selon la version courante...
pause

