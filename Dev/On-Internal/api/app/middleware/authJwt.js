const jwt = require("jsonwebtoken");
const config = require("../config/auth.config.js");
const { accessmenu } = require("../models");
const db = require("../models");
const User = db.user;

verifyToken = (req, res, next) => {1
  let token = req.headers['x-access-token'] || req.headers['authorization'];
  // if (token.startsWith('Bearer ')) {
  //   // Remove Bearer from string
  //   token = token.slice(7, token.length);
  // }
  console.log(req.headers);
  console.log("tokenz " + token)
  if (!token) {
    return res.status(403).send({
      message: "No token provided!"
    });
  }

  jwt.verify(token, config.secret, (err, decoded) => {
    if (err) {
      return res.status(401).send({
        message: "token invalid"
      });
    }
    req.userId = decoded.id;
    next();
  });
};

isAdmin = (req, res, next) => {
  User.findByPk(req.userId).then(user => {
    user.getRoles().then(roles => {
      for (let i = 0; i < roles.length; i++) {
        if (roles[i].name === "admin") {
          next();
          return;
        }
      }

      res.status(403).send({
        message: "Require Admin Role!"
      });
      return;
    });
  });
};

isModerator = (req, res, next) => {
  User.findByPk(req.userId).then(user => {
    user.getRoles().then(roles => {
      for (let i = 0; i < roles.length; i++) {
        if (roles[i].name === "moderator") {
          next();
          return;
        }
      }

      res.status(403).send({
        message: "Require Moderator Role!"
      });
    });
  });
};

isModeratorOrAdminOrUser = (req, res, next) => {
  User.findByPk(req.userId).then(user => {
    user.getRoles().then(roles => {
      for (let i = 0; i < roles.length; i++) {
        if (roles[i].name === "moderator") {
          // accessmenu.findAll()
          // .then(accessmenu => {
          //   console.log(res.json(accessmenu))
          // })
          next();
          return;
        }

        if (roles[i].name === "admin") {
          // res.send("TEssss")
          next();
          return;
        }
        if (roles[i].name === "user") {
          next();
          return;
        }
      }

      res.status(403).send({
        message: "Require Moderator or Admin Role!"
      });
    });
  });
};

const authJwt = {
  verifyToken: verifyToken,
  isAdmin: isAdmin,
  isModerator: isModerator,
  isModeratorOrAdminOrUser: isModeratorOrAdminOrUser
};

module.exports = authJwt;