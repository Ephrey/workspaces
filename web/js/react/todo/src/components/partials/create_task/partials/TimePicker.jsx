import React from 'react';
import DateRangePicker from 'react-datetime-range-picker';



function handleOnChange(timeRange) {
    document.querySelector('.rdtSwitch').innerHTML = '';
    const start = timeRange.start.toString();
    const end = timeRange.end.toString();
    setTimeRange(start, 'start');
    setTimeRange(end, 'end');
}


function setTimeRange(time, when) {
    const timeParts = time.split(' ')[4].split(':');
    let hours = Number(timeParts[0]);
    let minutes = Number(timeParts[1]);

    if(hours < 10) hours = "0" + hours;
    if(minutes < 10) minutes = "0" + minutes;
    const period = hours >= 12 ? "PM" : "AM";
    
    document.querySelector(`.tr_${when}_hours`).innerText   = hours;
    document.querySelector(`.tr_${when}_minutes`).innerText = minutes;
    document.querySelector(`.tr_${when}_period`).innerText  = period;
}

function hideOrShowActionButton() {
    const createTaskContainer = document.querySelector('.time_container');
    createTaskContainer.addEventListener('click', function() {
        const timePicker = document.querySelector('.rdtOpen');
        if(timePicker) {
            const actionBtn = document.querySelector('.action_button');
            actionBtn.classList.add('hide_action_button');
        } else {
            const actionBtn = document.querySelector('.action_button');
            actionBtn.classList.remove('hide_action_button');
        }
    })
}

function TimePicker(props) { 
    const settings = {
        viewMode : "time",
        className: "main_timerange_picker_container",
        onFocus : hideOrShowActionButton,
        onBlur  : hideOrShowActionButton,
        onChange: (timeRange) => {
            handleOnChange(timeRange);
            props.setNewTaskTimeRange(timeRange);
        }
    }
    return(
        <DateRangePicker {...settings} />
    );
}

export default TimePicker;