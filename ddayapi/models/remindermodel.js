// models/remindermodel.js
const mongoose = require('mongoose');

const reminderSchema = new mongoose.Schema({
  firm_name: { type: String, required: true },
  firm_address: { type: String, required: true },
  gst: { type: String, required: true },
  certification_body: { type: String, required: true },
  contact: { type: Number, required: true },
  basic_amount: { type: Number, required: true },
  reference: { type: String, required: true },
  issued_date: { 
    type: Date, 
    required: true,
    get: function (value) {
      return value ? new Date(value).toLocaleDateString('en-GB') : ''; // 'en-GB' is for dd-MM-yyyy format
    }
  },
  expiry_date: { 
    type: Date, 
    required: true,
    get: function (value) {
      return value ? new Date(value).toLocaleDateString('en-GB') : '';
    }
  },
  certificate: { type: String, required: true },
});

// To make sure the getter works when fetching data
reminderSchema.set('toJSON', { getters: true });

const Reminder = mongoose.model('Reminder', reminderSchema);

module.exports = Reminder;
