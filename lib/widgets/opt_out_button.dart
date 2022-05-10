import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_services.dart';

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
  final DatabaseMethods _dbMethods = DatabaseMethods();
  bool isEnabled = true;
  updateCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String? _valueOfPreviousUpdate =
        prefs.getString('previousUpdate' + widget.buttonType);
    String _dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (_valueOfPreviousUpdate == null ||
        _dateString != _valueOfPreviousUpdate) {
      setState(() {
        isEnabled = false;
      });
      _dbMethods.incrementCountOfMeal(widget.buttonType);
      setState(() {
        isEnabled = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have already opted out for this meal'),
      ));
    }
  }

  @override
  void initState() {
    isEnabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
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
          onPressed: isEnabled ? updateCount : null,
          child: Text(
            widget.buttonType,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
