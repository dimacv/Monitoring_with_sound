@echo off
set hostname=10.45.1.20
set DOWN_CNT=5
set /a cnt1=0
set /a cnt2=0

:loop
ping -n 1 %hostname% | find "TTL=" >nul
if errorlevel 1 (
    echo %hostname% -^> Server is down!!!!!!!!!!! %cnt1%
    set /a cnt1+=1
    if %cnt1% geq %DOWN_CNT% (
        rem Replace with desired sound file
        start "" "C:\Windows\Media\Alarm10.wav"
    )
) else (
    echo %hostname% -^> Server is up! %cnt2%
    set /a cnt2+=1
    if %cnt2% geq %DOWN_CNT% (
        set /a cnt2=0
    )
    set /a cnt1=0
)
goto loop
