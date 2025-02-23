
class ResponseSignDocument {
  final bool success;
  final String documentId;
  final String? error;

  ResponseSignDocument({
    required this.success,
    required this.documentId,
    this.error,
  });
}