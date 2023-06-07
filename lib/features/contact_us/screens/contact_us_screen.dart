import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/appstyles.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendEmailController = TextEditingController();

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(),
                RichText(
                  text: TextSpan(
                      text: "My Email Address\n",
                      style: TextStyles.semiBold(20, AppColors.amber),
                      children: [
                        TextSpan(
                            text: "mbakabilal.t@gmail.com           ",
                            style: TextStyles.regular(
                              20,
                              Colors.black,
                            ))
                      ]),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // RichText(
                //   text: TextSpan(
                //       text: "My Github profile\n",
                //       style: TextStyles.semiBold(20, AppColors.amber),
                //       children: [
                //         TextSpan(
                //             recognizer: TapGestureRecognizer()
                //               ..onTap = () async {
                //                 final Uri url =
                //                     Uri.parse("https://github.com/mbaka-bilal");
                //                 await launchUrl(url);
                //               },
                //             text: "https://github.com/mbaka-bilal",
                //             style: TextStyles.regular(
                //               20,
                //               Colors.blue,
                //             ))
                //       ]),
                // ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    color: Colors.grey,
                    height: 200,
                    child: TextField(
                      controller: sendEmailController,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          filled: true,
                          hintText:
                          'Send complaints/Send recommendations / Hire me 🙏 / Say Hello / '
                              'Say Thank you.'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue)),
                      onPressed: () async {
                        final String message = sendEmailController.text;

                        final Uri uri = Uri(
                          scheme: 'mailto',
                          path: 'mbakabilal.t@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Ges App',
                            'body': message,
                          }),
                        );

                        await launchUrl(uri);
                      },
                      child: const Text("Email me 📧 ✈️")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
