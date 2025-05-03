class DocumentSent {
  final String id;
  final String para;
  final String asunto;
  final String datFechaDocumento;

  DocumentSent({
    required this.id,
    required this.para,
    required this.asunto,
    required this.datFechaDocumento,
  });

  @override
  String toString() {
    return 'Documento enviado(id: $id para: $para, asunto: $asunto, fecha: $datFechaDocumento)';
  }
}
