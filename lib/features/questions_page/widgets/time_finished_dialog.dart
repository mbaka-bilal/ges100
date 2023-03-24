import 'package:flutter/material.dart';

import '/features/dashboard/screens/choose_subject.dart';
import '/widgets/custom_button.dart';

Widget customDialog({required BuildContext context, required int totalScore}) {
  return WillPopScope(
    onWillPop: (() => Future.value(false)),
    child: AlertDialog(
      title: const Text('Time finished'),
      actions: [
        CustomButton(
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const ChooseSubject()),
                  (route) => false);
            },
            width: double.infinity,
            child: const Text("Okay"))
      ],
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        totalScoreDialog(context: context, totalScore: totalScore)
      ]),
    ),
  );
}

Widget totalScoreDialog(
    {required BuildContext context, required int totalScore}) {
  return WillPopScope(
    onWillPop: (() => Future.value(false)),
    child: AlertDialog(
      title: const Text(
        'Total Score',
        style: TextStyle(
          fontSize: 30,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        CustomButton(
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const ChooseSubject()),
                  (route) => false);
            },
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("You scored: $totalScore")],
            ))
      ],
    ),
  );
}
