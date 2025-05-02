import 'package:tesis_firmonec/infrastructure/dto/document_not_sent_dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class DocumentNotSentMapper {
  static DocumentNotSent fromDto(DocumentNotSentDto dto) {
    return DocumentNotSent(
      id: dto.id,
    );
  }

  static List<DocumentNotSent> fromDtoList(List<DocumentNotSentDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }
}
