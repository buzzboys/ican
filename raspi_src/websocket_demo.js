const express = require('express')
const app = express()
const server = app.listen(5000)
const WebSocket = require('ws')

const wss = new WebSocket.Server({ server })

wss.on('connection', function (ws) {
    console.log('Get connection!')

    ws.on('message', function (data) {
        console.log(data)
    })

    let data = 50
    setInterval(function () {
        data = (data + 50) % 100
        ws.send(data)
        console.log('send data: ' + data)
    }, 2000)
})