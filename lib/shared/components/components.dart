


import 'package:apiproject/modules/news_app_screen/web_view/web_view_screen.dart';
import 'package:apiproject/shared/cubit/news_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/news_cubit/states.dart';
import 'package:apiproject/shared/cubit/shop_cubit/cubit.dart';
import 'package:apiproject/shared/cubit/todo_cubit/cubit.dart';
import 'package:apiproject/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';



Widget button({
  Color color = defaultColor,
  double width = double.infinity,
  required Function() function,
  required String? text,
}) {
  return Container(
    padding: const EdgeInsetsDirectional.only(
      top: 7,
      bottom: 7,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(200),
      color: color,
    ),
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        '${text?.toUpperCase()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget defulttextformfeild({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isSecure = false,
  Function()? suffixPresed,
  Function(String)? onSubmit,
  required String? Function(String? val)? validate,
  Function()? onTap,
  Function(String)? onChange,

}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isSecure,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    onChanged:onChange ,
    decoration: InputDecoration(
      fillColor: Colors.grey.shade200,
      filled: true,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
            width: 0,
          )
      ),
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
          onPressed:suffixPresed ,
          icon: Icon(suffix)
      ),
    ),
  );
}

Widget BuildTasksItem(Map model,context)
{
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction)
    {
      AppCubit.get(context).DeleteDatabase(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              '${model['time']}',
              style:const TextStyle(
                fontSize: 18,
              ),
            ),

          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style:const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style:const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),

              ],
            ),
          ),

          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).UpdateDatabase(status:'done', id: model['id']);
            },
            icon:const Icon(
              Icons.check_box_outlined,
              color: Colors.green,),
          ),
          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).UpdateDatabase(status: 'archived', id: model['id']);
            },
            icon:const Icon(
              Icons.archive_outlined,
              color: Colors.black45,),
          ),
        ],
      ),
    ),
  );
}

Widget BuildTasksList(
    {
      required List<Map> tasks,
    })
{
  return ListView.separated(

      itemBuilder: (context,index)=>BuildTasksItem(tasks[index] , context),
      separatorBuilder: (context,index)=> Devider(),
      itemCount: tasks.length);
}

Widget Devider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);


Widget buildArticleItem(Map article , context) => InkWell(
  onTap: ()
  {
    navigateTo(context, const WebViewScreen());
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20) ,

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        const SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style:Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                const SizedBox(

                  height: 10,

                ),

                Text(

                  '${article['publishedAt']}',

                  style:const TextStyle(

                    fontSize: 16,

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder(list , context) => BlocConsumer<NewsCubit,NewsStates>(
  listener: (context , state){},
  builder: (context , state) => ListView.separated(
      physics:const BouncingScrollPhysics(),
      itemBuilder:(context,index)=> buildArticleItem(list[index] , context),
      separatorBuilder: (context,index) => Devider(),
      itemCount: list.length) ,
);

void navigateTo(context , widget)
{
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => widget
  ));
}

void navigateAndFinish(context , widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => widget
  ),(Route<dynamic> route)=>false,
  );
}

void successToast(context , String message)
{
  MotionToast.success(
    title: Text(message),
    description:const Text(
      'login successfully',
      style: TextStyle(fontSize: 12),
    ),
    layoutOrientation: ORIENTATION.rtl,
    animationType: ANIMATION.fromBottom,
    dismissable: true,
    width: 300,
  ).show(context);
}

void errorToast(context , String message)
{
  MotionToast.error(
    title: Text(message),
    description:const Text('Please enter correct data'),
    animationType: ANIMATION.fromLeft,
    position: MOTION_TOAST_POSITION.bottom,
    width: 300,
  ).show(context);
}

Widget buildProductItem( model , context) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                placeholderScale: 1.2,
                placeholderFit: BoxFit.none,
                image:model!.image,
                width: 120,
                height: 120,
                imageErrorBuilder: (context,error,stackTrace){
                  return Image.asset("assets/images/error.jpeg",scale:2 ,);
                }),
            if(model.discount !=0 )
              Container(
                padding:const EdgeInsets.all(3),
                color: Colors.red,
                child:const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.name}',
                style:const TextStyle(
                  fontSize: 14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style:const TextStyle(
                      color: defaultColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if(model.discount !=0)
                    Text(
                      '${model.oldPrice}',
                      style:const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon:const Icon(Icons.favorite_border),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
Widget buildSearchItem( model , context) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            placeholderScale: 1.2,
            placeholderFit: BoxFit.none,
            image:model!.image,
            width: 120,
            height: 120,
            imageErrorBuilder: (context,error,stackTrace){
              return Image.asset("assets/images/error.jpeg",scale:2 ,);
            }),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.name}',
                style:const TextStyle(
                  fontSize: 14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style:const TextStyle(
                      color: defaultColor,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                    child: IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon:const Icon(Icons.favorite_border),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
