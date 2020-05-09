import React from 'react';
import { useParams } from 'react-router-dom';
import { TodosConsumer } from '../Context/TodosContext';
import TopSection from './partials/category_tasks/TopSection';
import AllTasks from './partials/category_tasks/AllTasks';
import StatusHeader from './partials/category_tasks/StatusHeader';
import ActionButton from './commons/ActionButton';

function CategoryTasks() {
    const {category, id} = useParams();
    return(
        <TodosConsumer>
            {todos => (
                <div className="category_tasks_container">
                    <TopSection 
                        from={todos.from} 
                        categoryId={id}
                        categories={todos.categories}
                    />
                    <div className="tasks_container">
                        <StatusHeader 
                            category={category} 
                            taskToBeLoad={todos.taskToBeLoad}
                            setTaskToBeLoad={todos.setTaskToBeLoad}
                        />
                        <AllTasks 
                            setTaskAsDone={todos.setTaskAsDone}
                            taskToBeLoad={todos.taskToBeLoad}
                            categories={todos.categories}
                            category={category}
                            categoryId={id} 
                            tasks={todos.tasks}
                        />
                    </div>
                    <ActionButton 
                        setCategoryNameAndId={todos.setCategoryNameAndId}
                        setBackTo={todos.setBackTo} 
                        backTo={`/category_tasks/${category}/${id}`}
                        icon="white_plus"
                        customClasses={`${category}_bg`}
                        to="/create_task/form"
                        categoryId={id}
                        categoryName={category}
                    />
                </div>
            )}
        </TodosConsumer>
    );
}

export default CategoryTasks;