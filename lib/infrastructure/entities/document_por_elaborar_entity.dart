import '../../domain/entities/document_entity.dart';

class DocumentoPorElaborarEntity extends DocumentEntity {
  final String id;
  final String de;
  final String para;
  final String fechaDocumento;
  final String numeroRadicado;
  final String numeroDocumento;
  final String numeroReferencia;
  final String categoria;
  final String leido;
  final String contenido;
  final String rutaDocumento;
  final String? base64;

  DocumentoPorElaborarEntity({
    required this.id,
    required this.de,
    required this.para,
    required super.asunto,
    required this.fechaDocumento,
    required this.numeroRadicado,
    required this.numeroDocumento,
    required this.numeroReferencia,
    required super.tipoDocumento,
    required this.categoria,
    required this.leido,
    required this.contenido,
    required this.rutaDocumento,
    this.base64,
  });

  // Constructor de copia
  DocumentoPorElaborarEntity copyWith({
    String? id,
    String? de,
    String? para,
    String? asunto,
    String? fechaDocumento,
    String? numeroRadicado,
    String? numeroDocumento,
    String? numeroReferencia,
    String? tipoDocumento,
    String? categoria,
    String? leido,
    String? contenido,
    String? rutaDocumento,
    String? base64,
  }) {
    return DocumentoPorElaborarEntity(
      id: id ?? this.id,
      de: de ?? this.de,
      para: para ?? this.para,
      asunto: asunto ?? this.asunto,
      fechaDocumento: fechaDocumento ?? this.fechaDocumento,
      numeroRadicado: numeroRadicado ?? this.numeroRadicado,
      numeroDocumento: numeroDocumento ?? this.numeroDocumento,
      numeroReferencia: numeroReferencia ?? this.numeroReferencia,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      categoria: categoria ?? this.categoria,
      leido: leido ?? this.leido,
      contenido: contenido ?? this.contenido,
      rutaDocumento: rutaDocumento ?? this.rutaDocumento,
      base64: base64 ?? this.base64
    );
  }

  @override
  String toString() {
    return 'DocumentoPorElaborarEntity(id: $id, de: $de, asunto: $asunto, numeroDocumento: $numeroDocumento)';
  }
}