import React from 'react';


function TaskStatusPanel(props) {
    const { tasks } = props; 
    
    const undoneTasks = tasks.filter(task => task.done === false);
    const doneTasks = tasks.filter(task => task.done === true);
    console.log(tasks);
    const undoneTasksSize = undoneTasks.length;
    const doneTasksSize = doneTasks.length;
     
    let totalTasks = undoneTasksSize;
    if(totalTasks < 10) totalTasks = "0" + totalTasks;

    let nextTaskText = undoneTasksSize > 0 
    ? undoneTasks[0].body 
    : "Seems like you have no up coming task";

    return (
        <div className="task_status_panel_container">
            <div className="task_status_panel_content">
                <div className="next_task">
                    <h3>Your Next Task</h3>
                    <p>{nextTaskText}</p>
                </div>
                <div className="done_task_counter">
                    <h2>{doneTasksSize}/{totalTasks}</h2>
                    <p>Done !</p>
                </div>
            </div>
        </div>
    )
}

export default TaskStatusPanel;