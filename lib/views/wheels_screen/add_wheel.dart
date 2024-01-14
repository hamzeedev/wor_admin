import 'package:get/get.dart';
import 'package:wor_admin/const/loading_indicator.dart';
import 'package:wor_admin/controllers/wheels_controller.dart';
import 'package:wor_admin/views/wheels_screen/components/wheel_dropdown.dart';
import 'package:wor_admin/views/wheels_screen/components/wheel_images.dart';
import 'package:wor_admin/views/widgets/custom_texfield.dart';
import '../../const/const.dart';
import '../widgets/text_style.dart';

class AddWheel extends StatelessWidget {
  const AddWheel({super.key});

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.find<WheelsController>();


    return Obx(
      ()=> Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: purpleColor,
            ),
          ),
          title: boldText(text: "Add Wheel", color: purpleColor, size: 16.0),
          actions: [
           controller.isloading.value 
           ? loadingIndicator()
           : TextButton(
                onPressed: () async {
                  controller.isloading(true);
                  await controller.uploadImages();
                  await controller.uploadWheel(context);
                  
                  Get.back();
                },
                child: boldText(text: save, size: 16.0, color: green))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ye sb data base se match kr k likhna hai (YAAD RAKHNA)
                10.heightBox,
                customTextField(
                  label: "Wheel Name",
                  hint: "eg. Toyota Corolla",
                  controller: controller.wnamecontroller,
                ),
      
                10.heightBox,
                customTextField(
                    label: "Description",
                    hint: "eg. Your description will here",
                    isDes: true,
                    controller: controller.wdescontroller,
                ),
      
                10.heightBox,
                customTextField(
                  label: "Price Per Day",
                  hint: "eg. 12,000 Rs",
                  controller: controller.wpricecontroller
                ),
      
                10.heightBox,
                customTextField(
                  label: "Minimum Days",
                  hint: "eg. 1",
                  controller: controller.wdayscontroller,
                ),
      
                10.heightBox,
                wheelDropDown(
                  "Category", 
                  controller.categoryList, 
                  controller.categoryvalue, 
                  controller
                ),
      
                10.heightBox,
                wheelDropDown(
                  "Subcategory", 
                  controller.subcategoryList, 
                  controller.subcategoryvalue, 
                  controller
                ),
      //selecting image code below.....
                10.heightBox,
                const Divider(color: purpleColor,),
                boldText(text: "Select Images:"),
                10.heightBox,
                Obx(
                  ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3, 
                        (index) => controller.wImagesList[index] != null
                        ? Image.file(
                          controller.wImagesList[index],
                           width: 100,
                        ).onTap(() {
                          controller.pickImage(index, context);
                        })
                        : wheelImages(label: "${index + 1}").onTap(() {
                          controller.pickImage(index, context);
                        })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First Image will be shown as your display image",
                    color: Colors.red),
                10.heightBox,
                const Divider(color: purpleColor,),
                boldText(text: "Select Colors:"),
                10.heightBox,
                Obx(
                  ()=> Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        10,
                        (index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox().color(Vx.randomPrimaryColor).roundedFull.size(65, 65).make().onTap(()
                             {
                              controller.selectedColorIndex.value = index;
                             }),
                            controller.selectedColorIndex.value == index
                                ?  const Icon(Icons.done, color: white,)
                                :  const SizedBox(),
                          ],
                        )
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
