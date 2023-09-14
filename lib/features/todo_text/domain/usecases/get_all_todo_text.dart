import 'package:dartz/dartz.dart';
import '../entities/todo_text.dart';

import '../../../../core/errors/failures/failures.dart';
import '../repositories/todo_text_repository.dart';

class GetAllTodoTextUseCase {
  final TodoTextRepository repository;

  GetAllTodoTextUseCase(
    this.repository,
  );

  Future<Either<Failure, List<TodoText>>> call() async{
    return await repository.getTodosTexts();
  }
}