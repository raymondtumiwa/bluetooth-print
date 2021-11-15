const waybillController = require("../controllers/waybill.controller");
const { verifySignUp } = require("../middleware");
const { authJwt } = require("../middleware");


module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    app.post(
        "/waybill/create",
        [verifySignUp.checkCreateWaybill, authJwt.verifyToken],
        waybillController.createWaybill
    )

    app.post(
        "/waybill/search",
        [authJwt.verifyToken],
        waybillController.searchWaybill
    )

    app.post(
        "/waybill/update",
        [authJwt.verifyToken],
        waybillController.updateWaybill
    )
    app.post(
        "/waybill/confirmwaybill",
        [authJwt.verifyToken],
        waybillController.confirmWaybill
    )

    app.post(
        "/waybill/track",
        [authJwt.verifyToken],
        waybillController.trackWaybill
    )

    app.post(
        "/waybill/ongoing",
        waybillController.updateWaybill
    )

    app.post(
        "/waybill/current",
        waybillController.updateWaybill
    )

    app.post(
        "/waybill/createki",
        [authJwt.verifyToken],
        waybillController.createNewWaybillKi
    )
    app.post(
        "/waybill/findnewki",
        [authJwt.verifyToken],
        waybillController.findNewWaybillKi
    )
    app.post(
        "/waybill/fileupload",
        waybillController.upload
    )

    //new
    app.post(
        "/ki/waybill/createki",
        [authJwt.verifyToken],
        waybillController.createNewWaybillKi
    )
    app.post(
        "/ki/waybill/findnewki",
        [authJwt.verifyToken],
        waybillController.findNewWaybillKi
    )
    app.post(
        "/ki/waybill/fileupload",
        waybillController.upload
    )
    app.post(
        "/ki/waybill/confirmwaybill",
        [authJwt.verifyToken],
        waybillController.confirmWaybill
    )
    app.post(
        "/ki/waybill/updateki",
        [authJwt.verifyToken],
        waybillController.updateWaybill
    )
    app.post(
        "/ki/waybill/updatekimobile",
        [authJwt.verifyToken],
        waybillController.updateWaybillMobile
    )
    app.post(
        "/ki/waybill/getallki",
        [authJwt.verifyToken],
        waybillController.getAllWaybillKi
    )
    app.get(
        "/ki/images/:name",
        waybillController.downloadImgKi
    )

    app.post(
        "/ipdumdum",
        waybillController.ipdumdum
    )
    app.post(
        "/ki/checktariff",
        [authJwt.verifyToken],
        waybillController.checkTariffWeb
    )
    app.post(
        "/ki/checkindomaret",
        //[authJwt.verifyToken],
        waybillController.getIndomaret
    )
    /*
    app.post(
        "/ki/waybill/createkitest",
        [authJwt.verifyToken],
        waybillController.createNewWaybillKiTest
    )
    
    app.post(
        "/ipdummy",
        [authJwt.verifyToken],
        waybillController.ipdummy
    )
    */
    //new end
}
