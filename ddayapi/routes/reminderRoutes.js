// routes/reminderRoutes.js
const express = require('express');
const router = express.Router();

// Import controller functions
const {
  getReminderByDate,
  getReminderByDateRange,
  saveReminder,
  allreminders,
} = require('../controllers/reminderController');

// Route to get reminders for a specific expiry date
router.get('/reminder/:date', getReminderByDate);

// Route to get reminders within a date range (start_date to end_date)
router.get('/reminders/:start_date/:end_date', getReminderByDateRange);

// Route to save a new reminder
router.post('/save-reminder', saveReminder);

// Route to get all reminders
router.get('/allreminders', allreminders);
  
module.exports = router;
