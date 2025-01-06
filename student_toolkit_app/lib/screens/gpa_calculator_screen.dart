import 'package:eeng_toolkit/services/analytics_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({super.key});

  @override
  _GPACalculatorScreenState createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  final AnalyticsService _analytics = AnalyticsService();
  final List<Map<String, dynamic>> _courses = [];
  String _selectedGradingSystem = '4.0';
  double _gpa = 0.0;

  final Map<String, double> gradingSystem4 = {
    'A': 4.0,
    'B+': 3.75,
    'B': 3.25,
    'B-': 3.0,
    'C+': 2.75,
    'C': 2.5,
    'C-': 2.0,
    'D': 1.5,
    'E': 1.25,
    'F': 1.0,
  };

  final Map<String, double> gradingSystem5 = {
    'A': 5.0,
    'B': 4.0,
    'C': 3.0,
    'D': 2.0,
    'E': 1.0,
    'F': 0.0,
  };

  Map<String, double> get selectedGradingScale =>
      _selectedGradingSystem == '4.0' ? gradingSystem4 : gradingSystem5;

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(
      screenName: AnalyticsService.gpaCalculatorScreen,
      screenClass: 'GPACalculatorScreen',
    );
  }

  void _addCourse() {
    setState(() {
      _courses.add({'name': '', 'grade': 'A', 'credit': 1});
    });
    _analytics.logEvent(
      name: AnalyticsService.addCourse,
      parameters: {'total_courses': _courses.length},
    );
  }

  void _resetGPA() {
    setState(() {
      _gpa = 0.0;
    });
  }

  void _removeCourse(int index) {
    setState(() {
      _courses.removeAt(index);
      _resetGPA(); // Reset GPA when a course is deleted
    });
  }

  void _calculateGPA() {
    double totalPoints = 0.0;
    int totalCredits = 0;

    for (var course in _courses) {
      final gradePoint = selectedGradingScale[course['grade']] ?? 0.0;
      final credit = course['credit'];
      totalPoints += gradePoint * credit;
      totalCredits += credit as int;
    }

    setState(() {
      _gpa = totalCredits > 0 ? totalPoints / totalCredits : 0.0;
    });

    _analytics.logGPACalculation(
      numberOfCourses: _courses.length,
      gradingSystem: _selectedGradingSystem,
      gpaResult: _gpa,
    );
  }

  void _changeGradingSystem(String? value) {
    setState(() {
      _selectedGradingSystem = value ?? '4.0';
      _resetGPA();
    });
    _analytics.logGradingSystemChange(newSystem: _selectedGradingSystem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedGradingSystem,
              items: ['4.0', '5.0']
                  .map((system) => DropdownMenuItem(
                        value: system,
                        child: Text('$system GPA Scale'),
                      ))
                  .toList(),
              onChanged: _changeGradingSystem,
              decoration: const InputDecoration(
                labelText: 'Select Grading Scale',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  final course = _courses[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Module Name',
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor, // Use theme's hint color
                                  ),
                                ),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color, // Use theme's text color
                                ),
                                onChanged: (value) {
                                  course['name'] = value;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: course['grade'],
                              items: selectedGradingScale.keys
                                  .map((grade) => DropdownMenuItem(
                                        value: grade,
                                        child: Text(grade),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  course['grade'] = value ?? 'A';
                                });
                              },
                              dropdownColor: Theme.of(context).cardColor,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color),
                            ),
                            const SizedBox(width: 12),
                            DropdownButton<int>(
                              value: course['credit'],
                              items: List.generate(
                                10,
                                (i) => DropdownMenuItem(
                                  value: i + 1,
                                  child: Row(
                                    children: [
                                      if (i == 0)
                                        const Icon(Icons.access_time, size: 18),
                                      const SizedBox(width: 5),
                                      Text('${i + 1}'),
                                    ],
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  course['credit'] = value ?? 1;
                                });
                              },
                              dropdownColor: Theme.of(context).cardColor,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeCourse(index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                      label: 'Add Module',
                      onPressed: _addCourse,
                      color: Theme.of(context).colorScheme.primaryContainer),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                      label: 'Calculate GPA',
                      onPressed: _calculateGPA,
                      color: Theme.of(context).colorScheme.primaryContainer),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'GPA: ${_gpa.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
