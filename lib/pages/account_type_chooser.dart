import 'package:flutter/material.dart';
import 'package:saver/pages/auth/login.dart';

class AccountTypeChooser extends StatefulWidget {
  const AccountTypeChooser({Key? key}) : super(key: key);
  @override
  State<AccountTypeChooser> createState() => _AccountTypeChooserState();
}

class _AccountTypeChooserState extends State<AccountTypeChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Who are you?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: const Text('Student'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(
                        typeOfWidget: 'Student',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: const Text('Mess Manager'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(
                        typeOfWidget: 'Manager',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
