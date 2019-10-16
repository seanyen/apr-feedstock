pushd apr-iconv

mkdir build
cd build

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    %SRC_DIR%\apr-iconv
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
