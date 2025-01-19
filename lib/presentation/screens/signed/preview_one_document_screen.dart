
import 'package:flutter/material.dart';
import 'package:tesis_firmonec/presentation/views/signed/signed.dart';

class PreviewOneDocumentScreen extends StatelessWidget {
  const PreviewOneDocumentScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PreviewOneDocumentView(),
    );
  }


}