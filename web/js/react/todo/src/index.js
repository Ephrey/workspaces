import React from 'react';
import ReactDOM from 'react-dom';  
import { TodosProvider } from './Context/TodosContext';
import { BrowserRouter as Router } from 'react-router-dom';
import Todo from './Todo';
import * as serviceWorker from './serviceWorker';
import * as firebase from 'firebase/app';

const firebaseConfig = {
    apiKey: "AIzaSyC1zxC31VMd8zrWI91CZ6YyACVZzQkUqFM",
    authDomain: "todo-1bd62.firebaseapp.com",
    databaseURL: "https://todo-1bd62.firebaseio.com",
    projectId: "todo-1bd62",
    storageBucket: "todo-1bd62.appspot.com",
    messagingSenderId: "33227128331",
    appId: "1:33227128331:web:005429c20d7614ced3910e",
    measurementId: "G-TDE852YC21"
}; 
firebase.initializeApp(firebaseConfig);

ReactDOM.render(
    <TodosProvider>
        <Router>
            <Todo />
        </Router>
    </TodosProvider>,
document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
