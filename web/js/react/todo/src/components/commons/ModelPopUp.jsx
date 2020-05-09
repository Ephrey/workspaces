import React from 'react';


function ModelPopUp(props) {
    const {content} = props;
    return(
        <div className="model_container hide">
            <div className="model_panel">
                {content}
            </div>
        </div>
    );
}

export default ModelPopUp;