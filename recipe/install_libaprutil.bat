pushd apr-util

mkdir build
cd build

cmake ^
    -GNinja ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    %SRC_DIR%\apr-util
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
