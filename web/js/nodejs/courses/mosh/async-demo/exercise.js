
// getCustomer(1, (customer) => {
//   console.log('Customer: ', customer);
//   if (customer.isGold) {
//     getTopMovies((movies) => {
//       console.log('Top movies: ', movies);
//       sendEmail(customer.email, movies, () => {
//         console.log('Email sent...')
//       });
//     });
//   }
// });

// async function notifyCustomer() {
//   try {
//     const customer = await getCustomer(1);
//     console.log('Customer : ', customer);
//     const topMovies = await getTopMovies(customer);
//     console.log('Top movies : ', topMovies);
//     await sendEmail(customer.email, topMovies);
//     console.log('Email sent ...');
//   } catch(err) {
//     console.log('Error : ' + err.message)
//   };
// }

async function notifyCustomer() {
  const customer = await getCustomer(1);
  console.log('Customer : ', customer);
  if(customer.isGold) {
    const topMovies = await getTopMovies(customer);
    console.log('Top movies : ', topMovies);
    await sendEmail(customer.email, topMovies);
    console.log('Email sent ...');
  }
}

notifyCustomer();

function getCustomer(id) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ 
        id: 1, 
        name: 'Mosh Hamedani', 
        isGold: true, 
        email: 'email' 
      });
    }, 4000);  
  });
}

function getTopMovies(customer) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      customer.isGold ? resolve(['movie1', 'movie2']) : reject(new Error('Customer is not Gold'));
    }, 4000);
  });
}

function sendEmail(email, movies) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, 4000);
  })
}