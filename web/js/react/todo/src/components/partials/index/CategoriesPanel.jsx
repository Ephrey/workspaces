import React from 'react';
import { Link } from 'react-router-dom';
import SectionTitleAndSeeAllLink from '../../commons/SectionTitleAndSeeAllLink';
import Slider from './Carousel';
import Loader from '../../commons/Loader';
import { isDefaultCategory, isPlural } from '../../commons/helpers/functions/Functions';

function CategoriesPanel(props) {
    const { categories, setBackTo, setFrom } = props;
    
    let items = "";
    if(categories.length > 1) {
        items = categories.map((singleCategory) => {
            const { id, name, tasks, category } = singleCategory;
            let cat = name.toLowerCase();
            if(category === "other" && !isDefaultCategory(cat)) cat = category.toLowerCase();
    
            return <Link 
                    key={id} 
                    to={`category_tasks/${cat}/${id}`}
                    onClick={() => {
                        setBackTo("/");
                        setFrom("home");
                    }} 
                >
                <div className="category_panel">
                    <div className="category_icon">
                        <img src={`/assets/icons/category_card/${cat}.svg`} alt=""/>
                    </div>
                    <div className="category_details">
                        <h3>{name}</h3>
                        <p>{tasks} Task{isPlural(tasks)}</p>
                    </div>
                </div>
            </Link>
        });

        items = <Slider items={items} />
    } else {
        items = <Loader />
    }
    
    return(
        <div className="categories_carousel_container">
            <SectionTitleAndSeeAllLink title="Categories" to="/categories" />
            <div className="categories_carousel">
                {items};
            </div>
        </div>
    )
}

export default CategoriesPanel;