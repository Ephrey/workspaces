import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/buttons/button_shape.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todos_list_model.dart';
import 'package:todo/widgets/custom_form_field.dart';

class AddTodoForm extends StatelessWidget {
  final Todo todo;

  AddTodoForm({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    final double _deviceHeight = _deviceSize.height;

    final EdgeInsets _padding = EdgeInsets.symmetric(
      vertical: _deviceHeight * .04,
      horizontal: _deviceSize.width * .05,
    );

    final LayoutBuilder _form = LayoutBuilder(
      builder: (context, constraints) =>
          _Form(parentSize: constraints, todo: todo),
    );

    return Container(
      height: _deviceHeight * .45,
      padding: _padding,
      color: Theme.of(context).cardColor,
      child: _form,
    );
  }
}

class _Form extends StatefulWidget {
  final parentSize;
  final Todo todo;

  _Form({Key key, this.parentSize, this.todo}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing;

  TextEditingController _taskNameController;
  TextEditingController _taskNoteController;

  @override
  void initState() {
    super.initState();
    _isEditing = (widget.todo != null);

    _taskNameController =
        TextEditingController(text: _isEditing ? widget.todo.task : null);
    _taskNoteController =
        TextEditingController(text: _isEditing ? widget.todo.note : null);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _divider = widget.parentSize.maxHeight * 0.05;

    final _taskField = CustomFormField(
      controller: _taskNameController,
      hint: 'Task name',
      isRequired: true,
    );

    final _noteField = CustomFormField(
      controller: _taskNoteController,
      hint: 'Task description',
      maxLines: 2,
    );

    final _submitButton = _SubmitButton(
      formKey: _formKey,
      todo: widget.todo,
      taskController: _taskNameController,
      noteController: _taskNoteController,
      parentSize: widget.parentSize,
    );

    final _formContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _FormTitle(isEditing: _isEditing),
        SizedBox(height: _divider),
        _taskField,
        SizedBox(height: _divider),
        _noteField,
        SizedBox(height: _divider),
        _submitButton,
      ],
    );

    return Form(key: _formKey, child: _formContent);
  }
}

class _FormTitle extends StatelessWidget {
  final bool isEditing;

  const _FormTitle({Key key, this.isEditing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _title = isEditing ? 'Edit Todo' : 'What\'s next ?';
    return Text(
      _title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final formKey;
  final Todo todo;
  final TextEditingController taskController;
  final TextEditingController noteController;
  final BoxConstraints parentSize;

  _SubmitButton({
    Key key,
    this.formKey,
    this.todo,
    this.taskController,
    this.noteController,
    this.parentSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<TodosListModel>(context);
    final _isEditing = (todo != null);

    void handleSubmit() async {
      if (formKey.currentState.validate()) {
        final _task = taskController.value.text;
        final _note = noteController.value.text;

        Todo newTodo = Todo(task: _task, note: _note);

        if (_isEditing) {
          newTodo.id = todo.id;
          final res = await _model.update(newTodo);
          if (res == true) Navigator.of(context).pop();
        } else {
          _model.add(newTodo);
        }

        formKey.currentState.reset();
      }
    }

    final _action = _isEditing ? 'Save' : 'Create';

    final _submitButton = FlatButton(
      child: Text(_action, style: Theme.of(context).textTheme.headline4),
      onPressed: handleSubmit,
    );

    return ButtonShape(
      parentSize: parentSize,
      color: Theme.of(context).primaryColor,
      child: _submitButton,
    );
  }
}
