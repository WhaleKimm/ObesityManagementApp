import 'package:flutter/material.dart';
import 'package:obesity_management_app/models/daily_checklist.dart'; // 체크리스트 모델 import
import 'package:shared_preferences/shared_preferences.dart'; // 로컬 저장소 import
import 'dart:convert'; // JSON 인코딩/디코딩 import

class ChecklistProvider with ChangeNotifier {
  List<DailyChecklist> _checklists = []; // 체크리스트 목록

  List<DailyChecklist> get checklists => _checklists; // 체크리스트 목록 반환

  void addChecklist(DailyChecklist checklist) {
    _checklists.add(checklist); // 체크리스트 추가
    saveChecklistsToLocal(); // 로컬 저장소에 저장
    notifyListeners(); // 리스너들에게 변경 사항 알림
  }

  void updateChecklist(DailyChecklist checklist) {
    int index =
        _checklists.indexWhere((c) => c.date == checklist.date); // 체크리스트 인덱스 찾기
    if (index >= 0) {
      _checklists[index] = checklist; // 체크리스트 업데이트
      saveChecklistsToLocal(); // 로컬 저장소에 저장
      notifyListeners(); // 리스너들에게 변경 사항 알림
    }
  }

  Future<void> loadChecklistsFromLocal() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final String? checklistsString =
        prefs.getString('dailyChecklists'); // 로컬 저장소에서 체크리스트 가져오기
    if (checklistsString != null) {
      final List<dynamic> checklistsJson =
          json.decode(checklistsString); // JSON 디코딩
      _checklists = checklistsJson
          .map((json) => DailyChecklist.fromJson(json))
          .toList(); // 체크리스트 목록으로 변환
      notifyListeners(); // 리스너들에게 변경 사항 알림
    }
  }

  Future<void> saveChecklistsToLocal() async {
    final prefs =
        await SharedPreferences.getInstance(); // SharedPreferences 인스턴스 가져오기
    final String checklistsString = json.encode(_checklists
        .map((checklist) => checklist.toJson())
        .toList()); // JSON 인코딩
    prefs.setString('dailyChecklists', checklistsString); // 로컬 저장소에 저장
  }
}
