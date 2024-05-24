const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()

const mongoose = require('mongoose');
mongoose.connect(process.env.MONGO_URI);

const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


app.use(cors())
app.use(express.static('public'))
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

const taskSchema = new mongoose.Schema({
  description: { type: String, required: true },
  duration: { type: Number, required: true },
  date: { type: Date, required: true, default: Date.now }
})
const userSchema = new mongoose.Schema({
  username: { type: String, required: true },
  log: [taskSchema]
});
const User = mongoose.model("User", userSchema);

const findUsers = async (res) => {
  const users = await User.find({}).select({"username": 1, });
  // console.log(users)
  res.json(users)  
};


// app.get("/api/demo", (req, res) => {
//   findUsers(res)

//   // res.json({
//   //   demo: "demo"
//   // })
// })

app.post("/api/users", (req, res) => {
  console.log("=> POST /api/users")
  const user = new User({
    username: req.body.username,
    // count: 1,
    log: []
  })
  user.save()
  
  res.json({
      "username": user.username,
      "_id": user._id
  })
})

app.get("/api/users", (req, res) => {
  console.log("=> /api/users")
  findUsers(res)
  // [{"_id":"61204ee9f5860e05a3652f11","username":"fcc_test_16295073016","__v":0},{"_id":"61206b40f5860e05a3652f21","username":"tejpaulsingh","__v":0},{"_id":"6120737df5860e05a3652f23","username":"hitesh","__v":0},{"_id":"6120ae24f5860e05a3652f32","username":"asd","__v":0}]
})

const addTask = async (res, id, description, duration, date) => {
  try {
    // TODO: continue
    const user = await User.findOne({_id: id});
    user.log.push({
      description: description,
      duration: +duration,
      date: date
    })
    // console.log(user)
    user.save()

    res.json({
      _id: id,
      username: user.username,
      date: date.toDateString(),
      duration: +duration,
      description: description
    })
  } catch (e) {
    res.json({
      error: e
    })
  }
};


app.post("/api/users/:id/exercises", (req, res) => {
  console.log("=> POST /api/users/:id/exercises")
  const id = req.params.id
  const {description, duration, date} = req.body
  console.log("date", date)
  let newDate = new Date(date)
  if (newDate == "Invalid Date") {
    newDate = new Date()
  }
  console.log("newDate", newDate)
  addTask(res, id, description, duration, newDate)
  
})

const aboutUser = (user, query) => {
  const log = []
  let count = 0
  for (const elem of user.log) {
    // console.log("* from", query.from, "elem.data", elem.date, query.from <= elem.date)
    if ((query.from !== undefined || query.from != 'Invalid Date') && query.from > elem.date) {
      continue
    }
    if ((query.to !== undefined || query.to != 'Invalid Date') && query.to < elem.date) {
      continue
    }

    log.push({
      description: elem.description,
      duration: elem.duration,
      date: elem.date.toDateString(),
    })
    count++
    if (query.limit === count) {
      break      
    }
    // console.log("elem", elem)
  }
  return {
      _id: user.id,
      username: user.username,
      count: count,
      log: log
  }
}

const findUser = async (res, id, query) => {
  const user = await User.findOne({_id: id})
  // console.log(user)
  res.json(aboutUser(user, query))
};

app.get("/api/users/:id/logs", (req, res) => {
  console.log("=> /api/users/:id/logs")
  console.log("req.query", req.query)
  const query = {}
  for (key of ["from", "to"]) {
    const value = req.query[key]
    if (value) {
      query[key] = new Date(value)
    }
  } 
  if (req.query["limit"]) {
    query["limit"] = +req.query["limit"]
  }
  // console.log("query", query)
  findUser(res, req.params.id, query)
})

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})

