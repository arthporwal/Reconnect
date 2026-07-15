import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reconnect/pages/charts.dart';

class Question {
  final String question;

  const Question({
    required this.question,
  });
}

/// A non-diagnostic, on-device check-in result.
class EmotionCheckInResult {
  final double wellbeingPercent;
  final double difficultFeelingsPercent;
  final String title;
  final String message;

  const EmotionCheckInResult({
    required this.wellbeingPercent,
    required this.difficultFeelingsPercent,
    required this.title,
    required this.message,
  });
}

EmotionCheckInResult assessEmotionCheckIn(Map<int, bool> answers) {
  const symptomQuestionCount = 9;
  final symptomCount = List.generate(symptomQuestionCount, (offset) => offset + 1)
      .where((index) => answers[index] == true)
      .length;
  final difficultFeelingsPercent = symptomCount / symptomQuestionCount * 100;
  final wellbeingPercent = 100 - difficultFeelingsPercent;

  if (symptomCount >= 6) {
    return EmotionCheckInResult(
      wellbeingPercent: wellbeingPercent,
      difficultFeelingsPercent: difficultFeelingsPercent,
      title: 'It sounds like things may feel heavy right now',
      message:
          'This check-in is not a diagnosis. Consider talking with someone you trust or a qualified mental-health professional.',
    );
  }
  if (symptomCount >= 3) {
    return EmotionCheckInResult(
      wellbeingPercent: wellbeingPercent,
      difficultFeelingsPercent: difficultFeelingsPercent,
      title: 'You may be dealing with some difficult feelings',
      message:
          'This check-in is not a diagnosis. A little rest, support, and a conversation with someone you trust may help.',
    );
  }
  return EmotionCheckInResult(
    wellbeingPercent: wellbeingPercent,
    difficultFeelingsPercent: difficultFeelingsPercent,
    title: 'Your check-in looks relatively steady',
    message:
        'This check-in is not a diagnosis. Keep noticing how you feel and reach out for support whenever you need it.',
  );
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    const Question(
      question: 'Have you generally felt calm or hopeful recently?',
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

  final Map<int, bool> answers = {};

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
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 96),
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            final question = questions[index];
            final selectedAnswer = answers[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    question.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: TextButton(
                      onPressed: () => openDialog(index),
                      child: Text(
                        selectedAnswer == null
                            ? 'Answer'
                            : selectedAnswer
                                ? 'Answered: Yes'
                                : 'Answered: No',
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
          if (answers.length < questions.length) {
            Fluttertoast.showToast(msg: 'Please answer all questions');
            return;
          }
          final result = assessEmotionCheckIn(answers);
          Fluttertoast.showToast(msg: 'Submitted');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Charts(
                        happinessPercent: result.wellbeingPercent,
                        sadnessPercent: result.difficultFeelingsPercent,
                        resultTitle: result.title,
                        resultMessage: result.message,
                      )));
        },
      ),
    );
  }

  Future openDialog(int questionIndex) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Choose answer'),
            content: Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        answers[questionIndex] = true;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        answers[questionIndex] = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('No')),
              ],
            )),
          ));
}
