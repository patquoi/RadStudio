del bin\listemots.txt
del /S dcu\*.dcu
rd /S /Q src\__history
del /S .\*.~dsk
del /S .\*.dsk
del /S .\*.local
del /S .\*.identcache
attrib -S -H Thumbs.db /S
del /S .\Thumbs.db
del install\Output\ins*.exe
del bin\Trace.txt
del bin\*.log
pause

