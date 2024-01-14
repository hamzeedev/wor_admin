import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//vendor = lessor, renter
const rentersCollection = 'renters';
const wheelsCollection = "wheels";
const chatsCollection = 'chats';
const messagesCollection = 'messages';
//order = booking
const bookingCollection = 'booking';