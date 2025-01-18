abstract class DocumentEntity {
  final String id;
  final String asunto;
  final String tipoDocumento;
  final String? rutaDocumento;

  const DocumentEntity({
    required this.id,
    required this.asunto,
    required this.tipoDocumento,
    this.rutaDocumento,
  });
}
