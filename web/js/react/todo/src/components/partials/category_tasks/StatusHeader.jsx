import React from 'react';

function StatusHeader(props) {
    const {
        category,
        taskToBeLoad,
        setTaskToBeLoad 
    } = props;

    let bg_undone = "";
    let bg_done = "";

    if(taskToBeLoad === "undone") bg_undone = category;
    if(taskToBeLoad === "done") bg_done = category;

    return(
        <div className="task_status_header">
            <div 
                onClick={setTaskToBeLoad} 
                data-ref="undone"
                className={`undone ${bg_undone}_border_bottom`}>Undone</div>
            <div 
                onClick={setTaskToBeLoad} 
                data-ref="done" 
                className={`done ${bg_done}_border_bottom`}>Done</div>
        </div>
    );
}

export default StatusHeader;