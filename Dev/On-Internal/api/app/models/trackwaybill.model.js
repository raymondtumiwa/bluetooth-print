module.exports = (sequelize, Sequelize) => {
    const trackwaybill = sequelize.define("track_waybills", {
      waybill_number: {
        type: Sequelize.STRING
      },
      signer: {
        type: Sequelize.STRING
      },
      location: {
        type: Sequelize.STRING
      },
      timestamp: {
        type: Sequelize.STRING
      }
    });
  
    return trackwaybill;
  };