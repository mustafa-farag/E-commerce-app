 import 'package:apiproject/modules/shop_app_screen/login/shop_login_screen.dart';
import 'package:apiproject/shared/components/components.dart';
import 'package:apiproject/shared/network/local/cache_helper.dart';

void logout(context)
{
CacheHelper.removeData(key: 'token').then((value)
{
if(value)
{
navigateAndFinish(context, ShopLoginScreen());
}
});
}

String? token ;

 void printFullText(String text) {
   final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
   pattern.allMatches(text).forEach((match) => print(match.group(0)));
 }