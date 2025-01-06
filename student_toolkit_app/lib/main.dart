import 'package:eeng_toolkit/firebase_options.dart';
import 'package:eeng_toolkit/screens/home_screen.dart';
import 'package:eeng_toolkit/screens/onboarding_screen.dart';
import 'package:eeng_toolkit/services/analytics_service.dart';
import 'package:eeng_toolkit/utils/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final AnalyticsService _analyticsService = AnalyticsService();

  void setTheme(ThemeMode themeMode) async {
    setState(() {
      _themeMode = themeMode;
    });
    await _analyticsService.logThemeChange(
      newTheme: themeMode.toString().split('.').last,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeAnalytics();
  }

  Future<void> _initializeAnalytics() async {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    // Add this measurement ID initialization
    await FirebaseAnalytics.instance.setConsent(
      analyticsStorageConsentGranted: true,
    );

    // Optional: Set user properties
    await FirebaseAnalytics.instance.setUserProperty(
      name: 'app_version',
      value: '1.0.1', // Match your app version
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      navigatorObservers: [
        _analyticsService.getAnalyticsObserver(),
      ],
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    await Future.delayed(
        const Duration(seconds: 1)); // Reduce splash screen display time
    FlutterNativeSplash.remove();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isFirstRun ? const OnboardingScreen() : const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/eng2.svg',
              colorFilter: isDarkMode
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null, // Adjust SVG color
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              'ToolKit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
