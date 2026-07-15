import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:reconnect/pages/home.dart';

class Charts extends StatefulWidget {
  final double happinessPercent;
  final double sadnessPercent;
  final String resultTitle;
  final String resultMessage;

  const Charts({
    super.key,
    required this.happinessPercent,
    required this.sadnessPercent,
    required this.resultTitle,
    required this.resultMessage,
  });

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int choiceIndex = 0;

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 48),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  widget.resultTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.resultMessage,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          PieChart(
            dataMap: {
              "Steady feelings": widget.happinessPercent,
              "Difficult feelings": widget.sadnessPercent,
            },
            chartRadius: MediaQuery.of(context).size.width,
            colorList: colorList,
            centerText: 'Analytics',
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 36, 182, 121)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text('Continue')),
          )
        ],
      ),
    );
  }
}
