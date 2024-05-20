// screens/diet_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obesity_management_app/providers/diet_plan_provider.dart'; // 다이어트 계획 프로바이더 import
import 'add_diet_plan_screen.dart'; // 다이어트 계획 추가 화면 import

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dietPlanProvider =
        Provider.of<DietPlanProvider>(context); // 다이어트 계획 프로바이더 사용
    return Scaffold(
      appBar: AppBar(
        title: const Text('다이어트 계획'), // 앱바 제목 설정
      ),
      body: ListView.builder(
        itemCount: dietPlanProvider.plans.length, // 다이어트 계획 수
        itemBuilder: (ctx, index) {
          final plan = dietPlanProvider.plans[index]; // 각 다이어트 계획 가져오기
          return ListTile(
            title: Text(plan.name), // 다이어트 계획 이름 표시
            subtitle: Text('설명: ${plan.description}\n'
                '키: ${plan.height ?? "N/A"} cm\n'
                '몸무게: ${plan.weight ?? "N/A"} kg\n'
                '나이: ${plan.age ?? "N/A"}\n'
                '특이사항: ${plan.specialNotes}\n'
                '목표 체중: ${plan.targetWeight ?? "N/A"} kg\n'
                '목표 기한: ${plan.targetDate ?? "N/A"}\n'
                '식단: ${plan.meals.join(', ')}\n'
                '운동: ${plan.exercises.join(', ')}'), // 세부사항 표시
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 다이어트 계획 추가 화면으로 이동
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddDietPlanScreen(),
          ));
        },
        child: const Icon(Icons.add), // 추가 버튼 아이콘
      ),
    );
  }
}
