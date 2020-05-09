import React from 'react';
import { TodosConsumer } from '../../../Context/TodosContext';
import Header from '../../commons/Header';
import ActionButton from '../../commons/ActionButton';
import TimePickerRange from '../create_task/partials/TimePickerRange';
import TimePicker from './partials/TimePicker';


function NewTaskCreationForm() {
    return(
        <TodosConsumer>
            {todos => (
                <div>
                    <Header iconSize="small_icon" to={todos.back}/>
                    <div className="create_task_container time_container">
                        <div className="title_container">
                            <h3>New Task</h3>
                        </div>
                        <div className="form_container">
                            <div className="form_content">
                                <input onChange={todos.setTaskBody} autoFocus={true} placeholder="What are you planning for today ?" type="text"/>
                                <TimePickerRange 
                                    title="Pick Up a Time Range"
                                    icon="clock_new_task"
                                />
                                <TimePicker setNewTaskTimeRange={todos.setNewTaskTimeRange} />
                            </div>
                            <div className="card card_secondary second_btn"></div>
                            <div className="card card_primary primary_btn"></div>
                        </div>
                    </div>
                    <ActionButton 
                        handleOnClick={todos.createNewTask}
                        icon="done_yellow"
                        customClasses="secondary_btn"
                    />
                </div>
            )}
        </TodosConsumer>
    );
}

export default NewTaskCreationForm;