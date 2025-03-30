// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$epicUserHash() => r'07a7ecd8e0fb13010969e6c9877c9aa1beff2a7e';

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

abstract class _$EpicUser extends BuildlessAutoDisposeAsyncNotifier<User?> {
  late final int userId;

  FutureOr<User?> build(int userId);
}

/// See also [EpicUser].
@ProviderFor(EpicUser)
const epicUserProvider = EpicUserFamily();

/// See also [EpicUser].
class EpicUserFamily extends Family<AsyncValue<User?>> {
  /// See also [EpicUser].
  const EpicUserFamily();

  /// See also [EpicUser].
  EpicUserProvider call(int userId) {
    return EpicUserProvider(userId);
  }

  @override
  EpicUserProvider getProviderOverride(covariant EpicUserProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'epicUserProvider';
}

/// See also [EpicUser].
class EpicUserProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EpicUser, User?> {
  /// See also [EpicUser].
  EpicUserProvider(int userId)
    : this._internal(
        () => EpicUser()..userId = userId,
        from: epicUserProvider,
        name: r'epicUserProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$epicUserHash,
        dependencies: EpicUserFamily._dependencies,
        allTransitiveDependencies: EpicUserFamily._allTransitiveDependencies,
        userId: userId,
      );

  EpicUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  FutureOr<User?> runNotifierBuild(covariant EpicUser notifier) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(EpicUser Function() create) {
    return ProviderOverride(
      origin: this,
      override: EpicUserProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EpicUser, User?> createElement() {
    return _EpicUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EpicUserProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EpicUserRef on AutoDisposeAsyncNotifierProviderRef<User?> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _EpicUserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EpicUser, User?>
    with EpicUserRef {
  _EpicUserProviderElement(super.provider);

  @override
  int get userId => (origin as EpicUserProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
