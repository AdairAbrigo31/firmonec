class DocumentSentDto {
  final String id;

  const DocumentSentDto({
    required this.id,
  });

  factory DocumentSentDto.fromJson(Map<String, dynamic> json) {
    return DocumentSentDto(
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  @override
  String toString() {
    return 'Documento enviado(id: $id';
  }
}
