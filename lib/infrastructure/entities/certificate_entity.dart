
class CertificateEntity {
  final String id;          
  final String name;       
  final String filePath;    
  final String? password;    
  final DateTime createdAt; 
  final DateTime? lastUsed; 
  final String alias;       
  final String emailOwner;  
  final String base64;

  CertificateEntity({
    required this.id,
    required this.name,
    required this.filePath,
    this.password,
    required this.createdAt,
    this.lastUsed,
    required this.alias,
    required this.emailOwner,
    required this.base64
  });


  CertificateEntity copyWith({
    String? password,
    DateTime? lastUsed,
    }) 
  {
    return CertificateEntity(
      id: id,
      name: name,
      filePath: filePath,
      password: password ?? this.password,
      createdAt: createdAt,
      lastUsed: lastUsed ?? this.lastUsed ,
      alias: alias,
      emailOwner: emailOwner,
      base64: base64,
    );
  }

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
      'base64': base64
    };
  }

  // Crear desde Map
  factory CertificateEntity.fromMap(Map<String, dynamic> map) {
    return CertificateEntity(
      id: map['id'],
      name: map['name'],
      filePath: map['filePath'],
      password: map['password'] ?? "",
      createdAt: DateTime.parse(map['createdAt']),
      lastUsed: map['lastUsed'] != null ? DateTime.parse(map['lastUsed']) : null,
      alias: map['alias'],
      emailOwner: map['emailOwner'],
      base64: map['base64']
    );
  }
}