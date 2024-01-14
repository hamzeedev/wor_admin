import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';

class HomeController extends GetxController {

@override
  void onInit(){
    super.onInit();
    getUsername();
  }


  var navIndex = 0.obs;
  var username = '';

  getUsername() async{
    var n = await firestore
    .collection(rentersCollection)
    .where('id', isEqualTo:  currentUser!.uid)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty) { 
        return value.docs.single['shop_name'];
      }
    });
    username = n;
  }
  
}