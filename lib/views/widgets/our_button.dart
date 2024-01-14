import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/views/widgets/text_style.dart';
Widget ourButton({onPress, color= purpleColor, textColor= white, String? title}){
  
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: boldText(
      text: title,
      size: 16.0,
    ),
    );
}