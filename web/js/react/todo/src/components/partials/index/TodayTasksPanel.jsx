import React from 'react';
import SectionTitleAndSeeAllLink from '../../commons/SectionTitleAndSeeAllLink';
import Task from '../../commons/Task';
import Loader from '../../commons/Loader'; 
import InfoMessage from '../../commons/InfoMessage';
import { isDefaultCategory } from '../../commons/helpers/functions/Functions';


function TodayTasksPanel(props) {
    const { tasks, setTaskAsDone } = props
    let { status, data} = tasks; 

    const undoneTasks = data.filter(task => task.done === false);
    const tasksSize = undoneTasks.length;
    
    if(!tasksSize && status === "ok") status = "empty";

    let tasksList = undoneTasks.map((task, index) => {
        const { 
            id,
            category
        } = task;

        let catName = category.name.toLowerCase();
        if(!isDefaultCategory(catName)) catName = "other";
        
        let classes = `task ${catName}_border_left`;
        if(index === tasksSize - 1) classes += " mb_30";

        return <Task 
            setTaskAsDone={setTaskAsDone}
            details={task}
            key={id} 
            classes={classes} 
            color={`${catName}_color`}
            bg={`${catName}_bg`} 
            catName={`${catName}`}
        />
    });
    
    let titleAndSeeAllLink = <SectionTitleAndSeeAllLink title="Today" to={`category_tasks/all`}/>;
    
    if(status === "unload") {
        titleAndSeeAllLink = "";
        tasksList = <Loader />
    }
    
    if(status === "empty") {
        titleAndSeeAllLink = "";
        tasksList = <InfoMessage 
            title="You have no tasks for today" 
            subTitle="Click the plus button bellow to start creating tasks" 
        />
    }
    
    return (
        <div>
            {titleAndSeeAllLink}
            <div className="today_task_container">
                {tasksList}
            </div>
        </div>
    );
}

export default TodayTasksPanel;