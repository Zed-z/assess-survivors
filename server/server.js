const fs = require('fs');
const path = require('path');
const config = require('./config.js');

// Set up express app
const PORT = config.port;
const express = require('express');

const app = express()
	.use(express.json({limit: config.dataLimit}))
	.use(express.urlencoded({ extended: true, limit: config.dataLimit}))
	.use(express.json());

// Load and apply routes from the requests/ folder
const loadRoutes = (app, routesDir) => {
	fs.readdirSync(routesDir).forEach(file => {
		if (file.endsWith('.js')) {
			console.info(`Loading routes from ${file}...`);
			const route = require(path.join(routesDir, file));
			app.use('/', route);
		}
	});
};
loadRoutes(app, path.join(__dirname, 'routes'));

// Start listening
app.listen(PORT);
console.log(`Server running on port ${PORT}.`);
