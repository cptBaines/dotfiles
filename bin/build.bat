@echo off
if not exist build mkdir build

SET COMPUNIT=compunit
SET TESTUNIT=test\test_main
SET BNC_OBJ=bnc\asm\lib
SET APP=main
SET SUBSYS=console
SET BUILD_DEFS=
SET LIBS=kernel32.lib 

:: get object files for bnc/asm/lib/*.o
for /f "delims=" %%x in (bnc\asm\lib\obj.lst) do set _BNC_OBJ=%%x

::pushd build
call :cleanup "build\%APP%.exe"
call :cleanup "build\%APP%.pdb"
call :cleanup "build\%APP%.obj"

SET OLD_PATH=%PATH%
SET _TC_PATH=c:\wsr\tc
SET _LLVM_ARCH=win64
SET _LLVM_VER=llvm14
SET _LLVM_PATH=%_TC_PATH%\sys\%_LLVM_VER%\%_LLVM_ARCH%
SET PATH=%_LLVM_PATH%\bin;%_LLVM_PATH%\bin\amd64

SET INCLUDE_DIR=-I%_TC_PATH%\home\bjorn\include\win -I%bnc
SET LIBPATH1=%_TC_PATH%\sys\global\lib\win64
SET WARN=-Wno-pragma-pack -Wno-ignored-attributes
SET COPT=/GS- /Gs9999999 /Od /EHa- /MD /Zi /Zl /Oi-
SET COPT=%COPT% -U__STDC_HOSTED__ -maes
SET COPT=%COPT% /Fo.\build\ %COMPUNIT%.c
SET COPT=%COPT% %_BNC_OBJ%
SET LOPT=/libpath:%LIBPATH1% /debug:full /nodefaultlib /machine:x64
SET LOPT=%LOPT% -subsystem:%SUBSYS%
SET LOPT=%LOPT% /out:.\build\%APP%.exe /stack:0x100000,0x100000

if "%1"=="cpp" goto :cpp
if "%1"=="test" goto :test

:: compiling without crt only link with native dlls 
clang-cl %INCLUDE_DIR% %BUILD_DEFS% %COPT% %WARN% ^
  -link %LOPT% %LIBS% 


SET PATH=%OLD_PATH%
goto :END

:test

SET INCLUDE_DIR=-I%_TC_PATH%\home\bjorn\include\win
SET LIBPATH1=%_TC_PATH%\sys\global\lib\win64
SET WARN=-Wno-pragma-pack -Wno-ignored-attributes
SET COPT=/GS- /Gs9999999 /Od /EHa- /MD /Zi /Zl -msse3 /Oi-
SET COPT=%COPT% /Fo.\build\ %TESTUNIT%.c
SET COPT=%COPT% %_BNC_OBJ%
SET LOPT=/libpath:%LIBPATH1% /debug:full /nodefaultlib /machine:x64
SET LOPT=%LOPT% -subsystem:%SUBSYS%
SET LOPT=%LOPT% /out:.\build\test.exe /stack:0x100000,0x100000

clang-cl %INCLUDE_DIR% %BUILD_DEFS% %COPT% %WARN% ^
  -link %LOPT% %LIBS% 

SET PATH=%OLD_PATH%
goto :END

:cpp
clang-cl %INCLUDE_DIR% %BUILD_DEFS% -E %COMPUNIT%.c
SET PATH=%OLD_PATH%
goto :END

:cleanup
if exist %1 del %1
goto :EOF

:END
EXIT /B %ERRORLEVEL%
