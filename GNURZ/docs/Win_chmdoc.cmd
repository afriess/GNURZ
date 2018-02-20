REM  
REM Builds all GNURZ docs
REM
REM Fix the Path to the fpcdoc and the other binaries
REM
PATH=C:\Users\andi\Documents\Pascal\lazarus\fpc\2.2.2\bin\i386-win32
fpdoc --descr=./xml/gnurz.xml --format=chm --package=gnurz --input=../source/gnurz.pas --output=./gnurz.chm
pause
