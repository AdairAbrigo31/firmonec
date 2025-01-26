
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/views.dart';
import 'package:tesis_firmonec/presentation/widgets/widgets.dart';

class DocumentsSignedScreen extends StatelessWidget {

  const DocumentsSignedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      appBar: AppBarFirmonec(title: "Documentos firmados", showBackButton: false),
      
      body: DocumentsSignedView(),
    );
  }


}