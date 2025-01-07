

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class PreviewDocumentView extends ConsumerStatefulWidget {
  const PreviewDocumentView({super.key});


  @override
  ConsumerState<PreviewDocumentView> createState() => PreviewDocumentViewState();


}

class PreviewDocumentViewState extends ConsumerState<PreviewDocumentView> {

  @override
  Widget build(BuildContext context) {

    final oneDocumentSelectedState = ref.watch(oneDocumentSelectedPreviewProvider);

    return const SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Previsualización del documento seleccionado")
            ],
          ),
        )
    );
  }

}