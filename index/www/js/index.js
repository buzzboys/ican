var DHT11 = require('./models/dht11');
var express = require('express');
var app = express();
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));


var paginate = 10;
var totalDocs;
var lastPage;
DHT11.count({}, function( err, count){
    totalDocs = count;
    lastPage = Math.ceil(totalDocs / paginate);
    console.log(totalDocs);
});

app.get("/", function(req, res) {
  var page = req.query.p || 1;   // 接收頁碼
  if (page < 1) {
    page = 1;
  }
  var skipDocs = (page-1)*paginate;
  if (skipDocs >= totalDocs ) {
    skipDocs = 0;
  }
	DHT11.find().select('-_id -__v').sort({'時間': -1}).skip(skipDocs).limit(paginate)
    .exec(function(err, docs) {
        res.render('past', {docs:docs, page:page, lastPage:lastPage});
    });
});

app.use("*",function(req,res){
  res.status(404).send('查無此頁！');
});

var server = app.listen(5438, function () {
  console.log("網站伺服器在5438埠口開工了！");
});