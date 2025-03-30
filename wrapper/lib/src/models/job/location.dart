class Location {
  final int id;
  final String? locationName;
  final String locality;
  final String? subLocality;
  final String administrativeArea;
  final String? subAdministrativeArea;
  final String isoCountryCode;
  final String country;
  final double latitude;
  final double longitude;
  final double percentMatch;

  Location({
    required this.id,
    this.locationName,
    required this.locality,
    this.subLocality,
    required this.administrativeArea,
    this.subAdministrativeArea,
    required this.isoCountryCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.percentMatch,
  });
}
