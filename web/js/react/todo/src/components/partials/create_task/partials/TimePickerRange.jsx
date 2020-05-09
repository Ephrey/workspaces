import React from 'react';

function TimePickerRange(props) {
    const {title, icon, customStyle} = props;
    return(
        <div className={`time_picker_main_container time_container ${customStyle}`}>
            <div className="time_picker_header">
                <img src={`/assets/icons/common/${icon}.svg`} alt=""/>
                <p>{title}</p>
            </div>
            <div className="time_range_container">
                <div>
                    <p>Start</p>
                    <div className="time_range time_start_container">
                        <div className="tr_hours tr_start_hours">00</div>
                        <div className="tr_separator">:</div>
                        <div className="tr_minutes tr_start_minutes">00</div>
                        <div className="tr_period tr_start_period">AM</div>
                    </div>
                </div>
                <div>
                    <p>End</p>
                    <div className="time_range time_end_container">
                        <div className="tr_hours tr_end_hours">00</div>
                        <div className="tr_separator">:</div>
                        <div className="tr_minutes tr_end_minutes">00</div>
                        <div className="tr_period tr_end_period">AM</div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default TimePickerRange;