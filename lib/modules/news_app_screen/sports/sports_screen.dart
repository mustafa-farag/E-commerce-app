import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:flutter/material.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sports;
    return list.isEmpty ? const Center(child: CircularProgressIndicator()) : articleBuilder(list , context);
  }
}
