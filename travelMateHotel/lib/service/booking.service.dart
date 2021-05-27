import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllBooking{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  allBooking(){
    try {
      return db.collection('booking').where('bookingType', isEqualTo: 'hotel').where('uid', isEqualTo: user.uid);
    } catch (e) {
      print(e.toString());
    }
  }
}