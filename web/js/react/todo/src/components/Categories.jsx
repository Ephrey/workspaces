import React from 'react';
import { TodosConsumer } from '../Context/TodosContext';
import Header from './commons/Header';
import CategoriesList from './partials/categories/CategoriesList';
import ActionButton from './commons/ActionButton';
import CreateCategoryPopUp from './partials/categories/CreateCategoryPopUp';
import { 
    showModel, 
    hideModel, 
    showActionButton,
    hideActionButton
} from '../components/commons/helpers/functions/Functions';

function Categories() {
    return(
        <div className="">
            <Header
                title="Categories"
                iconSize="small_icon"
            />
            <TodosConsumer>
                {todos => (
                    <CategoriesList categories={todos.categories} />
                )}
            </TodosConsumer>
            <ActionButton 
                icon="black_plus"
                customClasses="primary_btn"
                handleOnClick={() => {
                    showModel();
                    hideActionButton()
                }}
            /> 
            <CreateCategoryPopUp 
                hideModel={hideModel}
                showActionButton={showActionButton}
            />
        </div>
    );
}

export default Categories;