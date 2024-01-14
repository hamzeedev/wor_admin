import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

Widget chatBubble(){
  return Directionality(
    // textDirection: TextDirection.rtl,
    //below line will change chat dirction of sender and receiver...
    // textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        //below line will change chat color of sender and receiver...
        // color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
        color: purpleColor,
        // borderRadius: data['uid'] == currentUser!.uid
        //     ? const BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         topRight: Radius.circular(20),
        //         bottomLeft: Radius.circular(20),
        //       )
        //     : const BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         topRight: Radius.circular(20),
        //         bottomRight: Radius.circular(20),
        //       ),
        borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //line to show message
          // "${data['msg']}".text.white.size(16).make(),
          normalText(text: "Your message here..."),
          10.heightBox,
          //line to show time of message...
          // time.text.color(whiteColor.withOpacity(0.5)).make(),
          normalText(text: "10:54PM"),
        ],
      ),
    ),
  );
}