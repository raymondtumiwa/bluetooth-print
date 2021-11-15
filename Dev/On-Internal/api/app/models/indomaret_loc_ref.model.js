module.exports = (sequelize, Sequelize) => {
    const indomaretLocationRef = sequelize.define("indomaret_location_ref", {
      code: {
        type: Sequelize.STRING
      },
      store_name: {
        type: Sequelize.STRING
      },
      full_store_name: {
        type: Sequelize.STRING
      },
      address: {
        type: Sequelize.STRING
      },
      createdAt: {
        type: Sequelize.STRING
      },
      updatedAt: {
        type: Sequelize.STRING
      },
      city: {
        type: Sequelize.STRING
      },
      subdistrict: {
        type: Sequelize.STRING
      },
      lat: {
        type: Sequelize.STRING
      },
      long: {
        type: Sequelize.STRING
      },  
    });
  
    return indomaretLocationRef;
  };