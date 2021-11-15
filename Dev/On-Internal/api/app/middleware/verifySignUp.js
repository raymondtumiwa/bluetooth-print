const db = require("../models");
const User = db.user;
const Waybill = db.waybill;

checkDuplicateUsernameOrEmail = (req, res, next) => {
  // Username
  console.log(req.body)
  User.findOne({
    where: {
      username: req.body.username
    }
  }).then(user => {
    if (user) {
      res.status(400).send({
        message: "Failed! Username is already in use!"
      });
      return;
    }

    // Email
    User.findOne({
      where: {
        email: req.body.email
      }
    }).then(user => {
      if (user) {
        res.status(400).send({
          message: "Failed! Email is already in use!"
        });
        return;
      }

      next();
    });
  });
};

checkCreateWaybill= (req, res, next) => {
  Waybill.findOne({
    waybill_number: req.body.waybill_number
  })
  next();
}

const verifySignUp = {
  checkDuplicateUsernameOrEmail: checkDuplicateUsernameOrEmail,
  checkCreateWaybill:checkCreateWaybill 
};

module.exports = verifySignUp;