import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        late var tasks = AppCubit.get(context).archivedtasks;
        return BuildTasksList(tasks: tasks);
      },

    );
  }
}
