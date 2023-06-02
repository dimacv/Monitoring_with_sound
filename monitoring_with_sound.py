import subprocess
import time
import winsound

hostname = "10.45.1.20" # замените на ваш адрес сервера

DOWN_CNT = 5
cnt1 = cnt2 = 0

while True:
    response = subprocess.Popen(['ping', '-n', '1', hostname], stdout=subprocess.PIPE).stdout.read()
    response_str = response.decode('cp866') # декодируем байтовую строку в строковую
    #print(response)
    if "TTL=" not in response_str: # если ответ содержит такую строку, значит пинг выполнен успешно
        print(hostname + " -> Server is down!!!!!!!!!!! " + str(cnt1))
        cnt1 += 1
        if cnt1 >= DOWN_CNT:
            # заменить на нужный звук
            winsound.PlaySound("C:/Windows/Media/Alarm10.wav", winsound.SND_ASYNC)
            #time.sleep(1)


    else:
        print(hostname + " -> Server is up! " + str(cnt2))
        if cnt2 >= DOWN_CNT:
            cnt2 = 0
        else:
            cnt2 += 1
        cnt1 = 0
