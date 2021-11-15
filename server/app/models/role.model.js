// module.exports = (sequelize, Sequelize) => {
//     const Role = sequelize.define("roles", {
//         id: {
//             type: Sequelize.INTEGER,
//             primaryKey: true
//         },
//         name: {
//             type: Sequelize.STRING
//         }
//     });

//     return Role;
// };

module.exports = (sequelize, Sequelize) => {
    const Role = sequelize.define("roles", {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true
      },
     
      role_name: {
        type: Sequelize.STRING
      },
      access_menu: {
        type: Sequelize.STRING
      },
      role_code: {
        type: Sequelize.STRING,
        primaryKey: true,
      },
    });
  
    return Role;
  };