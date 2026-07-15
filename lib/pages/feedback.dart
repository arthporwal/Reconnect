import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/firestore.dart';

class My_feedback extends StatefulWidget {
  My_feedback({Key? key}) : super(key: key);

  @override
  State<My_feedback> createState() => _My_feedbackState();
}

class _My_feedbackState extends State<My_feedback> {
  double ratingValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: const Text('Your valuable Feedback here'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 58, 116, 98),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 80),
            children: [
              const Center(
                child: Text(
                  'How much did you like the App? \n \n',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: ratingValue,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 35,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    Fluttertoast.showToast(msg: 'Rated!');

                    setState(() {
                      ratingValue = rating;
                      RatingGiven(rating);
                    });

                    Navigator.pop(context);
                  },
                ),
              ),
              const Center(
                child: Text(
                  '\n \n Rate us out of 5 :)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ]));
  }
}
