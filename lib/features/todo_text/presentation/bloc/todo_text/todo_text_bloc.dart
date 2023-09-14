// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perla_task_app/core/strings/messages.dart';
import 'package:perla_task_app/features/todo_text/domain/entities/todo_text.dart';
import 'package:perla_task_app/features/todo_text/domain/usecases/add_todo_text.dart';
import 'package:perla_task_app/features/todo_text/domain/usecases/get_all_todo_text.dart';
import 'package:perla_task_app/features/todo_text/domain/usecases/update_todo_text.dart';

import '../../../../../core/constants/type_def.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/delete_todo_text.dart';

part 'todo_text_event.dart';
part 'todo_text_state.dart';

class TodoTextBloc extends Bloc<TodoTextEvent, TodoTextState> {
  final GetAllTodoTextUseCase getAllTodoTextUseCase;
  final AddTodoTextUseCase addTodoTextUseCase;
  final UpdateTodoTextUseCase updateTodoTextUseCase;
  final DeleteTodoTextUseCase deleteTodoTextUseCase;

  TodoTextBloc({
    required this.getAllTodoTextUseCase,
    required this.addTodoTextUseCase,
    required this.updateTodoTextUseCase,
    required this.deleteTodoTextUseCase,
  }) : super(TodoTextInitial()) {
    on<TodoTextEvent>((event, emit) async {
      if (event is GetAllTodosTextsEvent) {
        emit(LoadingTodosTextsState());

        final FailureOrTodosTexts failureOrTodosTexts =
            await getAllTodoTextUseCase();
        emit(_mapFailureOrTodosTestsToState(failureOrTodosTexts));
      } else if (event is AddTodoTextEvent) {
        emit(LoadingTodosTextsState());

        final addOrFailureTodoText = await addTodoTextUseCase(event.todoText);

        emit(
          _mapFailureOrAddUpdateDeleteTodoTextToState(
            addOrFailureTodoText,
            addTodoTextSuccess,
          ),
        );
      } else if (event is UpdateTodoTextEvent) {
        emit(LoadingTodosTextsState());

        final updateOrFailureTodoText =
            await updateTodoTextUseCase(event.todoText);

        emit(
          _mapFailureOrAddUpdateDeleteTodoTextToState(
            updateOrFailureTodoText,
            updateTodoTextSuccess,
          ),
        );
      } else if (event is DeleteTodoTextEvent) {
        emit(LoadingTodosTextsState());

        final deleteOrFailureTodoText =
            await deleteTodoTextUseCase(event.todoTextId);

        emit(
          _mapFailureOrAddUpdateDeleteTodoTextToState(
            deleteOrFailureTodoText,
            deleteTodoTextSuccess,
          ),
        );
      }
    });
  }

  TodoTextState _mapFailureOrTodosTestsToState(FailureOrTodosTexts either) {
    return either.fold(
      (failure) {
        return ErrorTodosTextsState(message: _mapFailureToMessageInfo(failure));
      },
      (todosTests) {
        return LoadedTodosTextsState(todosTests: todosTests);
      },
    );
  }

  TodoTextState _mapFailureOrAddUpdateDeleteTodoTextToState(
      FailureOrTodoText either, String message) {
    return either.fold(
      (failure) {
        return ErrorTodosTextsState(message: _mapFailureToMessageInfo(failure));
      },
      (_) {
        return LoadTodosTextsState(message: message);
      },
    );
  }

  String _mapFailureToMessageInfo(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyCacheFailure:
        return emptyCachedFailureMessage;
      case AddTodoTextCacheFailure:
        return addTodoTextFailureMessage;
      case UpdateTodoTextCacheFailure:
        return updateTodoTextFailureMessage;
      case DeleteTodoTextCacheFailure:
        return deleteTodoTextFailureMessage;

      default:
        return "An Unexpected Wrong, Please try again later!.";
    }
  }
}
