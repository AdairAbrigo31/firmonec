class DocumentNotSent {
  final String id;
  final String para;
  final String asunto;
  final String datFechaDocumento;

  DocumentNotSent({
    required this.id,
    required this.para,
    required this.asunto,
    required this.datFechaDocumento,
  });

  @override
  String toString() {
    return 'Documento NOO enviado(id: $id para: $para, asunto: $asunto, fecha: $datFechaDocumento)';
  }
}
