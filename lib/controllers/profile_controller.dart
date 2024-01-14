import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wor_admin/const/const.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;


  var profilImgPath = ''.obs;

  var profileImageLink = '';

//ye variable btaya ga k loading complete ho gai hai...
  var isloading = false.obs;

  //textfields...s
  var nameController    = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  //shop controller
  var shopNameController    = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController  = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescController    = TextEditingController();

  changeImage(context) async {
    
    try {

      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (img == null) return;
      profilImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload image ka method....
  uploadProfileImage() async {

    var filename    = basename(profilImgPath.value);
    var destination = 'image/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await     ref.putFile(File(profilImgPath.value));
    //ye sara honay mai thora time lag skta hai thats why i use await below....
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(rentersCollection).doc(currentUser!.uid);
    await store.set(
      {
      'renter_name': name,
      'password':   password,
      'imageUrl': imgUrl,
      }, 
      SetOptions(merge: true));
    //oper merge ka faida ye hai k ye dobara se pora document create nai kray ga, sirf oper d gai fields ko update kry ga or baki sb ko merge kr day ga....
    isloading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {});
  }


  updateShop({shopname, shopaddress, shopmobile, shopwebsite, shopdesc}) async {
    var store = firestore.collection(rentersCollection).doc(currentUser!.uid);
    await store.set(
      //this is map...
      {
        'shop_name':    shopname,
        'shop_address': shopaddress,
        'shop_mobile':  shopmobile,
        'shop_website': shopwebsite,
        'shop_desc':    shopdesc,

      },
      SetOptions(merge: true));
    //oper merge ka faida ye hai k ye dobara se pora document create nai kray ga, sirf oper d gai fields ko update kry ga or baki sb ko merge kr day ga....
    isloading(false);

  }








}
