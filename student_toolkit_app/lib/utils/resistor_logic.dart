String calculateResistanceValue(List<String> colors, int bands) {
  final Map<String, int> colorCodes = {
    'Black': 0,
    'Brown': 1,
    'Red': 2,
    'Orange': 3,
    'Yellow': 4,
    'Green': 5,
    'Blue': 6,
    'Violet': 7,
    'Gray': 8,
    'White': 9,
  };

  final Map<String, double> multipliers = {
    'Black': 1,
    'Brown': 10,
    'Red': 100,
    'Orange': 1e3,
    'Yellow': 1e4,
    'Green': 1e5,
    'Blue': 1e6,
    'Violet': 1e7,
    'Gray': 1e8,
    'White': 1e9,
    'Gold': 0.1,
    'Silver': 0.01,
  };

  final Map<String, double> tolerances = {
    'Brown': 1.0,
    'Red': 2.0,
    'Green': 0.5,
    'Blue': 0.25,
    'Violet': 0.1,
    'Gray': 0.05,
    'Gold': 5.0,
    'Silver': 10.0,
  };

  String formatResistance(double resistance) {
    if (resistance >= 1e6) {
      return '${(resistance / 1e6).toStringAsFixed(2)} MΩ';
    } else if (resistance >= 1e3) {
      return '${(resistance / 1e3).toStringAsFixed(2)} kΩ';
    } else {
      return '${resistance.toStringAsFixed(2)} Ω';
    }
  }

  if (bands == 3) {
    final resistance = (colorCodes[colors[0]]! * 10 + colorCodes[colors[1]]!) *
        multipliers[colors[2]]!;
    return formatResistance(resistance);
  } else if (bands == 4) {
    final resistance = (colorCodes[colors[0]]! * 10 + colorCodes[colors[1]]!) *
        multipliers[colors[2]]!;
    final tolerance = tolerances[colors[3]]!;
    return '${formatResistance(resistance)} ± $tolerance%';
  }

  return 'Invalid Band Configuration';
}
