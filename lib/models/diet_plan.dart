// models/diet_plan.dart
class DietPlan {
  final String id; // 식별자
  final String name; // 이름
  final String description; // 설명
  final double? height; // 키
  final double? weight; // 몸무게
  final int? age; // 나이
  final String? specialNotes; // 특이사항
  final double? targetWeight; // 목표 체중
  final String? targetDate; // 목표 기한
  final List<String> meals; // 식사 목록
  final List<String> exercises; // 운동 목록

  DietPlan({
    required this.id,
    required this.name,
    required this.description,
    this.height,
    this.weight,
    this.age,
    required this.specialNotes,
    this.targetWeight,
    this.targetDate,
    required this.meals,
    required this.exercises,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'height': height,
      'weight': weight,
      'age': age,
      'specialNotes': specialNotes,
      'targetWeight': targetWeight,
      'targetDate': targetDate,
      'meals': meals,
      'exercises': exercises,
    };
  }

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      specialNotes: json['specialNotes'],
      targetWeight: json['targetWeight'],
      targetDate: json['targetDate'],
      meals: List<String>.from(json['meals']),
      exercises: List<String>.from(json['exercises']),
    );
  }
}
