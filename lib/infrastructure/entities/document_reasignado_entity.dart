
import 'package:tesis_firmonec/domain/entities/document_entity.dart';

class DocumentReasignadoEntity extends DocumentEntity {
  final String reasignadoPor;       // Usuario que reasignó el documento
  final String motivoReasignacion;  // Motivo por el que se reasignó
  final String fechaReasignacion;   // Fecha en que se realizó la reasignación

  DocumentReasignadoEntity({
    required super.id,
    required super.asunto,
    required super.tipoDocumento,
    required this.reasignadoPor,
    required this.motivoReasignacion,
    required this.fechaReasignacion,
  });

  DocumentReasignadoEntity copyWith({
    String? asunto,
    String? tipoDocumento,
    String? id,
    String? reasignadoPor,
    String? motivoReasignacion,
    String? fechaReasignacion,
  }) {
    return DocumentReasignadoEntity(
      id: id ?? this.id,
      asunto: asunto ?? this.asunto,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      reasignadoPor: reasignadoPor ?? this.reasignadoPor,
      motivoReasignacion: motivoReasignacion ?? this.motivoReasignacion,
      fechaReasignacion: fechaReasignacion ?? this.fechaReasignacion,
    );
  }

  @override
  String toString() {
    return 'DocumentReasignadoEntity(asunto: $asunto, reasignadoPor: $reasignadoPor, motivo: $motivoReasignacion)';
  }
}