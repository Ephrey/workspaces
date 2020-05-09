import React from 'react';
import { TodosConsumer } from '../../../Context/TodosContext';
import { Link } from 'react-router-dom';
import Loader from '../../commons/Loader';
import { isDefaultCategory, isPlural } from '../../commons/helpers/functions/Functions';


function CategoriesList(props) {
    const { categories, hideTaskCounter } = props;

    let cats_blocks = "";

    if(categories.length > 0) {
        const categoriesSize = categories.length - 1;
        
        const cats = categories.map((singleCategory, index) => {
            const { id, name, tasks, category } = singleCategory;
            let cat = name.toLowerCase();
            if(category === "other" && !isDefaultCategory(cat)) cat = category.toLowerCase();
            const icon = '/assets/icons/'+cat+'.svg';
            
            let catsClassNames = "category";
            if(index === categoriesSize) catsClassNames += " mb_30";

            let taskCounter = <p className="tasks_counter">{tasks} task{isPlural(tasks)}</p>;
            
            if(!hideTaskCounter) {
                return <TodosConsumer key={id} >
                    {todos => (
                        <Link 
                            to={`/category_tasks/${cat}/${id}`}
                            onClick={() => {
                                todos.setBackTo("/categories");
                                todos.setFrom("categories");
                            }}
                        >
                            <div className={catsClassNames}>
                                <img alt="category icon" src={icon}/>
                                <h3 className="name">{name}</h3>
                                {taskCounter}
                            </div>
                        </Link>
                    )}
                </TodosConsumer>
                
            } else {
                if(cat === "all") return <React.Fragment key={0} />;
        
                return <TodosConsumer key={id}>
                    {todos => ( 
                        <div>
                            <div 
                            onClick={todos.setSelectedCategory} 
                            data-id={id} 
                            data-cat={cat}
                            className={catsClassNames}
                            >
                                <img alt="category icon" src={icon}/>
                                <h3 className="name">{name}</h3>
                                {taskCounter}
                            </div> 
                        </div>
                    )}
                </TodosConsumer>
            }
        });
        cats_blocks = 
            <div className="categories_list_container">
                {cats}
            </div>

    } else {
        cats_blocks = <Loader />
    }
    return(
        <React.Fragment>
            {cats_blocks}
        </React.Fragment>
    );
}

export default CategoriesList;