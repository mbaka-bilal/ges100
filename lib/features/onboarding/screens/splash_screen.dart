import 'package:flutter/material.dart';

import '/features/onboarding/screens/onboarding.dart';


import '../../../utils/appstyles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> initialize() async {
  //   FDatabase fDatabase = FDatabase();
  //
  //   try {
  //     /* Communication in english */
  //     if (await fDatabase.checkIfTableExists('ges100') == false) {
  //       await FDatabase.createDatabaseAndTables('ges100');
  //     }else{
  //       await fDatabase.addQuestionsToTable('ges100');
  //     }
  //
  //     /* Computer Appreciation */
  //     if (await fDatabase.checkIfTableExists('ges101') == false) {
  //       await FDatabase.createDatabaseAndTables('ges101');
  //     }else{
  //       await fDatabase.addQuestionsToTable('ges101');
  //     }
  //
  //     /* Entrepreneurship */
  //     if (await fDatabase.checkIfTableExists('ges300') == false) {
  //       await FDatabase.createDatabaseAndTables('ges300');
  //     }else{
  //       await fDatabase.addQuestionsToTable('ges300');
  //     }
  //
  //   } catch (e) {
  //     // print("Splash Screen: could not initialize questions $e");
  //     throw Future.error("Error");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.alabaster,
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(),
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                // Spacer(),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Text("Preparing questions, please wait...."))
              ],
            )));
  }
}
