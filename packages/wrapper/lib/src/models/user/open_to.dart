import 'package:wrapper/src/models/identified.dart';
import 'package:wrapper/src/models/job/category.dart';
import 'package:wrapper/src/models/job/location.dart';
import 'package:wrapper/src/utils/to_string_helper/mirrors_impl.dart';

class OpenTo with ToStringHelper {
  final Identified id;
  final String type;
  final String? mongoObjectId;
  final List<Location> locations;
  final List<JobCategory> jobCategories;
  final String internshipTimeFrame;
  final List<String> jobEnvironments;
  final DateTime? startDate;
  final List<String> jobTypes;
  OpenTo({
    required this.id,
    required this.type,
    required this.locations,
    required this.jobCategories,
    required this.internshipTimeFrame,
    required this.jobEnvironments,
    required this.jobTypes,
    this.mongoObjectId,
    this.startDate,
  });
}
