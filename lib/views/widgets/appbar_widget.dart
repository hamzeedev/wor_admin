import 'package:wor_admin/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wor_admin/views/widgets/text_style.dart';

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 18.0),
    actions: [
      Center(
          child: boldText(
              text: intl.DateFormat("EEE, MMM d, ' 'yy").format(DateTime.now()),
              color: purpleColor)),
      10.widthBox,
    ],
  );
}
