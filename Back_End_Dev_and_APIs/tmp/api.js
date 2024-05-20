require('dotenv').config()

// let bodyParser = require("body-parser");
const bodyParser = require('body-parser');


let express = require('express');
let app = express();
console.log("Hello World")

app.use(function middleware(req, res, next) {
    var string = req.method + " " + req.path + " - " + req.ip;
    console.log(string)
    // Call the next function in line:
    next();
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.post("/name", 
  (req, res) => {
    // res.json(req.body)  
    // Handle the data in the request
    var string = req.body.first + " " + req.body.last;
    res.json({ name: string });
  })

app.get("/", (req, res) => {
    // add text on page
    // res.send("Hello Express");
    
    // add view index.html
    res.sendFile(__dirname + '/views/index.html');

    // add style
    app.use("/public", express.static(__dirname + "/public"));

});

// now/
app.get(
    "/now",
    (req, res, next) => {
      req.time = new Date().toString();
      next();
    },
    (req, res) => {
      res.send({
        time: req.time
      });
    }
  );

// qwerty/echo
app.get("/:word/echo", (req, res) => {
    res.json({echo: req.params.word})
})

// name?first=firstname&last=lastnam
app.get("/name", function(req, res) {
    var firstName = req.query.first;
    var lastName = req.query.last;
    // OR you can destructure and rename the keys
    var { first: firstName, last: lastName } = req.query;
    // Use template literals to form a formatted string
    res.json({
      name: `${firstName} ${lastName}`
    });
  });




















 module.exports = app;
