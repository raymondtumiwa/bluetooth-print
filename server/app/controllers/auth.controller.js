const db = require("../models");
const config = require("../config/auth.config");
const User = db.user;
const Role = db.role;

const Employee = db.employee
const Op = db.Sequelize.Op;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

function checkTime(i) {
  if (i < 10) { i = "0" + i };  // add zero in front of numbers < 10
  return i;
}
// async function timestampFull() {
//   var time = new Date()
//   var ct1 = checkTime(time.getFullYear()) + "/" + checkTime((time.getMonth() + 1)) + "/" + checkTime(time.getDay())
//   var ct2 = checkTime(time.getHours()) + ":" + checkTime(time.getMinutes()) + ":" + checkTime(time.getSeconds())
//   return ct1 + "  " + ct2
// }

exports.signup = async (req, res) => {
  let body = req.body
  try {
    await User.create({
      username: body.username,
      password: bcrypt.hashSync(req.body.password, 8),
      email: body.email,
      role: body.role,
      login_token: {"web":"","native":""}
    })

    await Employee.create({
      username: body.username,
      employee_code: body.employee_code,
      employee_name: body.employee_name,
      role: body.role,
      area: body.area,
      password: body.password,
      mobile: body.mobile,
      address: body.address,
      status: body.status,
      

      // username: body.username,
      // employee_name: body.employee_name,
      // jenis_kelamin: body.jenis_kelamin,
      // tanggal_lahir:  body.tanggal_lahir,
      // tempat_lahir: body.tempat_lahir,
      // alamat_ktp: body.alamat_ktp,
      // alamat_domisili: body.alamat_domisili,
      // nomor_ktp: body.nomor_ktp,
      // nomor_npwp: body.nomor_npwp,
      // jenis_sim: body.jenis_sim,
      // status_pernikahan: body.status_pernikahan,
      // jumlah_anak: body.jumlah_anak,
      // no_wa: body.no_wa,
      // no_hp: body.no_hp,
      // nama_bank: body.nama_bank,
      // no_rekening: body.no_rekening,
      // nama_rekening: body.nama_rekening,
      // jabatan: body.jabatan
    })
    return res.status(200).send({
      message: "User was registered successfully!"
    })  
  }
  catch (error) {
    console.log(error);
    return res.send(error);
  }
};



exports.signin = async (req, res) => {
  let body = req.body
  var result = await User.findOne({
    where: {
      username: req.body.username
    }
  })
  if (!result) {
    return res.status(404).send({ message: "User Not found." });
  }
  
  var passwordIsValid = bcrypt.compareSync(
    req.body.password,
    result.password
  );

  if (!passwordIsValid) {
    return res.status(401).send({
      accessToken: null,
      message: "Invalid Password!"
    });
  }

  var tempEmploye = await Employee.findOne({
    where: {
      username: req.body.username
    }
  })

  var roles = ""
  switch (result.role) {
    case "administrator_hq": {
      roles = "Administrator HQ"
      break;
    }
    case "hq_admin": {
      roles = "HQ Admin"
      break;
    }
    case "area_admin": {
      roles = "Area Admin (Branding)"
      break;
    }
    case "area_manager": {
      roles = "Area Manager"
      break;
    }
    case "sales": {
      roles = "Sales"
      break;
    }
  }

  if (tempEmploye.status == "Disable") {
    res.status(400).send({
      message: "Maaf Akun anda saat ini Disable"
    })
  }
  console.log("AAAAAAAA")
  console.log(result.login_token)
  if(body.isNative == true){
    token = jwt.sign({ username: result.username, isNative: true }, config.secret, {});
    result.login_token.native = token
    console.log(token)
  }else{
    token = jwt.sign({ username: result.username, isNative: false }, config.secret, {
      expiresIn: '1h'  // 24 hours
    });
    result.login_token.web = token
  }

  await User.update({
    login_token: result.login_token
  }, {
    where: {
      username: req.body.username
    }
  })

  var result2 = await Employee.findOne({
    where: {
      username: req.body.username,
    }
  })
  
  var status = result2.status.toString().toLowerCase()
  if (status == "disable") {
    res.send({
      message: "Maaf Akun anda saat ini Disable",
      success: false
    })
  }
  // var link = "http://localhost:3001/api/profile/icon/"
  // var link = "https://demoapi.smekbm.com/api/profile/icon/"
  //   if(result2.photo_url == null ||result.photo_url == ""){
  //     result2.photo_url = link+"default.png"
  //   }else{
  //     result2.photo_url = link+result.photo_url
  //   }
  // console.log(result2)
  res.status(200).send({
    id: result.id,
    username: result.username,
    roles: result.role,
    roleName: roles,
    accessToken: token,
    success: true,
    email: result2.email,
    employeeCode: result2.employee_code,
    employeePosition: result2.position,
    employeeName: result2.employee_name,
    employeeArea: result2.area,
    employeeMobile: result2.mobile,
    employeeAddress: result2.address,
    employeeStatus: result2.status,
    // photoUrl:result2.photo_url,
    updatedAt: result2.updatedAt,
  });
  
};

// exports.signup = (req, res) => {
//   // Save User to Database
//   User.create({
//     username: req.body.username,
//     email: req.body.email,
//     password: bcrypt.hashSync(req.body.password, 8)
//   })
//     .then(user => {
//       if (req.body.roles) {
//         Role.findAll({
//           where: {
//             role_name: {
//               [Op.or]: req.body.roles
//             }
//           }
//         }).then(roles => {
//           user.setRoles(roles).then(() => {
//             res.send({ message: "User was registered successfully!" });
//           });
//         });
//       } else {
//         // user role = 1
//         user.setRoles([1]).then(() => {
//           res.send({ message: "User was registered successfully!" });
//         });
//       }
//     })
//     .catch(err => {
//       res.status(500).send({ message: err.message });
//     });
// };

// exports.signin = (req, res) => {
//   User.findOne({
//     where: {
//       username: req.body.username
//     }
//   })
//     .then(user => {
//       if (!user) {
//         return res.status(404).send({ message: "User Not found." });
//       }

//       var passwordIsValid = bcrypt.compareSync(
//         req.body.password,
//         user.password
//       );

//       if (!passwordIsValid) {
//         return res.status(401).send({
//           accessToken: null,
//           message: "Invalid Password!"
//         });
//       }

//       var token = jwt.sign({ id: user.id }, config.secret, {
//         expiresIn: 86400 // 24 hours
//       });

//       var authorities = [];
//       user.getRoles().then(roles => {
//         for (let i = 0; i < roles.length; i++) {
//           authorities.push("ROLE_" + roles[i].role_name.toUpperCase());
//         }
//         res.status(200).send({
//           id: user.id,
//           username: user.username,
//           email: user.email,
//           roles: authorities,
//           accessToken: token
//         });
//       });
//     })
//     .catch(err => {
//       res.status(500).send({ message: err.message });
//     });
// };

// exports.verify = (req, res) => {
//   return res.status(200).send({ message: "success" })
// };
