
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RolesDocumentsQuipuxView extends ConsumerStatefulWidget {
  const RolesDocumentsQuipuxView({super.key});

  @override
  ConsumerState<RolesDocumentsQuipuxView> createState() => RolesDocumentsQuipuxViewState();

}

class RolesDocumentsQuipuxViewState extends ConsumerState<RolesDocumentsQuipuxView>{

  @override
  Widget build(BuildContext context) {


    return const SafeArea(
      child: Text("Acordeones con documentos"),
    );
  }

}