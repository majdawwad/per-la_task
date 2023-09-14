part of 'todo_text_bloc.dart';

abstract class TodoTextEvent extends Equatable {
  const TodoTextEvent();

  @override
  List<Object> get props => [];
}


class GetAllTodosTextsEvent extends TodoTextEvent{}

class AddTodoTextEvent extends TodoTextEvent {
  final TodoText todoText;
  const AddTodoTextEvent({
    required this.todoText,
  });

   @override
  List<Object> get props => [todoText];
}

class UpdateTodoTextEvent extends TodoTextEvent {
  final TodoText todoText;
  const UpdateTodoTextEvent({
    required this.todoText,
  });

   @override
  List<Object> get props => [todoText];
}

class DeleteTodoTextEvent extends TodoTextEvent {
  final int todoTextId;
  const DeleteTodoTextEvent({
    required this.todoTextId,
  });

   @override
  List<Object> get props => [todoTextId];
}
