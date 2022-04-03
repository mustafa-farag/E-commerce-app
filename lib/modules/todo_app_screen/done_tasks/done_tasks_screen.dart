import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.get(context).donetasks;
        return BuildTasksList(tasks: tasks);
      },

    );
  }
}
