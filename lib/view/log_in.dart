import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homework4/config/get_it_config.dart';
import 'package:homework4/view/all_progect.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(core.get<SharedPreferences>().getString('name') ?? ''),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 60, 107),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xffbacD9D9D9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('image/Intersect.png'),
              ),
              SizedBox(height: 20),
              Container(
                height: 30,
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            core.get<SharedPreferences>().setString('name', name.text);
            core.get<SharedPreferences>().setString('pass', password.text);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectsPage(),
              ),
            );
          },
          child: Text(
            'Next',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
