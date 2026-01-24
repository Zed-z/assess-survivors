const express = require('express');
const router = express.Router();

const Sequelize = require('sequelize');
const db = require('../databaseHandler.js');

const crypto = require("crypto");

router.post('/register_results', async (req, res) => {

	console.log(`${req.socket.remoteAddress}: /register_results\t${JSON.stringify(req.body)}`);

	try {

		/*
		Example data:
		{
			"playerName": "Username",
			"score": "100000",
			"stats": [
				{
					"name": "STAT_ATK",
					"value": 300,
					"weight": 0.7,
					"riskiness": -0.23
				},
				{
					"name": "STAT_HP",
					"value": 540,
					"weight": 0.3,
					"riskiness": 0.52
				}
			]
		}
		*/

		const gameGuid = crypto.randomUUID();

		const info = { notes: []};

		const totalGames = await db.gameStats.count();
		info.total_games = totalGames;

		const mostWeightStat = req.body.stats.reduce((maxStat, currentStat) => {
			return (currentStat.weight > maxStat.weight)
				? currentStat
				: maxStat;
		});
		const sameMostWeightStatCount = await db.gameStats.count({
			where: { mostWeightStat: mostWeightStat.name }
		});

		info.most_weight_stat = mostWeightStat;
		info.same_most_weight_stat_count = sameMostWeightStatCount;
		info.notes.push(`Your most weighted stat was ${mostWeightStat.name}, just like ${sameMostWeightStatCount} other players.`);

		const lessScoreCount = await db.gameStats.count({
			where: { score: { [Sequelize.Op.lt]: req.body.score } }
		});
		const percentile = (totalGames > 0) ? (lessScoreCount / totalGames) : 0;
		info.less_score_count = lessScoreCount;
		info.score_percentile = percentile;
		info.notes.push(`Your score is better than ${(percentile * 100).toFixed(2)}% of all players.`);

		const avgerageRiskiness = req.body.stats.reduce((sum, stat) => sum + stat.riskiness * stat.weight, 0)
			/ req.body.stats.reduce((sum, stat) => sum + stat.weight, 0);
		const lessRiskinessCount = await db.gameStats.count({
			where: { averageRiskiness: { [Sequelize.Op.lt]: avgerageRiskiness } }
		});
		const moreRiskinessCount = totalGames - lessRiskinessCount;
		const riskinessPercentile = (totalGames > 0) ? (lessRiskinessCount / totalGames) : 0;

		info.avgerage_riskiness = avgerageRiskiness;
		info.more_riskiness_count = moreRiskinessCount;
		info.less_riskiness_count = lessRiskinessCount;
		info.riskiness_percentile = riskinessPercentile;
		info.notes.push(`Your average riskiness was ${avgerageRiskiness.toFixed(2)}, higher than ${(riskinessPercentile * 100).toFixed(2)} of people.`);


		const rawRow = await db.gameStats.create({
			gameGuid: gameGuid,
			playerName: req.body.playerName,
			score: req.body.score,
			averageRiskiness: avgerageRiskiness,
			mostWeightStat: mostWeightStat.name
		}).catch((e) => {
			console.log(e);
			throw e;
		});

		const rawStats = await db.playerPreferences.bulkCreate(
			req.body.stats.map(stat => ({
				gameGuid: gameGuid,
				name: stat.name,
				value: stat.value,
				weight: stat.weight,
				riskiness: stat.riskiness
			}))
		);

		const row = rawRow.get({ plain: true });
		row.stats = rawStats.map(s => s.get({ plain: true }));
		info.row = row;

		console.log(`\tOperation success.`);
		return res.status(200).json(info);

	} catch (error) {
		res.status(400).send('Unknown error.');
		console.log(error);
	}
});

module.exports = router;
