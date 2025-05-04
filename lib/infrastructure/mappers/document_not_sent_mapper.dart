import 'package:tesis_firmonec/infrastructure/dto/document_not_sent_dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class DocumentNotSentMapper {
  static DocumentNotSent fromDto(DocumentNotSentDto dto) {
    return DocumentNotSent(
      id: dto.id,
      para: dto.para,
      asunto: dto.asunto,
      fechaDocumento: dto.datFechaDocumento,
      categoria: dto.categoria,
    );
  }

  static List<DocumentNotSent> fromDtoList(List<DocumentNotSentDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }
}
