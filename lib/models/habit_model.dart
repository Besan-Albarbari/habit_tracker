import 'package:flutter/material.dart';

class Habit {
  
  Color color;
  String name;    
  bool isCompleted; 

  Habit({
    
   required this.color,
    required this.name,
    this.isCompleted = false, 
  });
  // دالة تحويل العادة من map الى jason String عشان ما بتتعامل دالة الحفظ مع الخريطة
  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "color":color.value,
      "isCompleted":isCompleted
    };
  }
  // 🟢 2. تحويل الـ Map المأخوذة من JSON لـ HabitModel
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      name: map['name'],
      color: Color(map['color']),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}