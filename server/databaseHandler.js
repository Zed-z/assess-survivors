const Sequelize = require('sequelize');
const { Op } = require('sequelize');

const sequelize = new Sequelize('database', 'user', 'password', {
	host: 'localhost',
	dialect: 'sqlite',
	logging: false,
	storage: './database.sqlite',
});

exports.gameStats = sequelize.define('game_stats', {
	gameGuid: {
		type: Sequelize.STRING,
		primaryKey: true,
	},
	playerName: {
		type: Sequelize.STRING,
		allowNull: false,
		validate: {
			is: /^[a-zA-Z0-9_]+$/
		}
	},
	score: {
		type: Sequelize.INTEGER,
		allowNull: false,
	},
	won: {
		type: Sequelize.BOOLEAN,
		allowNull: false,
	},
});

sequelize.sync();
console.log('Database ready.')
