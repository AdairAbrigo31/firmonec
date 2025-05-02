class DocumentNotSentDto {
  final String id;

  const DocumentNotSentDto({
    required this.id,
  });

  factory DocumentNotSentDto.fromJson(Map<String, dynamic> json) {
    return DocumentNotSentDto(
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
    return 'DOcumento no enviado(id: $id';
  }
}
