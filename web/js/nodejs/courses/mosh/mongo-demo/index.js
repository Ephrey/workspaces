const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/playground', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB ...'))
    .catch(err => console.log('Error connecting to', err));


const courseSchema = new mongoose.Schema({
    name: {
        type: String, 
        required: true,
        minlength: 5,
        maxlength: 255,
        // match: /pattern/
    },
    category: {
        type: String,
        required: true,
        enum: ['web', 'mobile', 'network'],
        lowercase: true,
        // uppercase: true,
        trim: true,
    },
    author: String,
    tags: {
        type: Array,
        validate: {
            validator: function(v) {
                return v && v.length > 0;
            },
            message: 'A course should have at least one tag.'
        }
    },
    publishers: {
        type: Array,
        validate: {
            validator: (v) => {
                return new Promise((resolve, reject) => {
                    setTimeout(function () {
                        (v && v.length > 0) ? resolve(true) : reject(new Error('Ooops'));
                    }, 2000)
                });
            },
            message: 'A course should have at least one publisher.'
        }
    },
    date: {type: Date, default: Date.now},
    isPublished: Boolean,
    price: {
        type: Number, 
        min: 10, max: 200,
        get: (v) => Math.round(v),
        set: (v) => Math.round(v),
        required: function() { return this.isPublished; }
    }
});

const Course = mongoose.model('Course', courseSchema);

async function createCourse() {
    const course = new Course({
        name: 'Angular',
        category: 'Web',
        author: 'Nancy',
        tags: ['tag1'],
        publishers: ['pub1', 'pub2'],
        isPublished: false,
        price: 15.8,
    });

    try {
        // await course.validate();
        const result = await course.save();
        console.log(result);
    } catch(ex) {
        for(field in ex.errors) {
            console.log(ex.errors[field].message);
        }
    }
}

async function getCourses() {
    const pageNumber = 2;
    const pageSize = 10;

    const courses = await Course
        .find({author: 'Nancy', isPublished: true})
        // .find({price: {$in: [10, 15, 20]}})
        // .find({price: {$gt: 10, $lte: 20}})
        // .find({$or: [{ author: {$eq:'Nancy'}}, {isPublished: {$eq: true}}]})
        // .find({author: {$regex: '^N'}})
        .skip((pageNumber -1) * pageSize)
        .limit(pageSize)
        .sort({name: 1})
        // .count()
        .select({ author: 1, tags: 1 })
    console.log(courses);
}

async function updateCourse(id) {
    // const course = await Course.findById(id);
    // if(!course) return;

    // course.set({isPublished: true, author: "Another author"});

    // const result = await course.save();
    // console.log(result);

    // const result = await Course
    //     .updateOne({_id: id}, {
    //         $set: {isPublished: false, author: "Ephraim Ilunga"}
    //     });

    const result = await Course
        .findByIdAndUpdate(id, {
            isPublished: false, author: "Ephraim TEC Ilunga"
        }, {useFindAndModify: false, new: true});
    console.log(result);
}


async function deleteCourse(id) {
    const course = await Course
        .findOneAndDelete({_id: id});
        console.log(course);
}

createCourse()

// getCourses();

// updateCourse('600de378f4d5bd2272e49586');
// deleteCourse('600de378f4d5bd2272e49586');