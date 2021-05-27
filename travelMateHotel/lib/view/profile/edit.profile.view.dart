import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelMateHotel/widget/custom.btn.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  String hotelName,
      hotelLocation,
      hotelDesc,
      hotelPrice,
      hotelImageUrl,
      hotelRooms,
      hotelSleeps,
      hotelEmail;
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://travelmate-620f4.appspot.com');
  StorageUploadTask uploadTask;
  PickedFile imageFile;
  String fileName;
  final ImagePicker picker = ImagePicker();
  final db = FirebaseFirestore.instance;

  // Loading State
  bool updateProfile = false;

  // Select Image gallery or camera
  selectImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  // upload Image Firestore
  uploadImageFirestore() async {
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
  void updateUser() async {
    await db
        .collection('users')
        .doc(user.uid)
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
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        )),
        child: ListView(
          children: [
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        'Upload Hotel Image[required]',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: imageFile == null
                            ? BoxDecoration(
                                color: Color(0xFFFD5F1FB),
                                borderRadius: BorderRadius.circular(6.0))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                    image: FileImage(File(imageFile.path)),
                                    fit: BoxFit.cover),
                              ),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'All Field Required',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Hotel Name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Hotel Name',
                                      ),
                                      onChanged: (value) {
                                        hotelName = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Email',
                                      ),
                                      onChanged: (value) {
                                        hotelEmail = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Day One Price';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Day One Price',
                                      ),
                                      onChanged: (value) {
                                        hotelPrice = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Rooms';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Rooms',
                                      ),
                                      onChanged: (value) {
                                        hotelRooms = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Sleeps';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Sleeps',
                                      ),
                                      onChanged: (value) {
                                        hotelSleeps = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Location Link';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Location Link',
                                      ),
                                      onChanged: (value) {
                                        hotelLocation = value;
                                      },
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFD5F1FB),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Description';
                                        }
                                        return null;
                                      },
                                      minLines: 1,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Description',
                                      ),
                                      onChanged: (value) {
                                        hotelDesc = value;
                                      },
                                    ))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    UpdateBtn(
                      text: 'Update Profile',
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            updateProfile = true;
                          });
                          await uploadImageFirestore();
                          updateUser();
                          setState(() {
                            updateProfile = false;
                          });
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              title: 'Succes',
                              desc: 'your prifile update succefuly!',
                              dismissOnTouchOutside: false,
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                                Navigator.pop(context);
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              })
                            ..show();
                        }
                        print('Upload Profile');
                      },
                      isLoading: updateProfile,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
