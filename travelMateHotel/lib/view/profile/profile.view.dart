import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelMateHotel/provider/google.signin.dart';
import 'package:travelMateHotel/service/profile.view.service.dart';
import 'package:travelMateHotel/view/profile/edit.profile.view.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<dynamic> userProfile = [];

  // Get User Profile Data in Firestore
  userProfileMethod() async{
    final user = FirebaseAuth.instance.currentUser;
    dynamic result = await UserProfileService().getUserProfile(uid: user.uid);
    setState(() {
      userProfile = result;
    });
    return userProfile;
  }

  @override
  void initState() {
    userProfileMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileUpdate()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: Text('EDIT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
                    ),
                  )
                ),
                Expanded(child: Text('HOTEL NAME', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 60.0),
                    child: IconButton(
                      icon: Icon(Icons.logout, color: Colors.white,), 
                      onPressed: (){
                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.logout();
                    }),
                  ),
                )
              ],
            ),
          ),

          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/hotel.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)
              )
            ),
          ),

          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Text('HOTEL NAME', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),),
                  ),
                  Container(
                    child: Text('hotelemail@gmail.com', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Text('USD 8.50 / one day', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur adipiscing, elit neque aliquam per dignissim, eu sociosqu aliquet ut lacus. Nibh facilisi nullam potenti aliquam vivamus metus habitant in tempus lobortis, vulputate et diam orci vitae primis nec semper taciti phasellus, eleifend fames blandit facilisis netus congue nulla posuere tellus. Cursus vestibulum est sociis blandit mauris lectus ante luctus venenatis class ultrices, pharetra pretium penatibus habitasse aliquam euismod porttitor aliquet id.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text('ROOMS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 10.0,),
                                Text('7', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text('SLEEPS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 10.0,),
                                Text('20', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[100]
                      ),
                    )
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}