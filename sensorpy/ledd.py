import pymysql
import time
import datetime
from datetime import datetime
from datetime import timedelta
import RPi.GPIO as GPIO



class main():
    GPIO.setmode(GPIO.BCM)
    db_setting={
        "host":"192.168.137.1",
        "user":"pipi",
        "password":"123456",
        "db":"trash",
        "charset":"utf8"}
    time_led = 23 #led gpio23
    
    
    
    
    try:
        conn=pymysql.connect(**db_setting)

        with conn.cursor() as cursor:
            command="SELECT * FROM trashcarrecord"
            while True:
                time.sleep(1)
                dt=time.strftime("%H:%M:%S",time.localtime())
                df=time.strftime("%H:%M:%S",time.localtime())
                print(dt)
                print(df)
                cursor.execute(command)

                result=cursor.fetchall()
                chioce=result[0][-1]
                time1=result[0][5]
                time2=result[0][8]
                time3=result[0][11]
                if chioce=="1" :
                    time_10=timedelta(hours=int(time1[:2]), minutes=int(time1[2:]))-timedelta(hours=0, minutes=10)
                elif chioce=="2" :
                    time_10=timedelta(hours=int(time2[:2]), minutes=int(time2[2:]))-timedelta(hours=0, minutes=10)
                elif chioce=="3" :
                    time_10=timedelta(hours=int(time3[:2]), minutes=int(time3[2:]))-timedelta(hours=0, minutes=10)
                print(time_10) #10分鐘後提醒時間
                print(time_10==dt)
                
                if time_10==dt :
                    GPIO.setmode(GPIO.BCM)
                    GPIO.setup(time_led,GPIO.OUT)
                    GPIO.output(time_led,1)
                    time.sleep(60)
                    GPIO.output(time_led,0)
                    GPIO.cleanup()
                    
                    
    except Exception as ex:
        print(ex)
        
