import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../repositories/todo_text_repository.dart';

class DeleteTodoTextUseCase {
  final TodoTextRepository repository;

  DeleteTodoTextUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(int todoTextId) async{
    return await repository.deleteTodoText(todoTextId);
  }
}