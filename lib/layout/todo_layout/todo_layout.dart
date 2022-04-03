
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


class TodoMain extends StatelessWidget {




  var scaffoldkey =GlobalKey<ScaffoldState>();
  var formkey =GlobalKey<FormState>();
  var titleControler= TextEditingController();
  var dateControler= TextEditingController();
  var timeControler= TextEditingController();



  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context , AppStates state){
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.titels[cubit.CurrentIndex]),
            ),
            body:cubit.screens[cubit.CurrentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if(cubit.isBottunSheetShow)
                {
                  if(formkey.currentState!.validate()){
                    cubit.InsertIntoDatabase(
                      title: titleControler.text,
                      date: dateControler.text,
                      time: timeControler.text,
                    );

                  }
                }
                else
                {
                  scaffoldkey.currentState!.showBottomSheet((context) {

                    return Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(20),


                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defulttextformfeild(
                              controller: titleControler,
                              type: TextInputType.text,
                              label: 'Task Title',
                              prefix: Icons.title,
                              validate: (value){
                                if(value!.isEmpty){
                                  return'title can not be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defulttextformfeild(
                              controller: timeControler,
                              onTap: ()
                              {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now() ).then((value)
                                {
                                  timeControler.text= value!.format(context).toString();
                                });
                              },
                              type: TextInputType.datetime,
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                              validate: (value){
                                if(value!.isEmpty){
                                  return'Time can not be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defulttextformfeild(
                              controller: dateControler,
                              onTap: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-04-03'),
                                ).then((value)
                                {
                                  dateControler.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                              type: TextInputType.datetime,
                              label: 'Task Time',
                              prefix: Icons.calendar_today,
                              validate: (value){
                                if(value!.isEmpty){
                                  return 'Time can not be empty';
                                }
                                return null;
                              },
                            ),

                          ],
                        ),
                      ),
                    );
                  }).closed.then((value) {
                    cubit.changebuttonnavbarstate(isshow: false, icon: Icons.edit);

                  });
                  cubit.changebuttonnavbarstate(isshow: true, icon: Icons.add);
                }

              },
            ) ,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.CurrentIndex,
              onTap: (index){
                cubit.ChangeIndex(index);
              },
              items:const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}






