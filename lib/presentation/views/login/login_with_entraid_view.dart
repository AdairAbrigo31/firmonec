
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';
import 'package:tesis_firmonec/presentation/controllers/get_information_user_controller.dart';

class LoginWithEntraIDView extends ConsumerWidget {
  const LoginWithEntraIDView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: TextButton(
            onPressed: () async {

              //await GetInformationUserController.executeActionsWithouToken(ref: ref);

              router.pushNamed('login_quipux');
            },
            
            child: Text("Iniciar sesión con MIcrosoft"))
    );
  }

}