import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart'; // تأكدي من مسار الموديل عندكِ

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart'; // تأكدي من مسار الموديل عندكِ

class StatisticsScreen extends StatelessWidget {

  final List<Habit> habits;

  const StatisticsScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
   
    int totalHabits = habits.length;
    int completedHabits = habits.where((habit) => habit.isCompleted).length;
   
    double completionPercentage = totalHabits == 0 
        ? 0.0 
        : (completedHabits / totalHabits);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title:Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15), // خلفية خضراء خفيفة للأيقونة
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.emoji_events_rounded, // أيقونة إنجازات وتطور
        color: Colors.black,
        size: 22,
      ),
    ),
    const SizedBox(width: 10),
    const Text(
      'إحصائيات إنجازاتي',
      style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),
    ),
  ],
),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'مدى التزامك اليوم',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 80),

           Center(
              child: Stack(
              alignment: Alignment.center,
              children: [
    
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                  value: 1.0, 
                  strokeWidth: 14,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade200),
        ),
      ),
      
     
      SizedBox(
        width: 140,
        height: 140,
        child: CircularProgressIndicator(
          value: completionPercentage, // النسبة من 0.0 إلى 1.0 (مثلاً 0.5 للـ 50%)
          strokeWidth: 14,
          strokeCap: StrokeCap.round, // حواف مدورة وأنيقة جداً لخط التقدم
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
      
      
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(completionPercentage * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'نسبة الإنجاز',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  ),
),

            const SizedBox(height: 100),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('إجمالي العادات', '$totalHabits', Colors.green),
                _buildStatCard('العادات المنجزة', '$completedHabits', Colors.black),
                _buildStatCard('العادات المتبقية', '${totalHabits-completedHabits}', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
    
  }

  
  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
