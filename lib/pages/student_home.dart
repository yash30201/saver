import 'package:flutter/material.dart';
import 'package:saver/services/auth_services.dart';
import 'package:saver/widgets/opt_out_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opt out of'),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'Loader', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 60),
            const OptOutButton(buttonType: 'Breakfast'),
            const SizedBox(height: 30),
            const OptOutButton(buttonType: 'Lunch'),
            const SizedBox(height: 30),
            const OptOutButton(buttonType: 'Dinner'),
            const Spacer(),
            Image.asset('assets/man_doubt.jpg'),
          ],
        ),
      ),
    );
  }
}
