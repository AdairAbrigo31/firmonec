
class CredentialQuipux {
  final String email;
  final String password;
  final int type; // 'ESPOL' o 'ciudadano'
  final DateTime lastAccessed;

  CredentialQuipux({
    required this.email,
    required this.password,
    required this.type,
    required this.lastAccessed,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'type': type,
    'lastAccessed': lastAccessed.toIso8601String(),
  };

  factory CredentialQuipux.fromJson(Map<String, dynamic> json) {
    return CredentialQuipux(
      email: json['email'],
      password: json['password'],
      type: json['type'],
      lastAccessed: DateTime.parse(json['lastAccessed']),
    );
  }
}