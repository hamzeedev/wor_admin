
import 'package:wor_admin/const/firebase_consts.dart';

class StoreServices{
  static getProfile(uid){
    return firestore.collection(rentersCollection).where('id', isEqualTo: uid).get();
    }

    static getMessages(uid){
      return firestore.collection(chatsCollection).where('toid', isEqualTo: uid).snapshots();
    }

    static getBookings(uid){
      return firestore.collection(bookingCollection).where('renters', arrayContains: uid).snapshots();
    }

    static getWheels(uid){
      return firestore.collection(wheelsCollection).where('agency_id', isEqualTo: uid).snapshots();
    }

    // get all messages...
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

    // static getPopularWheels(uid){
    //   return firestore.collection(wheelsCollection).where('agency_id', isEqualTo: uid).orderBy('w_wishlist'.length);
    // }


}