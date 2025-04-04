class DocumentPorElaborarDto {
  final String id;
  final String de;
  final String para;
  final String asunto;
  final String datFechaDocumento;
  final String hidRadiNumeRadi; // Corregido el nombre
  final String numeroDocumento;
  final String noReferencia;
  final String tipoDocumento;
  final String categoria;
  final String hidRadiLeido; // Corregido el nombre
  final String contenido; // Nuevo
  final String base64; // Nuevo (para cuando se necesite el PDF)
  final String? rutaDocumento;

  const DocumentPorElaborarDto({
    required this.id,
    required this.de,
    required this.para,
    required this.asunto,
    required this.datFechaDocumento,
    required this.hidRadiNumeRadi,
    required this.numeroDocumento,
    required this.noReferencia,
    required this.tipoDocumento,
    required this.categoria,
    required this.hidRadiLeido,
    required this.contenido,
    this.base64 = '', // Opcional, ya que podría no venir en el JSON inicial
    this.rutaDocumento,
  });

  factory DocumentPorElaborarDto.fromJson(Map<String, dynamic> json) {
    return DocumentPorElaborarDto(
      id: json['id'] ?? '',
      de: json['de'] ?? '',
      para: json['para'] ?? '',
      asunto: json['asunto'] ?? '',
      datFechaDocumento: json['DAT_Fecha_Documento'] ?? '',
      hidRadiNumeRadi:json['HID_RADI_NUME_RADI'] ?? '', // Corregido el nombre del campo
      numeroDocumento: json['Número_Documento'] ?? '',
      noReferencia: json['No_Referencia'] ?? '',
      tipoDocumento: json['Tipo_Documento'] ?? '',
      categoria: json['Categoría'] ?? '',
      hidRadiLeido: json['HID_RADI_LEIDO'] ?? '', // Corregido el nombre del campo
      contenido: json['contenido'] ?? '',
      base64: json['base64'] ?? '',
      rutaDocumento: json['ruta_documento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'de': de,
      'para': para,
      'asunto': asunto,
      'DAT_Fecha_Documento': datFechaDocumento,
      'HID_RADI_NUME_RADI': hidRadiNumeRadi,
      'Número_Documento': numeroDocumento,
      'No_Referencia': noReferencia,
      'Tipo_Documento': tipoDocumento,
      'Categoría': categoria,
      'HID_RADI_LEIDO': hidRadiLeido,
      'contenido': contenido,
      'base64': base64,
      'rutaDocumento': rutaDocumento
    };
  }

  @override
  String toString() {
    return 'DocumentPorElaborarDto(id: $id, de: $de, asunto: $asunto, numeroDocumento: $numeroDocumento)';
  }
}
