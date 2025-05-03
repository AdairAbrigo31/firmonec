import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class DocumentSentMapper {
  static DocumentSent fromDto(DocumentSentDto dto) {
    return DocumentSent(
        id: dto.id,
        para: dto.para,
        asunto: dto.asunto,
        datFechaDocumento: dto.datFechaDocumento);
  }

  static List<DocumentSent> fromDtoList(List<DocumentSentDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }
}
