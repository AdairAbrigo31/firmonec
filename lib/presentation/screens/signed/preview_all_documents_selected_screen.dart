
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/preview_all_documents_selected_view.dart';

class PreviewAllDocumentsSelectedScreen extends StatelessWidget {
  const PreviewAllDocumentsSelectedScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PreviewAllDocumentsSelectedView(),
    );
  }


}