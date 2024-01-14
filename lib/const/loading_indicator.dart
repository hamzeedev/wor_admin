import 'package:wor_admin/const/const.dart';

Widget loadingIndicator ({cicleColor = purpleColor}){
  return  Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(cicleColor) ,
    ),
  );
}