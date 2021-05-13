import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

Widget profileAvatar({String imgUrl, double radius}) {
  return CircularProfileAvatar(
    null,
    child: Image(
      image: AssetImage(imgUrl),
      fit: BoxFit.cover,
    ),
    borderColor: Colors.white,
    borderWidth: 1,
    elevation: 2,
    radius: radius,
  );
}