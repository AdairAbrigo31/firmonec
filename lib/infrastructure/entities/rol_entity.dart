
import 'package:tesis_firmonec/infrastructure/dto/dto.dart';

class RolEntity {
  final String codusuario;
  final String nombre;
  final String instCodi;
  final String instEstado;
  final String? institucion;
  final String usuaCargoCabecera;
  final String usuaTitulo;
  final String usuaEstado;
  final String cargo;
  final String email;
  final String dependenciaCod;
  final String identificacion;
  final String dependencia;
  final String dependenciaSigla;
  final String instNombre;

  const RolEntity({
    required this.codusuario,
    required this.nombre,
    required this.instCodi,
    required this.instEstado,
    this.institucion,
    required this.usuaCargoCabecera,
    required this.usuaTitulo,
    required this.usuaEstado,
    required this.cargo,
    required this.email,
    required this.dependenciaCod,
    required this.identificacion,
    required this.dependencia,
    required this.dependenciaSigla,
    required this.instNombre,
  });

  // Constructor de copia
  RolEntity copyWith({
    String? codusuario,
    String? nombre,
    String? instCodi,
    String? instEstado,
    String? institucion,
    String? usuaCargoCabecera,
    String? usuaTitulo,
    String? usuaEstado,
    String? cargo,
    String? email,
    String? dependenciaCod,
    String? identificacion,
    String? dependencia,
    String? dependenciaSigla,
    String? instNombre,
  }) {
    return RolEntity(
      codusuario: codusuario ?? this.codusuario,
      nombre: nombre ?? this.nombre,
      instCodi: instCodi ?? this.instCodi,
      instEstado: instEstado ?? this.instEstado,
      institucion: institucion ?? this.institucion,
      usuaCargoCabecera: usuaCargoCabecera ?? this.usuaCargoCabecera,
      usuaTitulo: usuaTitulo ?? this.usuaTitulo,
      usuaEstado: usuaEstado ?? this.usuaEstado,
      cargo: cargo ?? this.cargo,
      email: email ?? this.email,
      dependenciaCod: dependenciaCod ?? this.dependenciaCod,
      identificacion: identificacion ?? this.identificacion,
      dependencia: dependencia ?? this.dependencia,
      dependenciaSigla: dependenciaSigla ?? this.dependenciaSigla,
      instNombre: instNombre ?? this.instNombre,
    );
  }

  @override
  String toString() {
    return 'Rol(codusuario: $codusuario, nombre: $nombre, cargo: $cargo, dependencia: $dependencia)';
  }
}
