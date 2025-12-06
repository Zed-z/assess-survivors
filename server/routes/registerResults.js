const express = require('express');
const router = express.Router();

const db = require('../databaseHandler.js');

const crypto = require("crypto");

router.post('/register_results', async (req, res) => {

	console.log(`${req.socket.remoteAddress}: /register_results\
		${JSON.stringify(req.body).substring(0,30)}...`);

	try {

		await db.gameStats.create({
			gameGuid: crypto.randomUUID(),
			playerName: req.body.playerName,
			score: req.body.score,
		}).catch((e) => {
			console.log(e);
			throw e;
		});

		console.log(`\tOperation success.`);
		return res.status(200).send("OK");

	} catch (error) {
		res.status(400).send('Unknown error.');
		console.log(error);
	}
});

module.exports = router;
