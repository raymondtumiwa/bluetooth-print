module.exports = (sequelize, Sequelize) => {
    const hello = sequelize.define("hello", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true
      },
      nama: {
        type: Sequelize.STRING
      },
      kelas: {
        type: Sequelize.INTEGER
      }
    });
  
    return hello;
  };