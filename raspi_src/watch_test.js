const Gpio = require('onoff').Gpio;

const pir50 = new Gpio(27, 'in', 'both');
const pir80 = new Gpio(17, 'in', 'both');

var v_50 = null
var v_80 = null
console.log('50: ' + v_50 + ', 80: ' + v_80);

pir50.watch(function (err, value) {
    if (err) exit();
    v_50 = value
    console.log('50: ' + v_50 + ', 80: ' + v_80);
});

pir80.watch(function (err, value) {
    if (err) exit();
    v_80 = value
    console.log('50: ' + v_50 + ', 80: ' + v_80);
});