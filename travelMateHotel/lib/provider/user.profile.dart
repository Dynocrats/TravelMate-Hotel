import 'package:flutter/material.dart';

class UserProfileBloc extends ChangeNotifier{
  String hotelName, hotelPrice, hotelDesc, hotelLocation, hotelImageUrl;

  setUserProfileBloc({String hotelName, String hotelPrice, String hotelDesc, String hotelLocation, String hotelImageUrl}){
    this.hotelName = hotelName;
    this.hotelPrice = hotelPrice;
    this.hotelDesc = hotelDesc;
    this.hotelImageUrl = hotelImageUrl;
    this.hotelLocation = hotelLocation;
    notifyListeners();
  }

  changeUserProfileBloc({String hotelName, String hotelPrice, String hotelDesc, String hotelLocation, String hotelImageUrl}){
    this.hotelName = hotelName;
    this.hotelPrice = hotelPrice;
    this.hotelDesc = hotelDesc;
    this.hotelImageUrl = hotelImageUrl;
    this.hotelLocation = hotelLocation;
    notifyListeners();
  }

  getHotelName() => hotelName;
  getHotelPrice() => hotelPrice;
  getHotelDesc() => hotelDesc;
  getHotelImageUrl() => hotelImageUrl;
  getHotelLocation() => hotelLocation;
  
}