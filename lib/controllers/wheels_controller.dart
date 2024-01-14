import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wor_admin/const/const.dart';
import 'package:wor_admin/controllers/home_controller.dart';
import 'package:wor_admin/models/category_model.dart';
import 'package:path/path.dart';

class WheelsController extends GetxController{

  var isloading = false.obs;

  //text field controllers
    //w=p
  var wnamecontroller      = TextEditingController();
  var wdescontroller       = TextEditingController();
  var wpricecontroller     = TextEditingController();
  var wdayscontroller      = TextEditingController();

  var categoryList         = <String>[].obs;
  var subcategoryList      = <String>[].obs;

  List <Category> category = [];
  var wImagesLinks         = [];
  var wImagesList          = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue        = ''.obs;
  var subcategoryvalue     = ''.obs;
  var selectedColorIndex   = 0.obs;

  getCategories() async{
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat  = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList(){
    categoryList.clear();

    for(var item in category){
      categoryList.add(item.name);
    }
  }

  populateSubcategory(cat){
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

//image picking function...
    pickImage(index, context) async{
    //used try catch to check if user not add pic
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);
      if (img == null) return;
        wImagesList[index] = File(img.path);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

    uploadImages()async{

      wImagesLinks.clear();
      for (var item in  wImagesList) {
        if (item != null) {
           var filename    = basename(item.path);
           var destination = 'image/renters/${currentUser!.uid}/$filename';
           Reference ref   = FirebaseStorage.instance.ref().child(destination);
           await ref.putFile(item);
           var n           = await ref.getDownloadURL();
           wImagesLinks.add(n);
        }
        
      }
      
    }
//uploading vhicles details from given code...
    uploadWheel(context) async{
      var store = firestore.collection(wheelsCollection).doc();
      await store.set({
        'is_featured'   : false,
        'w_category'    : categoryvalue.value,
        'w_subcategory' : subcategoryvalue.value,
        'w_colors'      : FieldValue.arrayUnion([Colors.red.value, Colors.grey.value]),
        'w_imgs'        : FieldValue.arrayUnion(wImagesLinks),
        'w_wishlist'    : FieldValue.arrayUnion([]),
        'w_desc'        : wdescontroller.text,
        'w_name'        : wnamecontroller.text,
        'w_price'       : wpricecontroller.text,
        'w_days'        : wdayscontroller.text,
        'w_agency'      : Get.find<HomeController>().username,
        'w_rating'      : "5.0",
        'agency_id'     : currentUser!.uid,
        'featured_id'   : '',

      });
      isloading(false);

      VxToast.show(context, msg: "Wheel Uploaded");

    }
  
  //Methods of featured
  //ADD TO FETURED
    addFeatured(docId) async {
      await firestore.collection(wheelsCollection).doc(docId).set({
        'featured_id': currentUser!.uid,
        'is_featured': true,
        },SetOptions(merge: true));
    }
  //REMOVE FROM FETURED
     removeFeatured(docId) async {
      await firestore.collection(wheelsCollection).doc(docId).set({
        'featured_id': '',
        'is_featured': false,
        },SetOptions(merge: true));
    }

  //METHOD TO PARMANENTLY DELETE ANY WHEEL
  removeWheel(docId) async{
    await firestore.collection(wheelsCollection).doc(docId).delete();
  }

  
  
}