
import 'package:apiproject/modules/todo_app_screen/archived_tasks/archived_tasks_screen.dart';
import 'package:apiproject/modules/todo_app_screen/done_tasks/done_tasks_screen.dart';
import 'package:apiproject/modules/todo_app_screen/new_tasks_screen/new_tasks_screen.dart';
import 'package:apiproject/shared/cubit/todo_cubit/states.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> newtasks =[];
  List<Map> donetasks=[];
  List<Map> archivedtasks=[];
  int CurrentIndex= 0;

  List<Widget> screens=const[
    NewTasksScreen(),
    DoneTaskScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titels=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index)
  {
    CurrentIndex = index;
    emit(AppChangeNavBarState());
  }


  void CreateDatabase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value)
        {
          print('the table is created');
        }).catchError((error)
        {
          print('error when created${error.toString()}');
        });
      },
      onOpen:(database)
      {
        GetDataFromDatabase(database);
        print('database opened');
      } ,
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });

  }
  InsertIntoDatabase(
      {
        required String title,
        required String date,
        required String time,
      })async
  {
    await database?.transaction((txn)async{
      await txn.rawInsert('INSERT INTO tasks ( title, date, time, status) Values ("$title","$date","$time","new")').then((value)
      {
        print('successfully record inserted');
        emit(AppInsertDatabaseState());

        GetDataFromDatabase(database);
      }).catchError((error){
        print('error when row inserted ${error.toString()}');
      });
    })  ;
  }

  void GetDataFromDatabase(database)
  {
    newtasks=[];
    donetasks=[];
    archivedtasks=[];

    database!.rawQuery('SELECT * FROM tasks').then((value) {


      for (var element in value) {

        if(element['status']== 'new')
        {
          newtasks.add(element);
        }else if(element['status']== 'done')
        {
          donetasks.add(element);
        }else
        {
          archivedtasks.add(element);
        }

      }


      emit(AppGetDatabaseState());
    });

  }

  void UpdateDatabase(
      {
        required String status,
        required int id,
      }
      )
  {
    database!.rawUpdate('UPDATE tasks SET status=? WHERE id=?',[status,'$id']).
    then((value)
    {
      emit(AppUpdateDatabaseState());
      GetDataFromDatabase(database);
    });
  }
  void DeleteDatabase(
      {
        required int id,
      }
      )
  {
    database!.rawDelete('DELETE FROM tasks WHERE id=?',[id]).
    then((value)
    {
      emit(AppDeleteDatabaseState());
      GetDataFromDatabase(database);
    });
  }

  bool isBottunSheetShow = false;
  IconData fabIcon = Icons.edit;

  void changebuttonnavbarstate(
      {
        required bool isshow,
        required IconData icon,
      })
  {
    isBottunSheetShow = isshow;
    fabIcon = icon;
    emit(AppChangeNavButtonState());
  }

  bool isDark = false ;

  void changeTheme({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared ;
      emit(AppChangeThemeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeThemeState());
      });
    }


  }

}