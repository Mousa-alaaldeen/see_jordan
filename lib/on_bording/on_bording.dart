// ignore_for_file: prefer_const_constructors, void_checks

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../modules/login/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/style/colors.dart';

class BordingModel {
  late String image;
  late String titel;
  late String body;
  BordingModel({
    required this.body,
    required this.titel,
    required this.image,
  });
}

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _onBordingScreenState();
}

// ignore: camel_case_types
class _onBordingScreenState extends State<OnBordingScreen> {
  var boardControlle = PageController();
  bool isLast = false;

  List<BordingModel> bording = [
    BordingModel(
      body: 'body1',
      titel: 'text1',
      image: 'assets/images/travel.jpg',
    ),
    BordingModel(
      body: 'body2',
      titel: 'text2',
      image: 'assets/images/travel.jpg',
    ),
    BordingModel(
      body: 'body3',
      titel: 'text3',
      image: 'assets/images/travel.jpg',
    ),
  ];
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          deffaultTextButton(
            onPressed: () {
              submit();
            },
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardControlle,
                itemBuilder: (context, index) => buildOnBording(bording[index]),
                onPageChanged: (int index) {
                  if (index == bording.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                itemCount: bording.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControlle,
                  count: bording.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor2,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 4,
                      expansionFactor: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardControlle.nextPage(
                          duration: const Duration(
                            microseconds: 750,
                          ) /*التنقل */,
                          curve: Curves.fastOutSlowIn /**شكل التنقل */);
                    }
                  },
                  elevation: 0,
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBording(BordingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            model.image,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Text(
            model.titel,
            // style: GoogleFonts.abrilFatface().copyWith(fontSize: 40),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.body,
          // style: GoogleFonts.justAnotherHand().copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
