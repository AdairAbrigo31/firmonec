class DocumentNotSentDto {
  final String id;
  final String para;
  final String asunto;
  final String datFechaDocumento;
  final String categoria;
  final String? rutaDocumento;

  const DocumentNotSentDto(
      {required this.id,
      required this.para,
      required this.asunto,
      required this.datFechaDocumento,
      required this.categoria,
      this.rutaDocumento});

  factory DocumentNotSentDto.fromJson(Map<String, dynamic> json) {
    return DocumentNotSentDto(
      id: json['id'] ?? '',
      para: json['para'] ?? '',
      asunto: json['asunto'] ?? '',
      datFechaDocumento: json['DAT_Fecha_Documento'] ?? '',
      rutaDocumento: json['ruta_documento'],
      categoria: json['Categoría'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'para': para,
      'asunto': asunto,
      'DAT_Fecha_Documento': datFechaDocumento,
      'rutaDocumento': rutaDocumento,
      'Categoría': categoria,
    };
  }

  @override
  String toString() {
    return 'Documento NOO Nenviado(id: $id para: $para, asunto: $asunto, fecha: $datFechaDocumento, categoria: $categoria)';
  }
}
