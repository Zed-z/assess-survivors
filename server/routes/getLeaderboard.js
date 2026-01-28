const express = require('express');
const router = express.Router();

const db = require('../databaseHandler.js');

router.get('/get_leaderboard', async (req, res) => {

	console.log(`${req.socket.remoteAddress}: /get_leaderboard\
		${JSON.stringify(req.body).substring(0,30)}...`);

	try {

		const games = await db.gameStats.findAll({
			limit: 20,
			order: [['score', 'DESC']]
		}).catch((e) => {
			console.log(e);
			return null;
		});

		const gamesWithStats = await Promise.all(games.map(async (game) => {
			const stats = await db.playerPreferences.findAll({
				where: {
					gameGuid: game.gameGuid
				}
			});
			game.stats = stats.map(stat => ({
				name: stat.name,
				value: stat.value,
				weight: stat.weight,
				riskiness: stat.riskiness
			}));
			return game;
		}));

		const leaderboard = gamesWithStats.map((entry, i) => ({
			rank: i + 1,
			player: entry.playerName,
			score: entry.score,
			average_riskiness: entry.averageRiskiness,
			most_weight_stat: entry.mostWeightStat,
			//stats: entry.stats,
		}));

		console.log(leaderboard);

		console.log(`\tOperation success.`);
		return res.status(200).send(leaderboard);

	} catch (error) {
		res.status(400).send('Unknown error.');
		console.log(error);
	}
});

module.exports = router;
