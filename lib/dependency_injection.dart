import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/auth/data/data_sources/remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_implement.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/todo_text/data/repositories/todo_text_repository_implement.dart';
import 'features/todo_text/domain/repositories/todo_text_repository.dart';
import 'features/todo_text/domain/usecases/add_todo_text.dart';
import 'features/todo_text/domain/usecases/delete_todo_text.dart';
import 'features/todo_text/domain/usecases/get_all_todo_text.dart';
import 'features/todo_text/domain/usecases/update_todo_text.dart';
import 'features/todo_text/presentation/bloc/todo_text/todo_text_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/todo_text/data/data_sources/todo_text_local_data_source.dart';
import 'features/todo_text/presentation/widgets/app_drawer_widget.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth

  //Bloc

  sl.registerFactory(
    () => AuthBloc(signUpUseCase: sl(), signInUseCase: sl()),
  );

  //UseCases

  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  //Auth Repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplement(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplement(client: sl(), sharedPreferences: sl()),
  );

  //! Features - Todo Text

  //Bloc

  sl.registerFactory(
    () => TodoTextBloc(
      getAllTodoTextUseCase: sl(),
      addTodoTextUseCase: sl(),
      updateTodoTextUseCase: sl(),
      deleteTodoTextUseCase: sl(),
    ),
  );

  //UseCases

  sl.registerLazySingleton(() => GetAllTodoTextUseCase(sl()));
  sl.registerLazySingleton(() => AddTodoTextUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTodoTextUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTodoTextUseCase(sl()));

  //Auth Repository

  sl.registerLazySingleton<TodoTextRepository>(
    () => TodoTextRepositoryImplement(todoTextLocalDataSource: sl()),
  );

  //Data Sources

  sl.registerLazySingleton<TodoTextLocalDataSource>(
    () => TodoTextLocalDataSourceImplement(),
  );

  //!core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  ///////////
  sl.registerLazySingleton(() => AppDrawerWidget(sharedPreferences: sl()));

  //!External

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
