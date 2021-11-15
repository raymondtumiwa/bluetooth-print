const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

const db = require("./app/models");
const Role = db.role;
global.__basedir = __dirname;


db.sequelize.sync().then(() => {
db.sequelize.sync({force: true}).then(() => {
   console.log('Drop and Resyncssss Db');
   initial()
});
});


app.use(cors());

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// simple route
app.get("/", (req, res) => {
  //console.log(req)
  res.json({ message: "HALO." });
});

require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);
require('./app/routes/ki_od.routes')(app);


// set port, listen for requests
const PORT = process.env.PORT || 3080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
