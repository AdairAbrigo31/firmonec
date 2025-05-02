
// Mapper
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';

class RolMapper {
  static RolEntity fromDto(RolDto dto) {
    return RolEntity(
      codusuario: dto.codusuario,
      nombre: dto.nombre,
      instCodi: dto.instCodi,
      instEstado: dto.instEstado,
      institucion: dto.institucion,
      usuaCargoCabecera: dto.usuaCargoCabecera,
      usuaTitulo: dto.usuaTitulo,
      usuaEstado: dto.usuaEstado,
      cargo: dto.cargo,
      email: dto.email,
      dependenciaCod: dto.dependenciaCod,
      identificacion: dto.identificacion,
      dependencia: dto.dependencia,
      dependenciaSigla: dto.dependenciaSigla,
      instNombre: dto.instNombre,
    );
  }

  // Método para mapear una lista de DTOs
  static List<RolEntity> fromDtoList(List<RolDto> dtos) {
    return dtos.map((dto) => fromDto(dto)).toList();
  }
}