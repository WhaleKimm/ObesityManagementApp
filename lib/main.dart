// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/diet_plan_provider.dart'; // 다이어트 계획 프로바이더 import
import 'providers/checklist_provider.dart'; // 체크리스트 프로바이더 import
import 'screens/home_screen.dart'; // 홈 화면 import

void main() async {
  // main 함수는 앱의 진입점입니다
  WidgetsFlutterBinding.ensureInitialized(); // 위젯 바인딩을 초기화합니다
  final dietPlanProvider = DietPlanProvider(); // 다이어트 계획 프로바이더 인스턴스를 생성합니다
  final checklistProvider = ChecklistProvider(); // 체크리스트 프로바이더 인스턴스를 생성합니다
  await dietPlanProvider.loadPlansFromLocal(); // 로컬 저장소에서 다이어트 계획을 로드합니다
  await checklistProvider.loadChecklistsFromLocal(); // 로컬 저장소에서 체크리스트를 로드합니다

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => dietPlanProvider), // 다이어트 계획 프로바이더를 제공
        ChangeNotifierProvider(
            create: (_) => checklistProvider), // 체크리스트 프로바이더를 제공
      ],
      child: MyApp(), // MyApp 위젯을 실행
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 앱의 기본 디자인과 라우팅을 설정합니다
    return MaterialApp(
      title: 'Calorie Oh', // 앱의 제목 설정
      theme: ThemeData(
        primarySwatch: Colors.blue, // 기본 테마 색상 설정
      ),
      home: HomeScreen(), // 첫 화면으로 HomeScreen 설정
    );
  }
}
