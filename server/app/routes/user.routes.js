const { authJwt } = require("../middleware");
const controller = require("../controllers/user.controller");

module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type"
        );
        next();
    });

    app.get("/api/test/all", controller.allAccess);

    app.get(
        "/api/test/user",
        [authJwt.verifyToken],
        controller.userBoard
    );

    app.get(
        "/api/test/mod",
        [authJwt.verifyToken, authJwt.isModerator],
        controller.moderatorBoard
    );
    app.post(
        "/api/accessmenu",
        [authJwt.verifyToken],
        controller.AM
    );
    // app.post(
    // "/api/auth/check",
    // [authJwt.verifyToken],
    // controller.user
    // );
    app.post(
        "/accessmenu",
        [authJwt.verifyToken],
        controller.accessmenu
    );
    app.post(
        "/api/auth/check",
        [authJwt.verifyToken],
        controller.user
    );
    app.post(
        "/api/auth/check/fcm",
        [authJwt.verifyToken],
        controller.rewriteFCM
      );
      app.get(
		"/api/app/info",
		controller.infoApp
	);
    app.get(
        "/api/test/admin",
        [authJwt.verifyToken, authJwt.isAdmin],
        controller.adminBoard
    );

};