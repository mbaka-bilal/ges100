import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/features/onboarding/screens/onboarding.dart';
import '/services/f_database.dart';

import '../../../utils/appstyles.dart';

// enum CourseTitles {
//   ges100,
//   ges101,
//   ges102,
// }



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initialize() async {
    FDatabase fDatabase = FDatabase();

    try {
      /* Communication in english */
      if (await fDatabase.checkIfTableExists('ges100') == false) {
        await FDatabase.createDatabaseAndTables('ges100');
      await fDatabase.addQuestionsToTable('ges100');
      }

      /* Computer Appreciation */
      if (await fDatabase.checkIfTableExists('ges101') == false) {
        await FDatabase.createDatabaseAndTables('ges101');
        await fDatabase.addQuestionsToTable('ges101');
      }

      // if (await fDatabase.checkIfTableExists('ges102') == false) {
      //   await FDatabase.createDatabaseAndTables('ges102');
      //   await fDatabase.addQuestionsToTable('ges102');
      // }


      // return true;
    } catch (e) {
      // print("Splash Screen: could not initialize questions $e");
      throw Future.error("Error");
    }

    // if (await fDatabase.checkIfTableExists('ges101') == false) {
    //   await FDatabase.createDatabaseAndTables('ges101');
    //   await fDatabase.addQuestionsToTable('ges101');
    // }
    //
    // if (await fDatabase.checkIfTableExists('ges102') == false) {
    //   await FDatabase.createDatabaseAndTables('ges102');
    //   await fDatabase.addQuestionsToTable('ges102');
    // }
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 5),()=>initialize());
    initialize()
        .then((value) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoarding())))
        .onError((error, stackTrace) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ErrorPage()));
    });
    // }));
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
              CupertinoActivityIndicator(
                color: Colors.black,
              ),
              // Spacer(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Preparing questions, please wait...."))
            ],
          ),
        ));
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Error initializing database, please contact admin @ mbakabilal.t@gmail.com",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
