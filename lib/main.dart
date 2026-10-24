import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/dashboared_screen.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null); // تحميل بيانات اللغة العربية قبل تشغيل التطبيق
  runApp( HabitTrackerApp());
}
class HabitTrackerApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "متتبع العادات",
      builder: (context, child) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: child!,
    );
  },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: 
       const Color.fromARGB(255, 14, 188, 63),brightness: Brightness.light ),
     fontFamily: GoogleFonts.tajawal().fontFamily,
),
home: DashboaredScreen(),
     );
  }
}
