import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:travelMateHotel/provider/user.profile.dart';
import 'package:travelMateHotel/service/home.page.service.dart';
import 'package:travelMateHotel/view/postView/post.view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final UserProfileBloc userProfileBloc = Provider.of<UserProfileBloc>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        )
      ),
      padding: EdgeInsets.all(10),
      child: Column(
    children: [
      Padding(
        padding:const EdgeInsets.only(top: 40, bottom: 20, left: 5, right: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: PaginateFirestore(
            physics: BouncingScrollPhysics(),
            query: AllUserProfile().allUserProfile(), // test this
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (index, BuildContext context, documentSnapshot) {
              return GestureDetector(
                onTap: () {
                  userProfileBloc.changeUserProfileBloc(
                    hotelName: documentSnapshot.data()['hotelName'], 
                    hotelLocation: documentSnapshot.data()['location'], 
                    hotelImageUrl: documentSnapshot.data()['hotelImageUrl'], 
                    hotelDesc: documentSnapshot.data()['description'], 
                    hotelPrice: documentSnapshot.data()['price']
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostView()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            image: DecorationImage(
                                image: NetworkImage(documentSnapshot.data()['hotelImageUrl'] ?? documentSnapshot.data()['userImageUrl']),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child:  Row(
                              children: [
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(documentSnapshot.data()['hotelName'] ?? 'HOTEL NAME', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                                      SizedBox(height: 5.0,),
                                      Row(
                                        children: [
                                          Text('FEATURES'),
                                          SizedBox(width: 20.0,),
                                          Icon(Icons.king_bed),
                                          Icon(Icons.wifi),
                                          Icon(Icons.train)
                                        ],
                                      )
                                    ],
                                  )
                                ),
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('For Day  USD ${documentSnapshot.data()['price']}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                                      SizedBox(height: 5.0,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 50.0,),
                                          Icon(Icons.star, color: Colors.yellow,),
                                          Icon(Icons.star, color: Colors.yellow,),
                                          Icon(Icons.star, color: Colors.yellow,),
                                          Icon(Icons.star),
                                          Icon(Icons.star),
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      )
    ],
      ),
    );
  }
}