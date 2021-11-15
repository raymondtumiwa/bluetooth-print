const { authJwt } = require("../middleware");
const controller = require("../controllers/user.controller");
const { verifySignUp } = require("../middleware");
const waybillController = require("../controllers/waybill.controller");

module.exports = function (app) {
  app.use(function (req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  //app.get("/api/test/all", controller.allAccess);

  app.post(
    "/ki/accessmenu",
    [authJwt.verifyToken],
    controller.accessMenu
  );

  app.post(
    "/ki/auth/signin/details",
    [authJwt.verifyToken],
    controller.user
  )
/*
  app.post(
    "/accessmenu",
    [authJwt.verifyToken],
    controller.accessmenu
  );
  */
};
