import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:saver/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int _breakfastCount = 60;
  int _lunchCount = 45;
  int _dinnerCount = 21;
  bool _processing = false;
  final AuthService _auth = AuthService();
  final int _totalCount = 50;
  Future<void> onRefresh() async {
    String _dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final breakfast = await FirebaseFirestore.instance
        .collection('counts')
        .doc('Breakfast' + _dateString)
        .get();
    final lunch = await FirebaseFirestore.instance
        .collection('counts')
        .doc('Lunch' + _dateString)
        .get();
    final dinner = await FirebaseFirestore.instance
        .collection('counts')
        .doc('Dinner' + _dateString)
        .get();
    final breakfastCount =
        breakfast.data() != null ? breakfast.data()!['count'] : 0;
    final lunchCount = lunch.data() != null ? lunch.data()!['count'] : 0;
    final dinnerCount = dinner.data() != null ? dinner.data()!['count'] : 0;
    setState(() {
      _breakfastCount = breakfastCount;
      _lunchCount = lunchCount;
      _dinnerCount = dinnerCount;
    });
  }

  @override
  void initState() {
    _breakfastCount = 0;
    _lunchCount = 0;
    _dinnerCount = 0;
    _processing = false;
    onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'Loader', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            child: _processing
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _processing = true;
              });
              await onRefresh();
              setState(() {
                _processing = false;
              });
            },
          )),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/messdash.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    'Percentage of students incoming : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Breakfast : ' +
                        ((_totalCount - _breakfastCount).toDouble() /
                                _totalCount *
                                100)
                            .toStringAsPrecision(4) +
                        '%',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lunch : ' +
                        ((_totalCount - _lunchCount).toDouble() /
                                _totalCount *
                                100)
                            .toStringAsPrecision(4) +
                        '%',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dinner : ' +
                        ((_totalCount - _dinnerCount).toDouble() /
                                _totalCount *
                                100)
                            .toStringAsPrecision(4) +
                        '%',
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

  Container myPieChart(
      BuildContext context, String _title, double _value, double _totalCount) {
    Map<String, double> _chartData = {
      "Absent": _value,
      "Present": _totalCount - _value,
    };
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            _title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          PieChart(
            dataMap: _chartData,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: _title,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }
}
