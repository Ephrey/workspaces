import React from 'react';
import { useParams } from 'react-router-dom';
import { TodosConsumer } from '../Context/TodosContext';
import TopSection from './partials/category_tasks/TopSection';
import AllTasks from './partials/category_tasks/AllTasks';
import StatusHeader from './partials/category_tasks/StatusHeader';
import ActionButton from './commons/ActionButton';

function AllCategoriesTasks() {
    const {id} = useParams();
    return(
        <TodosConsumer>
            {todos => (
                <div className="category_tasks_container">
                    <TopSection 
                        from={"home"} 
                        categoryId={id}
                        categories={todos.categories}
                        totalTasks={todos.tasks.data.length}
                    />
                    <div className="tasks_container">
                        <StatusHeader category="all"/>
                        <AllTasks
                            setTaskAsDone={todos.setTaskAsDone}
                            category="all"
                            categoryId="" 
                            tasks={todos.tasks}
                        />
                    </div>
                    <ActionButton  
                        setBackTo={todos.setBackTo} 
                        backTo={`/category_tasks/all`}
                        icon="white_plus"
                        customClasses="all_bg"
                        to="/create_task/select_category"  
                    />
                </div>
            )}
        </TodosConsumer>
    );
}


export default AllCategoriesTasks;