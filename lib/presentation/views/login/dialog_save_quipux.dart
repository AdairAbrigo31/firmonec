

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/persistence/credentials_quipux_provider.dart';

import 'package:tesis_firmonec/presentation/providers/providers.dart';
import 'package:tesis_firmonec/presentation/screens/signed/roles_documents_quipux_screen.dart';

class DialogSaveQuipux extends ConsumerWidget {
  const DialogSaveQuipux({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stateLogin = ref.watch(loginQuipuxFormProvider);
    final notifierCredential = ref.read(credentialsQuipuxProvider.notifier);

    return Dialog(
        child: Center(
          child: Column(
            children: [
              const Text("¿Deseas guardar esta cuenta de quipux?"),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        context.goNamed('roles_documents_quipux');
                      },
                      child: const Text("No guardar")),
                  ElevatedButton(
                      onPressed: () {
                        final credential = CredentialQuipux(
                            email: stateLogin.email,
                            password: stateLogin.password,
                            type: stateLogin.type,
                            lastAccessed: DateTime.now()
                        );
                        notifierCredential.saveCredential(credential);
                        context.goNamed('roles_documents_quipux');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RolesDocumentsQuipuxScreen()));
                        },

                      child: const Text("Guardar")),
                ],
              )
            ],
          ),
        )
    );
  }


}