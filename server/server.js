const express = require("express");
const bodyParser = require("body-parser");
const cors = require ("cors");


// const api = require('./routes/api')
const app = express();
const db = require("./app/models");


app.use(cors());
const Role = db.role

global.__basedir = __dirname;

// db.sequelize.sync();
// db.sequelize.sync().then(() => {
//     db.sequelize.sync({ force: true }).then(() => {
//         console.log('Drop and Resyncssss Db');
//         // initial()
//     });
// });
// function initial() {
//     Role.create({
//       id: 1,
//       role_name: "user"
//     });
   
//     Role.create({
//       id: 2,
//       role_name: "moderator"
//     });
   
//     Role.create({
//       id: 3,
//       role_name: "admin"
//     });
//   }

app.use(bodyParser.json())

app.use(bodyParser.urlencoded({extended: true}));


app.get("/", (req, res) => {
    res.json({ message: "Welcome WELCOME"});
});


// routes
require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log('server running on localhost: ' + PORT)
});