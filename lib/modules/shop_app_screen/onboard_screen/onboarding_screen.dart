import 'package:apiproject/modules/shop_app_screen/login/shop_login_screen.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';
import 'package:apiproject/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel(
      {
        required this.image,
        required this.title,
        required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController = PageController();

List<BoardingModel> boarding =
[
  BoardingModel(
      image: 'https://snacknation.com/wp-content/uploads/2020/07/hero-option-2.png',
      title: 'on boarding title 1',
      body: 'on boarding body 1',
  ),
  BoardingModel(
      image: 'https://snacknation.com/wp-content/uploads/2020/07/hero-option-2.png',
      title: 'on boarding title 2',
      body: 'on boarding body 2',
  ),
  BoardingModel(
      image: 'https://snacknation.com/wp-content/uploads/2020/07/hero-option-2.png',
      title: 'on boarding title 3',
      body: 'on boarding body 3',
  ),
];
void submit()
{
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit,
              child: const Text('SKIP'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics:const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                  {
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                itemBuilder:(context , index)=> buildBoardingItem(boarding[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect:const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor:defaultColor ,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),

                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast == true){
                        submit();
                      }else{
                        boardController.nextPage(
                            duration:const Duration(milliseconds: 750,) ,
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
              image:NetworkImage(model.image)
          ),
        ),
        Text(
          model.title,
          style:const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10,),
        Text(
           model.body,
          style:const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
