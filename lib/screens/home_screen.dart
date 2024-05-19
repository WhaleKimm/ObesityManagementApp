// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:obesity_management_app/screens/diet_plan_screen.dart';
import 'package:obesity_management_app/screens/checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 홈 화면을 구성합니다
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Oh'), // 앱바 제목 설정
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // 다이어트 계획 화면으로 이동
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DietPlanScreen(),
                ));
              },
              child: Text('개인 맞춤형 다이어트 계획'), // 버튼 텍스트 설정
            ),
            ElevatedButton(
              onPressed: () {
                // 체크리스트 화면으로 이동
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChecklistScreen(),
                ));
              },
              child: Text('일일 체크 리스트'), // 버튼 텍스트 설정
            ),
          ],
        ),
      ),
    );
  }
}
