class CustomDate {

    date;
    day;
    month;
    year;
    hours;
    minutes;

    constructor() {
        this.date = new Date();

        this.day = this.date.getDate();
        this.month = this.date.getMonth();
        this.year = this.date.getFullYear();

        this.hours = this.date.getHours();
        this.minutes = this.date.getMinutes();
    }

    getUTCDate() {
        return this.day;
    }

    getUTCMonth() {
        return this.month;
    }

    getFullYear() {
        return this.year;
    }
    
    getUTCHours() {
        return this.hours;
    }

    getUTCMinutes() {
        return this.minutes;
    }

    getFullDateWithTime() {
        let month = this.month;
        let day = this.day;
        let hours = this.hours;
        let minutes = this.minutes;
        
        if(month < 10) month = "0" + (month + 1);
        if(day < 10) day = "0" + day;
        if(hours < 10) hours = "0" + hours;
        if(minutes < 10) minutes = "0" + minutes;

        return `${this.year}/${month}/${day} ${hours}:${minutes}`;
    }

    getFullDateWithoutTime() {
        let month = this.month;
        let day = this.day;

        if(month < 10) month = "0" + (month + 1);
        if(day < 10) day = "0" + day;

        return `${this.year}/${month}/${day}`;
    }
}

export default CustomDate;