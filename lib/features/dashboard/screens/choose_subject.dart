import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uniport_past_questions/models/questions.dart';

import '../../../features/dashboard/widgets/select_course_card.dart';
import '../../../services/f_ads.dart';
import '../../../utils/appstyles.dart';
// import '../../questions_page/widgets/banner_ad_widget.dart';

class ChooseSubject extends StatefulWidget {
  const ChooseSubject({Key? key}) : super(key: key);

  @override
  State<ChooseSubject> createState() => _ChooseSubjectState();
}

class _ChooseSubjectState extends State<ChooseSubject> {
  GoogleAdDisplay googleAdDisplay = GoogleAdDisplay();

  @override
  void initState() {
    googleAdDisplay.initializeBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ad = GoogleAdDisplay();

    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, boxConstraints) => Stack(
            children: [
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     height: boxConstraints.maxHeight / 2,
              //     color: AppColors.purple,
              //   ),
              // ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  // height: boxConstraints.maxHeight,
                  // width: boxConstraints.maxWidth,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // BlocBuilder<GoogleAdDisplay, BannerAd?>(
                        //     builder: ((contextz, state) {
                        //   context.read<GoogleAdDisplay>().disposeAd();
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
                        // if (ad.fetchBannerAd() != null)
                        // BannerAdWidget(),

                        SelectCourseCard(
                          // proceedTo: Container(),
                          // image: 'image',
                          courseName: 'Ges 100.1',
                          tableName: 'ges100',
                          leadingWidget: Icon(Icons.language),
                          list: ges100,
                        ),

                        // SelectCourseCard(
                        //   // proceedTo: Container(),
                        //   // image: 'image',
                        //   courseName: 'Ges 102.1',
                        //   tableName: 'ges102',
                        //   leadingWidget: Icon(Icons.language),
                        // ),

                        SelectCourseCard(
                          // proceedTo: Container(),
                          // image: 'image',
                          list: ges101,
                          courseName: 'Ges 101.1',
                          tableName: 'ges101',
                          leadingWidget: Icon(Icons.language),
                        ),
                        SelectCourseCard(
                          // proceedTo: Container(),
                          // image: 'image',
                          list: ges300,
                          courseName: 'Ges 300.1',
                          tableName: 'ges300',
                          leadingWidget: Icon(Icons.language),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    height: 80,
                    child: (googleAdDisplay.fetchBannerAd != null)
                        ? AdWidget(ad: googleAdDisplay.fetchBannerAd!)
                        : Container()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
