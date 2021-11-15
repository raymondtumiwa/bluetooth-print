const jwt = require("jsonwebtoken");
const config = require("../config/auth.config.js");
const db = require("../models");
const User = db.user;


verifyToken = async (req, res, next) => {
  let token = req.headers["x-access-token"] || req.headers["authorization"];
  if (!token) {
    return res.status(403).send({
      message: "No token provided!"
    });
  }
  var username = ""
  var isNative
  if (token.startsWith('Bearer ')) {
    // Remove Bearer from string
    token = token.slice(7, token.length);
  }
  var username;
  var isError = false
  jwt.verify(token, config.secret, (err, decoded) => {
    if (err) {
      return isError = !isError
    }
    username = decoded.username
    isNative = decoded.isNative
  });
  if (isError) {
    return res.status(401).send({
      message: "Token Invalid!"
    });
  }

  const user = await User.findOne({
    where: {
      username: username
    }
  })
  if (isNative) {
    if (user.login_token.native != token) {
      return res.status(401).send({
        message: "Token Invalid!"
      });
    } else {
      next();
    }
  } else {
    if (user.login_token.web != token) {
      return res.status(401).send({
        message: "Token Invalid!"
      });
    } else {
      next();
    }
  }
};

// verifyToken = (req, res, next) => {
//   let token = req.headers["x-access-token"];

//   if (!token) {
//     return res.status(403).send({
//       message: "No token provided!"
//     });
//   }

//   jwt.verify(token, config.secret, (err, decoded) => {
//     if (err) {
//       return res.status(401).send({
//         message: "Unauthorized!"
//       });
//     }
//     req.userId = decoded.id;
//     next();
//   });
// };

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

isModeratorOrAdmin = (req, res, next) => {
  User.findByPk(req.userId).then(user => {
    user.getRoles().then(roles => {
      for (let i = 0; i < roles.length; i++) {
        if (roles[i].name === "moderator") {
          next();
          return;
        }

        if (roles[i].name === "admin") {
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
  isModeratorOrAdmin: isModeratorOrAdmin
};
module.exports = authJwt;