double calculateGPA(List<Map<String, dynamic>> courses, double maxGPA) {
  double totalPoints = 0;
  double totalCredits = 0;

  for (var course in courses) {
    final double gradePoint = course['gradePoint'];
    final double creditHour = course['creditHour'];

    totalPoints += gradePoint * creditHour;
    totalCredits += creditHour;
  }

  return totalCredits == 0 ? 0.0 : totalPoints / totalCredits;
}
