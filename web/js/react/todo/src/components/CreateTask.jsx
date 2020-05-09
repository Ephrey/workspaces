import React from 'react';
import SelectCategory from './partials/create_task/SelectCategory';
import NewTaskCreationFrom from './partials/create_task/NewTaskCreationForm';
import { useParams } from 'react-router-dom';

function CreateTask(props) {
    const {step} = useParams();
    const screen = (step === "select_category") 
                   ? <SelectCategory /> : <NewTaskCreationFrom />
    return(
        <div className="">
           {screen}
        </div>
    );
}

export default CreateTask;