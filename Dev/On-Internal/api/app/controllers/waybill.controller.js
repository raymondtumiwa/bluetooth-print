const db = require("../models");
const Waybill = db.waybill
const UserDetails = db.userDetails
const TrackWaybill = db.trackwaybill
const newWaybillKi = db.newwaybill_ki
const indomaretLocationRef = db.indomaretLocationRef
const { Op } = require("sequelize");
const axios = require("axios")
const multer = require("multer");
const fs = require('fs');
const uploadFile = require("../middleware/upload");
const https = require('https')
const dateFormat = require('dateformat');
//require('request').defaults({ rejectUnauthorized: false })
const MaterialReference = db.material_reference

function fcmNotifier() {
    console.log("fcm start")
    //console.log(req.body)
    console.log("fcm finish")
    var respp;
    //console.log(req.body)
    UserDetails.findAll({
        where: {
            fcm_enabler: "1",
        }

    }).then(users => {
        //nameUser = users.name
        //phoneUser = users.phone
        //console.log(users)
        users.forEach(userfcm => {
            console.log(userfcm.agent_id)
            var param = {
                "notification": {
                    "title": "Ada Pesanan Baru",
                    "body": "Mohon cek app anda"
                },

                "data": {
                    "name": "Pesanan",
                    "age": "22",

                },
                "to": userfcm.agent_id
            }
            axios.post('https://fcm.googleapis.com/fcm/send', param, {
                headers: {
                    'Authorization': 'Bearer AAAA0RIushM:APA91bHzQA63uQE3-DogsPesBc3AiHsxcD_vTC1vMVQxWP8hwzz5enKUgyrg_mhMM4tbG5Tn1MiMVm452SemMP31AXsKvAfFLZj9B4Ub85aFG5MN_L-MMNZ0RUjjpyEr3Gnpa5o3s0HY'
                }
            })

                .then((res) => {
                    respp = res
                    //console.log(res)
                })


        })
        /*
        res.status(200).send({
            message: respp
        })
        */
        //res.status(200)



    })

}

function checkTariffs(latlongOrigins, latlongDest, callback) {
    /*
    axios.get('https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=-6.196228055559931,106.75516237281191&destinations=-6.196114,106.761591&key=AIzaSyDA2Kjc0wnLONRqMnois3qU2CiEmy84fw4').then((res) => {
        console.log(res)
    })
    */
    try {
        axios.get('https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=' + latlongOrigins + '&destinations=' + latlongDest + '&key=AIzaSyDA2Kjc0wnLONRqMnois3qU2CiEmy84fw4').then((resp) => {
            console.log(resp.data.rows[0].elements[0].distance.value)
            return callback(null, resp.data.rows[0].elements[0].distance.value)
        }).catch(err => {
            return callback(new Error(err));
        })
    }
    catch (err) {
        return callback(new Error(err));
    }
}

function kiPostReq(awbNum, trackStatus, courierName, courierPhone) {

    newWaybillKi.findOne({
        where: {
            waybill_number: awbNum
        }
    }).then(waybill => {
        //console.log(waybill)
        /*
        const instance = axios.create({
            httpsAgent: new https.Agent({  
              rejectUnauthorized: false
            })
          });
          //instance.get('https://103.116.234.8:6997');
          */
        // At request level

        var params = {
            "username": "cbrosheline",
            "password": "7C6646A51CD7C00F684FE27921F1046E",
            "waybill_number": waybill.waybill_number,
            "track_status": trackStatus,
            "track_time": dateFormat(Date.now(), "yyyy-mm-dd HH:MM:ss"),
            "courier_name": courierName,
            "courier_phone": courierPhone,
            "receiver_name": waybill.recipient_name,
            "image_url": waybill.image
        }

        //axios.post('https://103.116.234.8:6997/ServiceCallbackTracking.asmx/Rosheline', params, { httpsAgent: agent }).then((res) => {
        axios.post('http://103.116.234.8:6997/ServiceCallbackTracking.asmx/Rosheline', params).then((res) => {
            console.log(res)
        })
        //console.log(resp.data)
    })
}

