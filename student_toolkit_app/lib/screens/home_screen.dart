import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gpa_calculator_screen.dart';
import 'resistor_calculator_screen.dart';
import 'contributors_screen.dart';
import '../main.dart';
import '../services/analytics_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AnalyticsService _analytics = AnalyticsService();

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(
      screenName: AnalyticsService.homeScreen,
      screenClass: 'HomeScreen',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 34,
            ),
            const SizedBox(width: 14),
            const Text("Student Toolkit"),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Select Theme'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.light_mode),
                          title: const Text('Light Mode'),
                          onTap: () {
                            MyApp.of(context)?.setTheme(ThemeMode.light);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text('Dark Mode'),
                          onTap: () {
                            MyApp.of(context)?.setTheme(ThemeMode.dark);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('System Default'),
                          onTap: () {
                            MyApp.of(context)?.setTheme(ThemeMode.system);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.count(
                  crossAxisCount: constraints.maxWidth < 600 ? 1 : 2,
                  padding: const EdgeInsets.all(16.0),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: [
                    _buildFeatureCard(
                      context,
                      title: "Resistor Colour Decoder",
                      description:
                          "Decode resistor color codes and calculate resistance values easily.",
                      icon: SvgPicture.asset(
                        'assets/svgs/resistor4.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primaryFixed,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ResistorCalculatorScreen(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      title: "GPA Checker",
                      description:
                          "Calculate your GPA quickly using the 4.0 or 5.0 grading scale.",
                      icon: SvgPicture.asset(
                        'assets/svgs/gpa2.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primaryFixed,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GPACalculatorScreen(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureCard(
                      context,
                      title: "Contributors",
                      description:
                          "Learn more about the developers of this app.",
                      icon: SvgPicture.asset(
                        'assets/svgs/team2.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primaryFixed,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContributorsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.scrim,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: icon,
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onError,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
