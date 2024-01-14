import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wor_admin/controllers/booking_controller.dart';
import 'package:wor_admin/services/store_services.dart';
import 'package:wor_admin/views/booking_screen/booking_details.dart';
import 'package:wor_admin/views/widgets/appbar_widget.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/loading_indicator.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    var controller = Get.put(BookingController());


    
    return Scaffold(
        appBar: appbarWidget(orders),
        body: StreamBuilder(
            stream: StoreServices.getBookings(currentUser!.uid),
            // async work
            builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              
              if (!snapshot.hasData) {

                return loadingIndicator(cicleColor: purpleColor);

              } else {

                var  data = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(

                      children: List.generate(
                        data.length, (index) {
                          var time = data[index]['booking_date'].toDate();
                          return ListTile(

                          onTap: () {

                            Get.to(() => BookingDetailsScreen(data: data[index]),);

                          },

                          tileColor: textfieldGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          //ORDER CODE.....
                          title: boldText(
                              text: "${data[index]['booking_code']}",
                              color: fontGrey),
                          subtitle: Column(
                            children: [
                              //ORDER DATE.....
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  boldText(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(time),
                                      color: fontGrey)
                                ],
                              ),
                              //ORDER PAYMENT.....
                              Row(
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  boldText(text: unpaid, color: red),
                                ],
                              ),
                            ],
                          ),
                          trailing:
                          boldText(text: "${data[index]['total_amount']} Rs", color: purpleColor, size: 16.0),)
                          .box
                          .margin(const EdgeInsets.only(bottom: 4))
                          .make();
                      }),
                    ),
                  ),
                );
              }
            }));
  }
}
