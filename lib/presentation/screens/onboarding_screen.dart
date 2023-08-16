import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          controller: pageController,
          children: [
            Center(
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Text(
                        'Selamat Datang di Janganan',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/onboarding-img1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Text(
                        'Jaga kesehatanmu dengan memenuhi kebutuhan nutrisi harian mu dari sayur-sayuran, buah-buahan yang berkualitas.',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/onboarding-img2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/onboarding-img3.png',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/bottom-navigation');
                    },
                    child: Text(
                      'MULAI',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
