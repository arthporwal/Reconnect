import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reconnect/pages/home.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int choiceIndex = 0;

  Map<String, double> dataMap = {
    "Happiness": 40,
    "Sadness": 60,
  };

  List<Color> colorList = [
    // Color.fromARGB(255, 230, 222, 111),
    // Color.fromARGB(255, 87, 86, 86),
    Colors.yellow,
    Colors.grey.shade600
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text('Analysis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PieChart(
              dataMap: dataMap,
              chartRadius: MediaQuery.of(context).size.width,
              colorList: colorList,
              centerText: 'Analytics',
            ),
            SizedBox(height: 60),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 36, 182, 121)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text('Continue'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
