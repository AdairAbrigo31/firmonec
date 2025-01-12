
class CertificateEntity {
  final String id;          // Identificador único
  final String name;        // Nombre del certificado
  final String filePath;    // Ruta del archivo
  final String password;    // Contraseña encriptada
  final DateTime createdAt; // Fecha de registro
  final DateTime? lastUsed; // Última vez que se usó
  final String alias;       // Alias o nombre común del certificado
  final String emailOwner;   // Nombre del propietario del certificado

  CertificateEntity({
    required this.id,
    required this.name,
    required this.filePath,
    required this.password,
    required this.createdAt,
    this.lastUsed,
    required this.alias,
    required this.emailOwner,
  });

  // Convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'filePath': filePath,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'lastUsed': lastUsed?.toIso8601String(),
      'alias': alias,
      'emailOwner': emailOwner,
    };
  }

  // Crear desde Map
  factory CertificateEntity.fromMap(Map<String, dynamic> map) {
    return CertificateEntity(
      id: map['id'],
      name: map['name'],
      filePath: map['filePath'],
      password: map['password'],
      createdAt: DateTime.parse(map['createdAt']),
      lastUsed: map['lastUsed'] != null ? DateTime.parse(map['lastUsed']) : null,
      alias: map['alias'],
      emailOwner: map['emailOwner'],
    );
  }
}