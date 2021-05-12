import 'package:flutter/material.dart';
import 'package:travelMateHotel/widget/avatar.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemExtent: 200.0,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 12, bottom: 8, left: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      children: [

                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                child: profileAvatar(imgUrl: 'images/hotel.jpg', radius: 35),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('THARINDU KAVISHNA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                                      Text('2021-04-21 - 2021-05-06', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 10),),
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 70.0,
                                  child: Column(
                                    children: [
                                      Text('ROOM'),
                                      Text('5'),
                                      Text('BED'),
                                      Text('7')
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Learning is the process of acquiring new understanding, knowledge, behaviors, skills, values, attitudes', textAlign: TextAlign.justify,),
                                      ],
                                    )
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
            }));
  }
}