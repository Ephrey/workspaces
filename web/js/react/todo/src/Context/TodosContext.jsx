import React, { Component } from 'react';
import * as firebase from 'firebase/app';
import 'firebase/firestore';
import { 
    isDefaultCategory,
    showAlert,
    hideModel,
    showActionButton,
    hideActionButton,
    removeClass,
    getDiffMinutesBetweenTwoDate
} from '../components/commons/helpers/functions/Functions';
import CustomDate from '../components/commons/helpers/classes/CustomDate';


const TodoContext = React.createContext();

class TodosProvider extends Component {

    constructor(props) {
        super(props);
        this.state = {
            categories: [],
            tasks: {
                status: "unload",
                data: []
            },
            categoryName: "",
            newTask: {
                body: "",
                startTime: "",
                endTime: "",
                category: {
                    name:"", 
                    id: ""
                },
                location: "",
                date: "",
                done: false
            },
            back: "",
            from: "",
            taskToBeLoad: "undone"
        }
        this.db = firebase.firestore();
    }

    /* LIFE CYCLE HOOKS
    ======================================================= */

    componentDidMount() {
        this.getCategories();
        this.getAllTasks(); 
        
        setInterval(() => {
            this.removePastTaks(this.state.tasks.data);
        }, 60000)
    }

    
    /* GET/CREATE/SET CATEGORIES 
    ======================================================= */

    getCategories = () => {
        const categories = [];
        this.db.collection('categories')
        .orderBy('name')
        .get()
        .then(querySnapshot => {
            querySnapshot.docs.forEach(category => {
                categories.push({...category.data(), id: category.id});
            }); 
            this.setState({ categories });
        })
    }

    getSingleLocalCategory(id) {
        return this.state.categories.filter(category => category.id === id);
    }

    createCategory = () => {
        const name = this.state.categoryName;
        if(!name) {
            showAlert("Are you trying to create a Category without a name ? Really :( ", "error")
            return false;
        };
        const category = {name: name,tasks: 0}
        if(!isDefaultCategory(name.toLowerCase())) {
            category.category = "other";
        }
        this.db.collection('categories').add(category)
        .then(() => {
            this.getCategories();
            hideModel();
            showActionButton();
            showAlert('Category successfully created', 'success')
        })
    }
    
    setCategoryName = (e) => {
        const name = e.target.value;
        this.setState({ categoryName: name })
    }

    increaseTasksCounterPerCategory = (categoryId) => { 
        const {category, name, tasks } = this.getSingleLocalCategory(categoryId)[0];
        
        const totalTasks = tasks + 1; 
        
        const newCategory = {
            name: name,
            tasks: totalTasks 
        }

        if(category) newCategory.category = category;
        
        this.db.collection('categories').doc(categoryId)
        .set(newCategory)
        .then(() => {
            this.getCategories();
        });
    }

    decreaseTasksCounterPerCategory = (categoryId) => {  

        const {category, name, tasks} = this.getSingleLocalCategory(categoryId)[0];
        let totalTasks = tasks;
        totalTasks = totalTasks > 0 ? totalTasks - 1 : 0;
        
        const newCategory = {
            name: name,
            tasks: totalTasks
        }
        if(category) newCategory.category = category;

        this.db.collection('categories').doc(categoryId)
        .set(newCategory)
        .then(() => {this.getCategories()})
    }

    /* CREATE/GET/SET/SET AS DONE TASKS 
    ======================================================= */

    setSelectedCategory = (e) => {
        const category = e.target
        let categoryId = category.dataset.id;
        categoryId = categoryId ? categoryId : category.parentElement.dataset.id;
        
        const categories = document.querySelectorAll('.category');
        categories.forEach(category => {
            const cat = category.dataset.cat;
            if(categoryId === category.dataset.id) {
                category.classList.add(`${cat}_bg`);
            } else {
                category.classList.remove(`${cat}_bg`);
            }
        })

        const {name, id} = this.getSingleLocalCategory(categoryId)[0];
        this.setCategoryNameAndId(name, id); 
        showActionButton();
    }

    /**
     * @var {String} name
     * @var {int} id
     */
    setCategoryNameAndId = (name, id) => { 
        const newTask = this.state.newTask;
        newTask.category.name = name;
        newTask.category.id = id;

        this.setState({
            newTask
        });
    }

    setTaskBody = (e) => {
        const body = e.target.value;
        const newTask = this.state.newTask;
        newTask.body = body;
        this.setState({
            newTask
        });
    }

