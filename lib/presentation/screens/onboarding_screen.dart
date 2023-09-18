import 'package:flutter/material.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          // OnBoarding First Page
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTopRightButton(),
              SizedBox(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: buildTitleLarge(
                          'Selamat Datang di Janganan', TextAlign.start),
                    ),
                    buildImage('assets/images/onboarding-img1.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: buildTitleSmall(
                          'Jaga kesehatanmu dengan memenuhi kebutuhan nutrisi harian mu dari sayur-sayuran, buah-buahan yang berkualitas.',
                          TextAlign.end,
                          4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // OnBoarding Second Page
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTopRightButton(),
              SizedBox(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildImage('assets/images/onboarding-img2.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          buildTitleLarge(
                              'Harga Update Setiap Hari', TextAlign.center),
                          buildTitleSmall(
                              'Ketahui harga terbaru dari kebutuhan mu setiap hari dari smartphone mu.',
                              TextAlign.center,
                              2)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // OnBoarding Third Page
          Center(
            child: SizedBox(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildImage('assets/images/onboarding-img3.png'),
                  ElevatedButton(
                    onPressed: () {
                      // setState(() {
                      //   _isLoading = true;
                      // });
                      Navigator.of(context)
                          .pushReplacementNamed('/sign-in-screen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                    ),
                    // child: _isLoading
                    //     ? SizedBox(
                    //         width: 20,
                    //         height: 20,
                    //         child: CircularProgressIndicator(
                    //           valueColor: AlwaysStoppedAnimation(
                    //             Theme.of(context).colorScheme.background,
                    //           ),
                    //         ),
                    //       )
                    //     :
                    child: Text(
                      'MULAI',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Slide
      bottomSheet: Container(
        color: Colors.white,
        height: 50,
        child: Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 12,
              dotWidth: 15,
              dotColor: Theme.of(context).colorScheme.background,
              activeDotColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopRightButton() => SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/sign-in-screen');
            },
            child: Text(
              'Lewati',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      );

  Widget buildImage(String imgPath) => SizedBox(
        height: 300,
        width: double.infinity,
        child: Image.asset(
          imgPath,
          fit: BoxFit.fitHeight,
        ),
      );

  Widget buildTitleLarge(String text, TextAlign align) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        textAlign: align,
      );

  Widget buildTitleSmall(String text, TextAlign align, int lines) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        textAlign: align,
        maxLines: lines,
      );
}
