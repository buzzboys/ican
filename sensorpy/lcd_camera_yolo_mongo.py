from imutils.video import VideoStream
import argparse
import imutils
import time
import datetime
import cv2
import sys
import numpy as np
from picamera import PiCamera
import picamera
from time import sleep
import RPi.GPIO as GPIO
from pymongo import MongoClient
from bson.objectid import ObjectId
import os
from lcd_display import lcd
import argparse
import glob
import random
from subprocess import Popen, PIPE
import darknet
import pymysql
from datetime import datetime
from datetime import timedelta


class test():
#lcd顯示
    my_lcd = lcd()
#照相機
    pir = 22
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pir, GPIO.IN)
    vs = VideoStream(usePiCamera=True).start()
    time.sleep(1)
    print("Start camera")
    child = Popen("./darknet detector test obj.data cfg/yolov4-Icantest-tiny.cfg yolov4-Icantrain-tiny_best.weights -dont_show -save_labels -thresh 0.5 ", stdin=PIPE, stdout=PIPE, bufsize=1, universal_newlines=True, shell=True)
    while True:
        input_state = GPIO.input(pir)
        frame = vs.read()
        if input_state == 0:
            img = frame
            print("get")
            time.sleep(1)          
            print("take a picture")
            cv2.imwrite("test.jpg",img)
            print("test.jpg", file=child.stdin)
            time.sleep(8)
            f = open("test.txt","r")
            word = f.read(1)
            if word ==0 or word == '':
                my_lcd.display_string("This is", 1)
                my_lcd.display_string("Trash", 2)
                print(word+' :Trash')
            else : 
                my_lcd.display_string("This is", 1)
                my_lcd.display_string("Recyclable", 2)
                print(word+' :Recyclable')       
            if word == "1":
                type1="recycle"
                type2="bottle"
            elif word == "2":
                type1="recycle"
                type2="can"
            elif word == "3":
                type1="recycle"
                type2="battery"   
            elif word == "4":
                type1="recycle"
                type2="paper"  
            elif word == "0":
                type1="normal"
                type2="trash"
            else :
                type1="normal"
                type2="trash"
            #mongodb= id time type classes
            dt=time.strftime("%Y-%m-%d_%H:%M:%S",time.localtime())
            dicts = {"time": dt,"type": type1,"class": type2}
            print(dicts)
            conn=MongoClient("mongodb://192.168.137.1/27017") #pi 連結成功       
            db=conn["ican"]
            coll=db["trash"]
            coll.insert_one(dicts)
            print("Connect success!")
GPIO.cleanup()
vs.stop()
cv2.destroyAllWindows()
