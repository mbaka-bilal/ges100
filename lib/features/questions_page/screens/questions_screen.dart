import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../models/questions_model.dart';
import '../../../services/f_ads.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';

class PractiseQuestionScreen extends StatefulWidget {
  /// Practise qustions, always show the answer when next is presses.
  const PractiseQuestionScreen(
      {super.key, required this.subjectName, required this.questions});

  final String subjectName;
  final List<Map<String, dynamic>> questions;

  @override
  State<PractiseQuestionScreen> createState() => _PractiseQuestionScreenState();
}

class _PractiseQuestionScreenState extends State<PractiseQuestionScreen> {
  List<QuestionsModel> _questions = [];
  int _chosenIndex = 1000;
  int _currentQuestionIndex = 0;
  bool _checkAnswer = false;
  GoogleAdDisplay googleAdDisplay = GoogleAdDisplay();

  Widget option(
      {required bool chosen, required String question, Color? color}) {
    ///Generate the options, a, b, c, d, e.t.c
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color:
              color ?? ((chosen) ? (AppColors.purple) : (AppColors.alabaster)),
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
  }

  @override
  void dispose() {
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
                                      _chosenIndex = index;

                                      setState(() {});
                                    }, child: Builder(builder: (context) {
                                      bool state = false;
                                      Color? color;

                                      //Else display the formerly chosen answer index.

                                      if (_checkAnswer) {
                                        if (_questions[_currentQuestionIndex]
                                                .answerIndex ==
                                            index) {
                                          // print ("correct answer index is ${
                                          //     _questions[_currentQuestionIndex]
                                          //         .answerIndex
                                          // }");
                                          state = true;
                                          color = AppColors.purple;
                                        } else {
                                          state = false;
                                          color = AppColors.amber;
                                        }
                                      } else {
                                        if (_chosenIndex == index) {
                                          state = true;
                                        } else {
                                          state = false;
                                        }
                                      }

                                      return option(
                                          color: color,
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
                      Visibility(
                        visible: showPreviousButton,
                        child: CustomButton(
                          function: () {
                            _currentQuestionIndex--;
                            setState(() {});
                          },
                          width: 100,
                          child: const Text("Previous"),
                        ),
                      ),
                      Visibility(
                        visible: showNextButton,
                        child: CustomButton(
                            function: () {
                              if (_checkAnswer) {
                                _checkAnswer = false;
                                _currentQuestionIndex++;
                              } else {
                                _checkAnswer = true;
                              }
                              // _currentQuestionIndex++;
                              // _checkAnswer = true;
                              _chosenIndex = 1000;
                              setState(() {});
                            },
                            width: (_checkAnswer) ? 100 : 150,
                            child:
                                Text((_checkAnswer) ? "Next" : "Check Answer")),
                      )
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
