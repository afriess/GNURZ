REM
REM Builds all GNURZ docs
REM
REM Notes:
REM
REM Fix the Path to the fpcdoc and the other binaries
REM
PATH=C:\Users\andi\Documents\Pascal\lazarus\fpc\2.2.2\bin\i386-win32
fpdoc --descr=./xml/gnurz.xml --format=html --package=gnurz --input=../source/gnurz.pas --output=./html
pause
