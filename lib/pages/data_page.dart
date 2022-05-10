import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final double _totalCount = 100;
  final List<String> _keys = ["Breakfast", "Lunch", "Dinner"];
  final Map<String, double> _data = {
    "Breakfast": 20,
    "Lunch": 10,
    "Dinner": 25,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select date'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {},
              selectionMode: DateRangePickerSelectionMode.single,
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return myPieChart(context, _keys[index],
                    _data[_keys[index]] ?? 10, _totalCount);
              },
            )
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
