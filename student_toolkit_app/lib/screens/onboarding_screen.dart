import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import '../widgets/custom_button.dart';
import '../services/analytics_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AnalyticsService _analytics = AnalyticsService();
  final Stopwatch _onboardingTimer = Stopwatch()..start();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Student Toolkit App',
      'description':
          'An all-in-one app for checking GPA and resistor colour codes.',
      'image': 'assets/onboarding_images/onboarding1.jpg',
    },
    {
      'title': 'GPA Checker',
      'description': 'Easily calculate your GPA using an intuitive interface.',
      'image': 'assets/onboarding_images/onboarding3.jpg',
    },
    {
      'title': 'Resistor Colour Decoder',
      'description': 'Decode resistor colour codes quickly and accurately.',
      'image': 'assets/onboarding_images/onboarding8.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(
      screenName: AnalyticsService.onboardingScreen,
      screenClass: 'OnboardingScreen',
    );
  }

  Future<void> completeOnboarding() async {
    _onboardingTimer.stop();
    await _analytics.logOnboardingComplete(
      timeSpentSeconds: _onboardingTimer.elapsed.inSeconds,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              onboardingData[index]['image']!,
                              height: orientation == Orientation.portrait
                                  ? 400
                                  : 150,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              onboardingData[index]['title']!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                onboardingData[index]['description']!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: _currentPage == index ? 10 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                    label: _currentPage == onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: _currentPage == onboardingData.length - 1
                        ? completeOnboarding
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
