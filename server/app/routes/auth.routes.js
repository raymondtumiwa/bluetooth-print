const { verifySignUp } = require("../middleware");
const controller = require("../controllers/auth.controller");
const controllerEmployee = require("../controllers/employee.controller");
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
      "/api/auth/signup",
      [
        verifySignUp.checkDuplicateUsernameOrEmail,
        // verifySignUp.checkRolesExisted
      ],
      controller.signup
    );

    app.post("/api/auth/signin", 
        controller.signin);
      
    app.post("/api/employee/add",
      controllerEmployee.newEmployee);

  

  
  //test finish

};