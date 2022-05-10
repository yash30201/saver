import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  void checkWhatToDisplay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('logged')) {
      final String _type = prefs.getString('type') ?? 'Student';
      final String _email = prefs.getString('email') ?? 'alpha@beta.com';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ' + _email + 'logged in!'),
        ),
      );
      if (_type == 'Student') {
        Navigator.pushReplacementNamed(context, 'StudentHome');
      } else {
        Navigator.pushReplacementNamed(context, 'ManagerHome');
      }
    } else {
      Navigator.pushReplacementNamed(context, 'AccountTypeChooser');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'SAVER',
                  textStyle:
                      const TextStyle(fontFamily: 'Horizon', fontSize: 50),
                  colors: const [
                    Color.fromARGB(255, 62, 207, 111),
                    Color.fromARGB(255, 46, 162, 240),
                  ],
                  speed: const Duration(milliseconds: 400),
                )
              ],
              totalRepeatCount: 1,
              isRepeatingAnimation: false,
              onFinished: () {
                checkWhatToDisplay();
              },
            ),
          ),
          Positioned(
            child: Image.asset(
              'assets/HEALTHY.png',
              width: MediaQuery.of(context).size.width,
            ),
            bottom: 0,
          ),
        ],
      ),
    );
  }
}