function fcmNotif(waybillArr, trackStatus, courierName, courierPhone) {

    newWaybillKi.findOne({
        where: {
            waybill_number: awbNum
        }
    }).then(waybill => {
        console.log(waybill)
        var params = {
            "username": "cbrosheline",
            "password": "callbackrosheline",
            "waybill_number": waybill.waybill_number,
            "track_status": trackStatus,
            "track_time": dateFormat(waybill.updatedAt, "yyyy-mm-dd hh:MM:ss"),
            "courier_name": courierName,
            "courier_phone": courierPhone,
            "receiver_name": waybill.recipient_name,
            "image_url": waybill.image
        }

        axios.post('https://ondelivery.id/api/ipdumdum', params)
        //console.log(resp.data)
    })
}

exports.createWaybill = (req, res) => {
    //console.log(req)
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
        status: "neworder"
    }).then(res => {
        console.log(res)
    }).catch(err => {
        res.status(500).send({ message: "error" });;
    })
    /*
        TrackWaybill.create({
        waybill_number: req.body.waybill_number,
        signer: req.body.agent_id,
        location: req.body.location,
        phone: req.body.phone
    })
        .then(waybill => {
            res.status(200).send({
                message: "Correct"
            })
        }).catch(err => {
            res.status(500).send({ message: "error" });
        });
        */
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
        }).catch(err => {
            res.status(500).send({ message: "request error" });
        });
}

exports.updateWaybill = (req, res) => {
    newWaybillKi.update({
        waybill_number: req.body.waybill_number,
        sender_name: req.body.sender_name,
        sender_phone: req.body.sender_phone,
        indomaret_id: req.body.indomaret_id,
        recipient_name: req.body.recipient_name,
        recipient_phone: req.body.recipient_phone,
        recipient_address: req.body.recipient_address,
        recipient_lat: req.body.recipient_lat,
        recipient_long: req.body.recipient_long,
        order_time: req.body.order_time,
        volume: req.body.volume,
        weight: req.body.weight,
        area: req.body.area,
        image: req.body.image,
    },
        {
            where: {
                [Op.and]: {
                    waybill_number: req.body.waybill_number,
                    status: 'neworder'
                }

            }
        })
        .then(waybill => {
            console.log("waybill start")
            console.log(waybill)
            console.log("waybill finish")
            if (waybill[0] == 0) {
                res.status(500).send({
                    message: "failed"
                })
            } else {
                res.status(200).send({
                    message: "success"
                })
            }

        }).catch(err => {
            res.status(500).send({ message: "request error" });
        });
}





