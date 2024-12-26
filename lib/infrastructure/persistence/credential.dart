class Credentials {
  final String userId;       // ID único del usuario en Microsoft
  final String displayName;  // Nombre para mostrar
  final String email;        // Email del usuario
  final String refreshToken; // Token para renovar autenticación
  final DateTime lastUsed;   // Última vez que se usó esta cuenta
  final DateTime tokenExpiration; // Fecha de expiración del refresh token

  // Constructor
  const Credentials({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.refreshToken,
    required this.lastUsed,
    required this.tokenExpiration,
  });

  // Método para crear desde JSON (útil para almacenamiento)
  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      userId: json['userId'],
      displayName: json['displayName'],
      email: json['email'],
      refreshToken: json['refreshToken'],
      lastUsed: DateTime.parse(json['lastUsed']),
      tokenExpiration: DateTime.parse(json['tokenExpiration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'refreshToken': refreshToken,
      'lastUsed': lastUsed.toIso8601String(),
      'tokenExpiration': tokenExpiration.toIso8601String(),
    };
  }

  bool isExpired() {
    return DateTime.now().isAfter(tokenExpiration);
  }

  Credentials copyWithUpdatedLastUsed() {
    return Credentials(
      userId: userId,
      displayName: displayName,
      email: email,
      refreshToken: refreshToken,
      lastUsed: DateTime.now(),
      tokenExpiration: tokenExpiration,
    );
  }
}