    setNewTaskTimeRange = (timeRange) => {
        const start = timeRange.start.toString().split(' ')[4].split(':');
        const end = timeRange.end.toString().split(' ')[4].split(':');
        
        let startHours = Number(start[0]);
        let startMinutes = Number(start[1]);

        let endHours = Number(end[0]);
        let endMinutes = Number(end[1]);

        if(startHours < 10) startHours = "0" + startHours;
        if(startMinutes < 10) startMinutes = "0" + startMinutes;
        
        if(endHours < 10) endHours = "0" + endHours;
        if(endMinutes < 10) endMinutes = "0" + endMinutes;

        const today = new CustomDate();
        const date = today.getFullDateWithoutTime();

        const startTime = `${date} ${startHours}:${startMinutes}`;
        const endTime = `${date} ${endHours}:${endMinutes}`;

        const newTask = this.state.newTask;
        newTask.startTime = startTime;
        newTask.endTime = endTime;
        newTask.date = date; 

        this.setState({
            newTask
        });

        //
        console.log(this.state.newTask);
    }
    
    createNewTask = () => {
        hideActionButton();
        showAlert('Creating ... :)', 'warning');

        const newTask = this.state.newTask;
        const categoryId = newTask.category.id; 

        this.db.collection('todos').add(newTask)
        .then(() => {
            this.increaseTasksCounterPerCategory(categoryId);
            removeClass('alert_message', 'alert_warning');
            showAlert('Task successfully created :)', 'success');
            
            this.getAllTasks();
            showActionButton();
        });
    }
    
    getAllTasks = () => {
        const tasks = [];
        
        const data = new CustomDate();
        const today =  data.getFullDateWithoutTime(); 

        this.db.collection('todos')
        .where('date', '==', today)
        .orderBy('startTime')
        .get()
        .then(querySnapshot => {
            querySnapshot.docs.forEach((task) => {
                const taskData = task.data(); 
                tasks.push({...taskData, id: task.id});
            });  

            this.removePastTaks(tasks); 
        });
    }

    removePastTaks = (tasks) => {
        const cleanedTasks = {
            status: "empty",
            data: []
        };

        const today = new CustomDate();
        const nowDate = today.getFullDateWithTime();

        tasks.forEach((task) => {
            const startTime = task.startTime;
            // const minutes = getDiffMinutesBetweenTwoDate(nowDate, startTime);
            
            // if(startTime > nowDate && minutes > 0) {
            //     cleanedTasks.data.push(task);
            // }  

            console.log(startTime <= nowDate && !task.done);
            if(startTime <= nowDate && !task.done) { 
                this.decreaseTasksCounterPerCategory(task.category.id);  
                task.done = true;
                    console.log('in');
                this.db.collection('todos')
                .doc(`${task.id}`)
                .set(task);
            }

            cleanedTasks.data.push(task);
        });

        if(cleanedTasks.data.length > 0) {
            cleanedTasks.status = "ok";
        }
        
        this.setState({tasks: cleanedTasks});
    }
    
    setTaskAsDone = (e) => {    
        showAlert("Processing... Please wait :)", "warning");
        const taskId = e.target.dataset.ref;  

        const doneTask = this.getSingleLocalTask(taskId)[0];
        doneTask.done = true;
        
        this.db.collection('todos').doc(`${taskId}`)
        .set({...doneTask})
        .then(() => { 
            removeClass('alert_message', 'alert_warning');
            showAlert("Task set as Done. Keep it up :)", "success");

            const tasks = [...this.state.tasks.data];
            const indexOfDoneTask = tasks.indexOf(doneTask); 
            tasks[indexOfDoneTask] = doneTask;
            
            let status = "ok"; 
            if(!tasks.length) status = "empty";

            this.setState({
                tasks : {
                    status: status,
                    data: tasks
                }
            });
            
            this.decreaseTasksCounterPerCategory(doneTask.category.id);
        });
    }

    getSingleLocalTask = (taskId) => {
        return this.state.tasks.data.filter(task => task.id === taskId);
    }

    setTaskToBeLoad = (e) => {
        const taskKind = e.target.dataset.ref; 

        this.setState({
            taskToBeLoad : taskKind
        });
    }


    /* SET BACK PAGE */
    setBackTo = (target) => {
        this.setState({
            back: target
        })
    }

    setFrom = (src) => {
        this.setState({
            from: src
        })
    }


    render() {
        return(
            <TodoContext.Provider value={{
                ...this.state,
                createCategory : this.createCategory,
                setCategoryName: this.setCategoryName,
                setSelectedCategory: this.setSelectedCategory,
                setTaskBody: this.setTaskBody,
                setNewTaskTimeRange: this.setNewTaskTimeRange,
                setCategoryNameAndId : this.setCategoryNameAndId,
                createNewTask: this.createNewTask,
                setTaskAsDone: this.setTaskAsDone,
                setTaskToBeLoad: this.setTaskToBeLoad,
                setBackTo: this.setBackTo,
                setFrom: this.setFrom
            }}>
                {this.props.children}
            </TodoContext.Provider>
        );
    }
}

const TodosConsumer = TodoContext.Consumer;

export { TodosProvider, TodosConsumer };