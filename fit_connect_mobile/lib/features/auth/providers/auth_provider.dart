import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fit_connect_mobile/services/supabase_service.dart';
import 'package:fit_connect_mobile/features/auth/models/user_model.dart' as app;

part 'auth_provider.g.dart';

/// 認証状態を管理するProvider
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<app.User?> build() async {
    // 認証状態の変更を監視
    final subscription = SupabaseService.client.auth.onAuthStateChange.listen(
      (data) {
        if (data.event == AuthChangeEvent.signedIn ||
            data.event == AuthChangeEvent.signedOut ||
            data.event == AuthChangeEvent.tokenRefreshed) {
          ref.invalidateSelf();
        }
      },
    );

    // Provider破棄時にサブスクリプションをキャンセル
    ref.onDispose(() {
      subscription.cancel();
    });

    return _fetchCurrentUser();
  }

  /// 現在のユーザー情報を取得
  Future<app.User?> _fetchCurrentUser() async {
    final session = SupabaseService.client.auth.currentSession;
    if (session == null) return null;

    try {
      final response = await SupabaseService.client
          .from('profiles')
          .select()
          .eq('id', session.user.id)
          .maybeSingle();

      if (response == null) return null;
      return app.User.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// メールアドレスでマジックリンク認証
  Future<void> signInWithEmail(String email) async {
    await SupabaseService.client.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'fitconnectmobile://login-callback',
    );
  }

  /// サインアウト
  Future<void> signOut() async {
    await SupabaseService.client.auth.signOut();
  }

  /// プロフィールを作成（初回登録時）
  Future<void> createProfile({
    required String name,
    String? email,
  }) async {
    final userId = SupabaseService.client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await SupabaseService.client.from('profiles').insert({
      'id': userId,
      'name': name,
      'email': email,
      'role': 'client',
    });

    ref.invalidateSelf();
  }
}

/// 現在のセッションを取得するProvider
@riverpod
Session? currentSession(CurrentSessionRef ref) {
  return SupabaseService.client.auth.currentSession;
}

/// 認証済みかどうかを返すProvider
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final session = ref.watch(currentSessionProvider);
  return session != null;
}
