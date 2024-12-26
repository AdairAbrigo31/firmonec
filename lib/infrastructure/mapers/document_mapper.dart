
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class DocumentMapper {
  static DocumentoPorElaborarEntity fromDto(DocumentDto dto) {
    return DocumentoPorElaborarEntity(
      id: dto.id,
      de: dto.de,
      para: dto.para,
      asunto: dto.asunto,
      fechaDocumento: dto.datFechaDocumento,
      numeroRadicado: dto.hioRadiNumeRadi,
      numeroDocumento: dto.numeroDocumento,
      numeroReferencia: dto.noReferencia,
      tipoDocumento: dto.tipoDocumento,
      categoria: dto.categoria,
      leido: dto.hioRadiLeido,
    );
  }

  // Método para mapear una lista de DTOs
  static List<DocumentoPorElaborarEntity> fromDtoList(List<DocumentDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }

  // Opcionalmente, podemos agregar un método para convertir de Entity a DTO
  static DocumentDto toDto(DocumentoPorElaborarEntity entity) {
    return DocumentDto(
      id: entity.id,
      de: entity.de,
      para: entity.para,
      asunto: entity.asunto,
      datFechaDocumento: entity.fechaDocumento,
      hioRadiNumeRadi: entity.numeroRadicado,
      numeroDocumento: entity.numeroDocumento,
      noReferencia: entity.numeroReferencia,
      tipoDocumento: entity.tipoDocumento,
      categoria: entity.categoria,
      hioRadiLeido: entity.leido,
    );
  }
}