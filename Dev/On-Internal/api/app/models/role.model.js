const { accessmenu } = require(".");

module.exports = (sequelize, Sequelize) => {
    const Role = sequelize.define("roles", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true
      },
      name: {
        type: Sequelize.STRING
      },
      accessMenu: {
        type: Sequelize.STRING
      }
    });
  
    return Role;
  };