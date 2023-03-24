import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniport_past_questions/services/prefs.dart';

class CounterCubit extends Cubit<int> {
  // final int index;

  /// Class to handle current index of question to display
  ///
  ///

  CounterCubit({required bool shouldResume}) : super(0) {
    if (shouldResume) {
      _updateIndex();
    }
  }

  void _updateIndex() async {
    int? index = await UserData.readData();
    if (index == null) {
      emit(0);
    } else {
      emit(index - 1);
    }
  }

  //Add 1 to the current state
  void increment() async {
    emit(state + 1);
    await UserData.setData(state + 1);
  }

  // Subtract 1 from the current state
  void decrement() async {
    emit(state - 1);
    await UserData.setData(state + 1);
  }
}

class CheckAnswerCubit extends Cubit<CheckAnswer> {
  CheckAnswerCubit()
      : super(CheckAnswer(
            shouldCheckAnswer: false, chosenAnswerIndex: 0, isFirstTime: true));

  void updateStatus(
      bool shouldCheckAnswer, int chosenAnswerIndex, bool firstTime) {
    emit(CheckAnswer(
        shouldCheckAnswer: shouldCheckAnswer,
        chosenAnswerIndex: chosenAnswerIndex,
        isFirstTime: firstTime));
  }

  CheckAnswer viewStatus() {
    return state;
  }
}

class CheckAnswer {
  bool shouldCheckAnswer;
  int chosenAnswerIndex;
  bool isFirstTime;

  CheckAnswer(
      {required this.shouldCheckAnswer,
      required this.chosenAnswerIndex,
      required this.isFirstTime});

  // set updateAnswerIndex(int index) {
  //   chosenAnswerIndex = index;
  // }

  // set updateShouldCheckAnswer(bool status) {
  //   shouldCheckAnswer = status;
  // }
}

class CountDownTimerCubit extends Cubit<int> {
  Timer? timer;

  CountDownTimerCubit() : super(30) {
    emit(30);
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (state == 0) {
        timer.cancel();
      } else {
        emit(state - 1);
      }
    });
  }

  @override
  Future<void> close() {
    timer ?? timer!.cancel();
    return super.close();
  }
}
