import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/supabase_service.dart';
import 'services/notification_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('🚀 アプリ起動開始');
  
  // 環境変数読み込み
  await dotenv.load(fileName: "assets/.env");
  print('✅ 環境変数読み込み完了');
  
  // Supabase初期化
  await SupabaseService.initialize();
  print('✅ Supabase初期化完了');
  print('📡 Supabase URL: ${dotenv.env['SUPABASE_URL']}'); 
  
  // プッシュ通知初期化（後で実装）
  // await NotificationService.initialize();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}