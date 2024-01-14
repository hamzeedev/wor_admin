import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          boldText(text: title, size: 18.0),
          boldText(text: count, size: 20.0)
        ],
      )),
      Image.asset(
        icon,
        width: 55,
        color: white,
      ),
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.9, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
