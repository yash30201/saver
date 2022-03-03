import 'package:flutter/material.dart';

class OptOutButton extends StatefulWidget {
  final String buttonType;
  const OptOutButton({
    Key? key,
    required this.buttonType,
  }) : super(key: key);

  @override
  State<OptOutButton> createState() => _OptOutButtonState();
}

class _OptOutButtonState extends State<OptOutButton> {
  bool _isEnabled = true;

  someFunction() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Request Sent'),
    ));
    setState(() {
      _isEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
          ),
        ),
        onPressed: _isEnabled ? someFunction : null,
        child: Text(
          widget.buttonType,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