exports.confirmWaybill = (req, res) => {
    var nameUser
    var phoneUser
    UserDetails.findOne({
        where: {
            username: req.body.userid,
        }

    }).then(users => {
        nameUser = users.name
        phoneUser = users.phone
        newWaybillKi.update({
            status: "finished " + nameUser,
            image: "https://ondelivery.id/api/ki/images/" + req.body.waybill_number + ".png"
        },
            {
                where: {
                    [Op.and]: {
                        waybill_number: req.body.waybill_number,
                        status: req.body.userid
                    }

                }
            })
            .then(waybill => {
                console.log("waybill start")
                console.log(waybill)
                console.log("waybill finish")
                if (waybill[0] == 0) {
                    res.status(500).send({
                        message: "failed"
                    })
                } else {
                    kiPostReq(req.body.waybill_number, "TERIMA", nameUser, phoneUser)
                    res.status(200).send({
                        message: "success"
                    })
                }

            }).catch(err => {
                res.status(500).send({ message: "request error" });
            });
    })
    //console.log(req.body.userid)
    //console.log(req.body.waybill_number)


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


exports.findNewWaybillKi = (req, res) => {
    if (req.body.hasOwnProperty('subdistrict')) {
        if (req.body.subdistrict != "all") {
            newWaybillKi.findAll({
                where: {
                    [Op.and]: {
                        subdistrict: req.body.subdistrict,
                        status: req.body.status
                    }
                }
            })
                .then(waybillX => {
                    var tempData = []
                    waybillX.forEach(waybill1 => {
                        var tempDataEach = {
                            waybill_number: waybill1.waybill_number,
                            sender_name: waybill1.sender_name,
                            sender_phone: waybill1.sender_phone,
                            indomaret_id: waybill1.indomaret_id,
                            recipient_name: waybill1.recipient_name,
                            recipient_phone: waybill1.recipient_phone,
                            recipient_address: waybill1.recipient_address,
                            recipient_lat: waybill1.recipient_lat,
                            recipient_long: waybill1.recipient_long,
                            order_time: waybill1.order_time,
                            volume: waybill1.volume,
                            order_time: waybill1.order_time,
                            weight: waybill1.weight,
                            status: waybill1.status
                        }
                        tempData.push(tempDataEach)
                    });
                    res.status(200).send(tempData)
                }).catch(err => {
                    res.status(500).send({ message: "request error" });
                });
        } else {
            newWaybillKi.findAll({
                where: {
                    status: req.body.status
                }
            })
                .then(waybillX => {
                    var tempData = []
                    waybillX.forEach(waybill1 => {
                        var tempDataEach = {
                            waybill_number: waybill1.waybill_number,
                            sender_name: waybill1.sender_name,
                            sender_phone: waybill1.sender_phone,
                            indomaret_id: waybill1.indomaret_id,
                            recipient_name: waybill1.recipient_name,
                            recipient_phone: waybill1.recipient_phone,
                            recipient_address: waybill1.recipient_address,
                            recipient_lat: waybill1.recipient_lat,
                            recipient_long: waybill1.recipient_long,
                            order_time: waybill1.order_time,
                            volume: waybill1.volume,
                            order_time: waybill1.order_time,
                            weight: waybill1.weight,
                            status: waybill1.status
                        }
                        tempData.push(tempDataEach)
                    });
                    res.status(200).send(tempData)
                }).catch(err => {
                    res.status(500).send({ message: "request error" });
                });
        }

    } else {
        newWaybillKi.findAll({
            where: {
                status: req.body.status
            }
        })
            .then(waybillX => {
                var tempData = []
                waybillX.forEach(waybill1 => {
                    var tempDataEach = {
                        waybill_number: waybill1.waybill_number,
                        sender_name: waybill1.sender_name,
                        sender_phone: waybill1.sender_phone,
                        indomaret_id: waybill1.indomaret_id,
                        recipient_name: waybill1.recipient_name,
                        recipient_phone: waybill1.recipient_phone,
                        recipient_address: waybill1.recipient_address,
                        recipient_lat: waybill1.recipient_lat,
                        recipient_long: waybill1.recipient_long,
                        order_time: waybill1.order_time,
                        volume: waybill1.volume,
                        order_time: waybill1.order_time,
                        weight: waybill1.weight,
                        status: waybill1.status
                    }
                    tempData.push(tempDataEach)
                });
                res.status(200).send(tempData)
            }).catch(err => {
                res.status(500).send({ message: "request error" });
            });
    }

}

exports.findOngoingWaybillKi = (req, res) => {
    newWaybillKi.findAll({
        where: {
            status: req.body.userid
        }
    })
        .then(waybillX => {
            var tempData = []
            waybillX.forEach(waybill1 => {
                var tempDataEach = {
                    waybill_number: waybill1.waybill_number,
                    sender_name: waybill1.sender_name,
                    sender_phone: waybill1.sender_phone,
                    indomaret_id: waybill1.indomaret_id,
                    recipient_name: waybill1.recipient_name,
                    recipient_phone: waybill1.recipient_phone,
                    recipient_address: waybill1.recipient_address,
                    recipient_lat: waybill1.recipient_lat,
                    recipient_long: waybill1.recipient_long,
                    order_time: waybill1.order_time,
                    volume: waybill1.volume,
                    order_time: waybill1.order_time,
                    weight: waybill1.weight,
                    status: waybill1.status
                }
                tempData.push(tempDataEach)
            });
            res.status(200).send(tempData)
        }).catch(err => {
            res.status(500).send({ message: "request error" });
        });
}

exports.createNewWaybillKi = (req, res) => {
    var subdistrictTemp = "";
    // indomaretLocationRef.findAll({
    //     where: {
    //         full_store_name: req.body.indomaret_id
    //     }
    // })
    //     .then(waybillX => {
    //         if (waybillX != "") {
    //             subdistrictTemp = waybillX[0].subdistrict
    //         } else {
    //             subdistrictTemp = ""
    //         }
    //     })
    var latlongDesti = req.body.recipient_lat.toString() + "," + req.body.recipient_long.toString()
    var latlongOrig = req.body.sender_lat.toString() + "," + req.body.sender_long.toString()

    checkTariffs(latlongOrig, latlongDesti, function (err, data) {
        if (Number.isFinite(data)) {
            var prices;
            var distancee = data;
            if (data < 5001) {
                prices = 7000
            } else {
                var temporaryVal = data - 5000;
                var temporaryVal2 = Math.floor(temporaryVal / 1000)
                var lastMeterDecider = temporaryVal - (temporaryVal2 * 1000)
                if (lastMeterDecider > 300) {
                    temporaryVal2 = temporaryVal2 + 1
                }
                prices = (temporaryVal2 * 2000) + 7000
            }
            indomaretLocationRef.findAll({
                where: {
                    full_store_name: req.body.indomaret_id
                }
            })
                .then(waybillX => {
                    if (waybillX != "") {
                        subdistrictTemp = waybillX[0].subdistrict
                    } else {
                        subdistrictTemp = ""
                    }
                    newWaybillKi.create({
                        waybill_number: req.body.waybill_number,
                        sender_name: req.body.sender_name,
                        sender_phone: req.body.sender_phone,
                        indomaret_id: req.body.indomaret_id,
                        recipient_name: req.body.recipient_name,
                        recipient_phone: req.body.recipient_phone,
                        recipient_address: req.body.recipient_address,
                        recipient_lat: req.body.recipient_lat,
                        recipient_long: req.body.recipient_long,
                        order_time: req.body.order_time,
                        volume: req.body.volume,
                        weight: req.body.weight,
                        area: req.body.area,
                        image: req.body.image,
                        sender_lat: req.body.sender_lat,
                        sender_long: req.body.sender_long,
                        status: "neworder",
                        price: prices,
                        distance: distancee,
                        subdistrict: subdistrictTemp
                    })
                        .then(waybill => {
                            fcmNotifier();
                            res.status(200).send({
                                message: "success",
                                ongkos_kirim: prices
                            })
                        }).catch(err => {
                            res.status(500).send({ message: "request error" });
                        });
                })
            
        }
        else {
            res.status(200).send({
                message: "Invalid lat or long"
            })
        }
    })
}

exports.getAllWaybillKi = (req, res) => {
    newWaybillKi.findAll()
        .then(waybill => {
            res.json(waybill)
        })
}

exports.upload = async (req, res) => {
    try {
        //console.log(req)
        await uploadFile(req, res);
        //console.log(req.file.originalname)
        console.log(req.body.waybillnum)
        var filenameOri = await req.file.originalname

        //   console.log(req)

        if (req.file == undefined) {
            return res.status(400).send({ message: "Please upload a file!" });
        } else {
            res.status(200).send({
                message: "Uploaded the file successfully: " + req.file.originalname,
            });
        }
    } catch (err) {
        res.status(500).send({
            message: `Could not upload the file: ${req.file.originalname}. ${err}`,
        });
    }
};
exports.downloadImgKi = (req, res) => {
    const fileName = req.params.name;
    const directoryPath = __basedir + "/resources/static/";

    res.download(directoryPath + fileName, fileName, (err) => {
        console.log(directoryPath)
        if (err) {
            res.status(500).send({
                message: "Could not download the file",
            });
        }
    });
};

exports.updateWaybillMobile = (req, res) => {
    var nameUser
    var phoneUser
    UserDetails.findOne({
        where: {
            username: req.body.userid,
        }

    }).then(users => {
        nameUser = users.name
        phoneUser = users.phone
    })

    newWaybillKi.update({
        status: req.body.userid
    },
        {
            where: {
                waybill_number: req.body.waybill_number,
            }
        })
        .then(waybill => {

            if (waybill[0] == 0) {
                res.status(500).send({
                    message: "failed"
                })
            } else {
                kiPostReq(req.body.waybill_number, "PICKUP", nameUser, phoneUser)
                res.status(200).send({
                    message: "success"
                })
            }

        }).catch(err => {
            res.status(500).send({ message: "request error" });
        });
}

/*
exports.ipdumdum = (req, res) => {
    console.log("err start")
    console.log(req.body)
    console.log("err finish")
    var respp;
    //console.log(req.body)
    var param = {
        "notification": {
            "title": "tes",
            "body": "test"
        },

        "data": {
            "name": "tests",
            "age": "22",

        },
        "to": "e_V5gh-_TSCU69t0Rmptx3:APA91bFphgJ7Ix6x5Nc6O3IEV5bhghTxX-e98wvCssSgT3ai9jPMJgsDMa1NOmb5PQ_SeJXxSm7irYlDCrhvuzZFubKFHehhQAWemQ3cwWSTpCsR0zAkxBXW98AmIJbRz_gW9G0FmU6-"
    }
    axios.post('https://fcm.googleapis.com/fcm/send', param, {
        headers: {
            'Authorization': 'Bearer AAAA0RIushM:APA91bHzQA63uQE3-DogsPesBc3AiHsxcD_vTC1vMVQxWP8hwzz5enKUgyrg_mhMM4tbG5Tn1MiMVm452SemMP31AXsKvAfFLZj9B4Ub85aFG5MN_L-MMNZ0RUjjpyEr3Gnpa5o3s0HY'
        }
    })
        .then((res) => {
            respp = res
        })
    res.status(200).send({
        message: respp
    })
}

*/
exports.ipdumdum = (req, res) => {
    console.log("err start")
    console.log(req.body)
    console.log("err finish")
    var respp;
    //console.log(req.body)
    UserDetails.findAll({
        where: {
            fcm_enabler: "1",
        }

    }).then(users => {
        //nameUser = users.name
        //phoneUser = users.phone
        //console.log(users)
        users.forEach(userfcm => {
            console.log(userfcm.agent_id)
            var param = {
                "notification": {
                    "title": "Ada Pesanan Baru",
                    "body": "Mohon cek app anda"
                },

                "data": {
                    "name": "tests",
                    "age": "22",

                },
                "to": userfcm.agent_id
            }
            axios.post('https://fcm.googleapis.com/fcm/send', param, {
                headers: {
                    'Authorization': 'Bearer AAAA0RIushM:APA91bHzQA63uQE3-DogsPesBc3AiHsxcD_vTC1vMVQxWP8hwzz5enKUgyrg_mhMM4tbG5Tn1MiMVm452SemMP31AXsKvAfFLZj9B4Ub85aFG5MN_L-MMNZ0RUjjpyEr3Gnpa5o3s0HY'
                }
            })

                .then((res) => {
                    respp = res
                    //console.log(res)
                })


        })
        res.status(200).send({
            message: respp
        })
        //res.status(200)
    })

}
exports.checkTariffWeb = (req, res) => {
    /*
    var blueming = checkTariffs(req.body.latlong_origins, req.body.latlong_destinations, callback)
    console.log(blueming)
    res.status(200).send({
        message: blueming
    })
*/
    checkTariffs(req.body.latlong_origins, req.body.latlong_destinations, function (err, data) {
        if (Number.isFinite(data)) {
            var price;
            if (data < 5001) {
                res.status(200).send({
                    ongkos_kirim: 7000
                })
            } else {
                var temporaryVal = data - 5000;
                var temporaryVal2 = Math.floor(temporaryVal / 1000)
                var lastMeterDecider = temporaryVal - (temporaryVal2 * 1000)
                if (lastMeterDecider > 300) {
                    temporaryVal2 = temporaryVal2 + 1
                }
                price = (temporaryVal2 * 2000) + 7000
                res.status(200).send({
                    ongkos_kirim: price
                })
            }
        }
        else {
            res.status(200).send({
                message: "Invalid lat or long"
            })
        }

    })

}
exports.getIndomaret = (req, res) => {
    console.log(req.body.indomaret)
    if (req.body.hasOwnProperty('subdistrict')) {
        indomaretLocationRef.findAll({
            where: {
                full_store_name: req.body.indomaret
            }
        })
            .then(waybillX => {
                if (waybillX != "") {
                    res.send(waybillX[0].subdistrict)
                } else {
                    res.send("empty")
                }
            })
    } else {
        res.send("rrrrrr")
    }

}