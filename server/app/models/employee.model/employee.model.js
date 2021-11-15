var moment = require('moment-timezone')
const { DataTypes } = require("sequelize");

module.exports = (sequelize, Sequelize) => {
	const Employee = sequelize.define("employee_details", {
		id: {
			type: Sequelize.INTEGER,
			autoIncrement: true
		},
		username: {
			type: Sequelize.STRING
		},
		employee_code: {
			type: Sequelize.STRING,
			primaryKey: true,
		},
		
		employee_name: {
			type: Sequelize.STRING
		},
		role: {
			type: Sequelize.STRING
		},
		area: {
			type: Sequelize.STRING
		},
		password: {
			type: Sequelize.STRING
		},
		mobile: {
			type: Sequelize.STRING
		},
		address: {
			type: Sequelize.STRING
		},
		status: {
			type: Sequelize.STRING
		},
		log: {
			type: Sequelize.STRING
		},
		createdBy: {
			type: Sequelize.STRING
		},
		updatedBy: {
			type: Sequelize.STRING
		},
		last_jwt: {
			type: Sequelize.STRING
		},
		disableOn: {
			type: Sequelize.DATE,
			get() {
                return moment.tz(this.getDataValue('updatedAt'), 'Asia/Jakarta').format('YYYY-MM-DD HH:mm:ss')
            }
		},
		disableBy: {
			type: Sequelize.STRING
		},
		// fcm: {
		// 	type: Sequelize.STRING
		// },
		position: {
			type: Sequelize.STRING
		},
		// photo_url: {
		// 	type: Sequelize.STRING
		// },
		createdAt: {
            type: Sequelize.DATE,
            get() {
				console.log(this.getDataValue('createdAt'))
                return moment.tz(this.getDataValue('createdAt'), 'Asia/Jakarta').format('YYYY-MM-DD HH:mm:ss')
            }
        },
        updatedAt: {
            type: Sequelize.DATE,
            get() {
				console.log(this.getDataValue('updatedAt'))
                return moment.tz(this.getDataValue('updatedAt'), 'Asia/Jakarta').format('YYYY-MM-DD HH:mm:ss')
            }
        },
		nameWithCode: {
            type: Sequelize.VIRTUAL,
            get() {
				console.log(this.getDataValue('employee_name'))
                return this.getDataValue('employee_name') + " - " + this.getDataValue('username')
            }
        },
	});
	return Employee;
};




