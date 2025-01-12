abstract class DocumentEntity {
  final String asunto;
  final String tipoDocumento;
  final String? rutaDocumento;

  const DocumentEntity({
    required this.asunto,
    required this.tipoDocumento,
    this.rutaDocumento,
  });
}
