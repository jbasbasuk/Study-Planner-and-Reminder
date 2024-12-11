const express = require("express");
const router = express.Router();

// Define our data
var shopData = { shopName: "StudyPlannerReminder" };

// Handle our routes
router.get('/', function(req, res) {
    res.render('index.ejs', shopData);
});

router.get('/about', function(req, res) {
    res.render('about.ejs', shopData);
});

router.get('/search', function(req, res) {
    res.render("search.ejs", shopData);
});

router.get('/search-result', function(req, res) {
    // Searching in the database
    res.send("You searched for: " + req.query.keyword);
});

router.get('/register', function(req, res) {
    res.render('register.ejs', shopData);
});

router.post('/registered', function(req, res) {
    // Saving data in database
    res.send('Hello ' + req.body.first + ' ' + req.body.last + 
             ' you are now registered! We will send an email to you at ' + req.body.email);
});

// Define a new route to list books from the database
router.get('/list', function(req, res) {
    let sqlquery = "SELECT * FROM books"; // Query database to get all the books
    // Execute SQL query
    db.query(sqlquery, (err, result) => {
        if (err) {
            res.redirect('./');
        }
        res.send(result);
    });
});

// Export the router object so index.js can access it
module.exports = router;

// ADD A COURSE 
router.get('/add-course', function(req, res) {
    res.render('add-course.ejs');  // Render the course addition form
});

router.post('/add-course', function(req, res) {
    const { course_name, course_description, start_date, end_date } = req.body;

    // SQL query to insert course data into the database
    const query = "INSERT INTO courses (course_name, course_description, start_date, end_date) VALUES (?, ?, ?, ?)";
    db.query(query, [course_name, course_description, start_date, end_date], (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Error adding course');
        }
        res.send('Course added successfully!');
    });
});

// Add Study Session Route
router.get('/add-study-session', function(req, res) {
    // Fetch all courses to display in the dropdown
    const query = "SELECT * FROM courses";
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).send('Error fetching courses');
        }
        res.render('add-study-session.ejs', { courses: result });
    });
});

router.post('/add-study-session', function(req, res) {
    const { course_id, study_date, study_time, study_topic, reminder_time } = req.body;

    // Log the received data for debugging
    console.log('Received data for study session:', req.body);

    // SQL query to insert study session data
    const query = `
        INSERT INTO StudySessions (course_id, study_date, study_time, study_topic, reminder_time)
        VALUES (?, ?, ?, ?, ?)
    `;
    db.query(query, [course_id, study_date, study_time, study_topic, reminder_time], (err, result) => {
        if (err) {
            console.error('Error inserting study session:', err.message); // Log the error message
            return res.status(500).send(`Error adding study session: ${err.message}`); // Display exact error for debugging
        }
        res.send('Study session added successfully!');
    });
});

// Add Reminder
router.get('/reminders', function(req, res) {
    const query = "SELECT * FROM Reminders";  // Query the reminders table
    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Error fetching reminders');
        }
        res.render('reminders.ejs', { reminders: result });  // Pass results to the view
    });
});
