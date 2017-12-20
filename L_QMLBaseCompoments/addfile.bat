
rem @echo off

set filepath=%1
set delstr=%cd%
set outfile=%2

:loop
if not "%delstr%"=="" (
set delstr=%delstr:~1%
set filepath=%filepath:~1%
goto loop
)

set filepath=%filepath:~1%
set filepath=%filepath:\=/%
echo ^<file^>QmlRes/%filepath%^</file^> >> %2






