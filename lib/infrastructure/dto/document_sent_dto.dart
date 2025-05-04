class DocumentSentDto {
  final String id;
  final String para;
  final String asunto;
  final String datFechaDocumento;
  final String categoria;
  final String? rutaDocumento;

  const DocumentSentDto(
      {required this.id,
      required this.para,
      required this.asunto,
      required this.datFechaDocumento,
      required this.categoria,
      this.rutaDocumento});

  factory DocumentSentDto.fromJson(Map<String, dynamic> json) {
    return DocumentSentDto(
      id: json['id'] ?? '',
      para: json['para'] ?? '',
      asunto: json['asunto'] ?? '',
      datFechaDocumento: json['DAT_Fecha_Documento'] ?? '',
      categoria: json['Categoría'] ?? '',
      rutaDocumento: json['ruta_documento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'para': para,
      'asunto': asunto,
      'DAT_Fecha_Documento': datFechaDocumento,
      'Categoría': categoria,
      'rutaDocumento': rutaDocumento,
    };
  }

  @override
  String toString() {
    return 'Documento enviado(id: $id para: $para, asunto: $asunto, fecha: $datFechaDocumento, categoria: $categoria)';
  }
}
