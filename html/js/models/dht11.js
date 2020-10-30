var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/test');
var dht11Schema = new mongoose.Schema({
    '類型': String,
    '時間': { type: Date, default: Date.now }
});
var DHT11 = mongoose.model('dht11', dht11Schema);
module.exports = DHT11;