import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reconnect/pages/charts.dart';
import '../widgets/firestore.dart';

class Question {
  final String question;

  const Question({
    required this.question,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> Questions = [
    //1
    const Question(
      question: 'What does mental means to you, is it the same as happiness?',
    ),
    //2
    const Question(
      question: 'Have your sleeping habits changed in past few days/months?',
    ),
    // 3
    const Question(
      question: 'Have your eating habits changed over the past few days?',
    ),
    // 4
    const Question(
      question:
          'Do you enjoy little pleasure or intrest in the activities you usually do?',
    ),
    // 5
    const Question(
      question: 'Do you feel restlessness?',
    ),
    // 6
    const Question(
      question: 'Do you have difficulty in sleeping?',
    ),
    // 7
    const Question(
      question: 'Have your appetite changed over the past few weeks?',
    ),
    // 8
    const Question(
      question:
          'Do you ever feel that you’ve been affected by feelings of edginess, anxiety, or nerves?',
    ),
    // 9
    const Question(
      question:
          'Have you experienced a week or longer of lower-than-usual interest in activities that you usually enjoy?',
    ),
    // 10
    const Question(
      question:
          'Have you ever experienced an ‘attack’ of fear, anxiety, or panic',
    ),
  ];

  int yes = 0;
  int no = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text(
          'Analysis',
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: Questions.length,
          itemBuilder: (BuildContext context, int index) {
            final Question = Questions[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    Question.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: TextButton(
                      onPressed: () => openDialog(),
                      child: Text(
                        'Answer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  isThreeLine: true,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 43, 165, 139),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Submit'),
          ],
        ),
        onPressed: () {
          Fluttertoast.showToast(msg: 'Submitted');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Charts()));
          setState(() {
            Analysis(yes, no);
          });
        },
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Choose answer'),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      yes = yes + 1;
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      no = no + 1;
                      Navigator.pop(context);
                    },
                    child: Text('No')),
              ],
            )),
          ));
}
