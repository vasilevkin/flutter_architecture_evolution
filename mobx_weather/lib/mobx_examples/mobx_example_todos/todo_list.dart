import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/todo.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_todos/visibility_filter.dart';

part 'todo_list.g.dart';

@jsonSerializable
class TodoList extends _TodoList with _$TodoList {}

@jsonSerializable
abstract class _TodoList with Store {
  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @observable
  @JsonProperty(defaultValue: VisibilityFilter.all)
  VisibilityFilter filter;

  @computed
  ObservableList<Todo> get pendingTodos =>
      ObservableList.of(todos.where((todo) => todo.done != true));

  @computed
  ObservableList<Todo> get completedTodos =>
      ObservableList.of(todos.where((todo) => todo.done == true));

  @computed
  bool get hasCompletedTodos => completedTodos.isNotEmpty;

  @computed
  bool get hasPendingTodos => pendingTodos.isNotEmpty;

  @computed
  String get itemsDescription {
    if (todos.isEmpty) {
      return Constants.exampleTodosNoTodos;
    }

    final suffix = pendingTodos.length == 1
        ? Constants.exampleTodosTodo
        : Constants.exampleTodosTodos;

    return '${pendingTodos.length} ${Constants.exampleTodosPending} $suffix, ${completedTodos.length} ${Constants.exampleTodosCompleted}.';
  }

  @computed
  @JsonProperty(ignore: true)
  ObservableList<Todo> get visibleTodos {
    switch (filter) {
      case VisibilityFilter.pending:
        return pendingTodos;
      case VisibilityFilter.completed:
        return completedTodos;
      default:
        return todos;
    }
  }

  @computed
  bool get canRemoveAllCompleted =>
      hasCompletedTodos && filter != VisibilityFilter.pending;

  @computed
  bool get canMarkAllCompleted =>
      hasPendingTodos && filter != VisibilityFilter.completed;

  @action
  void addTodo(String description) {
    final todo = Todo(description);
    todos.add(todo);
  }

  @action
  void removeTodo(Todo todo) {
    todos.removeWhere((element) => element == todo);
  }

  @action
  void removeCompleted() {
    todos.removeWhere((todo) => todo.done);
  }

  @action
  void markAllAsCompleted() {
    for (final todo in todos) {
      todo.done = true;
    }
  }
}
