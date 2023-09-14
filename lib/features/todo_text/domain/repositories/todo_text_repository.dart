import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/todo_text.dart';

abstract class TodoTextRepository {
  Future<Either<Failure, List<TodoText>>> getTodosTexts();
  Future<Either<Failure, Unit>> deleteTodoText(int id);
  Future<Either<Failure, Unit>> updateTodoText(TodoText todoText);
  Future<Either<Failure, Unit>> addTodoText(TodoText todoText);
}
