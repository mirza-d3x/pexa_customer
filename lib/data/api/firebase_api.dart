import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
Future<void>handleBackgroundMessages(RemoteMessage message)async{
print("Title !!!! : ${message.notification?.title}");
print("Body !!!! : ${message.notification?.body}");
print("Payload !!!! : ${message.data}");
}
class FireBaseApi{
  final _firebaseMessaging=FirebaseMessaging.instance;

  /*final _androidChannel=const AndroidNotificationChannel(
    'high_importance_chnnnel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );*/
  /*final _localNotification=FlutterLocalNotificationsPlugin();*/

  void handleMessage(RemoteMessage? message){
    if(message==null)return;
    message.notification!.title;
    message.notification!.body;
    Get.toNamed(RouteHelper.initial);
  }
  Future initPushNotification()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
    FirebaseMessaging.onMessage.listen((message){
      final notification=message.notification;
      if(notification==null)return;
    });
  }


  Future<void>initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken=await _firebaseMessaging.getToken();
    print("Token !!!! : $fCMToken");
    initPushNotification();
  }
}