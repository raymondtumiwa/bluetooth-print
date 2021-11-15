const { verifySignUp } = require("../middleware");
const controller = require("../controllers/auth.controller");
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
    "/ki/auth/signup",
    [verifySignUp.checkDuplicateUsernameOrEmail, authJwt.verifyToken],
    controller.signup
  );

  app.post(
    "/ki/auth/signin",
    controller.signin);

  app.get(
    "/ki/auth/verify",
    [authJwt.verifyToken],
    controller.verify
  );
  app.post(
    "/ki/registerfcm",
    [authJwt.verifyToken],
    controller.registerfcm
  );

  //test start
  app.post(
    "/auth/signup",
    [verifySignUp.checkDuplicateUsernameOrEmail, authJwt.verifyToken],
    controller.signup
  );

  app.post(
    "/auth/signin",
    controller.signin);

  app.get(
    "/auth/verify",
    [authJwt.verifyToken],
    controller.verify
  );

  
  //test finish

};