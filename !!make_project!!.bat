@echo off

if not exist deps/vst_sdk_2.4 (
cd deps
call sync
rem patching flac repo 
powershell.exe -ExecutionPolicy RemoteSigned -File patchFlac.ps1

cd ..
) 


mkdir build
echo.
cd build
cmake ..
echo.
echo Done!
echo.
echo You can find VC solution project in the "build" subfolder.
cd ..
echo.
build\ShoutVST_Solution.sln
PAUSE
