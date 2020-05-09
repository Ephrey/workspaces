import React from 'react';
import { TodosConsumer } from '../../../Context/TodosContext';
import ModelPopUp from '../../commons/ModelPopUp';


function CreateCategoryPopUp(props) {
    const { hideModel, showActionButton } = props;
    const content = <TodosConsumer>
        {todos => (
            <React.Fragment>
                <input onChange={todos.setCategoryName} autoFocus={true} placeholder="Type in a category name" type="text"/>
                <div className="create_category_btn_container">
                    <button onClick={() => {hideModel(); showActionButton()}} className="cancel_create_category_btn">Cancel</button>
                    <button onClick={todos.createCategory} className="create_category_btn">Save</button>
                </div>
            </React.Fragment>
        )}
    </TodosConsumer>

    return(<ModelPopUp content={content}/>);
}

export default CreateCategoryPopUp;