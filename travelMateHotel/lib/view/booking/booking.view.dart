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
    return SafeArea(
        child: PaginateFirestore(
            physics: BouncingScrollPhysics(),
            query: AllBooking().allBooking(),
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (index, BuildContext context, documentSnapshot) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 12, bottom: 8, left: 12),
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
                              child: profileAvatar(imgUrl: 'images/hotel.jpg', radius: 35),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 15.0, bottom: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('ROOMS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text('5', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text('PEOPLES', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                                    Text('7', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),)
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
                                Text('THARINDU KAVISHNA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 3.0,),
                                Text('2021-04-21 - 2021-05-06', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 10),),
                                SizedBox(height: 15.0,),
                                Text('Learning is the process of acquiring new understanding, knowledge, behaviors, skills, values, attitudes Learning is the process of acquiring new understanding, knowledge, behaviors, skills, values, attitudes Learning is the process of acquiring new understanding, knowledge, behaviors, skills, values, attitudes', textAlign: TextAlign.justify,),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
