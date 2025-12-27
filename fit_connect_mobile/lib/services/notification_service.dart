import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  static Future<void> initialize() async {
    // 権限リクエスト
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    // FCMトークン取得
    final token = await _messaging.getToken();
    print('FCM Token: $token');
    
    // フォアグラウンド通知
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('メッセージ受信: ${message.notification?.title}');
      // ローカル通知表示
    });
    
    // バックグラウンド通知
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

// バックグラウンドハンドラ（トップレベル関数）
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('バックグラウンドメッセージ: ${message.notification?.title}');
}