
import 'package:apiproject/modules/basics_app_screens/counter_screen/counter_cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());

  int counter = 1;

  static CounterCubit get(context) => BlocProvider.of(context);

  void plus ()
  {
    counter++;
    emit(CounterPlusState());
  }

  void minus ()
  {
    counter--;
    emit(CounterMinusState());
  }


}