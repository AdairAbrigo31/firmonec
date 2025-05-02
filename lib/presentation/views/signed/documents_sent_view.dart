import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsSentView extends ConsumerStatefulWidget {
  const DocumentsSentView({super.key});

  @override
  ConsumerState<DocumentsSentView> createState() {
    return DocumentsSentViewState();
  }
}

class DocumentsSentViewState extends ConsumerState<DocumentsSentView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Documentos Enviados"),
    );
  }
}
