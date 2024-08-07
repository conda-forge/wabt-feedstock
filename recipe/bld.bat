@echo on

set CMAKE_CONFIG=Release

mkdir build_%CMAKE_CONFIG%
if errorlevel 1 exit 1

pushd build_%CMAKE_CONFIG%
if errorlevel 1 exit 1

cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE:STRING="%CMAKE_CONFIG%" ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DBUILD_TESTS:BOOL=OFF ^
    "%SRC_DIR%"
if errorlevel 1 exit 1

cmake --build . --target install --config %CMAKE_CONFIG%
if errorlevel 1 exit 1

popd
if errorlevel 1 exit 1
