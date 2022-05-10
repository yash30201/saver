import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saver/pages/auth/login.dart';
import 'package:saver/pages/auth/signup.dart';
import 'package:saver/pages/account_type_chooser.dart';
import 'package:saver/pages/data_page.dart';
import 'package:saver/pages/loading.dart';
import 'package:saver/pages/manager_home.dart';
import 'package:saver/pages/student_home.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: 'Loader',
      routes: {
        'SignUp': (context) => const SignUp(typeOfWidget: 'Student'),
        'Login': (context) => const Login(typeOfWidget: 'Student'),
        'StudentHome': (context) => const StudentHome(),
        'ManagerHome': (context) => const ManagerHome(),
        'DataPage': (context) => const DataPage(),
        'AccountTypeChooser': (context) => const AccountTypeChooser(),
        'Loader': (context) => const Loader(),
      },
    );
  }
}
