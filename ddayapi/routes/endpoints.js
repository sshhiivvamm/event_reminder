const express = require('express');
const router = express.Router();

// Import the Firm model from models/firm.js
const Reminder = require('../models/reminders');


// API endpoint to save firm data 
router.post('/save-reminder', async (req, res) => {
    try {
        // Destructuring the fields from the request body
        const { firm_name, firm_address, certificate, issued_date, expiry_date } = req.body;

        // Check if all required fields are present
        if (!firm_name || !firm_address || !certificate || !issued_date || !expiry_date) {
            return res.status(400).json({
                success: false,
                message: 'All fields are required'
            });
        }

        // Convert date fields into Date objects


        // Create a new firm instance
        const newReminder = new Reminder({
            firm_name,
            firm_address,
            certificate,
            issued_date,
            expiry_date,
        });

        // Save the firm to the database
        await newReminder.save();

        // Respond with a success message and the saved firm data
        res.status(201).json({
            success: true,
            message: 'Firm data saved successfully',
            reminder: {
                _id: newReminder._id,
                firm_name: newReminder.firm_name,
                firm_address: newReminder.firm_address,
                certificate: newReminder.certificate,
                issued_date: newReminder.issued_date,
                expiry_date: newReminder.expiry_date,
                createdAt: newReminder.createdAt,
                updatedAt: newReminder.updatedAt
            }
        });
    } catch (error) {
        console.error(error.message);  // Log the error message
        res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
});

router.get('/all-reminders', async (req, res) => {
    try {
        // Fetch all firms from the database
        const reminders = await Reminder.find();  // Use .find() to get all firms/reminders

        if (reminders.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'No reminders found'
            });
        }

        // Respond with the list of firms
        res.status(200).json({
            success: true,
            reminders: reminders
        });
    } catch (error) {
        console.error(error.message);  // Log the error message
        res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
});
// route to add new reminder
router.post('/', (req, res) => {

})

//route to delete reminder
router.delete('/', (req, res) => {

})

// route to edit existing reminder
router.patch('/', (req, res) => {

})

// route for a reminder for a day
router.get('/has2', (req, res) => {

})

let data = ["ISO 9001 - Quality Management System",
    "ISO 14001 - Environmental Management System",
    "ISO 45001 - Occupational Health & Safety Management System",
    "ISO 22000 - Food Safety Management System",
    "ISO/IEC 27001 - Information Security Management System",
    "ISO/IEC 20000-1 - IT Management System",
    "ISO 13485 - Medical Devices, Quality Management System",
    "ISO 50001 - Energy Management System Certification",
    "ISO 22313 - Business Continuity Management System",
    "HACCP Hazard Analysis & Critical Control Points",
    "ISO 10002 - Customer Complaints Management Systems",
    "ISO 10006 - Quality Management Systems",
    "ISO 10015 - Quality Management, Guidelines For Training",
    "ISO 28001 - Security Management for Supply Chain Management",
    "ISO 29990 - Learning Services Management",
    "ISO 31000 - Risk Management",]

// route for all certifications  
router.get('/certifications', (req, res) => {
    res.json({
        info: data
    })
})

// route to edit certifications
router.put('/', (req, res) => {
    console.log(req.query);
    data.push(req.query);
    res.send(data)
})

// route for reminders in a week
// route for reminders in a month
// route for all reminders

module.exports = router;
