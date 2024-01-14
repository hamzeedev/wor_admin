import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/controllers/auth_controller.dart';
import 'package:wor_admin/controllers/profile_controller.dart';
import 'package:wor_admin/services/store_services.dart';
import 'package:wor_admin/views/auth/login_screen.dart';
import 'package:wor_admin/views/messages/messages_screen.dart';
import 'package:wor_admin/views/profile_screen/editing_screen.dart';
import 'package:wor_admin/views/agency/shop_settings_screen.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

import '../../const/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

//PROFILE CONTROLLER....
    var controller = Get.put(ProfileController());


    return Scaffold(
        backgroundColor: white,
        //APPBAR with Buttons...
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 18.0, color: purpleColor),
          actions: [
            //LOGOUT BUTTON IN APPBAR....
            IconButton(
                onPressed: () {
                  
                  //FROM HERE GOING TO EDIT PROFILE SCREEN
                  Get.to(() =>  EditingScreen(
                       username: controller.snapshotData['renter_name'],
                      ));
                },
                icon: const Icon(Icons.edit)),
            //FOR LOGOUT....    
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout, color: purpleColor)),
                //TILL HERE......
          ],
        ),
        body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          // async work
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(cicleColor: purpleColor);

            } else {

              // var data = snapshot.data!.docs[0];
              //upper didnot give us error
              controller.snapshotData = snapshot.data!.docs[0];


              return Column(
                children: [
                  ListTile(
                     leading: controller.snapshotData['imageUrl'] == ''
                     ? Image.asset(icLogo, width: 100, fit: BoxFit.cover,)
                         .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                     : Image.network(controller.snapshotData['imageUrl'], width: 80, fit: BoxFit.cover,)
                         .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                    // Image.asset(icLogo)
                    //     .box
                    //     .roundedFull
                    //     .clip(Clip.antiAlias)
                    //     .make(),
                    title: boldText(text: "${controller.snapshotData['renter_name']}", color: purpleColor),
                    subtitle:normalText(text: "${controller.snapshotData['email']}", color: purpleColor),
                  ),
                  const Divider(
                    color: purpleColor,
                  ),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileButtonsIcons.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopSettings());
                                      break;
                                    case 1:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                    default:
                                  }
                                },
                                leading: Icon(
                                  profileButtonsIcons[index],
                                  color: purpleColor,
                                ),
                                title: normalText(
                                    text: profileButtonsTitle[index],
                                    color: purpleColor
                                    ),
                              )),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
