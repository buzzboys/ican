const WebSocket = require('ws')
const ws = new WebSocket('ws://192.168.137.1:8080/Ican/IcanContent')

ws.onopen = function () { console.log("Get connection to RasPi"); }
ws.onclose = function () { console.log("Lost connection to RasPi"); }
ws.onmessage = function (event) {

        console.log('send data: ' + event.data)

}