import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../services/f_database.dart';
import '../../../state/counter_cubit.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';
import 'banner_ad_widget.dart';

class Body extends StatelessWidget {
  final String tableName;

  /// Body of the quiz without timer
  ///
  ///

  const Body({Key? key, required this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> future =
        FDatabase.fetchQuestions(tableName);

    return LayoutBuilder(
      builder: (context, boxConstraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: boxConstraints.maxHeight,
          ),
          child: FutureBuilder(
              future: future,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  List<Map<String, dynamic>> questionsMap =
                      snapShot.data as List<Map<String, dynamic>>;

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Begin questions and answer display
                        BlocBuilder<CounterCubit, int>(
                            // bloc: CounterCubit(index: 5),
                            builder: (context, state) {
                          String optionString = questionsMap[state]['options'];
                          List<String> options = optionString.split('|');

                          return Column(
                            children: [
                              // BlocBuilder<GoogleAdDisplay, BannerAd?>(
                              //     builder: ((context, state) {
                              //   context.read<GoogleAdDisplay>().initializeBannerAd();
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

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Question ${state + 1}/${questionsMap.length}',
                                  style:
                                      TextStyles.semiBold(20, Colors.black45),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
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
                                                correctAnswerIndex:
                                                    int.tryParse(
                                                        questionsMap[state]
                                                            ['answerIndex'])!,
                                                buttonIndex: index,
                                                question: options[index]))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                        //End question and answer display

                        const BannerAdWidget(),

                        //Begin the logic to show button and answer icon

                        BlocBuilder<CheckAnswerCubit, CheckAnswer>(
                            builder: (context, state) {
                          final Widget displayIcon;

                          if (state.shouldCheckAnswer) {
                            if (((questionsMap[context
                                        .read<CounterCubit>()
                                        .state]['answerIndex'])
                                    .toString() ==
                                (state.chosenAnswerIndex).toString())) {
                              displayIcon = const FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              );
                            } else {
                              displayIcon = const FaIcon(
                                FontAwesomeIcons.xmark,
                                color: Colors.red,
                              );
                            }
                          } else {
                            displayIcon = Container();
                          }

                          return Column(
                            children: [
                              displayIcon,
                              //choose to display the Back - Next button or checkAnswer button
                              (state.shouldCheckAnswer)
                                  ? BlocBuilder<CounterCubit, int>(
                                      builder: ((context, state) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20,
                                                right: 10,
                                                left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomButton(
                                                  function: (state ==
                                                          questionsMap.length -
                                                              1)
                                                      ? null
                                                      : () {
                                                          context
                                                              .read<
                                                                  CounterCubit>()
                                                              .increment(
                                                                  tableName:
                                                                      tableName);
                                                          context
                                                              .read<
                                                                  CheckAnswerCubit>()
                                                              .updateStatus(
                                                                  false,
                                                                  0,
                                                                  true);
                                                        },
                                                  width: 100,
                                                  backgroundColor:
                                                      AppColors.purple,
                                                  child: const Text('Next'),
                                                ),
                                              ],
                                            ),
                                          )))
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, right: 10, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BlocBuilder<CounterCubit, int>(
                                            builder: (context, counterState) =>
                                                CustomButton(
                                              function: (counterState == 0)
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<CounterCubit>()
                                                          .decrement(
                                                              tableName:
                                                                  tableName);
                                                      context
                                                          .read<
                                                              CheckAnswerCubit>()
                                                          .updateStatus(
                                                              false, 0, true);
                                                    },
                                              width: 100,
                                              backgroundColor: Colors.red,
                                              child: Text(
                                                'Back',
                                                style: TextStyles.regular(
                                                    14, Colors.black),
                                              ),
                                            ),
                                          ),
                                          BlocBuilder<CounterCubit, int>(
                                            builder: (context, counterState) =>
                                                CustomButton(
                                              function: (counterState == 0)
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<CounterCubit>()
                                                          .jumpToTop(
                                                              tableName:
                                                                  tableName);
                                                      context
                                                          .read<
                                                              CheckAnswerCubit>()
                                                          .updateStatus(
                                                              false, 0, true);
                                                    },
                                              width: 100,
                                              backgroundColor: Colors.green,
                                              child: Text(
                                                'To Top',
                                                style: TextStyles.regular(
                                                    14, Colors.black),
                                              ),
                                            ),
                                          ),
                                          CustomButton(
                                            function: () {
                                              context
                                                  .read<CheckAnswerCubit>()
                                                  .updateStatus(
                                                    true,
                                                    context
                                                        .read<
                                                            CheckAnswerCubit>()
                                                        .state
                                                        .chosenAnswerIndex,
                                                    false,
                                                  );
                                            },
                                            width: 150,
                                            backgroundColor: AppColors.purple,
                                            child: const Text('Check Answer'),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          );
                        }),
                        //End the logic to show button and answer icon
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
