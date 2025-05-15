import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/utils/to_string_helper/base_impl.dart';

class Major with ToStringHelper {
  final Identified id;

  /// The name of the major.
  final String name;

  final String mongoObjectId;

  /// Create a new [Major].
  Major({required this.id, required this.name, required this.mongoObjectId});
}

class MajorCategory with ToStringHelper {
  final Identified id;
  final String name;
  MajorCategory({required this.id, required this.name});
}
