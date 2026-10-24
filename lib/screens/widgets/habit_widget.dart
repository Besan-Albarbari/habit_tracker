import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';

class HabitTile extends StatelessWidget {

  final Habit habit;
  final VoidCallback onTap;
   final VoidCallback onLongPress;
   final VoidCallback onEditPress;
  const HabitTile({
    super.key,
    required this.habit,
    required this.onTap,
    required this.onLongPress,
    required this.onEditPress,
  });

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onLongPress: onLongPress, // ربط الحركة بالمتغير الممرر من الشاشة الرئيسية
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: habit.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: habit.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: habit.isCompleted ? Colors.grey : Colors.black87,
                  ),
                ),
              ],
            ),
                 
      Row(children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: habit.isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: habit.isCompleted ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: habit.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey, size: 20),
          onPressed: onEditPress, 
          // سنمرر هذه الدالة من الشاشة الرئيسية
        ),
        const SizedBox(width: 10), // مسافة صغيرة بين القلم وزر الصح
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 26,
            height: 26,
          
          ),
        ),
        ],
      
        )
          ],
        ),
      ),
   
    
    );
  }
}
