import 'package:flutter/material.dart';
import 'package:shoppie/models/onboarding_model.dart';
import 'package:shoppie/modules/login/login_screen.dart';
import 'package:shoppie/shared/components/components.dart';
import 'package:shoppie/shared/components/constants.dart';
import 'package:shoppie/shared/local/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<BoardingModel> boardData = [
    BoardingModel('OnBoarding Screen 1', 'assets/images/onboard1.png',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry'),
    BoardingModel('OnBoarding Screen 2', 'assets/images/onboard2.png',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry'),
    BoardingModel('OnBoarding Screen 3', 'assets/images/onboard3.png',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry'),
  ];

  int pageIndex = 0;

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  CacheHelper.setData(value: true, key: 'isBoardChecked')
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  });
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: defaultColor),
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  controller: controller,
                  itemBuilder: (context, int index) =>
                      buildBoardItem(context, boardData[index]),
                  itemCount: boardData.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: boardData.length,
                      effect: ExpandingDotsEffect(
                          dotWidth: 15,
                          dotHeight: 10,
                          activeDotColor: defaultColor),
                    ),
                    Spacer(),
                    defaultButton(
                        width: 100,
                        radius: 15,
                        onPressed: () {
                          if (pageIndex == (boardData.length) - 1) {
                            CacheHelper.setData(
                                    value: true, key: 'isBoardChecked')
                                .then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                            });
                          } else {
                            controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          }
                        },
                        text: pageIndex == boardData.length - 1
                            ? 'Login'
                            : 'Next',
                        context: context),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Widget buildBoardItem(context, BoardingModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            child: Image(
              image: AssetImage(
                data.image,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          data.title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 28),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          child: Text(data.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  height: 1.5,
                  fontWeight: FontWeight.normal)),
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
