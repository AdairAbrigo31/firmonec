

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviewDocumentView extends ConsumerWidget {
  const PreviewDocumentView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Encabezado"),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Text("Preview del PDF"),
                ),
              )
          )
        ],
      ),
    );
  }


}