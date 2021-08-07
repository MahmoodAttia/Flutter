import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/archived.dart';
import 'package:flutter_application_2/modules/done.dart';
import 'package:flutter_application_2/modules/tasks.dart';
//import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class CubitClass extends Cubit<CubitState> {
  CubitClass() : super(InitialState());
  static CubitClass get(context) => BlocProvider.of(context);
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  int crIndex = 0;
  Database database;
  IconData fabicon = Icons.edit;
  List<Widget> screens = [
    Tasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> titles = [
    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void createDatabase() async {
    database =
        await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('database created');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, status TEXT, date TEXT, time TEXT)')
          .then((value) {
        print('table created');
      });
    }, onOpen: (db) {
      getData(db);
    });
  }

  Future insertRecord(
      {@required String title,
      @required String date,
      @required String time}) async {
    // ignore: missing_return
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","New")')
          .then((value) {
        emit(InsertDatabaseState());
        print('$value Inserted');
        getData(database);
      }).catchError((error) {
        print(error);
      });
      print(database);
    });
  }

  void getData(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(LoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      print(value);
      value.forEach((element) {
        if (element['status'] == 'New')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(GetDatabaseState());
    });
  }

  void updateRecord(
    String status,
    int id,
  ) {
    database.rawUpdate('UPDATE tasks SET status=? WHERE id = ?',
        ['$status', id]).then((value) {
      getData(database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteRecord(
    int id,
  ) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getData(database);
      emit(DeleteDatabaseState());
    });
  }

  void setIconFab(IconData icon) {
    fabicon = icon;
    emit(ChangeIconFabState());
  }

  void bottomNavChangeState(index) {
    crIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
