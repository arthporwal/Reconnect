import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reconnect/pages/Upload.dart';
import 'package:reconnect/pages/quizpage.dart';

void main() {
  testWidgets('upload screen shows its primary actions', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Upload()));

    expect(find.text('Select File'), findsOneWidget);
    expect(find.text('Upload File'), findsOneWidget);
    expect(find.text('No File Selected'), findsOneWidget);
  });

  test('emotion check-in scores answers locally', () {
    final result = assessEmotionCheckIn({
      for (var index = 0; index < 10; index++) index: true,
    });

    expect(result.difficultFeelingsPercent, 100);
    expect(result.wellbeingPercent, 0);
    expect(result.title, contains('heavy'));
  });
}
