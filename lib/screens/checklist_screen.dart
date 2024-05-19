// screens/checklist_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obesity_management_app/providers/checklist_provider.dart'; // 체크리스트 프로바이더 import
import 'add_checklist_screen.dart'; // 체크리스트 추가 화면 import

class ChecklistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checklistProvider =
        Provider.of<ChecklistProvider>(context); // 체크리스트 프로바이더 사용
    return Scaffold(
      appBar: AppBar(
        title: Text('일일 체크 리스트'), // 앱바 제목 설정
      ),
      body: ListView.builder(
        itemCount: checklistProvider.checklists.length, // 체크리스트 수
        itemBuilder: (ctx, index) {
          final checklist = checklistProvider.checklists[index]; // 각 체크리스트 가져오기
          return ListTile(
            title: Text(checklist.date), // 날짜 표시
            subtitle: Text('아침: ${checklist.breakfast.join(', ')}\n'
                '점심: ${checklist.lunch.join(', ')}\n'
                '저녁: ${checklist.dinner.join(', ')}\n'
                '운동 시간: ${checklist.exerciseTime}분\n'
                '운동: ${checklist.exercises.join(', ')}\n'
                '물 섭취량: ${checklist.waterIntake}L\n'
                '물 섭취 여부: ${checklist.isWaterIntakeToggle ? "Yes" : "No"}'), // 세부사항 표시
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 체크리스트 추가 화면으로 이동
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddChecklistScreen(),
          ));
        },
        child: Icon(Icons.add), // 추가 버튼 아이콘
      ),
    );
  }
}
