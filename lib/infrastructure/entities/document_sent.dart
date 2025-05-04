class DocumentSent {
  final String id;
  final String para;
  final String asunto;
  final String fechaDocumento;
  final String? rutaDocumento;
  final String? categoria;

  DocumentSent(
      {required this.id,
      required this.para,
      required this.asunto,
      required this.fechaDocumento,
      this.rutaDocumento,
      this.categoria});

  @override
  String toString() {
    return 'Documento enviado(id: $id para: $para, asunto: $asunto, fecha: $fechaDocumento, categoria: $categoria)';
  }
}
