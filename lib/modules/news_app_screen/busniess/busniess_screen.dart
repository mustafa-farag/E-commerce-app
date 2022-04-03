import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var list = NewsCubit.get(context).business ;
    return list.isEmpty ? const Center(child: CircularProgressIndicator()) : articleBuilder(list , context);
  }
}
