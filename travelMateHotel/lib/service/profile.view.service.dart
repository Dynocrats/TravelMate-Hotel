import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileService{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  getUserProfile({String uid}) async{
    final List user = [];
    try {
      print(uid);
      await db.collection('users').where('userId', isEqualTo: uid).get()
      .then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          user.add(element.data());
        });
      });
      return user;
    } catch (e) {
      print(e.toString()); 
    }
  }
}