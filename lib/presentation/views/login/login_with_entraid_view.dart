import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/controllers/get_information_user_controller.dart';
import 'package:tesis_firmonec/presentation/screens/signed/roles_documents_quipux_screen.dart';

class LoginWithEntraIDView extends ConsumerWidget {
  const LoginWithEntraIDView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(

        child: FutureBuilder(

            future: GetInformationUserController.getDataQuipux(ref, context),
            
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString().contains("networkError") 
                    ? "Sin conexión a internet" 
                    : "Error en la autenticación"
                );
              }

              return  const RolesDocumentsQuipuxScreen();

            }
        )
    );

  }
}
