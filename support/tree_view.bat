@echo off
chcp 866 >nul
setlocal EnableDelayedExpansion

set /p folder="Укажите путь к папке: "

if not exist "%folder%" (
    echo Папка не существует!
    pause
    exit /b
)

set output=tree_output.txt

echo Генерация дерева...

rem Шаг 1: Генерируем дерево во временный файл (CP866)
tree "%folder%" /F > temp_tree.txt

rem Шаг 2: Преобразуем в ASCII и добавляем заголовок
(
    echo ======================================
    echo Иерархический список файлов
    echo Папка: %folder%
    echo Дата: %date% %time%
    echo ======================================
    echo.
    
    for /f "usebackq delims=" %%a in ("temp_tree.txt") do (
        set "line=%%a"
        set "line=!line:├=+!"
        set "line=!line:└=\--!"
        set "line=!line:─=-!"
        set "line=!line:│=^|!"
        echo !line!
    )
) > "%output%"

del temp_tree.txt
echo Готово! Файл: %output%
pause
