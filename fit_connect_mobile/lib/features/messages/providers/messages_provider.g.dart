// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageRepositoryHash() => r'983823314282193fabadb5261bdd8e35a7ff7255';

/// MessageRepositoryのProvider
///
/// Copied from [messageRepository].
@ProviderFor(messageRepository)
final messageRepositoryProvider =
    AutoDisposeProvider<MessageRepository>.internal(
  messageRepository,
  name: r'messageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessageRepositoryRef = AutoDisposeProviderRef<MessageRepository>;
String _$messagesStreamHash() => r'3ba88b0db331e3047dadd319ccc9ea5cab8d2d59';

/// メッセージリストを取得するProvider（リアルタイム）
///
/// Copied from [messagesStream].
@ProviderFor(messagesStream)
final messagesStreamProvider =
    AutoDisposeStreamProvider<List<Message>>.internal(
  messagesStream,
  name: r'messagesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messagesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessagesStreamRef = AutoDisposeStreamProviderRef<List<Message>>;
String _$unreadMessageCountHash() =>
    r'c6e76b24b7f5f08d7fe20491602883dbca42aa35';

/// 未読メッセージ数を取得するProvider
///
/// Copied from [unreadMessageCount].
@ProviderFor(unreadMessageCount)
final unreadMessageCountProvider = AutoDisposeFutureProvider<int>.internal(
  unreadMessageCount,
  name: r'unreadMessageCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadMessageCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadMessageCountRef = AutoDisposeFutureProviderRef<int>;
String _$messagesNotifierHash() => r'fa4b08e2c9e3eab11e949a50483330b38e30b89a';

/// メッセージ送受信を管理するProvider
///
/// Copied from [MessagesNotifier].
@ProviderFor(MessagesNotifier)
final messagesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<MessagesNotifier, List<Message>>.internal(
  MessagesNotifier.new,
  name: r'messagesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messagesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessagesNotifier = AutoDisposeAsyncNotifier<List<Message>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
