import 'package:flutter/material.dart';
import 'package:saver/pages/auth/login.dart';

class AccountTypeChooser extends StatefulWidget {
  const AccountTypeChooser({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AccountTypeChooser> createState() => _AccountTypeChooserState();
}

class _AccountTypeChooserState extends State<AccountTypeChooser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Student'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login(
                              typeOfWidget: 'Student',
                            )));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              child: const Text('Mess Manager'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
