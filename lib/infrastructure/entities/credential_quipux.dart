
class CredentialQuipux {
  final String email;
  final String accessToken;
  final int type; // 'ESPOL' o 'ciudadano'
  final DateTime lastAccessed;

  CredentialQuipux({
    required this.email,
    required this.accessToken,
    required this.type,
    required this.lastAccessed,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'accessToken': accessToken,
    'type': type,
    'lastAccessed': lastAccessed.toIso8601String(),
  };

  factory CredentialQuipux.fromJson(Map<String, dynamic> json) {
    return CredentialQuipux(
      email: json['email'],
      accessToken: json['accessToken'],
      type: json['type'],
      lastAccessed: DateTime.parse(json['lastAccessed']),
    );
  }
}