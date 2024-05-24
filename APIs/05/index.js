var express = require('express');
var cors = require('cors');
require('dotenv').config()

var app = express();

const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(cors());
app.use('/public', express.static(process.cwd() + '/public'));

app.get('/', function (req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

var busboy = require('connect-busboy');
app.use(busboy()); 

var fileupload = require("express-fileupload");
app.use(fileupload());

app.post("/api/fileanalyse", (req, res) => {
  const {mimetype, name, size} = req.files.upfile
  console.log(mimetype, name, size)
  res.json({
    name: name,
    type: mimetype,
    size: size
  })
})

const port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Your app is listening on port ' + port)
});
