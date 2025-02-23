import 'package:tesis_firmonec/presentation/models/models.dart';

class ReportSigned {
  final int error;
  final int success;
  final List<ResponseSignDocument> documentsSigned;

  ReportSigned({
    required this.error,
    required this.success,
    required this.documentsSigned
  });
}