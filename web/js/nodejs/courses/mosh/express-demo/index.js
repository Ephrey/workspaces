const Joi = require('joi');
const express = require('express');
const app = express();

// body parsing middleware 
app.use(express.json());

const _ = require('underscore');

let courses = [
    {id: 1, name: 'courses1'},
    {id: 2, name: 'courses2'},
    {id: 3, name: 'courses3'}
];

// GET 
app.get('/', (req, res) => {
    res.send('Hello, world :)');
});

app.get('/api/courses', (req, res) => {
    res.send(courses);
});

// http://your-domain.com/api/courses/course_id{int}
app.get('/api/courses/:id', (req, res) => {
    const course = courses.find(c => c.id === parseInt(req.params.id));
    if(!course) {
        res.status(404).send('The course with the given ID was not found');
        return;
    }
    res.send(course);
});

// POST 
app.post('/api/courses', (req, res) => {

    const {error} = validateCourse(req.body);

    if(error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    const course = {
        id: courses.length + 1, 
        name: req.body.name + (courses.length + 1)
    }

    courses.push(course);

    res.send(course);
});

// PUT 
app.put('/api/courses/:id', (req, res) => {
    const newName = req.body.name;  
    const courseId = parseInt(req.params.id);

    // Look up the course
    const course = courses.find(c => c.id === courseId);

    // If not existing, return 404
    if(!course) {
        res.status(404).send('Course with ID #' + courseId + ' not found');
        return;
    }

    // Validate 
    const {error} = validateCourse(req.body);

    // If invalid, return 400 - Bad Request
    if(error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    // Update course
    course.name = newName;

    // Return the updated course
    res.send(course);
}); 

// DELETE 
app.delete('/api/courses/:id', (req, res) => {
    const courseId = parseInt(req.params.id);

    // Look up the course
    const course = courses.find(c => c.id === courseId);


    // If not existing, return 404
    if(!course) {
        res.status(404).send('Course with ID #' + courseId + ' not found');
        return;
    }

    courses.splice(courses.indexOf(course), 1);

    res.send({message: "Successfully deleted", course: course});
});

// VALIDATION 
function validateCourse(course) {
    const schema = Joi.object({
        name: Joi.string().min(3).required()
    });

    return schema.validate(course);
}

// PORT 
const port = process.env.PORT || 3000;

app.listen(port, () => console.log('Listening on port ' + port));