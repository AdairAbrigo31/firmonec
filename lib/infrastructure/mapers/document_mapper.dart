import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class DocumentMapper {
  static DocumentoPorElaborarEntity fromDto(DocumentPorElaborarDto dto) {
    return DocumentoPorElaborarEntity(
      id: dto.id,
      de: dto.de,
      para: dto.para,
      asunto: dto.asunto,
      fechaDocumento: dto.datFechaDocumento,
      numeroRadicado: dto.hidRadiNumeRadi,  // Corregido
      numeroDocumento: dto.numeroDocumento,
      numeroReferencia: dto.noReferencia,
      tipoDocumento: dto.tipoDocumento,
      categoria: dto.categoria,
      leido: dto.hidRadiLeido,  // Corregido
      contenido: dto.contenido,  // Nuevo
      rutaDocumento: dto.rutaDocumento,  // Nuevo
      base64: dto.base64,  // Nuevo
    );
  }

  // Método para mapear una lista de DTOs
  static List<DocumentoPorElaborarEntity> fromDtoList(List<DocumentPorElaborarDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }

  // Convertir de Entity a DTO
  static DocumentPorElaborarDto toDto(DocumentoPorElaborarEntity entity) {
    return DocumentPorElaborarDto(
      id: entity.id,
      de: entity.de,
      para: entity.para,
      asunto: entity.asunto,
      datFechaDocumento: entity.fechaDocumento,
      hidRadiNumeRadi: entity.numeroRadicado,  // Corregido
      numeroDocumento: entity.numeroDocumento,
      noReferencia: entity.numeroReferencia,
      tipoDocumento: entity.tipoDocumento,
      categoria: entity.categoria,
      hidRadiLeido: entity.leido,  // Corregido
      contenido: entity.contenido,  // Nuevo
      rutaDocumento: entity.rutaDocumento,  // Nuevo
      base64: entity.base64 ?? '',  // Nuevo
    );
  }
}