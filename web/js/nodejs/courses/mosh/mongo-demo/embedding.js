const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/playground', {useNewUrlParser: true, useUnifiedTopology: true})
  .then(() => console.log('Connected to MongoDB...'))
  .catch(err => console.error('Could not connect to MongoDB...', err));

const authorSchema = new mongoose.Schema({
  name: String,
  bio: String,
  website: String
});

const Author = mongoose.model('Author', authorSchema);

const Course = mongoose.model('Course', new mongoose.Schema({
  name: String,
  authors: [authorSchema]
}));

async function createCourse(name, authors) {
  const course = new Course({
    name, 
    authors
  }); 
  
  const result = await course.save();
  console.log(result);
}

async function updateCourse(courseId) {
  const course = await Course.updateOne({_id: courseId}, {
    // $set: {
    //   'author.name': 'John Smith'
    // },
    $unset: {
      'author': ''
    }
  });
}

async function addAuthor(courseId, author) {
  const course = await Course.findById(courseId);
  course.authors.push(author);
  course.save();
}

async function removeAuthor(courseId, authorId) {
  const course = await Course.findById(courseId);
  const author = course.authors.id(authorId);
  author.remove();
  course.save();
}

async function listCourses() { 
  const courses = await Course.find();
  console.log(courses);
}

// createCourse('Node Course', [
//   new Author({ name: 'Mosh' }),
//   new Author({ name: 'Ephra' })
// ]);

// updateCourse('6012e7d05eed34675ed1b761');

// addAuthor('6012ea9dd6a88e83ba1ccadd', new Author({name: 'Kally'}));

removeAuthor('6012ea9dd6a88e83ba1ccadd', '6012ebfe9329b391a9f2602a');
