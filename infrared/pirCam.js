var exec = require('child_process').exec;
var Gpio = require('onoff').Gpio,
  pir = new Gpio(2, 'in', 'rising'),
  captured = false;
  led = new Gpio(17, 'out');

function takeVideo() {
    // 自訂「時間」函式
    var time = function () {
        var now = new Date();
        var str = now.getFullYear() + '.' +
            (now.getMonth()+1) + '.' +
            now.getDate()
            + '_' +
            ((now.getHours() < 10) ? "0" : "") + now.getHours()
            + '.' +
            ((now.getMinutes() < 10) ? "0" : "") + now.getMinutes()
            + '.' +
            ((now.getSeconds() < 10) ? "0" : "") + now.getSeconds();
        return str;
    };
    var cmd = 'raspistill -w 640 -h 480 -t 1 -q 40 -o ./images/'
        + time() + '.jpg';
    exec(cmd, function(error, stdout, stderr) {
        if (error !== null) {
            console.log('exec執行錯誤：' + error);
        } else {
            console.log('拍攝完畢！');
        }
    });
}
function takeled() {
led.write(1, function() { //#E 非同步地將新的數值寫入到 pin17
    console.log("開啟LED");
});
}
function offled() {
    led.write(0, function() { //#E 非同步地將新的數值寫入到 pin17
        console.log("關閉LED");
    });
}
  // 處理pir腳位變化的事件處理程式
pir.watch(function(err, value) {
  if (err) exit();
  // 若腳位是「高電位」而且尚未拍照
  if(value == 1 && captured == false)  {
   captured = true;
   console.log('偵測到垃圾，開始攝影');
      takeVideo();           // 拍照
      takeled();             // 開燈
      // 3秒設置成「未拍照」狀態。
   setTimeout(function () {
      captured = false;
       offled()
    }, 3000);
  }
});
function exit() {
  pir.unexport();
  console.log('\n結束程式');
  process.exit();
  led.exit();
}
process.on('SIGINT', exit);
console.log('自動攝影裝置準備好了～');