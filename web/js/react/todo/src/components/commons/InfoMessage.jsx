import React from 'react';


function InfoMessage(props) {
    const {title, subTitle } = props;
    return(
        <div className="info_message_container">
            <h3>{title}</h3>
            <p>{subTitle}</p>
        </div>
    );
}

export default InfoMessage;