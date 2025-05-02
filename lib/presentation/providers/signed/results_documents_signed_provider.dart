import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/models/report_signed.dart';

final resultsDocumentsSignedProvider = StateProvider<ReportSigned>((ref) {
  return ReportSigned(error: 0, success: 0, documentsSigned: []);
});
