// screens/add_checklist_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // 이미지 선택 패키지 import
import 'package:obesity_management_app/providers/checklist_provider.dart'; // 체크리스트 프로바이더 import
import 'package:obesity_management_app/models/daily_checklist.dart'; // 체크리스트 모델 import

class AddChecklistScreen extends StatefulWidget {
  @override
  _AddChecklistScreenState createState() => _AddChecklistScreenState();
}

class _AddChecklistScreenState extends State<AddChecklistScreen> {
  final _formKey = GlobalKey<FormState>(); // 폼 키 생성
  String _date = ''; // 날짜
  List<String> _meals = []; // 식사 목록
  List<String> _exercises = []; // 운동 목록
  int _waterIntake = 0; // 물 섭취량

  // 추가 필드
  String? _breakfast; // 아침 식사 이미지 경로
  String? _lunch; // 점심 식사 이미지 경로
  String? _dinner; // 저녁 식사 이미지 경로
  int _exerciseHours = 0; // 운동 시간 (시간)
  int _exerciseMinutes = 0; // 운동 시간 (분)
  bool _isWaterIntakeToggle = false; // 물 섭취 토글

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 폼 검증
      _formKey.currentState!.save(); // 폼 저장
      final newChecklist = DailyChecklist(
        date: _date, // 날짜 설정
        meals: _meals, // 식사 설정
        exercises: _exercises, // 운동 설정
        waterIntake: _waterIntake, // 물 섭취량 설정
        breakfast: _breakfast != null ? [_breakfast!] : [], // 아침 식사 설정
        lunch: _lunch != null ? [_lunch!] : [], // 점심 식사 설정
        dinner: _dinner != null ? [_dinner!] : [], // 저녁 식사 설정
        exerciseTime:
            _exerciseHours * 60 + _exerciseMinutes, // 운동 시간 설정 (분 단위로 변환)
        isWaterIntakeToggle: _isWaterIntakeToggle, // 물 섭취 토글 설정
      );
      Provider.of<ChecklistProvider>(context, listen: false)
          .addChecklist(newChecklist); // 체크리스트 추가
      Navigator.of(context).pop(); // 이전 화면으로 이동
    } else {
      print('Form is not valid');
    }
  }

  Future<void> _pickImage(String mealType) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        switch (mealType) {
          case 'breakfast':
            _breakfast = pickedFile.path;
            break;
          case 'lunch':
            _lunch = pickedFile.path;
            break;
          case 'dinner':
            _dinner = pickedFile.path;
            break;
        }
      });
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
        _date = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daily Checklist'), // 앱바 제목 설정
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // 패딩 설정
        child: Form(
          key: _formKey, // 폼 키 설정
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ), // 날짜 입력 필드
                readOnly: true,
                controller: TextEditingController(text: _date),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date'; // 검증 메시지
                  }
                  return null;
                },
              ),
              // 식사 입력 필드
              Row(
                children: [
                  Text('Breakfast: '),
                  _breakfast != null
                      ? Image.file(File(_breakfast!), width: 50, height: 50)
                      : Container(),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () => _pickImage('breakfast'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Lunch: '),
                  _lunch != null
                      ? Image.file(File(_lunch!), width: 50, height: 50)
                      : Container(),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () => _pickImage('lunch'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Dinner: '),
                  _dinner != null
                      ? Image.file(File(_dinner!), width: 50, height: 50)
                      : Container(),
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () => _pickImage('dinner'),
                  ),
                ],
              ),
              // 운동 시간 입력 필드
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Exercise Hours'), // 운동 시간 (시간) 입력 필드
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter hours'; // 검증 메시지
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _exerciseHours = int.parse(value!); // 운동 시간 (시간) 저장
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Exercise Minutes'), // 운동 시간 (분) 입력 필드
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter minutes'; // 검증 메시지
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _exerciseMinutes = int.parse(value!); // 운동 시간 (분) 저장
                        });
                      },
                    ),
                  ),
                ],
              ),
              // 물 섭취량 입력 필드
              ToggleButtons(
                children: List<Widget>.generate(
                  11,
                  (index) => Text('${index}L'),
                ),
                isSelected: List<bool>.generate(
                  11,
                  (index) => index == _waterIntake,
                ),
                onPressed: (index) {
                  setState(() {
                    _waterIntake = index; // 물 섭취량 저장
                    _isWaterIntakeToggle = index > 0;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _submitForm, // 폼 제출
                child: Text('Add Checklist'), // 버튼 텍스트
              ),
            ],
          ),
        ),
      ),
    );
  }
}
