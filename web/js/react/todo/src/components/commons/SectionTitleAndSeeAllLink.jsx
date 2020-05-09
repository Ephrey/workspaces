import React from 'react';
import {Link} from 'react-router-dom';

function SectionTitleAndSeeAllLink(props) {
    const {title, to} = props;
    return(
        <div className="categories_title_and_see_all">
            <h3>{title}</h3>
            <Link to={to}>See All</Link>
        </div>
    );
}

export default SectionTitleAndSeeAllLink;