@echo off
setlocal enabledelayedexpansion

set "hostname=10.45.1.20"  REM Замените на свой адрес сервера

set "DOWN_CNT=5"
set "cnt1=0"
set "cnt2=0"

:loop
REM Выполнение команды ping с одной попыткой и проверкой вывода
for /f "tokens=*" %%A in ('ping -n 1 %hostname%') do (
    REM Проверка наличия строки "TTL=" в выводе команды
    echo %%A | find "TTL=" >nul
    if errorlevel 1 (
        REM Если ответ не содержит строку "TTL=", значит сервер недоступен
        echo %hostname% -> Сервер недоступен! ! ! ! ! ! ! %cnt1%
        set /a cnt1+=1
        if %cnt1% gtr %DOWN_CNT% (
            REM Заменить на нужный звук
            start "" "C:\Windows\Media\Alarm10.wav"
            REM Добавьте задержку времени, если требуется
            REM timeout /t 1 /nobreak >nul
        )
    ) else (
        REM Если ответ содержит строку "TTL=", значит сервер доступен
        echo %hostname% -> Сервер доступен! %cnt2%
        if %cnt2% gtr %DOWN_CNT% (
            set "cnt2=0"
        ) else (
            set /a cnt2+=1
        )
        set "cnt1=0"
    )
)

REM Задержка времени, прежде чем повторить цикл
timeout /t 1 /nobreak >nul
goto loop
