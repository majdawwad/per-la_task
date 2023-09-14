part of 'todo_text_bloc.dart';

abstract class TodoTextState extends Equatable {
  const TodoTextState();

  @override
  List<Object> get props => [];
}

final class TodoTextInitial extends TodoTextState {}

class LoadingTodosTextsState extends TodoTextState {}

class LoadedTodosTextsState extends TodoTextState {
  final List<TodoText> todosTests;

  const LoadedTodosTextsState({
    required this.todosTests,
  });

  @override
  List<Object> get props => [todosTests];
}
class LoadTodosTextsState extends TodoTextState {
  final String message;

  const LoadTodosTextsState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ErrorTodosTextsState extends TodoTextState {
  final String message;

  const ErrorTodosTextsState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
