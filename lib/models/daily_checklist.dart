// models/daily_checklist.dart

class DailyChecklist {
  final String date; // 날짜
  final List<String> meals; // 식사 목록
  final List<String> exercises; // 운동 목록
  final int waterIntake; // 물 섭취량
  final List<String> breakfast; // 아침 식사
  final List<String> lunch; // 점심 식사
  final List<String> dinner; // 저녁 식사
  final int exerciseTime; // 운동 시간
  final bool isWaterIntakeToggle; // 물 섭취 토글

  DailyChecklist({
    required this.date,
    required this.meals,
    required this.exercises,
    required this.waterIntake,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.exerciseTime,
    required this.isWaterIntakeToggle,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'meals': meals,
      'exercises': exercises,
      'waterIntake': waterIntake,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'exerciseTime': exerciseTime,
      'isWaterIntakeToggle': isWaterIntakeToggle,
    };
  }

  factory DailyChecklist.fromJson(Map<String, dynamic> json) {
    final date = json['date'];
    final meals = (json['meals'] ?? []).cast<String>(); // Cast to List<String>
    final exercises =
        (json['exercises'] ?? []).cast<String>(); // Cast to List<String>
    final waterIntake = json['waterIntake'] ?? 0;
    final breakfast =
        (json['breakfast'] ?? []).cast<String>(); // Cast to List<String>
    final lunch = (json['lunch'] ?? []).cast<String>(); // Cast to List<String>
    final dinner =
        (json['dinner'] ?? []).cast<String>(); // Cast to List<String>
    final exerciseTime = json['exerciseTime'] ?? 0;
    final isWaterIntakeToggle = json['isWaterIntakeToggle'] ?? false;

    return DailyChecklist(
      date: date,
      meals: meals,
      exercises: exercises,
      waterIntake: waterIntake,
      breakfast: breakfast,
      lunch: lunch,
      dinner: dinner,
      exerciseTime: exerciseTime,
      isWaterIntakeToggle: isWaterIntakeToggle,
    );
  }
}
