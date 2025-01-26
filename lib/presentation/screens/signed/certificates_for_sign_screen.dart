
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class CertificatesForSignScreen extends StatelessWidget {
  const CertificatesForSignScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      appBar: AppBarFirmonec(title: "Certificados", showBackButton: true),

      body: CertificatesForSignView(),
      
    );
  }


}