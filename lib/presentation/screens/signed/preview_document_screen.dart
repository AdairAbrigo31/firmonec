
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/certificates_for_sign_view.dart';

class PreviewDocumentScreen extends StatelessWidget {
  const PreviewDocumentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CertificatesForSignView(),
    );
  }


}