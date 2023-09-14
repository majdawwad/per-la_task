import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../domain/entities/todo_text.dart';
import '../../domain/repositories/todo_text_repository.dart';
import '../data_sources/todo_text_local_data_source.dart';
import '../models/todo_text_model.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class TodoTextRepositoryImplement implements TodoTextRepository {
  final TodoTextLocalDataSource todoTextLocalDataSource;

  TodoTextRepositoryImplement({
    required this.todoTextLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TodoText>>> getTodosTexts() async {
    try {
      final List<TodoText> localTodosTexts =
          await todoTextLocalDataSource.allTodosTexts();

      return Right(localTodosTexts);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTodoText(TodoText todoText) async {
    final TodoTextModel todoTextModel =
        TodoTextModel(text: todoText.text, date: todoText.date);

    try {
      await todoTextLocalDataSource.addTodoText(todoTextModel);
      return const Right(unit);
    } on AddTodoTestCacheException {
      return Left(AddTodoTextCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodoText(int id) async {
    try {
      await todoTextLocalDataSource.deleteTodoText(id);
      return const Right(unit);
    } on DeleteTodoTestCacheException {
      return Left(DeleteTodoTextCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTodoText(TodoText todoText) async {
    final TodoTextModel todoTextModel = TodoTextModel(
        id: todoText.id, text: todoText.text, date: todoText.date);

    try {
      await todoTextLocalDataSource.updateTodoText(todoTextModel);
      return const Right(unit);
    } on UpadteTodoTestCacheException {
      return Left(UpdateTodoTextCacheFailure());
    }
  }
}
