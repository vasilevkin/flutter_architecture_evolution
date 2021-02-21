import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/todo_list.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/visibility_filter.dart';
import 'package:provider/provider.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TodoList>(context);

    return Column(
      children: [
        Observer(
          builder: (_) {
            final selections = VisibilityFilter.values
                .map((f) => f == list.filter)
                .toList(growable: false);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(8),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(Constants.exampleTodosAll),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(Constants.exampleTodosPending),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(Constants.exampleTodosCompleted),
                      ),
                    ],
                    onPressed: (index) {
                      list.filter = VisibilityFilter.values[index];
                    },
                    isSelected: selections,
                  ),
                ),
              ],
            );
          },
        ),
        Observer(
          builder: (_) => ButtonBar(
            children: [
              RaisedButton(
                onPressed:
                    list.canRemoveAllCompleted ? list.removeCompleted : null,
                child: const Text(Constants.exampleTodosRemoveCompleted),
              ),
              RaisedButton(
                onPressed:
                    list.canMarkAllCompleted ? list.markAllAsCompleted : null,
                child: const Text(Constants.exampleTodosMarkCompleted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
