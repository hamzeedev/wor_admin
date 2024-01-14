import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wor_admin/controllers/wheels_controller.dart';
import 'package:wor_admin/views/wheels_screen/add_wheel.dart';
import 'package:wor_admin/views/wheels_screen/wheels_details.dart';
import 'package:wor_admin/views/widgets/appbar_widget.dart';

import '../../const/const.dart';
import '../../const/loading_indicator.dart';
import '../../services/store_services.dart';
import '../widgets/text_style.dart';

class WheelsScreen extends StatelessWidget {
  const WheelsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(WheelsController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => const AddWheel());
          },
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
        //PRODUCTS(name) + DATE used in appbar....
        appBar: appbarWidget(products),
        //We dont use listview.builder here because it affacts the RAM
        //when to use? there is huge amount of data...
        body: StreamBuilder(
            stream: StoreServices.getWheels(currentUser!.uid),
            // async work
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(cicleColor: purpleColor);
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) => Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() =>  WheelDetails(data: data[index],));
                            },
                            leading: Image.network(
                              data[index]['w_imgs'][0],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: boldText( text: "${data[index]['w_name']}", color: fontGrey),
                            subtitle: Row(
                              children: [
                                normalText(text: "${data[index]['w_price']} RS", color: darkGrey),
                                10.widthBox,
                                boldText(text: data[index]['is_featured'] == true? "Featured": "", color: green)
                              ],
                            ),
                      //POPUP MENU FOR... * Featured, Edit, Remove *
                            trailing: VxPopupMenu(
                                menuBuilder: () => Column(
                                      children: List.generate(
                                          popupMenuTitles.length,
                                          (i) => Padding(
                                                padding:const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      popupMenuIcons[i],
                                                      color: data[index]['featured_id'] == currentUser!.uid && i ==0
                                                      ? green
                                                      : darkGrey
                                                      ),
                                                    10.widthBox,
                                                    normalText(
                                                        text: data[index]['featured_id'] == currentUser!.uid && i== 0 
                                                        ? 'Remove feature' 
                                                        : popupMenuTitles[i],
                                                        color: darkGrey
                                                        ),
                                                  ],
                                                ).onTap(() {
                                                  switch (i) {
                                                  case 0:
                                                    if (data[index]['is_featured']==true) {
                                                      controller.removeFeatured(data[index].id);
                                                      VxToast.show(context, msg: "Removed");
                                                      } else {
                                                       controller.addFeatured(data[index].id);
                                                       VxToast.show(context, msg: "Added");
                                                       }
                                                  break;

                                                  case 1:
                                                  break;

                                                  case 2:
                                                    controller.removeWheel(data[index].id);
                                                     VxToast.show(context, msg: "Wheel Removed");
                                                  break;
                                                    default:
                                                  }
                                                }),
                                              )),
                                    ).box.white.rounded.width(200).make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
