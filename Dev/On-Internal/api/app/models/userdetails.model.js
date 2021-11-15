module.exports = (sequelize, Sequelize) => {
    const userDetails = sequelize.define("user_details", {
      username: {
        type: Sequelize.STRING
      },
      phone: {
        type: Sequelize.STRING
      },
      agent_id: {
        type: Sequelize.STRING
      },
      location: {
        type: Sequelize.STRING
      },
      name: {
        type: Sequelize.STRING
      },
      fcm_enabler: {
        type: Sequelize.STRING
      }
    });
  
    return userDetails;
  };