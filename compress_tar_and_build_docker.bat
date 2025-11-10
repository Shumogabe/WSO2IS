@echo off
chcp 65001 >nul
setlocal

:: Lấy tên thư mục hiện tại
for %%I in ("%cd%") do set "FOLDER_NAME=%%~nxI"

:: Đường dẫn file tar (đặt ở thư mục cha)
set "DEST_TAR=%cd%\%FOLDER_NAME%.tar"

:: Kiểm tra nếu file tar đã tồn tại thì xóa
if exist "%DEST_TAR%" (
    echo ⚠️ File %DEST_TAR% đã tồn tại. Đang xóa...
    del "%DEST_TAR%"
    if exist "%DEST_TAR%" (
        echo ❌ Không thể xóa file: %DEST_TAR%
        endlocal
        exit /b 1
    )
    echo ✅ Đã xóa thành công: %DEST_TAR%
)

:: Di chuyển ra thư mục cha
cd ..

:: Nén lại thư mục
tar -cf "%DEST_TAR%" "%FOLDER_NAME%"
if errorlevel 1 (
    echo ❌ Nén thất bại!
    endlocal
    exit /b 1
)
echo ✅ Đã nén thành công: %FOLDER_NAME%

:: Cut file tar vào trong thư mục cha
move "%DEST_TAR%" "%FOLDER_NAME%"
if errorlevel 1 (
    echo ❌ Nén thất bại!
    endlocal
    exit /b 1
)
echo ✅ Đã nén thành công: %FOLDER_NAME%

:: Vào thư mục chạy lệnh build docker
cd "%FOLDER_NAME%"
docker build -t ciissoftdev/wso2is:latest .
docker run -p 443:443 -it --entrypoint /bin/bash ciissoftdev/wso2is:latest
::docker run --network host -it --entrypoint /bin/bash ciissoftdev/wso2is:latest
endlocal