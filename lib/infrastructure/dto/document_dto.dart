class DocumentDto {
  final String id;
  final String de;
  final String para;
  final String asunto;
  final String datFechaDocumento;
  final String hioRadiNumeRadi;
  final String numeroDocumento;
  final String noReferencia;
  final String tipoDocumento;
  final String categoria;
  final String hioRadiLeido;

  const DocumentDto({
    required this.id,
    required this.de,
    required this.para,
    required this.asunto,
    required this.datFechaDocumento,
    required this.hioRadiNumeRadi,
    required this.numeroDocumento,
    required this.noReferencia,
    required this.tipoDocumento,
    required this.categoria,
    required this.hioRadiLeido,
  });

  factory DocumentDto.fromJson(Map<String, dynamic> json) {
    return DocumentDto(
      id: json['id'] ?? '',
      de: json['de'] ?? '',
      para: json['para'] ?? '',
      asunto: json['asunto'] ?? '',
      datFechaDocumento: json['DAT_Fecha_Documento'] ?? '',
      hioRadiNumeRadi: json['HIO_RADI_NUME_RADI'] ?? '',
      numeroDocumento: json['Número_Documento'] ?? '',
      noReferencia: json['No_Referencia'] ?? '',
      tipoDocumento: json['Tipo_Documento'] ?? '',
      categoria: json['Categoría'] ?? '',
      hioRadiLeido: json['HIO_RADI_LEIDO'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'de': de,
      'para': para,
      'asunto': asunto,
      'DAT_Fecha_Documento': datFechaDocumento,
      'HIO_RADI_NUME_RADI': hioRadiNumeRadi,
      'Número_Documento': numeroDocumento,
      'No_Referencia': noReferencia,
      'Tipo_Documento': tipoDocumento,
      'Categoría': categoria,
      'HIO_RADI_LEIDO': hioRadiLeido,
    };
  }

  @override
  String toString() {
    return 'DocumentDto(id: $id, de: $de, asunto: $asunto, numeroDocumento: $numeroDocumento)';
  }
}