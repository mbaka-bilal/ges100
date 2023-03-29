import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/services/prefs.dart';

class CounterCubit extends Cubit<int> {
  // final int index;

  /// Class to handle current index of question to display
  ///
  ///

  CounterCubit({required bool shouldResume,required String tableName}) : super(0) {
    if (shouldResume) {
      _updateIndex(tableName);
    }
  }

  void _updateIndex(String tableName) async {
    int? index = await UserData.readData(tableName);
    if (index == null) {
      emit(0);
    } else {
      emit(index - 1);
    }
  }

  //Add 1 to the current state
  void increment({String? tableName}) async {
    emit(state + 1);
    if (tableName != null){
      await UserData.setData(state + 1,tableName);
    }
  }

  // Subtract 1 from the current state
  void decrement({String? tableName}) async {
    emit(state - 1);
    if (tableName != null){
      await UserData.setData(state + 1,tableName);
    }
  }

  //Jump to a question index
  void jumpToTop({String? tableName}) async {
    emit(0);
    if (tableName != null){
      await UserData.setData(state + 1,tableName);
    }
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
  // RestartableTimer
  // RestartableTimer? timer;
  Timer? timer;

  CountDownTimerCubit() : super(60);

  void startTimer() {
    emit(60);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // print ("the timer is working $state");
      if (state == 0) {
        // print ("done");
        timer.cancel();
        startTimer();
      } else {
        emit(state - 1);
      }
    });
  }

  @override
  Future<void> close() {
    if (timer != null){
      timer!.cancel();
    }
    return super.close();
  }
}
