class AuthenticatedUser {
  final String token;
  final String type;
  final String refreshToken;
  final num id;
  final String username;
  final String email;
  final String role;
  final List<dynamic> permissions;
  final List<dynamic> companyPageIds;
  final String accountStatus;

  AuthenticatedUser({
    required this.token,
    required this.type,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.permissions,
    required this.companyPageIds,
    required this.accountStatus,
  });
}
