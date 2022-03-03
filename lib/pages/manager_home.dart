import 'package:flutter/material.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int _breakfastCount = 0;
  int _lunchCount = 0;
  int _dinnerCount = 0;
  Future<void> onRefresh() {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _breakfastCount++;
              _lunchCount++;
              _dinnerCount++;
            });
          },
          child: const Icon(Icons.refresh_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 10,
                    color: Colors.grey[200] ?? Colors.grey,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Students opted out : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Breakfast : ' + _breakfastCount.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lunch : ' + _lunchCount.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dinner : ' + _dinnerCount.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
