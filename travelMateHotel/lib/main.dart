import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelMateHotel/provider/user.profile.dart';
import 'package:travelMateHotel/view/home.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var multiProvider = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProfileBloc(),)
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
      ),
  );
  runApp(multiProvider);
}

