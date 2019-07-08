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
rd /S /Q rechdiko\src\__history
rd /S /Q rechdiko\src\__recovery
rd /S /Q gwodiko\src\__history
rd /S /Q gwodiko\src\__recovery
rd /S /Q impcfgdip\src\__history
rd /S /Q impcfgdip\src\__recovery
attrib -S -H Thumbs.db /S
del /S Thumbs.db

