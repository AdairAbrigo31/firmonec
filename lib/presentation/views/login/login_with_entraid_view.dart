import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/controllers/get_information_user_controller.dart';
import 'package:tesis_firmonec/presentation/screens/signed/roles_documents_quipux_screen.dart';

class LoginWithEntraIDView extends ConsumerWidget {
  const LoginWithEntraIDView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(

        child: TextButton(

            onPressed: () {

              router.pushNamed("login_quipux");

            },

            child: const Text("Saltarse EntraID")
        )
    );

  }
}
