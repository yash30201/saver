import 'package:flutter/material.dart';
import 'package:saver/widgets/opt_out_button.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Opt out of',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            const OptOutButton(buttonType: 'Breakfast'),
            const SizedBox(height: 30),
            const OptOutButton(buttonType: 'Lunch'),
            const SizedBox(height: 30),
            const OptOutButton(buttonType: 'Dinner'),
          ],
        ),
      ),
    );
  }
}
