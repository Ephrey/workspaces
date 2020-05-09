import React from 'react';
import { Link } from 'react-router-dom';
import { isPlural } from '../../commons/helpers/functions/Functions'

function TopSection(props) {
    const { categoryId, categories, from, totalTasks} = props;
    
    let categoryName = categoryId;
    let name = categoryId.toUpperCase();
    let tasks = totalTasks;
    
    if(categoryId !== "all") {
        let categoryDetails = categories.filter(category => category.id === categoryId)[0];

        name = categoryDetails.name;
        tasks = categoryDetails.tasks;

        let category = categoryDetails.category;
        categoryName = category ? category.toLowerCase() : name.toLowerCase();
    }
 
    
    let goTo = from;
    if(from === "categories") goTo = "/categories";
    if(from === "home") goTo = "/";

    const bgIcon = {backgroundImage: `url(/assets/icons/category_tasks/${categoryName}.svg)`}
    return (
        <div style={bgIcon} className={`top_container ${categoryName}_bg`}>
            <Link to={`${goTo}`}>
                <img className="close_icon" src="/assets/icons/common/close_button.svg" alt=""/>
            </Link>
            <h3>{name}</h3>
            <p>{tasks} task{isPlural(tasks)}</p>
        </div>
    );
}

export default TopSection;