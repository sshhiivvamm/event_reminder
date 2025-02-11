const mongoose = require('mongoose');

// Define the schema for the firm
const reminderSchema = new mongoose.Schema({
    firm_name: { type: String, required: true },
    firm_address: { type: String, required: true },
    certificate: { type: String, required: true },
    issued_date: { type: Date, required: true },
    expiry_date: { type: Date, required: true },
  });

// Create and export the model
const Reminder = mongoose.model('Reminder', reminderSchema);

module.exports = Reminder;
