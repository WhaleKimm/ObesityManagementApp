// screens/add_diet_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obesity_management_app/providers/diet_plan_provider.dart'; // 다이어트 계획 프로바이더 import
import 'package:obesity_management_app/models/diet_plan.dart'; // 다이어트 계획 모델 import
import 'package:uuid/uuid.dart'; // UUID 생성 라이브러리 import

class AddDietPlanScreen extends StatefulWidget {
  @override
  _AddDietPlanScreenState createState() => _AddDietPlanScreenState();
}

class _AddDietPlanScreenState extends State<AddDietPlanScreen> {
  final _formKey = GlobalKey<FormState>(); // 폼 키 생성
  String _name = ''; // 다이어트 계획 이름
  String _description = ''; // 다이어트 계획 설명
  double? _height; // 키
  double? _weight; // 몸무게
  int? _age; // 나이
  String _specialNotes = ''; // 특이사항
  double? _targetWeight; // 목표 체중
  DateTime? _targetDate; // 목표 기한
  List<String> _meals = []; // 식사 목록
  List<String> _exercises = []; // 운동 목록

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 폼 검증
      _formKey.currentState!.save(); // 폼 저장
      final newPlan = DietPlan(
        id: Uuid().v4(), // UUID 생성
        name: _name, // 이름 설정
        description: _description, // 설명 설정
        height: _height, // 키 설정
        weight: _weight, // 몸무게 설정
        age: _age, // 나이 설정
        specialNotes: _specialNotes, // 특이사항 설정
        targetWeight: _targetWeight, // 목표 체중 설정
        targetDate: _targetDate?.toString(), // 목표 기한 설정
        meals: _meals, // 식사 설정
        exercises: _exercises, // 운동 설정
      );
      Provider.of<DietPlanProvider>(context, listen: false)
          .addPlan(newPlan); // 다이어트 계획 추가
      Navigator.of(context).pop(); // 이전 화면으로 이동
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diet Plan'), // 앱바 제목 설정
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // 패딩 설정
        child: Form(
          key: _formKey, // 폼 키 설정
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'), // 이름 입력 필드
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name'; // 검증 메시지
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!; // 이름 저장
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Description'), // 설명 입력 필드
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description'; // 검증 메시지
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!; // 설명 저장
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Height (cm)'), // 키 입력 필드
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter height'; // 검증 메시지
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _height =
                        value!.isEmpty ? null : double.parse(value); // 키 저장
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Weight (kg)'), // 몸무게 입력 필드
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter weight'; // 검증 메시지
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _weight =
                        value!.isEmpty ? null : double.parse(value); // 몸무게 저장
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'), // 나이 입력 필드
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter age'; // 검증 메시지
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = value!.isEmpty ? null : int.parse(value); // 나이 저장
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Special Notes'), // 특이사항 입력 필드
                  onSaved: (value) {
                    _specialNotes = value!; // 특이사항 저장
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Target Weight (kg)'), // 목표 체중 입력 필드
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _targetWeight =
                        value!.isEmpty ? null : double.parse(value); // 목표 체중 저장
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Target Date', // 목표 기한 입력 필드
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text: _targetDate == null
                              ? ''
                              : _targetDate!.toLocal().toString().split(' ')[0],
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitForm, // 폼 제출
                  child: Text('Add Plan'), // 버튼 텍스트
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
