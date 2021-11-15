const config = require("../config/db.config.js");

const Sequelize = require("sequelize");
const sequelize = new Sequelize(
    config.DB,
    config.USER,
    config.PASSWORD,
    {
        host: config.HOST,
        dialect: config.dialect,
        operatorsAliases: false,

        pool: {
            max: config.pool.max,
            min: config.pool.min,
            acquire: config.pool.acquire,
            idle: config.pool.idle
        }
    }
);

const db = {};

db.Sequelize=Sequelize;
db.sequelize=sequelize;

db.user = require("./user.model")(sequelize,Sequelize);
db.role = require("./role.model")(sequelize,Sequelize);
db.accessmenu = require("../models/accessmenu.model.js")(sequelize, Sequelize);
db.employee = require("./employee.model/employee.model")(sequelize, Sequelize);

db.role.belongsToMany(db.user, {
    through: "user_roles",
    foreignKey: "roleId",
    otherKey: "userId"
});

db.employee.belongsTo(db.role, {
    foreignKey: 'role',
    as: "role_detail"
  });
db.employee.belongsTo(db.user, {
    foreignKey: 'username',
    as: "user_detail"
  });
db.user.hasOne(db.employee, {
    foreignKey: 'username',
    as: "employee_detail",
    onDelete: 'cascade',
    onUpdate: 'cascade'
  })

db.user.belongsToMany(db.role, {
    through: "user_roles",
    foreignKey: "userId",
    otherKey: "roleId"
});

db.ROLES = ["user", "admin", "moderator"];

module.exports=db;