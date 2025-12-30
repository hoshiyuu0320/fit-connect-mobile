import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fit_connect_mobile/services/supabase_service.dart';
import 'package:fit_connect_mobile/features/auth/models/client_model.dart';
import 'package:fit_connect_mobile/features/auth/providers/auth_provider.dart';

part 'current_user_provider.g.dart';

/// 現在のクライアント情報を取得するProvider
@riverpod
Future<Client?> currentClient(CurrentClientRef ref) async {
  // 認証状態を監視
  final user = ref.watch(authNotifierProvider).valueOrNull;
  if (user == null) return null;

  try {
    final response = await SupabaseService.client
        .from('clients')
        .select()
        .eq('client_id', user.id)
        .maybeSingle();

    if (response == null) return null;
    return Client.fromJson(response);
  } catch (e) {
    return null;
  }
}

/// 現在のクライアントIDを取得するProvider
@riverpod
String? currentClientId(CurrentClientIdRef ref) {
  final client = ref.watch(currentClientProvider).valueOrNull;
  return client?.clientId;
}

/// 現在のトレーナーIDを取得するProvider
@riverpod
String? currentTrainerId(CurrentTrainerIdRef ref) {
  final client = ref.watch(currentClientProvider).valueOrNull;
  return client?.trainerId;
}
