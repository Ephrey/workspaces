const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/mongo-exercises', {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => console.log('Connected to Database'))
    .catch(err => console.log('Error : ' + err.message));



const courseSchema = new mongoose.Schema({
    name: String,
    author: String,
    tags: [String],
    isPublished: Boolean,
    price: Number,
    date: {type: Date, default: Date.now},
});

const Course = mongoose.model('Course', courseSchema);


/**
 * Exercise 1
 */
// async function getCourses() {
//     return await Course.find({isPublished: true, tags: {$in: ['backend']}})
//         .sort({name: 1})
//         .select({name: 1, author: 1});
// }

/**
 * Exercise 2
 */
//  async function getCourses() {
//      return await Course
//         .find({isPublished: true, tags: {$in: ['frontend', 'backend']}})
//         .sort({price: -1})
//         .select({name: 1, author: 1});
//  }

/**
 * Exercises 3
 */
async function getCourses() {
    return await Course
        .find({isPublished: true})
        .or([{price: {$gte: 15}}, {name: /.*by.*/i}]);
}


async function run() {
    const courses = await getCourses();
    console.log(courses);
};

run();