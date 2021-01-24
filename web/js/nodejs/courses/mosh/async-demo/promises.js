const p = new Promise((resolve, reject) => {
    console.log('Please wait ...');
    setTimeout(() => {
        // resolve(1);
        reject(new Error('Something went horribly wrong ... :('));
    }, 2000);
});

p.then(result => console.log('Result : ' + result))
.catch(err => console.log('Error : ' + err.message));