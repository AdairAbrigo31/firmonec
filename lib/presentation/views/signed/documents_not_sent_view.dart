import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsNotSentView extends ConsumerStatefulWidget {
  const DocumentsNotSentView({super.key});

  @override
  ConsumerState<DocumentsNotSentView> createState() {
    return DocumentsNotSentViewState();
  }
}

class DocumentsNotSentViewState extends ConsumerState<DocumentsNotSentView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Documentos No Enviados"),
    );
  }
}
