import 'package:flutter/material.dart';
import 'package:saver/pages/auth/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.typeOfWidget}) : super(key: key);
  final String typeOfWidget;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerAdmissionNo = TextEditingController();
  final TextStyle dimStyle = const TextStyle(
    fontSize: 16,
    color: Colors.blueGrey,
    fontFamily: 'Roboto',
  );

  String? defaultValidator(String? value) {
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
        title: Text(widget.typeOfWidget + ' SignUp'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                myTextField(
                  controller: _controllerFirstName,
                  context: context,
                  hintText: 'First Name',
                  toObscure: false,
                  textInputAction: TextInputAction.next,
                  customValidator: defaultValidator,
                ),
                const SizedBox(height: 30),
                myTextField(
                  customValidator: defaultValidator,
                  controller: _controllerLastName,
                  context: context,
                  hintText: 'Last Name',
                  toObscure: false,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                myTextField(
                  customValidator: defaultValidator,
                  controller: _controllerAdmissionNo,
                  context: context,
                  hintText: 'Admission No',
                  toObscure: false,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                myTextField(
                  customValidator: defaultValidator,
                  controller: _controllerUsername,
                  context: context,
                  hintText: 'Username',
                  toObscure: false,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                myTextField(
                  customValidator: defaultValidator,
                  controller: _controllerPassword,
                  context: context,
                  hintText: 'Password',
                  toObscure: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                  },
                  child: const Text(
                    'SignUp',
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
                      'Already a user? ',
                      style: dimStyle,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const Login(typeOfWidget: 'Student'),
                          ),
                        );
                      },
                      child: Text(
                        'Login!',
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
