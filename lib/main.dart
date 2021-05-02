import 'package:CWCFlutter/controller/user_controller.dart';
import 'package:CWCFlutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(UserController());
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserController controller =
      UserController.to; //Get all users one time when the app first loads

  @override
  void initState() {
    super.initState();
    controller.fecthAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xFFee5f00)),
      ),
      home: Home(),
    );
  }
}
