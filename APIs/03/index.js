require('dotenv').config();

const express = require('express');
const cors = require('cors');
const app = express();

const bodyParser = require('body-parser')
const dns = require('dns');



/** 1) Install & Set up mongoose */
const mongoose = require('mongoose');
// mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true });
mongoose.connect(process.env.MONGO_URI);
const AutoIncrement = require('mongoose-sequence')(mongoose);

/** 2) Create a 'Url' Model */
const urlSchema = new mongoose.Schema({
  original_url: { type: String, required: true },
  // short_url: { type: Number, required: true }
  short_url: Number
});
urlSchema.plugin(AutoIncrement, {id:'short_url_seq',inc_field: 'short_url'});
/** 3) Create and Save a Url */
const Url = mongoose.model("Url", urlSchema);


// COUNT
const countSchema = new mongoose.Schema({
  count: { type: Number, required: true }
})
const Count = mongoose.model("Count", countSchema)



const findUrlByOriginalCount = async (url, res) => {
  let count = await Count.findOne();
  if (!count) {
    // create count
    count = new Count({count: 1});
    count.save();
  } else {
    count.count++
    count.save()
    console.log("url url", url)
    // url.short_url = count.count
    // url.save()
  }
  res.json({
    original_url: url.original_url,
    short_url: count.count
  })
}

const findUrlByOriginalUrl = async (originalUrl, res) => {
  try {
    const url = await Url.findOne({original_url: originalUrl});
    if (url) {
      res.json({
        original_url: url.original_url,
        short_url: url.short_url
      })
    } else {
      // createAndSaveCount
      // const url = new Url({original_url: originalUrl, short_url: 1});
      const url = new Url({original_url: originalUrl});
      
      url.save();
      findUrlByOriginalCount(url, res)
    }
  } catch (error) {
    res.json({error: 'Error finding person:'})
  }
};

const findUrlByOriginalShortUrl = async (shortUrl, res) => {
  const url = await Url.findOne({short_url: shortUrl});
  if (url) {
    res.writeHead(301, {
      Location: url.original_url
    }).end();
    // res.json({
    //   demo: shortUrl
    // })  
  } else {
    res.json({error: "No short URL found for the given input"})
  }
}

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function(req, res) {
  res.json({ greeting: 'hello API' });
});

app.get('/api/shorturl/:short_url', function(req, res) {
  const shortUrl = +req.params.short_url
  if (shortUrl) {
    findUrlByOriginalShortUrl(shortUrl, res)
    // res.json({
    //   demo: shortUrl
    // })
  } else {
    res.json({error: "No short URL found for the given input"})
  }
  // if

  // else


  
});

app.post('/api/shorturl', function(req, res) {
  // console.log(req.query)
  // console.log(req.params)
  // console.log(req.body.url)
  const url = req.body.url
  let domen = 'abracadabra'
  const arr = url.split("/")
  // console.log("arr", arr, url)
  if (arr.length >= 3) {
    domen = arr[2]
    const protocol = arr[0]
    if (protocol === "http:" || protocol === "https:" ) {
      // console.log("domen", domen)
      dns.lookup(domen, (err, address, family) => {
        if (err) {
          res.json({"error": "Invalid URL"})
        }
        findUrlByOriginalUrl(url, res)
      });
    } else {
      res.json({"error": "Invalid URL"})
    }
  } else {
    res.json({"error": "Invalid URL"})
  }
});


app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});