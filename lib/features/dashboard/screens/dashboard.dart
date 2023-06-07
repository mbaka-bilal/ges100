import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uniport_past_questions/services/f_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../features/dashboard/screens/choose_subject.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../contact_us/screens/contact_us_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GoogleAdDisplay googleAdDisplay = GoogleAdDisplay();

  @override
  void initState() {
    super.initState();
    googleAdDisplay.initializeBannerAd();
  }

  @override
  void dispose() {
    googleAdDisplay.disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, boxConstraints) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()));
                    },
                    child: const Text("Contact US"),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(AppImages.dashboardImage),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Past Questions',
                      style: TextStyles.semiBold(20, Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      function: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ChooseSubject()));
                      },
                      width: boxConstraints.maxWidth / 2,
                      backgroundColor: AppColors.purple,
                      child: Text(
                        'Start test',
                        style: TextStyles.regular(14, Colors.white),
                      ),
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }
}
