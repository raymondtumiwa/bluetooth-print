const db = require("../models");
const ROLES = db.role;
const User = db.user;

checkDuplicateUsernameOrEmail = (req, res, next)  => {
    User.findOne({
        where: {
            username: req.body.username
        }
    }).then(user => {
        if (user) {
            res.status(400).send({
                message:"Failed, dy in use!"
            });
            return;
        }

        User.findOne({  
            where: {
                email:req.body.email
            }
        }).then(user => {
            if(user){
                res.status(400).send({
                    message:"Failed! Email is already in use"
                });
                return;
            }

            next();
        });
    });
};
checkDuplicateUsernameOrEmailEmployee = (req, res, next) => {
    // Username
    console.log(req.body)
    var tempNum = req.body.employeeCode
    var checkNumber = tempNum.toString().replace(/[^\d.-]/g, '')
    console.log(checkNumber)
    User.findOne({
      where: {
        email: req.body.email
      }
    }).then(users => {
      if (users) {
        res.send({
          message: "Failed! Email is already in use!",
          success: false
        });
        return;
      }
      if (req.body.mobile.toString().charAt(0) == "0") {
        var tempMob = req.body.mobile.toString().substring(1);
      } else {
        var tempMob = req.body.mobile.toString()
      }
      var prefixMobile = "+62"
      var mobile = prefixMobile.concat(tempMob)
      Employee.findOne({
        where: {
          mobile: mobile
        }
      }).then(userss => {
        if (userss) {
          res.send({
            message: "Failed! Mobile is already in use!",
            success: false
          })
          return
        }
        if (checkNumber == "" || checkNumber == null) {
          console.log("a")
          next()
        } else {
          console.log("b")
          Employee.findOne({
            where: {
              employee_code: req.body.employeeCode
            }
          }).then(usersss => {
            if (usersss) {
              res.send({
                message: "Failed! Employee Code is already in use!",
                success: false
              })
              return
            }
            next()
          })
  
        }
      })
    });
    // });
  };


checkRolesExisted = (req, res, next) => {
    if (req.body.role) {
        for (let i=0; i<req.body.role.length; i++) {
            if(!ROLES.includes(req.body.roles[i])){
                res.status(400).send({
                    message: "Failed! Role does no exist = " + req.body.role[i]
                });
                return;
            }
        }
    }
    next();
};

const verifySignUp = {
    checkDuplicateUsernameOrEmail: checkDuplicateUsernameOrEmail,
    checkRolesExisted: checkRolesExisted,
    checkDuplicateUsernameOrEmailEmployee: checkDuplicateUsernameOrEmailEmployee
};

module.exports = verifySignUp;