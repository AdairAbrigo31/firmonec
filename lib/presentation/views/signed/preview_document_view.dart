
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviewDocumentView extends ConsumerWidget {
  const PreviewDocumentView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Center(
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
              ),
              TextButton(
                  onPressed: (){},
                  child: Text("Firmar")
              )
            ],
          ),
        )
    );
  }


}