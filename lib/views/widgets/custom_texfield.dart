import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller, isDes = false }){
  return TextFormField(
    controller: controller,
    style:  const TextStyle(color: purpleColor,),
    maxLines: isDes ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label, color: purpleColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: purpleColor,
        )),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: green,
        )),
        hintText: hint,
        hintStyle: const TextStyle(color: fontGrey),
        ),
  );
}