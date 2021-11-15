module.exports = (sequelize, Sequelize) => {
    const accessMenu = sequelize.define("access_menu", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true
      },
      state: {
        type: Sequelize.STRING
      },
      name: {
        type: Sequelize.STRING
      },
      type: {
        type: Sequelize.STRING
      },
      icon: {
        type: Sequelize.STRING
      },
      children: {
        type: Sequelize.STRING
      }
    });
  
    return accessMenu;
  };