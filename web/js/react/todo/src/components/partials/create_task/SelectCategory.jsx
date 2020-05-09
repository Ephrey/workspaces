import React from 'react';
import { TodosConsumer } from '../../../Context/TodosContext';
import Header from '../../commons/Header';
import CategoriesList from '../categories/CategoriesList';
import ActionButton from '../../commons/ActionButton';


function SelectCategory() {
    return (
        <TodosConsumer>
            {todos => (
                <React.Fragment>
                    <Header 
                        title="Select a Category" 
                        iconSize="small_icon" 
                        to="/"
                    />
                    <CategoriesList categories={todos.categories} hideTaskCounter={true}/>
                    <ActionButton 
                        icon="next_arrow" 
                        customClasses="secondary_btn hide_action_button" 
                        to="/create_task/form"
                    />
                </React.Fragment>
            )}
        </TodosConsumer>
    );
}

export default SelectCategory;