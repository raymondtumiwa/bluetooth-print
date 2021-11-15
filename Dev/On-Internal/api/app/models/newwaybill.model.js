module.exports = (sequelize, Sequelize) => {
  const waybillNumber = sequelize.define("new_waybill", {
    waybill_number: {
      type: Sequelize.STRING
    },
    sender_name: {
      type: Sequelize.STRING
    },
    sender_phone: {
      type: Sequelize.STRING
    },
    sender_origin: {
      type: Sequelize.STRING
    },
    recipient_name: {
      type: Sequelize.STRING
    },
    recipient_phone: {
      type: Sequelize.STRING
    },
    recipient_address: {
      type: Sequelize.STRING
    },
    recipient_address_subdistrict: {
      type: Sequelize.STRING
    },
    recipient_address_district: {
      type: Sequelize.STRING
    },
    recipient_address_city: {
      type: Sequelize.STRING
    },
    recipient_address_province: {
      type: Sequelize.STRING
    },
    weight: {
      type: Sequelize.STRING
    },
    status: {
      type: Sequelize.STRING
    },
    area: {
      type: Sequelize.STRING
    },
    image: {
      type: Sequelize.STRING
    },
  });

  return waybillNumber;
};