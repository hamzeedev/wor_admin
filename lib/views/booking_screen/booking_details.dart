import 'package:get/get.dart';
import 'package:wor_admin/const/colors.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/controllers/booking_controller.dart';
import 'package:wor_admin/views/widgets/our_button.dart';
import 'package:wor_admin/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

import 'components/booking_place.dart';

class BookingDetailsScreen extends StatefulWidget {

  final dynamic data;
  
  const BookingDetailsScreen({super.key, this.data});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}
class _BookingDetailsScreenState extends State<BookingDetailsScreen> {


   var controller = Get.find<BookingController>();


   @override
  void initState() {
    controller.getBookings(widget.data); 

    controller.confirmed.value = widget.data['booking_confirmed'];
    // controller.ontime.value    = widget.data['wheel_hiried_on_time'];
    controller.hiried.value    = widget.data['wheel_hiried'];
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   //rapping scaffold with obx bcz we have to change the state of confirm button
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: darkGrey,
              )),
          title: boldText(text: "Booking details", color: fontGrey, size: 16.0),
        ),
        //BUTTON....
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: () {
                controller.confirmed(true);
                 controller.changeStatus(title: "booking_confirmed", status: true, docID: widget.data.id);
              },
              title: "Confirm Order",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //delivery status section....
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "Booking Status", color: fontGrey, size: 16.0),
                      
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Booking Placed", color: fontGrey),
                      ),

                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,

                        onChanged: (value) {
                          controller.confirmed.value = value;
                          
                        },
                        title: boldText(text: "Booking Confirmed", color: fontGrey),
                      ),

                      SwitchListTile(
                        activeColor: green,
                        value: controller.ontime.value,
                        onChanged: (value) {

                          controller.ontime.value = value;
                          controller.changeStatus(title: "wheel_hiried_on_time", status: value, docID: widget.data.id);

                        },
                        title: boldText(text: "Wheel hiried on time", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.hiried.value,
                        onChanged: (value) {

                          controller.hiried.value = value;
                          controller.changeStatus(title: "wheel_hiried", status: value, docID: widget.data.id);
                          
                        },
                        title: boldText(text: "Hiried", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(8))
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),
                      
                //order details section....
                const Divider(),
                1.heightBox,
                Column(
                  children: [
                    bookingPlacedDetails(
                      // d1: "{${widget.data}['booking_code']}",
                      d2: "{${widget.data}['hiring_method']}",
                      title1: "Booking Code",
                      title2: "Hiring Method",
                    ),
                    bookingPlacedDetails(
                      // d1: DateTime.now(),
                      d1: intl.DateFormat().add_yMd() .format((widget.data['booking_date'].toDate())),
                      d2: "{${widget.data}['payment_method']}",
                      title1: "Order Date",
                      title2: "Payment Method",
                    ),
                    bookingPlacedDetails(
                      d1: "Unpaid Yet!",
                      d2: "Booking Placed",
                      title1: "Payment Status",
                      title2: "Booking Status",
                    ),
                      
                    ///this row is for hirer address...
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Hirer Address", color: purpleColor),
                              // "Hirer Address".text.fontFamily(bold).make(),
                              "${widget.data['booking_by_name']}".text.make(),
                              "${widget.data['booking_by_email']}".text.make(),
                              "${widget.data['booking_by_address']}".text.make(),
                              "${widget.data['booking_by_city']}".text.make(),
                              "${widget.data['booking_by_state']}".text.make(),
                              "${widget.data['booking_by_phone']}".text.make(),
                              "${widget.data['booking_by_postalcode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amont", color: purpleColor),
                                boldText(text: "${widget.data['total_amount']}", color: red, size: 16.0),
                                // "Total Amount".text.fontFamily(semibold).make(),
                                // "${data['total_amount']}"
                                //     .text
                                //     .color(redColor)
                                //     .fontFamily(bold)
                                //     .make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                const Divider(),
                20.heightBox,
                      
                ///BOOKED Wheels detail screen
                boldText(text: "Booked Wheel", color: fontGrey, size: 16.0),
                // "Booked Wheels".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.booking.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bookingPlacedDetails(
                          title1: "${controller.booking[index]['title']}",
                          title2: "${controller.booking[index]['wprice']}",
                          d1:     "${controller.booking[index]['days']} day",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 30,
                            height: 10,
                            color: Color(controller.booking[index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
