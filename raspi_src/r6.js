var io = require("socket.io");
var express = require("express");
var app = express();
app.use(express.static('www'));
var server = app.listen(5438);
var sio = io.listen(server);

var exec = require('child_process').exec;
var Gpio = require('onoff').Gpio,
    pir50 = new Gpio(27, 'in', 'both');
pir80 = new Gpio(17, 'in', 'both');
pir50r = new Gpio(6, 'in', 'both');
pir80r = new Gpio(5, 'in', 'both');
led1 = new Gpio(25, 'out'); //一般垃圾LED
led2 = new Gpio(24, 'out'); //資源回收LED


// 一般垃圾處理gpio27(50) 17(80)
sio.on('connection', function(socket){
    pir50.watch(function(err, value) {
        if (err) exit();
        console.log("一般50%"+value);
        if(value == 0)  {
            socket.emit('pi', { 'msg': 50 })
        } else {  console.log("一般垃圾else:50%"+value);
            socket.emit('pi',{ 'msg' : 0 })
        }
    });
    pir80.watch(function(err, value) {
        if (err) exit();
        console.log("80%"+value);
        if(value == 0)  {
            socket.emit('pi', { 'msg': 80 })
            led1.write(1, function() {
                console.log("LED亮 80%到垃圾");});
        } else {  console.log("一班垃圾else:80%"+value);
            socket.emit('pi',{ 'msg': 50 })
            led1.write(0, function() {
                console.log("LED1 低於80關閉led");});
        }
    });

//資源回收處理gpio6(50) 5(80)
    pir50r.watch(function(err, value) {
        if (err) exit();
        console.log("50%"+value);
        if(value == 0)  {
            socket.emit('pir', { 'msgr': 50 })
        } else {  console.log("else:50%"+value);
            socket.emit('pir',{ 'msgr' : 0 })
        }
    });
    pir80r.watch(function(err, value) {
        if (err) exit();
        console.log("80%"+value);
        if(value == 0)  {
            socket.emit('pir', { 'msgr': 80 })
            led2.write(1, function() {
                console.log("LED2亮 80%到垃圾");});
        } else {  console.log("else:80%"+value);
            socket.emit('pir',{ 'msgr': 50 })
            led2.write(0, function() {
                console.log("LED2 低於50關閉led");});
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