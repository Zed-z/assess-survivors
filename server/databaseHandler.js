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
			is: /^[a-zA-Z0-9_.\-]+$/
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
	averageRiskiness: {
		type: Sequelize.FLOAT,
		allowNull: true,
	},
	mostWeightStat: {
		type: Sequelize.STRING,
		allowNull: true,
	},
});

exports.playerPreferences = sequelize.define('player_preferences', {
	gameGuid: {
		type: Sequelize.STRING,
		allowNull: false,
	},
	name: {
		type: Sequelize.STRING,
		allowNull: false,
	},
	value: {
		type: Sequelize.FLOAT,
		allowNull: false,
	},
	weight: {
		type: Sequelize.FLOAT,
		allowNull: false,
	},
	riskiness: {
		type: Sequelize.FLOAT,
		allowNull: false,
	},
});

sequelize.sync();
console.log('Database ready.')
