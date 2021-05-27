import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:travelMateHotel/service/booking.service.dart';
import 'package:travelMateHotel/widget/avatar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
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
        child: PaginateFirestore(
            physics: BouncingScrollPhysics(),
            query: AllBooking().allBooking(),
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (index, BuildContext context, documentSnapshot) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, right: 12, left: 12),
                  child: Container(
                    height: 240.0,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 10.0),
                              child: profileAvatarNetwork(imgUrl: documentSnapshot.data()['userUrl'], radius: 35),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 15.0, bottom: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('ROOMS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text(documentSnapshot.data()['room'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text('PEOPLES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text(documentSnapshot.data()['sleep'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),)
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(documentSnapshot.data()['userName'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 3.0,),
                                Text('${documentSnapshot.data()['start-date']} - ${documentSnapshot.data()['end-date']}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 10),),
                                SizedBox(height: 15.0,),
                                Expanded(child: Text(documentSnapshot.data()['userDesc'], textAlign: TextAlign.justify,)),
                                SizedBox(height: 15.0,),
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
      ),
    );
  }
}
