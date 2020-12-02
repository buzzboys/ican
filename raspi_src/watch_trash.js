const express = require("express");
const app = express();
const server = app.listen(5000);
const WebSocket = require('ws')
const wss = new WebSocket.Server({ server })

const exec = require('child_process').exec;
const Gpio = require('onoff').Gpio;

const pir50 = new Gpio(27, 'in', 'both');
const pir80 = new Gpio(17, 'in', 'both');
const pir50r = new Gpio(6, 'in', 'both');
const pir80r = new Gpio(5, 'in', 'both');
const led1 = new Gpio(25, 'out'); //一般垃圾LED
const led2 = new Gpio(24, 'out'); //資源回收LED


// 一般垃圾處理gpio27(50) 17(80)
wss.on('connection', function (ws) {
    pir50.watch(function (err, value) {
        if (err) exit();
        console.log("一般50%" + value);
        if (value == 0) {
            ws.send(50)
        } else {
            console.log("一般垃圾else:50%" + value);
            ws.send(0)
        }
    });
    pir80.watch(function (err, value) {
        if (err) exit();
        console.log("一般80%" + value);
        if (value == 0) {
            ws.send(80)
            led1.write(1, function () {
                console.log("LED亮 80%到垃圾");
            });
        } else {
            console.log("一般垃圾else:80%" + value);
            ws.send(50)
            led1.write(0, function () {
                console.log("LED1 低於80關閉led");
            });
        }
    });

    //資源回收處理gpio6(50) 5(80)
    pir50r.watch(function (err, value) {
        if (err) exit();
        console.log("回收50%" + value);
        if (value == 0) {
            ws.send(50)
        } else {
            console.log("回收else:50%" + value);
            ws.send(0)
        }
    });
    pir80r.watch(function (err, value) {
        if (err) exit();
        console.log("回收80%" + value);
        if (value == 0) {
            ws.send(80)
            led2.write(1, function () {
                console.log("LED2亮 80%到垃圾");
            });
        } else {
            console.log("回收else:80%" + value);
            ws.send(50)
            led2.write(0, function () {
                console.log("LED2 低於50關閉led");
            });
        }
    });
});



function exit() {
    pir50.unexport();
    pir80.unexport();
    pir50r.unexport();
    pir80r.unexport();
    console.log('\n結束程式');
    process.exit();
}

process.on('SIGINT', exit);
console.log('偵測垃圾量');