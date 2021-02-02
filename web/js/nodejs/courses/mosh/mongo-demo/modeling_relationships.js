// Trade off between consistency and performance

// Using References (Normalization) -> CONSISTENCY
const author = {
    name: "Ephraim",
    id: "id"
}

const course = {
    name: "Node",
    author: "id"
}


// Using Embedded Documents (De-normalization) -> PERFORMANCE
const course = {
    name: "Node",
    author: {
        name: "Ephraim",
    }
}

// Hybrid
let author = {
    name: "Ephraim",
    // 50 properties
}

let course = {
    author: {
        id: "ref",
        "name": "Mosh"
    }
}