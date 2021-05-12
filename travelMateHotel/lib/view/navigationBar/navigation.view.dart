import 'package:flutter/material.dart';
import 'package:travelMateHotel/view/booking/booking.view.dart';
import 'package:travelMateHotel/view/home/home.view.dart';
import 'package:travelMateHotel/view/profile/profile.view.dart';
import 'package:travelMateHotel/widget/navigationBar.widget.dart';


class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  
  int index = 0;
  List<Widget> widgetOption = <Widget>[
    Home(),
    Booking(),
    Profile()
  ];

  void changeIndexNumber(value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: widgetOption.elementAt(index),
      bottomNavigationBar: navigationBar(index: index, action: changeIndexNumber),
    );
  }
}