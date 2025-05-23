// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messagesHash() => r'ea42dcf319dc2e0f3ccef4a9af6bf861eac4c495';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Messages extends BuildlessAsyncNotifier<List<Message>?> {
  late final Identified conversationId;

  FutureOr<List<Message>?> build(Identified conversationId);
}

/// See also [Messages].
@ProviderFor(Messages)
const messagesProvider = MessagesFamily();

/// See also [Messages].
class MessagesFamily extends Family<AsyncValue<List<Message>?>> {
  /// See also [Messages].
  const MessagesFamily();

  /// See also [Messages].
  MessagesProvider call(Identified conversationId) {
    return MessagesProvider(conversationId);
  }

  @override
  MessagesProvider getProviderOverride(covariant MessagesProvider provider) {
    return call(provider.conversationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesProvider';
}

/// See also [Messages].
class MessagesProvider
    extends AsyncNotifierProviderImpl<Messages, List<Message>?> {
  /// See also [Messages].
  MessagesProvider(Identified conversationId)
    : this._internal(
        () => Messages()..conversationId = conversationId,
        from: messagesProvider,
        name: r'messagesProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$messagesHash,
        dependencies: MessagesFamily._dependencies,
        allTransitiveDependencies: MessagesFamily._allTransitiveDependencies,
        conversationId: conversationId,
      );

  MessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final Identified conversationId;

  @override
  FutureOr<List<Message>?> runNotifierBuild(covariant Messages notifier) {
    return notifier.build(conversationId);
  }

  @override
  Override overrideWith(Messages Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessagesProvider._internal(
        () => create()..conversationId = conversationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<Messages, List<Message>?> createElement() {
    return _MessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesProvider && other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessagesRef on AsyncNotifierProviderRef<List<Message>?> {
  /// The parameter `conversationId` of this provider.
  Identified get conversationId;
}

class _MessagesProviderElement
    extends AsyncNotifierProviderElement<Messages, List<Message>?>
    with MessagesRef {
  _MessagesProviderElement(super.provider);

  @override
  Identified get conversationId => (origin as MessagesProvider).conversationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
