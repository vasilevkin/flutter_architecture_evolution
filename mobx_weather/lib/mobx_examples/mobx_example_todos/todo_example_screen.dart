import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/todo_list.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/widgets/TodoListView.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/widgets/action_bar.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/widgets/add_todo.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/widgets/description.dart';
import 'package:provider/provider.dart';

class TodoExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider<TodoList>(
        create: (_) => TodoList(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Constants.exampleTodosTitle),
          ),
          body: Column(
            children: [
              AddTodo(),
              ActionBar(),
              Description(),
              TodoListView(),
            ],
          ),
        ),
      );
}
