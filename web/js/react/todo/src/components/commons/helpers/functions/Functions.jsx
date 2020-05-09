// import CustomDate from '../classes/CustomDate';

const DEFAULT_CATEGORIES = [
    'all',
    "home",
    'work',
    'shopping',
    'travel',
    'study',
    'music',
    'hobbies',
    'sport',
    'music'
];

const MONTH = [
    'January', 
    'Fabruary', 
    'Match', 
    'April', 
    'May', 
    'June', 
    'July', 
    'August', 
    'September', 
    'October', 'November', 
    'December'
];

export function isDefaultCategory(category) {
    return DEFAULT_CATEGORIES.indexOf(category) >= 0;
}

export function showAlert(message, alertType) {
    const alertBox = document.querySelector('.alert_message');
    alertBox.innerHTML = message;
    alertBox.classList.add(`alert_${alertType}`);
    alertBox.classList.remove('hide_alert_message');

    const hideAlert = setInterval(() => {
        alertBox.classList.add('hide_alert_message');
        removeClass('alert_message', `alert_${alertType}`);
        clearInterval(hideAlert);
    }, 5000)
}

export function removeClass(elementIdentifier, classToRemove){
    const element = document.querySelector(`.${elementIdentifier}`);
    element.classList.remove(classToRemove);
}

export function showModel() {
    const model = document.querySelector(".model_container");
    model.classList.remove('hide');
}

export function hideModel() {
    const model = document.querySelector(".model_container");
    model.classList.add('hide');
}

export function showActionButton() {
    const actionButton = document.querySelector(".action_button");
    actionButton.classList.remove('hide_action_button');
}

export function hideActionButton() {
    const actionButton = document.querySelector(".action_button");
    actionButton.classList.add('hide_action_button');
}


export function getDiffMinutesBetweenTwoDate(startDate, endDate) {
    var startTime = new Date(startDate);
    var endTime = new Date(endDate);
    var difference = endTime.getTime() - startTime.getTime(); // This will give difference in milliseconds
    return Math.round(difference / 60000);
}

export function timeConvert(n) {
    var num = n;
    var hours = (num / 60);
    var rhours = Math.floor(hours);
    var minutes = (hours - rhours) * 60;
    var rminutes = Math.round(minutes);

    if(rhours === 0) {
        return rminutes + " minute" + isPlural(minutes) + " to go"
    } 

    if(minutes === 0) {
        return rhours + "h" + isPlural(rhours) + " to go";
    }

    return rhours + "h" + isPlural(hours) + " and " + rminutes + " minute" + isPlural(rminutes) + " to go";
}

export function humanReadableDate(date) {
    const dateParts = date.split('/');
    const year = dateParts[0].substring(2,4);
    console.log(dateParts[1]);
    const month = MONTH[Number(dateParts[1]) - 1];
    const day = dateParts[2];

    return day + " " + month + " " + year;
}


export function humanReadableTime(time) {
    const timeParts = time.split(':');
    const hours = Number(timeParts[0]);
    const period = hours >= 12 ? "pm" : "am";
    
    return time + period;
}


export function isPlural(number) {
    return number > 1 ? "s" : "";
}

export function uFirst(string) {
    const firstWord = string[0].toUpperCase();
    const restOfWord = string.substring(1);
    return firstWord + restOfWord;
}

