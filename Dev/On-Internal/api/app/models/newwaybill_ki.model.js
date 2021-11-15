module.exports = (sequelize, Sequelize) => {
  const waybillNumber = sequelize.define("new_waybill_ki", {
    waybill_number: {
      type: Sequelize.STRING
    },
    sender_name: {
      type: Sequelize.STRING
    },
    sender_phone: {
      type: Sequelize.STRING
    },
    indomaret_id: {
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
    recipient_lat: {
      type: Sequelize.STRING
    },
    recipient_long: {
      type: Sequelize.STRING
    },
    order_time: {
      type: Sequelize.STRING
    },
    volume: {
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
    sender_lat: {
      type: Sequelize.STRING
    },
    sender_long: {
      type: Sequelize.STRING
    },
    price: {
      type: Sequelize.STRING
    },
    distance: {
      type: Sequelize.STRING
    },
    subdistrict: {
      type: Sequelize.STRING
    },

  });

  return waybillNumber;
};