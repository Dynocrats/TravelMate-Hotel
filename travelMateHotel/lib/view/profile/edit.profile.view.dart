import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdate extends StatefulWidget {

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  String hotelName, hotelLocation, hotelDesc, hotelPrice, hotelImageUrl, hotelRooms, hotelSleeps, hotelEmail;
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://travelmate-620f4.appspot.com');
  StorageUploadTask uploadTask;
  PickedFile imageFile;
  String fileName;
  final ImagePicker picker = ImagePicker();
  final db = FirebaseFirestore.instance;

  // Select Image gallery or camera
  selectImage(ImageSource source) async{
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  // upload Image Firestore
    uploadImageFirestore() async{
    String filePath = 'hotels/${DateTime.now()}.jpg';
    setState(() {
      uploadTask = storage.ref().child(filePath).putFile(File(imageFile.path));
      fileName = filePath;
    });
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      hotelImageUrl = url.toString();
    });
  }

  // Update Data in Firestorage
  void updateUser() async{
    await db.collection('users').doc(user.uid)
    .update({
      'userName': user.displayName,
      'userEmail': hotelEmail,
      'userImageUrl': user.photoURL,
      'hotelName': hotelName,
      'hotelImageUrl': hotelImageUrl,
      'price': hotelPrice,
      'description': hotelDesc,
      'rooms': hotelRooms,
      'sleeps': hotelSleeps,
      'location': hotelLocation,
      'userType': 'hotel',
      'date': DateTime.now()
    }).then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 50.0,),
                  GestureDetector(
                    onDoubleTap: (){
                      selectImage(ImageSource.camera);
                    },
                    child: Container(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      child: Icon(Icons.add_a_photo, color: Colors.black45,),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Hotel Name'
                          ),
                          onChanged: (value){
                            hotelName = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email'
                          ),
                          onChanged: (value){
                            hotelEmail = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Day One Price'
                          ),
                          onChanged: (value){
                            hotelPrice = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Room'
                          ),
                          onChanged: (value){
                            hotelRooms = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Sleeps'
                          ),
                          onChanged: (value){
                            hotelSleeps = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Location Link'
                          ),
                          onChanged: (value){
                            hotelLocation = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Description'
                          ),
                          maxLines: 5,
                          onChanged: (value){
                            hotelDesc = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: GestureDetector(
                      onTap: () async{
                       await uploadImageFirestore();
                        updateUser();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Center(
                          child: Text('Create Post', style: TextStyle(fontSize: 20, color: Colors.white),)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}