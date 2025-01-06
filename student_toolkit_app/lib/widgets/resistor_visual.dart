import 'package:flutter/material.dart';

class ResistorVisual extends StatelessWidget {
  final int numberOfBands;
  final List<String> selectedColors;

  const ResistorVisual(
      {super.key, required this.numberOfBands, required this.selectedColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Custom resistor visual
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 158, 143, 143)
                  : Colors.brown[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(selectedColors.length, (index) {
                return Container(
                  width: 20,
                  color: getColor(selectedColors[index]),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),

          // Display color bands
          Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.center,
            children: selectedColors.map((color) {
              return Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: getColor(color),
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Maps color names to Flutter colors
  Color getColor(String colorName) {
    switch (colorName) {
      case 'Black':
        return Colors.black;
      case 'Brown':
        return Colors.brown;
      case 'Red':
        return const Color.fromARGB(255, 247, 18, 1);
      case 'Orange':
        return Colors.orange;
      case 'Yellow':
        return Colors.yellow;
      case 'Green':
        return const Color.fromARGB(255, 37, 153, 41);
      case 'Blue':
        return const Color.fromARGB(255, 0, 138, 252);
      case 'Violet':
        return const Color.fromARGB(255, 196, 7, 230);
      case 'Gray':
        return Colors.grey;
      case 'White':
        return Colors.white;
      case 'Gold':
        return const Color.fromARGB(255, 228, 172, 4);
      case 'Silver':
        return const Color.fromARGB(255, 205, 218, 224);
      default:
        return Colors.transparent;
    }
  }
}
