import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultsDocumentsSignedProvider = StateProvider <Map<String, dynamic>> ( (ref) {
  return {
    'total': 0,
    'success': 0,
    'error': ""
  };
} );