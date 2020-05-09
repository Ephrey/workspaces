import React from 'react';
import { Switch, Route } from 'react-router-dom';
import './Normalizer.css';
import './CustomBootstrap.css';
import './Main.css';
import Index from './components/Index';
import Categories from './components/Categories';
import CategoryTasks from './components/CategoryTasks';
import AllCategoriesTasks from './components/AllCategoriesTasks'
import CreateTask from './components/CreateTask';

function Todo() {
  return (
    <div className="todo_main_container">
      <div className="nosh"></div>
      <div className="alert_message hide_alert_message">This is a message alert that alert the user when an alert occured ... :)</div>
      <Switch>
        <Route exact path="/" component={Index} />
        <Route exact path="/categories" component={Categories} />
        <Route exact path="/category_tasks/:category/:id" component={CategoryTasks} />
        <Route exact path="/category_tasks/:id" component={AllCategoriesTasks} />
        <Route exact path="/create_task/:step" component={CreateTask} />
      </Switch>
    </div>
  );
}

export default Todo;
