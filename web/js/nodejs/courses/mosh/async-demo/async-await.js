// getUser(1)
//     .then(user => getRepos(user.name))
//     .then(repos => getCommits(repos[0]))
//     .then(commits => console.log(commits))
//     .catch(err => console.log('Error : ' + err.message));


async function displayCommit() {
    try {
        const user = await getUser(1);
        const repos = await getRepos(user.name);
        const commits = await getCommits(repos);
        console.log(commits);
    } catch(err) {
        console.log('Error : ' + err.message);
    }
}

displayCommit();

function getUser(id) {
    return new Promise((resolve) => {
        setTimeout(() => {
            console.log('Reading the user from a database ...');
            resolve({id: id, gitHubUsername: 'mosh'});
            // reject(new Error('Nooooooo'));
        }, 2000);
    })
}

function getRepos(userName) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            console.log('Requesting repos for user ');
            // resolve(['repo1', 'repo2', 'repo3']);
            reject(new Error('404'));
        }, 2000)
    })
}

function getCommits(repos) {
    return new Promise((resolve) => {
        setTimeout(() => {
            console.log('Getting commits ...')
            resolve(['commit1', 'commit2', 'commit3']);
        }, 2000); 
    })  
}