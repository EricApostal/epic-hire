import 'dart:async';

import 'package:wrapper/src/builders/builder.dart';
import 'package:wrapper/src/http/managers/manager.dart';
import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/utils/to_string_helper/base_impl.dart';

/// The base class for all entities in the API identified by a [Identified].
abstract class IdentifiedEntity<T extends IdentifiedEntity<T>>
    with ToStringHelper {
  /// The id of this entity.
  final Identified id;

  /// Create a new [IdentifiedEntity].
  /// @nodoc
  IdentifiedEntity({required this.id});

  /// If this entity exists in the manager's cache, return the cached instance. Otherwise, [fetch]
  /// this entity and return it.
  Future<T> get();

  /// Fetch this entity from the API.
  Future<T> fetch();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdentifiedEntity<T> && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String defaultToString() => '$T($id)';
}

/// The base class for all [IdentifiedEntity]'s that have a dedicated [ReadOnlyManager].
abstract class ManagedIdentifiedEntity<T extends ManagedIdentifiedEntity<T>>
    extends IdentifiedEntity<T> {
  /// The manager for this entity.
  ReadOnlyManager<T> get manager;

  /// Create a new [ManagedIdentifiedEntity];
  /// @nodoc
  ManagedIdentifiedEntity({required super.id});

  @override
  Future<T> get() => manager.get(id);

  @override
  Future<T> fetch() => manager.fetch(id);
}

/// The base class for all [IdentifiedEntity]'s that have a dedicated [Manager].
abstract class WritableIdentifiedEntity<T extends WritableIdentifiedEntity<T>>
    extends ManagedIdentifiedEntity<T> {
  @override
  Manager<T> get manager;

  /// Create a new [WritableIdentifiedEntity].
  /// @nodoc
  WritableIdentifiedEntity({required super.id});

  /// Update this entity using the provided builder and return the updated entity.
  Future<T> update(covariant UpdateBuilder<T> builder) =>
      manager.update(id, builder);

  /// Delete this entity.
  Future<void> delete() => manager.delete(id);
}
