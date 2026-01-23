const fs = require('fs');
const path = require('path');
const config = require('./config.js');

// Set up express app
const PORT = config.port;
const express = require('express');

const app = express();
app.use(express.json());

// CORS
app.use((req, res, next) => {
    const origin = req.headers.origin;

    if (config.allowedOrigins.includes(origin)) {
        res.setHeader('Access-Control-Allow-Origin', origin);
    }

    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Cross-Origin-Resource-Policy', 'cross-origin');

    if (req.method === 'OPTIONS') {
        return res.sendStatus(200);
    }

    next();
});

// Load and apply routes
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
