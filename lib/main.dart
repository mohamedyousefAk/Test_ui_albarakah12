import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework4/view/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // الحصول على SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // تسجيل SharedPreferences داخل GetIt
  GetIt.instance.registerSingleton<SharedPreferences>(prefs);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}

ValueNotifier<int> counter = ValueNotifier(0);
