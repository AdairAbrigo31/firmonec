
import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configuration/microsoftID.dart';


class RolesDocumentsQuipuxView extends ConsumerStatefulWidget {
  const RolesDocumentsQuipuxView({super.key});

  @override
  ConsumerState<RolesDocumentsQuipuxView> createState() => RolesDocumentsQuipuxViewState();

}

class RolesDocumentsQuipuxViewState extends ConsumerState<RolesDocumentsQuipuxView>{

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Column(
        children: [
          Text("Acordeones de documentos"),
          TextButton(
              onPressed: (){
                final oadd = AadOAuth(MicrosoftID.config);
                oadd.logout();
              },
              child: Text("Cerrar sesión"))
        ],
      ),
    );
  }

}