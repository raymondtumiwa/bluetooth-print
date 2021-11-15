const db = require("../models");
const config = require("../config/auth.config");
const Op = db.Sequelize.Op;
const AccessMenu = db.accessmenu;
const User = db.user;
const Role = db.role
const Waybill = db.waybill
const UserDetails = db.userDetails
const Area = db.area
const LargeArea = db.large_area
const fs = require("fs")
const path = require("path")
const sequelize = db.sequelize



exports.allAccess = (req, res) => {
    res.status(200).send("Public Content.");
  };
  
  exports.userBoard = (req, res) => {
    res.status(200).send("User Content.");
  };
  
  exports.adminBoard = (req, res) => {
    res.status(200).send("Admin Content.");
  };
  
  exports.moderatorBoard = (req, res) => {
    res.status(200).send("Moderator Content.");
  };

  exports.user = async (req, res) => {
    var body = req.body
  
    try {
      var result = await Employee.findOne({
        where: {
          username: req.body.username,
        },
        include: [  
          {
            model: User,
            as: 'user_detail'
          }
        ]
      })
      // var result2 = await User.findOne({
      //   where: {
      //     username: req.body.username,
      //   }
      // })
      // var link = "http://localhost:3001/api/profile/icon/"

      // var link = "https://demoapi.smekbm.com/api/profile/icon/"
      // if(result.photo_url == null ||result.photo_url == ""){
      //   result.photo_url = link+"default.png"
      // }else{
      //   result.photo_url = link+result.photo_url
      // }
      // console.log(result)
      if (result) {
        res.send({
          username: result.username,
          email: result.user_detail.email,
          employeeCode: result.employee_code,
          employeeName: result.employee_name,
          // employeeArea: result.area,
          employeePosition: result.position,
          employeeMobile: result.mobile,
          employeeAddress: result.address,
          employeeStatus: result.status,
          updatedAt: result.updatedAt,
          // photoUrl: result.photo_url
        })
      } else {
        res.status(400).send(error)
      }
  
    }
    catch (error) {
      console.log(error)
      res.status(500).send(error)
    }
  }
  exports.rewriteFCM = async (req, res) => {
    var body = req.body
    try {
      var shoot1 = await Employee.update({
        fcm: body.fcm
      }, {
        where: {
          username: body.username,
        }
      })
      if (shoot1) {
        res.send({
          message: "Success",
          success: true
        })
      } else {
        res.send({
          message: "Failed",
          success: false
        })
      }
  
    }
    catch (error) {
      console.log(error)
      res.send({
        message: error.message,
        success: false
      })
    }
  }
  exports.AM = async (req, res) => {
    let body = req.body
    try {
      var user = await User.findOne({
        where: {
          username: body.username
        }
      })
      var getAM = await Role.findOne({
        where: {
          role_code: user.dataValues.role
        }
      })
      var split = getAM.access_menu.toString().split(",")
      var baseAM = await AccessMenu.findAll()
      var parentAM = []
      var realAM = []
      baseAM.forEach(element => {
        if (split.includes(element.id.toString())) {
  
          var jvekoo = {
            id: element.id,
            state: element.state,
            name: element.name,
            type: element.type,
            icon: element.icon,
            children: element.children
          }
          // console.log(element.children)
          if (element.children == null || element.children == "") {
            parentAM.push(element.children)
          }
          realAM.push(jvekoo)
          //i = 1 + i
        }
      });
      var sorted = {};
      var secondhands = [];
      realAM.forEach((element, index) => {
        //console.log(element.id)
        secondhands[realAM[index].id] = realAM[index]
      })
      realAM = []
      // console.log(secondhands)
      secondhands.forEach(category => {
        // console.log(category)
        if (category.children == null || category.children == "") {
          const filteredVal = {
            id: category.id,
            state: category.state,
            name: category.name,
            type: category.type,
            icon: category.icon,
            children: {}
          }
          // console.log(filteredVal)
          sorted[category.id] = filteredVal
        }
        else {
          var index = category.children
          const filteredVal = {
            id: category.id,
            state: category.state,
            name: category.name,
            type: category.type,
            icon: category.icon,
            children: category.children
          }
  
          sorted[index].children[category.id] = filteredVal
        }
        // console.log(sorted)
      })
      return res.send(sorted)
    }
    catch (error) {
      // console.log(error);
      return res.send(`${error}`);
    }
  }
  exports.infoApp = (req, res) => {
    const directoryPath = __basedir + "/resources/static/app_info.json"
    var text = fs.readFileSync(directoryPath, 'utf8')
    var jsonParsing = JSON.parse(text)
    res.send(jsonParsing)
  };
  exports.accessmenu = (req, res) => {
    AccessMenu.findAll()
      .then(accessmenu => {
        res.json(accessmenu)
      })
      .catch(err => {
        res.status(500).send({
          message: err.message
        });
      });
  
  }