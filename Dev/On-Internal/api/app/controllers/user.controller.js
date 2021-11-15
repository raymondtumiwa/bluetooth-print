const db = require("../models");
const config = require("../config/auth.config");
const { user, role, trackwaybill, waybill } = require("../models");
const accessmenu = db.accessmenu;
const User = db.user;
const Role = db.role
const Waybill = db.waybill
const UserDetails = db.userDetails
const TrackWaybill = db.trackwaybill

exports.allAccess = (req, res) => {
  res.status(200).send("Public Content.");
};

exports.userBoard = (req, res) => {
  res.status(200).send("User Content.");
};

exports.adminBoard = (req, res) => {
  res.status(200).send("Admin Content.");
};

exports.user = (req, res) => {
  UserDetails.findOne({
    where: {
      username: req.body.username
    }
  }).then(details => {
    res.status(200).send({
      phone: details.phone,
      agent_id: details.agent_id,
      location: details.location
    })
  })
}
/*
exports.AM = (req, res) => {
  User.findOne({
    where: {
      username: req.body.username
    }
  }).then(user => {
    if (user) {
      user.getRoles().then(roles => {
        var realAM = []
        var str = roles[0].accessMenu
        var indexAM = str.split(",")
        var i = 0
        // console.log(res)?
        accessmenu.findAll().then(accessmenus => {
          accessmenus.forEach(element => {
            var indexMenu = element.id == indexAM[i];
            if (indexMenu) {
              menuSent = {
                state: element.state,
                name: element.name,
                type: element.type,
                icon: element.icon,
                children: {}
              }
              if (element.children != null) {
                menuSent.children = {
                  state: element.state,
                  name: element.name,
                  type: element.type,
                }
              }
              console.log(menuSent)
              realAM.push(menuSent)
              i = 1 + i
            }
          });
          //console.log(realAM)
          //console.log(realAM2)
          res.status(200).send(
            realAM
          )
          return
        })

      })
    }
  })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });
};
*/

exports.accessMenu = (req, res) => {
  User.findOne({
    where: {
      username: req.body.username
    }
  }).then(user => {
    if (user) {
      user.getRoles().then(roles => {
        var realAM = []
        var str = roles[0].accessMenu
        var indexAM = str.split(",")
        var i = 0
        // console.log(res)?
        accessmenu.findAll().then(accessmenus => {
          accessmenus.forEach(element => {
            if (element.id == indexAM[i]) {
              var menuSent = {
                state: element.state,
                name: element.name,
                type: element.type,
                icon: element.icon,
                children: element.children,
              }
              //console.log(menuSent.children)
              realAM.push(menuSent)
              i = 1 + i
            }
          });
          console.log(realAM)
          res.status(200).send(
            realAM
          )
          return
        })
      })
    }
  })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });
};

exports.accessmenu = (req, res) => {
  accessmenu.findAll()
    .then(accessmenu => {
      res.json(accessmenu)
    })
    .catch(err => {
      res.status(500).send({ message: err.message });
    });

}

/*
exports.createWaybill = (req, res) => {
  Waybill.create({
    waybill_number: req.body.waybill_number,
    sender_name: req.body.sender_name,
    sender_phone: req.body.sender_phone,
    sender_origin: req.body.location,
    recipient_name: req.body.recipient_name,
    recipient_phone: req.body.recipient_phone,
    recipient_address: req.body.recipient_address,
    recipient_address_subdistrict: req.body.recipient_address_subdistrict,
    recipient_address_district: req.body.recipient_address_district,
    recipient_address_city: req.body.recipient_address_city,
    recipient_address_province: req.body.recipient_address_province,
    status: "UNFINISH"
  })
  TrackWaybill.create({
    waybill_number: req.body.waybill_number,
    signer: req.body.agent_id,
    location: req.body.location,
    phone: req.body.phone
  })
    .then(waybill => {
      res.status(200).send({
        message: "Correct"
      }
      )
    })
}


exports.searchWaybill = (req, res) => {
  console.log(req.body.waybill_number)
  Waybill.findOne({
    where: {
      waybill_number: req.body.waybill_number
    }
  })
    .then(waybill => {
      res.status(200).send([{
        waybill_number: waybill.waybill_number,
        sender_name: waybill.sender_name,
        sender_phone: waybill.sender_phone,
        recipient_name: waybill.recipient_name,
        recipient_phone: waybill.recipient_phone,
        recipient_address: waybill.recipient_address,
        recipient_address_subdistrict: waybill.recipient_address_subdistrict,
        recipient_address_district: waybill.recipient_address_district,
        recipient_address_city: waybill.recipient_address_city,
        recipient_address_province: waybill.recipient_address_province
      }])
    })
}

exports.updateWaybill = (req, res) => {
  Waybill.update({
    waybill_number: req.body.waybill_number,
    sender_name: req.body.sender_name,
    sender_phone: req.body.sender_phone,
    recipient_name: req.body.recipient_name,
    recipient_phone: req.body.recipient_phone,
    recipient_address: req.body.recipient_address,
    recipient_address_subdistrict: req.body.recipient_address_subdistrict,
    recipient_address_district: req.body.recipient_address_district,
    recipient_address_city: req.body.recipient_address_city,
    recipient_address_province: req.body.recipient_address_province
  },
    {
      where: {
        waybill_number: req.body.waybill_number
      }
    })
    .then(waybill => {
      res.status(200).send({
        message: "berhasil"
      }
      )
    })
}

exports.trackWaybill = (req, res) => {
  TrackWaybill.findOne({
    where: {
      waybill_number: req.body.waybill_number
    }
  })
    .then(waybill1 => {
      Waybill.findOne({
        where: {
          waybill_number: req.body.waybill_number
        }
      }).then(waybill2 => {
        res.status(200).send([{
          waybill_number: waybill2.waybill_number,
          inbound: waybill2.sender_origin,
          status: waybill2.status,
          outbound: waybill2.recipient_address_province,
          signer: waybill1.signer,
          location: waybill1.location,
          timestamp: waybill1.timestamp
        }])
      })

    })
}
*/
