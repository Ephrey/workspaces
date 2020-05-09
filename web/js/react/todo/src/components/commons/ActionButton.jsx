import React from 'react';
import { Link } from 'react-router-dom';
import { uFirst } from './helpers/functions/Functions';

function ActionButton(props) {
    const {
        categoryId,
        categoryName,
        icon, 
        customClasses,  
        backTo,
        to, 
        handleOnClick,
        setBackTo, 
        setCategoryNameAndId
    } = props;
    const iconPath = "/assets/icons/common/"+icon+".svg";
    const classes = "action_button " + customClasses;
    
    let button = <div onClick={handleOnClick} className={classes} >
        <img alt="add task button" src={iconPath}/>
    </div>

    if(to) button = <Link
        onClick={() => {
            if(categoryId && categoryName) {
                setCategoryNameAndId(uFirst(categoryName), categoryId);
                setBackTo(backTo);
            }
        }}
        to={to}
    >{button}</Link>
    return (
        <React.Fragment>
            {button}
        </React.Fragment>
    )
}

export default ActionButton;