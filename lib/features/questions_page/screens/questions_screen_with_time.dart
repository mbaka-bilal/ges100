import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../features/dashboard/screens/choose_subject.dart';
import '../../../models/questions_model.dart';
import '../../../services/f_ads.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';

class QuestionScreenWithTime extends StatefulWidget {
  /// Questions screen with a count down timer
  /// e.g QuestionsScreenWithTimer('tableName')
  ///
  const QuestionScreenWithTime(
      {super.key, required this.subjectName, required this.questions});

  final String subjectName;
  final List<Map<String, dynamic>> questions;

  @override
  State<QuestionScreenWithTime> createState() => _QuestionScreenWithTimeState();
}

class _QuestionScreenWithTimeState extends State<QuestionScreenWithTime> {
  List<QuestionsModel> _questions = [];
  int _chosenIndex = 1000;
  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  List<dynamic> _indexOfChosenAnswer = [];
  int minutesLeft = 29;
  int secondsLeft = 60;
  late Timer _timer;
  GoogleAdDisplay googleAdDisplay = GoogleAdDisplay();

  Widget option({required bool chosen, required String question}) {
    ///Generate the options, a, b, c, d, e.t.c
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: (chosen) ? (AppColors.purple) : (AppColors.alabaster),
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              question,
              style: TextStyles.medium(14, Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void calculateTotalScore() {
    for (int i = 0; i < _indexOfChosenAnswer.length - 1; i++) {
      if (_indexOfChosenAnswer[i] != null) {
        // totalChecked++;
        if (_indexOfChosenAnswer[i] ==
            _questions[_currentQuestionIndex].answerIndex) {
          _totalScore++;
        }
      }
    }
    setState(() {});
  }

  Widget done() {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 200,
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                "Total score is $_totalScore",
                style: TextStyles.regular(20, Colors.black),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseSubject()),
                          (route) => false);
                    },
                    child: const Text("Exit")),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    googleAdDisplay.initializeBannerAd();
    //Make a list for the chosen question
    for (Map<String, dynamic> item in widget.questions) {
      String optionString = item["options"] as String;
      List<String> options = optionString.split("|");

      _questions.add(QuestionsModel(
          question: item["question"],
          options: options,
          answerIndex: item["answerIndex"],
          chosenAnswerIndex: 0));
    }

    /** Select random 75 ****/
    _questions.shuffle();
    _questions = _questions.sublist(0, 75);

    //Populate the chosen answers index.
    _indexOfChosenAnswer = List.generate(_questions.length, (index) => null);

    // print("questinos length is ${_questions.length}");

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutesLeft == 0 && secondsLeft == 1) {
        _timer.cancel();
        secondsLeft = 0;
        minutesLeft = 0;
        calculateTotalScore();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => done());
      } else {
        if (secondsLeft == 1) {
          minutesLeft--;
          secondsLeft = 60;
        }
        secondsLeft--;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    googleAdDisplay.disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.alabaster,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Temp Screen',
            style: TextStyles.regular(20, Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                    style: TextStyles.semiBold(20, Colors.black45),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "$minutesLeft : $secondsLeft Minutes Left",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: (minutesLeft < 5) ? Colors.red : Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                _questions[_currentQuestionIndex].question,
                                style: TextStyles.medium(20, Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ...List.generate(
                                _questions[_currentQuestionIndex]
                                    .options
                                    .length,
                                (index) => InkWell(onTap: () {
                                      /*
                                      * Update chosen answer, then update it in the list
                                      * check if chosenindex == the answer, if it is update
                                      * total score.
                                      * */

                                      //this is what is used to color the options
                                      //when i click on it.

                                      // _chosenIndex = index;
                                      _indexOfChosenAnswer[
                                          _currentQuestionIndex] = index;

                                      setState(() {});
                                    }, child: Builder(builder: (context) {
                                      bool state = false;

                                      //For remembering chosen answer
                                      // If it is null don't display anythinh.
                                      if (_indexOfChosenAnswer[
                                              _currentQuestionIndex] ==
                                          null) {
                                        state = false;
                                      }

                                      //Else display the formerly chosen answer index.
                                      if (_indexOfChosenAnswer[
                                              _currentQuestionIndex] ==
                                          index) {
                                        state = true;
                                      } else {
                                        state = false;
                                      }

                                      return option(
                                          chosen: state,
                                          question:
                                              _questions[_currentQuestionIndex]
                                                  .options[index]);
                                    })))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Builder(builder: (context) {
                  bool showPreviousButton = false;
                  bool showNextButton = true;

                  if (_currentQuestionIndex == 0) {
                    showPreviousButton = false;
                  } else {
                    showPreviousButton = true;
                  }

                  if (_currentQuestionIndex == (_questions.length - 1)) {
                    showNextButton = false;
                  } else {
                    showNextButton = true;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showPreviousButton)
                        CustomButton(
                          function: () {
                            _currentQuestionIndex--;
                            setState(() {});
                          },
                          width: 100,
                          child: const Text("Previous"),
                        ),
                      CustomButton(
                          function: () {
                            _timer.cancel();
                            secondsLeft = 0;
                            minutesLeft = 0;
                            calculateTotalScore();
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => done());
                          },
                          width: 100,
                          child: const Text("Submit")),
                      if (showNextButton)
                        CustomButton(
                            function: () {
                              _currentQuestionIndex++;
                              setState(() {});
                            },
                            width: 100,
                            child: const Text("Next"))
                    ],
                  );
                }),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  // color: Colors.red,
                  height: 80,
                  child: (googleAdDisplay.fetchBannerAd != null)
                      ? AdWidget(ad: googleAdDisplay.fetchBannerAd!)
                      : Container())
            ],
          ),
        ));
  }
}
