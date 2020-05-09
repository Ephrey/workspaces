import React, { Component } from 'react';
import { TodosConsumer } from '../Context/TodosContext';
import Header from './commons/Header';
import TaskStatusPanel from './partials/index/TaskStatusPanel';
import CategoriesPanel from './partials/index/CategoriesPanel';
import TodayTasksPanel from './partials/index/TodayTasksPanel';
import ActionButton from './commons/ActionButton';
import * as moment from 'moment';

class Index extends Component {
    render() {
        return(
            <TodosConsumer>
                {todos => (
                    <div className="">
                        <Header 
                            title="TODO"
                            subTitle={moment().format('LL')}
                            userProfile="assets/imgs/user.png"
                            iconSize="profile_image_size"
                        />
                        <TaskStatusPanel 
                            nextTask={todos.nextTask} 
                            tasks={todos.tasks.data} 
                        />
                        <CategoriesPanel 
                            categories={todos.categories} 
                            setBackTo={todos.setBackTo}
                            setFrom={todos.setFrom}
                        />
                        <TodayTasksPanel setTaskAsDone={todos.setTaskAsDone} tasks={todos.tasks} />
                        <ActionButton 
                            icon="yellow_plus"
                            customClasses="secondary_btn"
                            to="/create_task/select_category"
                        />
                    </div>
                )}
            </TodosConsumer>
        );
    }
}

export default Index;