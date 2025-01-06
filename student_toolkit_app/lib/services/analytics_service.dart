import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Screen names
  static const String homeScreen = 'home_screen';
  static const String gpaCalculatorScreen = 'gpa_calculator_screen';
  static const String resistorCalculatorScreen = 'resistor_calculator_screen';
  static const String contributorsScreen = 'contributors_screen';
  static const String onboardingScreen = 'onboarding_screen';

  // Event names
  static const String calculateGPA = 'calculate_gpa';
  static const String calculateResistance = 'calculate_resistance';
  static const String addCourse = 'add_course';
  static const String removeCourse = 'remove_course';
  static const String changeGradingSystem = 'change_grading_system';
  static const String changeTheme = 'change_theme';
  static const String contributorSocialClick = 'contributor_social_click';
  static const String onboardingComplete = 'onboarding_complete';
  static const String resistorBandChange = 'resistor_band_change';

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  // Custom methods for specific events
  Future<void> logGPACalculation({
    required int numberOfCourses,
    required String gradingSystem,
    required double gpaResult,
  }) async {
    await logEvent(
      name: calculateGPA,
      parameters: {
        'number_of_courses': numberOfCourses,
        'grading_system': gradingSystem,
        'gpa_result': gpaResult,
      },
    );
  }

  Future<void> logResistanceCalculation({
    required int numberOfBands,
    required List<String> colors,
    required String result,
  }) async {
    await logEvent(
      name: calculateResistance,
      parameters: {
        'number_of_bands': numberOfBands,
        'band_colors': colors.join(','),
        'resistance_result': result,
      },
    );
  }

  Future<void> logThemeChange({required String newTheme}) async {
    await logEvent(
      name: changeTheme,
      parameters: {'new_theme': newTheme},
    );
  }

  Future<void> logContributorSocialClick({
    required String contributorName,
    required String platform,
  }) async {
    await logEvent(
      name: contributorSocialClick,
      parameters: {
        'contributor_name': contributorName,
        'platform': platform,
      },
    );
  }

  Future<void> logGradingSystemChange({required String newSystem}) async {
    await logEvent(
      name: changeGradingSystem,
      parameters: {'new_system': newSystem},
    );
  }

  Future<void> logResistorBandChange({
    required int bandNumber,
    required String newColor,
  }) async {
    await logEvent(
      name: resistorBandChange,
      parameters: {
        'band_number': bandNumber,
        'new_color': newColor,
      },
    );
  }

  Future<void> logOnboardingComplete({required int timeSpentSeconds}) async {
    await logEvent(
      name: onboardingComplete,
      parameters: {'time_spent_seconds': timeSpentSeconds},
    );
  }
}
