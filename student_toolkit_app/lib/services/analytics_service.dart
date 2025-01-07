import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

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
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
      debugPrint(
          '📊 Analytics - Screen View: $screenName, Class: $screenClass');
    } catch (e) {
      debugPrint('❌ Analytics Error (Screen View): $e');
    }
  }

  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
      debugPrint('📊 Analytics - Event: $name, Params: $parameters');
    } catch (e) {
      debugPrint('❌ Analytics Error (Event): $e');
    }
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
    debugPrint(
        '📊 Analytics - GPA Calculation: Courses: $numberOfCourses, System: $gradingSystem, Result: $gpaResult');
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
    debugPrint(
        '📊 Analytics - Resistance Calculation: Bands: $numberOfBands, Colors: ${colors.join(',')}, Result: $result');
  }

  Future<void> logThemeChange({required String newTheme}) async {
    await logEvent(
      name: changeTheme,
      parameters: {'new_theme': newTheme},
    );
    debugPrint('📊 Analytics - Theme Change: New Theme: $newTheme');
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
    debugPrint(
        '📊 Analytics - Contributor Social Click: Name: $contributorName, Platform: $platform');
  }

  Future<void> logGradingSystemChange({required String newSystem}) async {
    await logEvent(
      name: changeGradingSystem,
      parameters: {'new_system': newSystem},
    );
    debugPrint('📊 Analytics - Grading System Change: New System: $newSystem');
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
    debugPrint(
        '📊 Analytics - Resistor Band Change: Band: $bandNumber, New Color: $newColor');
  }

  Future<void> logOnboardingComplete({required int timeSpentSeconds}) async {
    await logEvent(
      name: onboardingComplete,
      parameters: {'time_spent_seconds': timeSpentSeconds},
    );
    debugPrint(
        '📊 Analytics - Onboarding Complete: Time Spent: $timeSpentSeconds seconds');
  }
}
