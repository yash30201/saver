import 'package:flutter/material.dart';
import 'package:saver/pages/auth/signup.dart';
import 'package:saver/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.typeOfWidget}) : super(key: key);
  final String typeOfWidget;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextStyle dimStyle = const TextStyle(
    fontSize: 16,
    color: Colors.blueGrey,
    fontFamily: 'Roboto',
  );

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) return "Invalid data";
    return null;
  }

  TextFormField myTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String hintText,
    required bool toObscure,
    required TextInputAction textInputAction,
    required customValidator,
  }) {
    return TextFormField(
      controller: controller,
      validator: customValidator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1.0,
            color: Colors.transparent,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        filled: true,
        hintText: hintText,
        hintStyle: dimStyle,
      ),
      style: dimStyle,
      textInputAction: textInputAction,
      obscureText: toObscure,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.typeOfWidget + ' Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                myTextField(
                  controller: _controllerEmail,
                  context: context,
                  hintText: 'Email',
                  toObscure: false,
                  customValidator: defaultValidator,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                myTextField(
                  controller: _controllerPassword,
                  context: context,
                  hintText: 'Password',
                  toObscure: true,
                  customValidator: defaultValidator,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final user = await _auth.signInWithEmailAndPassword(
                          _controllerEmail.text, _controllerPassword.text);
                      if (user != null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('email', _controllerEmail.text);
                        await prefs.setBool('logged', true);
                        await prefs.setString('type', widget.typeOfWidget);
                        //TODO : Implement signout functionality along with shared preference clearance
                        // TODO : Find some stickers and make the app look cool
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('User ' + user.email + 'logged in!'),
                        ));
                        if (widget.typeOfWidget == 'Student') {
                          Navigator.pushReplacementNamed(
                              context, 'StudentHome');
                        } else {
                          Navigator.pushReplacementNamed(
                              context, 'ManagerHome');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Credentials'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'New to Saver? ',
                      style: dimStyle,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUp(typeOfWidget: widget.typeOfWidget),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up now!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
