import 'package:wrapper/src/models/identified_entity/identified_entity.dart';
import 'package:wrapper/wrapper.dart';

class Major extends IdentifiedEntity<School> {
  /// The name of the major.
  final String name;

  final String mongoObjectId;

  /// Create a new [Major].
  Major({required super.id, required this.name, required this.mongoObjectId});

  @override
  Future<School> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<School> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}

class MajorCategory extends IdentifiedEntity<School> {
  final String name;
  MajorCategory({required super.id, required this.name});

  @override
  Future<School> fetch() {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<School> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
