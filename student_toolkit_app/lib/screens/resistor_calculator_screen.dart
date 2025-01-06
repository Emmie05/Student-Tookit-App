import 'package:flutter/material.dart';
import '../utils/resistor_logic.dart';
import '../widgets/resistor_visual.dart';
import '../widgets/custom_button.dart';
import '../services/analytics_service.dart';

class ResistorCalculatorScreen extends StatefulWidget {
  const ResistorCalculatorScreen({super.key});

  @override
  _ResistorCalculatorScreenState createState() =>
      _ResistorCalculatorScreenState();
}

class _ResistorCalculatorScreenState extends State<ResistorCalculatorScreen> {
  final AnalyticsService _analytics = AnalyticsService();
  int numberOfBands = 3;
  // Initialize with 3 colors instead of 4
  List<String> selectedColors = ['Brown', 'Black', 'Red'];
  String resistanceValue = '';

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(
      screenName: AnalyticsService.resistorCalculatorScreen,
      screenClass: 'ResistorCalculatorScreen',
    );
  }

  void calculateResistance() {
    setState(() {
      resistanceValue = calculateResistanceValue(selectedColors, numberOfBands);
    });

    _analytics.logResistanceCalculation(
      numberOfBands: numberOfBands,
      colors: selectedColors,
      result: resistanceValue,
    );
  }

  void _onBandColorChanged(int bandIndex, String newColor) {
    setState(() {
      selectedColors[bandIndex] = newColor;
    });
    _analytics.logResistorBandChange(
      bandNumber: bandIndex + 1,
      newColor: newColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resistor Decoder'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTextStyle(
          style: theme.textTheme.bodyLarge!,
          child: Column(
            children: [
              // Dropdown to choose number of bands
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Number of Bands:',
                    style: theme.textTheme.titleMedium,
                  ),
                  DropdownButton<int>(
                    value: numberOfBands,
                    dropdownColor: theme.cardColor,
                    style: TextStyle(color: theme.textTheme.bodyLarge!.color),
                    items: [3, 4].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value Bands',
                          style: TextStyle(
                              color: theme.textTheme.bodyLarge!.color),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        numberOfBands = value!;
                        // Reset colors for selected bands
                        if (numberOfBands == 3) {
                          selectedColors = ['Black', 'Brown', 'Red'];
                        } else {
                          selectedColors = ['Black', 'Brown', 'Red', 'Gold'];
                        }
                        resistanceValue = ''; // Clear the resistance value
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Resistor visual representation
              ResistorVisual(
                numberOfBands: numberOfBands,
                selectedColors: selectedColors,
              ),
              const SizedBox(height: 16),

              // Dropdowns for band color selection
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfBands,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Band ${index + 1}:',
                        style: theme.textTheme.titleMedium,
                      ),
                      DropdownButton<String>(
                        value: selectedColors[index],
                        dropdownColor: theme.cardColor,
                        style:
                            TextStyle(color: theme.textTheme.bodyLarge!.color),
                        items:
                            getColorOptions(index, numberOfBands).map((color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(
                              color,
                              style: TextStyle(
                                  color: theme.textTheme.bodyLarge!.color),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _onBandColorChanged(index, value!);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Display calculated resistance
              if (resistanceValue.isNotEmpty)
                Text(
                  'Resistance: $resistanceValue',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 16),
              CustomButton(
                label: 'Calculate',
                color: Theme.of(context).colorScheme.primaryContainer,
                onPressed: calculateResistance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated helper function with complete tolerance color options
List<String> getColorOptions(int index, int bands) {
  final baseColors = [
    'Black',
    'Brown',
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Blue',
    'Violet',
    'Gray',
    'White'
  ];

  final toleranceColors = [
    'Brown', // ±1%
    'Red', // ±2%
    'Green', // ±0.5%
    'Blue', // ±0.25%
    'Violet', // ±0.1%
    'Gray', // ±0.05%
    'Gold', // ±5%
    'Silver' // ±10%
  ];

  if (bands == 3 && index == 2) {
    return [...baseColors, 'Gold', 'Silver']; // Multiplier band
  } else if (bands == 4 && index == 3) {
    return toleranceColors; // Tolerance band
  }
  return baseColors; // Standard digit bands
}
