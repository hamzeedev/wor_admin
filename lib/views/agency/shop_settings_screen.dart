import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/controllers/profile_controller.dart';
import 'package:wor_admin/views/widgets/custom_texfield.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

class ShopSettings extends StatefulWidget {
  const ShopSettings({super.key});

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  var controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: white,
        //APPBAR with Buttons...
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: boldText(text: shopSettings, size: 18.0, color: purpleColor),
          actions: [
            controller.isloading.value
            ? loadingIndicator(cicleColor: purpleColor)
            : TextButton(onPressed: () async{
              controller.isloading(true);
        await controller.updateShop(
                shopaddress: controller.shopAddressController.text,
                shopname:    controller.shopNameController.text,
                shopmobile:  controller.shopMobileController.text,
                shopwebsite: controller.shopWebsiteController.text,
                shopdesc:    controller.shopDescController.text,
              );
              // ignore: use_build_context_synchronously
              VxToast.show(context, msg: "Settings Updated");
      
            },
            child: normalText(text: save, color: purpleColor)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //the reason why we dont put these in list is...
              //that i have to make list of 'names' and lists seprately
              customTextField(
                label: shopName,
                hint: nameHint,
                controller: controller.shopNameController
              ),
              10.heightBox,
               customTextField(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAddressController
              ),
              10.heightBox,
               customTextField(
                label: mobile,
                hint: shopMobileHint,
                controller: controller.shopMobileController
              ),
              10.heightBox,
               customTextField(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController
              ),
              10.heightBox,
               customTextField(
                isDes: true,
                label: description,
                hint: shopDesHint,
                controller: controller.shopDescController
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}