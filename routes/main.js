const express = require("express");
const router = express.Router();
const methodOverride = require('method-override');

// Middleware to parse URL-encoded bodies
router.use(express.urlencoded({ extended: true }));

// Middleware to override HTTP methods
router.use(methodOverride('_method'));

// Define our data
var shopData = { shopName: "StudyPlannerReminder" };

// Routes
router.get('/', function (req, res) {
    res.render('index.ejs', shopData);
});

router.get('/about', function (req, res) {
    shopData.description = "StudyPlannerReminder helps students stay organized by planning their study schedules and setting reminders for tasks and study sessions.";
    res.render('about.ejs', shopData);
});

// Add Course
router.get('/add-course', function (req, res) {
    res.render('add-course.ejs');
});

router.post('/add-course', function (req, res) {
    const { course_name, course_description, start_date, end_date } = req.body;
    const query = "INSERT INTO courses (course_name, course_description, start_date, end_date) VALUES (?, ?, ?, ?)";
    db.query(query, [course_name, course_description, start_date, end_date], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error adding course');
        }
        res.redirect('/reminders');
    });
});

// Add Study Session
router.get('/add-study-session', function (req, res) {
    const query = "SELECT * FROM courses";
    db.query(query, (err, result) => {
        if (err) {
            return res.status(500).send('Error fetching courses');
        }
        res.render('add-study-session.ejs', { courses: result });
    });
});

router.post('/add-study-session', function (req, res) {
    const { course_id, study_date, study_time, study_topic, reminder_time } = req.body;
    const query = `
        INSERT INTO StudySessions (course_id, study_date, study_time, study_topic, reminder_time)
        VALUES (?, ?, ?, ?, ?)
    `;
    db.query(query, [course_id, study_date, study_time, study_topic, reminder_time], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error adding study session');
        }
        res.redirect('/reminders');
    });
});

// Study Reminders
router.get('/reminders', function (req, res) {
    const query = `
        SELECT s.session_id, s.study_date, s.study_time, s.study_topic, c.course_name
        FROM StudySessions s
        JOIN courses c ON s.course_id = c.courseID
    `;
    db.query(query, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error fetching reminders');
        }
        res.render('reminders.ejs', { reminders: result });
    });
});

// Delete a single reminder
router.delete('/reminders/:id', function (req, res) {
    const { id } = req.params;
    const query = "DELETE FROM StudySessions WHERE session_id = ?";
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error deleting reminder');
        }
        res.redirect('/reminders');
    });
});

// Search
router.get('/search', function (req, res) {
    res.render('search.ejs', { shopName: shopData.shopName, keyword: null, results: null });
});

router.get('/search-result', function (req, res) {
    const keyword = req.query.keyword;
    const query = `
        SELECT * 
        FROM courses 
        WHERE course_name LIKE ? OR course_description LIKE ?
    `;
    db.query(query, [`%${keyword}%`, `%${keyword}%`], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Error fetching search results');
        }
        res.render('search.ejs', { shopName: shopData.shopName, keyword, results });
    });
});

// Export the router object
module.exports = router;
