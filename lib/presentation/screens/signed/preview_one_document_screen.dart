
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class PreviewOneDocumentScreen extends StatelessWidget {
  const PreviewOneDocumentScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      appBar: AppBarFirmonec(title: "Previsuzalización", showBackButton: true),

      body: PreviewOneDocumentView(),
      
    );
  }


}