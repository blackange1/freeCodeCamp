// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 
app.get("/api/hello", function (req, res) {
  res.json({greeting: 'hello API'});
});

// api/1451001600000
// api/2015-12-25
app.get("/api/:data", function(req, res) {
  const data = req.params.data
  let utc
  let unix
  const invalidDate = "Invalid Date"
  
  utc = new Date(+data)
  if (utc == invalidDate) {
    utc = new Date(data)
    if (utc == invalidDate) {
      res.json({
        error: "Invalid Date"
      })
    }
  }
  res.json({
    unix: Date.parse(utc),
    utc: utc.toString()
  })
});


// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
