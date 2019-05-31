@echo off
del /Q c:\www\mapage\compil\images\compte\lcpdb\*.*
del /Q c:\www\mapage\compil\images\compte\lcpdb\html\*.*
copy bin\*.* c:\www\mapage\compil\images\compte\lcpdb
copy src.zip c:\www\mapage\compil\images\compte\lcpdb
copy bin\html\*.* c:\www\mapage\compil\images\compte\lcpdb\html
copy li*.txt c:\www\mapage\compil\images\compte\lcpdb\
del c:\www\mapage\compil\images\compte\lcpdb\Statistiques.html
del c:\www\mapage\compil\images\compte\lcpdb\lcpdb.ini
