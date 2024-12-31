class UserEntity {
  final String displayName;
  final String givenName;
  final String surname;
  final String mail;
  final String userPrincipalName;
  final String? jobTitle;
  final String? officeLocation;
  final String? preferredLanguage;
  final String? mobilePhone;
  final String? numberCI;
  final int? typeQuipux;

  const UserEntity({
    required this.displayName,
    required this.givenName,
    required this.surname,
    required this.mail,
    required this.userPrincipalName,
    this.jobTitle,
    this.officeLocation,
    this.preferredLanguage,
    this.mobilePhone,
    this.numberCI,
    this.typeQuipux
  });

  // Crear instancia desde JSON
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      displayName: json['displayName'] ?? '',
      givenName: json['givenName'] ?? '',
      surname: json['surname'] ?? '',
      mail: json['mail'] ?? '',
      userPrincipalName: json['userPrincipalName'] ?? '',
      jobTitle: json['jobTitle'],
      officeLocation: json['officeLocation'],
      preferredLanguage: json['preferredLanguage'],
      mobilePhone: json['mobilePhone'],
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'givenName': givenName,
      'surname': surname,
      'mail': mail,
      'userPrincipalName': userPrincipalName,
      'jobTitle': jobTitle,
      'officeLocation': officeLocation,
      'preferredLanguage': preferredLanguage,
      'mobilePhone': mobilePhone,
    };
  }

  // Método copyWith para crear una nueva instancia con algunos campos modificados
  UserEntity copyWith({
    String? displayName,
    String? givenName,
    String? surname,
    String? mail,
    String? userPrincipalName,
    String? jobTitle,
    String? officeLocation,
    String? preferredLanguage,
    String? mobilePhone,
    List<String>? businessPhones,
    String? numberCI,
    int? typeQuipux
  }) {
    return UserEntity(
      displayName: displayName ?? this.displayName,
      givenName: givenName ?? this.givenName,
      surname: surname ?? this.surname,
      mail: mail ?? this.mail,
      userPrincipalName: userPrincipalName ?? this.userPrincipalName,
      jobTitle: jobTitle ?? this.jobTitle,
      officeLocation: officeLocation ?? this.officeLocation,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      numberCI: numberCI ?? this.numberCI,
      typeQuipux: typeQuipux ?? this.typeQuipux
    );
  }

  @override
  String toString() {
    return 'UserEntity(displayName: $displayName, givenName: $givenName, '
        'surname: $surname, mail: $mail, userPrincipalName: $userPrincipalName, '
        'jobTitle: $jobTitle, officeLocation: $officeLocation, '
        'preferredLanguage: $preferredLanguage, mobilePhone: $mobilePhone, numberCI: $numberCI)';
  }
}