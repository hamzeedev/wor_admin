import 'dart:io';

import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/controllers/profile_controller.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

import '../widgets/custom_texfield.dart';

class EditingScreen extends StatefulWidget {

  final String? username;
  const EditingScreen({super.key, this.username});

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {


  var controller = Get.find<ProfileController>();


  @override
  void initState() {

    controller.nameController.text = widget.username!;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
                 title: boldText(text: editProfile, color: purpleColor, size: 18.0),
            //SAVE BUTTON ON EDIT SCRENN...
                 actions: [
                  controller.isloading.value
                ? loadingIndicator(cicleColor: purpleColor)
                : TextButton(onPressed: ()async{
                    
                    controller.isloading(true);
        
                    //FOR IMAGE SELECTION....if image is not selected .....
                    if (controller.profilImgPath.value.isNotEmpty) {
                      await controller.uploadProfileImage();
                    } else {
                      controller.profileImageLink = controller.snapshotData['imageUrl'];
                    }
        
                    //FOR PASSWORD CHANGE... if old password matches data base...
                    if ( controller.snapshotData['password'] == 
                         controller.oldpassController.text
                         ) {
                  await controller.changeAuthPassword(
                        email:       controller.snapshotData['email'],
                        password:    controller.oldpassController.text,
                        newpassword: controller.newpassController.text,);
        
                  await controller.updateProfile(
                        imgUrl:   controller.profileImageLink,
                        name:     controller.nameController.text,
                        password: controller.newpassController.text,
                      );
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Updated");
                    } 
                   else if (
                    controller.oldpassController.text.isEmptyOrNull &&
                    controller.newpassController.text.isEmptyOrNull
                    ) {
                  await controller.updateProfile(
                        imgUrl:   controller.profileImageLink,
                        name:     controller.nameController.text,
                        password: controller.snapshotData['password']);
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Updated");
                    } else{
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Some error occured");
                      controller.isloading(false);
                    }
      
                 }, 
                 child: normalText(text: save,color: purpleColor)),
                 ],
                 ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
             Column(
              children: [
              //SHOWING PROFILE IMAGE ON EDIT SCREEN....  
                controller.snapshotData['imageUrl'] == '' &&
                    controller.profilImgPath.isEmpty
                        ? Image.asset(
                            icLogo,
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                  
                        //if data is not empty but controller path is empty....
                        : controller.snapshotData['imageUrl'] != '' &&
                          controller.profilImgPath.isEmpty
                            ? Image.network(
                                controller.snapshotData['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                  
                            //if both are empty.....
                            : Image.file(
                                File(controller.profilImgPath.value),
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                  
            
            
                // Image.asset(icLogo, width: 120,).box.roundedFull.clip(Clip.antiAlias).make(),
                
            
                10.heightBox,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: purpleColor),
                    onPressed: () {
                       controller.changeImage(context);
                    },
                    child: normalText(text: changeImage, color: white)),
                10.heightBox,
            
                const Divider(
                  color: purpleColor,
                ),
            
                //TEXT FIELD TO ADD DATA....
                customTextField(
                  label: renterName,
                  hint: "eg. Wheels on Rent",
                  controller: controller.nameController,
                ),
                30.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change your password", color: purpleColor),
                ),
                10.heightBox,
                customTextField(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpassController,
                ),
                10.heightBox,
                customTextField(
                  label: confirmPass,
                  hint: passwordHint,
                  controller: controller.newpassController,
                ),
              ],
            ),
          
        ),
      ),
    );
  }
}
