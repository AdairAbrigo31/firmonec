import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificatesForSignView extends ConsumerStatefulWidget {
  const CertificatesForSignView({super.key});


  @override
  ConsumerState<CertificatesForSignView> createState() => CertificatesForSignViewState();


}

class CertificatesForSignViewState extends ConsumerState<CertificatesForSignView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("Estos son los certificados que usted ha decidido guardar"),
              ListView.builder(itemCount: 2, itemBuilder: (_, index) {
                return Text("Este es ek indice $index");
              },)
            ],
          ),
        )
    );
  }

}