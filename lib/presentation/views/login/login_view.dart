
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/presentation/providers/persistence/credentials_quipux_provider.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => LoginViewState();

}

class LoginViewState extends ConsumerState<LoginView>{

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final readStateFormLogin = ref.read(loginFormProvider.notifier);

    return SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text("Input de correo"),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    emailController.text = value;
                    readStateFormLogin.updateEmail((value));
                  },
                ),
                const Text("Input de contraseña"),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    passwordController.text = value;
                    readStateFormLogin.updatePassword(value);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    ref.read(credentialsQuipuxProvider.notifier).loadCredentials();
                    await readStateFormLogin.login();
                  },
                  child: const Text("Iniciar sesión"),
                )
                ],
            )
          ),
        )
    );
  }

}