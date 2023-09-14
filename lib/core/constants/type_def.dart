import 'package:dartz/dartz.dart';
import '../../features/todo_text/domain/entities/todo_text.dart';

import '../../features/auth/domain/entities/user.dart';
import '../errors/failures/failures.dart';

typedef FailureOrSignUpAuth = Either<Failure, Unit>;
typedef FailureOrSignInAuth = Either<Failure, User>;

typedef FailureOrTodosTexts =  Either<Failure, List<TodoText>>;
typedef FailureOrTodoText = Either<Failure, Unit>;