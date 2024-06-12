import 'package:flutter/material.dart';
import 'package:homework4/config/get_it_config.dart';
import 'package:homework4/main.dart';
import 'package:homework4/view/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Hello Mr.${core.get<SharedPreferences>().getString('name')}"),
      ),
    );
  }
}
