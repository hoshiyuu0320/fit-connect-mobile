import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fit_connect_mobile/core/theme/app_theme.dart';
import 'package:fit_connect_mobile/core/theme/app_colors.dart';
import 'package:fit_connect_mobile/features/home/presentation/screens/main_screen.dart';
import 'package:fit_connect_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:fit_connect_mobile/features/auth/providers/current_user_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIT-CONNECT',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _LoadingScreen();
          }
          final session = snapshot.data?.session;
          if (session != null) {
            // ログイン済み: データ取得を待つローディング画面を表示
            return const _AuthLoadingScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

/// 初期ローディング画面
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary600,
        ),
      ),
    );
  }
}

/// 認証後のデータ取得を待つローディング画面
class _AuthLoadingScreen extends ConsumerWidget {
  const _AuthLoadingScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(currentClientProvider);

    return clientAsync.when(
      data: (client) {
        // データ取得完了 → MainScreenへ
        return const MainScreen();
      },
      loading: () {
        // ローディング中
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primary600,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: AppColors.slate500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) {
        // エラー時もMainScreenへ（エラーハンドリングはMainScreen側で行う）
        return const MainScreen();
      },
    );
  }
}