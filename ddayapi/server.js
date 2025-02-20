// server.js
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

// Import routes
const remindersRouter = require('./routes/reminderRoutes');

// Set up the app
const app = express();
app.use(express.json());

// Connect to the database
mongoose.connect(process.env.DATABASE_URL)
  .then(() => {
    console.log('Connected to Database');
  })
  .catch((error) => {
    console.error('Error connecting to the database:', error);
  });

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));

// Use the reminder routes
app.use('/routes', remindersRouter);

// Start the server
app.listen(3000, () => console.log('Server Started'));
