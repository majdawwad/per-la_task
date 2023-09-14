import 'package:dartz/dartz.dart';
import '../entities/todo_text.dart';

import '../../../../core/errors/failures/failures.dart';
import '../repositories/todo_text_repository.dart';

class UpdateTodoTextUseCase {
  final TodoTextRepository repository;

  UpdateTodoTextUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(TodoText todoText) async{
    return await repository.updateTodoText(todoText);
  }
}