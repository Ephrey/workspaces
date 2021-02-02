const mongoose = require('mongoose');

const id = new mongoose.Types.ObjectId();
console.log(id.getTimestamp());

const isValidId = mongoose.Types.ObjectId.isValid(id);

console.log(isValidId);

// _id: 6011cb92d8a12c79aa4b69d5

// 12 bytes : uniquely identify a document in a collection
    // 4 bytes : timestamp 
    // 3 bytes : machine identifier
    // 2 bytes : process identifier 
    // 3 bytes : counter (change if the 9 bytes above were created at the same time);

// 1 byte = 8 bits
// 2 ^ 8 = 256
// 2 ^ 24 = 16m

// MongoDB Driver (generate the unique _id) -> Mongodb 