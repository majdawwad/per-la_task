import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as p;
import '../../../../core/errors/exceptions/exceptions.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_text_model.dart';

abstract class TodoTextLocalDataSource {
  Future<List<TodoTextModel>> allTodosTexts();
  Future<Unit> addTodoText(TodoTextModel textModel);
  Future<Unit> updateTodoText(TodoTextModel todoTextModel);
  Future<Unit> deleteTodoText(int todoTextId);
}

class TodoTextLocalDataSourceImplement extends TodoTextLocalDataSource {
  static const _databaseName = 'todos_text_db';
  static const _tableName = 'todos_texts';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _columnText = 'text';
  static const _columnDate = 'date';
  static Database? _database;

  static Future<Database> _initDatabase() async {
    return openDatabase(
      p.join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_tableName(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_columnText TEXT NOT NULL,
            $_columnDate TEXT NOT NULL
          )
        ''');
      },
      version: _databaseVersion,
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  @override
  Future<List<TodoTextModel>> allTodosTexts() async {
    final db = await database;
    List<Map> maps = await db.query(
      _tableName,
      columns: [_columnId, _columnText, _columnText],
    );
    if (maps.isNotEmpty) {
      final List<TodoTextModel> todosTexts = maps
          .map((todoText) =>
              TodoTextModel.fromJson(todoText))
          .toList();
      return todosTexts;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> addTodoText(TodoTextModel textModel) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        textModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }).catchError((error) {
      throw AddTodoTestCacheException();
    });
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteTodoText(int todoTextId) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [todoTextId],
    ).catchError((error){
      throw DeleteTodoTestCacheException();
    });
     return Future.value(unit);
  }

  @override
  Future<Unit> updateTodoText(TodoTextModel todoTextModel) async {
    final db = await database;
    await db.update(
      _tableName,
      todoTextModel.toJson(),
      where: '$_columnId = ?',
      whereArgs: [todoTextModel.id],
    ).catchError((error) {
      throw UpadteTodoTestCacheException();
    });
    return Future.value(unit);
  }
}
