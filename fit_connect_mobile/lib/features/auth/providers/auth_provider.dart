import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fit_connect_mobile/services/supabase_service.dart';
import 'package:fit_connect_mobile/features/auth/models/user_model.dart' as app;

part 'auth_provider.g.dart';

/// 認証状態を管理するProvider
@riverpod
class AuthNotifier extends _$AuthNotifier {
  String? _lastUserId;

  @override
  Future<app.User?> build() async {
    // 現在のユーザーIDを記録（変更検知用）
    final currentUserId = SupabaseService.client.auth.currentUser?.id;
    _lastUserId = currentUserId;

    // 認証状態の変更を監視
    final subscription = SupabaseService.client.auth.onAuthStateChange.listen(
      (data) {
        // tokenRefreshedは除外
        if (data.event != AuthChangeEvent.signedIn &&
            data.event != AuthChangeEvent.signedOut) {
          return;
        }

        // ユーザーIDが実際に変わった場合のみ再評価
        final newUserId = data.session?.user.id;
        if (newUserId != _lastUserId) {
          print('[DEBUG] AuthNotifier: user changed from $_lastUserId to $newUserId, invalidating...');
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
    print('[DEBUG] _fetchCurrentUser: 開始');

    // currentUserを使用（セッション復元後は正しい値が返される）
    final user = SupabaseService.client.auth.currentUser;
    print('[DEBUG] _fetchCurrentUser: currentUser = $user, id = ${user?.id}');

    if (user == null) {
      print('[DEBUG] _fetchCurrentUser: user is null, returning null');
      return null;
    }

    try {
      print('[DEBUG] _fetchCurrentUser: fetching profile...');
      final response = await SupabaseService.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      print('[DEBUG] _fetchCurrentUser: response = $response');
      if (response == null) return null;
      return app.User.fromJson(response);
    } catch (e) {
      print('[DEBUG] _fetchCurrentUser: error = $e');
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
