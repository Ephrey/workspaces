import React from 'react'; 
import Task from '../../commons/Task';
import InforMessage from '../../commons/InfoMessage';


function AllTAsks(props) {
    const {
        setTaskAsDone, 
        categories,
        category, 
        categoryId, 
        tasks,
        taskToBeLoad
     } = props;
     
    const { status, data } = tasks;
    
    let categoryName = category;
    
    let tasksList = null ;
    if(category === "all") {
        tasksList = data
    } else {
        tasksList = data.filter(task => task.category.id === categoryId);
        const categoryDetails = categories.filter(category => category.id === categoryId)[0];
        categoryName = categoryDetails.name;
    } 

    let text = "";
     
    if(taskToBeLoad === "undone") {
        tasksList = tasksList.filter(task => task.done === false);
        text = `Nothing ${categoryName.toUpperCase()} related planned`;
    } else if (taskToBeLoad === "done") {
        tasksList = tasksList.filter(task => task.done === true);
        text = `You've not Done any task in ${categoryName.toUpperCase()}`;
    }
    
    const tasksSize = tasksList.length;  

    let tasksOutput = "";

    if(status === "empty" || !tasksSize) {
        const message = text;
        const subTitle = "Click the plus button bellow to start creating tasks";
        tasksOutput = <InforMessage title={message} subTitle={subTitle} />

    } else {
        tasksOutput = tasksList.map((task, index) => { 
            
            const {id} = task;
            const catName = category.toLowerCase();
            let classes = `task ${category}_border_left`;
            if(index === tasksSize) {
                classes += " mb_30";
            }

            if(taskToBeLoad === "undone") {
                return <Task 
                    key={id} 
                    setTaskAsDone={setTaskAsDone}
                    details={task}
                    classes={classes} 
                    color={`${catName}_color`}
                    bg={`${catName}_bg`} 
                    catName={`${catName}`}
                    to={`/task_details/${id}`}
                />
            }

            return <Task  
                key={id} 
                details={task}
                classes={classes} 
                taskToBeLoad={taskToBeLoad}
                color={`${catName}_color`}
                bg={`${catName}_bg`}  
            />
        });
    }
    


    return(
        <div className="category_tasks_content">
            {tasksOutput}
        </div>
    );
}

export default AllTAsks;