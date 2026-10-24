import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/tzdata.dart' as tz;
class NotificationService {
  // 1. إنشاء كائن وحيد من حزمة الإشعارات
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 2. دالة التهيئة وطلب الإذن من المستخدم فور فتح التطبيق
  Future<void> initNotification() async {
    // إعدادات الأندرويد (تحديد أيقونة الإشعار الصغير التي تظهر بالأعلى)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // دمج الإعدادات معاً
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // تشغيل نظام الاستشعار للإشعار
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 3. دالة إرسال إشعار فوري (للتجربة والامتحان) ⚡
  Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'habit_channel_id', // معرف القناة
      'Habit Alerts',     // اسم القناة المعروض في إعدادات الهاتف
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // إطلاق الإشعار فوراً للمستخدم!
    await flutterLocalNotificationsPlugin.show(
      0, // رقم تعريف الإشعار الفريد
      title,
      body,
      platformChannelSpecifics,
    );
  }
}