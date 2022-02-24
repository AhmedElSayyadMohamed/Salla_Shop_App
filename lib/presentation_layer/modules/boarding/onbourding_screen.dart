import 'package:flutter/material.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/sharedPrefrences/sharedprefrences.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../user/login/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class onbourding_screen extends StatelessWidget {
  List<BoardingModel> boardingScreen = [
    BoardingModel(
      image: "assets/images/onbourding1.jpg",
      title: "Screen 1 title",
      body: "Screen 1 body",
    ),
    BoardingModel(
      image: "assets/images/onbourding1.jpg",
      title: "Screen 2 title",
      body: "Screen 2 body",
    ),
    BoardingModel(
      image: "assets/images/onbourding1.jpg",
      title: "Screen 3 title",
      body: "Screen 3 body",
    ),
  ];
  //////////////////variable//////////////

  var boardingController = PageController();
  int? pageBourdingIndex;

  /////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit(context);
            },
            child: Text(
              'Skip',
              style: fontAppStyle,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildBourdingItem(boardingScreen[index]),
                itemCount: boardingScreen.length,
                onPageChanged: (index) {
                  print(index);
                  pageBourdingIndex = index;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingScreen.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    activeDotColor: defaultAppColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  // backgroundColor: defaultAppColor,
                  onPressed: () {
                    if (pageBourdingIndex == boardingScreen.length - 1) {
                      submit(context);
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBourdingItem(BoardingModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(image: AssetImage(model.image)),
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void submit(BuildContext context) {
    CachHelper.setData(key: 'onboard', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login_screen()),
          (route) => false,
        );
      }
    });
  }
}
