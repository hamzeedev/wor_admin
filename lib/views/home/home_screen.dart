import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/services/store_services.dart';
import 'package:wor_admin/views/wheels_screen/wheels_details.dart';
import 'package:wor_admin/views/widgets/appbar_widget.dart';
import 'package:wor_admin/views/widgets/dashboard_button.dart';
import 'package:wor_admin/views/widgets/text_style.dart';
import '../../const/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //DASHBOARD(name) + DATE used in appbar....
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
          stream: StoreServices.getWheels(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a,b) => b['w_wishlist'].length.compareTo(a['w_wishlist'].length));
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //DASHBOARD Buttons.....Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: totalWheels, count: "${data.length}", icon: icProducts),
                        
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: totalBookings, count: "${data.length}", icon: icOrders),
                        // dashboardButton(context,
                        //     title: rating, count: "60.0", icon: icStar),
                        // dashboardButton(context,
                        //     title: totalSales, count: "15", icon: icChat),
                      ],
                    ),
                    //DASHBOARD Buttons.....End
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    //POPULAR Wheels.....Start
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['w_wishlist'].length == 0
                          ? const SizedBox()
                          : ListTile(
                                onTap: () {
                                  Get.to(()=> WheelDetails(data: data[index],));
                                },
                                leading: Image.network(
                                  data[index]['w_imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText( text: "${data[index]['w_name']}", color: fontGrey),
                                subtitle: normalText( text: "${data[index]['w_price']} RS", color: darkGrey),
                              )),
                    ),
                    //POPULAR Products.....End
                  ],
                ),
              );
            }
          }
          ),
    );
  }
}
