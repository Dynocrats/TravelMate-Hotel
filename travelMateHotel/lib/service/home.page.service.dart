import 'package:cloud_firestore/cloud_firestore.dart';

class AllUserProfile{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  allUserProfile(){
    try {
      return db.collection('users').where('userType', isEqualTo: 'hotel');
    } catch (e) {
      print(e.toString());
    }
  }
}