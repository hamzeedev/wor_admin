import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/controllers/wheels_controller.dart';
import 'package:wor_admin/views/widgets/text_style.dart';

Widget wheelDropDown(hint, List<String> list, dropvalue, WheelsController controller) {
  return Obx(
    ()=> DropdownButtonHideUnderline(
      child: DropdownButton(
        focusColor: white,
        hint: normalText(text: "$hint", color: red),
        value: dropvalue.value == ''? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e){
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
    
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category"){
            controller.subcategoryvalue.value = '';
            controller.populateSubcategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
    
        },
      ),
    ).box.color(white).roundedSM.border(color: Colors.black38).padding(const EdgeInsets.symmetric(horizontal: 4)).make(),
  );
}
