import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/screens/widgets/habit_widget.dart';
import 'package:habit_tracker/screens/widgets/statistics_screen.dart';
import 'widgets/date_header.dart';
import 'widgets/add_habit_buttom.dart';
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker/services/notification_service.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboaredScreen(),
  ));
}

class DashboaredScreen extends StatefulWidget {
  @override
  _DashboaredScreenState createState() => _DashboaredScreenState();
}

class _DashboaredScreenState extends State<DashboaredScreen> {
  final List<Habit> _myHabit = [];
  @override
  void initState(){
    super.initState();
    _loadHabits();
      NotificationService().initNotification();
  }
 Future<void> _saveHabitsToStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String encodedData = json.encode(
    _myHabit.map((habits) => habits.toMap()).toList(),
  );
  
  await prefs.setString('user_habits', encodedData);
}
Future<void> _loadHabits() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? habitsString = prefs.getString('user_habits');
  
  if (habitsString != null) {
 
    final List<dynamic> decodedData = json.decode(habitsString);
    
    setState(() {
      _myHabit.clear();
      _myHabit.addAll(
        decodedData.map((item) => Habit.fromMap(item)).toList(),
      );
    });
  }
}

 
  void _showAddHabitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return AddHabitButtom(
          onHabitAdd: (habitTitle, chosenColor) {
            setState(() {
              _myHabit.add(
                Habit(
                  name: habitTitle,
                  color: chosenColor,
                ),
              );
              _saveHabitsToStorage();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'متتبع العادات اليومية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
             MaterialPageRoute(builder: (context) =>
               StatisticsScreen(habits: _myHabit)
             ));
          },
           icon: Icon(Icons.bar_chart_rounded,size: 35,))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          _showAddHabitBottomSheet(context);
        },
        child: const Icon(Icons.add, size: 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateHeader(),
            const SizedBox(height: 20),
            Text(
              'عاداتي اليومية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _myHabit.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_turned_in_rounded, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'لا توجد عادات اليوم.\nاضغط على زر (+) بالأسفل لإضافة عادتك الأولى! ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _myHabit.length,
                      itemBuilder: (context, index) {
                        final habit = _myHabit[index];

                        return HabitTile(
                          habit: habit,
                          onTap: () {
                            setState(() {
                              habit.isCompleted = !habit.isCompleted;
                            });
                            _saveHabitsToStorage();
                            if(habit.isCompleted){
                              NotificationService().showNotification(
                                    title: "إنجاز رائع! ",
                                    body: "لقد قمت بإنجاز عادة '${habit.name}' بنجاح، استمر في التقدم!",
                                    );
                              
                            }
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  title: const Row(
                                    children: [
                                      Icon(Icons.delete_forever_rounded, color: Colors.red, size: 28),
                                      SizedBox(width: 10),
                                      Text("تأكيد الحذف", style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("إلغاء", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _myHabit.removeAt(index);
                                        });
                                        _saveHabitsToStorage();
                                        Navigator.pop(context);
                                      },
                                      child: Text("تأكيد", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          
                          onEditPress: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              builder: (context) {
                                return AddHabitButtom(
                                  editname: habit.name,
                                  editColor: habit.color, 
                                  onHabitAdd: (updatedTitle, updatedColor) {
                                    setState(() {
                                      _myHabit[index] = Habit(
                                        name: updatedTitle,
                                        color: updatedColor,
                                        isCompleted: habit.isCompleted,
                                      );
                                      _saveHabitsToStorage();
                                    });
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
