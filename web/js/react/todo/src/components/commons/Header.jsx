import React from 'react';
import { Link } from 'react-router-dom';

function Header(props) {
    let {title, subTitle, userProfile, iconSize, to} = props;
    subTitle = subTitle ? <span>{subTitle}</span>  : "";

    if(!userProfile) {
        userProfile = "/assets/icons/common/close_button.svg"
        iconSize += " close_icon"
    }
    if(!to) to = "/";
    return (
        <div className="header_container">
            <div className="header_panel_left">
                <h1>{title}</h1>
                {subTitle}
            </div>
            <div className="header_panel_right">
                <Link to={to}>
                    <img className={iconSize} src={userProfile} alt=""/>
                </Link>
            </div>
        </div>
    );
}

export default Header;