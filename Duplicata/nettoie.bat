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
rd /S /Q rechdico\src\__history
rd /S /Q rechdico\src\__recovery
rd /S /Q impcfgdup\src\__history
rd /S /Q impcfgdup\src\__recovery
attrib -S -H Thumbs.db /S
del /S Thumbs.db

