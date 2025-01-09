
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/configuration/configuration.dart';

class LoginWithEntraIDView extends ConsumerWidget {
  const LoginWithEntraIDView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: TextButton(
            onPressed: () async {
              router.pushNamed('login_quipux');
            },
            child: Text("Iniciar sesión con MIcrosoft"))
    );
  }

}