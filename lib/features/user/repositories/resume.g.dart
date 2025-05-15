// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userResumeHash() => r'1852c93ceba1a80f3269efaaf0c70afcd482c660';

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

abstract class _$UserResume
    extends BuildlessAutoDisposeAsyncNotifier<Uint8List?> {
  late final int userId;

  FutureOr<Uint8List?> build(int userId);
}

/// See also [UserResume].
@ProviderFor(UserResume)
const userResumeProvider = UserResumeFamily();

/// See also [UserResume].
class UserResumeFamily extends Family<AsyncValue<Uint8List?>> {
  /// See also [UserResume].
  const UserResumeFamily();

  /// See also [UserResume].
  UserResumeProvider call(int userId) {
    return UserResumeProvider(userId);
  }

  @override
  UserResumeProvider getProviderOverride(
    covariant UserResumeProvider provider,
  ) {
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
  String? get name => r'userResumeProvider';
}

/// See also [UserResume].
class UserResumeProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserResume, Uint8List?> {
  /// See also [UserResume].
  UserResumeProvider(int userId)
    : this._internal(
        () => UserResume()..userId = userId,
        from: userResumeProvider,
        name: r'userResumeProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$userResumeHash,
        dependencies: UserResumeFamily._dependencies,
        allTransitiveDependencies: UserResumeFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserResumeProvider._internal(
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
  FutureOr<Uint8List?> runNotifierBuild(covariant UserResume notifier) {
    return notifier.build(userId);
  }

  @override
  Override overrideWith(UserResume Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserResumeProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserResume, Uint8List?>
  createElement() {
    return _UserResumeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserResumeProvider && other.userId == userId;
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
mixin UserResumeRef on AutoDisposeAsyncNotifierProviderRef<Uint8List?> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserResumeProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserResume, Uint8List?>
    with UserResumeRef {
  _UserResumeProviderElement(super.provider);

  @override
  int get userId => (origin as UserResumeProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
