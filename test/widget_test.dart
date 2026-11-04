import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_1/main.dart';

void main() {
  testWidgets('answering every question correctly ends with a full score', (tester) async {
    // A tall phone-width surface: the column of answers does not scroll.
    tester.view.physicalSize = const Size(1170, 4000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    expect(find.text('Кыргызстанда 7 область барбы?'), findsOneWidget);

    // The answers of the four questions are: yes, yes, no, yes.
    for (final answer in ['Туура', 'Туура', 'Tuura emes', 'Туура']) {
      await tester.tap(find.text(answer));
      await tester.pump();
    }
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Тест завершён!'), findsOneWidget);
    expect(find.text('Ваш результат: 4/4'), findsOneWidget);
  });

  testWidgets('a wrong answer is counted against the score', (tester) async {
    tester.view.physicalSize = const Size(1170, 4000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    for (final answer in ['Tuura emes', 'Туура', 'Tuura emes', 'Туура']) {
      await tester.tap(find.text(answer));
      await tester.pump();
    }
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Ваш результат: 3/4'), findsOneWidget);
  });
}
