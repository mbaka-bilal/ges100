import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import '/services/f_ads.dart';
import '/features/onboarding/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Upgrader.clearSavedSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // const appCastURL =
    //     'https://raw.githubusercontent.com/mbaka-bilal/appCast/main/appCast.xml';
    // final cfg = AppcastConfiguration(url: appCastURL, supportedOS: ['android']);

    return MaterialApp(
      title: 'Ges',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: const SplashScreen(),
    );
  }
}
