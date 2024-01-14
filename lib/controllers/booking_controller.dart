import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wor_admin/const/const.dart';

class BookingController extends GetxController{

  var booking = [];

  var confirmed  = false.obs;
  var ontime     = false.obs; //on delivary...
  var hiried     = false.obs; // delivered...

  getBookings(data){
    booking.clear();
    //         ye wala   'bookings' ... booking main collection ki sub collection hai
    for (var item in data['bookings']) {
      if(item['agency_id'] == currentUser!.uid){
        booking.add(item);
      }

      
    }
  }

  changeStatus({title, status, docID}) async{
    var store = firestore.collection(bookingCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));


  }
}