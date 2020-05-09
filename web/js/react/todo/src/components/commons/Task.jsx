import React from 'react';
import { 
    isDefaultCategory,
    getDiffMinutesBetweenTwoDate,
    timeConvert
} from '../commons/helpers/functions/Functions';
import CustomDate from './helpers/classes/CustomDate';


function Task(props) {
    let { setTaskAsDone, details, classes, color, catName, taskToBeLoad, bg} = props;
    
    const {id, body, startTime, category } = details;
    
    if(taskToBeLoad === "done") {
        return (
            <div className={classes}>
                <div className="task_content">
                    <h4>{body}</h4>
                    <div className="task_start_time">
                        <p className={`time ${color}`}>12h ago</p> 
                    </div>
                </div>
                <div className="task_staus">
                    <div className={`set_as_done_btn ${bg}`}></div>
                </div>
            </div>
        );
    }

    const time = startTime.split(' ')[1];
    const hours = time.split(':')[0];
    const period = Number(hours) >= 12 ? "pm" : "am";

    const today = new CustomDate();
    const nowDate = today.getFullDateWithTime();
    const minutes = getDiffMinutesBetweenTwoDate(nowDate, startTime);
    const remainingTime = timeConvert(minutes);

    if(!isDefaultCategory(catName)) {
        catName = "other";
        color = "other_color";
    } 
    
    const border = {
        border: `1px solid var(--${catName})`
    }
    
    return (
        <div className={classes}>
            <div className="task_content">
                <h4>{body}</h4>
                <div className="task_start_time">
                    <p className={`time ${color}`}>{time} {period}</p>
                    <p className="separator"></p>
                    <p className={`start ${color}`}>{remainingTime}</p>
                    <p className="separator"></p>
                    <p className={`start fade_color`}>{category.name}</p>
                </div>
            </div>
            <div className="task_staus">
                <div data-ref={id} onClick={setTaskAsDone} style={border} className={`set_as_done_btn`}></div>
            </div>
        </div>
    );
}

export default Task;