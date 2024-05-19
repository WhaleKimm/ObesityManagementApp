// providers/diet_plan_provider.dart
import 'package:flutter/material.dart';
import 'package:obesity_management_app/models/diet_plan.dart'; // 다이어트 계획 모델 import
import 'package:shared_preferences/shared_preferences.dart'; // 로컬 저장소 import
import 'dart:convert'; // JSON 인코딩/디코딩 import

class DietPlanProvider with ChangeNotifier {
  List<DietPlan> _plans = []; // 다이어트 계획 목록

  List<DietPlan> get plans => _plans; // 다이어트 계획 목록 반환

  void addPlan(DietPlan plan) {
    _plans.add(plan); // 다이어트 계획 추가
    savePlansToLocal(); // 로컬 저장소에 저장
    notifyListeners(); // 리스너들에게 변경 사항 알림
  }

  void removePlan(String id) {
    _plans.removeWhere((plan) => plan.id == id); // 다이어트 계획 제거
    savePlansToLocal(); // 로컬 저장소에 저장
    notifyListeners(); // 리스너들에게 변경 사항 알림
  }

  Future<void> loadPlansFromLocal() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final String? plansString =
        prefs.getString('dietPlans'); // 로컬 저장소에서 다이어트 계획 가져오기
    if (plansString != null) {
      final List<dynamic> plansJson = json.decode(plansString); // JSON 디코딩
      _plans = plansJson
          .map((json) => DietPlan.fromJson(json))
          .toList(); // 다이어트 계획 목록으로 변환
      notifyListeners(); // 리스너들에게 변경 사항 알림
    }
  }

  Future<void> savePlansToLocal() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final String plansString =
        json.encode(_plans.map((plan) => plan.toJson()).toList()); // JSON 인코딩
    prefs.setString('dietPlans', plansString); // 로컬 저장소에 저장
  }
}
