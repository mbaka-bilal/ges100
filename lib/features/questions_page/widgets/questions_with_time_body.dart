import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/questions_page/widgets/time_finished_dialog.dart';
import '../../../services/f_database.dart';
import '../../../state/counter_cubit.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';
import 'banner_ad_widget.dart';

class BuildBody extends StatefulWidget {
  BuildBody({super.key});

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  Future<List<Map<String, dynamic>>> future =
      FDatabase.fetchQuestions('ges100');
  int _timeLeft = 30;

  final countDownTimerCubit = CountDownTimerCubit();

  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    // context.read<CountDownTimerCubit>().startTimer();
    countDownTimerCubit.startTimer();
    countDownTimerCubit.stream.listen((event) {
      // print ("listening to cubit");
      if (event == 0) {
        // print ("reduce time");
        _timeLeft--;
        if (_timeLeft == 0) {
          context.read<CountDownTimerCubit>().close();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (builder) =>
                  customDialog(context: context, totalScore: totalScore));
        }
      }
    });
  }

  @override
  void dispose() {
    countDownTimerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {




    return LayoutBuilder(
        builder: (context, boxConstrants) => ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstrants.maxHeight,
              ),
              child: FutureBuilder(
                  future: future,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List<Map<String, dynamic>> result =
                          snapShot.data as List<Map<String, dynamic>>;
                      List<Map<String, dynamic>> questionsMap = result.toList()
                        ..shuffle();
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // BlocBuilder<GoogleAdDisplay, BannerAd?>(
                            //     builder: ((context, state) {
                            //   context
                            //       .read<GoogleAdDisplay>()
                            //       .initializeBannerAd();
                            //   if (state != null) {
                            //     return SizedBox(
                            //       width: state.size.width.toDouble(),
                            //       height: state.size.height.toDouble(),
                            //       child: AdWidget(
                            //         ad: state,
                            //       ),
                            //     );
                            //   } else {
                            //     return Container();
                            //   }
                            // })),
                            const BannerAdWidget(),
                            StreamBuilder(
                                stream: countDownTimerCubit.stream,
                                builder: (context, asyncSnapShot) {
                                  // int? data = asyncSnapShot.data;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      LinearProgressIndicator(
                                        minHeight: 10,
                                        value: (asyncSnapShot.hasData)
                                            ? (_timeLeft / 30)
                                            : 1,
                                        color: AppColors.purple,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.punch_clock_outlined,
                                            color: Colors.black45,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              (asyncSnapShot.hasData)
                                                  ? '$_timeLeft Minutes : ${asyncSnapShot.data} seconds Left'
                                                  : '30 Minutes : 59 seconds Left',
                                              style: TextStyles.semiBold(
                                                  14, Colors.black,))
                                        ],
                                      )
                                    ],
                                  );
                                }),

                            //Begin questions and answer display
                            BlocBuilder<CounterCubit, int>(
                                builder: (context, state) {
                              String optionString =
                                  questionsMap[state]['options'];
                              List<String> options = optionString.split('|');

                              return Column(
                                children: [
                                  Text(
                                    'Question ${state + 1}/${questionsMap.length}',
                                    style:
                                        TextStyles.semiBold(20, Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                questionsMap[state]['question'],
                                                style: TextStyles.medium(
                                                    20, Colors.black),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            ...List.generate(
                                                options.length,
                                                (index) => CustomRadioButton(
                                                    correctAnswerIndex: int
                                                        .tryParse(questionsMap[
                                                                state]
                                                            ['answerIndex'])!,
                                                    buttonIndex: index,
                                                    question: options[index]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            //End question and answer display

                            //Begin display of buttons

                            BlocBuilder<CounterCubit, int>(
                              builder: (context, state) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      function: (state == 0)
                                          ? null
                                          : () {
                                              context
                                                  .read<CounterCubit>()
                                                  .decrement();
                                              context
                                                  .read<CheckAnswerCubit>()
                                                  .updateStatus(false, 0, true);
                                              if (totalScore != 0) {
                                                totalScore--;
                                              }
                                            },
                                      width: 100,
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        'Back',
                                        style: TextStyles.regular(
                                            14, Colors.black),
                                      ),
                                    ),
                                    CustomButton(
                                      function: () {
                                        if (state == questionsMap.length - 1) {
                                          // if we reached the end of the list
                                          // of questions.

                                          //stop the timer
                                          context
                                              .read<CountDownTimerCubit>()
                                              .close();
                                          countDownTimerCubit.close();

                                          //Show the dialog
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (builder) {
                                                print(
                                                    'the total score is $totalScore');
                                                return totalScoreDialog(
                                                    context: context,
                                                    totalScore: totalScore);
                                              });
                                        } else {
                                          context
                                              .read<CounterCubit>()
                                              .increment();
                                          // context.read<
                                          //     CheckAnswerCubit>.updateState();
                                          context
                                              .read<CheckAnswerCubit>()
                                              .updateStatus(false, 0, true);
                                          int answerIndex = context
                                              .read<CheckAnswerCubit>()
                                              .viewStatus()
                                              .chosenAnswerIndex;
                                          if (answerIndex ==
                                              int.tryParse(questionsMap[state]
                                                  ['answerIndex'])) {
                                            // if chosen answer is correct
                                            totalScore++;
                                            print(
                                                "the total scrore is $totalScore");
                                          } else {
                                            // if chosen answer is wrong.
                                            if (totalScore != 0) {
                                              totalScore--;
                                              print(
                                                  "the total scrore is $totalScore");
                                            }
                                          }
                                        }
                                      },
                                      width: 100,
                                      backgroundColor: AppColors.purple,
                                      child: Text(
                                          (state == questionsMap.length - 1)
                                              ? 'Submit'
                                              : 'Next'),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //End display of buttons
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ));
  }
}
