module.exports = (sequelize, Sequelize) => {
    const AccessMenu = sequelize.define("access_menu", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement:true
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
    },{
      timeStamps: false,
    });
    return AccessMenu;
  };