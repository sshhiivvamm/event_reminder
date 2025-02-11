require('dotenv').config()

const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

mongoose.connect(process.env.DATABASE_URL)
    .then(() => {
        console.log('Connected to Database');
    })
    .catch((error) => {
        console.error('Error connecting to the database:', error);
    });


app.use(express.json())
 
const remindersRouter = require('./routes/endpoints')

app.use(bodyParser.urlencoded({ extended: true }));

app.use('/reminders', remindersRouter)
app.listen(3000, () => console.log('Server Started'));
